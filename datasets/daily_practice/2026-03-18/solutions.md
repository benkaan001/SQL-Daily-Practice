## Puzzle: The Double-Entry Ledger Balance

**The Scenario:** You are a data engineer for a new peer-to-peer payment app. The finance team needs a daily reconciliation report showing the current net balance of every registered user on the platform.

**Your Task:** Write a query to calculate the final `net_balance` for every user in the `users` table.

Assume everyone starts with a balance of `$0.00`. The net balance is the total amount of money received minus the total amount of money sent.

The final report should list the `user_name` and their `net_balance`. Order the results by the `net_balance` in descending order, and then by `user_name` alphabetically to break any ties.

**Expected Output:**

| **user_name** | **net_balance** |
| ------------------- | --------------------- |
| Alice               | 85.00                 |
| Bob                 | 30.00                 |
| Charlie             | 25.00                 |
| Evan                | 0.00                  |
| Diana               | -140.00               |

*(Note: Users can have negative balances if they sent more than they received, and users with zero activity like Evan should display a balance of 0.00).*

### Tips for Approaching the Problem

There are two main ways to solve this: the `LEFT JOIN` aggregation method, and the `UNION ALL` method. The `UNION ALL` method is highly recommended as it is an elegant, senior-level SQL pattern for ledger data.

1. **The Ledger Un-Pivot (Recommended Approach):** Instead of trying to join the transfers table twice (once for sends, once for receives), you can use `UNION ALL` to create a single, unified ledger column.
   * Write a query that selects `sender_id` and multiplies the `amount` by `-1` (since sending decreases balance).
   * `UNION ALL` that with a query that selects `receiver_id` and keeps the `amount` positive.
   * Now you have a single temporary table with two columns: `user_id` and `transaction_impact`.
2. **Calculate the Balances:** In your main query, select from the `users` table. `LEFT JOIN` your unified ledger CTE to it.
3. **Aggregate and Handle NULLs:** `GROUP BY` the user. Calculate the balance using `SUM(transaction_impact)`. Because you used a `LEFT JOIN` (to ensure users with no transactions are included), use `COALESCE(..., 0)` or `IFNULL(..., 0)` to turn the `NULL` sums into `0.00`.

**Your Solution:**

```sql
WITH combined_transactions AS (
	SELECT
		t.sender_id AS user_id,
		COALESCE(t.amount * -1, 0.00)AS amount
	FROM
		users u
	LEFT JOIN
		transfers t ON
		t.sender_id = u.user_id
		
	UNION ALL 
	
	SELECT 
		t.receiver_id AS user_id,
		COALESCE(t.amount, 0.00) AS amount
	FROM
		users u
	LEFT JOIN
		transfers t ON
		t.receiver_id = u.user_id
)
SELECT
	u.user_name,
	COALESCE(SUM(ct.amount), 0.00) AS net_balance
FROM	
	combined_transactions ct
RIGHT JOIN
	users u ON ct.user_id = u.user_id 
GROUP BY 
	u.user_name
ORDER BY
	net_balance DESC,
	u.user_name;
```
