**Question 6:**

**Explanation:** For each project, find the employee who joined the project earliest - based on employee hire date. Return the project name, the first name, and the last name of the employee, along with their role in the project.

**Expected Output:**

| project_name    | first_name | last_name | role            |
| --------------- | ---------- | --------- | --------------- |
| Project Alpha   | John       | Doe       | Lead Engineer   |
| Project Beta    | Mary       | Brown     | Sales Manager   |
| Project Delta   | Michael    | Davis     | Finance Analyst |
| Project Epsilon | NULL       | NULL      | NULL            |
| Project Gamma   | John       | Doe       | Technical Lead  |

**Solution Area:**

```sql
WITH earliest_employees AS (
  SELECT
      p.project_name,
      MIN(e.hire_date) AS hire_date
  FROM
      projects p
  LEFT JOIN
  	  employee_projects ep ON ep.project_id = p.project_id
  LEFT JOIN
  	  employees e ON e.employee_id = ep.employee_id
  GROUP BY
      p.project_name
), active_projects AS (
  SELECT
      p.project_name,
      e.first_name,
      e.last_name,
      ep.role
  FROM
      employees e
  JOIN
      employee_projects ep ON ep.employee_id = e.employee_id
  JOIN	
      projects p ON p.project_id = ep.project_id
  JOIN
      earliest_employees ee ON p.project_name = ee.project_name
      AND e.hire_date = ee.hire_date
)
SELECT
	p.project_name,
    ap.first_name,
    ap.last_name,
    ap.role
FROM
	projects p
LEFT JOIN
	active_projects ap ON ap.project_name = p.project_name
ORDER BY
	project_name;
```

**Question 7:**

**Explanation:** Calculate the total salary paid to employees in each department. Return the department name and the total salary, ordered by total salary in descending order.

**Expected Output:**

| department_name | total_salary |
| --------------- | ------------ |
| Engineering     | 410000.00    |
| Sales           | 218000.00    |
| Marketing       | 135000.00    |
| Finance         | 95000.00     |
| Human Resources | 62000.00     |

**Solution Area:**

```sql
SELECT
	d.department_name,
    SUM(e.salary) AS total_salary
FROM
	departments d
LEFT JOIN
	employees e ON e.department_id = d.department_id
GROUP BY
	d.department_name
ORDER BY
	total_salary DESC;
```

**Question 8:**

**Explanation:** Find the names of employees who are not currently assigned to any project. Return their first and last names.

**Expected Output:**

| first_name | last_name |
| ---------- | --------- |
| Jennifer   | Williams  |

**Solution Area:**

```sql
SELECT
	e.first_name,
    e.last_name
FROM
	employees e
LEFT JOIN
	employee_projects ep ON ep.employee_id = e.employee_id
WHERE
	ep.employee_id IS NULL;
```

**Question 9:**

**Explanation:** For each employee, find the number of projects they are currently working on (assuming "currently" means projects whose end date is in the future or today 2025-03-23). Return the employee's first and last name and the number of current projects.

**Expected Output:**

| first_name | last_name | current_projects |
| ---------- | --------- | ---------------- |
| John       | Doe       | 1                |
| Jane       | Smith     | 0                |
| Peter      | Jones     | 0                |
| Mary       | Brown     | 0                |
| David      | Wilson    | 1                |
| Sarah      | Miller    | 0                |
| Michael    | Davis     | 1                |
| Linda      | Garcia    | 1                |
| Robert     | Rodriguez | 1                |
| Jennifer   | Williams  | 0                |
| Charles    | Moore     | 1                |
| Jessica    | Taylor    | 0                |

**Solution Area:**

```sql
SELECT
	e.first_name,
    e.last_name,
    COALESCE(SUM(CASE WHEN p.end_date >= CURRENT_DATE THEN 1 ELSE 0 END), 0) AS current_projects
FROM
	employees e
LEFT JOIN
	employee_projects ep ON ep.employee_id = e.employee_id
LEFT JOIN
	projects p ON p.project_id = ep.project_id
GROUP BY
	e.first_name,
    e.last_name;
```

**Question 10:**

**Explanation:** Find the department with the highest average salary among employees hired after January 1, 2022. Return the department name and the average salary.

**Expected Output:**

| department_name | average_salary |
| --------------- | -------------- |
| Engineering     | 85000.00       |

**Solution Area:**

```sql
WITH average_salaries AS (
    SELECT
        d.department_name,
        ROUND(AVG(e.salary), 2) AS average_salary
    FROM
        departments d
    LEFT JOIN
        employees e ON d.department_id = e.department_id
    WHERE
        e.hire_date >= '2022-01-01'
    GROUP BY
        d.department_name
    )
SELECT
  department_name,
  average_salary
FROM
  average_salaries
WHERE
	average_salary = (SELECT MAX(average_salary) FROM average_salaries);
```

```sql
SELECT
    d.department_name,
    ROUND(AVG(e.salary), 2) AS average_salary
FROM
    departments d
LEFT JOIN
    employees e ON d.department_id = e.department_id
WHERE
    e.hire_date >= '2022-01-01'
GROUP BY
    d.department_name
ORDER BY
    average_salary DESC
LIMIT 1;
```

```sql
SELECT
    d.department_name,
    ROUND(AVG(e.salary), 2) AS average_salary
FROM
    departments d
LEFT JOIN
    employees e ON d.department_id = e.department_id
WHERE
    e.hire_date >= '2022-01-01'
GROUP BY
    d.department_name
HAVING
    AVG(e.salary) = 
        (
        SELECT MAX(avg_sal) 
        FROM 
            (
            SELECT AVG(salary) AS avg_sal 
            FROM employees 
            WHERE hire_date >= '2022-01-01' 
            GROUP BY department_id
            ) 
        AS temp
        );
```