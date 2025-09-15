## Puzzle: The Reconstructed Transaction Log

**The Scenario:** You are a data engineer at a warehouse, and a critical transaction logging service has failed. All you have are periodic snapshots of inventory levels. Your task is to reconstruct a transaction log from these snapshots by inferring the events that must have occurred between them.

**Your Task:** Write a query that compares each inventory snapshot to the one immediately preceding it for the same `sku_id`. Based on the change in `quantity_on_hand`, you must generate a log of inferred transactions.

1. If the quantity increases, it's a `STOCK_RECEIPT`.
2. If the quantity decreases, it's a `SHIPMENT`.
3. If the quantity is unchanged, that snapshot should be ignored in the final log.
4. The very first snapshot for any SKU is always considered a `STOCK_RECEIPT` of its full quantity.

The final report should show the `sku_id`, the `event_timestamp` (from the snapshot that reflects the new quantity), the `inferred_event_type`, and the `quantity_change`. The results must be ordered by `sku_id` and then `event_timestamp`.

| **sku_id** | **event_timestamp** | **inferred_event_type** | **quantity_change** |
| ---------------- | ------------------------- | ----------------------------- | ------------------------- |
| SKU-101          | 2023-11-01 09:00:00.000   | STOCK_RECEIPT                 | 100                       |
| SKU-101          | 2023-11-01 10:00:00.000   | SHIPMENT                      | -20                       |
| SKU-101          | 2023-11-02 11:00:00.000   | STOCK_RECEIPT                 | 50                        |
| SKU-101          | 2023-11-03 14:00:00.000   | SHIPMENT                      | -130                      |
| SKU-202          | 2023-11-01 09:05:00.000   | STOCK_RECEIPT                 | 200                       |
| SKU-202          | 2023-11-02 09:10:00.000   | STOCK_RECEIPT                 | 50                        |
| SKU-303          | 2023-11-04 10:00:00.000   | STOCK_RECEIPT                 | 50                        |
| SKU-303          | 2023-11-04 10:05:00.000   | SHIPMENT                      | -10                       |
| SKU-303          | 2023-11-04 10:10:00.000   | SHIPMENT                      | -10                       |
| SKU-303          | 2023-11-04 10:15:00.000   | SHIPMENT                      | -10                       |

**Your Solution:**

```sql
-- Write your solution here
```
