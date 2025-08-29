## Puzzle 1: The Phantom Balance

**The Scenario:** The finance team needs to audit an account's balance over time, but they have a unique requirement. The running balance should only include `COMPLETED` transactions. However, when a `PENDING` transaction is eventually `COMPLETED`, its value should be retroactively applied from the time of the *original* `PENDING` event, not the completion event.

**Your Task:** Write a query for `account_id = 101` that calculates the correct `running_balance` after each transaction. The balance must be calculated chronologically, but the value of a completed transaction should be included from the timestamp of its initial `PENDING` state if one exists.

**Expected Output:**

| **transaction_timestamp** | **transaction_type** | **amount** | **status** | **running_balance** |
| ------------------------------- | -------------------------- | ---------------- | ---------------- | ------------------------- |
| 2023-10-01 10:00:00             | DEPOSIT                    | 1000.00          | COMPLETED        | 1000.00                   |
| 2023-10-02 11:00:00             | WITHDRAWAL                 | 100.00           | COMPLETED        | 900.00                    |
| 2023-10-03 12:00:00             | DEPOSIT                    | 500.00           | PENDING          | 900.00                    |
| 2023-10-04 13:00:00             | WITHDRAWAL                 | 200.00           | COMPLETED        | 1200.00                   |
| 2023-10-05 14:00:00             | DEPOSIT                    | 500.00           | COMPLETED        | 1200.00                   |

**Your Solution:**

```sql
-- Write your solution here
```

## Puzzle 2: The Money Laundering Trail

**The Scenario:** A fraud detection system has flagged a large deposit. You need to investigate if this deposit was immediately followed by a "structuring" pattern, where the large sum is broken down into smaller transfers to obscure the trail.

**Task:** Find all instances where a `DEPOSIT` of over $9,000 into an account is followed by a series of `TRANSFER_OUT` events from the *same account* within 1 hour. The sum of these subsequent transfers must exactly equal the amount of the initial deposit.

The report should show the `account_id`, the `initial_deposit_id`, the `deposit_amount`, and a comma-separated list of the `structured_transfer_ids`.

**Expected Output:**

| **account_id** | **initial_deposit_id** | **deposit_amount** | **structured_transfer_ids** |
| -------------------- | ---------------------------- | ------------------------ | --------------------------------- |
| 201                  | txn_06                       | 9500.00                  | txn_07,txn_08,txn_09              |

**Your Solution:**

```sql
-- Write your solution here
```

## Puzzle 3: The Currency Arbitrage Detective

**The Scenario:** You are a quantitative analyst looking for arbitrage opportunities in the platform's transaction data. An arbitrage opportunity exists if a user can start with an amount in one currency, execute a series of two transfers through different currencies, and end up with more of the original currency than they started with.

**Task:** Find all three-step, circular currency exchange paths (e.g., USD -> EUR -> GBP -> USD) that result in a net profit. You must track the flow of money from one account to another. The entire chain of three transfers must be completed within 24 hours.

The report should show the `start_account_id`, the `initial_amount`, the `initial_currency`, the `final_amount` received back in the same currency, and the `profit`.

**Expected Output:**

| **start_account_id** | **initial_amount** | **initial_currency** | **final_amount** | **profit** |
| -------------------------- | ------------------------ | -------------------------- | ---------------------- | ---------------- |
| 301                        | 1000.00                  | USD                        | 1016.60                | 16.60            |

**Your Solution:**

```sql
-- Write your solution here
```
