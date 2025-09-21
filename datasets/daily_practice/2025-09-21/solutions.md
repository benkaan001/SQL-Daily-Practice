## Puzzle: The Primary Endpoint Shift

**The Scenario:** As an API platform manager, you need to understand how your clients' usage patterns evolve over time. A significant change, like an API key shifting its primary endpoint, could indicate a client is adopting a new feature, or that an old feature has been deprecated.

**Your Task:** Write a query to identify every `api_key` that has changed its "primary endpoint" from one month to the next.

A "primary endpoint" for a given month is defined as the `endpoint_path` that the `api_key` requested most frequently during that month. To be considered primary, it must account for more than 50% of the key's total requests for that month. If no single endpoint meets this >50% threshold, the key has no primary endpoint for that month.

The final report should show the `api_key`, the `shift_month` (the month in which the new primary endpoint was established), the `previous_months_primary_endpoint`, and the `new_primary_endpoint`.

| **api_key** | **shift_month** | **previous_months_primary_endpoint** | **new_primary_endpoint** |
| ----------------- | --------------------- | ------------------------------------------ | ------------------------------ |
| ABC-123           | 2023-11               | /v1/users                                  | /v1/data                       |

### Tips for Approaching the Problem

1. **Calculate Monthly Counts:** First, you need to count the requests for each `api_key` on each `endpoint_path` for each month. A `GROUP BY` on the key, `endpoint_path`, and the truncated month (`DATE_FORMAT` or similar) is a good start. Also calculate the total monthly requests for each key in this step using a window function.
2. **Identify the Primary Endpoint:** From the monthly counts, you need to find the primary endpoint.
   * First, calculate the percentage of total requests for each endpoint (`endpoint_count / total_monthly_requests`).
   * Filter out any endpoints that are not > 50%.
   * The remaining endpoint is the primary one for that month. You can use a window function like `ROW_NUMBER()` partitioned by `api_key` and `month` and ordered by the count to formally rank them, but the >50% rule is the main filter.
3. **Look at the Previous Month:** Once you have a list of each key's primary endpoint for each month, you need to compare a month to the one before it. The `LAG()` window function is perfect for this. Partition by `api_key` and order by `month` to pull the primary endpoint from the previous row (i.e., the previous month).
4. **Filter for Changes:** Finally, simply filter your results to find rows where the `primary_endpoint` is not the same as the `previous_months_primary_endpoint` returned by the `LAG()` function.

**Your Solution:**

```sql
WITH key_counts AS (
	SELECT
		api_key,
		DATE_FORMAT(request_timestamp, '%Y-%m') AS month_year,
		endpoint_path,
		COUNT(*) AS monthly_key_count,
		COUNT(*) OVER (PARTITION BY api_key, DATE_FORMAT(request_timestamp, '%Y-%m')) AS total_key_count
	FROM
		api_usage_logs
	GROUP BY
		api_key,
		month_year,
		endpoint_path
),
monthly_endpoints AS (
	SELECT
		api_key,
		month_year,
		endpoint_path,
		(monthly_key_count * 100.0 / total_key_count) AS percentange,
		ROW_NUMBER() OVER (PARTITION BY api_key ORDER BY month_year) AS rn,
		LAG(endpoint_path, 1) OVER (PARTITION BY api_key ORDER BY month_year) AS prev_month_endpoint_path,
		LAG(month_year, 1) OVER (PARTITION BY api_key ORDER BY month_year) AS shift_month
	FROM
		key_counts
	WHERE
		(monthly_key_count * 100.0 / total_key_count) > 50
)
SELECT
	api_key,
	shift_month,
	prev_month_endpoint_path AS previous_month_primary_endpoint,
	endpoint_path AS new_primary_endpoint
FROM
	monthly_endpoints
WHERE
	endpoint_path != prev_month_endpoint_path
	AND prev_month_endpoint_path IS NOT NULL;
```
