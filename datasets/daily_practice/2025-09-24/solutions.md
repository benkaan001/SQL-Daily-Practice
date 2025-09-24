## Puzzle: The Daily Inventory Snapshot

**The Scenario:** As a warehouse manager, you need to reconstruct the daily inventory level for each product. The raw data only provides a log of individual events (`RECEIVED`, `SHIPPED`, `LOST`), not a snapshot of the stock level at any given time.

**Your Task:** Write a query that calculates the `stock_on_hand` for each product in each warehouse at the end of each day that the product had activity. The stock on hand is the cumulative sum of quantities from 'RECEIVED' events minus the sum of quantities from 'SHIPPED' and 'LOST' events.

The final report should show the `snapshot_date`, `product_sku`, `warehouse_id`, and the calculated `end_of_day_stock`.

| **snapshot_date** | **product_sku** | **warehouse_id** | **end_of_day_stock** |
| ----------------------- | --------------------- | ---------------------- | -------------------------- |
| 2023-11-01              | A-123                 | 1                      | 135                        |
| 2023-11-02              | A-123                 | 1                      | 83                         |
| 2023-11-03              | A-123                 | 2                      | 60                         |
| 2023-11-04              | C-789                 | 1                      | 20                         |
| 2023-11-05              | B-456                 | 1                      | 100                        |

### Tips for Approaching the Problem

1. **Standardize Quantity:** The first step is to treat all events as additions or subtractions from a total. A `CASE` statement is perfect for this. Convert quantities to a positive value for `RECEIVED` events and a negative value for `SHIPPED` and `LOST` events.
2. **Calculate Running Total:** With the standardized quantities, you can now calculate the cumulative stock level after each event. The `SUM() OVER (...)` window function is the key here.
   * You need to calculate this per product and warehouse, so you must `PARTITION BY product_sku, warehouse_id`.
   * The sum must be chronological, so you must `ORDER BY event_timestamp`.
3. **Identify the Last Daily Event:** The running total gives you the stock after *every* event, but you only need the final value for each day.
   * You can use another window function like `ROW_NUMBER()` in a CTE. Partition by `product_sku`, `warehouse_id`, and the `DATE(event_timestamp)`.
   * Order this `ROW_NUMBER()` by `event_timestamp DESC`. This will assign a `1` to the very last event of each day for each product.
4. **Filter for the Snapshot:** In your final `SELECT` statement, query from the CTE where you created the row number, and add a `WHERE` clause to keep only the rows where your row number is `1`.

**Your Solution:**

```sql
-- Write your solution here
```
