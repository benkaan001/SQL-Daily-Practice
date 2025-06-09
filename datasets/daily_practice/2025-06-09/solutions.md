## Question 1: Departmental Project Hours and Active Employees

For each department, calculate the total hours worked on each project in June 2025, and the number of unique active employees (those with no termination_date or a termination_date after '2025-06-01').

**Expected Output:**

| department  | project          | total_hours | active_employees |
| ----------- | ---------------- | ----------- | ---------------- |
| Engineering | Website Redesign | 45.00       | 3                |
| Engineering | Product Launch   | 37.50       | 3                |
| Marketing   | Product Launch   | 13.50       | 1                |

```sql
WITH active_emps AS (
  SELECT
  	d.department_id,
  	COUNT(DISTINCT e.employee_id) AS active_employees
  FROM
  	employees e
  JOIN
  	departments d ON e.department_id = d.department_id
  WHERE
    e.termination_date IS NULL OR e.termination_date > '2025-06-01'
  GROUP BY
  	d.department_id
),
project_hours AS (
  SELECT
    d.department_id,
    d.name AS department,
    p.name AS project,
    SUM(t.hours_worked) AS total_hours
  FROM
    departments d
  JOIN
    employees e ON e.department_id = d.department_id
  JOIN
    timesheets t ON t.employee_id = e.employee_id
  JOIN
    projects p ON t.project_id = p.project_id
  WHERE
    t.work_date BETWEEN '2025-06-01' AND '2025-06-30'
    AND (e.termination_date IS NULL OR e.termination_date > '2025-06-01')
  GROUP BY
    d.department_id,
    d.name,
    p.name
)
SELECT
	ph.department,
    ph.project,
    ph.total_hours,
    ae.active_employees
FROM
	project_hours ph
JOIN
	active_emps ae ON ae.department_id = ph.department_id;


```

---

## Question 2: Employee Work Streaks and Gaps

For each employee, find their longest streak of consecutive work days (in timesheets) in June 2025, and the longest gap (in days) between any two work days in June 2025.

**Expected Output:**

| name    | longest_streak | longest_gap |
|---------|----------------|-------------|
| Alice   | 3              | 1           |
| Eve     | 3              | 2           |
| Bob     | 2              | 2           |
| Diana   | 2              | 2           |

```sql
-- Write your SQL query here
```

---

## Question 2: Project Completion and Departmental Contribution

For each project that ended in May or June 2025, calculate:
- The department with the highest total hours contributed to the project
- The percentage of total project hours contributed by that department (rounded to 1 decimal)
- The number of employees from that department who contributed

**Expected Output:**

| project            | top_department | percent_contributed | employee_count |
|--------------------|---------------|--------------------|---------------|
| Recruitment Drive  | HR            | 100.0              | 1             |
| Product Launch     | Engineering   | 73.53              | 2             |

```sql
WITH total_project_hours AS (
  SELECT
    p.name AS project_name,
    SUM(t.hours_worked) AS total_project_hours
  FROM
    timesheets t
  JOIN
    projects p ON p.project_id = t.project_id
  WHERE
    p.end_date BETWEEN '2025-05-01' AND '2025-06-30'
  GROUP BY
    p.name
),
contributions AS (
  SELECT
    p.name AS project,
    d.name AS department,
    SUM(t.hours_worked) AS dept_total_hours,
    COUNT(DISTINCT e.employee_id) AS dept_employee_count
  FROM
    projects p
  JOIN
    timesheets t ON t.project_id = p.project_id
  JOIN
    employees e ON e.employee_id = t.employee_id
  JOIN
    departments d ON d.department_id = e.department_id
  WHERE
    p.end_date BETWEEN '2025-05-01' AND '2025-06-30'
  GROUP BY
    p.name,
    d.name
),
contribution_ranking AS (
  SELECT
    project,
    department,
    dept_total_hours,
    total_project_hours,
    dept_employee_count,
    RANK() OVER (PARTITION BY project ORDER BY dept_total_hours DESC) AS rnk
  FROM
    contributions c
  JOIN
    total_project_hours tph ON tph.project_name = c.project
)
SELECT
  project,
  department AS top_department,
  ROUND(dept_total_hours / total_project_hours * 100, 2) AS percent_contributed,
  dept_employee_count AS employee_count
FROM
  contribution_ranking
WHERE
  rnk = 1
ORDER BY
  percent_contributed DESC;
```
