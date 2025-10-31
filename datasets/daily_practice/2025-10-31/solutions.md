## Puzzle: The Zombie Session Audit

**The Scenario:** As a network administrator for a VPN service, you need to find "zombie sessions." A zombie session is a session that is still marked as active (`session_end IS NULL`) but has been open for an unusually long time, suggesting it failed to close properly and is tying up resources.

**Your Task:** Write a query to find all sessions that are "zombies" as of the cutoff time `'2023-11-20 12:00:00'`. A session is a zombie if:

1. It is still active (`session_end IS NULL`).
2. It has been open for more than **12 hours** as of the cutoff time.

For each zombie session, the report must also include a flag `has_newer_session`. This flag is `true` if the same user has started *any* other session (on any server) *after* the zombie session began, and `false` otherwise. This helps prioritize alerts, as it shows the user was able to reconnect.

The final report should show the `user_id`, `zombie_session_id`, `server_id`, `session_start_time`, the `hours_open` (rounded to 2 decimal places), `client_version`, and the `has_newer_session` flag.

| **user_id** | **zombie_session_id** | **server_id** | **session_start_time** | **hours_open** | **client_version** | **has_newer_session** |
| ----------------- | --------------------------- | ------------------- | ---------------------------- | -------------------- | ------------------------ | --------------------------- |
| 101               | 2                           | srv-B               | 2023-11-18 10:00:00.000      | 50.00                | 1.2.0                    | true                        |
| 103               | 5                           | srv-C               | 2023-11-15 08:00:00.000      | 124.00               | 1.1.0                    | false                       |
| 105               | 7                           | srv-A               | 2023-11-16 10:00:00.000      | 98.00                | 1.0.0                    | false                       |

### Tips for Approaching the Problem

1. **Find Active Sessions:** Start by creating a Common Table Expression (CTE) that selects all sessions where `session_end IS NULL`.
2. **Calculate `hours_open`:** In this CTE, calculate the duration in hours between the `session_start` and the cutoff time (`'2023-11-20 12:00:00'`). Use a function like `TIMESTAMPDIFF(MINUTE, session_start, '...') / 60.0` for decimal precision.
3. **Filter for Zombies:** In a second CTE (or your final `SELECT`), filter the results from step 2 to keep only those where `hours_open > 12`. This is your list of zombie sessions.
4. **Check for Newer Sessions:** This is the key part. To get the `has_newer_session` flag, you need to check if another session exists for the same user. A `LEFT JOIN` or an `EXISTS` subquery is perfect for this.
   * Using EXISTS: In your final SELECT statement, you can use a CASE statement with a correlated subquery:
     CASE WHEN EXISTS (SELECT 1 FROM vpn_sessions s2 WHERE s2.user_id = zombies.user_id AND s2.session_start > zombies.session_start) THEN true ELSE false END AS has_newer_session
   * **Using `LEFT JOIN`:** You could `LEFT JOIN` the `vpn_sessions` table back onto your zombie sessions CTE (`ON s2.user_id = zombies.user_id AND s2.session_start > zombies.session_start`). Then, in your final `SELECT`, use `DISTINCT` and check if `s2.session_id IS NOT NULL`.

**Your Solution:**

```sql
-- Write your solution here
```

