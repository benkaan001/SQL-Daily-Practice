## Scenario 1: High-Velocity Sender Alert

**Objective:** As a fraud analyst, you need to detect users who are sending money to many different people in a short amount of time, a pattern known as "fanning out."

**Task:** Write a query to identify any `sender_id` who makes transactions to more than 3 unique `receiver_id`s within any 5-minute rolling window. The output should show the `sender_id` and the exact `alert_timestamp` when their 4th unique transaction in a 5-minute window was completed.

**Expected Output:**

| sender_id | alert_timestamp     |
| --------- | ------------------- |
| 101       | 2023-11-28 10:02:30 |
| 102       | 2023-11-28 18:03:00 |

**Your Solution:**

```sql
-- Step 1: For each transaction, create a 5-minute window and count the unique receivers within it.
WITH RollingWindowCounts AS (
    SELECT
        t1.sender_id,
        t1.transaction_timestamp,
        -- For each transaction (t1), we count the distinct receivers from all
        -- transactions (t2) that occurred in the 5 minutes leading up to it.
        COUNT(DISTINCT t2.receiver_id) AS unique_receivers_in_window
    FROM
        p2p_transactions t1
    JOIN
        p2p_transactions t2 ON t1.sender_id = t2.sender_id
        -- This join condition creates the 5-minute rolling window for each of t1's transactions
        AND t2.transaction_timestamp BETWEEN DATE_SUB(t1.transaction_timestamp, INTERVAL 5 MINUTE) AND t1.transaction_timestamp
    GROUP BY
        t1.transaction_id -- Group by the unique transaction ID to get a count for each event
),

-- Step 2: Filter for the transactions that crossed the "> 3" threshold.
Alerts AS (
    SELECT
        sender_id,
        transaction_timestamp
    FROM
        RollingWindowCounts
    WHERE
        unique_receivers_in_window > 3
)

-- Step 3: Find the very first time each sender triggered the alert.
SELECT
    sender_id,
    MIN(transaction_timestamp) AS alert_timestamp
FROM
    Alerts
GROUP BY
    sender_id;

```

## Scenario 2: Detecting Circular Payment Chains

**Objective:** Money launderers sometimes use circular transactions (e.g., A pays B, B pays C, C pays A) to obscure the origin of funds. Your task is to detect such three-party cycles.

**Task:** Find all instances of a three-party circular payment chain where `User A` sends money to `User B`, `User B` sends money to `User C`, and `User C` sends money back to `User A`. All three transactions must be 'COMPLETED' and must occur within a 24-hour period.

The report should show the user IDs for `user_a`, `user_b`, and `user_c`, and the timestamps for each of the three transactions that form the cycle.

**Expected Output:**

| user_a | user_b | user_c | a_to_b_timestamp    | b_to_c_timestamp    | c_to_a_timestamp    |
| ------ | ------ | ------ | ------------------- | ------------------- | ------------------- |
| 301    | 302    | 303    | 2023-11-28 14:00:00 | 2023-11-28 15:00:00 | 2023-11-28 16:00:00 |

**Your Solution:**

```sql
SELECT
	a.sender_id AS user_a,
	b.sender_id AS user_b,
	c.sender_id AS user_c,
	a.transaction_timestamp AS a_to_b_timestamp,
	b.transaction_timestamp AS b_to_c_timestamp,
	c.transaction_timestamp AS c_to_a_timestamp
FROM
	p2p_transactions a
JOIN
	p2p_transactions b ON a.receiver_id = b.sender_id
JOIN
	p2p_transactions c ON b.receiver_id = c.sender_id
WHERE
	-- C must send back to A
	c.receiver_id = a.sender_id
	-- Transactions must be completed
	AND a.status = 'COMPLETED' AND b.status = 'COMPLETED' AND c.status = 'COMPLETED'
	-- Transaction timestamps must be in logical order
	AND a.transaction_timestamp < b.transaction_timestamp
	AND b.transaction_timestamp < c.transaction_timestamp
	-- The entire circle must have takne place within a 24-hr window
	AND TIMESTAMPDIFF(HOUR, a.transaction_timestamp, c.transaction_timestamp) <= 24;
```

## Scenario 3: Cross-Border Transaction Flow Matrix

**Objective:** The finance team needs a summary of the total value of successful transactions flowing between different currency zones.

**Task:** Calculate the total value of completed transactions for currencies. You need to convert all amounts to a common currency, USD, for comparison. Use the following fixed conversion rates:

* 1 GBP = 1.25 USD
* 1 JPY = 0.0067 USD
* 1 EUR = 1.10 USD

The final report should show the `sender_currency` and the `total_volume_usd`. The report should only include pairs with a total volume greater than $500 USD.

**Expected Output:**

| sender_currency | total_volume_usd |
| --------------- | ---------------- |
| EUR             | 1727.00000000    |
| GBP             | 1937.50000000    |
| JPY             | 1005.00000000    |
| USD             | 11090.00000000   |

**Your Solution:**

```sql
SELECT
    currency AS sender_currency,
    SUM(CASE
        WHEN currency = 'GBP' THEN amount * 1.25
        WHEN currency = 'JPY' THEN amount * 0.0067
        WHEN currency = 'EUR' THEN amount * 1.10
        WHEN currency = 'USD' THEN amount
        ELSE 0
    END) AS total_volume_usd
FROM
    p2p_transactions
WHERE
    status = 'COMPLETED'
GROUP BY
    currency
HAVING
    total_volume_usd > 500
ORDER BY
    sender_currency;
```
