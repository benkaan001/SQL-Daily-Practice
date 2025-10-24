## Puzzle: The Concurrent Session Alert

**The Scenario:** As a security administrator, you must identify employees who have active sessions on more than one device at the same time. This could be a sign of a compromised account or policy violation.

**Your Task:** Write a query to find all `LOGIN` events that are "concurrent." A `LOGIN` event is considered concurrent if, at the moment of login, the same `employee_id` already had an active session on a *different* `device_id`.

An "active session" is defined as a `LOGIN` event that has not yet been followed by a `LOGOUT` event for that specific employee *and* device.

The final report should show the `employee_id`, the `device_id` of the concurrent login, the `concurrent_login_time`, and the `other_active_device_id`.

| **employee_id** | **concurrent_login_device** | **concurrent_login_time** | **other_active_device_id** |
| --------------------- | --------------------------------- | ------------------------------- | -------------------------------- |
| 101                   | Device-B                          | 2023-10-22 09:15:00.000         | Device-A                         |
| 101                   | Device-B                          | 2023-10-22 14:05:00.000         | Device-A                         |
| 103                   | Device-F                          | 2023-10-22 09:45:00.000         | Device-E                         |
| 103                   | Device-E                          | 2023-10-22 11:00:00.000         | Device-F                         |

### Tips for Approaching the Problem

1. **Define Sessions:** The first step is to define the start and end time for every session on every device. A session is a `LOGIN` event and its corresponding `LOGOUT`. Use the `LEAD()` window function to find the `logout_time` for each `LOGIN`.
   * `PARTITION BY employee_id, device_id` and `ORDER BY log_timestamp`.
   * The `LEAD(log_timestamp)` will give you the next event's time.
   * Only use this `LEAD` time if the `LEAD(status)` is 'LOGOUT'. If the next event is another 'LOGIN' or is `NULL`, the session is still active (its `logout_time` can be considered `NULL`).
2. **Create a Session CTE:** Build a CTE that lists all defined sessions, showing `employee_id`, `device_id`, `login_time`, and `logout_time` (which can be `NULL` if the session is still active).
3. **Use a Self-Join to Find Overlaps:** `JOIN` this session CTE to itself (e.g., `s1` and `s2`). This allows you to compare every session with every other session. The join conditions are the key:
   * `s1.employee_id = s2.employee_id` (same employee)
   * `s1.device_id != s2.device_id` (different devices)
   * `s1.login_time > s2.login_time` (this finds the "concurrent" login, `s1`)
   * `s1.login_time < COALESCE(s2.logout_time, '9999-12-31')` (this checks that `s1`'s login happened *before* `s2`'s session ended. Use `COALESCE` to handle active sessions that have a `NULL` logout time).
4. **Final Selection:** Select the details for the `s1` session, as it represents the concurrent login. You will also want to select `s2.device_id` as the `other_active_device_id`.

**Your Solution:**

```sql
-- Write your solution here
```
