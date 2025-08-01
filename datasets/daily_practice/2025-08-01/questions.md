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
-- Write your solution here
```

## Question 2: Identifying "Pump and Dump" Patterns

Identify potential "pump and dump" schemes within the trade data. A pattern is defined as:

1. A price increase of at least 40% from a `low_point` to a `high_point` within a 15-minute window.
2. Followed by a price decrease of at least 30% from that `high_point` to a subsequent `low_point` within the next 30 minutes.

The report should show the `ticker_symbol`, the timestamp and price of the initial `low_point`, the peak `high_point`, and the final `low_point`, along with the price change percentages for both the "pump" and the "dump" phases.

**Expected Output:**

| **ticker_symbol** | **initial_low_time** | **initial_low_price** | | ticker_symbol | initial_low_time    | initial_low_price | peak_high_time      | peak_high_price | pump_increase_pct | final_low_time      | final_low_price | dump_decrease_pct |
| ------------- | ------------------- | ----------------- | ------------------- | --------------- | ----------------- | ------------------- | --------------- | ----------------- |
| BETA          | 2023-11-02 10:00:00 | 21.0000           | 2023-11-02 10:10:00 | 30.0000         | 42.86             | 2023-11-02 10:30:00 | 18.0000         | 40.00             |


**Your Solution:**

```sql
-- Write your solution here
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
-- Write your solution here
```
