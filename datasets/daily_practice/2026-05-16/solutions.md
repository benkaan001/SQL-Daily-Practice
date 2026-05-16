## Puzzle: The Price Integrity Audit

**The Scenario:** In a high-volume marketplace, price updates can take time to propagate through various caching layers. The Finance team allows a 5-minute "Grace Period" for technical lag. However, any transaction occurring more than 5 minutes after a price change that still uses the old price is considered a "Critical Price Mismatch" and must be flagged for investigation.

**Your Task:** Write a query to identify all transactions where the `price_paid` does not match the catalog price that was active at the time of the transaction.

For each mismatch, you must categorize it based on the following rules:

1. **Grace Period Lag:** If the transaction occurred within 5 minutes (300 seconds) after a price change, and the `price_paid` matches the immediately preceding price.
2. **Critical Mismatch:** If the transaction occurred more than 5 minutes after the latest price change, or if the price paid doesn't match the immediately preceding price.

The final report should show the `txn_id`, `product_id`, `txn_timestamp`, `price_paid`, `expected_price` (the price that should have been active), and the `audit_status` ('Grace Period Lag' or 'Critical Mismatch').

Order the results by `txn_timestamp`.

### Expected Output:

| **txn_id** | **product_id** | **txn_timestamp** | **price_paid** | **expected_price** | **audit_status** |
| ---------------- | -------------------- | ----------------------- | -------------------- | ------------------------ | ---------------------- |
| 2                | 101                  | 2026-05-16 10:02:00.000 | 10.00                | 12.50                    | Grace Period Lag       |
| 3                | 101                  | 2026-05-16 10:06:00.000 | 10.00                | 12.50                    | Critical Mismatch      |
| 5                | 101                  | 2026-05-16 14:01:00.000 | 12.50                | 11.00                    | Grace Period Lag       |
| 8                | 102                  | 2026-05-16 12:04:00.000 | 50.00                | 45.00                    | Grace Period Lag       |
| 9                | 102                  | 2026-05-16 12:10:00.000 | 50.00                | 45.00                    | Critical Mismatch      |

### Tips for Approaching the Problem

1. **Building Price Windows:** Use `LEAD()` on the `price_ledger` to create a `valid_until` timestamp for each price. This allows you to perform an "As-Of" join.
2. **Synchronizing Tables:** Join the `sales_transactions` to the versioned `price_ledger` where the `txn_timestamp` falls between the `change_timestamp` and the `valid_until` timestamp.
3. **Calculating Lag:** For transactions with a price mismatch, use `TIMESTAMPDIFF(SECOND, ...)` between the `txn_timestamp` and the `change_timestamp` of the currently active price to determine if it falls within the 300-second grace period.

**Your Solution:**

```sql
-- Write your solution here
```

