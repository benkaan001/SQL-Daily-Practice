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
-- Step 1: Isolate the initial "trigger" events: large, completed deposits.
WITH LargeDeposits AS (
    SELECT
        transaction_id,
        account_id,
        transaction_timestamp,
        amount
    FROM
        financial_ledger
    WHERE
        transaction_type = 'DEPOSIT'
        AND status = 'COMPLETED'
        AND amount > 9000.00
),

-- Step 2: For each large deposit, find all subsequent transfers that could be part of the structuring.
PotentialStructures AS (
    SELECT
        d.account_id,
        d.transaction_id AS initial_deposit_id,
        d.amount AS deposit_amount,
        t.transaction_id AS transfer_id,
        t.amount AS transfer_amount
    FROM
        LargeDeposits d
    JOIN
        financial_ledger t ON d.account_id = t.account_id
    WHERE
        t.transaction_type = 'TRANSFER_OUT'
        AND t.status = 'COMPLETED'
        -- The transfer must happen AFTER the deposit and WITHIN 1 hour.
        AND t.transaction_timestamp > d.transaction_timestamp
        AND TIMESTAMPDIFF(HOUR, d.transaction_timestamp, t.transaction_timestamp) < 1
),

-- Step 3: Group the potential transfers by the initial deposit and check if the sum matches.
StructuredGroups AS (
    SELECT
        account_id,
        initial_deposit_id,
        deposit_amount,
        SUM(transfer_amount) AS total_transfer_amount,
        -- Use GROUP_CONCAT to create the list of transfer IDs.
        GROUP_CONCAT(transfer_id ORDER BY transfer_id) AS structured_transfer_ids
    FROM
        PotentialStructures
    GROUP BY
        account_id,
        initial_deposit_id,
        deposit_amount
)

-- Final Step: Select only the groups where the transfer sum exactly equals the deposit amount.
SELECT
    account_id,
    initial_deposit_id,
    deposit_amount,
    structured_transfer_ids
FROM
    StructuredGroups
WHERE
    deposit_amount = total_transfer_amount;
```

