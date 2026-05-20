## Puzzle: SIM Cloning / Impossible Concurrent Connection

**The Scenario:** A user should not be connected to two different cell towers at the same time. If the same `user_id` has overlapping connections on distinct towers, that is a strong indicator of SIM cloning or another network anomaly.

**Your Task:** Write a query against `network_connections` to find users with overlapping connection intervals on two different towers.

Rules:

- Only compare rows for the same `user_id`.
- Only count overlaps when one connection starts before the other ends and ends after the other starts.
- Ignore clean handoffs where one connection ends exactly when another begins.
- Return only one row per tower pair, with `tower_1` alphabetically before `tower_2`.

Output columns:

- `user_id`
- `tower_1`
- `tower_2`
- `overlap_start_time`
- `overlap_end_time`
- `overlap_duration_minutes`

**Expected Output:**

| user_id | tower_1      | tower_2       | overlap_start_time      | overlap_end_time        | overlap_duration_minutes |
| ------- | ------------ | ------------- | ----------------------- | ----------------------- | ------------------------ |
| 3001    | Airport_West | Downtown_01   | 2026-04-20 12:04:00.000 | 2026-04-20 12:05:00.000 | 1                        |
| 5001    | Airport_West | Suburban_East | 2026-04-20 10:05:00.000 | 2026-04-20 10:10:00.000 | 5                        |

**Your Solution:**

```sql
-- Write your solution here
```
