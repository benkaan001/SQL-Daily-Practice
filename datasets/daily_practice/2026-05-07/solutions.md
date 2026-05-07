
## Puzzle: The "Money Mule" Network Detector

**The Scenario:** You are a Data Engineer on a Trust & Safety team. You are tasked with writing a query to automatically detect "Money Mules" in the platform's transaction network. A money mule is an `ACTIVE` user who receives illicit funds from a `BLOCKED` account and quickly funnels those funds to other `ACTIVE` accounts to launder the money.

**Your Task:** Write a query to identify any `ACTIVE` user acting as a money mule. A user is classified as a money mule if they meet **all** of the following conditions for a specific "receipt" transaction:

1. The user (who must have an `ACTIVE` account status) receives a transfer from a user with a `BLOCKED` account status. Let's call this the "dirty receipt".
2. The user subsequently makes one or more outgoing transfers to *other* `ACTIVE` users.
3. These outgoing transfers must occur strictly *after* the "dirty receipt" and within **24 hours** (<= 24 hours) of that receipt's timestamp.
4. The total sum of these qualifying outgoing transfers must be **greater than or equal to 80%** of the original "dirty receipt" amount.

The final report should show the `mule_user_id`, the `blocked_sender_id`, the `receipt_amount`, the total `forwarded_amount` within the 24-hour window, and the `forwarded_pct` (rounded to 2 decimal places).

Order the results by `forwarded_pct` descending.

**Expected Output:**

| **mule_user_id** | **blocked_sender_id** | **receipt_amount** | **forwarded_amount** | **forwarded_pct** |
| ---------------------- | --------------------------- | ------------------------ | -------------------------- | ----------------------- |
| 102                    | 101                         | 1000.00                  | 900.00                     | 90.00                   |

### Tips for Approaching the Problem

1. **Identify the "Dirty Receipts":** Start by creating a Common Table Expression (CTE) that isolates the initial suspicious transactions. Join the `transactions` table to the `users` table twice (once for the sender, once for the receiver) to filter for rows where the `sender.account_status = 'BLOCKED'` and the `receiver.account_status = 'ACTIVE'`.
2. **Find the Outgoing Transfers:** In a second step, `LEFT JOIN` the `transactions` table back onto your "dirty receipts" CTE. This allows you to find all transactions where the mule is now the `sender_id`.
3. **Apply Time and Status Filters:** In your `JOIN` condition (or the `WHERE` clause), apply the core business logic:
   * The outgoing transfer time must be `>` the dirty receipt time.
   * The outgoing transfer time must be `<= TIMESTAMPADD(HOUR, 24, dirty_receipt_time)`.
   * You will need to join the `users` table one more time to ensure the *new* recipient is also `ACTIVE`.
4. **Aggregate and Verify the Threshold:** Finally, `GROUP BY` the mule's ID and the original dirty receipt transaction details. Use `SUM(outgoing_amount)` to find the total forwarded funds. Use a `HAVING` clause to filter out any groups where `(SUM(outgoing_amount) / receipt_amount) * 100` is less than `80.00`.

**Your Solution:**

```sql
-- Write your solution here
```
