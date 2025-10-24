## Puzzle: The Immediate Back-to-Back Login Alert

**The Scenario:** As a security administrator, you want to be alerted when an employee logs into the system again immediately after a previous login, potentially on different devices. This could indicate unusual activity.

**Your Task:** Write a query to find all instances where a `LOGIN` event is the *direct chronological predecessor* to another `LOGIN` event for the same `employee_id`.

The final report should show the `employee_id`, the `device_id` of the *second* login (`concurrent_login_device`), the timestamp of the *second* login (`concurrent_login_time`), and the `device_id` of the *first* login (`other_active_device_id`).

| **employee_id** | **concurrent_login_device** | **concurrent_login_time** | **other_active_device_id** |
| --------------------- | --------------------------------- | ------------------------------- | -------------------------------- |
| 101                   | Device-B                          | 2023-10-22 09:15:00.000         | Device-A                         |
| 101                   | Device-B                          | 2023-10-22 14:05:00.000         | Device-A                         |
| 103                   | Device-F                          | 2023-10-22 09:45:00.000         | Device-E                         |

### Tips for Approaching the Problem

1. **Look at Consecutive Events:** The core of the problem is comparing each event to the one that comes immediately after it for the same employee. The `LEAD()` window function is the perfect tool for this, as it can "look ahead" in your ordered dataset.
2. **Partition by Employee:** When using `LEAD()`, you must `PARTITION BY employee_id` to look at each employee's event history separately. The history needs to be in chronological order, so you must `ORDER BY log_timestamp`.
3. **Fetch Next Event Details:** Use `LEAD()` in a CTE to get the `status`, `device_id`, and `log_timestamp` of the *next* event and attach it to each row.
4. **Filter for Back-to-Back Logins:** In your final `SELECT` statement, query from the CTE you created. Your `WHERE` clause needs to check if both the current event's `status` and the `next_event_status` are 'LOGIN'.

**Your Solution:**

```sql
WITH concurrent_devices AS (
	SELECT
		employee_id,
		device_id AS other_active_device_id,
		log_timestamp,
		status,
		LEAD(device_id, 1) OVER (PARTITION BY employee_id ORDER BY log_timestamp) AS concurrent_login_device,
		LEAD(log_timestamp , 1) OVER (PARTITION BY employee_id ORDER BY log_timestamp) AS concurrent_login_time,
		LEAD(status, 1) OVER (PARTITION BY employee_id ORDER BY log_timestamp) AS concurrent_device_status
	FROM
		employee_device_logs
)
SELECT
	employee_id,
	concurrent_login_device,
	concurrent_login_time,
	other_active_device_id
FROM
	concurrent_devices
WHERE
	status = 'LOGIN'
	AND concurrent_device_status = 'LOGIN';
```
