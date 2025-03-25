## Question 1: Window Functions

Write a SQL query to find the highest paid employee in each department, along with their salary rank across the entire company. Also include what percentage their salary is of the total salary of all employees in their department.

**Expected Output Format:**

| department_name | employee_name   | salary   | company_rank | dept_salary_percentage |
| --------------- | --------------- | -------- | ------------ | ---------------------- |
| Finance         | Lisa Anderson   | 92000.00 | 1            | 58.97                  |
| Engineering     | John Smith      | 85000.00 | 2            | 28.33                  |
| Sales           | James Martinez  | 81000.00 | 3            | 34.32                  |
| Marketing       | Emily Davis     | 68000.00 | 4            | 52.31                  |
| HR              | Jennifer Thomas | 59000.00 | 5            | 100.00                 |

**Your Solution:**
```sql
WITH department_salaries AS (
    SELECT
        d.department_name,
        d.department_id,
        SUM(e.salary) AS dept_total_salary,
        MAX(e.salary) AS dept_highest_salary
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
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    ds.dept_highest_salary AS salary,
    RANK() OVER (ORDER BY e.salary DESC) AS company_rank,
    ROUND((ds.dept_highest_salary / ds.dept_total_salary) * 100, 2) AS dept_salary_percentage
FROM
    employees e
JOIN
    department_salaries ds ON e.department_id = ds.department_id
    AND e.salary = ds.dept_highest_salary
ORDER BY
    company_rank;
```

## Question 2: Common Table Expressions (CTE)

Write a SQL query to find employees who are working on more than one project. For these employees, return their full name, a list of the project names they are involved in, their roles in these projects, and the total duration (in days) of all the projects they are working on.

**Expected Output Format:**
| employee_name | project_names                 | roles                                     | total_project_druation_days |
| ------------- | ----------------------------- | ----------------------------------------- | --------------------------- |
| Jane Smith    | Project Alpha | Project Beta  | Software Engineer | Technical Contributor | 1170                        |
| John Doe      | Project Alpha | Project Gamma | Lead Engineer | Technical Lead            | 1184                        |

**Your Solution:**
```sql
WITH multi_project_employees AS (
  SELECT
  	employee_id
  FROM
  	employee_projects
  GROUP BY
  	employee_id
  HAVING 
  	COUNT(DISTINCT project_id) > 1
), target_projects AS (
  SELECT
  	ep.employee_id,
  	ep.project_id,
    ep.role
  FROM
  	employee_projects ep
  JOIN 
  	multi_project_employees mpe ON mpe.employee_id = ep.employee_id
), project_durations AS (
  SELECT
  	p.project_id,
    DATEDIFF(p.end_date, p.start_date) AS project_in_days
  FROM 
  	projects p
  JOIN
  	target_projects tp ON tp.project_id = p.project_id
)
SELECT
	CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    GROUP_CONCAT(DISTINCT p.project_name SEPARATOR ' | ') AS project_names,
    GROUP_CONCAT(DISTINCT tp.role SEPARATOR ' | ') AS roles,
    SUM(pd.project_in_days) AS total_project_druation_days
FROM
	target_projects tp
JOIN
	employees e ON e.employee_id = tp.employee_id
JOIN
	project_durations pd ON pd.project_id = tp.project_id
JOIN 
	projects p On p.project_id = pd.project_id
GROUP BY
	employee_name;

```

