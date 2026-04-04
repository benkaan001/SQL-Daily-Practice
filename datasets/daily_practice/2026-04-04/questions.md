## Puzzle: The Cumulative Unique User Growth

**The Scenario:** The product team just launched a new app on April 1st. The CEO wants a daily dashboard showing the growth of the overall user base. They want to see the number of brand new users acquired each day, and the **cumulative total of unique users** who have ever tried the app up to that day.

**Your Task:** Write a query to calculate the daily new users and the running total of unique users.

*The Catch:* You might be tempted to use `COUNT(DISTINCT user_id) OVER (ORDER BY session_date)`. However, many SQL engines (including MySQL) **do not support** `DISTINCT` inside window functions! You must find a mathematical workaround.

The final report should show the `session_date`, the `daily_new_users` acquired on that day, and the `cumulative_unique_users` up to and including that day. Order the results chronologically.

**Expected Output:**

| **session_date** | **daily_new_users** | **cumulative_unique_users** |
| ---------------------- | ------------------------- | --------------------------------- |
| 2026-04-01             | 3                         | 3                                 |
| 2026-04-02             | 1                         | 4                                 |
| 2026-04-03             | 0                         | 4                                 |
| 2026-04-04             | 2                         | 6                                 |

### Tips for Approaching the Problem

This puzzle requires the "First Appearance" pattern. If you only count a user on the very first day they appear, a simple running sum of that count will naturally equal the cumulative unique users!

1. **Get All Dates:** First, you need a continuous list of all the dates the app was active. Create a Common Table Expression (CTE) that simply selects `DISTINCT session_date` from the table.
2. **Find the "Firsts":** Create a second CTE that groups the original table by `user_id` to find each user's `MIN(session_date)`. This isolates the exact day they were acquired.
3. **Count Daily New Users:** Create a third CTE that groups your "Firsts" CTE by that minimum date, counting how many users share the same acquisition date. This gives you the `daily_new_users`.
4. **Join and Handle Missing Days:** `LEFT JOIN` your master list of dates (from step 1) to your daily new users count (from step 3). *Why? Look at April 3rd!* There were 0 new users that day. If you don't join against the master date list, April 3rd will completely disappear from your report! Use `COALESCE` to turn `NULL` new user counts into `0`.
5. **The Running Total:** In your final `SELECT` statement, you can now use a standard window function: `SUM(daily_new_users) OVER (ORDER BY session_date)` to calculate the `cumulative_unique_users`.

**Your Solution:**

```sql
-- Write your solution here
```
