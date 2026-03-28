## Puzzle: The Historical Pricing Audit ("As-Of" Join)

**The Scenario:** The finance team is performing an audit on Q1 revenue. Unfortunately, the legacy Point-of-Sale system only recorded the `product_id` and `quantity` for each sale, omitting the actual price charged! To calculate the revenue, you must cross-reference the `product_sales` table with the `price_history` ledger to find the exact price that was active on the day the sale occurred.

**Your Task:** Write a query to calculate the `total_revenue` for each individual sale.

The report should show the `sale_id`, `product_id`, `sale_date`, the matched `historical_price`, the `quantity`, and the calculated `total_revenue` (`historical_price * quantity`). Order the results by `sale_id` ascending.

**Expected Output:**

| **sale_id** | **product_id** | **sale_date** | **historical_price** | **quantity** | **total_revenue** |
| ----------------- | -------------------- | ------------------- | -------------------------- | ------------------ | ----------------------- |
| 1                 | 101                  | 2026-02-15          | 10.00                      | 5                  | 50.00                   |
| 2                 | 101                  | 2026-03-10          | 12.00                      | 2                  | 24.00                   |
| 3                 | 101                  | 2026-03-25          | 11.00                      | 4                  | 44.00                   |
| 4                 | 102                  | 2026-03-01          | 50.00                      | 1                  | 50.00                   |
| 5                 | 102                  | 2026-03-15          | 45.00                      | 2                  | 90.00                   |

### Tips for Approaching the Problem

There are two common ways to perform this "As-Of" join: the `LEAD()` approach and the `ROW_NUMBER()` approach.

**Approach 1: Building Lifespans with `LEAD()` (Recommended)**

1. **Define the Price Window:** In a Common Table Expression (CTE), query the `price_history` table. Use the `LEAD(effective_date)` window function (partitioned by `product_id` and ordered by `effective_date`) to attach the *next* price change date to the current row. This essentially gives every price a `start_date` and an `end_date`.
2. **Handle the Current Price:** For the most recent price of a product, the `LEAD()` function will return `NULL`. Use `COALESCE()` to replace this `NULL` with a far-future date (e.g., '9999-12-31') so the logic doesn't break.
3. **The Theta Join:** Join the `product_sales` table to your new CTE. The join condition should be `sales.product_id = history.product_id` AND the `sale_date` falls `>=` the price's start date and `<` the price's end date.

**Approach 2: Ranking with `ROW_NUMBER()`**

1. **Join and Filter First:** Join `product_sales` to `price_history` on `product_id`, adding a condition that `price_history.effective_date <= product_sales.sale_date`. This will attach *every* past price to the sale.
2. **Rank the Past Prices:** In a CTE, use `ROW_NUMBER() OVER (PARTITION BY sale_id ORDER BY effective_date DESC)` to rank these matched prices. The price with rank `1` is the most recent price prior to the sale!
3. **Filter and Calculate:** Select from the CTE where the rank is `1`, and calculate your revenue.

**Your Solution:**

```sql
-- Write your solution here
```
