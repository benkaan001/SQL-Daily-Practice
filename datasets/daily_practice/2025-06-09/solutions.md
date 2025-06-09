## Question 1: Departmental Project Hours and Active Employees

For each department, calculate the total hours worked on each project in June 2025, and the number of unique active employees (those with no termination_date or a termination_date after '2025-06-01').

**Expected Output:**

| department   | project           | total_hours | active_employees |
|--------------|-------------------|-------------|------------------|
| Engineering  | Website Redesign  | 29.5        | 3                |
| Engineering  | Product Launch    | 14.0        | 3                |

```sql
-- Write your SQL query here
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

## Question 3: Project Completion and Departmental Contribution

For each project that ended in May or June 2025, calculate:
- The department with the highest total hours contributed to the project
- The percentage of total project hours contributed by that department (rounded to 1 decimal)
- The number of employees from that department who contributed

**Expected Output:**

| project            | top_department | percent_contributed | employee_count |
|--------------------|---------------|--------------------|---------------|
| Recruitment Drive  | HR            | 100.0              | 1             |
| Product Launch     | Engineering   | 57.1               | 2             |

```sql
-- Write your SQL query here
```
