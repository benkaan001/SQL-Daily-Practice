## Puzzle: The "Lead Conversion" Funnel Attribution

**The Scenario:** As a marketing analyst, you need to understand which initial landing pages are most effective at driving users towards submitting a lead generation form (`contact_form` or `signup_form`). You need to attribute a form submission back to the first page the user viewed in that session.

**Your Task:** Write a query that identifies every `FORM_SUBMIT` event for either `contact_form` or `signup_form`. For each submission, find the `page_url` of the very first `PAGE_VIEW` event within the same `session_id`.

The final report should aggregate the results to show, for each `initial_page_url`, the `total_sessions_started`, the number of `lead_submissions` attributed to it, and the resulting `conversion_rate_pct`.

| **initial_page_url** | **total_sessions_started** | **lead_submissions** | **conversion_rate_pct** |
| -------------------------- | -------------------------------- | -------------------------- | ----------------------------- |
| /                          | 1                                | 1                          | 100.00                        |
| /blog/article1             | 1                                | 0                          | 0.00                          |
| /contact                   | 1                                | 1                          | 100.00                        |
| /pricing                   | 3                                | 2                          | 66.67                         |
| /signup                    | 1                                | 1                          | 100.00                        |

### Tips for Approaching the Problem

1. **Identify First Page Views:** The crucial first step is to find the first `PAGE_VIEW` for every session. A window function like `ROW_NUMBER()` partitioned by `session_id` and ordered by `event_timestamp ASC` is perfect. Filter this result to get only the rows where the rank is 1.
2. **Isolate Form Submissions:** Create a separate CTE that selects only the `FORM_SUBMIT` events for the relevant `form_id`s (`contact_form`, `signup_form`). Include the `session_id`.
3. **Join Submissions to First Views:** `LEFT JOIN` your "first page view" CTE to your "form submissions" CTE on `session_id`. A `LEFT JOIN` is important because you want to count all sessions that started, even if they didn't end in a submission.
4. **Aggregate and Calculate:** Now you can `GROUP BY` the `initial_page_url` (from the "first page view" CTE).
   * `total_sessions_started`: `COUNT(DISTINCT first_page_view.session_id)` or simply `COUNT(*)` if your CTE only contains one row per session.
   * `lead_submissions`: Count the non-null `session_id`s from the form submissions side of the join (`COUNT(form_submissions.session_id)`).
   * `conversion_rate_pct`: Calculate `(lead_submissions * 100.0) / total_sessions_started`.

**Your Solution:**

```sql
WITH sessions AS (
	SELECT
		*,
		ROW_NUMBER() OVER (PARTITION BY session_id ORDER BY event_timestamp) AS rn
	FROM
		website_analytics
	WHERE
		event_type = 'PAGE_VIEW'
),
urls AS (
	SELECT
		session_id,
		page_url AS initial_page_url
	FROM
		sessions
	WHERE
	    rn = 1
),
submissions AS (
	SELECT
		session_id AS lead_submission_session_id,
		form_id
	FROM
		website_analytics
	WHERE
		event_type = 'FORM_SUBMIT'
)
SELECT
	u.initial_page_url,
	COUNT(*) AS total_sessions_started,
	SUM(CASE WHEN u.session_id = s.lead_submission_session_id THEN 1 ELSE 0 END) AS lead_submission,
	ROUND(IFNULL(
		SUM(CASE WHEN u.session_id = s.lead_submission_session_id THEN 1 ELSE 0 END) / COUNT(*)
		, 0) * 100.0, 2) AS conversion_rate_pct
FROM
	submissions s
RIGHT JOIN
	urls u ON u.session_id = s.lead_submission_session_id
GROUP BY
	u.initial_page_url
ORDER BY
	u.initial_page_url;
```

