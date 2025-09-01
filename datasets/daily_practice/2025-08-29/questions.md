## Puzzle 1: The Money Laundering Trail

**The Scenario:** A fraud detection system has flagged a large deposit. You need to investigate if this deposit was immediately followed by a "structuring" pattern, where the large sum is broken down into smaller transfers to obscure the trail.

**Task:** Find all instances where a `DEPOSIT` of over $9,000 into an account is followed by a series of `TRANSFER_OUT` events from the *same account* within 1 hour. The sum of these subsequent transfers must exactly equal the amount of the initial deposit.

The report should show the `account_id`, the `initial_deposit_id`, the `deposit_amount`, and a comma-separated list of the `structured_transfer_ids`.

**Expected Output:**

| account_id | initial_deposit_id | deposit_amount | structured_transfer_ids |
| ---------- | ------------------ | -------------- | ----------------------- |
| 201        | txn_06             | 9500.0000      | txn_07,txn_08,txn_09    |

**Your Solution:**

```sql
-- Write your solution here
```
