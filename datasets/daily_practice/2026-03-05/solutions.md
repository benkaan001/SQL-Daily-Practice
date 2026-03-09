## Puzzle: The E-commerce Drop-Off Funnel

**The Scenario:** The product management team is trying to understand where users are abandoning their purchase journey on the website. They have asked you to build a conversion funnel report that calculates the drop-off rate from one stage to the next.

**Your Task:** Write a query that calculates the number of unique sessions that reached each stage of the funnel, and the percentage drop-off from the *immediately preceding* stage.

The funnel order is strictly:

1. `PAGE_VIEW`
2. `ADD_TO_CART`
3. `CHECKOUT`
4. `PURCHASE`

The final report should show the `step_number` (1 through 4), the `stage_name` (the `event_name`), the `session_count` (unique sessions that reached this stage), and the `drop_off_pct` (rounded to 2 decimal places). The drop-off percentage for the first step should be `0.00`.

**Expected Output:**

| **step_number** | **stage_name** | **session_count** | **drop_off_pct** |
| --------------------- | -------------------- | ----------------------- | ---------------------- |
| 1                     | PAGE_VIEW            | 6                       | 0.00                   |
| 2                     | ADD_TO_CART          | 5                       | 16.67                  |
| 3                     | CHECKOUT             | 3                       | 40.00                  |
| 4                     | PURCHASE             | 2                       | 33.33                  |

### Tips for Approaching the Problem

1. **Assign Step Numbers:** The `event_name` strings don't alphabetize into the correct funnel order. In your first CTE, map each `event_name` to its corresponding `step_number` (1, 2, 3, or 4) using a `CASE` statement.
2. **Calculate Session Counts:** Group by your new `step_number` and `event_name` to calculate the `COUNT(DISTINCT session_id)`. This will give you the total volume reaching each stage.
3. **Fetch the Previous Stage Count:** In a new CTE, use the `LAG(session_count, 1) OVER (ORDER BY step_number)` window function to pull the count from the preceding stage down into the current row.
4. **Calculate the Drop-off Percentage:** Use the formula `((previous_count - current_count) / previous_count) * 100.0`. Wrap it in a `COALESCE` or `IFNULL` to handle the very first row where `previous_count` will be `NULL` so it outputs `0.00`.

**Your Solution:**

```sql
-- Write your solution here
```
