## Puzzle: The Stuck Red Light

**The Scenario:** Smart city sensors log the state of traffic lights every few minutes. A light is considered "stuck" if it reports the same color consecutively for more than 10 minutes spanning multiple logs.

**Your Task:** Identify sensors that have reported 'RED' for a continuous span of more than 10 minutes.

Use the difference between the `MIN(log_time)` and `MAX(log_time)` of consecutive 'RED' blocks.

| **sensor_id** | **stuck_color** | **duration_minutes** |
| ------------------- | --------------------- | -------------------------- |
| 2                   | RED                   | 10                         |

### Tips

1. **Gaps and Islands:** This is a grouping problem. You need to group consecutive rows that have the same color.
2. **Aggregation:** `GROUP BY` the streak and calculate `TIMESTAMPDIFF`.

**Your Solution:**

```sql
-- Write your solution here
```
