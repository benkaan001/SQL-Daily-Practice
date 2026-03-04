## Puzzle: The "Time Travel" Snapshot

**The Scenario:** The CFO is preparing the end-of-year financial reports for 2025. To ensure accuracy in their retrospective accounting, they need a snapshot of the company's payroll and headcount exactly as it stood at the end of the year.

**Your Task:** Write a query that reconstructs the active state of the company on  **'2025-12-31'** . Calculate the `headcount` and `total_salary` for each `department` based *only* on the employees who were actively employed on that specific date, using their correct salary and department assignment as of that date.

**Rules:**

1. An employee's record is valid from its `effective_date` until the `effective_date` of their *next* record.
2. If an employee has no subsequent records, their current record is valid indefinitely.
3. Employees with an `employment_status` of 'TERMINATED' on or before '2025-12-31' must not be included in the active headcount or salary sum.
4. Employees hired *after* '2025-12-31' must not be included.

Order the final report alphabetically by `department`.

**Expected Output:**

| **department** | **headcount** | **total_salary** |

| Engineering | 1 | 85000.00 |

| Product | 1 | 95000.00 |

| Sales | 1 | 75000.00 |

### Tips for Approaching the Problem

1. **Define the Lifespan of Each Record:** The raw table only gives you the `effective_date` (the start date). You need to calculate the `end_date` for each record to see if the target date ('2025-12-31') falls within that span. Use the `LEAD()` window function to grab the `effective_date` of the *next* chronological record for the same `employee_id`.
2. **Handle the "Current" Records:** For an employee's most recent record, `LEAD()` will return `NULL`. Wrap your `LEAD()` function in a `COALESCE()` or `IFNULL()` and provide a far-future date (like `'9999-12-31'`) so the logic doesn't break for active employees.
3. **Filter for the "As-Of" Date:** In your main query, filter the data so you only look at rows where the target date ('2025-12-31') is greater than or equal to the `effective_date` AND strictly less than the calculated `end_date`. This guarantees you only get exactly one row per employee who existed on that day.
4. **Exclude Terminations:** Add a condition to your `WHERE` clause to exclude any rows where the `employment_status` is 'TERMINATED'. Since you are looking at the specific record active on '2025-12-31', if the status was 'TERMINATED' at that time, they were no longer an active employee.
5. **Aggregate:** Finally, `GROUP BY department` and calculate your `COUNT(employee_id)` and `SUM(salary)`.

**Your Solution:**

```sql
-- Write your solution here
```
