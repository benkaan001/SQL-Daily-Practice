## Puzzle: The Meeting Room Gap Finder

**The Scenario:** As an office facility manager, you constantly receive requests from employees asking: "Are there any rooms available for at least an hour today?" You need a query that automatically detects all continuous available blocks of time for every room.

**Your Task:** Write a query to find all continuous available time gaps of **60 minutes or more** for any room on  **March 4, 2026** , between the business hours of **08:00:00** and  **18:00:00** .

*Rules for a valid gap:*

1. A gap can exist between the end of one scheduled meeting and the start of the next.
2. A gap can exist between the start of the business day (`08:00:00`) and the very first meeting.
3. A gap can exist between the end of the last meeting and the end of the business day (`18:00:00`).

The final report should show the `room_name`, the `gap_start`, the `gap_end`, and the `gap_duration_minutes`. Order the results by `room_name` and then by `gap_start`.

**Expected Output:**

| **room_name** | **gap_start** | **gap_end**   | **gap_duration_minutes** |
| ------------------- | ------------------- | ------------------- | ------------------------------ |
| Boardroom A         | 2026-03-04 08:00:00 | 2026-03-04 09:00:00 | 60                             |
| Boardroom A         | 2026-03-04 12:00:00 | 2026-03-04 14:00:00 | 120                            |
| Boardroom A         | 2026-03-04 15:30:00 | 2026-03-04 17:30:00 | 120                            |
| Innovation Lab      | 2026-03-04 16:30:00 | 2026-03-04 18:00:00 | 90                             |
| Quiet Room          | 2026-03-04 08:00:00 | 2026-03-04 10:00:00 | 120                            |
| Quiet Room          | 2026-03-04 11:00:00 | 2026-03-04 18:00:00 | 420                            |
| Strategy Room       | 2026-03-04 17:00:00 | 2026-03-04 18:00:00 | 60                             |

### Tips for Approaching the Problem

1. **Establish the Daily Boundaries:** The hardest part is finding gaps at the very beginning or end of the day. A brilliant SQL trick is to create "dummy" meetings for each room that represent the start and end of the business day.
   * Generate a CTE that extracts `DISTINCT room_name` and assigns them a dummy meeting from `08:00:00` to `08:00:00` (Start of day).
   * `UNION ALL` that with another dummy meeting from `18:00:00` to `18:00:00` (End of day).
   * `UNION ALL` both of those with the actual `room_bookings` data.
2. **Look Ahead for the Next Meeting:** Now that you have a continuous timeline of dummy and real meetings, use the `LEAD()` window function. Partition by `room_name` and order by `start_time`. You want to pull the `start_time` of the *next* meeting in the schedule.
3. **Calculate the Gap:** In a CTE, calculate the gap. The open gap starts exactly when the current meeting's `end_time` finishes, and the gap ends exactly when the `next_meeting_start` begins.
4. **Filter:** Finally, use `TIMESTAMPDIFF(MINUTE, end_time, next_meeting_start)` and apply a `WHERE` clause to filter out any gaps that are less than 60 minutes.

**Your Solution:**

```sql
	(SELECT DISTINCT 
		room_name, 
		TIMESTAMP('2026-03-04 08:00:00') AS start_time, 
		TIMESTAMP('2026-03-04 08:00:00') AS end_time
	FROM 
		room_bookings
	)
	UNION ALL 
	(
	SELECT DISTINCT 
		room_name, 
		TIMESTAMP('2026-03-04 18:00:00') AS start_time, 
		TIMESTAMP('2026-03-04 18:00:00') AS end_time
	FROM 
		room_bookings
	)
	UNION ALL 
	(
	SELECT 
		room_name, 
		start_time,
		end_time
	FROM
		room_bookings
	)
	ORDER BY 
		room_name,
		start_time
), 
consecutive_times AS (
	SELECT
		room_name, 
		start_time,
		end_time, 
		lEAD(start_time, 1) OVER (PARTITION BY room_name ORDER BY start_time) AS next_start_time
	FROM
		default_times
)
SELECT
	room_name, 
	start_time AS gap_start,
	end_time AS gap_end, 
	TIMESTAMPDIFF(MINUTE, end_time, next_start_time) AS gap_duration_minutes
FROM	
 	consecutive_times
 WHERE 
 	TIMESTAMPDIFF(MINUTE, end_time, next_start_time) >= 60;
```
