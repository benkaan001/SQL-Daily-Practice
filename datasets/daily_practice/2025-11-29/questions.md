## Puzzle: The Premature Closure Audit

**The Scenario:** As a Support Quality Assurance lead, you want to identify cases where agents are closing tickets too early, forcing customers to re-open them shortly after. This metric is called "Premature Closure."

**Your Task:** Write a query to find every instance of a Premature Closure. A Premature Closure is defined as a `CLOSED` event by an agent that is followed by a `REOPENED` event for the same `ticket_id` within  **24 hours** .

The report should show the `ticket_id`, the `agent_id` who closed the ticket, the `close_time`, the `reopen_time`, and the `hours_to_reopen` (rounded to 2 decimal places).

| **ticket_id** | **agent_id** | **close_time**    | **reopen_time**   | **hours_to_reopen** |
| ------------------- | ------------------ | ----------------------- | ----------------------- | ------------------------- |
| 101                 | 201                | 2023-11-10 10:00:00.000 | 2023-11-10 12:00:00.000 | 2.00                      |
| 104                 | 204                | 2023-11-12 08:30:00.000 | 2023-11-12 09:00:00.000 | 0.50                      |
| 104                 | 204                | 2023-11-12 09:30:00.000 | 2023-11-12 10:00:00.000 | 0.50                      |

### Tips for Approaching the Problem

1. **Identify Sequential Events:** The core task is to find a specific sequence: `CLOSED` -> `REOPENED`. The `LEAD()` window function is ideal for "looking ahead" to the next event for a ticket.
2. **Partition and Order:** Use `LEAD()` partitioned by `ticket_id` and ordered by `event_timestamp`. You want to retrieve the `event_type` and `event_timestamp` of the *next* event.
3. **Construct a CTE:** Create a CTE that selects the current event details and the next event details. Filter this CTE (or in the next step) to only look at rows where the *current* event is `CLOSED`.
4. **Filter for Premature Logic:** In your final `SELECT`, apply the logic:
   * The current event must be `CLOSED`.
   * The next event must be `REOPENED`.
   * The difference between `next_event_timestamp` and `event_timestamp` must be <= 24 hours.
5. **Calculate Duration:** Use `TIMESTAMPDIFF(MINUTE, ...)` divided by 60 to get the `hours_to_reopen` precisely.

**Your Solution:**

```sql
-- Write your solution here
```
