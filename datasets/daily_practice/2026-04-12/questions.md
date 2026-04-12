## Puzzle: The "Unbroken Growth" Streak

**The Scenario:** The VP of Sales wants to implement a new bonus program called the "Unbroken Growth Bonus." To qualify, a sales representative must increase their daily revenue for at least  **4 consecutive calendar days** .

This means the revenue on Day 2 must be strictly greater than Day 1, Day 3 > Day 2, and Day 4 > Day 3. If they tie their previous day's revenue, or if they miss a day of work, the streak is broken and resets to 1.

**Your Task:** Write a query to identify all sales reps who have achieved an "Unbroken Growth" streak of **4 or more** days.

The final report should show the `rep_id`, the `streak_start_date`, the `streak_end_date`, and the `streak_length_days`. Order the results by `streak_length_days` descending, then by `rep_id`.

**Expected Output:**

| **rep_id** | **streak_start_date** | **streak_end_date** | **streak_length_days** |

| 102 | 2026-04-01 | 2026-04-05 | 5 |

| 101 | 2026-04-01 | 2026-04-04 | 4 |

*(Note: Rep 103 is excluded because a flat day broke their streak. Rep 104 is excluded because taking April 3rd off broke their consecutive calendar day streak).*

### Tips for Approaching the Problem

This puzzle uses a brilliant variation of the "Gaps and Islands" technique. Instead of grouping by matching dates, you group by checking if a streak  *failed* .

1. **Look Back:** First, use the `LAG()` window function to peek at the previous day's `sale_date` and `revenue` for each rep.
2. **The "Streak Breaker" Flag:** In a CTE, create a new column called `is_streak_breaker`. This flag should evaluate to `1` if a new streak is starting, and `0` if the current streak is successfully continuing.
   A streak is BROKEN (so the flag = 1) if:
   * The previous revenue is `NULL` (it's their first day).
   * The current revenue is `<=` the previous revenue (it didn't strictly increase).
   * The time difference between the current date and the previous date is `> 1` day (they skipped a calendar day). You can check this using `DATEDIFF(sale_date, prev_sale_date)`.
3. **Generate the Island ID:** Now for the magic: take a running cumulative sum of your `is_streak_breaker` flag, partitioned by `rep_id` and ordered by `sale_date`. Because the flag is `0` during a valid streak, the running sum will remain a constant number for the entire duration of the growth streak! This becomes your unique `streak_id`.
4. **Aggregate and Filter:** In your final `SELECT` statement, `GROUP BY rep_id` and your calculated `streak_id`. Find the `MIN(sale_date)` and `MAX(sale_date)`, and count the rows to get the length. Use a `HAVING` clause to filter for streaks `>= 4`.

**Your Solution:**

```sql
-- Write your solution here
```
