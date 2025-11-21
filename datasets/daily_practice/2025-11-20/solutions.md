## Puzzle: The "Depth of View" Segmentation

**The Scenario:** As a product analyst, you need to segment user engagement based on the depth of their interest in product content. A high number of page views doesn't necessarily mean high engagement; the user might be rapidly clicking links (low engagement). True interest is indicated by a deep view, followed by a short subsequent interaction.

**Your Task:** Write a query to classify each session into one of three engagement categories based on two key metrics:

1. **`avg_dwell_time`** : The average time spent on any page view (duration_seconds).
2. **`products_viewed_count`** : The count of unique product detail pages viewed (`/products/[id]`).

**Engagement Segments (per Session):**

| **Segment Name**         | **Criteria**                                                 |
| ------------------------------ | ------------------------------------------------------------------ |
| **Deep Viewer**          | `products_viewed_count`>= 3 AND `avg_dwell_time`>= 15 seconds. |
| **High Dwell Low Depth** | `products_viewed_count`< 3 AND `avg_dwell_time`>= 30 seconds.  |
| **Rapid Browser**        | None of the above criteria are met.                                |

The final report should show the `session_id`, `user_id`, the calculated `avg_dwell_time` (rounded to 2 decimal places), the `products_viewed_count`, and the assigned `engagement_segment`.

| **session_id** | **user_id** | **avg_dwell_time** | **products_viewed_count** | **engagement_segment** |
| -------------------- | ----------------- | ------------------------ | ------------------------------- | ---------------------------- |
| sess_A               | 101               | 10.00                    | 1                               | Rapid Browser                |
| sess_B               | 102               | 111.25                   | 1                               | High Dwell Low Depth         |
| sess_C               | 101               | 7.00                     | 3                               | Rapid Browser                |
| sess_D               | 103               | 180.00                   | 0                               | High Dwell Low Depth         |
| sess_E               | 104               | 1.00                     | 4                               | Rapid Browser                |

### Tips for Approaching the Problem

1. **Calculate Session Metrics:** The first step is to group the data by `session_id` and `user_id` to calculate the fundamental metrics in a CTE.
   * Use `AVG(duration_seconds)` to find the `avg_dwell_time`.
   * Use `COUNT(DISTINCT CASE WHEN page_url LIKE '/products/%' THEN page_url END)` to find the `products_viewed_count`.
2. **Apply Classification Logic:** In your final `SELECT` statement, query from your metrics CTE and use a prioritized `CASE` statement to assign the segment name. You must start with the most specific or highest priority segment (`Deep Viewer`).
   * `CASE WHEN products_viewed_count >= 3 AND avg_dwell_time >= 15 THEN 'Deep Viewer'`
   * `WHEN avg_dwell_time >= 30 THEN 'High Dwell Low Depth'`
   * `ELSE 'Rapid Browser' END`

**Your Solution:**

```sql
WITH sessions AS (
	SELECT
		session_id,
		user_id,
		AVG(duration_seconds) AS avg_dwell_time,
		SUM(CASE WHEN page_url LIKE '%/products%' THEN 1 ELSE 0 END) AS products_viewed_count
	FROM
		page_visits
	GROUP BY
		session_id,
		user_id
)
SELECT
	session_id,
	user_id,
	ROUND(avg_dwell_time, 2) AS avg_dwell_time,
	products_viewed_count,
	CASE
		WHEN products_viewed_count >= 3 AND avg_dwell_time >= 15 THEN 'Deep Viewer'
		WHEN products_viewed_count < 3 AND avg_dwell_time >= 30 THEN 'High Dwell Low Depth'
		ELSE 'Rapid Browser'
	END AS engagement_segment

FROM
	sessions;
```
