## Puzzle: The Coffee Shop Rush Hour (Time Bucketing)

**The Scenario:** The manager of a busy local coffee shop wants to optimize the barista schedule. They know the morning is busy, but they need precise data. They have asked you to build a report that calculates the exact number of orders and total revenue generated in every **15-minute block** of the morning.

**Your Task:** Write a query to "bucket" or "bin" the `txn_time` into 15-minute intervals (e.g., 08:00:00, 08:15:00, 08:30:00).

For each 15-minute block that had activity, calculate the total `order_count` and the `total_revenue`.

The report should show the `interval_start` (formatted as a standard DATETIME), the `order_count`, and the `total_revenue`. Order the results chronologically.

**Expected Output:**

| **interval_start** | **order_count** | **total_revenue** |
| ------------------------ | --------------------- | ----------------------- |
| 2026-04-16 08:00:00      | 3                     | 15.00                   |
| 2026-04-16 08:15:00      | 2                     | 9.00                    |
| 2026-04-16 08:30:00      | 4                     | 22.50                   |
| 2026-04-16 09:00:00      | 1                     | 5.00                    |

### Tips for Approaching the Problem

Grouping timestamps into arbitrary intervals (like 15 minutes) can be tricky if you try to extract and manipulate the strings or use bulky `CASE` statements. The most elegant solution involves UNIX epoch math!

1. **Convert to UNIX Time:** The `UNIX_TIMESTAMP(datetime)` function converts a date and time into the total number of seconds since January 1, 1970. This turns your tricky datetime string into a simple, highly math-friendly integer.
2. **The Flooring Math Trick:** A 15-minute block is exactly **900 seconds** (15 * 60). If you divide a UNIX timestamp by 900, chop off the decimals using `FLOOR()`, and then multiply it back by 900, you effectively "round down" that timestamp to the nearest 15-minute marker!
   * *Formula:* `FLOOR(UNIX_TIMESTAMP(txn_time) / 900) * 900`
3. **Convert Back to Datetime:** Once you've mathematically rounded down the seconds, wrap the entire equation in the `FROM_UNIXTIME(...)` function. This translates the integer back into a human-readable `DATETIME` format. This becomes your `interval_start`.
4. **Aggregate:** Now that you have successfully converted `08:02:15` and `08:14:59` into identical `08:00:00` strings, you can simply `GROUP BY` your new `interval_start` column.
5. **Calculate Metrics:** In your `SELECT` statement, use `COUNT(txn_id)` and `SUM(amount)` to get the final metrics for each bucket.

**Your Solution:**

```sql
-- Write your solution here
```
