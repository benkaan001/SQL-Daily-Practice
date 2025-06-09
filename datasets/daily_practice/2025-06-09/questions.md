## Question 1: Departmental Project Hours and Active Employees

For each department, calculate the total hours worked on each project in June 2025, and the number of unique active employees (those with no termination_date or a termination_date after '2025-06-01').

- Show department name, project name, total hours worked (rounded to 1 decimal), and active employee count.
- Only include projects with at least 2 employees from the department logging hours in June 2025.
- Order by department name, then project name.

**Expected Output:**

| department   | project           | total_hours | active_employees |
|--------------|-------------------|-------------|------------------|
| Engineering  | Website Redesign  | 29.5        | 3                |
| Engineering  | Product Launch    | 14.0        | 3                |

---

## Question 2: Employee Work Streaks and Gaps

For each employee, find their longest streak of consecutive work days (in timesheets) in June 2025, and the longest gap (in days) between any two work days in June 2025.

- Show employee name, longest_streak (days), longest_gap (days).
- If an employee only worked one day, longest_streak should be 1 and longest_gap should be NULL.
- Order by longest_streak descending, then name ascending.

**Expected Output:**

| name    | longest_streak | longest_gap |
|---------|----------------|-------------|
| Alice   | 3              | 1           |
| Eve     | 3              | 2           |
| Bob     | 2              | 2           |
| Diana   | 2              | 2           |

---

## Question 3: Project Completion and Departmental Contribution

For each project that ended in May or June 2025, calculate:
- The department with the highest total hours contributed to the project
- The percentage of total project hours contributed by that department (rounded to 1 decimal)
- The number of employees from that department who contributed

Show project name, top_department, percent_contributed, employee_count. Order by project name.

**Expected Output:**

| project            | top_department | percent_contributed | employee_count |
|--------------------|---------------|--------------------|---------------|
| Recruitment Drive  | HR            | 100.0              | 1             |
| Product Launch     | Engineering   | 57.1               | 2             |

