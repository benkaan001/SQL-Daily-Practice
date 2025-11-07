## Puzzle: The "Dropped Interest" Detector

**The Scenario:** As a UI/UX analyst, you're concerned about "dropped interest" events. This is different from a traditional bounce (which is a session with only one page view). A "dropped interest" event occurs when a user lands on a page (`PAGE_VIEW`) but then has no subsequent activity of any kind (no `CLICK`, `SCROLL`, `ADD_TO_CART`, or other `PAGE_VIEW`) *within 2 minutes* in the same session.

**Your Task:** Write a query to find every `PAGE_VIEW` event that resulted in "dropped interest." The report should show the `session_id`, `user_id`, the `page_url` of the page, and the `page_view_timestamp`.

| session_id | user_id | page_url | page_view_timestamp |

| sess_A | 101 | /landing-page-A | 2023-11-29 09:00:00.000 |

| sess_C | 103 | /features | 2023-11-29 09:10:00.000 |

| sess_E | 105 | /product/456 | 2023-11-29 09:20:00.000 |

### Tips for Approaching the Problem

1. **Find the Next Event:** The key to this problem is to find the timestamp of the *next* event in the session, regardless of its type. The `LEAD()` window function is perfect for this.
2. **Partition and Order:** Use `LEAD(event_timestamp, 1) OVER (PARTITION BY session_id ORDER BY event_timestamp)` in a CTE to get the `next_event_timestamp` for every event in a session.
3. **Filter and Apply Logic:** In your final `SELECT` statement, query from your CTE and apply all the rules in your `WHERE` clause:
   * `event_type = 'PAGE_VIEW'` (you only care about page views).
   * The `next_event_timestamp` is `NULL` (meaning it was the last event in the session, so no activity could have followed it).
   * OR the time difference between the `next_event_timestamp` and the current `event_timestamp` is greater than 2 minutes. `TIMESTAMPDIFF(MINUTE, event_timestamp, next_event_timestamp) > 2` is a good way to check this.

**Your Solution:**

```sql
-- Write your solution here
```