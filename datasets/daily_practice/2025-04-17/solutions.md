
## Question 1: Managers with Salary Less Than Twice the Average of Their Reports

Write a query to get the list of managers whose salary is less than twice the average salary of employees reporting to them. For these managers, output their ID, salary and the average salary of employees reporting to them.

**Expected Output:**

| manager_id | manager_salary | avg_report_salary |
|------------|---------------|------------------|
| E850       | 30000         | 20000            |
| E854       | 18000         | 16000            |

**Your Solution:**
```sql
WITH report_salaries AS (
  SELECT
      e.manager_empl_id AS manager_id,
      AVG(ed.salary) AS avg_report_salary
  FROM
      employees e
  JOIN
      employee_details ed ON e.empl_id = ed.empl_id
  WHERE
      e.manager_empl_id IS NOT NULL
  GROUP BY
      e.manager_empl_id
)
SELECT
    rs.manager_id,
    ed_mgr.salary AS manager_salary,
    rs.avg_report_salary
FROM
    report_salaries rs
JOIN
    employee_details ed_mgr ON rs.manager_id = ed_mgr.empl_id 
WHERE
    ed_mgr.salary < rs.avg_report_salary * 2;
```

---

## Question 2: Managers with the Most Direct Reports

Find the manager(s) with the highest number of direct reports. Output their ID, name, and the number of direct reports.

**Expected Output:**

| manager_id | manager_name        | direct_reports |
|------------|--------------------|---------------|
| E851       | Kyle M. Massey     | 3             |

**Your Solution:**
```sql
WITH max_employee_count AS (
  SELECT 
  	COUNT(*) AS direct_report_count 
  FROM 
  	employees 
  GROUP BY 
  	manager_empl_id 
  ORDER BY 
  	direct_report_count DESC 
  LIMIT 
  	1
)
SELECT
	e.manager_empl_id AS manager_id,
    ed.empl_name AS manager_name,
    COUNT(*) AS direct_reports
FROM
	employees e
JOIN
	employee_details ed ON ed.empl_id = e.manager_empl_id
WHERE
	e.manager_empl_id IS NOT NULL
GROUP BY
	e.manager_empl_id
HAVING 
	direct_reports = (SELECT direct_report_count FROM max_employee_count)
ORDER BY
	direct_reports DESC;
```

---

## Question 3: Employees with No Reports and Salary Above Company Average

Find employees who do **not** manage anyone and whose salary is **above the company average**. Output their ID, name, and salary.

**Expected Output:**

| empl_id | empl_name         | salary |
|---------|-------------------|--------|
|         |                   |        |

**Your Solution:**
```sql
WITH companywide_avg_salary AS (
  SELECT
  	AVG(salary) AS avg_salary
  FROM
  	employee_details
)
SELECT
	ed.empl_id,
    ed.empl_name,
    ed.salary
FROM
	employee_details ed
WHERE
	ed.salary > (SELECT avg_salary FROM companywide_avg_salary)
    AND ed.empl_id NOT IN (SELECT DISTINCT manager_empl_id FROM employees WHERE manager_empl_id IS NOT NULL);
```

---
