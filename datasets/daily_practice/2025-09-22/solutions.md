## Puzzle: The Impossible Journey - Detecting Velocity Fraud

**The Scenario:** As a fraud analyst, you need to detect "velocity fraud," which occurs when a credit card is used in geographically distant locations within a time frame that would be impossible for the cardholder to physically travel between.

**Your Task:** Write a query to find all transactions that are flagged as "impossible." An impossible transaction is one that occurs in a different `merchant_country` than the *immediately preceding* transaction for the same `card_number`, AND the time between the end of the previous transaction and the start of the current one is less than 2 hours.

The final report should show the `card_number`, details of the `previous_transaction` (its ID, country, and timestamp), and details of the `impossible_transaction` (its ID, country, and timestamp).

| **card_number** | **previous_transaction_id** | **previous_country** | **previous_timestamp** | **impossible_transaction_id** | **impossible_country** | **impossible_timestamp** |
| --------------------- | --------------------------------- | -------------------------- | ---------------------------- | ----------------------------------- | ---------------------------- | ------------------------------ |
| card_B                | txn_B01                           | USA                        | 2023-11-05 08:15:00.000      | txn_B02                             | UK                           | 2023-11-05 09:30:00.000        |
| card_D                | txn_D01                           | Japan                      | 2023-11-10 20:00:00.000      | txn_D02                             | Australia                    | 2023-11-10 20:45:00.000        |

### Tips for Approaching the Problem

1. **Look at the Previous Transaction:** The core of the problem is comparing each transaction to the one that came just before it for the same card. The `LAG()` window function is the perfect tool for this.
2. **Partition and Order:** When using `LAG()`, you must `PARTITION BY card_number` to look at each card's history separately. The history needs to be in chronological order, so you must `ORDER BY transaction_timestamp`.
3. **Fetch Previous Details:** Use `LAG()` in a CTE to get the `transaction_id`, `merchant_country`, and `transaction_timestamp` of the previous transaction. This will attach the prior event's data to each row.
4. **Filter for Impossible Journeys:** In your final `SELECT` statement, query from the CTE you created. Your `WHERE` clause will need to check three things:
   * The `previous_country` is not `NULL` (this excludes the very first transaction for each card).
   * The current `merchant_country` is different from the `previous_country`.
   * The time difference between the current `transaction_timestamp` and the `previous_transaction_timestamp` is less than 2 hours. Functions like `TIMESTAMPDIFF()` are ideal for this check.

**Your Solution:**

```sql
-- Write your solution here
```
