## Question 1: Daily Volatility and Volume Analysis

For each ticker symbol, analyze its daily trading activity. The report should identify days where both the price volatility and trading volume were "unusually high."

1. First, calculate the `daily_volatility` (the difference between the highest and lowest price) and `total_daily_volume` for each ticker on each trading day.
2. Next, for each day, calculate the `avg_volatility_3d` and `avg_volume_3d`, which are the average volatility and volume over a 3-day rolling window (the current day and the two previous trading days).
3. An "unusual" day is defined as a day where `daily_volatility` is more than 2x the `avg_volatility_3d` AND `total_daily_volume` is more than 1.5x the `avg_volume_3d`.

The final report should only list these unusual days. Order the results by `trade_date` and then by `ticker_symbol`.

**Expected Output:**

| trade_date | ticker_symbol | daily_volatility | total_daily_volume | avg_volatility_3d | avg_volume_3d |
| ---------- | ------------- | ---------------- | ------------------ | ----------------- | ------------- |
| 2023-11-03 | ALPHA         | 6.5000           | 17000              | 2.60              | 7500.00       |
| 2023-11-05 | GAMMA         | 10.0000          | 3500               | 3.33              | 1833.33       |

**Your Solution:**

```sql
WITH volatility AS (
SELECT
		DATE(trade_timestamp) AS trade_date,
		ticker_symbol,
		MAX(price) - MIN(price) AS daily_volatility,
		SUM(volume) AS total_daily_volume
	FROM
		stock_trades
	GROUP BY
		DATE(trade_timestamp),
		ticker_symbol
),
averages AS (
	SELECT
		trade_date,
		ticker_symbol,
		daily_volatility,
		total_daily_volume,
		AVG(daily_volatility) OVER (PARTITION BY ticker_symbol ORDER BY trade_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_volatility_3d,
		AVG(total_daily_volume) OVER (PARTITION BY ticker_symbol ORDER BY trade_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_volume_3d
	FROM
		volatility
)
SELECT
	trade_date,
	ticker_symbol,
	daily_volatility,
	total_daily_volume,
	ROUND(avg_volatility_3d, 2) AS avg_volatility_3d,
	ROUND(avg_volume_3d, 2) AS avg_volume_3d
FROM
	averages
WHERE
	daily_volatility > avg_volatility_3d * 2
	AND total_daily_volume > avg_volume_3d  * 1.5
ORDER BY
	trade_date,
	ticker_symbol;
```

## Question 2: Identifying "Pump and Dump" Patterns

Identify potential "pump and dump" schemes within the trade data. A pattern is defined as:

1. A price increase of at least 40% from a `low_point` to a `high_point` within a 15-minute window.
2. Followed by a price decrease of at least 30% from that `high_point` to a subsequent `low_point` within the next 30 minutes.

The report should show the `ticker_symbol`, the timestamp and price of the initial `low_point`, the peak `high_point`, and the final `low_point`, along with the price change percentages for both the "pump" and the "dump" phases.

**Expected Output:**

| ticker_symbol | initial_low_time    | initial_low_price | peak_high_time      | peak_high_price | pump_increase_pct | final_low_time      | final_low_price | dump_decrease_pct |
| ------------- | ------------------- | ----------------- | ------------------- | --------------- | ----------------- | ------------------- | --------------- | ----------------- |
| BETA          | 2023-11-02 10:00:00 | 21.0000           | 2023-11-02 10:10:00 | 30.0000         | 42.86             | 2023-11-02 10:30:00 | 18.0000         | 40.00             |                      |

**Your Solution:**

