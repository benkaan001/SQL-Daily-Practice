## Puzzle: The Zombie Authorization Hold

**The Scenario:** As a payment operations analyst, you need to identify "zombie authorizations." These are transactions that were successfully authorized, placing a hold on a customer's funds, but were never captured by the merchant. These holds eventually expire, but they can cause customer confusion and tie up their available credit.

**Your Task:** Write a query to find all `AUTH_SUCCESS` events that were not followed by a `CAPTURE` event for the same `transaction_id` within 7 days. These are considered expired authorizations.

The final report should show the `transaction_id`, `card_id`, `merchant_id`, the `authorization_amount`, and the `authorization_timestamp` for each of these expired holds as of '2023-12-06'.

| transaction_id | card_id | merchant_id | authorization_amount | authorization_timestamp |
| -------------- | ------- | ----------- | -------------------- | ----------------------- |
| txn_106        | card_B  | merchant_3  | 500.00               | 2023-11-25 12:00:00     |

**Your Solution:**

```sql
WITH events AS (
	SELECT
		transaction_id,
		card_id,
		merchant_id,
		amount,
		event_type,
		LEAD(event_type, 1) OVER (PARTITION BY transaction_id ORDER BY event_timestamp) AS next_event_type,
		event_timestamp,
		LEAD(event_type, 1, event_timestamp) OVER (PARTITION BY transaction_id ORDER BY event_timestamp) AS next_event_timestamp
	FROM
		card_transaction_events
)
SELECT
    transaction_id,
    card_id,
    merchant_id,
    amount AS authorization_amount,
    event_timestamp AS authorization_timestamp
FROM
    events
WHERE
    event_type = 'AUTH_SUCCESS'
    AND (
    	(next_event_type <> 'CAPTURE')
    	OR
        (next_event_type IS NULL AND DATEDIFF('2023-12-06', event_timestamp) > 7)
 	);
```
