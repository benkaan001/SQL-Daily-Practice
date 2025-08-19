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
-- Write your solution here

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
-- Write your solution here

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
-- Write your solution here
```
