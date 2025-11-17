## Puzzle: The Stockout Audit

**The Scenario:** As an e-commerce inventory manager, you need to identify all sales that "oversold" an item, resulting in a negative inventory level. This is a critical problem that leads to customer dissatisfaction and backorders.

**Your Task:** Write a query to find every `SALE` event that caused the `stock_on_hand` for that product to drop below zero. The report must show the `product_id`, the `event_timestamp` of the sale, the `quantity_sold` (as a positive number), and the `resulting_stock` level (the inventory level *after* this sale).

| **product_id** | **event_timestamp** | **quantity_sold** | **resulting_stock** |
| -------------------- | ------------------------- | ----------------------- | ------------------------- |
| A-101                | 2023-11-04 14:00:00.000   | 25                      | -5                        |
| C-303                | 2023-11-05 10:00:00.000   | 30                      | -10                       |
| C-303                | 2023-11-08 15:00:00.000   | 30                      | -10                       |
| D-404                | 2023-11-06 10:00:00.000   | 5                       | -5                        |

### Tips for Approaching the Problem

1. **Calculate Running Stock:** The key to this problem is calculating the `stock_on_hand` after *every* event. The `SUM() OVER (...)` window function is the perfect tool for this.
2. **Partition and Order:** You need a separate running total for each product's inventory.
   * `PARTITION BY product_id`
   * The sum must be chronological, so `ORDER BY event_timestamp`.
3. **Create a CTE:** In a Common Table Expression (CTE), select all the columns from the original table, and add your new `stock_on_hand` column: `SUM(quantity) OVER (PARTITION BY product_id ORDER BY event_timestamp) AS resulting_stock`.
4. **Filter for Stockouts:** In your final `SELECT` statement, query from your CTE and apply the filters:
   * `event_type = 'SALE'`
   * `AND resulting_stock < 0`
5. **Format the Quantity:** Remember to show the `quantity_sold` as a positive number. You can use `ABS(quantity)` or `-quantity` in your final `SELECT`.

**Your Solution:**

```sql
-- Write your solution here
```
