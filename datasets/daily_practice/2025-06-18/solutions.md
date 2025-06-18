## Question 1: Departmental Performance Review

Management wants to identify top-performing employees within each department based on hours logged in Q1 2023 (January-March).

Write a query that ranks employees within each department by their total hours worked during this period. The output must include the department, employee name, their total hours, and their rank.
Additionally, show the total hours worked by the employee ranked just below them in the same department.
For the lowest-ranked employee in a department, this value should be `NULL`.

Order the results by department and then by rank.

**Expected Output:**

| department   | employee_name   | total_hours | rank | next_employee_hours |
| ------------ | --------------- | ----------- | ---- | ------------------- |
| Data Science | Clara Rodriguez | 49.50       | 1    | 8.00                |
| Data Science | David Chen      | 8.00        | 2    |                     |
| Engineering  | Adeline Carter  | 45.00       | 1    | 31.50               |
| Engineering  | Benjamin Hayes  | 31.50       | 2    |                     |
| Product      | Eleanor Vance   | 23.50       | 1    |                     |

**Your Solution:**
```sql
WITH department_hours AS (
  SELECT
    e.department,
    e.employee_name,
    ROUND(SUM(pl.hours_worked), 2) AS total_hours
  FROM
    employees e
  JOIN
    project_logs pl ON e.employee_id = pl.employee_id
  WHERE
    pl.log_date BETWEEN '2023-01-01' AND '2023-03-31'
  GROUP BY
    e.department,
    e.employee_name
)
SELECT
  department,
  employee_name,
  total_hours,
  RANK() OVER (PARTITION BY department ORDER BY total_hours DESC) AS `rank`,
  LEAD(total_hours, 1, NULL) OVER (PARTITION BY department ORDER BY total_hours DESC) AS next_employee_hours
FROM
  department_hours
ORDER BY
  department,
  `rank`;
```

---

## Question 2: Employee Productivity Growth

The HR department wants to identify employees who have frequently shown increased productivity over the course of the year.

Write a query to find all employees who have had a total of three or more month-over-month increases in their logged hours during 2023. These increases do not need to be in consecutive months.

**Expected Output:**

| employee_id | employee_name  |
|-------------|----------------|


**Your Solution:**
```sql
WITH monthly_hours AS (
  SELECT
    e.employee_id,
    e.employee_name,
    MONTH(pl.log_date) AS work_month,
    SUM(pl.hours_worked) AS total_hours
  FROM
    project_logs pl
  JOIN
    employees e ON e.employee_id = pl.employee_id
  WHERE
  	YEAR(pl.log_date) = 2023
  GROUP BY
    e.employee_id,
    e.employee_name,
    MONTH(pl.log_date)
),
consecutive_hours AS (
  SELECT
    employee_id,
    employee_name,
    work_month,
    total_hours,
    LEAD(total_hours, 1, NULL) OVER (PARTITION BY employee_id ORDER BY work_month) AS next_month_hours
  FROM
    monthly_hours
),
consecutive_counts AS (
  SELECT
    employee_id,
    employee_name,
    SUM(CASE WHEN next_month_hours > total_hours THEN 1 ELSE 0 END) AS consecutive_count
  FROM
    consecutive_hours
  WHERE
    next_month_hours IS NOT NULL
  GROUP BY
    employee_id,
    employee_name
)
SELECT
  employee_id,
  employee_name
FROM
  consecutive_counts
WHERE
  consecutive_count >= 3;
```

---

## Question 3: Project Labor Cost Analysis

The finance team needs to understand the monthly labor costs associated with each project. Assume a standard 160 working hours per month to calculate an employee"s hourly rate based on their salary.

Write a query that calculates the total labor cost for each project for each month in 2023. The final report should be a pivoted table with `project_name` as rows and the months (`Jan`, `Feb`, `Mar`, `Apr`, etc.) as columns. The values should be the total calculated cost for that project in that month, rounded to two decimal places.

Labor cost for a log entry is `hours_worked * (salary / 160)`.

**Expected Output:**

| project_name    | Jan_2023 | Feb_2023 | Mar_2023 | Apr_2023 | May_2023 | Jun_2023 |
| --------------- | -------- | -------- | -------- | -------- | -------- | -------- |
| Project Alpha   | 15203.13 | 12546.88 | 4750.00  | 5343.75  | 0.00     | 0.00     |
| Project Gamma   | 0.00     | 3562.50  | 10531.25 | 0.00     | 0.00     | 0.00     |
| Project Beta    | 0.00     | 5250.00  | 8250.00  | 8500.00  | 3750.00  | 0.00     |
| Project Phoenix | 11343.75 | 10656.25 | 4900.00  | 9493.75  | 0.00     | 0.00     |
| Project Delta   | 0.00     | 0.00     | 12031.25 | 12531.25 | 10412.50 | 5818.75  |


**Your Solution:**
```sql
SELECT
  pl.project_name,
  ROUND(SUM(CASE WHEN MONTH(pl.log_date) = 1 THEN pl.hours_worked * (e.salary / 160) ELSE 0 END), 2) AS Jan_2023,
  ROUND(SUM(CASE WHEN MONTH(pl.log_date) = 2 THEN pl.hours_worked * (e.salary / 160) ELSE 0 END), 2) AS Feb_2023,
  ROUND(SUM(CASE WHEN MONTH(pl.log_date) = 3 THEN pl.hours_worked * (e.salary / 160) ELSE 0 END), 2) AS Mar_2023,
  ROUND(SUM(CASE WHEN MONTH(pl.log_date) = 4 THEN pl.hours_worked * (e.salary / 160) ELSE 0 END), 2) AS Apr_2023,
  ROUND(SUM(CASE WHEN MONTH(pl.log_date) = 5 THEN pl.hours_worked * (e.salary / 160) ELSE 0 END), 2) AS May_2023,
  ROUND(SUM(CASE WHEN MONTH(pl.log_date) = 6 THEN pl.hours_worked * (e.salary / 160) ELSE 0 END), 2) AS Jun_2023
FROM
  project_logs pl
LEFT JOIN
  employees e ON pl.employee_id = e.employee_id
WHERE
  YEAR(pl.log_date) = 2023
GROUP BY
  pl.project_name;
```

