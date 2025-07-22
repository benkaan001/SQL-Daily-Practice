## Question 1: Account Running Balance

**Calculate the running balance for each financial account after every transaction. The running balance should reflect the cumulative sum of deposits minus the cumulative sum of withdrawals and fees.**

**The output should include the **`<span class="selected">account_id</span>`, `<span class="selected">transaction_id</span>`, `<span class="selected">transaction_date</span>`, the `<span class="selected">amount</span>` of the transaction, the `<span class="selected">transaction_type</span>`, and the `<span class="selected">running_balance</span>` after that transaction.

**Order the results by **`<span class="selected">account_id</span>` and then by `<span class="selected">transaction_date</span>`.

**Expected Output:**

| **account_id** | **transaction_id** | **transaction_date**    | **transaction_type** | **amount**  | **running_balance** |
| -------------------- | ------------------------ | ----------------------------- | -------------------------- | ----------------- | ------------------------- |
| **101**        | **TXN001**         | **2023-05-01 09:15:00** | **deposit**          | **2500.00** | **2500.00**         |
| **101**        | **TXN003**         | **2023-05-03 12:30:00** | **withdrawal**       | **150.00**  | **2350.00**         |
| **101**        | **TXN005**         | **2023-05-05 08:45:00** | **withdrawal**       | **1200.00** | **1150.00**         |
| **101**        | **TXN006**         | **2023-05-06 19:00:00** | **deposit**          | **1500.00** | **2650.00**         |
| **101**        | **TXN010**         | **2023-05-15 13:00:00** | **fee**              | **5.00**    | **2645.00**         |
| **101**        | **TXN013**         | **2023-06-01 09:18:00** | **deposit**          | **2500.00** | **5145.00**         |
| **101**        | **TXN014**         | **2023-06-02 11:00:00** | **withdrawal**       | **1200.00** | **3945.00**         |
| **101**        | **TXN017**         | **2023-06-10 10:00:00** | **withdrawal**       | **200.00**  | **3745.00**         |
| **101**        | **TXN019**         | **2023-06-15 14:05:00** | **deposit**          | **35.00**   | **3780.00**         |
| **102**        | **TXN002**         | **2023-05-01 10:00:00** | **deposit**          | **1500.00** | **1500.00**         |
| **102**        | **TXN004**         | **2023-05-04 18:00:00** | **withdrawal**       | **250.00**  | **1250.00**         |
| **102**        | **TXN008**         | **2023-05-10 14:20:00** | **withdrawal**       | **50.00**   | **1200.00**         |
| **102**        | **TXN012**         | **2023-06-01 09:16:00** | **deposit**          | **1500.00** | **2700.00**         |
| **102**        | **TXN015**         | **2023-06-05 17:30:00** | **withdrawal**       | **75.00**   | **2625.00**         |
| **102**        | **TXN018**         | **2023-06-15 14:00:00** | **deposit**          | **25.00**   | **2650.00**         |
| **102**        | **TXN021**         | **2023-06-25 12:00:00** | **withdrawal**       | **1100.00** | **1550.00**         |
| **102**        | **TXN022**         | **2023-06-26 15:00:00** | **deposit**          | **1200.00** | **2750.00**         |
| **103**        | **TXN007**         | **2023-05-07 11:00:00** | **deposit**          | **5000.00** | **5000.00**         |
| **103**        | **TXN009**         | **2023-05-12 20:00:00** | **withdrawal**       | **2500.00** | **2500.00**         |
| **103**        | **TXN011**         | **2023-05-13 10:00:00** | **deposit**          | **3000.00** | **5500.00**         |
| **103**        | **TXN016**         | **2023-06-08 16:00:00** | **withdrawal**       | **150.00**  | **5350.00**         |
| **103**        | **TXN020**         | **2023-06-20 19:45:00** | **withdrawal**       | **300.00**  | **5050.00**         |

**Your Solution:**

```sql
-- Write your solution here
```

## Question 2: Suspicious Transaction Pairs

**Identify accounts with "suspicious" back-to-back transactions. A suspicious pair is defined as a withdrawal of more than $1000, followed by a deposit of more than $1000 within the next 2 calendar days.**

**The report should show the **`<span class="selected">account_id</span>`, the `<span class="selected">transaction_id</span>` and details (`<span class="selected">transaction_date</span>`, `<span class="selected">amount</span>`) of the withdrawal, and the `<span class="selected">transaction_id</span>` and details of the subsequent deposit.

**Order the results by **`<span class="selected">account_id</span>`.

**Expected Output:**

| **account_id** | **withdrawal_txn_id** | **withdrawal_date**     | **withdrawal_amount** | **deposit_txn_id** | **deposit_date**        | **deposit_amount** |
| -------------------- | --------------------------- | ----------------------------- | --------------------------- | ------------------------ | ----------------------------- | ------------------------ |
| **101**        | **TXN005**            | **2023-05-05 08:45:00** | **1200.00**           | **TXN006**         | **2023-05-06 19:00:00** | **1500.00**        |
| **102**        | **TXN021**            | **2023-06-25 12:00:00** | **1100.00**           | **TXN022**         | **2023-06-26 15:00:00** | **1200.00**        |
| **103**        | **TXN009**            | **2023-05-12 20:00:00** | **2500.00**           | **TXN011**         | **2023-05-13 10:00:00** | **3000.00**        |

**Your Solution:**

```sql
-- Write your solution here
```

## Question 3: Monthly Account Flow Summary

**Create a monthly summary for each account that details its financial flow.**

**The report must include the **`<span class="selected">account_id</span>`, the month (formatted as 'YYYY-MM'), total money deposited, total money withdrawn (including fees), the net flow of money for the month, and a `<span class="selected">flow_status</span>` categorized as 'Positive', 'Negative', or 'Neutral' based on the net flow.

**Order the results by **`<span class="selected">account_id</span>` and then by month.

**Expected Output:**

| **account_id** | **month**   | **total_deposits** | **total_withdrawals** | **net_flow** | **flow_status** |
| -------------------- | ----------------- | ------------------------ | --------------------------- | ------------------ | --------------------- |
| **101**        | **2023-05** | **4000.00**        | **1355.00**           | **2645.00**  | **Positive**    |
| **101**        | **2023-06** | **2535.00**        | **1400.00**           | **1135.00**  | **Positive**    |
| **102**        | **2023-05** | **1500.00**        | **300.00**            | **1200.00**  | **Positive**    |
| **102**        | **2023-06** | **1525.00**        | **1175.00**           | **350.00**   | **Positive**    |
| **103**        | **2023-05** | **8000.00**        | **2500.00**           | **5500.00**  | **Positive**    |
| **103**        | **2023-06** | **0.00**           | **450.00**            | **-450.00**  | **Negative**    |

**Your Solution:**

```sql
-- Write your solution here
```
