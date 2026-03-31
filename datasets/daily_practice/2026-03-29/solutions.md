## Puzzle: The True Moving Average (ROWS vs. RANGE)

**The Scenario:** The store manager wants a chart showing a **7-day rolling average** of their daily sales revenue. This helps smooth out the daily spikes and provides a clearer view of the business trend.

**The Catch:** The store is closed on certain days, meaning there are gaps in the dates. If you use a standard `ROWS 6 PRECEDING` window frame, SQL will grab the last 6 *recorded* rows, which might stretch back 9 or 10 actual calendar days, completely throwing off the true weekly average!

**Your Task:** Write a query that calculates a mathematically accurate 7-day rolling average for every recorded date. The 7-day window must include the current date and exactly the 6 preceding  *calendar days* , completely ignoring any days the store was closed rather than stretching further back in time.

The final report should show the `sales_date`, the daily `revenue`, and the `rolling_7_day_avg` (rounded to 2 decimal places). Order the results chronologically.

**Expected Output:**

| **sales_date** | **revenue** | **rolling_7_day_avg** |

| 2026-03-02 | 100.00 | 100.00 |

| 2026-03-03 | 150.00 | 125.00 |

| 2026-03-04 | 200.00 | 150.00 |

| 2026-03-06 | 300.00 | 187.50 |

| 2026-03-07 | 250.00 | 200.00 |

| 2026-03-09 | 400.00 | 260.00 |

| 2026-03-10 | 100.00 | 250.00 |

| 2026-03-11 | 350.00 | 280.00 |

*(Example Check: On March 9th, the previous 6 days are Mar 3 to Mar 8. The available revenues in that window are 150, 200, 300, 250, and the current 400. Their sum is 1300. Divided by the 5 available days = 260.00).*

### Tips for Approaching the Problem

1. **Understand Window Frames:** A standard window function uses `ROWS BETWEEN X PRECEDING AND CURRENT ROW`. `ROWS` blindly counts physical rows in the table.
2. **Shift to RANGE:** To evaluate data chronologically rather than sequentially, you must change your frame clause to use `RANGE`. `RANGE` evaluates the *actual value* in the `ORDER BY` column.
3. **Use Date Intervals:** When you use `ORDER BY sales_date` with `RANGE`, you can specify time-based intervals. Try using `RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW`. This tells the SQL engine to build a window based strictly on calendar math, flawlessly handling any missing rows!
4. **Formatting:** Don't forget to use `ROUND(..., 2)` on the final average.

**Your Solution:**

```sql
SELECT 
	sales_date, revenue,
	AVG(revenue) OVER (
        ORDER BY sales_date
        RANGE BETWEEN INTERVAL '6' DAY PRECEDING AND CURRENT ROW
    ) AS rolling_7_day_avg
FROM
	daily_store_sales
ORDER BY
	sales_date;
```
