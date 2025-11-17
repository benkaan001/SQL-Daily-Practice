## Puzzle: The Multi-Funnel Conversion Analysis

**The Scenario:** As a marketing analyst, you need to track user progression through two different key conversion funnels simultaneously. Both funnels start on the home page but then diverge.

**Funnel A: "Standard Signup"**

1. View `/home` (`VIEW_PAGE`)
2. Then, view `/pricing` (`VIEW_PAGE`)
3. Then, click `signup_standard` (`CLICK_BUTTON`)

**Funnel B: "Enterprise Signup"**

1. View `/home` (`VIEW_PAGE`)
2. Then, view `/enterprise` (`VIEW_PAGE`)
3. Then, submit `contact_sales` (`FORM_SUBMIT`)

**Your Task:** Write a single query that finds all sessions that successfully completed *either* Funnel A or Funnel B. The events for a funnel must occur in the correct chronological order within the same session.

The final report should show the `session_id`, `user_id`, the `funnel_name` ('Standard Signup' or 'Enterprise Signup'), and the `completion_time` (the timestamp of the final step in the funnel).

| **session_id** | **user_id** | **funnel_name** | **completion_time** |
| -------------------- | ----------------- | --------------------- | ------------------------- |
| sess_A               | 101               | Standard Signup       | 2023-11-17 10:02:00.000   |
| sess_B               | 102               | Enterprise Signup     | 2023-11-17 11:02:00.000   |
| sess_F               | 106               | Standard Signup       | 2023-11-17 15:03:00.000   |
| sess_G               | 102               | Enterprise Signup     | 2023-11-17 16:03:00.000   |

### Tips for Approaching the Problem

1. **Pivot Session Data:** The key to this problem is to get the *first timestamp* for each relevant event within each session. You can do this by creating a Common Table Expression (CTE) that pivots the data.
2. **Use Conditional Aggregation:** `GROUP BY session_id, user_id`. In your `SELECT` statement, use conditional aggregation to find the `MIN()` timestamp for each of the key events:
   * `MIN(CASE WHEN event_name = 'VIEW_PAGE' AND page_url = '/home' THEN event_timestamp END) AS home_time`
   * `MIN(CASE WHEN event_name = 'VIEW_PAGE' AND page_url = '/pricing' THEN event_timestamp END) AS pricing_time`
   * `MIN(CASE WHEN event_name = 'CLICK_BUTTON' AND details = 'signup_standard' THEN event_timestamp END) AS standard_signup_time`
   * ...and so on for the 'Enterprise Signup' events.
3. **Check for Valid Funnels:** In your final `SELECT` statement (querying from the CTE), use a `CASE` statement to check if either funnel's conditions were met.
4. **Funnel A Logic:** `WHEN home_time < pricing_time AND pricing_time < standard_signup_time THEN 'Standard Signup'`
5. **Funnel B Logic:** `WHEN home_time < enterprise_time AND enterprise_time < contact_sales_time THEN 'Enterprise Signup'`
6. **Filter for Success:** Use a `WHERE` clause to filter out all sessions that did not successfully complete either funnel.

**Your Solution:**

```sql
-- Write your solution here
```
