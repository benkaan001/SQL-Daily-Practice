## Puzzle: The Chargeback Abuse Detector

**The Scenario:** As a fraud analyst for a payments company, you need to identify cases of "chargeback abuse." This occurs when a customer initiates a chargeback, the merchant successfully disputes and wins (reversing the chargeback), but the customer then initiates a *second* chargeback for the same original transaction.

**Your Task:** Write a query to find all original transactions that have experienced this "abuse" pattern. The report must show the `card_id`, the `original_transaction_id`, the timestamp of the `first_chargeback`, the timestamp when the `dispute_was_won` by the merchant, and the timestamp of the `second_chargeback`.

| **card_id** | **original_transaction_id** | **first_chargeback_time** | **dispute_was_won_time** | **second_chargeback_time** |
| ----------------- | --------------------------------- | ------------------------------- | ------------------------------ | -------------------------------- |
| card_C            | txn_C01                           | 2023-11-12 15:00:00.000         | 2023-11-20 16:00:00.000        | 2023-11-25 17:00:00.000          |

### Tips for Approaching the Problem

1. **Isolate Each Event Type:** The easiest way to start is to create separate Common Table Expressions (CTEs) for each of the three key event types: `TRANSACTION_COMPLETED`, `CHARGEBACK_INITIATED`, and `CHARGEBACK_DISPUTE_WON`.
2. **Connect the First Chargeback:** `JOIN` your `completed_transactions` CTE with the `chargebacks` CTE. The join condition is on `original_transaction_id`, and the `chargeback_timestamp` must be greater than the `transaction_timestamp`.
3. **Connect the Won Dispute:** Now, `JOIN` the result from the previous step to the `dispute_won` CTE. Again, join on `original_transaction_id`, and ensure the `dispute_won_timestamp` is greater than the `first_chargeback_timestamp`.
4. **Find the Second Chargeback:** This is the key step. `JOIN` the result again to your `chargebacks` CTE (using a different alias, e.g., `second_chargebacks`). The join conditions must be on `original_transaction_id`, and the `second_chargeback_timestamp` must be greater than the `dispute_won_timestamp`.
5. **Ensure Correct Sequencing:** Because a transaction could have many chargebacks, use a window function like `ROW_NUMBER()` at each join stage to select the *first* event that occurs after the preceding one. For example, when finding the first chargeback, rank them by timestamp and take the first one. Then, when finding the won dispute, rank them by timestamp after the first chargeback, and so on.

**Your Solution:**

```sql
-- Write your solution here
```

