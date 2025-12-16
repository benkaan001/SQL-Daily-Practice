## Puzzle: The Flash Sale Scalper

**The Scenario:** During a flash sale, you suspect "scalper bots" are buying up inventory. A scalper is defined as a user who purchases a total of **10 or more units** of the **same item** within any  **10-minute window** .

**Your Task:** Write a query to detect these scalpers. The report should return the `user_id`, the `item_id`, the start of the suspicious window, and the `total_quantity` purchased in that window.

| **user_id** | **item_id** | **window_start** | **total_quantity** |
| ----------------- | ----------------- | ---------------------- | ------------------------ |
| 102               | 999               | 2023-12-15 12:00:00    | 12                       |

### Tips for Approaching the Problem

1. **Self-Join for Windows:** Join the table to itself (`t1` to `t2`) on `user_id` and `item_id`.
2. **Define Window:** The join condition should be `t2.order_timestamp BETWEEN t1.order_timestamp AND t1.order_timestamp + INTERVAL 10 MINUTE`. This looks forward 10 minutes from every order.
3. **Aggregate:** Group by `t1.user_id`, `t1.item_id`, and `t1.order_timestamp`. Sum the quantities of the joined `t2` rows.
4. **Filter:** Keep groups where `SUM(t2.quantity) >= 10`.

**Your Solution:**

```sql
-- Write your solution here
```
