
## Puzzle: The Overloaded Server Detector

**The Scenario:** As a Site Reliability Engineer (SRE), you need to monitor the load balancer logs to proactively identify backend servers that might be overloaded. An overloaded server often exhibits higher response times compared to its peers under similar traffic conditions.

**Your Task:** Write a query to identify potentially overloaded servers based on 10-minute intervals. A server is considered potentially overloaded in a specific 10-minute window if:

1. It handled at least 10 requests during that window.
2. Its average `response_time_ms` during that window was more than 50% higher than the *overall* average response time across *all* servers during that same window.

The final report should show the `window_start_time` (e.g., '10:00:00', '10:10:00'), the `server_id` identified as overloaded, the `server_request_count` in that window, the `server_avg_response_time` in that window, and the `overall_avg_response_time` across all servers for comparison.

| **window_start_time** | **server_id** | **server_request_count** | **server_avg_response_time** | **overall_avg_response_time** |
| --------------------------- | ------------------- | ------------------------------ | ---------------------------------- | ----------------------------------- |
| 10:00:00                    | srv-B               | 11                             | 308.18                             | 199.21                              |
| 10:30:00                    | srv-C               | 12                             | 274.17                             | 171.37                              |

### Tips for Approaching the Problem

1. **Define Time Windows:** The first step is to group the log entries into 10-minute intervals. You can achieve this by truncating the `request_timestamp` to the nearest 10-minute mark. One way is to calculate minutes from the start of the hour (`MINUTE(request_timestamp)`), divide by 10 (`FLOOR(MINUTE(...) / 10)`), and then combine this back with the hour and date.
2. **Calculate Window Aggregates:** You need two levels of aggregation: per-server within the window and overall for the window. Window functions are ideal here.
   * In a CTE, calculate the `COUNT(*)` and `AVG(response_time_ms)` for each `server_id` within each `window_start_time`. Use `PARTITION BY window_start_time, server_id`.
   * In the *same* CTE, also calculate the overall `AVG(response_time_ms)` for the entire window, ignoring the server. Use `PARTITION BY window_start_time` only.
3. **Apply Overload Logic:** Now you have all the necessary numbers calculated for each log entry. In your final `SELECT` statement (which can query from the CTE):
   * Use `DISTINCT` to get one row per identified overloaded server per window.
   * Filter using a `WHERE` clause:
     * `server_request_count >= 10`
     * `server_avg_response_time > overall_avg_response_time * 1.5`

**Your Solution:**

```sql
-- Write your solution here
```
