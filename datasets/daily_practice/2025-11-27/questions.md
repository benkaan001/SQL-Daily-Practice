## Puzzle: The Net Billable Time Audit

**The Scenario:** As a payroll specialist, your task is to accurately calculate the net billable time for all employees for a specific day. Billable time includes any period between `SHIFT_START` and `SHIFT_END` that is **not** covered by a `BREAK_START` to `BREAK_END` interval. The presence of overlapping shifts (two `SHIFT_START` events without an intervening `SHIFT_END`) should be ignored, as you are concerned with the total billable time.

**Your Task:** Write a query to calculate the total `net_billable_hours` for each employee on the date  **'2023-11-28'** .

**Note:** Shifts that start or end on a different day must be truncated precisely to the start (00:00:00) or end (23:59:59.999) of the target day.

| **employee_id** | **net_billable_hours** |
| --------------------- | ---------------------------- |
| 101                   | 7.00                         |
| 102                   | 8.00                         |
| 103                   | 5.50                         |
| 104                   | 8.00                         |

### Tips for Approaching the Problem

1. **Define All Intervals:** The first step is to establish the time interval (start and end) for *every* logged event. Use the `LEAD()` window function, partitioned by `employee_id`, to find the `end_time` of each activity.
2. **Filter to Target Day:** In your final calculation, you must focus only on the target date. All intervals must be clipped by the bounds of the target day (2023-11-28 00:00:00 to 2023-11-29 00:00:00). You can handle this by using `GREATEST` and `LEAST` functions to limit the `start_time` and `end_time` to the target day's boundaries.
3. **Identify Billable Time:** A period is billable if:
   * It starts with `SHIFT_START` and ends with `BREAK_START`.
   * It starts with `BREAK_END` and ends with `SHIFT_END`.
   * It starts with `BREAK_END` and ends with `BREAK_START` (if the subsequent break starts immediately).
   * Essentially, any time between `SHIFT_START` and `SHIFT_END` that is not a defined break is billable. A simple way is to sum the duration of `SHIFT_START` to `BREAK_START` intervals and `BREAK_END` to `SHIFT_END` intervals.
4. **Calculate and Aggregate:** Sum the billable durations for all relevant intervals and convert the total minutes/seconds to hours (rounded to 2 decimal places).

**Your Solution:**

```sql
-- Write your solution here
```
