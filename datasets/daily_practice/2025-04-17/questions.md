
## Question 1: Managers with Salary Less Than Twice the Average of Their Reports

Write a query to get the list of managers whose salary is less than twice the average salary of employees reporting to them. For these managers, output their ID, salary and the average salary of employees reporting to them.

**Expected Output:**

| manager_id | manager_salary | avg_report_salary |
|------------|---------------|------------------|
| E850       | 30000         | 20000            |
| E851       | 40000         | 18666.67         |
| E854       | 18000         | 16000            |

**Your Solution:**
```sql
-- Write your solution here
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
-- Write your solution here
```

---

## Question 3: Employees with No Reports and Salary Above Company Average

Find employees who do **not** manage anyone and whose salary is **above the company average**. Output their ID, name, and salary.

**Expected Output:**

| empl_id | empl_name         | salary |
|---------|-------------------|--------|
| E849    | Steven M. Jones   | 80000  |

**Your Solution:**
```sql
-- Write your solution here
```

---
