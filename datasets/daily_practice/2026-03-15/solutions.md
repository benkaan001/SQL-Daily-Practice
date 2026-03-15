## Puzzle: The Pareto Principle (80/20 Rule)

**The Scenario:** The merchandising team wants to focus their marketing budget on "A-Tier" products. They define "A-Tier" products using the Pareto Principle: the top-selling items that collectively account for at least **80%** of the company's total revenue.

**Your Task:** Write a query to identify these top revenue-driving products. Order the products from highest revenue to lowest, and calculate a running cumulative percentage of total revenue.

You must include all products up to and including the *first* product that pushes the cumulative percentage over the 80% threshold.

The report should show the `product_name`, the individual `revenue`, the `running_revenue`, and the `running_percentage` (rounded to 2 decimal places).

**Expected Output:**

| **product_name**   | **revenue** | **running_revenue** | **running_percentage** |

| ------------------------ | ----------------- | ------------------------- | ---------------------------- |

| Laptop Pro Max           | 4500.00           | 4500.00                   | 45.00                        |

| Smartphone X1            | 3000.00           | 7500.00                   | 75.00                        |

| Noise Cancelling Earbuds | 1000.00           | 8500.00                   | 85.00                        |

*(Notice that the Earbuds are included because prior to adding them, the cumulative percentage was only 75%. Adding them brings the total to 85%, successfully crossing the threshold).*

### Tips for Approaching the Problem

1.**Calculate the Grand Total:** You need the denominator to calculate percentages. You can easily attach the grand total to every row without a `GROUP BY` by using an empty window function: `SUM(revenue) OVER ()`.

2.**Calculate the Running Total:** To get the numerator, you need a cumulative sum ordered by revenue. Use `SUM(revenue) OVER (ORDER BY revenue DESC)`.

3.**Calculate the Percentage:** In a Common Table Expression (CTE), combine these concepts to calculate your `running_percentage`: `(running_total / grand_total) * 100.0`.

4.**The Threshold Catch (The tricky part!):** If you simply write `WHERE running_percentage <= 80` in your final query, your report will stop at 'Smartphone X1' (75%) and *miss* the Earbuds that push it over the line to 85%.

5.**Use LAG to Look Back:** To solve the threshold catch, use the `LAG()` window function in your CTE to look at the `running_percentage` of the *previous* row. Let's call it `previous_percentage`. For the very first row, `LAG()` will be NULL, so use `COALESCE(..., 0)`.

6.**Final Filter:** In your final `SELECT`, filter where `previous_percentage < 80`. This brilliant trick ensures you include the product that tipped the scale, but stop immediately after!

**Your Solution:**

```sql

-- Write your solution here

```
