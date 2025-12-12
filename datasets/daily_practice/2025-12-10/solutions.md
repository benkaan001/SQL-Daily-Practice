## Puzzle: The "Flapping" Server Alert

**The Scenario:** A server is "flapping" if it oscillates between a healthy state (`OK`) and an unhealthy state (`CRITICAL` or `WARNING`) rapidly. This indicates an unstable configuration rather than a genuine load issue.

**Your Task:** Identify servers that have changed status from `OK` to an unhealthy state (`WARNING` or `CRITICAL`) **more than once** within a single hour.

The report should show the `server_name` and the `instability_count` (number of times it went from OK -> Bad).

| **server_name** | **instability_count** |
| --------------------- | --------------------------- |
| Server-B              | 2                           |

### Tips for Approaching the Problem

1. **Compare Previous State:** Use `LAG(status)` to find the previous status for each row.
2. **Define Instability:** Filter for rows where `prev_status = 'OK'` AND `current_status IN ('WARNING', 'CRITICAL')`.
3. **Count:** Group by `server_name` and count these occurrences.

**Your Solution:**

```sql
-- Write your solution here
```
