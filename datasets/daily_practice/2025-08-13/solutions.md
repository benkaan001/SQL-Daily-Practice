## Scenario 1: Dynamic Rate Limiting Alert

**Objective:** As a platform engineer, you need to identify API keys that might be causing performance degradation by accumulating high latency through a series of rapid requests. This can help find clients making inefficient calls.

**Task:**
Write a query to find the **first request** for each `api_key` that meets all of the following criteria:

1.  It causes the **cumulative sum of `latency_ms`** for that key (ordered by time) to be **100ms or greater**.
2.  The **next request** from that same key must occur within **5 minutes**.
3.  To exclude single long-running requests, the specific request that crosses the threshold must itself have a `latency_ms` of **less than 100**.

The final report should show the `api_key` and the `throttling_start_time` (the timestamp of the request that met these conditions).

**Expected Output:**

| api_key | throttling_start_time |
| :--- | :--- |
| key-abc | 2023-11-25 10:02:58 |
| key-ghi | 2023-11-25 16:01:00 |

**Your Solution:**

```sql
WITH latencies AS (
	SELECT
		api_key,
		latency_ms,
		SUM(latency_ms) OVER (PARTITION BY api_key ORDER BY request_timestamp) AS latency_running_total,
		request_timestamp,
		LEAD(request_timestamp, 1) OVER (PARTITION BY api_key ORDER BY request_timestamp) AS next_request_timestamp
	FROM
		api_usage_logs
),
filtered_latencies AS (
	SELECT
		api_key,
		latency_ms,
		latency_running_total,
		request_timestamp,
		next_request_timestamp
	FROM
		latencies
	WHERE
		latency_running_total >= 100
		AND next_request_timestamp IS NOT NULL
		AND TIMESTAMPDIFF(SECOND, request_timestamp, next_request_timestamp) <= 60* 5
)
SELECT
	api_key,
	MIN(request_timestamp) AS throttling_start_time
FROM
	filtered_latencies
WHERE
	latency_ms < 100
GROUP BY
	api_key;
```

## Scenario 2: Latency Degradation Detection

**Objective:** As an SRE, you need to automatically detect when an API endpoint's performance is degrading. Your goal is to find endpoints where the 95th percentile (P95) latency for a given hour is more than 50% higher than the P95 latency of the *previous* hour.

**Task:**

1. Calculate the P95 latency for each endpoint for each hour of the day.
2. Compare each hour's P95 latency with the P95 latency of the previous hour for the same endpoint.
3. Filter for instances where the current hour's P95 is at least 1.5 times the previous hour's P95.

The report should show the `endpoint`, the `degradation_hour`, the `p95_latency_current_hour`, and the `p95_latency_previous_hour`.

**Expected Output:**

| endpoint | degradation_hour    | p95_latency_current_hour | p95_latency_previous_hour |
| -------- | ------------------- | ------------------------ | ------------------------- |
| /orders  | 2023-11-25 14:00:00 | 480                      | 210                       |
| /users   | 2023-11-25 17:00:00 | 300                      | 55                        |

**Your Solution:**

```sql
WITH ranked_latencies AS (
    SELECT
        endpoint,
        DATE_FORMAT(request_timestamp, '%Y-%m-%d %H:00:00') AS hour,
        latency_ms,
        ROW_NUMBER() OVER (PARTITION BY endpoint, DATE_FORMAT(request_timestamp, '%Y-%m-%d %H:00:00') ORDER BY latency_ms) AS latency_rank,
        COUNT(*) OVER (PARTITION BY endpoint, DATE_FORMAT(request_timestamp, '%Y-%m-%d %H:00:00')) AS total_in_group
    FROM
        api_usage_logs
),
hourly_P95 AS (
    SELECT
        endpoint,
        hour,
        latency_ms AS p95_latency
    FROM
        ranked_latencies
    WHERE
        latency_rank = CEIL(0.95 * total_in_group)
),
hourly_changes AS (
    SELECT
        endpoint,
        hour,
        p95_latency,
        LAG(p95_latency, 1) OVER (PARTITION BY endpoint ORDER BY hour) AS p95_latency_previous_hour
    FROM
        hourly_P95
)
SELECT
    endpoint,
    hour AS degradation_hour,
    p95_latency AS p95_latency_current_hour,
    p95_latency_previous_hour
FROM
    hourly_changes
WHERE
    p95_latency_previous_hour IS NOT NULL
    AND p95_latency > p95_latency_previous_hour * 1.5;
```

## Scenario 3: Correlating Errors with Payload Size

**Objective:** You suspect that server errors (status codes 500-599) are correlated with large request payloads for certain endpoints. Your task is to write a query to find endpoints where this correlation is strong.

**Task:** For each endpoint that has experienced at least one server error, calculate the average `request_payload_kb` for all successful requests (`status_code < 500`) and the average `request_payload_kb` for all failed requests (`status_code >= 500`).

The final report should only include endpoints where the average payload of failed requests is more than 10 times greater than the average payload of successful requests, indicating a strong correlation.

**Expected Output:**

| endpoint  | avg_payload_success_kb | avg_payload_failed_kb |
| --------- | ---------------------- | --------------------- |
| /products | 2.850000               | 60.000000             |

**Your Solution:**

```sql
WITH successful_payloads AS (
	SELECT
		endpoint,
		AVG(request_payload_kb) AS avg_payload_success_kb
	FROM
		api_usage_logs
	WHERE
		status_code < 500
	GROUP BY
		endpoint
),
failed_payloads AS (
	SELECT
		endpoint,
		AVG(request_payload_kb) AS avg_payload_failed_kb
	FROM
		api_usage_logs
	WHERE
		status_code >= 500
	GROUP BY
		endpoint
)
SELECT
	sp.endpoint,
	sp.avg_payload_success_kb,
	fp.avg_payload_failed_kb
FROM
	successful_payloads sp
JOIN
	failed_payloads fp ON sp.endpoint = fp.endpoint
WHERE
	fp.avg_payload_failed_kb >= sp.avg_payload_success_kb * 10;
```
