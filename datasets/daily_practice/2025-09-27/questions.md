## Puzzle: The Stale Fulfillment Pipeline

**The Scenario:** As an e-commerce operations manager, you need to identify orders that are "stale" - meaning they are stuck in a fulfillment stage for longer than the Service Level Agreement (SLA) allows. This is critical for preventing shipping delays and improving customer satisfaction.

**Your Task:** Write a query to find all orders that are currently stale as of `'2023-11-26 00:00:00'`. An order is considered stale if its most recent status has not progressed to the next expected status within the defined SLA time.

**SLA Rules:**

* From `PAYMENT_CONFIRMED`, an order must be `SENT_TO_WAREHOUSE` within  **4 hours** .
* From `SENT_TO_WAREHOUSE`, `PICKING_STARTED` must begin within  **24 hours** .
* From `PICKING_STARTED`, `PACKING_COMPLETED` must finish within  **4 hours** .
* From `PACKING_COMPLETED`, an order must be `SHIPPED` within  **36 hours** .

The report should show the `order_id`, its `current_stage`, the `time_in_stage_hours` (how long it has been in that stage as of the cutoff date), and the `sla_hours` for that stage. Only include orders that have breached their SLA.

| **order_id** | **current_stage** | **time_in_stage_hours** | **sla_hours** |
| ------------------ | ----------------------- | ----------------------------- | ------------------- |
| 102                | PICKING_STARTED         | 102.00                        | 4                   |
| 104                | PAYMENT_CONFIRMED       | 62.48                         | 4                   |

### Tips for Approaching the Problem

1. **Find the Current State:** The first step is to determine the most recent (current) status for every order. A window function like `ROW_NUMBER()` or `RANK()` is perfect for this. Partition by `order_id` and order by `event_timestamp DESC` to assign a `1` to the latest event for each order.
2. **Filter for Active Orders:** In a CTE, select only the rows where the rank is `1`. This gives you a clean list of each order and its current stage. You should also filter out orders that are already in a final state like `SHIPPED`, `DELIVERED` or `CANCELLED`, as they cannot be stale.
3. **Calculate Time in Stage:** For each active order, calculate how long it has been in its current stage. This will be the time difference between its `event_timestamp` and the fixed analysis time (`'2023-11-26 00:00:00'`). Use a function like `TIMESTAMPDIFF` to get the duration in hours.
4. **Apply SLA Logic:** Use a `CASE` statement to define the `sla_hours` for each `current_stage` based on the rules provided. For example, `WHEN current_stage = 'PICKING_STARTED' THEN 4`.
5. **Final Filtering:** In your final `SELECT` statement, filter the results to only include rows where the `time_in_stage_hours` is greater than the `sla_hours`.

**Your Solution:**

```sql
-- Write your solution here
```
