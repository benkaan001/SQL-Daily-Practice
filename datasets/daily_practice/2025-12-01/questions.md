## Puzzle: The Bid Efficiency Histogram

**The Scenario:** As an AdTech analyst, you need to find the "pricing sweet spot" for your campaigns. Bidding too low results in lost auctions, but bidding too high wastes budget. You need to analyze the Win Rate across different price ranges.

**Your Task:** Write a query that groups all bids into **$0.50 buckets** (e.g., 0.00-0.49, 0.50-0.99, 1.00-1.49, etc.) for each campaign.

For each `campaign_id` and `bid_bucket`, calculate:

1. `total_bids`: The number of auctions entered.
2. `win_rate_pct`: The percentage of auctions won (`WON` / `total_bids` * 100).
3. `total_spend`: The sum of the `clearing_price` for won auctions (Cost).

The final report should show the `campaign_id`, the `bucket_floor` (the lower bound of the bucket, e.g., 0.00, 0.50, 1.00), the `total_bids`, `win_rate_pct`, and `total_spend`.

Order the results by `campaign_id` and then `bucket_floor`.

| **campaign_id** | **bucket_floor** | **total_bids** | **win_rate_pct** | **total_spend** |
| --------------------- | ---------------------- | -------------------- | ---------------------- | --------------------- |
| Camp_A                | 0.00                   | 4                    | 25.00                  | 0.45                  |
| Camp_A                | 0.50                   | 2                    | 100.00                 | 1.60                  |
| Camp_B                | 1.00                   | 2                    | 0.00                   | 0.00                  |
| Camp_B                | 2.50                   | 3                    | 100.00                 | 6.80                  |
| Camp_C                | 0.00                   | 2                    | 0.00                   | 0.00                  |
| Camp_C                | 0.50                   | 2                    | 50.00                  | 0.80                  |
| Camp_C                | 1.00                   | 3                    | 100.00                 | 3.30                  |

### Tips for Approaching the Problem

1. **Calculate the Bucket Floor:** You need to convert a continuous value (`bid_amount`) into discrete steps of 0.5. The formula `FLOOR(bid_amount / 0.50) * 0.50` allows you to round every number down to the nearest 0.5 increment.
   * *Example:* Bid 0.40 -> 0.40/0.5 = 0.8 -> FLOOR(0.8) = 0 -> 0 * 0.5 =  **0.00** .
   * *Example:* Bid 0.90 -> 0.90/0.5 = 1.8 -> FLOOR(1.8) = 1 -> 1 * 0.5 =  **0.50** .
2. **Conditional Aggregation:** Use standard aggregation functions combined with `CASE` statements to calculate the metrics.
   * `win_rate`: `SUM(CASE WHEN outcome = 'WON' THEN 1 ELSE 0 END) / COUNT(*)`
   * `total_spend`: `SUM(COALESCE(clearing_price, 0))` (Using COALESCE is good practice, though LOST auctions should have NULL price anyway).
3. **Grouping:** Simply `GROUP BY campaign_id` and your calculated `bucket_floor`.

**Your Solution:**

```sql
-- Write your solution here
```
