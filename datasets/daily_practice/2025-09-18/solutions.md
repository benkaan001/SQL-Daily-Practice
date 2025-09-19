## Puzzle: The Realized Gains Calculator (FIFO)

**The Scenario:** As a financial data analyst, you need to calculate the "realized capital gains" for each user and for each stock they have traded. A realized gain occurs only when a stock is sold. The calculation must follow the First-In, First-Out (FIFO) accounting principle. This means that when shares are sold, they are assumed to be the ones that were purchased earliest.

**Your Task:** Write a query that calculates the total `realized_gain` for each `user_id` and `ticker_symbol` pair. The gain from a sale is calculated as `(sell_price - buy_price) * quantity_sold`. You must correctly match the shares sold against the shares bought using the FIFO method.

The final report should show the `user_id`, `ticker_symbol`, and the total `realized_gain`. Only include users and tickers where at least one sale has occurred.

| **user_id** | **ticker_symbol** | **realized_gain** |
| ----------------- | ----------------------- | ----------------------- |
| 101               | AAPL                    | 110.00                  |
| 101               | TSLA                    | 60.00                   |
| 102               | GOOG                    | 200.00                  |
| 103               | MSFT                    | 1150.00                 |


The key to solving it effectively is to methodically match the shares being sold to the shares that were bought first.

Here's a breakdown of the steps you can take to approach this problem:

1.  **Number Your Buys and Sells:** The first step is to establish a clear chronological order. Use a window function like `ROW_NUMBER()` to create separate, ordered lists for both `BUY` and `SELL` transactions for each user and ticker.

2.  **Calculate Running Totals (Cumulative Sums):** This is the most critical step. For both your ordered `BUY` list and your `SELL` list, calculate a running total of the `quantity`. This will tell you, for any given transaction, the total number of shares that have been bought or sold up to that point. The `SUM() OVER (PARTITION BY ... ORDER BY ...)` window function is perfect for this.

3.  **Join Buys to Sells:** Now you need to connect every `SELL` transaction with every `BUY` transaction that could potentially be part of that sale (i.e., all buys that happened *before* that sell for the same user and ticker).

4.  **Find the "Overlap":** This is the core of the FIFO logic. For each `SELL-BUY` pair from your join, you need to figure out exactly how many shares from that *specific* buy lot were part of that *specific* sell. You can do this by looking at the cumulative quantities you calculated in step 2. The number of shares sold from a buy lot in a given sale is essentially the "overlap" between the cumulative buy range and the cumulative sell range.

5.  **Calculate the Gain:** Once you know the exact number of shares from a specific buy lot that were sold at a specific sell price, you can calculate the gain for that portion: `(sell_price - buy_price) * quantity_from_that_lot`.

6.  **Aggregate:** Finally, group your results by `user_id` and `ticker_symbol` and `SUM()` the gains you calculated in the previous step to get the total realized gain.

Thinking about the problem in terms of creating running totals first is the most effective way to crack the complex matching logic. Good luck!

**Your Solution:**

```sql
WITH buys AS (
	SELECT
		user_id,
		ticker_symbol,
		quantity ,
		price_per_share,
		trade_timestamp,
		ROW_NUMBER() OVER (PARTITION BY user_id, ticker_symbol ORDER BY trade_timestamp) AS buy_rn,
		SUM(quantity) OVER (PARTITION BY user_id, ticker_symbol ORDER BY trade_timestamp) AS buy_running_total
	FROM
		stock_trades
	WHERE
		trade_type = 'BUY'
),
sells AS (
	SELECT
		user_id,
		ticker_symbol,
		quantity ,
		price_per_share,
		trade_timestamp,
		ROW_NUMBER() OVER (PARTITION BY user_id, ticker_symbol ORDER BY trade_timestamp) AS sell_rn,
		SUM(quantity) OVER (PARTITION BY user_id, ticker_symbol ORDER BY trade_timestamp) sell_running_total
	FROM
		stock_trades
	WHERE
		trade_type = 'SELL'
),
filtered_trades AS (
	SELECT
		b.user_id,
		b.ticker_symbol,
		b.quantity AS buy_quantity,
		s.quantity AS sell_quantity,
		b.price_per_share AS buy_price,
		s.price_per_share AS sell_price,
		b.trade_timestamp AS buy_timestamp,
		s.trade_timestamp AS sell_timestamp,
		b.buy_rn,
		s.sell_rn,
		b.buy_running_total,
		s.sell_running_total,
		GREATEST(0,
	    LEAST(b.buy_running_total, s.sell_running_total) -
	    GREATEST(b.buy_running_total - b.quantity, s.sell_running_total - s.quantity)) AS fifo_quantity
	FROM
		buys b
	JOIN
		sells s ON b.user_id = s.user_id
		AND b.ticker_symbol = s.ticker_symbol
		AND b.trade_timestamp < s.trade_timestamp
)
SELECT
	user_id,
	ticker_symbol,
	SUM((sell_price - buy_price) * fifo_quantity) AS gain
FROM
	filtered_trades
GROUP BY
	user_id,
	ticker_symbol;
```
