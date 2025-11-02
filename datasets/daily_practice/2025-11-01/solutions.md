## Puzzle: The "Quick Flip" Arbitrage

**The Scenario:** As a risk analyst for a trading platform, you need to identify traders who are performing "quick flip" arbitrage. This is defined as a trader buying a position in a currency pair and then selling the *exact same amount* of that pair for a profit within 60 minutes.

**Your Task:** Write a query to find every instance of a successful "quick flip." The report must show the `trader_id`, the `currency_pair`, the `buy_timestamp` and `buy_rate`, the `sell_timestamp` and `sell_rate`, and the total `profit` from the flip. The profit is calculated as `(sell_rate - buy_rate) * amount`.

**Note:** If a `BUY` is followed by multiple valid `SELL`s (of the same amount) within the 60-minute window, only the *first* `SELL` that occurred after the `BUY` should be counted as the "quick flip."

| **trader_id** | **currency_pair** | **buy_timestamp** | **buy_rate** | **sell_timestamp** | **sell_rate** | **profit** |
| ------------------- | ----------------------- | ----------------------- | ------------------ | ------------------------ | ------------------- | ---------------- |
| 101                 | EUR/USD                 | 2023-11-20 09:00:15.000 | 1.08500            | 2023-11-20 09:30:45.000  | 1.08750             | 25.00            |
| 101                 | GBP/USD                 | 2023-11-21 08:15:00.000 | 1.25200            | 2023-11-21 08:30:00.000  | 1.25450             | 20.00            |
| 102                 | USD/CAD                 | 2023-11-22 14:00:00.000 | 1.37000            | 2023-11-22 14:10:00.000  | 1.37500             | 25.00            |

### Tips for Approaching the Problem

1. **Isolate Buys and Sells:** The first step is to separate the two sides of the transaction. Create two Common Table Expressions (CTEs): one for all `BUY` events and one for all `SELL` events.
2. **Join Buys to Sells:** `JOIN` your `buy_cte` to your `sell_cte`. The join conditions are the key to finding a valid "flip":
   * `ON buys.trader_id = sells.trader_id`
   * `AND buys.currency_pair = sells.currency_pair`
   * `AND buys.amount = sells.amount` (the amount must be an exact match)
   * `AND sells.trade_timestamp > buys.trade_timestamp` (the sell must happen *after* the buy)
3. **Filter for Profit and Time:** In your `WHERE` clause, add the two business rules:
   * `sells.rate > buys.rate` (to ensure it's a profitable flip)
   * `sells.trade_timestamp <= TIMESTAMPADD(MINUTE, 60, buys.trade_timestamp)` (to ensure it happened within 60 minutes)
4. **Find the *****First***** Sell:** The join in step 2 might match one `BUY` to multiple `SELL`s. The puzzle requires only the *first* sell. To solve this, use the `ROW_NUMBER()` window function.
   * In a new CTE (after the join), partition by the `buy_trade_id` (or `trader_id`, `currency_pair`, and `buy_timestamp`).
   * `ORDER BY sells.trade_timestamp ASC`. This will assign a rank of `1` to the earliest sell for each buy.
   * In your final `SELECT`, filter for `WHERE rank = 1`.
5. **Calculate Profit:** In your final `SELECT` statement, add the profit calculation: `(sells.rate - buys.rate) * sells.amount AS profit`.

**Your Solution:**

```sql
WITH buy_trades AS(
	SELECT
		trade_id, trader_id, trade_timestamp, currency_pair, trade_type, amount, rate
	FROM
		forex_trades
	WHERE
		trade_type = 'BUY'
),
sell_trades AS (
	SELECT
		trade_id, trader_id, trade_timestamp, currency_pair, trade_type, amount, rate
	FROM
		forex_trades
	WHERE
		trade_type = 'SELL'
),
potential_flips AS (
	SELECT
		s.trader_id,
		s.currency_pair,
		b.trade_timestamp AS buy_timestamp,
		b.rate AS buy_rate,
		s.trade_timestamp AS sell_timestamp,
		s.rate AS sell_rate,
		s.amount,
		ROW_NUMBER() OVER (PARTITION BY b.trade_id ORDER BY s.trade_timestamp) AS rn
	FROM
		buy_trades b
	JOIN
		sell_trades s ON s.trader_id = b.trader_id
		AND s.currency_pair = b.currency_pair
		AND s.amount = b.amount
		AND s.rate > b.rate
		AND s.trade_timestamp > b.trade_timestamp
		AND s.trade_timestamp <= TIMESTAMPADD(MINUTE, 60, b.trade_timestamp)
)
SELECT
	trader_id,
	currency_pair,
	buy_timestamp,
	buy_rate,
	sell_timestamp,
	sell_rate,
	ROUND((sell_rate - buy_rate) * amount, 2) AS profit
FROM
	potential_flips
WHERE
	rn = 1;
```
