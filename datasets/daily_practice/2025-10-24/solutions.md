## Puzzle: The Promotion Conversion Funnel

**The Scenario:** As a marketing analyst, you need to determine the effectiveness of your promotion codes. A key metric is the "promo conversion rate": the percentage of users who apply a promo code and then complete a purchase within 1 hour.

**Your Task:** Write a query that calculates the `conversion_rate_pct` for each `promo_code`. The report must show:

1. `promo_code`: The specific promotion code used.
2. `total_applications`: The total number of times the promo was applied.
3. `total_conversions`: The number of those applications that were "successful" (i.e., were followed by a `PURCHASE` event from the same `user_id` within 1 hour).
4. `conversion_rate_pct`: The (total_conversions / total_applications) * 100.
5. `avg_purchase_value`: The average `purchase_value` for the successful conversions.

**Note:** If a user applies multiple promos before a purchase, only the *most recent* promo applied within the 1-hour window should be attributed to that purchase.

| **promo_code** | **total_applications** | **total_conversions** | **conversion_rate_pct** | **avg_purchase_value** |
| -------------------- | ---------------------------- | --------------------------- | ----------------------------- | ---------------------------- |
| FALL20               | 2                            | 1                           | 50.00                         | 80.00                        |
| NEWUSER15            | 1                            | 1                           | 100.00                        | 120.00                       |
| VIP_ONLY             | 1                            | 0                           | 0.00                          | NULL                         |
| FREESHIP             | 1                            | 1                           | 100.00                        | 210.00                       |
| FLASH10              | 1                            | 0                           | 0.00                          | NULL                         |
| COMEBACK5            | 1                            | 1                           | 100.00                        | 50.00                        |

### Tips for Approaching the Problem

1. **Isolate Event Types:** The easiest way to start is by creating two separate Common Table Expressions (CTEs): one for all `APPLY_PROMO` events and another for all `PURCHASE` events.
2. **Connect Promos to Purchases:** `LEFT JOIN` your `promo_events` CTE to your `purchase_events` CTE. The join conditions are key:
   * `ON promo_events.user_id = purchase_events.user_id`
   * `AND purchase_events.event_timestamp > promo_events.event_timestamp` (purchase must be *after* the promo)
   * `AND purchase_events.event_timestamp <= TIMESTAMPADD(HOUR, 1, promo_events.event_timestamp)` (purchase must be  *within 1 hour* ).
3. **Handle Promo Stacking:** The join above will match a purchase to *all* promos applied within the 1-hour window. The puzzle states only the *most recent* promo should get credit. To solve this, you need to rank the promos for each purchase.
   * In a new CTE, use `ROW_NUMBER()` over the results of your join.
   * `PARTITION BY purchase_events.log_id` (or `user_id` and `purchase_timestamp`).
   * `ORDER BY promo_events.event_timestamp DESC`. This will assign a `1` to the promo that was applied most recently before the purchase.
4. **Aggregate and Calculate:** Now you have a clean list of all promo applications and their associated purchases (if one exists and is ranked #1).
   * `GROUP BY promo_code`.
   * `COUNT(*)` gives `total_applications`.
   * `COUNT(purchase_log_id)` or `COUNT(CASE WHEN rank = 1 THEN 1 END)` gives `total_conversions`.
   * `AVG(CASE WHEN rank = 1 THEN purchase_value END)` gives `avg_purchase_value`.

**Your Solution:**

```sql
-- Write your solution here
```

