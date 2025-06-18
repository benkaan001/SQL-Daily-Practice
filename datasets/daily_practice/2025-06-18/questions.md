## Question 1: Departmental Performance Review

Management wants to identify top-performing employees within each department based on hours logged in Q1 2023 (January-March).

Write a query that ranks employees within each department by their total hours worked during this period. The output must include the department, employee name, their total hours, and their rank.
Additionally, show the total hours worked by the employee ranked just below them in the same department.
For the lowest-ranked employee in a department, this value should be `NULL`.

Order the results by department and then by rank.

**Expected Output:**

| department   | employee_name    | total_hours | rank | next_employee_hours |
|--------------|------------------|-------------|------|---------------------|
| Data Science | Clara Rodriguez  | 49.50       | 1    | 8.00                |
| Data Science | David Chen       | 8.00        | 2    | NULL                |
| Engineering  | Adeline Carter   | 45.00       | 1    | 15.00               |
| Engineering  | Benjamin Hayes   | 15.00       | 2    | NULL                |
| Product      | Eleanor Vance    | 23.50       | 1    | NULL                |


**Your Solution:**
```sql
-- Write your solution here

```

---

## Question 2: Employee Productivity Growth

The HR department is looking for employees who have shown a consistent increase in productivity. An indicator of this is an increase in total logged hours for three consecutive months.

Write a query to find all employees who had a month-over-month increase in their total logged hours for at least three consecutive months during 2023.

For example, an employee qualifies if their total hours in March were greater than February, AND their total hours in February were greater than January.

**Expected Output:**

| employee_id | employee_name  |
|-------------|----------------|
| 104         | David Chen     |


**Your Solution:**
```sql
-- Write your solution here

```

---

## Question 3: Project Labor Cost Analysis

The finance team needs to understand the monthly labor costs associated with each project. Assume a standard 160 working hours per month to calculate an employee"s hourly rate based on their salary.

Write a query that calculates the total labor cost for each project for each month in 2023. The final report should be a pivoted table with `project_name` as rows and the months (`Jan`, `Feb`, `Mar`, `Apr`, etc.) as columns. The values should be the total calculated cost for that project in that month, rounded to two decimal places.

Labor cost for a log entry is `hours_worked * (salary / 160)`.

**Expected Output:**

| project_name    | Jan_2023 | Feb_2023 | Mar_2023 | Apr_2023 | May_2023 | Jun_2023 |
|-----------------|----------|----------|----------|----------|----------|----------|
| Project Alpha   | 9687.50  | 5054.69  | 4718.75  | 5343.75  | 0.00     | 0.00     |
| Project Beta    | 0.00     | 0.00     | 8250.00  | 8500.00  | 3750.00  | 0.00     |
| Project Delta   | 0.00     | 0.00     | 6168.75  | 6515.63  | 10412.50 | 5821.88  |
| Project Gamma   | 0.00     | 3562.50  | 4168.75  | 0.00     | 0.00     | 0.00     |
| Project Phoenix | 11343.75 | 10656.25 | 4900.00  | 9509.38  | 0.00     | 0.00     |


**Your Solution:**
```sql
-- Write your solution here
```

