## Puzzle: The Holiday Payroll Calculator

**The Scenario:** It's payday! As the HR Data Analyst, you need to calculate the gross pay for each employee for the week leading up to International Workers' Day. The company has strict rules regarding overtime and holiday pay.

**Your Task:** Write a query to calculate the `regular_hours`, `overtime_hours`, `holiday_hours`, and total `gross_pay` for each employee.

**Payroll Rules:**

1. **Regular Hours:** Paid at the standard `hourly_rate`. Applies to the first 8 hours worked on any non-holiday.
2. **Overtime Hours:** Paid at **1.5x** the standard `hourly_rate`. Applies to any hours worked *in excess of 8 hours* on a non-holiday.
3. **Holiday Hours:** Paid at **2.0x** the standard `hourly_rate`. Applies to *all* hours worked on a date listed in the `public_holidays` table. (Overtime rules do not compound on holidays; all holiday hours are simply 2x).

The final report should show the `emp_name` and the four calculated columns (rounded to 2 decimal places). Order the results by `gross_pay` in descending order.

**Expected Output:**

| **emp_name** | **regular_hours** | **overtime_hours** | **holiday_hours** | **gross_pay** |

| Alice | 16.00 | 2.50 | 5.00 | 892.50 |

| Bob | 8.00 | 1.00 | 10.00 | 737.50 |

| Charlie | 24.00 | 0.00 | 0.00 | 480.00 |

*(Math Check for Alice: 16 reg hours * $30 = $480. 2.5 OT hours * $45 = $112.50. 5 Holiday hours * $60 = $300. Total: $892.50).*

### Tips for Approaching the Problem

1. **Identify Holidays:** Start by joining the `timesheets` table to the `public_holidays` table. Use a `LEFT JOIN` on the date. If the joined holiday date is `NOT NULL`, you know that shift occurred on a holiday.
2. **Bucket the Hours:** In a Common Table Expression (CTE) or subquery, use `CASE` statements to break the single `hours_worked` column into three separate columns for each shift:
   * `daily_holiday_hours`: If it's a holiday, this gets *all* the `hours_worked`. Otherwise, `0`.
   * `daily_regular_hours`: If it's *not* a holiday, use `LEAST(hours_worked, 8)`. This grabs the hours up to the 8-hour cap.
   * `daily_overtime_hours`: If it's *not* a holiday, use `GREATEST(hours_worked - 8, 0)`. This safely isolates any hours above the 8-hour mark without dropping into negative numbers.
3. **Aggregate and Calculate Pay:** In your final `SELECT` statement, group by the employee.
   * `SUM()` the three daily hour buckets to get the totals.
   * Multiply each summed bucket by its respective multiplier (`1.0`, `1.5`, or `2.0`) and the employee's `hourly_rate` to calculate the final `gross_pay`.

**Your Solution:**

```sql
-- Write your solution here
```