```sql
WITH pumps AS (
    SELECT
        low_point.ticker_symbol,
        low_point.trade_timestamp AS initial_low_time,
        low_point.price AS initial_low_price,
        high_point.trade_timestamp AS peak_high_time,
        high_point.price AS peak_high_price,
        -- Rank pumps starting at the same time by how high they went, to select the true peak
        ROW_NUMBER() OVER(PARTITION BY low_point.trade_id ORDER BY high_point.price DESC) as rn
    FROM
        stock_trades low_point
    JOIN
        stock_trades high_point ON low_point.ticker_symbol = high_point.ticker_symbol
        AND high_point.trade_timestamp > low_point.trade_timestamp
        AND TIMESTAMPDIFF(MINUTE, low_point.trade_timestamp, high_point.trade_timestamp) <= 15
    WHERE
        high_point.price >= low_point.price * 1.40 -- At least a 40% increase
),
dumps AS (
    SELECT
        p.ticker_symbol,
        p.initial_low_time,
        p.initial_low_price,
        p.peak_high_time,
        p.peak_high_price,
        final_low.trade_timestamp AS final_low_time,
        final_low.price AS final_low_price,
        -- Rank dumps from the same peak by how low they went, to select the true bottom
        ROW_NUMBER() OVER(PARTITION BY p.initial_low_time ORDER BY final_low.price ASC) as rn
    FROM
        pumps p
    JOIN
        stock_trades final_low ON p.ticker_symbol = final_low.ticker_symbol
        AND final_low.trade_timestamp > p.peak_high_time
        AND TIMESTAMPDIFF(MINUTE, p.peak_high_time, final_low.trade_timestamp) <= 30
    WHERE
        p.rn = 1 -- Only consider the true peak for each potential pump
        AND final_low.price <= p.peak_high_price * 0.70 -- At least a 30% decrease
)

-- Step 3: Select the best-fit pattern and calculate the final percentages
SELECT
    ticker_symbol,
    initial_low_time,
    initial_low_price,
    peak_high_time,
    peak_high_price,
    ROUND((peak_high_price - initial_low_price) * 100.0 / initial_low_price, 2) AS pump_increase_pct,
    final_low_time,
    final_low_price,
    ROUND((peak_high_price - final_low_price) * 100.0 / peak_high_price, 2) AS dump_decrease_pct
FROM
    dumps
WHERE
    rn = 1 -- Only select the most significant dump for each pump
ORDER BY
    initial_low_time;
```

## Question 3: Calculating Maximum Drawdown

For each ticker symbol, calculate its "Maximum Drawdown" over the entire period. The Maximum Drawdown is the largest percentage drop from a peak price to a subsequent trough price.

To solve this, for each point in time, you need to find the highest price seen *up to that point* (the running max). Then, calculate the percentage difference between that running max and the current price. The maximum of these percentage differences for a given stock is its Maximum Drawdown.

The report should show the `ticker_symbol`, the `peak_price` from which the drawdown began, the `trough_price` at the lowest point of the drawdown, and the calculated `max_drawdown_pct`, rounded to two decimal places.

**Expected Output:**

| ticker_symbol | peak_price | through_price | max_drawdown_pct |
| ------------- | ---------- | ------------- | ---------------- |
| ALPHA         | 155.0000   | 148.5000      | 4.19             |
| BETA          | 30.0000    | 18.0000       | 40.00            |
| DELTA         | 65.0000    | 45.0000       | 30.77            |
| GAMMA         | 300.0000   | 250.0000      | 16.67            |

**Your Solution:**

```sql
WITH running_max AS (
	SELECT
		ticker_symbol,
		trade_timestamp,
		price,
		MAX(price) OVER (PARTITION BY ticker_symbol ORDER BY trade_timestamp) AS running_max_price
	FROM
		stock_trades
),
drawdowns AS (
	SELECT
		ticker_symbol,
		running_max_price AS peak_price,
		price AS through_price,
		(running_max_price - price) * 100.0 / running_max_price AS drawdown_pct,
		ROW_NUMBER() OVER(PARTITION BY ticker_symbol ORDER BY (running_max_price - price) * 100.0 / running_max_price DESC) as rn
	FROM
		running_max

)
SELECT
	ticker_symbol,
	peak_price,
	through_price,
	ROUND(drawdown_pct, 2) AS max_drawdown_pct
FROM
	drawdowns
WHERE
	rn = 1
ORDER BY
	ticker_symbol;
```
