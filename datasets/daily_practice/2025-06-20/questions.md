
### Question 1: Customer's Monthly Net Flow and Most Active Month

For each customer, calculate their total net flow (total deposits - total withdrawals/payments/transfers) for each month they had activity.

Also, identify the month (year-month) with the highest absolute net flow (largest inflow or outflow) for each customer.

If there's a tie for the most active month, choose the earliest month.

Output customer_id, month_year (format YYYY-MM), net_flow_amount, and most_active_month_net_flow.

Include all months with activity for each customer.

Order the results by customer_id ascending, then by month_year ascending.

**Expected Output:**

| customer_id | month_year | net_flow_amount | most_active_month_next_flow |
| ----------- | ---------- | --------------- | --------------------------- |
| 1           | 2024-01    | 675.00          | 825.00                      |
| 1           | 2024-02    | 825.00          | 825.00                      |
| 1           | 2024-03    | -330.00         | 825.00                      |
| 1           | 2024-04    | -120.00         | 825.00                      |
| 2           | 2024-01    | 800.00          | 800.00                      |
| 2           | 2024-02    | -200.00         | 800.00                      |
| 2           | 2024-03    | -100.00         | 800.00                      |
| 2           | 2024-06    | 100.00          | 800.00                      |
| 3           | 2024-01    | 1500.00         | 1500.00                     |
| 3           | 2024-04    | -500.00         | 1500.00                     |
| 4           | 2024-02    | 300.00          | 300.00                      |
| 4           | 2024-03    | -50.00          | 300.00                      |
| 5           | 2024-01    | 5000.00         | 5000.00                     |
| 5           | 2024-05    | -1000.00        | 5000.00                     |
| 6           | 2024-07    | 480.00          | 480.00                      |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 2: Accounts with Consecutive Monthly Withdrawals

Identify account_ids that have had withdrawals (including payments and transfers from the account) in at least three consecutive months within the same calendar year.

Return the account_id and the start_month of such a consecutive streak (format YYYY-MM).

An account should only appear once per distinct streak. If multiple streaks exist, show the start month of each.

Order the results by account_id ascending, then by start_month ascending.

**Expected Output:**

| **account_id** | **start_month** |
| -------------------- | --------------------- |
| 101                  | 2024-01               |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 3: Deepest Transactional Link

For each transaction that is a 'transfer' to another account within the system (i.e., recipient_account_id is NOT NULL), find the "deepest" transactional link.

This means finding the transaction_id that is furthest down a chain of consecutive transfers originating from the current transaction's recipient_account_id and continuing through other accounts.

If a transfer does not lead to another transfer, its deepest link is itself.

Output initial_transaction_id, initial_account_id, final_account_id (the account at the end of the chain), and transfer_depth (the number of transfers in the chain, including the initial one).

Order results by initial_transaction_id ascending.

**Expected Output:**

| initial_transaction_id | initial_account_id | final_account_id | transfer_depth |
| ---------------------- | ------------------ | ---------------- | -------------- |
| 3                      | 101                | 102              | 1              |

**Your Solution:**

```sql
--- Write your solution here

```
