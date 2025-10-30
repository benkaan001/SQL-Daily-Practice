## Puzzle: The Subscription Lifecycle Window

**The Scenario:** As a business analyst, you need to analyze subscription lifecycles. You can't just look at individual events; you must define a "subscription period" to understand how long users stay subscribed and why they leave.

**Your Task:** Write a query to define every subscription period for each user. A subscription period begins with a `SUBSCRIBED` event. It ends at the *next* `CANCELLED_BY_USER` or `SUBSCRIPTION_ENDED_INVOLUNTARILY` event for that user. Events like `RENEWAL_SUCCESSFUL` or `PAYMENT_FAILED` happen *within* a period but do not end it.

The final report should show the `user_id`, the `subscription_start_time` (the timestamp of the `SUBSCRIBED` event), the `subscription_end_time` (the timestamp of the churn event), and a `churn_type` ('Voluntary' for `CANCELLED_BY_USER`, 'Involuntary' for `SUBSCRIPTION_ENDED...`, or 'Active' if the period hasn't ended).

| **user_id** | **subscription_start_time** | **subscription_end_time** | **churn_type** |
| ----------------- | --------------------------------- | ------------------------------- | -------------------- |
| 101               | 2023-01-15 10:00:00.000           | 2023-03-20 14:00:00.000         | Voluntary            |
| 101               | 2023-05-01 12:00:00.000           | NULL                            | Active               |
| 102               | 2023-02-10 11:00:00.000           | 2023-03-24 11:00:00.000         | Involuntary          |
| 102               | 2023-06-15 10:00:00.000           | 2023-08-15 10:00:00.000         | Voluntary            |
| 103               | 2023-02-15 11:00:00.000           | NULL                            | Active               |
| 104               | 2023-06-10 09:00:00.000           | 2023-07-12 15:00:00.000         | Voluntary            |

### Tips for Approaching the Problem

1. **Isolate Start and End Events:** This problem is about pairing "start" events with their corresponding "end" events. It's helpful to create two separate Common Table Expressions (CTEs): one for start events (`event_type = 'SUBSCRIBED'`) and one for end events (`event_type IN ('CANCELLED_BY_USER', 'SUBSCRIPTION_ENDED_INVOLUNTARILY')`).
2. **Find the *****Next***** End Event:** For each `SUBSCRIBED` event, you need to find the *first* "end" event that happened *after* it for the same user. This is a perfect use case for a correlated subquery or, more efficiently, a window function.
3. **Using `LEAD` (A Tricky Approach):** A simple `LEAD()` over all events is difficult because you need to skip intermediate events like 'RENEWAL_SUCCESSFUL'.
4. **Recommended Approach (Finding the Pair):**
   * Create a CTE (`start_events`) for all `SUBSCRIBED` events.
   * Create a CTE (`end_events`) for all `CANCELLED...` or `SUBSCRIPTION_ENDED...` events.
   * Use a final `SELECT` from `start_events`. In this `SELECT`, use a correlated subquery (or a `CROSS APPLY`/`LATERAL JOIN` if your SQL dialect supports it) to find the *next* end event.
   * It would look something like:
     SELECT ..., (SELECT MIN(e.event_timestamp) FROM end_events e WHERE e.user_id = s.user_id AND e.event_timestamp > s.event_timestamp) AS subscription_end_time
   * This finds the earliest end event that occurred after the start event.
5. **Handling 'Active' and 'Churn Type':**
   * The correlated subquery from Tip 4 will return `NULL` for `subscription_end_time` if no end event is found. Use `COALESCE` or a `CASE` statement to label these as 'Active'.
   * To get the `churn_type`, you'll also need to fetch the `event_type` of the end event. This makes the query slightly more complex, as you can't just get the `MIN(event_timestamp)`. You may need to use `ROW_NUMBER()` in the `end_events` CTE, partitioned by `user_id` and ordered by time, and then join.

**Your Solution:**

```sql
-- Write your solution here
```
