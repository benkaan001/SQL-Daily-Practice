## Puzzle: The Monthly OHLC Chart (First and Last Values)

**The Scenario:** You are building the backend for a cryptocurrency dashboard. The frontend charts require data in the standard **OHLC** format: Open, High, Low, and Close.

However, your raw data is just a stream of daily prices. Furthermore, crypto markets occasionally experience reporting outages, meaning you cannot guarantee a month will always have data exactly on the 1st or the 31st.

**Your Task:** Write a query to aggregate the daily prices into monthly OHLC records for each asset.

For every asset and every calendar month, you must determine:

1. `open_price`: The price on the *earliest* recorded date in that month.
2. `high_price`: The highest price recorded in that month.
3. `low_price`: The lowest price recorded in that month.
4. `close_price`: The price on the *latest* recorded date in that month.

The final report should show the `report_month` (formatted as 'YYYY-MM'), the `asset_id`, and the four calculated OHLC prices. Order the results chronologically by month, then alphabetically by asset.

**Expected Output:**

| **report_month** | **asset_id** | **open_price** | **high_price** | **low_price** | **close_price** |

| 2026-03 | BTC | 55000.00 | 61000.00 | 54000.00 | 59000.00 |

| 2026-03 | ETH | 2800.00 | 3200.00 | 2800.00 | 3100.00 |

| 2026-04 | BTC | 60000.00 | 65000.00 | 58000.00 | 62000.00 |

| 2026-04 | ETH | 3000.00 | 3500.00 | 3000.00 | 3200.00 |

### Tips for Approaching the Problem

This is a classic window function puzzle. While `MIN()` and `MAX()` easily solve the High and Low, getting the Open and Close requires a bit more care.

1. **The Window Partition:** All your window functions will need to evaluate data grouped by both the asset and the month. Create a formatted month string (e.g., `DATE_FORMAT(price_date, '%Y-%m')`) and `PARTITION BY asset_id, formatted_month`.
2. **The `FIRST_VALUE` Function:** To get the `open_price`, you can use `FIRST_VALUE(price) OVER (PARTITION BY ... ORDER BY price_date ASC)`. This effortlessly grabs the price from the earliest chronological row in that month's partition.
3. **The `LAST_VALUE` Trap:** You might be tempted to use `LAST_VALUE(price) OVER (PARTITION BY ... ORDER BY price_date ASC)` to get the close price. **Beware!** By default, window functions with an `ORDER BY` clause use a framing of `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`. This means `LAST_VALUE` will just return the *current row's* price, not the last row in the partition!
4. **The Safe Workaround:** Instead of wrestling with custom frame clauses (like `UNBOUNDED FOLLOWING`), the safest and cleanest way to get the last value is to simply use `FIRST_VALUE` again, but reverse the ordering!
   * `FIRST_VALUE(price) OVER (PARTITION BY ... ORDER BY price_date DESC)` will easily fetch the close price.
5. **Deduplicate:** Since window functions append these calculations to *every* row, you'll end up with duplicates. You can use a `ROW_NUMBER()` filter or apply `DISTINCT` in your final `SELECT` to clean up the output so there is only one row per asset per month.

**Your Solution:**

```sql
-- Write your solution here
```

