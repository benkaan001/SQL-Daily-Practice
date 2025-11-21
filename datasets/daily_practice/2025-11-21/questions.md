## Puzzle: The Ghost Session Detector

**The Scenario:** As a security administrator, you are tasked with auditing active user sessions. A "ghost session" is defined as a `LOGIN` event that was never properly closed by a subsequent `LOGOUT` event for the same user. This can happen if a user's browser crashes or if the system fails to record the logout, posing a security risk.

**Your Task:** Write a query to find every instance of a "ghost session." A `LOGIN` event is considered a ghost session if the *next* chronological event for that `user_id` is *not* a `LOGOUT` event.

The final report should show the `user_id` and the `session_start_time` (the timestamp of the `LOGIN` event) for every ghost session.

| **user_id** | **session_start_time** |
| ----------------- | ---------------------------- |
| 102               | 2023-11-20 11:00:00.000      |
| 105               | 2023-11-20 16:00:00.000      |

### Tips for Approaching the Problem

1. **Look at the Next Event:** The key to this problem is comparing each event to the one that immediately follows it. The `LEAD()` window function is the perfect tool to "look ahead" in your data.
2. **Partition and Order:** When using `LEAD()`, you must `PARTITION BY user_id` to look at each user's entire history separately. The history needs to be strictly chronological, so you must `ORDER BY event_timestamp`.
3. **Isolate Login Events:** Create a Common Table Expression (CTE) that selects all events and uses `LEAD()` to attach the `next_event_type`.
4. **Apply the Ghost Logic:** In your final `SELECT` statement, query from the CTE and filter for `event_type = 'LOGIN'`. The session is a "ghost" if the next event meets one of the following criteria:
   * The `next_event_type` is **NULL** (meaning the user's last action was a login).
   * OR the `next_event_type` is **'LOGIN'** (meaning a new session started without the previous one closing).

**Your Solution:**

```sql
-- Write your solution here
```
