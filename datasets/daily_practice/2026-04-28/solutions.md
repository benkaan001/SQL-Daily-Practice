## Puzzle: The Moving Weighted Average Cost (WAC) Ledger

**The Scenario:** The accounting department needs to value the company's inventory using the Moving Average Cost method. Unlike FIFO (First-In, First-Out), WAC blends the cost of old and new inventory.

Every time new items are purchased, a new average cost per unit must be struck. When items are sold, their cost is calculated using the *current* moving average cost, reducing the total inventory value but leaving the average cost per unit unchanged.

**Your Task:** Write a query to calculate the `total_qty`, `total_value`, and `moving_avg_cost` of 'WIDGET-X' after every single transaction.

**Rules for WAC:**

* **On a 'BUY':** * `New Total Value` = `Previous Total Value` + (`Buy Quantity` * `Buy Price`)
  * `New Total Qty` = `Previous Total Qty` + `Buy Quantity`
  * `New WAC` = `New Total Value` / `New Total Qty`
* **On a 'SELL':**
  * `New Total Qty` = `Previous Total Qty` - `Sell Quantity`
  * `New Total Value` = `Previous Total Value` - (`Sell Quantity` * `Previous WAC`)
  * `New WAC` = `Previous WAC` (WAC does not change on a sale)

The report should show the `txn_id`, `txn_date`, `txn_type`, `quantity`, `unit_price`, `total_qty`, `total_value`, and `moving_avg_cost` (rounded to 2 decimal places).

**Expected Output:**

| **txn_id** | **txn_date** | **txn_type** | **quantity** | **unit_price** | **total_qty** | **total_value** | **moving_avg_cost** |
| ---------------- | ------------------ | ------------------ | ------------------ | -------------------- | ------------------- | --------------------- | ------------------------- |
| 1                | 2026-04-01         | BUY                | 100                | 10.00                | 100                 | 1000.00               | 10.00                     |
| 2                | 2026-04-05         | BUY                | 50                 | 16.00                | 150                 | 1800.00               | 12.00                     |
| 3                | 2026-04-10         | SELL               | 60                 | NULL                 | 90                  | 1080.00               | 12.00                     |
| 4                | 2026-04-15         | BUY                | 110                | 14.00                | 200                 | 2620.00               | 13.10                     |
| 5                | 2026-04-20         | SELL               | 50                 | NULL                 | 150                 | 1965.00               | 13.10                     |
| 6                | 2026-04-25         | SELL               | 20                 | NULL                 | 130                 | 1703.00               | 13.10                     |

### Tips for Approaching the Problem

This is an advanced puzzle. You *cannot* use standard window functions like `SUM() OVER()` because the calculation has a "recursive dependency" (the value deducted on a `SELL` depends on the `moving_avg_cost` calculated in the row immediately prior).

1. **Number the Steps:** Start with a CTE that assigns a sequential `ROW_NUMBER()` to the transactions ordered by `txn_date`. Let's call this column `step`. This gives you a clear path to walk down.
2. **The Recursive CTE Anchor:** Use a `WITH RECURSIVE` statement. The "Anchor" member will simply select the transaction where `step = 1`. Its `total_qty` is the `quantity`, its `total_value` is `quantity * unit_price`, and its `moving_avg_cost` is `unit_price`.
3. **The Recursive Member:** `JOIN` your ordered transactions CTE to your recursive CTE on `current_txn.step = previous_txn.step + 1`.
4. **The Recursive Math:** In the recursive `SELECT` clause, use a `CASE` statement based on `txn_type` to calculate the new values using the formulas provided in the rules. You will pull the `prev_qty`, `prev_value`, and `prev_wac` from the recursive join alias.
5. **Casting is Critical:** Because you are multiplying and dividing recursively, you must wrap your calculated `total_value` and `moving_avg_cost` in `CAST( ... AS DECIMAL(10,2))` inside the recursive CTE to prevent the database engine from throwing a type-mismatch or precision error during the recursion loop.

**Your Solution:**

```sql
-- Write your solution here
```
