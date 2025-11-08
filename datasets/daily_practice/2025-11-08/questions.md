## Puzzle: The "Degraded Server" Detector

**The Scenario:** As a Site Reliability Engineer (SRE), you need to create an alert to find servers that are in a "degraded" state. A server is considered degraded if it reports unhealthy metrics for 3 consecutive minutes (i.e., 3 log entries in a row).

An "unhealthy" metric is defined as:

* `cpu_usage_percent` > 90%
* OR `memory_usage_gb` is over 90% of `total_memory_gb`.

**Your Task:** Write a query to find all servers that have experienced at least one 3-minute "degraded" streak. The report should show the `server_id` and the `first_alert_timestamp` (the timestamp of the *first* log in the 3-minute unhealthy streak).

| server_id | first_alert_timestamp |

| db-01 | 2023-11-08 11:01:00.000 |

| web-01 | 2023-11-08 10:02:00.000 |

### Tips for Approaching the Problem

1. Identify Unhealthy Logs: The first step is to flag every log entry as either "healthy" (0) or "unhealthy" (1). You can do this in a CTE. Use a CASE statement with the logic:
   WHEN cpu_usage_percent > 90 OR (memory_usage_gb / total_memory_gb) > 0.9 THEN 1
   ELSE 0 END AS is_unhealthy
2. **Find Consecutive Events:** This is a "gaps and islands" problem. To find *consecutive* unhealthy logs, you need to group them.
   * First, use `LAG()` to get the `is_unhealthy` status of the *previous* log entry for that server (`PARTITION BY server_id ORDER BY log_timestamp`).
   * Create a new flag (e.g., `is_new_streak_start`) that is `1` if the current row is unhealthy (`is_unhealthy = 1`) but the previous row was not (`prev_is_unhealthy = 0` or `NULL`).
3. **Create Streak Groups:** Now, you can create a unique ID for each streak. Use a cumulative `SUM()` of your `is_new_streak_start` flag (`PARTITION BY server_id ORDER BY log_timestamp`). This will assign the same `streak_id` to all consecutive rows in an unhealthy streak.
4. **Aggregate and Filter:** In your final query, `GROUP BY server_id, streak_id`.
   * You only care about the unhealthy streaks, so filter `WHERE is_unhealthy = 1`.
   * Get the `MIN(log_timestamp)` as the `first_alert_timestamp`.
   * Use `COUNT(*)` to find the `streak_length`.
   * Use a `HAVING` clause to keep only the streaks where `streak_length >= 3`.

**Your Solution:**

```sql
-- Write your solution here
```
