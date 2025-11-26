## Puzzle: The Data Integrity Auditor

**The Scenario:** As a data integrity specialist, your primary job is to flag suspicious activity that violates the core chronological and logical rules of the system. Anomalies must be identified quickly to prevent exploits or system corruption.

**Your Task:** Write a query to find all log entries that represent a data integrity violation. A log entry is a violation if it breaks either of the following rules compared to the *immediately preceding* log entry for the same user:

1. **Chronological Violation (Time Travel):** The current `event_timestamp` is less than the previous event's timestamp.
2. **Score Violation (Impossible Jump):** The `current_score` increases by more than 100 points in a single step.
3. **Score Violation (Reversal):** The `current_score` is less than the previous event's score.

The final report should show the `log_id` of the violating event, the `user_id`, the `event_timestamp`, and the specific `violation_type` ('TIME_REVERSAL', 'IMPOSSIBLE_SCORE', or 'SCORE_REVERSAL').

| **log_id** | **user_id** | **event_timestamp** | **current_score** | **violation_type** |
| ---------------- | ----------------- | ------------------------- | ----------------------- | ------------------------ |
| 8                | 102               | 2023-12-01 10:59:00.000   | 20                      | TIME_REVERSAL            |
| 11               | 103               | 2023-12-02 12:02:00.000   | 200                     | IMPOSSIBLE_SCORE         |
| 15               | 104               | 2023-12-02 14:02:00.000   | 60                      | SCORE_REVERSAL           |

### Tips for Approaching the Problem

1. **Use `LAG()` Extensively:** The core of this problem is comparing the current row's data against the immediate predecessor. The `LAG()` window function is essential and must be partitioned by `user_id` and ordered by `event_timestamp`. You need to pull both the previous timestamp and the previous score.
2. **Standardize Comparisons (CTE):** Create a Common Table Expression (CTE) to calculate three key values on every row:
   * `prev_timestamp`: `LAG(event_timestamp)`
   * `prev_score`: `LAG(current_score)`
   * `score_difference`: `current_score - prev_score`
3. **Prioritize Violation Type:** In your final `SELECT` statement, use a prioritized `CASE` statement. The first `WHEN` condition that is met will assign the violation type.
   * Check for **TIME_REVERSAL** first (`current_timestamp < prev_timestamp`).
   * Check for **SCORE_REVERSAL** next (`current_score < prev_score`).
   * Check for **IMPOSSIBLE_SCORE** last (`score_difference > 100`).

**Your Solution:**

```sql
-- Write your solution here
```
