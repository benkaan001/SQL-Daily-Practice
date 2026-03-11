## Puzzle: The "A + B - C" Cross-Sell Target

**The Scenario:** The marketing team at a grocery delivery app is running a targeted promotion for a new brand of premium guacamole. They want to send a high-value discount code, but only to the perfect audience. The ideal audience consists of customers who demonstrate a clear preference for Mexican snacks but haven't yet discovered the app's guacamole selection.

**Your Task:** Write a query to find all `customer_id`s who meet **all** of the following criteria across their entire purchase history:

1. They have purchased **'Tortilla Chips'** at least once.
2. They have purchased **'Salsa'** at least once.
3. They have **NEVER** purchased  **'Guacamole'** .

To help the marketing team time the email, your report should also include the `last_trigger_purchase_date`, which is the most recent date the customer bought *either* 'Tortilla Chips' or 'Salsa'.

Order the results by the `last_trigger_purchase_date` descending.

**Expected Output:**

| **customer_id** | **last_trigger_purchase_date** |
| --------------------- | ------------------------------------ |
| 105                   | 2026-03-01                           |
| 102                   | 2026-02-05                           |

### Tips for Approaching the Problem

There are two primary ways to solve this: the `EXISTS`/`NOT EXISTS` approach, and the `GROUP BY` with `HAVING` approach. The `GROUP BY` approach is often cleaner and easier to read for this specific pattern.

1. **The Conditional Aggregation Approach:** Group your data by `customer_id`.
2. **Count the Occurrences:** Inside a `HAVING` clause, you can use conditional aggregation (`SUM(CASE WHEN ... THEN 1 ELSE 0 END)`) to count how many times a user bought specific items.
3. **Apply the Rules:** Your `HAVING` clause should check that the sum for Tortilla Chips is `> 0`, the sum for Salsa is `> 0`, and the sum for Guacamole is exactly `= 0`.
4. **Find the Last Purchase Date:** In your `SELECT` clause, use a similar `MAX(CASE WHEN ... END)` statement to find the highest date where the product was either Chips or Salsa.

**Your Solution:**

```sql
WITH purhcase_counts AS (
	SELECT 
		customer_id,
		SUM(CASE WHEN product_name = 'Tortilla Chips' THEN 1 ELSE 0 END) AS tortilla_purchase_count,
		SUM(CASE WHEN product_name = 'Salsa' THEN 1 ELSE 0 END) AS salsa_purchase_count,
		SUM(CASE WHEN product_name = 'Guacamole' THEN 1 ELSE 0 END) AS guac_purchase_count,
		MAX(CASE WHEN product_name IN ('Tortilla Chips', 'Salsa') THEN purchase_date END) AS last_trigger_purchase_date
	FROM 
		customer_purchases
	GROUP BY 
		customer_id
)
SELECT 
	customer_id,
	last_trigger_purchase_date 
FROM
	purhcase_counts
WHERE
	tortilla_purchase_count > 0
	AND salsa_purchase_count > 0
	AND guac_purchase_count = 0;
```
