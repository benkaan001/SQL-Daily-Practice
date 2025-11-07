## Puzzle: The "Serial Returner" Anomaly

**The Scenario:** As an analyst for an e-commerce platform, you need to identify "serial returners." This behavior is costly and can indicate fraud or a poor customer experience. Your task is to build a report that flags these users.

**Your Task:** Write a query to find all users who are considered "serial returners" as of  **'2023-11-30'** . A serial returner is defined as a user who meets both of the following criteria within the last 90 days (i.e., for returns timestamped between '2023-09-01 00:00:00' and '2023-11-30 23:59:59'):

1. They have returned items from at least  **3 unique product categories** .
2. Their `total_return_value` (the sum of `return_value` from all their returns in this period) is greater than  **$500** .

The final report should show the `user_id`, the number of `unique_categories_returned`, and the `total_return_value` for all flagged users.

| **user_id** | **unique_categories_returned** | **total_return_value** |
| ----------------- | ------------------------------------ | ---------------------------- |
| 101               | 3                                    | 600.00                       |

### Tips for Approaching the Problem

1. **Filter by Time:** The first step is to filter the `product_returns` table to only include returns within the 90-day window specified (from '2023-09-01' to '2023-11-30').
2. **Group by User:** Since the analysis is per-user, you will need to `GROUP BY user_id`.
3. **Calculate Aggregates:** In your `SELECT` statement, you need to calculate the two key metrics:
   * `COUNT(DISTINCT product_category)` to get the number of unique categories.
   * `SUM(return_value)` to get the total value of their returns.
4. **Filter with `HAVING`:** After the `GROUP BY`, use a `HAVING` clause to apply the business rules. Your `HAVING` clause will check for two conditions:
   * `COUNT(DISTINCT product_category) >= 3`
   * `AND SUM(return_value) > 500`

**Your Solution:**

```sql
SELECT
	user_id,
	COUNT(DISTINCT product_category) AS unique_categories_returned,
	SUM(return_value) AS total_return_value
FROM
	product_returns
WHERE
	return_timestamp BETWEEN '2023-09-01 00:00:00' AND '2023-11-30 23:59:59'
GROUP BY
	user_id
HAVING
	unique_categories_returned >= 3
	AND total_return_value > 500;
```
