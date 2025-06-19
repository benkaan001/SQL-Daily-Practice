### Question 1: Top 3 Highest Paid Employees Per Department

Retrieve the first name, last name, salary, department name, and rank of the top 3 highest-paid employees within each department. In case of ties in salary, all employees with the same salary should receive the same rank, and the next rank should be skipped (i.e., use a rank function that handles ties). If a department has fewer than 3 employees, display all of them. Order the results by department name ascending, then by salary descending, and finally by employee ID ascending.

**Expected Output:**

| first_name | last_name | salary    | department_name | employee_rank |
| ---------- | --------- | --------- | --------------- | ------------- |
| John       | Doe       | 150000.00 | Null            | 1             |
| Wendy      | Young     | 140000.00 | Null            | 2             |
| Alice      | Williams  | 130000.00 | Engineering     | 1             |
| Liam       | Harris    | 92000.00  | Engineering     | 2             |
| Kevin      | White     | 90000.00  | Engineering     | 3             |
| Mia        | Martin    | 90000.00  | Engineering     | 3             |
| Charlie    | Davis     | 115000.00 | Finance         | 1             |
| Rachel     | Clark     | 80000.00  | Finance         | 2             |
| Tina       | Walker    | 80000.00  | Finance         | 2             |
| Bob        | Brown     | 95000.00  | Human Resources | 1             |
| Paul       | Martinez  | 65000.00  | Human Resources | 2             |
| Quinn      | Robinson  | 50000.00  | Human Resources | 3             |
| Peter      | Jones     | 110000.00 | Marketing       | 1             |
| Hannah     | Anderson  | 70000.00  | Marketing       | 2             |
| Julia      | Jackson   | 70000.00  | Marketing       | 2             |
| Jane       | Smith     | 120000.00 | Sales           | 1             |
| Ethan      | Wilson    | 62000.00  | Sales           | 2             |
| Diana      | Miller    | 60000.00  | Sales           | 3             |
| Fiona      | Moore     | 60000.00  | Sales           | 3             |

**Your Solution:**

```sql
WITH ranked_employees AS (
    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        e.salary,
        d.department_name,
        RANK() OVER (PARTITION BY d.department_id ORDER BY e.salary DESC) AS employee_rank
    FROM
        Employees e
    LEFT JOIN
        Departments d ON e.department_id = d.department_id
)
SELECT
    first_name,
    last_name,
    salary,
    department_name,
    employee_rank
FROM
    ranked_employees
WHERE
    employee_rank <= 3
ORDER BY
    department_name ASC,
    salary DESC,
    employee_id ASC;

```

### Question 2: Salary Comparison Between Managed and Unmanaged Employees

Calculate the average salary of employees who report to a manager (i.e., `manager_id` is NOT NULL) and the average salary of employees who do not report to a manager (i.e., `manager_id` is NULL). Display both averages in a single result set, aliasing them as `avg_salary_managed` and `avg_salary_unmanaged` respectively. Consider that `department_id` can be NULL for unmanaged employees (e.g., CEO).

**Expected Output:**

| **avg_salary_managed** | **avg_salary_unmanaged** |
| ---------------------------- | ------------------------------ |
| 75750.00                     | 145000.00                      |

**Your Solution:**

```sql
WITH unmanaged_employees AS (
  SELECT
    ROUND(AVG(salary), 2) AS avg_salary_unmanaged
  FROM
    Employees
  WHERE
    manager_id IS NULL
),
managed_employees AS (
  SELECT
    ROUND(AVG(salary), 2) AS avg_salary_managed
  FROM
    Employees
  WHERE
    manager_id IS NOT NULL
)
SELECT
  avg_salary_managed,
  avg_salary_unmanaged
FROM
  unmanaged_employees
JOIN
  managed_employees;
```

### Question 3: Departments with Below Average Employee Tenure

Identify departments where the average tenure (time in years an employee has been with the company) of their employees is less than the overall average tenure of all employees across the entire company. Return the `department_name` and `average_tenure_years` for these departments. The average tenure should be calculated from the `hire_date` up to the current date (June 18, 2025). Round the average tenure years to two decimal places. Exclude employees with NULL `hire_date` if any (though none in this dataset). Order the results by `average_tenure_years` ascending.

**Expected Output:**

| **department_name** | **average_tenure_years** |
| ------------------------- | ------------------------------ |
| Human Resources           | 3.79                           |
| Sales                     | 4.00                           |
| Marketing                 | 4.86                           |

**Your Solution:**

```sql
WITH company AS (
  SELECT
    AVG(DATEDIFF('2025-06-18', hire_date)) / 365 AS company_tenure_years
  FROM
    Employees
  WHERE
    hire_date IS NOT NULL
)
SELECT
  d.department_name,
  ROUND(AVG(DATEDIFF('2025-06-18', e.hire_date)) / 365, 2) AS average_tenure_years
FROM
  Employees e
JOIN
  Departments d ON e.department_id = d.department_id
WHERE
  e.hire_date IS NOT NULL
GROUP BY
  d.department_name
HAVING
  average_tenure_years < (SELECT company_tenure_years FROM company)
ORDER BY
  average_tenure_years;
```
