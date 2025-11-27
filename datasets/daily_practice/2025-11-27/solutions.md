## Puzzle: The Net Billable Time Audit

**The Scenario:** As a payroll specialist, your task is to accurately calculate the net billable time for all employees for a specific day. Billable time is defined as any interval that **begins with either `SHIFT_START` or `BREAK_END`** and ends at the next activity timestamp. These intervals represent **active working time**. Break periods begin at `BREAK_START` and end at `BREAK_END`, and any interval starting at `BREAK_START` is **not** billable. Overlapping shifts (e.g., a second `SHIFT_START` before a `SHIFT_END`) should simply be treated as additional billable intervals starting at that timestamp.

**Your Task:** Write a query to calculate the total `net_billable_hours` for each employee on the date **'2023-11-28'** according to these rules.

**Note:** Any interval that crosses midnight must be truncated to fit within the target day:
- If it begins before **2023-11-28 00:00:00**, truncate the start time to **00:00:00.000**.
- If it ends after **2023-11-28 23:59:59.999**, truncate the end time to **23:59:59.999**.

| **employee_id** | **net_billable_hours** |
| ---------------- | ---------------------- |
| 101              | 7.00                   |
| 102              | 8.00                   |
| 103              | 9.50                   |
| 104              | 8.00                   |

### Tips for Approaching the Problem

1. **Define All Intervals:**
   Use the `LEAD()` window function, partitioned by `employee_id`, to determine the `activity_end_time` of each activity.

2. **Filter to Target Day:**
   Use clipping logic to restrict each interval to the bounds of the target date (2023-11-28 00:00:00 to 2023-11-28 23:59:59.999).
   `GREATEST()` and `LEAST()` help enforce this.

3. **Identify Billable Time:**
   A period is billable if its starting activity is:
   - `SHIFT_START`, or
   - `BREAK_END`
   These represent active working intervals.
   Intervals starting at `BREAK_START` or `SHIFT_END` are not billable.

4. **Calculate and Aggregate:**
   Convert each billable interval to minutes/hours, sum them per employee, and round the final result to 2 decimal places.

**Your Solution:**

```sql
WITH activities AS (
	SELECT
		log_id, employee_id, log_timestamp, activity_type,
		LEAD(log_timestamp, 1) OVER (PARTITION BY employee_id ORDER BY log_timestamp) AS activity_end_time
	FROM
		employee_schedule_log
),
end_times AS(
	SELECT
		log_id, employee_id,
		log_timestamp,
		activity_type,
		CASE WHEN DATE(activity_end_time) > '2023-11-28' THEN '2023-11-28 23:59:59.999' ELSE activity_end_time END AS activity_end_time
	FROM
		activities
	WHERE
		activity_end_time IS NOT NULL
		AND log_timestamp <> activity_end_time
),
total_hours AS (
	SELECT
		log_id, employee_id, log_timestamp, activity_type, activity_end_time,
		ROUND(
			CASE
				WHEN activity_type IN ('SHIFT_START', 'BREAK_END') THEN TIMESTAMPDIFF(MINUTE, log_timestamp, activity_end_time) /60
			END
		, 1) AS activity_time
	FROM
		end_times
)
SELECT
	employee_id,
	ROUND(SUM(activity_time), 2) AS net_billable_hours
FROM
	total_hours
GROUP BY
	employee_id;
```