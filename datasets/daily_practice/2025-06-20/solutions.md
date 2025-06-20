
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
WITH filtered_transactions AS (
  SELECT
    a.customer_id,
    DATE_FORMAT(t.transaction_date, '%Y-%m') AS month_year,
    SUM(CASE WHEN t.transaction_type = 'deposit' THEN t.amount ELSE 0 END) AS total_deposits,
    SUM(CASE WHEN t.transaction_type != 'deposit' THEN t.amount ELSE 0 END) AS total_expenses
  FROM
    Transactions t
  JOIN
    Accounts a ON a.account_id = t.account_id
  GROUP BY
    a.customer_id,
    month_year
)
SELECT
  customer_id,
  month_year,
  total_deposits - total_expenses AS net_flow_amount,
  MAX(ABS(total_deposits - total_expenses)) OVER (PARTITION BY customer_id ORDER BY ABS(total_deposits - total_expenses) DESC, month_year ASC) AS most_active_month_next_flow
FROM
  filtered_transactions
ORDER BY
  customer_id,
  month_year;
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
WITH filtered_transactions AS (
  SELECT DISTINCT
    account_id,
    YEAR(transaction_date) AS withdrawal_year,
    MONTH(transaction_date) AS withdrawal_month
  FROM
    Transactions
  WHERE
    transaction_type <> 'deposit'
),
consecutive_transactions AS (
  SELECT
      t1.account_id,
      DATE_FORMAT(MAKEDATE(t1.withdrawal_year, 1) + INTERVAL (t1.withdrawal_month - 1) MONTH, '%Y-%m') AS start_month
  FROM
      filtered_transactions t1
  JOIN
      filtered_transactions t2  ON t1.account_id = t2.account_id
      AND t1.withdrawal_year = t2.withdrawal_year
      AND t2.withdrawal_month = t1.withdrawal_month + 1
  JOIN
      filtered_transactions t3 ON t1.account_id = t3.account_id
      AND t1.withdrawal_year = t3.withdrawal_year
      AND t3.withdrawal_month = t1.withdrawal_month + 2
  ORDER BY
      t1.account_id ASC,
      start_month ASC
)
SELECT
  account_id,
  MIN(start_month) AS start_month
FROM
  consecutive_transactions
GROUP BY
  account_id;

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
WITH RECURSIVE transfer_chain AS (
  SELECT
    transaction_id AS initial_transaction_id,
    account_id AS initial_account_id,
    recipient_account_id AS receiving_account_id,
    recipient_account_id AS final_account_id,
    1 AS transfer_depth
  FROM
    Transactions
  WHERE
    transaction_type = 'transfer'
    AND recipient_account_id IS NOT NULL

  UNION ALL

  SELECT
    tc.initial_transaction_id,
    tc.initial_account_id,
    t.recipient_account_id AS receiving_account_id,
    t.recipient_account_id AS final_account_id,
    tc.transfer_depth + 1 AS transfer_depth
  FROM
    transfer_chain tc
  JOIN
    Transactions t ON t.account_id = tc.receiving_account_id
    AND t.transaction_type = 'transfer'
    AND t.recipient_account_id IS NOT NULL
    AND t.transaction_id <> tc.initial_transaction_id


)
SELECT
  initial_transaction_id,
  initial_account_id,
  MAX(final_account_id) AS final_account_id,
  MAX(transfer_depth) AS transfer_depth
FROM
  transfer_chain
GROUP BY
  1, 2;
```
