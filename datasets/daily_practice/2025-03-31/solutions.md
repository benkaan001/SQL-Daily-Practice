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
WITH department_counts AS (
  SELECT
    department_id,
    department_name,
    COUNT(DISTINCT id) AS emp_count
  FROM
    employees
  GROUP BY
    department_id,
    department_name
  ORDER BY
    emp_count DESC, 
    department_name
  LIMIT 1
)
SELECT
	e.first_name,
    e.last_name,
    e.department_name
FROM
	employees e
JOIN
	department_counts dc ON dc.department_name = e.department_name
WHERE 
	e.position = 'Manager';
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
SELECT
	department_name,
    COUNT(id) AS non_manager_count
FROM
	employees
WHERE
	LOWER(position) NOT LIKE '%manager%'
GROUP BY
	department_name
HAVING
	non_manager_count >= 2;
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
WITH position_counts AS (
  SELECT
  	department_name,
  	COUNT(DISTINCT position) AS position_count
  FROM
  	employees
  GROUP BY
  	department_name
  HAVING position_count > 1
)
SELECT
	e.department_name,
    GROUP_CONCAT(DISTINCT e.position
                ORDER BY e.position
                SEPARATOR ', ') AS positions
FROM
	employees e
JOIN
	position_counts pc ON e.department_name = pc.department_name
GROUP BY
	e.department_name;
```