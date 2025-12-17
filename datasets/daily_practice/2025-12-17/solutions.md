## Puzzle: The "Clopening" Shift Detector

**The Scenario:** "Clopening" is a retail term for when an employee works a closing shift one day and an opening shift the next morning with very little rest in between. This leads to burnout and errors. HR policies require at least **9 hours** of rest between shifts.

**Your Task:** Write a query to identify all instances where an employee had **less than 9 hours** of rest between the end of one shift and the start of their next shift.

The report should show the `employee_id`, the `shift_1_end` time, the `shift_2_start` time, and the `rest_duration_hours` (rounded to 2 decimal places).

**Note:** Ignore cases where the rest duration is 0 (back-to-back double shifts are handled separately). Only report cases where `rest_duration_hours > 0` AND `rest_duration_hours < 9`.

| **employee_id** | **shift_1_end** | **shift_2_start** | **rest_duration_hours** |
| --------------------- | --------------------- | ----------------------- | ----------------------------- |
| 102                   | 2023-12-16 23:30:00   | 2023-12-17 05:30:00     | 6.00                          |
| 104                   | 2023-12-17 22:00:00   | 2023-12-18 06:00:00     | 8.00                          |

### Tips for Approaching the Problem

1. **Look Ahead:** The key is to compare the end of the current shift with the start of the *next* shift for the same employee. The `LEAD()` window function is ideal for this.
2. **Partition and Order:** Use `LEAD(shift_start, 1) OVER (PARTITION BY employee_id ORDER BY shift_start)` to get the start time of the subsequent shift.
3. **Calculate Difference:** In a CTE or subquery, calculate the time difference in hours between the current row's `shift_end` and the `next_shift_start`.
4. **Filter:** In your final `WHERE` clause, filter for rows where the calculated rest is less than 9 hours but greater than 0.

**Your Solution:**

```sql
-- Write your solution here
```
