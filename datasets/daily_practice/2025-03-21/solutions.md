**Question 1:**

**Explanation:** Find the names of all employees who are working on both 'Project Alpha' and 'Project Gamma'. Return their first and last names.

**Expected Output:**

| first_name | last_name |
|------------|-----------|
| John       | Doe       |

**Solution Area:**

```sql
SELECT
	e.first_name,
    e.last_name
FROM
	employees e 
JOIN
	employee_projects ep ON ep.employee_id = e.employee_id
JOIN	
	projects p ON p.project_id = ep.project_id
WHERE
	p.project_name = 'Project Alpha'
	AND EXISTS (
      	SELECT 1
        FROM employees e2 
      	JOIN employee_projects ep ON ep.employee_id = e2.employee_id
      	JOIN projects p ON p.project_id = ep.project_id
        WHERE p.project_name = 'Project Gamma'
        AND  e2.employee_id = e.employee_id);
```

**Question 2:**

**Explanation:** For each department, find the employee with the highest salary. Return the department name, the first name, and the last name of the employee, along with their salary.

**Expected Output:**

| department_name | first_name | last_name | salary   |
| --------------- | ---------- | --------- | -------- |
| Sales           | Mary       | Brown     | 90000.00 |
| Marketing       | David      | Wilson    | 70000.00 |
| Finance         | Michael    | Davis     | 95000.00 |
| Human Resources | Jennifer   | Williams  | 62000.00 |
| Engineering     | Charles    | Moore     | 92000.00 |

**Solution Area:**

```sql
WITH department_salaries AS (
    SELECT
      d.department_name,
  	  d.department_id,
      MAX(e.salary) AS salary
  FROM
      departments d
  JOIN 
      employees e ON e.department_id = d.department_id
  GROUP BY 
      d.department_name,
  	  d.department_id
)
SELECT
	ds.department_name,
    e.first_name,
    e.last_name,
    ds.salary
FROM
	department_salaries ds
JOIN	
	employees e ON e.department_id = ds.department_id AND e.salary = ds.salary;
```

**Question 3:**

**Explanation:** Find the names of all projects that started and ended within the year 2023. Return the project name and the start and end dates.

**Expected Output:**

| project_name  | start_date | end_date   |
|---------------|------------|------------|
| Project Alpha | 2023-01-01 | 2023-12-31 |

**Solution Area:**

```sql
SELECT
	project_name,
    start_date,
    end_date
FROM
	projects
WHERE
	YEAR(start_date) = 2023 AND YEAR(end_date) = 2023;
```

**Question 4:**

**Explanation:** For each employee, find the name of their manager. If an employee has no manager (i.e., they are a top-level manager), return `NULL` for the manager's name. Return the employee's first and last name, and their manager's first and last name.

**Expected Output:**

| employee_first_name | employee_last_name | manager_first_name | manager_last_name |
|---------------------|--------------------|--------------------|-------------------|
| John                | Doe                | NULL               | NULL              |
| Jane                | Smith              | John               | Doe               |
| Peter               | Jones              | Mary               | Brown             |
| Mary                | Brown              | NULL               | NULL              |
| David               | Wilson             | Mary               | Brown             |
| Sarah               | Miller             | John               | Doe               |
| Michael             | Davis              | Mary               | Brown             |
| Linda               | Garcia             | David              | Wilson            |
| Robert              | Rodriguez          | Jane               | Smith             |
| Jennifer            | Williams           | John               | Doe               |
| Charles             | Moore              | Sarah              | Miller            |
| Jessica             | Taylor             | Mary               | Brown             |

**Solution Area:**

```sql
SELECT
	e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    m.first_name AS manager_first_name,
    m.last_name AS manager_last_name
FROM
	employees e
JOIN 	
	employees m 
WHERE
	m.employee_id = e.manager_id
UNION ALL
SELECT
	first_name AS employee_first_name,
    last_name AS employee_last_name,
    'NULL' AS manager_first_name,
    'NULL' AS manager_last_name
FROM
	employees
WHERE
	manager_id IS NULL;
```

**Question 5:**

**Explanation:** Find the departments that have more than 2 employees. Return the department name and the number of employees in that department.

**Expected Output:**

| department_name | employee_count |
|-----------------|----------------|
| Sales           | 3              |
| Engineering     | 5              |

**Solution Area:**

```sql
SELECT
	d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM
	departments d
LEFT JOIN
	employees e ON d.department_id = e.department_id
GROUP BY
	d.department_name
HAVING
	employee_count > 2;
```
