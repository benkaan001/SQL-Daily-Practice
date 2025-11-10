## Puzzle: The "At-Risk" Subscriber Detector

**The Scenario:** As a data analyst on the retention team, you need to identify "at-risk" subscribers. A subscriber is considered "at-risk" if their *most recent* billing cycle for any given subscription has a status of `FAILED`. If a user fails a payment but then has a subsequent `PAID` cycle for the  *same subscription* , they are no longer considered at-risk for that subscription.

**Your Task:** Write a query to find all subscriptions that are currently in an "at-risk" state. The report should show the `user_id`, `subscription_id`, and the `last_failed_cycle_start` date.

| user_id | subscription_id | last_failed_cycle_start |

| 103 | sub_C | 2023-12-01 |

| 104 | sub_D | 2023-11-15 |

### Tips for Approaching the Problem

1. **Find the Latest Cycle for Each Subscription:** The core of the problem is to find the *most recent* status for each unique `subscription_id`. A window function like `ROW_NUMBER()` is perfect for this.
2. **Partition and Order:** Use `ROW_NUMBER() OVER (PARTITION BY subscription_id ORDER BY billing_cycle_start DESC)` in a Common Table Expression (CTE). This will assign a rank of `1` to the very last billing cycle record for every subscription.
3. **Filter for the Latest:** In your final `SELECT` statement, query from your CTE and apply filters to find the at-risk subscriptions.
4. **Apply At-Risk Logic:** Your `WHERE` clause should filter for rows where:
   * The rank is `1` (to ensure you are only looking at the latest status for each subscription).
   * AND the `status` of that row is `FAILED`.

**Your Solution:**

```sql
WITH failed_renewals AS (
	SELECT
		cycle_id, user_id, subscription_id, billing_cycle_start, billing_cycle_end, status, amount
	FROM
		subscription_billing_cycles
	WHERE
		status = 'FAILED'
)
SELECT
	fr.user_id,
    fr.subscription_id,
    fr.billing_cycle_start AS last_failed_cycle_start
FROM
	failed_renewals fr
WHERE NOT EXISTS
	(
		SELECT
			1
		FROM
			subscription_billing_cycles sbc
		WHERE
			sbc.status = 'PAID'
			AND sbc.subscription_id = fr.subscription_id
			AND sbc.cycle_id > fr.cycle_id
	);
```
