## Scenario 1: Canary Deployment Performance Comparison

**Objective:** You are running a canary test for `version_id = 2` of the `image_processor` function alongside the stable `version_id = 1`. Your task is to compare their performance and reliability during the test window.

**Task:** For the `image_processor` function, analyze all invocations that occurred on '2023-12-01' between '10:00:00' and '10:01:00'. Create a report that shows the `version_id`, `total_invocations`, `error_rate_pct`, `avg_duration_ms`, and `avg_memory_used_mb`.

The final report should compare the two versions side-by-side.

**Expected Output:**

| **version_id** | **total_invocations** | **error_rate_pct** | **avg_duration_ms** | **avg_memory_used_mb** |
| -------------------- | --------------------------- | ------------------------ | ------------------------- | ---------------------------- |
| 1                    | 3                           | 0.00                     | 85.00                     | 128.00                       |
| 2                    | 3                           | 33.33                    | 173.33                    | 135.00                       |

**Your Solution:**

```sql
-- Write your solution here

```

## Scenario 2: Identifying Chained Function Invocations

**Objective:** A "chained invocation" occurs when one function execution immediately triggers another execution of the same function, often resulting in a tight loop of activity. You need to identify these chains to investigate potential recursive bugs or inefficient workflows.

**Task:** Write a query to find all instances where an invocation of a function starts within 1 millisecond of the previous invocation of the *same function* ending.

For each link in a chain, the report should show the `function_name`, the `previous_invocation_id` (the trigger), the `chained_invocation_id` (the one that was triggered), and the exact `start_timestamp` of the chained call.

**Expected Output:**

| **function_name** | **previous_invocation_id** | **chained_invocation_id** | **chained_start_timestamp** |
| ----------------------- | -------------------------------- | ------------------------------- | --------------------------------- |
| user_auth               | inv_014                          | inv_015                         | 2023-12-02 09:00:00.051           |
| user_auth               | inv_015                          | inv_016                         | 2023-12-02 09:00:00.091           |

**Your Solution:**

```sql
-- Write your solution here

```

## Scenario 3: Correlating Errors with High Invocation Frequency

**Objective:** You hypothesize that a sudden burst of traffic (high invocation frequency) is causing an increase in errors for the `data_enrichment` function. Your task is to find evidence of this correlation.

**Task:**

1. First, identify all 1-second windows where the `data_enrichment` function was invoked 3 or more times.
2. For each of these high-frequency windows, calculate the `invocation_count` and the `error_rate_pct`  *within that specific 1-second window* .

The final report should list the `window_start_time` (the timestamp truncated to the second), the `invocation_count`, and the `error_rate_pct` for each identified high-traffic second.

**Expected Output:**

| **window_start_time** | **invocation_count** | **error_rate_pct** |
| --------------------------- | -------------------------- | ------------------------ |
| 2023-12-01 11:30:00         | 1                          | 0.00                     |
| 2023-12-01 11:30:01         | 1                          | 0.00                     |
| 2023-12-01 11:30:02         | 1                          | 0.00                     |
| 2023-12-01 11:30:03         | 1                          | 100.00                   |
| 2023-12-01 11:30:04         | 1                          | 0.00                     |
| 2023-12-01 11:30:05         | 1                          | 0.00                     |
| 2023-12-01 11:30:06         | 1                          | 0.00                     |

**Your Solution:**

```sql
-- Write your solution here

```
