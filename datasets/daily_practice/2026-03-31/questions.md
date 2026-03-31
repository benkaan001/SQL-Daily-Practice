## Puzzle: The End-of-Month Balance Snapshot

**The Scenario:** The Finance department needs a clean Q1 2026 ledger report. They need to see the exact ending account balance for every user at the end of January, February, and March.

**The Catch:** If a user makes no transactions in a specific month (like Alice in March or Bob in January), standard `GROUP BY` logic will just skip that month entirely. Finance requires a row for *every* month for *every* account, with the balance properly carrying over from the previous month.

**Your Task:** Write a query to generate the End-of-Month (EOM) balance for every account for the first three months of 2026 ('2026-01', '2026-02', '2026-03').

The report should show the `account_name`, the `report_month` (formatted as YYYY-MM), and the `eom_balance`. Order the results by `account_name` alphabetically, and then by `report_month` chronologically.

**Expected Output:**

| **account_name** | **report_month** | **eom_balance** |
| ---------------------- | ---------------------- | --------------------- |
| Alice                  | 2026-01                | 500.00                |
| Alice                  | 2026-02                | 400.00                |
| Alice                  | 2026-03                | 400.00                |
| Bob                    | 2026-01                | 0.00                  |
| Bob                    | 2026-02                | 200.00                |
| Bob                    | 2026-03                | 250.00                |
| Charlie                | 2026-01                | 1000.00               |
| Charlie                | 2026-02                | 1000.00               |
| Charlie                | 2026-03                | 800.00                |

### Tips for Approaching the Problem

This puzzle requires you to forcefully generate the missing rows before doing the math!

1. **Generate the Skeleton (CROSS JOIN):** First, you need a "skeleton" table that contains every possible combination of Account and Month.
   * Create a CTE that hardcodes the three target months using `UNION ALL` (e.g., `SELECT '2026-01' AS report_month UNION ALL SELECT '2026-02'...`).
   * `CROSS JOIN` this CTE with the `accounts` table. Now you have a guaranteed 9 rows (3 users x 3 months).
2. **Aggregate the Raw Transactions:** In a second CTE, aggregate the `transactions` table so you know the total *net change* for each account within each specific month. Use `DATE_FORMAT(txn_date, '%Y-%m')` and `SUM(amount)`.
3. **Merge the Skeleton and Transactions:** `LEFT JOIN` your aggregated transactions CTE onto your Skeleton CTE. Link them on both `account_id` and the formatted month string.
   * *Note: Use `COALESCE(..., 0)` on the transaction sum so that months with no activity show `0.00` instead of `NULL`.*
4. **Calculate the Running Total:** Now that you have a perfect, uninterrupted timeline for every user, you can easily carry the balances forward! In your final `SELECT`, use the window function `SUM(net_monthly_change) OVER (PARTITION BY account_id ORDER BY report_month)` to build the final `eom_balance`.

**Your Solution:**

```sql
-- Write your solution here
```
