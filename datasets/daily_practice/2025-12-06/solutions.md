
## Puzzle: The Session Reconstruction

**The Scenario:** You have raw clickstream data, but no session IDs. To analyze user behavior, you must group clicks into "Sessions." A new session starts if a user is inactive for  **30 minutes or more** .

**Your Task:** Write a query to define session IDs for these users and calculate the duration of each session.

1. Identify where new sessions begin (gap > 30 mins from previous event).
2. Assign a unique `session_id` to each group of events (e.g., using a running sum of "new session" flags).
3. Calculate the `session_start_time`, `session_end_time`, and `event_count` for each reconstructed session.

| **user_id** | **session_start_time** | **session_end_time** | **event_count** |
| ----------------- | ---------------------------- | -------------------------- | --------------------- |
| 101               | 2023-12-06 08:00:00          | 2023-12-06 08:29:00        | 3                     |
| 102               | 2023-12-06 09:00:00          | 2023-12-06 09:05:00        | 2                     |
| 102               | 2023-12-06 10:00:00          | 2023-12-06 10:05:00        | 2                     |

### Tips for Approaching the Problem

1. **Flag New Sessions:** Use `LAG()` to look at the previous timestamp. If `timestamp - prev_timestamp > 30 mins` (or if `prev` is null), set a flag `is_new_session = 1`.
2. **Generate ID:** Use `SUM(is_new_session) OVER (PARTITION BY user_id ORDER BY timestamp)` to create a running total. This total becomes your Session ID.
3. **Aggregate:** Group by `user_id` and your new `session_id` to find `MIN(time)` and `MAX(time)`.

**Your Solution:**

```sql
-- Write your solution here
```
