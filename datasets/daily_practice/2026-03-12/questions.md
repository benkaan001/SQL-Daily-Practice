## Puzzle: The Outperforming Subordinates

**The Scenario:** The HR Compensation Committee is running an audit to identify compensation anomalies. Specifically, they are looking for employees who are severely out-earning expectations relative to their direct leadership and their peers.

**Your Task:** Write a query to find all employees who meet **both** of the following conditions simultaneously:

1. They earn strictly  **more than their direct manager** .
2. They earn strictly  **more than the average salary of their respective department** .

The final report should show the `employee_name`, the `department_name`, the employee's `salary`, the `manager_salary`, and the `department_avg_salary` (rounded to two decimal places).

Order the results alphabetically by `department_name`, then by `employee_name`.

**Expected Output:**

| **employee_name** | **department_name** | **salary** | **manager_salary** | **department_avg_salary** |
| ----------------------- | ------------------------- | ---------------- | ------------------------ | ------------------------------- |
| Heidi                   | Engineering               | 170000.00        | 160000.00                | 142500.00                       |
| Liam                    | Marketing                 | 200000.00        | 90000.00                 | 128333.33                       |
| Eve                     | Sales                     | 160000.00        | 150000.00                | 122500.00                       |

*(Note: Kevin in Marketing makes more than his manager Judy, but is excluded because his $95k salary is below the Marketing average of ~$128k).*

### Tips for Approaching the Problem

This problem requires mixing relational concepts (managers to employees) with analytical concepts (department averages).

1. **Calculate Department Averages First:** The cleanest approach is to create a Common Table Expression (CTE) that uses the `AVG(salary) OVER (PARTITION BY department_name)` window function to append the exact department average to every employee's row. Let's call this CTE `emp_with_dept_avg`.
2. **The Self-Join:** To get the manager's salary on the same row as the employee, you need to `JOIN` the table to itself.
   * Query from your `emp_with_dept_avg` CTE (alias it as `e` for employee).
   * `JOIN` it back to the original `employees` table (alias it as `m` for manager).
   * The join condition is what links them together: `e.manager_id = m.employee_id`.
3. **Apply the Filters:** In your `WHERE` clause, you now have all three numbers available on the exact same row: the employee's salary (`e.salary`), the manager's salary (`m.salary`), and the department average (`e.dept_avg_salary`). Simply filter where the employee's salary is greater than both!

**Your Solution:**

```sql
-- Write your solution here
```
