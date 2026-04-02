## Puzzle: The Domino Effect (Cascading Delays)

**The Scenario:** The Airline Operations team is trying to improve their on-time departure metrics. They know that many delays aren't the fault of the current gate crew, but are "cascading delays" caused when the physical aircraft arrives late from its previous flight, squeezing the required turnaround time.

**Your Task:** Write a query to identify all flights that suffered a  **Cascading Delay** .

A flight is considered to have a Cascading Delay if it meets **ALL THREE** of the following conditions:

1. **Current Flight Late:** The current flight departed more than **15 minutes** after its `scheduled_departure`.
2. **Previous Flight Late:** The *immediately preceding* flight for that exact same `tail_number` arrived more than **15 minutes** after its `scheduled_arrival`.
3. **Squeezed Turnaround:** The time between the previous flight's `actual_arrival` and the current flight's `scheduled_departure` was less than  **45 minutes** . (If there was plenty of scheduled layover time, the current delay is considered an independent issue).

The final report should show the `flight_id`, `tail_number`, the `previous_flight_id`, and the current flight's `departure_delay_minutes`. Order the results by `flight_id`.

**Expected Output:**

| **flight_id** | **tail_number** | **previous_flight_id** | **departure_delay_minutes** |
| ------------------- | --------------------- | ---------------------------- | --------------------------------- |
| 3                   | N111A                 | 2                            | 30                                |
| 8                   | N333C                 | 7                            | 30                                |

*(Note: Flight 6 was delayed by 30 minutes, and its previous flight arrived 20 minutes late. However, the previous flight arrived at 11:20 and Flight 6 wasn't scheduled to depart until 14:00. Since they had over 2.5 hours to turn the plane around, the delay on Flight 6 is an independent failure, not a cascade!)*

### Tips for Approaching the Problem

1. **Look Backwards:** For every flight, you need to know the details of the *previous* flight flown by that exact same aircraft. The `LAG()` window function is built for this.
2. **Partition and Order:** Use `LAG(...) OVER (PARTITION BY tail_number ORDER BY scheduled_departure)` to reliably fetch the previous `flight_id`, previous `scheduled_arrival`, and previous `actual_arrival`.
3. **Calculate Time Differences:** In a CTE, calculate your `departure_delay_minutes` using `TIMESTAMPDIFF(MINUTE, scheduled_departure, actual_departure)`.
4. **Apply the Logic:** In your final `SELECT` statement, query from your CTE and apply the three rules in your `WHERE` clause:
   * Current departure delay > 15
   * Previous arrival delay (`TIMESTAMPDIFF` of the lagged columns) > 15
   * The turnaround window (`TIMESTAMPDIFF` between `prev_actual_arrival` and current `scheduled_departure`) < 45.

**Your Solution:**

```sql
-- Write your solution here
```
