## Puzzle: The Continuous Date Spine (Daily Headcount)

**The Scenario:** HR wants to visualize the daily employee headcount trend for **March 2026** on a line chart. However, your database only records the `hire_date` and `termination_date` for each employee. To draw a continuous trend line, your BI tool requires a data point for *every single day* of the month, regardless of whether a hiring or termination event occurred on that specific day.

**Your Task:** Write a query that generates a continuous daily headcount report from `'2026-03-01'` to `'2026-03-31'`.

**Rules:**

1. An employee is considered "active" on a `calendar_date` if their `hire_date` is on or before that date.
2. If an employee has a `termination_date`, they are considered active up to the day *before* their termination. They are NOT active on their actual `termination_date` (e.g., if terminated on Mar 5, their last active day was Mar 4).
3. The final report must include all 31 days in March 2026, ordered chronologically.

**Expected Output (Snippet):**

| **calendar_date** | **active_headcount** |
| ----------------------- | -------------------------- |
| 2026-03-01              | 3                          |
| 2026-03-02              | 3                          |
| 2026-03-03              | 3                          |
| 2026-03-04              | 3                          |
| 2026-03-05              | 2                          |
| ...                     | ...                        |
| 2026-03-11              | 2                          |
| 2026-03-12              | 3                          |
| ...                     | ...                        |
| 2026-03-24              | 3                          |
| 2026-03-25              | 4                          |
| 2026-03-26              | 4                          |
| 2026-03-27              | 4                          |
| 2026-03-28              | 3                          |
| ...                     | ...                        |
| 2026-03-31              | 3                          |

### Tips for Approaching the Problem

1. **Generate a Date Spine:** Because you don't have a pre-existing "calendar" table in the database, you must generate one on the fly. A `WITH RECURSIVE` Common Table Expression (CTE) is the standard way to generate a continuous sequence of dates. Start your anchor member with `'2026-03-01'` and recursively `DATE_ADD()` 1 day until you hit `'2026-03-31'`.
2. **The Range Join (Theta Join):** You need to match your generated calendar dates with the employees who were active on those dates. Use a `LEFT JOIN` from your calendar CTE to the `employee_lifecycle` table.
3. **Join Conditions:** Instead of an equals sign (`=`), your join condition will evaluate a date range overlapping your calendar day:
   `calendar.date >= employee.hire_date AND (employee.termination_date IS NULL OR calendar.date < employee.termination_date)`
4. **Aggregate:** Group by the `calendar_date` and `COUNT()` the `emp_id`s. Because you used a `LEFT JOIN`, any dates with zero active employees would correctly show a count of 0 instead of dropping out of your results.

**Your Solution:**

```sql
-- Write your solution here
```
