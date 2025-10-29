
## Puzzle: The Overloaded Server Detector

**The Scenario:** As a Site Reliability Engineer (SRE), you need to monitor the load balancer logs to proactively identify backend servers that might be overloaded. An overloaded server often exhibits higher response times compared to its peers under similar traffic conditions.

**Your Task:** Write a query to identify potentially overloaded servers based on 10-minute intervals. A server is considered potentially overloaded in a specific 10-minute window if:

1. It handled at least 10 requests during that window.
2. Its average `response_time_ms` during that window was higher than the *overall* average response time across *all* servers during that same window.

The final report should show the `window_start_time` (e.g., '10:00:00', '10:10:00'), the `server_id` identified as overloaded, the `server_request_count` in that window, the `server_avg_response_time` in that window, and the `overall_avg_response_time` across all servers for comparison.

| window_start_time   | server_id | server_request_count | server_avg_response_time | overall_avg_response_time |
| ------------------- | --------- | -------------------- | ------------------------ | ------------------------- |
| 2023-11-15 10:00:00 | srv-B     | 10                   | 307.00                   | 210.53                    |
| 2023-11-15 10:30:00 | srv-C     | 11                   | 273.64                   | 207.50                    |

### Tips for Approaching the Problem

1. **Define Time Windows:** The first step is to group the log entries into 10-minute intervals. You can achieve this by truncating the `request_timestamp` to the nearest 10-minute mark. One way is to calculate minutes from the start of the hour (`MINUTE(request_timestamp)`), divide by 10 (`FLOOR(MINUTE(...) / 10)`), and then combine this back with the hour and date.
2. **Calculate Window Aggregates:** You need two levels of aggregation: per-server within the window and overall for the window. Window functions are ideal here.
   * In a CTE, calculate the `COUNT(*)` and `AVG(response_time_ms)` for each `server_id` within each `window_start_time`. Use `PARTITION BY window_start_time, server_id`.
   * In the *same* CTE, also calculate the overall `AVG(response_time_ms)` for the entire window, ignoring the server. Use `PARTITION BY window_start_time` only.
3. **Apply Overload Logic:** Now you have all the necessary numbers calculated for each log entry. In your final `SELECT` statement (which can query from the CTE):
   * Use `DISTINCT` to get one row per identified overloaded server per window.
   * Filter using a `WHERE` clause:
     * `server_request_count >= 10`
     * `server_avg_response_time > overall_avg_response_time`

**Your Solution:**

```sql
WITH interval_windows AS (
	SELECT
		TIMESTAMP(
			CONCAT(
				CAST(DATE(request_timestamp) AS CHAR),
				' ',
				CAST(HOUR(request_timestamp) AS CHAR),
				':',
				CAST(FLOOR(MINUTE(request_timestamp) / 10) AS CHAR),
				'0'
			)
		) AS window_start_time,
		server_id,
		COUNT(*) AS server_request_count,
		AVG(response_time_ms) AS server_avg_response_time
	FROM
		load_balancer_logs
	GROUP BY
		window_start_time,
		server_id
	HAVING
		server_request_count >= 10
),
overall_response_times AS (
	SELECT
		TIMESTAMP(
			CONCAT(
				CAST(DATE(request_timestamp) AS CHAR),
				' ',
				CAST(HOUR(request_timestamp) AS CHAR),
				':',
				CAST(FLOOR(MINUTE(request_timestamp) / 10) AS CHAR),
				'0'
			)
		) AS window_start_time,
		AVG(response_time_ms) AS overall_avg_response_time
	FROM
		load_balancer_logs
	GROUP BY
		window_start_time
)
SELECT
	iw.window_start_time,
	iw.server_id,
	iw.server_request_count,
	ROUND(iw.server_avg_response_time, 2) AS server_avg_response_time,
	ROUND(orp.overall_avg_response_time, 2) AS overall_avg_response_time
FROM
	interval_windows iw
JOIN
	overall_response_times orp ON orp.window_start_time  = iw.window_start_time
WHERE
	iw.server_avg_response_time > orp.overall_avg_response_time;
```
