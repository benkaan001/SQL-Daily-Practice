## Question 1: Departmental Project Hours and Active Employees

For each department, calculate the total hours worked on each project in June 2025, and the number of unique active employees (those with no termination_date or a termination_date after '2025-06-01').

- Show department name, project name, total hours worked (rounded to 1 decimal), and active employee count.
- Only include projects with at least 2 employees from the department logging hours in June 2025.
- Order by department name, then project name.

**Expected Output:**

| department  | project          | total_hours | active_employees |
| ----------- | ---------------- | ----------- | ---------------- |
| Engineering | Website Redesign | 45.00       | 3                |
| Engineering | Product Launch   | 37.50       | 3                |
| Marketing   | Product Launch   | 13.50       | 1                |



---

## Question 2: Project Completion and Departmental Contribution

For each project that ended in May or June 2025, calculate:
- The department with the highest total hours contributed to the project
- The percentage of total project hours contributed by that department (rounded to 1 decimal)
- The number of employees from that department who contributed

Show project name, top_department, percent_contributed, employee_count. Order by project name.

**Expected Output:**

| project            | top_department | percent_contributed | employee_count |
|--------------------|---------------|--------------------|---------------|
| Recruitment Drive  | HR            | 100.0              | 1             |
| Product Launch     | Engineering   | 73.53              | 2             |

