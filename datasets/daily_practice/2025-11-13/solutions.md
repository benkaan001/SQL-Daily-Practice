## Puzzle: The Consecutive Workout Streak

**The Scenario:** As a data analyst for a fitness app, you need to identify the most consistent users. The marketing team wants to send rewards to any user who has a "workout streak" of 3 or more consecutive days.

**Your Task:** Write a query to find all workout streaks of 3 or more days. A "workout day" is any calendar day where a user has at least one `COMPLETED_WORKOUT` event. The report should show the `user_id`, the `streak_start_date` (the first day of the streak), the `streak_end_date` (the last day of the streak), and the `consecutive_days` in the streak.

| user_id | streak_start_date | streak_end_date | consecutive_days |
| ------- | ----------------- | --------------- | ---------------- |
| 101     | 2023-11-01        | 2023-11-03      | 3                |
| 101     | 2023-11-10        | 2023-11-12      | 3                |
| 102     | 2023-11-05        | 2023-11-08      | 4                |

### Tips for Approaching the Problem

1. **Find Workout Days:** First, you need a list of the unique days each user completed a workout. Use `SELECT DISTINCT user_id, DATE(event_timestamp) AS workout_date` from the table, filtering for `event_type = 'COMPLETED_WORKOUT'`.
2. **Identify Gaps and Islands:** This is a classic "gaps and islands" problem. To find consecutive days, you need to create a grouping ID for each streak. A common way to do this is:
   * Use `ROW_NUMBER()` to create a sequential number for each user's workout days, ordered by date. (`ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY workout_date)`)
   * Subtract this row number (as days) from the `workout_date`. For example, `DATE_SUB(workout_date, INTERVAL row_num DAY)`.
   * This calculation will result in a constant date for all days in a single consecutive streak. This constant date is your `streak_group_id`.
3. **Aggregate by Streak:** Now that you have a `streak_group_id` for each workout day, you can `GROUP BY user_id, streak_group_id`.
4. **Calculate Streak Details:** In your `SELECT` statement, you can now:
   * Find the `MIN(workout_date)` to get the `streak_start_date`.
   * Find the `MAX(workout_date)` to get the `streak_end_date`.
   * Use `COUNT(*)` to get the `consecutive_days`.
5. **Final Filtering:** Use a `HAVING` clause to keep only the groups where `COUNT(*) >= 3`.

**Your Solution:**

```sql
WITH workout_days AS (
	SELECT DISTINCT
		user_id,
		DATE(event_timestamp) AS event_date,
		ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY DATE(event_timestamp)) AS rn
	FROM
		fitness_activity_logs
	WHERE
		event_type = 'COMPLETED_WORKOUT'
),
streak_groups AS (
	SELECT
		user_id,
		event_date,
		DATE_SUB(event_date, INTERVAL rn DAY) AS streak_group_id
	FROM
		workout_days
)
SELECT
	user_id,
	MIN(event_date) AS streak_start_date,
	MAX(event_date) AS streak_end_date,
	COUNT(*) AS consecutive_days
FROM
	streak_groups
GROUP BY
	user_id,
	streak_group_id
HAVING
	COUNT(streak_group_id) >= 3;
```