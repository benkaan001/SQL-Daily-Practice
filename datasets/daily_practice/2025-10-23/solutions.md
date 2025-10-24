## Puzzle: The Subscription "Win-Back" and "Churn" Analysis

**The Scenario:** As a marketing analyst, you are tasked with identifying two key user behaviors: "Churn" and "Win-Backs".

* **Churn:** A user is considered "churned" if their most recent plan is `Cancelled`.
* **Win-Back:** A user is considered a "win-back" if they `Cancelled` at some point but their *most recent* plan is **not** `Cancelled` (meaning they returned).

**Your Task:** Write a single query to find all users who are either "Churned" or "Win-Backs". Your report should show the `user_id`, their `current_plan` (the latest `new_plan` on record), and their `status` ('Churned' or 'Win-Back').

Order the results by `user_id`.

| **user_id** | **current_plan** | **status** |
| ----------------- | ---------------------- | ---------------- |
| 102               | Cancelled              | Churned          |
| 103               | Premium                | Win-Back         |
| 106               | Cancelled              | Churned          |
| 108               | Basic                  | Win-Back         |

### Tips for Approaching the Problem

1. **Find Each User's Final Plan:** The first step is to identify the *most recent* plan for every user. A window function like `ROW_NUMBER()` partitioned by `user_id` and ordered by `change_date DESC` is perfect for this.
2. **Isolate the Final Plan:** In a CTE, select only the rows where your `ROW_NUMBER()` is 1. This gives you a clean list of all users and their single, current plan.
3. **Check for Past Cancellations:** You also need to know if a user has *ever* cancelled. You can create a separate CTE that gets a distinct list of all `user_id`s from the table where `new_plan = 'Cancelled'` or `previous_plan = 'Cancelled'`.
4. **Combine the Logic:**
   * `JOIN` your "final plan" CTE with your "past cancellation" CTE using a `LEFT JOIN` (since not all users have a cancellation record).
   * You can now select the `user_id` and `current_plan` from your "final plan" CTE.
   * Use a `CASE` statement to determine the `status`:
     * `WHEN current_plan = 'Cancelled' THEN 'Churned'`
     * `WHEN current_plan != 'Cancelled' AND past_cancellation.user_id IS NOT NULL THEN 'Win-Back'`
   * Filter your final result to only include rows where the `status` is not `NULL`.

**Your Solution:**

```sql
WITH plan_history AS (
	SELECT
		user_id,
		GROUP_CONCAT(DISTINCT previous_plan) AS previous_plans
	FROM
		subscription_plan_changes
	GROUP BY
		user_id
),
most_recent_plans AS (
	SELECT
		user_id,
		new_plan,
		ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY change_date DESC) AS rn
	FROM
		subscription_plan_changes

),
final_analysis AS (
	SELECT
		mrp.user_id,
		mrp.new_plan AS current_plan,
		CASE
			WHEN mrp.new_plan = 'Cancelled' THEN 'Churned'
			WHEN ph.previous_plans LIKE '%Cancelled%' AND mrp.new_plan != 'Cancelled' THEN 'Win-Back'
		END AS status
	FROM
		most_recent_plans mrp
	LEFT JOIN
		plan_history ph ON ph.user_id = mrp.user_id
	WHERE
		mrp.rn = 1
		AND ph.previous_plans IS NOT NULL
)
SELECT
	user_id,
	current_plan,
	status
FROM
	final_analysis
WHERE
	status IS NOT NULL;
```

