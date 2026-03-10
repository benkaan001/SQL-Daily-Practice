## Puzzle: The Daily "New vs. Returning" Split

**The Scenario:** The Growth and Marketing teams want to track the daily composition of the active customer base. They need to know how much of the daily traffic is driven by fresh acquisitions versus retained users coming back to buy again.

**Your Task:** Write a query that generates a daily summary report. For every `purchase_date` in the dataset, calculate:

1. `total_active_customers`: The count of unique customers who made a purchase that day.
2. `new_customers`: The count of unique customers whose *very first* lifetime purchase occurred on that day.
3. `returning_customers`: The count of unique customers who made a purchase that day, but already had a prior purchase on an earlier date.
4. `total_revenue`: The total sum of `purchase_amount` for that day.

Order the final report chronologically by `purchase_date`.

**Expected Output:**

| **purchase_date** | **total_active_customers** | **new_customers** | **returning_customers** | **total_revenue** |
| ----------------------- | -------------------------------- | ----------------------- | ----------------------------- | ----------------------- |
| 2026-03-01              | 3                                | 3                       | 0                             | 275.00                  |
| 2026-03-02              | 3                                | 1                       | 2                             | 190.00                  |
| 2026-03-03              | 2                                | 2                       | 0                             | 40.00                   |
| 2026-03-04              | 3                                | 0                       | 3                             | 190.00                  |

### Tips for Approaching the Problem

1. **Find the "Cohort" Date:** First, determine the initial acquisition date for every customer. Create a Common Table Expression (CTE) that calculates the `MIN(purchase_date)` for each `customer_id`. Let's call this the `first_purchase_date`.
2. **Join the Data:** In your main query, `JOIN` the original `customer_purchases` table to your new CTE on the `customer_id`. This allows you to compare the current transaction's date against that customer's historical first purchase date.
3. **Conditional Counting (Pivot):** Now, group your results by `cp.purchase_date`. Use conditional aggregation to bucket the unique customers:

   * **New:** Use `COUNT(DISTINCT CASE WHEN cp.purchase_date = cf.first_purchase_date THEN cp.customer_id END)`
   * **Returning:** Use `COUNT(DISTINCT CASE WHEN cp.purchase_date > cf.first_purchase_date THEN cp.customer_id END)`

   *(Note: The `DISTINCT` is crucial! A new customer might make 5 purchases on their first day, but they should still only count as ONE new customer for that date.)*
4. **Aggregate the Rest:** Finish the query by adding `COUNT(DISTINCT cp.customer_id)` for total active customers and `SUM(cp.purchase_amount)` for revenue.

**Your Solution:**

```sql
-- Write your solution here
```
