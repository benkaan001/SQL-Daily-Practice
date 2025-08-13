## Scenario 1: Dynamic Rate Limiting Alert

**Objective:** As a platform engineer, you need to identify API keys that are violating usage policies. Your task is to write a query that can detect in real-time when an API key first exceeds a rate limit of 100 requests within any 5-minute rolling window.

**Task:** For each `api_key`, find the exact timestamp of the first request that caused its 5-minute request count to exceed 100. This is the moment the key should be throttled.

The final report should show the `api_key` and the `throttling_start_time`.

**Expected Output:**

| **api_key** | **throttling_start_time** |
| ----------------- | ------------------------------- |
| key-abc           | 2023-11-25 10:02:59             |

**Your Solution:**

```sql
-- Write your solution here

```

## Scenario 2: Latency Degradation Detection

**Objective:** As an SRE, you need to automatically detect when an API endpoint's performance is degrading. Your goal is to find endpoints where the 95th percentile (P95) latency for a given hour is more than 50% higher than the P95 latency of the *previous* hour.

**Task:**

1. Calculate the P95 latency for each endpoint for each hour of the day.
2. Compare each hour's P95 latency with the P95 latency of the previous hour for the same endpoint.
3. Filter for instances where the current hour's P95 is at least 1.5 times the previous hour's P95.

The report should show the `endpoint`, the `degradation_hour`, the `p95_latency_current_hour`, and the `p95_latency_previous_hour`.

**Expected Output:**

| **endpoint** | **degradation_hour** | **p95_latency_current_hour** | **p95_latency_previous_hour** |
| ------------------ | -------------------------- | ---------------------------------- | ----------------------------------- |
| /orders            | 2023-11-25 14:00:00        | 477.00                             | 207.00                              |

**Your Solution:**

```sql
-- Write your solution here

```

## Scenario 3: Correlating Errors with Payload Size

**Objective:** You suspect that server errors (status codes 500-599) are correlated with large request payloads for certain endpoints. Your task is to write a query to find endpoints where this correlation is strong.

**Task:** For each endpoint that has experienced at least one server error, calculate the average `request_payload_kb` for all successful requests (`status_code < 500`) and the average `request_payload_kb` for all failed requests (`status_code >= 500`).

The final report should only include endpoints where the average payload of failed requests is more than 10 times greater than the average payload of successful requests, indicating a strong correlation.

**Expected Output:**

| **endpoint** | **avg_payload_success_kb** | **avg_payload_failed_kb** |
| ------------------ | -------------------------------- | ------------------------------- |
| /products          | 2.85                             | 60.00                           |

**Your Solution:**

```sql
-- Write your solution here

```
