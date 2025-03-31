## Question 1: Manager from Largest Department
Find the name of the manager from the department that has the largest number of employees.  
A manager is any employee whose position contains the word "Manager" (case‐insensitive).  
In case of ties, return the manager from the department with the lexicographically smallest department_name.  
Output the manager's first name, last name, and department_name.

**Expected Output Format:**

| first_name | last_name | department_name   |
| ---------- | --------- | ----------------- |
| Sara       | Davis     | Human Resources   |

**Your Solution:**
```sql
-- Write your solution here
```

## Question 2: Non-Manager Employee Counts by Department
For each department, count the number of employees whose position does **not** contain the word "Manager" (case‐insensitive).  
List only the departments with at least two non-manager employees.  
Output the department_name and the count of non-manager employees.

**Expected Output Format:**

| department_name   | non_manager_count |
| ----------------- | ----------------- |
| Marketing         | 2                 |
| Human Resources   | 2                 |
| Operations        | 2                 |
| Sales             | 2                 |

**Your Solution:**
```sql
-- Write your solution here
```

## Question 3: Distinct Positions by Department
Identify departments that have more than one distinct position title. For each such department, output the department_name and a comma-separated list of distinct positions (sorted alphabetically).

**Expected Output Format:**

| department_name   | positions                                   |
| ----------------- | ------------------------------------------- |
| Human Resources   | Intern, Manager, Senior specialist          |
| Marketing         | Manager, Senior specialist                  |
| Operations        | Intern, Manager, Senior specialist          |
| Finance           | Manager, Senior specialist                  |
| Sales             | Intern, Senior specialist                   |

**Your Solution:**
```sql
-- Write your solution here
```