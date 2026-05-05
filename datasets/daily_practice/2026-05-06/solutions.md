## Puzzle: The Predictive Restock Alert

**The Scenario:** To prevent delays, the warehouse uses a "safety stock" threshold. When a product's inventory drops below this number, a reorder must be triggered immediately. As a data analyst, you have access to current inventory levels and all scheduled outgoing orders for the next week. The operations manager needs a report that predicts exactly *when* products will hit critical levels so they can order supplies proactively.

**Your Task:** Write a query to predict the exact date each product will breach its safety stock threshold.

A product breaches its threshold on the day its `projected_stock` (which is `current_stock` minus the cumulative sum of all `quantity` dispatched up to and including that day) falls strictly below its `safety_stock_threshold`.

The final report should show the `product_name`, the `current_stock`, the `safety_stock_threshold`, the `breach_date` (the *first* date the threshold is breached), and the `projected_stock` on that specific date. Exclude any products that do not breach their threshold. Order the results chronologically by the `breach_date`.

**Expected Output:**

| **product_name** | **current_stock** | **safety_stock_threshold** | **breach_date** | **projected_stock** |

| Laptop Stand | 200 | 50 | 2026-05-06 | 40 |

| Wireless Mouse | 80 | 15 | 2026-05-10 | 10 |

| Ergonomic Keyboard | 150 | 30 | 2026-05-11 | 20 |

### Tips for Approaching the Problem

1. **Calculate the Running Demand:** Start by looking at the `scheduled_dispatches` table. Use a window function to calculate the running total of the `quantity` ordered for each product over time.
   * `SUM(quantity) OVER (PARTITION BY product_id ORDER BY dispatch_date)` will give you the `cumulative_demand` up to any given day.
2. **Calculate Projected Stock:** In a Common Table Expression (CTE), `JOIN` your running demand calculations to the `inventory_levels` table. You can now calculate the `projected_stock` for each date by subtracting the `cumulative_demand` from the `current_stock`.
3. **Identify Breaches:** In your CTE, you can also filter out the safe days by applying a `WHERE` clause: `current_stock - cumulative_demand < safety_stock_threshold`.
4. **Isolate the *****First***** Breach:** A product might continue to drop further below the safety threshold on subsequent days (like the Wireless Mouse). The manager only needs to be alerted on the *first* day it crosses the line.
   * Add a `ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY dispatch_date)` to your CTE.
   * In your final `SELECT` statement, query from your CTE and filter for `WHERE rank = 1` to isolate the earliest breach date.

**Your Solution:**

```sql
-- Write your solution here
```

