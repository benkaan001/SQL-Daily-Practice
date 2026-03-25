## Puzzle: Month-over-Month (MoM) Revenue Growth

**The Scenario:** The Finance team is preparing their Q1 performance review. They need a report that shows exactly how each product category's revenue is trending from month to month.

**Your Task:** Write a query to calculate the total monthly revenue and the Month-over-Month (MoM) percentage growth for each `category`.

The final report should show the `category`, the `sales_month` (formatted as 'YYYY-MM'), the `current_revenue`, the `prev_month_revenue`, and the `growth_pct`.

*Rules:*

1. The `growth_pct` should be calculated as `((current - previous) / previous) * 100`.
2. Round the `current_revenue`, `prev_month_revenue`, and `growth_pct` to 2 decimal places.
3. If a category has no previous month of data (i.e., it's their first month of sales in the dataset), the `prev_month_revenue` and `growth_pct` should be `NULL`.
4. Order the results alphabetically by `category`, then chronologically by `sales_month`.

**Expected Output:**

| **category** | **sales_month** | **current_revenue** | **prev_month_revenue** | **growth_pct** |
| ------------------ | --------------------- | ------------------------- | ---------------------------- | -------------------- |
| Apparel            | 2026-01               | 500.00                    | NULL                         | NULL                 |
| Apparel            | 2026-02               | 500.00                    | 500.00                       | 0.00                 |
| Apparel            | 2026-03               | 750.00                    | 500.00                       | 50.00                |
| Electronics        | 2026-01               | 1000.00                   | NULL                         | NULL                 |
| Electronics        | 2026-02               | 1200.00                   | 1000.00                      | 20.00                |
| Electronics        | 2026-03               | 900.00                    | 1200.00                      | -25.00               |
| Home Goods         | 2026-02               | 400.00                    | NULL                         | NULL                 |
| Home Goods         | 2026-03               | 500.00                    | 400.00                       | 25.00                |

### Tips for Approaching the Problem

1. **Aggregate to the Monthly Level:** Your raw data has multiple transactions per month. In a Common Table Expression (CTE), use `DATE_FORMAT(sale_date, '%Y-%m')` and `SUM(amount)` to get the total revenue grouped by category and month.
2. **Look Back in Time:** Once you have the aggregated monthly totals, you can use the `LAG()` window function to pull the previous month's revenue into the current row. Remember to `PARTITION BY category` so you only compare a category against its own history, and `ORDER BY sales_month`.
3. **Calculate the Growth:** In your final `SELECT` statement, apply the percentage change formula using the current and previous revenue columns.

**Your Solution:**

```sql
WITH category_monthly_revenues AS (
	SELECT 
		category, 
		DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,  
		SUM(amount) AS current_revenue
	FROM
		category_sales
	GROUP BY 
		category, 
		DATE_FORMAT(sale_date, '%Y-%m')
),
previous_month_revenues AS (
	SELECT 
		category, 
		sales_month, 
		current_revenue,
		LAG(current_revenue, 1) OVER (PARTITION BY category ORDER BY sales_month) AS prev_month_revenue
	FROM
		category_monthly_revenues 
)
SELECT 
	category, 
	sales_month, 
	current_revenue, 
	prev_month_revenue,
	ROUND(((current_revenue - prev_month_revenue) / prev_month_revenue ) * 100, 2) AS growth_pct
FROM
	previous_month_revenues 
ORDER BY 
	category, 
	sales_month;
```
