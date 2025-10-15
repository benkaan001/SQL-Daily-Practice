## Puzzle: The Orphaned Scooter Detector

**The Scenario:** As an operations manager for a scooter rental company, you need to identify "orphaned" scooters. An orphaned scooter is one that was unlocked but never subsequently locked, and its last reported event of any kind was more than 2 hours ago. This could indicate a rider forgot to end their trip, a dead battery, or even theft.

**Your Task:** Write a query to find all scooters that are currently in an "orphaned" state as of the cutoff time `'2023-12-18 15:00:00'`.

The final report should show the `scooter_id`, the timestamp of when it was `unlocked`, its `last_known_latitude` and `last_known_longitude`, and the total `hours_since_last_event`.

| **scooter_id** | **unlocked_at**   | **last_known_latitude** | **last_known_longitude** | **hours_since_last_event** |
| -------------------- | ----------------------- | ----------------------------- | ------------------------------ | -------------------------------- |
| 102                  | 2023-12-18 09:00:00.000 | 40.714222                     | -74.007888                     | 5.83                             |
| 104                  | 2023-12-18 11:00:00.000 | 40.713999                     | -74.008222                     | 3.92                             |

### Tips for Approaching the Problem

1. **Find the Last Event for Each Scooter:** The first step is to find the most recent event of any type for every scooter. A window function like `ROW_NUMBER()` partitioned by `scooter_id` and ordered by `event_timestamp DESC` is perfect for this.
2. **Find the Last 'UNLOCK' Event:** In parallel, you also need to find the timestamp of the most recent `UNLOCK` event for each scooter. You can do this in a separate CTE by filtering for `event_type = 'UNLOCK'` and using a similar `ROW_NUMBER()` window function.
3. **Combine the Information:** Join the results from the previous two steps. You should now have a list of every scooter, its last known event details, and the timestamp of its last unlock.
4. **Check for a Subsequent Lock:** The key to this puzzle is ensuring there isn't a `LOCK` event that occurred *after* the most recent `UNLOCK` event. A `LEFT JOIN` to a CTE of lock events or using a `NOT EXISTS` subquery is a good way to verify this.
5. **Final Filtering:** In your final `SELECT` statement, apply all the conditions:
   * The scooter's last known status must not be `LOCK`. (This can be inferred from the previous step).
   * The timestamp of the scooter's last event must be more than 2 hours before the cutoff time (`'2023-12-18 15:00:00'`).

**Your Solution:**

```sql
-- Write your solution here
```

