## Puzzle: The Impossible Concurrent Connection

**The Scenario:** As a security engineer for a telecom company, you are looking for evidence of "SIM Cloning" (where a malicious actor duplicates a user's SIM card). A strong indicator of this is if the same `user_id` is connected to two *different* cell towers at the exact same time.

**Your Task:** Write a query to find all users who had overlapping connection intervals on two distinct towers. 

An overlap occurs if a user's connection to one tower starts strictly before another connection ends, and ends strictly after the other connection starts. If a connection ends at the exact same second another begins, it is a clean handoff, not an overlap.

The final report should list the `user_id`, the two conflicting towers (`tower_1` and `tower_2`), the `overlap_start_time`, the `overlap_end_time`, and the `overlap_duration_minutes`. 

*Rules:*
1. To avoid duplicate mirror rows (A-B and B-A), ensure `tower_1` comes before `tower_2` alphabetically.
2. Only flag overlaps occurring on different towers.

| user_id | tower_1 | tower_2 | overlap_start_time | overlap_end_time | overlap_duration_minutes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 102 | TWR-C | TWR-D | 2026-05-18 10:45:00 | 2026-05-18 11:00:00 | 15 |
| 105 | TWR-A | TWR-H | 2026-05-18 15:30:00 | 2026-05-18 16:00:00 | 30 |

### Tips for Approaching the Problem

1. **Self-Join Strategy:** You need to compare rows within the same `network_connections` table. Join the table to itself (aliased as `c1` and `c2`) on `user_id`.
2. **Prevent Duplicates and Same-Tower Matches:** In your join condition, use `c1.tower_id < c2.tower_id`. This elegantly handles two rules at once: it forces different towers, and it ensures the pair is only evaluated in alphabetical order, preventing mirror duplicates.
3. **The Universal Overlap Formula:** Two time intervals overlap if and only if: `Start_A < End_B AND End_A > Start_B`. Add this logic to your `JOIN` or `WHERE` clause.
4. **Calculate the Overlap Boundaries:** 
   * The actual overlap *starts* at the later of the two start times: `GREATEST(c1.connect_time, c2.connect_time)`.
   * The actual overlap *ends* at the earlier of the two end times: `LEAST(c1.disconnect_time, c2.disconnect_time)`.
5. **Calculate Duration:** Use `TIMESTAMPDIFF(MINUTE, ...)` between your calculated start and end boundaries.

**Your Solution:**

```sql
-- Write your solution here
```
