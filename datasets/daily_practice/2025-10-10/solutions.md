## Puzzle: The Rate Limit Burst Detector

**The Scenario:** As an API platform engineer, you need to identify clients who are "bursting" their rate limit. This behavior can indicate a misconfigured client or a malicious attack. Your task is to create an alert that detects these high-frequency error periods.

**Your Task:** Write a query to find all "burst incidents." A burst incident is defined as a period where an `api_key` generates 4 or more `RATE_LIMIT_EXCEEDED` events within any continuous 60-second window.

The final report should consolidate these incidents, showing the `api_key`, the `incident_start_time` (the timestamp of the first error in the burst), the `incident_end_time` (the timestamp of the last error in the burst), and the total `error_count` during that incident.

| **api_key** | **incident_start_time** | **incident_end_time** | **error_count** |
| ----------------- | ----------------------------- | --------------------------- | --------------------- |
| key-abc           | 2023-12-15 10:00:10.000       | 2023-12-15 10:00:35.000     | 5                     |
| key-xyz           | 2023-12-15 14:30:10.000       | 2023-12-15 14:30:55.000     | 5                     |

### Tips for Approaching the Problem

1. **Isolate Rate Limit Errors:** Start by creating a CTE that selects only the `RATE_LIMIT_EXCEEDED` events from the log.
2. **Identify Consecutive Events:** The core of this puzzle is grouping consecutive rate-limit events that are close in time. This is a classic "gaps and islands" problem.
   * Use the `LAG()` window function to find the timestamp of the previous rate limit error for each `api_key`.
   * In a new column, create a flag (e.g., `1` or `0`) that marks the start of a new incident. A new incident begins if the time between the current error and the previous error is *greater* than 60 seconds (or if it's the very first error for that key).
3. **Create Session IDs:** With the "start of incident" flag, you can now assign a unique ID to each group of consecutive errors. Use a cumulative `SUM()` of your flag, partitioned by `api_key`. This will give every event in the same incident the same `session_id`.
4. **Aggregate by Incident:** Now that you have a `session_id` for each incident, you can `GROUP BY` `api_key` and `session_id`.
   * Calculate the `MIN(event_timestamp)` as the `incident_start_time`.
   * Calculate the `MAX(event_timestamp)` as the `incident_end_time`.
   * Use `COUNT(*)` to get the `error_count`.
5. **Final Filtering:** In your final step, filter the aggregated results to only include incidents where the `error_count` is 4 or more.

**Your Solution:**

```sql
-- Write your solution here
```

