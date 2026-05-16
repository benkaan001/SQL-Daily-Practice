## Puzzle: Microservice Flapping Detection

**The Scenario:** In a distributed system, "flapping" occurs when a service rapidly switches between `UP` and `DOWN` states. This usually indicates an unstable configuration or a failing dependency. However, during scheduled maintenance, these transitions are expected and should not trigger alerts.

**Your Task:** Write a query to identify microservices that exhibited "Unscheduled Flapping" on May 17th, 2026.

**Definitions and Rules:**

1. **Status Change:** A log entry where the `status` is different from the *immediately preceding* log entry for the same service.
2. **Maintenance Filter:** Ignore any log entry where the `metadata` JSON field has `"maintenance": true`. If the key is missing or set to `false`, assume it is not maintenance.
3. **Flapping Criteria:** A service is flapping if it has **3 or more status changes** within any continuous  **30-minute window** .
4. **Result Window:** The 30-minute window is anchored to the timestamp of the *latest* change in the flapping sequence.

The final report should show the `service_name`, the `flapping_start_time` (timestamp of the first change in the sequence), the `flapping_end_time` (timestamp of the third or latest change in the sequence), and the `total_changes` in that window.

### Expected Output:

| **service_name** | **flapping_start_time** | **flapping_end_time** | **total_changes** |
| ---------------------- | ----------------------------- | --------------------------- | ----------------------- |
| auth-service           | 2026-05-17 08:05:00.000       | 2026-05-17 08:20:00.000     | 3                       |

### Tips for Approaching the Problem

1. **Filter Noise First:** Start by excluding maintenance logs. Use `JSON_EXTRACT` or the `->>` operator to check the maintenance status.
2. **Detect Transitions:** Use `LAG()` to compare the current status with the previous one. A transition is only counted if the status actually changed.
3. **Window Calculation:** Use a window function with a `RANGE` or `ROWS` frame, or a self-join, to look back 30 minutes from each transition to count how many other transitions occurred.
4. **Math Note:** Remember that a transition requires two points. The first transition is the second `UP/DOWN` event in a sequence.

**Your Solution:**

```sql
-- Write your solution here
```

