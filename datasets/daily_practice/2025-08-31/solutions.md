## Puzzle 1: The Throttled Client

**The Scenario:** The platform team needs to identify which clients are hitting rate limits. To provide context, they don't just want to see the throttled request; they want to know *how many* requests that client had made in the minute leading up to the throttle event.

**Your Task:** Write a query that finds every request that resulted in a `429` (Too Many Requests) status code. For each of these throttled requests, calculate `requests_in_last_60s`, which is the total number of requests made by that same `api_key` in the 60 seconds immediately preceding the throttled request.

The final report should show the `api_key`, the `request_timestamp` of the throttled request, and the calculated `requests_in_last_60s`.

**Expected Output:**

| api_key | request_timestamp   | requests_in_last_60s |
| ------- | ------------------- | -------------------- |
| key-B   | 2023-09-20 10:30:35 | 4                    |
| key-B   | 2023-09-20 10:30:40 | 5                    |


**Your Solution:**

```sql
WITH throttled_requests AS (
    SELECT
        api_key,
        request_id,
        request_timestamp
    FROM
        api_gateway_logs
    WHERE
        status_code = 429
)
SELECT
    tr.api_key,
    tr.request_timestamp,
    COUNT(logs.request_id) AS requests_in_last_60s
FROM
    throttled_requests tr
LEFT JOIN
    api_gateway_logs logs ON tr.api_key = logs.api_key
    AND logs.request_timestamp BETWEEN DATE_SUB(tr.request_timestamp, INTERVAL 60 SECOND) AND tr.request_timestamp
    AND logs.request_id != tr.request_id
GROUP BY
    tr.api_key,
    tr.request_timestamp
ORDER BY
    tr.request_timestamp;
```

## Puzzle 2: The Cascading Failure

**The Scenario:** An SRE is investigating a production incident. They hypothesize that a failure in the `user-service` caused a "cascading failure" in the `order-service`, which depends on it. You need to find proof of this chain reaction.

**Your Task:** Find all instances where a request to the `order-service` failed (status code >= 500) and was preceded by a failure (status code >= 500) in the `user-service` as part of the *same logical transaction* (indicated by a shared `request_id`). The `user-service` failure must have occurred within 1 second before the `order-service` failure.

The report should show the `request_id`, the `dependency_service_name` (`user-service`), its `dependency_failure_time`, and the `failing_service_name` (`order-service`) with its `service_failure_time`.

**Expected Output:**

| **request_id** | **dependency_service_name** | **dependency_failure_time** | **failing_service_name** | **service_failure_time** |
| -------------------- | --------------------------------- | --------------------------------- | ------------------------------ | ------------------------------ |
| req_09               | user-service                      | 2023-09-21 11:00:00.000           | order-service                  | 2023-09-21 11:00:00.500        |

**Your Solution:**

```sql
-- Write your solution here
```

## Puzzle 3: The Latency Anomaly

**The Scenario:** The performance team needs an automated way to detect significant latency degradations. Your task is to identify any service whose 95th percentile (P95) response time on a given day is more than double its P95 response time from the previous day.

**Your Task:**

1. Calculate the daily P95 `response_time_ms` for each service.
2. Compare each day's P95 latency to the P95 latency of the day before for the same service.
3. Flag any day where the `p95_latency` is more than twice the `previous_day_p95_latency`.

The final report should show the `service_name`, the `anomaly_date`, the `p95_latency` on that date, and the `previous_day_p95_latency`.

**Expected Output:**

| **service_name** | **anomaly_date** | **p95_latency** | **previous_day_p95_latency** |
| ---------------------- | ---------------------- | --------------------- | ---------------------------------- |
| payment-service        | 2023-09-23             | 890.00                | 290.00                             |

**Your Solution:**

```sql
-- Write your solution here
```
