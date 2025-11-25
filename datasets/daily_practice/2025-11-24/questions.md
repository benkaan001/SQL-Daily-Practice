## Puzzle: The Checkout Friction Bottleneck

**The Scenario:** As a Conversion Rate Optimization (CRO) analyst, you need to measure the average time users spend between key steps in the checkout process. This metric helps identify "friction points" where users get stuck.

**Your Task:** Write a query that calculates the average time, in seconds, spent by users in each critical stage of the checkout funnel. The stages are defined by the time between two sequential events:

1. **Checkout Initiation Friction:** Time from `VIEW_CART` to `START_CHECKOUT`.
2. **Shipping Entry Friction:** Time from `START_CHECKOUT` to `ENTER_SHIPPING`.
3. **Payment Entry Friction:** Time from `ENTER_SHIPPING` to `ENTER_PAYMENT`.
4. **Purchase Finalization Time:** Time from `ENTER_PAYMENT` to `PURCHASE_COMPLETE`.

**Note:** Only include sessions that successfully completed the *final* event of the stage being measured. For example, to measure the time from `VIEW_CART` to `START_CHECKOUT`, the session must have reached `START_CHECKOUT` or a later stage.

The final report should show the `stage_name` and the `avg_duration_seconds` for that stage, ordered by duration (descending).

| stage_name                   | avg_duration_seconds |
| ---------------------------- | -------------------- |
| Shipping Entry Friction      | 74.00                |
| Payment Entry Friction       | 62.50                |
| Checkout Initiation Friction | 39.00                |
| Purchase Finalization Time   | 23.33                |

### Tips for Approaching the Problem

1. **Find the Next Event (Time-in-Stage):** The key to this problem is using the `LEAD()` window function to find the timestamp of the next event for every event in a session. You'll need this to calculate the duration between any two sequential steps.
2. **Partition and Order:** Use `LEAD(event_type)` and `LEAD(event_timestamp)` partitioned by `session_id` and ordered by `event_timestamp`.
3. **Calculate Individual Stage Durations:** Create a CTE that filters for the specific start event of each stage and calculates the duration to the *next* event.
   * For instance, for `VIEW_CART` to `START_CHECKOUT`, filter for `event_type = 'VIEW_CART'` and check if `LEAD(event_type) = 'START_CHECKOUT'`. This will give you the duration for that specific stage.
4. **Aggregate by Stage:** In your final query, use conditional aggregation to group all the calculated durations into the four required stages and find the average for each. A robust way to do this is to assign the duration to a stage name and then take the overall average.

**Your Solution:**

```sql
-- Write your solution here
```
