## Puzzle: The Negative Inventory Leak

**The Scenario:** As an inventory control specialist, your most critical alert is "Negative Inventory." This happens when the system records more sales/outflows for a specific batch than were ever received. This indicates theft, data errors, or unrecorded shipments.

**Your Task:** Write a query to find any `batch_id` where the running total of `quantity` dropped below zero at any point in time.

The report should show the `product_id`, the `batch_id`, the `movement_date` when the balance first went negative, and the `balance_at_failure`.

| **product_id** | **batch_id** | **failure_date** | **balance_at_failure** |
| -------------------- | ------------------ | ---------------------- | ---------------------------- |
| 103                  | BATCH-003          | 2023-11-06             | -5                           |

### Tips for Approaching the Problem

1. **Calculate Running Total:** Use `SUM(quantity) OVER (PARTITION BY batch_id ORDER BY movement_date)` to find the stock level after every movement.
2. **Filter for Negatives:** Select rows where this running total is `< 0`.
3. **Find the First Instance:** Use a window function or `GROUP BY` to find the earliest date this occurred for each batch.

**Your Solution:**

```sql
-- Write your solution here
```
