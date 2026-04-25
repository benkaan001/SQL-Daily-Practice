## Puzzle: The "Current Streak" Calculator

**The Scenario:** A popular language-learning app prominently displays a "Daily Streak" on the user's dashboard to encourage consistent engagement. A streak is the number of consecutive calendar days a user has logged in, leading directly up to today.

**Your Task:** Write a query to calculate the *current* active streak for every user in the database as of the target date:  **'2026-04-25'** .

**Rules:**

1. A streak counts backwards continuously from the target date ('2026-04-25').
2. If a user did *not* log in on the target date, their current streak is broken and evaluating to `0`.
3. Multiple logins on the same calendar day only count as `1` streak day.

The final report should show the `user_id` and the `current_streak`. Order the results by `current_streak` in descending order, then by `user_id` in ascending order.

**Expected Output:**

| **user_id** | **current_streak** |
| ----------------- | ------------------------ |
| 101               | 5                        |
| 102               | 2                        |
| 104               | 1                        |
| 103               | 0                        |
| 105               | 0                        |

*(Note: User 103 had a 3-day streak from the 22nd to the 24th, but because they missed the 25th, their current streak is 0).*

### Tips for Approaching the Problem

This is a brilliant variation of the "Gaps and Islands" problem. Instead of finding *all* streaks, you only want to validate the streak tethered to the target date!

1. **Deduplicate Logins:** Start by creating a Common Table Expression (CTE) that formats the `login_timestamp` into a `DATE` and selects `DISTINCT user_id, login_date`.
2. **Rank Backwards:** In a second CTE, apply a `DENSE_RANK()` window function to your deduplicated dates, partitioned by `user_id` and ordered by `login_date DESC`. This assigns `1` to their most recent login, `2` to the one before that, etc.
3. **The Magic Equation:** You can determine if a login date is part of the *current, unbroken streak* using a simple mathematical test.
   * If a user logged in on the 25th (target date), the `DATEDIFF('2026-04-25', login_date)` is `0`, and its rank is `1`. (`0 == 1 - 1`).
   * If they logged in on the 24th, the diff is `1`, and its rank is `2`. (`1 == 2 - 1`).
   * **The Rule:** Filter your ranked dates so you only keep rows where `DATEDIFF('2026-04-25', login_date) = reverse_rank - 1`. The moment a user misses a day, this equation breaks for all older dates!
4. **Join and Aggregate:** To ensure users with a streak of `0` (like User 103 and 105) don't vanish from the report, query a distinct list of all `user_id`s from the raw table. `LEFT JOIN` this list to the filtered valid streak days from Step 3, and `COUNT()` the matches.

**Your Solution:**

```sql
-- Write your solution here
```
