## Puzzle: The Abandoned Queue Detector

**The Scenario:** As a data analyst for a multiplayer game, you're tasked with identifying players who abandon the matchmaking queue. Long queue times are a major cause of player frustration and churn, and the team needs to know when and how often this happens.

**Your Task:** Write a query to find every instance where a player is considered to have "abandoned" a queue. A player abandons a queue if they have an `ENTER_QUEUE` event that is not followed by a successful `MATCH_FOUND` event within 5 minutes.

The final report should show the `player_id` and the exact `queue_entry_time` for each abandoned queue session.

| **player_id** | **queue_entry_time** |
| ------------------- | -------------------------- |
| 102                 | 2023-11-25 11:00:00.000    |
| 103                 | 2023-11-25 12:00:00.000    |
| 105                 | 2023-11-25 14:00:00.000    |

### Tips for Approaching the Problem

1. **Look at the Next Event:** The key to this problem is to compare each `ENTER_QUEUE` event with the event that immediately follows it for the same player. The `LEAD()` window function is the perfect tool to "look ahead" in your data.
2. **Partition and Order:** When using `LEAD()`, you need to look at each player's history separately, so you must `PARTITION BY player_id`. The events must be in chronological order, so you must `ORDER BY event_timestamp`.
3. **Create a CTE:** In a Common Table Expression (CTE), select all events and use `LEAD()` to get the `next_event_type` and `next_event_timestamp`. This will attach the subsequent event's data to each row, making comparison easy.
4. **Apply the Abandonment Logic:** In your final `SELECT` statement, query from the CTE and apply a `WHERE` clause to find the abandoned sessions. An `ENTER_QUEUE` event is abandoned if:
   * It is the player's very last event (the `next_event_type` is `NULL`).
   * OR the `next_event_type` is *not* `MATCH_FOUND`.
   * OR the `next_event_type` is `MATCH_FOUND`, but the time difference between the `next_event_timestamp` and the current `event_timestamp` is greater than 5 minutes.

**Your Solution:**

```sql
-- Write your solution here
```
