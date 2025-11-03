## Puzzle: The Driver's "True Active Time"

**The Scenario:** As an operations manager for a food delivery service, you need to calculate the *true active time* for each driver to be used for payroll. "Active time" is any period a driver is marked as `ONLINE` or `ON_DELIVERY`. Time spent `OFFLINE` is unpaid.

**Your Task:** Write a query to calculate the total `active_time_minutes` for each driver for the day of  **'2023-11-25'** . The report must sum all time intervals where a driver was in an `ONLINE` or `ON_DELIVERY` state.

**Note:** If a driver's last status on that day is `ONLINE` or `ON_DELIVERY` (like Driver 103), their active time should be counted from that last status change until the end of the day (`'2023-11-26 00:00:00'`).

| **driver_id** | **total_active_time_minutes** |
| ------------------- | ----------------------------------- |
| 101                 | 450.00                              |
| 102                 | 300.00                              |
| 103                 | 360.00                              |

### Tips for Approaching the Problem

1. **Find the Next Event:** The key to this problem is to find the duration of each status. The duration of a status lasts from its `log_timestamp` until the `log_timestamp` of the *next* event for that driver. The `LEAD()` window function is perfect for this.
2. **Partition and Order:** Use `LEAD(log_timestamp, 1) OVER (PARTITION BY driver_id ORDER BY log_timestamp)` in a CTE to get the `end_time` for each status log.
3. **Handle the End of the Day:** The last event for a driver on that day will have a `NULL` `end_time` from the `LEAD()` function. You must replace this `NULL` with the end-of-day cutoff time (`'2023-11-26 00:00:00'`). Use the `COALESCE()` function for this.
4. **Filter for the Day:** Make sure you are only processing events that occurred on `'2023-11-25'`. You should filter the log table *before* applying the window functions for efficiency.
5. **Filter for Active States:** In your final `SELECT`, query from your CTE and filter for rows where the `status` is either `ONLINE` or `ON_DELIVERY`.
6. **Calculate and Aggregate:** Calculate the duration for each active row in minutes using `TIMESTAMPDIFF(MINUTE, start_time, end_time)`. Finally, `GROUP BY driver_id` and `SUM()` the calculated durations.

**Your Solution:**

```sql
-- Write your solution here
```
