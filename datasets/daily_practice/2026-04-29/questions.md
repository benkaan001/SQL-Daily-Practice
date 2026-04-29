## Puzzle: The "Golden Cross" Indicator

**The Scenario:** Quantitative analysts use Moving Average (MA) crossovers to generate automated buy and sell signals. A highly sought-after bullish signal is the  **"Golden Cross"** . This occurs when a short-term moving average crosses *above* a long-term moving average.

For this exercise, we will look for a Golden Cross between the **3-day** moving average and the **7-day** moving average.

**Your Task:** Write a query to find all dates where a "Golden Cross" occurred for any stock.

A Golden Cross is defined by these strict rules:

1. The 3-day MA on the current day is strictly **greater than** the 7-day MA on the current day.
2. On the *immediately preceding* trading day, the 3-day MA was **less than or equal to** the 7-day MA.
3. You must have at least 7 days of historical data to calculate a valid 7-day MA. Exclude any potential crossovers that happen before a stock's 7th recorded trading day.

*(Note: The 3-day MA includes the current day and the 2 preceding days. The 7-day MA includes the current day and the 6 preceding days).*

The final report should show the `ticker`, the `cross_date`, the `closing_price` on that day, and the calculated `ma_3_day` and `ma_7_day` (both rounded to 2 decimal places).

**Expected Output:**

| **ticker** | **cross_date** | **closing_price** | **ma_3_day** | **ma_7_day** |

| DATA | 2026-04-09 | 105.00 | 95.00 | 92.86 |

| DATA | 2026-04-18 | 115.00 | 105.00 | 101.71 |

*(Note: Ticker 'BEAR' does not appear because its 3-day MA is constantly dragged down by dropping prices, never crossing above its 7-day MA).*

### Tips for Approaching the Problem

1. **Calculate Multiple Moving Averages:** In your first Common Table Expression (CTE), calculate both the 3-day and 7-day moving averages simultaneously.
   * Use `AVG(closing_price) OVER (...)` partitioned by `ticker` and ordered by `trade_date`.
   * For the 3-day, use the frame clause `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW`.
   * For the 7-day, use `ROWS BETWEEN 6 PRECEDING AND CURRENT ROW`.
   * Also, include `ROW_NUMBER()` in this CTE so you know which "day number" you are on for each stock.
2. **Look Back at the Previous Day:** To detect a  *crossover* , you can't just check if `MA3 > MA7`. That might be true for weeks! You only want the specific day the flip happened.
   * Create a second CTE that queries your first one.
   * Use `LAG()` to pull the `prev_ma_3` and `prev_ma_7` into the current row.
3. **Apply the Golden Cross Logic:** In your final `SELECT`, apply your `WHERE` conditions:
   * `day_number >= 7` (Ensures the 7-day MA has enough data to be valid).
   * `ma_3 > ma_7` (The short-term trend is now higher).
   * `prev_ma_3 <= prev_ma_7` (The short-term trend *used to be* lower or equal, confirming a fresh crossing).

**Your Solution:**

```sql
-- Write your solution here
```
