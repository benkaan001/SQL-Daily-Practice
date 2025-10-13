## Puzzle: The Weekly Power User Report

**The Scenario:** As a product analyst, you need to identify your "power users" on a weekly basis. This helps the marketing team target them for testimonials or loyalty programs.

**Your Task:** Write a query that identifies all "power users" for each week. A power user is defined as a user who meets both of the following criteria *within a single calendar week* (Monday to Sunday):

1. They had more than 5 sessions.
2. Their average session duration was over 30 minutes.

The final report should show the `week_start_date` (the Monday of the week), the `user_id` of the power user, their total `session_count` for that week, and their `avg_duration_minutes` (rounded to two decimal places).

| **week_start_date** | **user_id** | **session_count** | **avg_duration_minutes** |
| ------------------------- | ----------------- | ----------------------- | ------------------------------ |
| 2023-10-02                | 101               | 6                       | 50.00                          |
| 2023-10-09                | 104               | 6                       | 47.50                          |

### Tips for Approaching the Problem

1. **Group by Week:** The first step is to group sessions into calendar weeks for each user. A function like `YEARWEEK(session_start, 1)` (where `1` signifies weeks starting on Monday) is perfect for this. You'll also need to calculate the start date of that week.
2. **Calculate Session Duration:** For each session, calculate its duration in minutes. A function like `TIMESTAMPDIFF(MINUTE, session_start, session_end)` will be useful here. It's best to do this in a preliminary CTE.
3. **Perform Weekly Aggregation:** In a new CTE, `GROUP BY` the `user_id` and the calculated week identifier. In this step, you can calculate the two key metrics:
   * `COUNT(*)` to get the weekly `session_count`.
   * `AVG(duration_minutes)` to get the `avg_duration_minutes`.
4. **Final Filtering:** In your final `SELECT` statement, query from the CTE where you calculated the weekly aggregates. Apply a `WHERE` clause to filter for only those rows that meet the power user criteria: `session_count > 5` AND `avg_duration_minutes > 30`.

**Your Solution:**

```sql
-- Write your solution here
```
