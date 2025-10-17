## Puzzle: The Lingering Access Security Audit

**The Scenario:** As a security compliance officer, you need to audit system access logs to ensure that when an employee's access to a system is terminated, all of their active sessions for that system are also terminated. A "lingering access" is a significant security risk.

**Your Task:** Write a query to identify all instances of "lingering access." A lingering access is defined as an active session (a `LOGIN` event without a corresponding subsequent `LOGOUT` event) that was initiated *before* an employee's `access_end_date` for that specific system.

The final report should show the `employee_id`, the `system_name` they still have access to, the `session_start_time` of the lingering session, and the `access_termination_time`.

| **employee_id** | **system_name** | **session_start_time** | **access_termination_time** |
| --------------------- | --------------------- | ---------------------------- | --------------------------------- |
| 101                   | Sales_CRM             | 2023-11-20 09:00:00.000      | 2023-11-20 17:00:00.000           |

### Tips for Approaching the Problem

1. **Define a Session:** The first step is to clearly define the start and end of each access session. A session is a `LOGIN` event and its corresponding `LOGOUT` event. Use the `LEAD()` window function to find the next event for an employee on a specific system. This allows you to pair a `LOGIN` with its subsequent `LOGOUT`.
2. **Find Session End Times:** In a CTE, use `LEAD(access_event) OVER (PARTITION BY employee_id, system_name ORDER BY event_timestamp)` and `LEAD(event_timestamp) OVER (...)`. This will give you the `next_event_type` and `next_event_time` for each log entry.
3. **Identify Active Sessions:** A session is defined by a `LOGIN` event. Its end time is the `next_event_time` *only if* the `next_event_type` is a `LOGOUT`. If the next event is another `LOGIN` or is `NULL`, the session is still considered active.
4. **Join with Access Rights:** `JOIN` your session data from the previous steps with the `employee_access_rights` table on both `employee_id` and `system_name`. This links each session to a potential access termination date.
5. **Apply the Lingering Logic:** In your final `WHERE` clause, filter for the specific conditions of a lingering session:
   * The session must be a `LOGIN` event.
   * The `LOGIN` timestamp must be *before* the `access_end_date`.
   * The session must still be active at the time access was terminated. This means either:
     * There is no next event (the `next_event_time` is `NULL`).
     * OR the next event's timestamp is *after* the `access_end_date`.

**Your Solution:**

```sql
WITH joint_logs AS (
SELECT
	eal.employee_id,
	eal.event_timestamp,
	eal.access_event,
	eal.system_name AS emp_log_system,
	ear.system_name AS emp_right_system,
	ear.access_end_date,
	LEAD(eal.access_event, 1) OVER (PARTITION BY eal.employee_id, eal.system_name ORDER BY eal.event_timestamp) AS next_access_event
FROM
	employee_access_logs eal
JOIN
	employee_access_rights ear ON eal.employee_id = ear.employee_id AND eal.system_name = ear.system_name
)
SELECT
	employee_id,
	emp_right_system AS system_name,
	event_timestamp AS session_start_time,
	access_end_date AS access_termination_time
FROM
	joint_logs
WHERE
	access_event = 'LOGIN'
	AND (next_access_event != 'LOGOUT' OR next_access_event IS NULL);
```

