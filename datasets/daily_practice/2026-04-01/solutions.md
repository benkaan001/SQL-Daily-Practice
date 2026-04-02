## Puzzle: The April Fools' Price Glitch

**The Scenario:** On the morning of April 1st, a rogue snippet of code meant for a harmless internal prank accidentally leaked into the production checkout system. For a brief window, it randomly applied a massive 99% discount to several orders! The Finance team is panicking and needs an immediate audit of the damage.

**Your Task:** Write a query to identify all orders affected by the "April Fools' Glitch." An order is considered glitched if the `price_paid` is exactly **1%** of the product's `standard_price`.

For each glitched order, you must also calculate the total `lost_revenue` (the difference between the standard price and the price actually paid).

The report should show the `order_id`, `product_name`, `standard_price`, `price_paid`, and `lost_revenue`. Order the results by the `lost_revenue` in descending order so the finance team can prioritize the biggest losses.

**Expected Output:**

| **order_id** | **product_name** | **standard_price** | **price_paid** | **lost_revenue** |

| 4 | Ultra-Wide Monitor | 400.00 | 4.00 | 396.00 |

| 5 | Ergonomic Chair | 250.00 | 2.50 | 247.50 |

| 6 | Mechanical Keyboard | 150.00 | 1.50 | 148.50 |

### Tips for Approaching the Problem

1. **Join the Truth to the Log:** To determine if a price is wrong, you need to compare it to the source of truth. `JOIN` the `april_orders` table to the `catalog_prices` table using `product_id`.
2. **Filter for the Prank:** In your `WHERE` clause, apply the mathematical condition for the glitch. You need to check if the `price_paid` is equal to `standard_price * 0.01`.
   *(Pro-tip: Because dealing with floating-point decimals in SQL can occasionally be finicky, using `ROUND(standard_price * 0.01, 2)` or checking `standard_price * 0.01` directly will work perfectly for this cleanly mocked data).*
3. **Calculate the Loss:** In your `SELECT` statement, simply subtract the `price_paid` from the `standard_price` to generate your `lost_revenue` column.

**Your Solution:**

```sql
SELECT 	
	ao.order_id, 
	cp.product_name,
	cp.standard_price,
	ao.order_timestamp,
	ao.price_paid,
	(cp.standard_price - ao.price_paid) AS lost_revenue
FROM
	april_orders ao 
JOIN
	catalog_prices cp ON ao.product_id = cp.product_id 
WHERE
	ao.price_paid = cp.standard_price * 0.01
ORDER BY
	lost_revenue DESC;
```

