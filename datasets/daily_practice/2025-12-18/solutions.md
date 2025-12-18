## Puzzle: The "Ghost" Subscriber Purge

**The Scenario:** To maintain a healthy sender reputation, the email marketing team wants to purge "ghost" subscribers from their list. A ghost subscriber is defined as a user who has received at least **3 emails** but has **never** engaged with any of them. Engagement is defined as either `OPENED` or `CLICKED`.

**Your Task:** Write a query to identify all ghost subscribers.

The report should show the `user_id`, the `total_emails_sent` to them, and their `last_sent_timestamp`.

| **user_id** | **total_emails_sent** | **last_sent_timestamp** |
| ----------------- | --------------------------- | ----------------------------- |
| 102               | 3                           | 2023-12-18 11:00:00           |

### Tips for Approaching the Problem

1. **Count Sents:** Group by `user_id` and count `SENT` events.
2. **Check Engagement:** In the same aggregation, checking for the existence of `OPENED` or `CLICKED` events. You can use `COUNT(CASE WHEN event_type IN ('OPENED', 'CLICKED') THEN 1 END)` or `MAX(CASE WHEN ... THEN 1 ELSE 0 END)`.
3. **Filter:** Keep users with `sent_count >= 3` AND `engagement_count = 0`.

**Your Solution:**

```sql
SELECT
	user_id,
	SUM(CASE WHEN event_type = 'SENT' THEN 1 END) AS total_emails_sent,
	MAX(event_timestamp) AS last_sent_timestamp
FROM
	email_engagement
GROUP BY 
	user_id
HAVING 
	total_emails_sent >= 3
	AND SUM(CASE WHEN event_type != 'SENT' THEN 1 ELSE 0 END) = 0;
```
