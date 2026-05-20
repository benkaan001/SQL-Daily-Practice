## Puzzle: Microservice Flapping Detection

**The Scenario:** "Flapping" occurs when a service rapidly switches between `UP` and `DOWN` states. During scheduled maintenance, these transitions are expected and should not trigger alerts.

**Your Task:** Write a query to identify microservices that exhibited "Unscheduled Flapping" on April 19th, 2026.

**Rules:**

1. **Status Change:** A entry where status is different from the immediately preceding log entry for the same service.
2. **Maintenance Filter:** Ignore entries where `metadata` has `"maintenance": true`.
3. **Flapping Criteria:** 3 or more status changes within any continuous 30-minute window.
4. **Result Window:** Anchored to the timestamp of the latest change in the flapping sequence.

### Expected Output:

| **service_name** | **flapping_start_time** | **flapping_end_time** | **total_changes** |
| ---------------------- | ----------------------------- | --------------------------- | ----------------------- |
| gateway-service        | 2026-04-19 08:05:00.000       | 2026-04-19 08:25:00.000     | 3                       |

**Your Solution:**

```sql
-- Write your solution here
```
