## Puzzle: The 3-Day Posting Streak

**The Scenario:** To increase engagement, the platform wants to award a "Consistency Badge" to users who post content for at least  **3 consecutive days** .

**Your Task:** Write a query to identify users who have achieved a 3-day consecutive posting streak.

The report should return the `user_id`, the `streak_start_date`, and the `streak_end_date`.

| **user_id** | **streak_start_date** | **streak_end_date** |
| ----------------- | --------------------------- | ------------------------- |
| 101               | 2023-12-01                  | 2023-12-03                |

### Tips for Approaching the Problem

1. **Date Math:** Use the `DATE_SUB` / `ROW_NUMBER` trick (Gaps and Islands).
2. **Grouping:** Calculate `group_id = post_date - INTERVAL ROW_NUMBER() DAY`.
3. **Aggregate:** Group by user and `group_id`, then filter `HAVING COUNT(*) >= 3`.

**Your Solution:**

```sql
-- Write your solution here
```
