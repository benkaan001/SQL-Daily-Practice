## Puzzle: The "Impossible Travel" Alert

**The Scenario:** The security team needs to flag "Impossible Travel" events—where a user successfully logs in from two different countries within a timeframe that makes physical travel impossible. We will define "impossible" as changing countries within less than  **2 hours** .

**Your Task:** Write a query to identify any `user_id` who had two consecutive `SUCCESS` logins from *different* `country_code`s within a 2-hour window.

The report should show the `user_id`, the `origin_country`, the `origin_time`, the `destination_country`, and the `destination_time`.

| **user_id** | **origin_country** | **origin_time** | **destination_country** | **destination_time** |
| ----------------- | ------------------------ | --------------------- | ----------------------------- | -------------------------- |
| 101               | US                       | 2023-12-05 08:00:00   | JP                            | 2023-12-05 09:00:00        |
| 103               | FR                       | 2023-12-05 10:00:00   | DE                            | 2023-12-05 10:05:00        |
| 103               | DE                       | 2023-12-05 10:05:00   | BR                            | 2023-12-05 10:09:00        |

### Tips for Approaching the Problem

1. **Look Ahead:** Use `LEAD()` to get the *next* login's country and timestamp for each row. Partition by `user_id`.
2. **Compare:** In the outer query, filter for rows where:
   * `status` is SUCCESS.
   * `next_country` is not equal to `current_country`.
   * `next_timestamp` is within 2 hours of `current_timestamp` (`TIMESTAMPDIFF`).

**Your Solution:**

```sql
-- Write your solution here
```
