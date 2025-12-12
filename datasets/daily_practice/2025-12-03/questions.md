## Puzzle: The Packing Bottleneck

**The Scenario:** Warehouse management believes there is a bottleneck at the packing stations. Items are being picked from the shelves quickly, but they are sitting in bins for too long before being packed.

**Your Task:** Write a query to identify "slow-to-pack" items. An item is considered slow-to-pack if the time difference between its `PICKED` event and its `PACKED` event is  **greater than 60 minutes** .

The report should show the `order_id`, `item_id`, the `picked_time`, the `packed_time`, and the `processing_duration_minutes`.

| **order_id** | **item_id** | **picked_time** | **packed_time** | **processing_duration_minutes** |
| ------------------ | ----------------- | --------------------- | --------------------- | ------------------------------------- |
| 102                | 502               | 2023-12-03 09:00:00   | 2023-12-03 10:30:00   | 90.00                                 |

### Tips

1. **Pivot:** You need to compare two rows (Picked vs Packed) for the same item. A self-join or conditional aggregation is needed.
2. **Filter:** Only include items where both events exist and the difference > 60 minutes.

**Your Solution:**

```sql
-- Write your solution here
```
