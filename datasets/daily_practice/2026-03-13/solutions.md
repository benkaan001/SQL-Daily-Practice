## Puzzle: The Rolling 7-Day Active Users (WAU)

**The Scenario:** The Growth and Product teams closely monitor the platform's Weekly Active Users (WAU). However, they don't just want a single number at the end of the week. They want a  **daily rolling report** .

For any given day, the "7-Day Active Users" metric counts the number of unique users who were active on that specific day *or* any of the 6 preceding days.

**Your Task:** Write a query to calculate the rolling 7-day WAU for every date between  **'2026-03-07' and '2026-03-13'** .

The final report should show the `target_date` and the `rolling_7_day_active_users` count. Order the results chronologically.

**Expected Output:**

| **target_date** | **rolling_7_day_active_users** |
| --------------------- | ------------------------------------ |
| 2026-03-07            | 5                                    |
| 2026-03-08            | 5                                    |
| 2026-03-09            | 5                                    |
| 2026-03-10            | 6                                    |
| 2026-03-11            | 6                                    |
| 2026-03-12            | 6                                    |
| 2026-03-13            | 7                                    |

### Tips for Approaching the Problem

This is a classic non-equi join (or theta join) problem. Standard `GROUP BY` won't work easily because a single user's activity on March 1st needs to be counted in the totals for March 1st, March 2nd, March 3rd, etc., all the way up to March 7th.

1. **Create a Target Dates List:** First, you need a clean list of the dates you are reporting on. Create a Common Table Expression (CTE) that selects the distinct `activity_date`s from the table where the date is `>= '2026-03-07'`. Let's call the column in this CTE `target_date`.
2. **The Non-Equi Join:** In your main query, `SELECT` from your new target dates CTE. Then, `LEFT JOIN` the original `app_activity` table.
3. **The Rolling Window Condition:** Instead of joining on an exact match (e.g., `a.date = b.date`), join based on a date range! The join condition should require that the user's `activity_date` is less than or equal to the `target_date`, AND greater than or equal to the `target_date` minus 6 days.
   * *MySQL Syntax Hint:* `a.activity_date BETWEEN DATE_SUB(d.target_date, INTERVAL 6 DAY) AND d.target_date`
4. **Count Distinct Users:** Finally, `GROUP BY` your `target_date` and calculate the `COUNT(DISTINCT user_id)` from the joined activity table.

**Your Solution:**

```sql
WITH target_dates AS (
	SELECT DISTINCT
		activity_date AS target_date
	FROM
		app_activity
	WHERE
		activity_date >= '2026-03-07'
)
SELECT 
	td.target_date,
	COUNT(DISTINCT aa.user_id) AS rolling_7_day_active_users
FROM
	target_dates td
LEFT JOIN 
	app_activity aa ON aa.activity_date BETWEEN DATE_SUB(td.target_date, INTERVAL 6 DAY) AND td.target_date 
GROUP BY 
	td.target_date;
```
