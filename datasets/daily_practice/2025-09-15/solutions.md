## Puzzle: The Power User Streak

**The Scenario:** The product team wants to identify "power users" by finding who has the most consistent engagement with the application. A key metric for this is a user's longest continuous streak of daily activity.

**Your Task:** Write a query to find the longest continuous streak of days that each user was active. A "streak" is defined as a sequence of consecutive calendar days where the user had at least one event in the `feature_usage` table.

The final report should show the `user_id`, their `longest_streak_days`, the `streak_start_date`, and the `streak_end_date` for that longest streak. If a user has multiple streaks of the same maximum length, the most recent one should be reported.

| **user_id** | **longest_streak_days** | **streak_start_date** | **streak_end_date** |
| ----------------- | ----------------------------- | --------------------------- | ------------------------- |
| 101               | 3                             | 2023-09-01                  | 2023-09-03                |
| 102               | 5                             | 2023-09-01                  | 2023-09-05                |
| 103               | 1                             | 2023-09-10                  | 2023-09-10                |
| 104               | 3                             | 2023-09-08                  | 2023-09-10                |

**Your Solution:**

```sql
-- Write your solution here
```
