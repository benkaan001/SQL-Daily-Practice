## Puzzle: The Commission Unlock Date

**The Scenario:** In the sales department, representatives unlock their commission payout only after they have successfully met their monthly sales quota. As a compensation analyst, you need to determine the exact date each representative unlocked their commission for February 2026.

**Your Task:** Write a query to find the "Attainment Date" for each sales rep. The attainment date is defined as the exact `sale_date` when a representative's cumulative (running total) sales for the month first equaled or exceeded their `quota_amount`.

The report should show the `rep_id`, their `quota_amount`, and the `attainment_date`. Exclude any representatives who did not meet their quota.

| **rep_id** | **quota_amount** | **attainment_date** |
| ---------------- | ---------------------- | ------------------------- |
| 101              | 5000.00                | 2026-02-15                |
| 102              | 8000.00                | 2026-02-25                |
| 104              | 2000.00                | 2026-02-02                |

### Tips for Approaching the Problem

1. **Running Total:** Start by calculating the cumulative sum of sales for each representative across the month. You can use the `SUM(sale_amount) OVER (PARTITION BY rep_id ORDER BY sale_date)` window function.
2. **Join with Targets:** Join this resulting data with the `sales_quotas` table using the `rep_id`. (Since all data is for February 2026, you don't strictly need to join on the month, but it's best practice).
3. **Filter for Success:** Filter your results to only include rows where the `running_total >= quota_amount`.
4. **Find the First Instance:** Since a rep's running total will continue to exceed the quota on subsequent sales, you will have multiple rows for successful reps. You need to isolate the *earliest* date. You can do this by grouping by `rep_id` and selecting the `MIN(sale_date)`, or by using `ROW_NUMBER()` in an additional CTE.

**Your Solution:**

```sql
-- Write your solution here

```
