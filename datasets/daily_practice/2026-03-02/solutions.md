## Puzzle: The Organizational Chart Generator

**The Scenario:** Human Resources needs a fully mapped organizational chart. The raw data only tells us who an employee's direct manager is. HR wants a report that maps out the entire chain of command and assigns a "Management Level" to each person.

**Your Task:** Write a query to generate the organizational chart. The CEO should be Level 1. Anyone reporting directly to the CEO is Level 2, their direct reports are Level 3, and so on.

The final report must include the `employee_id`, `employee_name`, `job_title`, `manager_name` (which should be `NULL` for the CEO), and the calculated `management_level`.

Order the results first by `management_level` (ascending), and then by `employee_id` (ascending).

**Expected Output:**

| **employee_id** | **employee_name** | **job_title**     | **manager_name** | **management_level** |
| --------------------- | ----------------------- | ----------------------- | ---------------------- | -------------------------- |
| 1                     | Alice CEO               | Chief Executive Officer | NULL                   | 1                          |
| 2                     | Bob VP                  | VP of Engineering       | Alice CEO              | 2                          |
| 3                     | Charlie VP              | VP of Sales             | Alice CEO              | 2                          |
| 4                     | David Dir               | Engineering Director    | Bob VP                 | 3                          |
| 8                     | Heidi Dir               | Sales Director          | Charlie VP             | 3                          |
| 5                     | Eve Mgr                 | Engineering Manager     | David Dir              | 4                          |
| 9                     | Ivan Rep                | Sales Representative    | Heidi Dir              | 4                          |
| 10                    | Judy Rep                | Sales Representative    | Heidi Dir              | 4                          |
| 6                     | Frank Eng               | Software Engineer       | Eve Mgr                | 5                          |
| 7                     | Grace Eng               | Software Engineer       | Eve Mgr                | 5                          |

### Tips for Approaching the Problem

1. **Use a Recursive CTE:** Hierarchical data (like employee/manager relationships) is the classic use case for a `WITH RECURSIVE` Common Table Expression.
2. **The Anchor Member:** The first part of a recursive CTE is the "anchor." This is the starting point of your hierarchy. Select the employee who has no manager (`manager_id IS NULL`). Hardcode their `management_level` as `1`.
3. **The Recursive Member:** The second part of the CTE (after the `UNION ALL`) references the CTE itself. You will `JOIN` the `employees` table to the CTE you are building.
   * Match the `employees.manager_id` to the CTE's `employee_id`.
   * For the level, take the CTE's `management_level` and add `1` to it.
4. **Get the Manager's Name:** Once your recursive CTE is complete, it will have all the levels calculated. However, you still need the manager's actual name (not just their ID) for the final output. In your final `SELECT` statement outside the CTE, do a `LEFT JOIN` back to the original `employees` table using the `manager_id` to fetch the manager's name.

**Your Solution:**

```sql
-- Write your solution here
```