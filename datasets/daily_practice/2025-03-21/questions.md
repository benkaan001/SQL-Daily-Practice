**Question 1:**

**Explanation:** Find the names of all employees who are working on both 'Project Alpha' and 'Project Gamma'. Return their first and last names.

**Expected Output:**

| first_name | last_name |
|------------|-----------|
| John       | Doe       |

**Solution Area:**

```sql
-- Paste your SQL solution here
```

**Question 2:**

**Explanation:** For each department, find the employee with the highest salary. Return the department name, the first name, and the last name of the employee, along with their salary.

**Expected Output:**

| department_name | first_name | last_name | salary   |
|-----------------|------------|-----------|----------|
| Sales           | Mary       | Brown     | 90000.00 |
| Marketing       | Linda      | Garcia    | 65000.00 |
| Engineering     | Charles    | Moore     | 92000.00 |
| Finance         | Michael    | Davis     | 95000.00 |
| Human Resources | Jennifer   | Williams  | 62000.00 |

**Solution Area:**

```sql
-- Paste your SQL solution here
```

**Question 3:**

**Explanation:** Find the names of all projects that started and ended within the year 2023. Return the project name and the start and end dates.

**Expected Output:**

| project_name  | start_date | end_date   |
|---------------|------------|------------|
| Project Alpha | 2023-01-01 | 2023-12-31 |
| Project Beta  | 2023-06-15 | 2024-08-30 |

**Solution Area:**

```sql
-- Paste your SQL solution here
```

**Question 4:**

**Explanation:** For each employee, find the name of their manager. If an employee has no manager (i.e., they are a top-level manager), return `NULL` for the manager's name. Return the employee's first and last name, and their manager's first and last name.

**Expected Output:**

| employee_first_name | employee_last_name | manager_first_name | manager_last_name |
|---------------------|--------------------|--------------------|-------------------|
| John                | Doe                | NULL               | NULL              |
| Jane                | Smith              | John               | Doe               |
| Peter               | Jones              | Mary               | Brown             |
| Mary                | Brown              | NULL               | NULL              |
| David               | Wilson             | Mary               | Brown             |
| Sarah               | Miller             | John               | Doe               |
| Michael             | Davis              | Mary               | Brown             |
| Linda               | Garcia             | David              | Wilson            |
| Robert              | Rodriguez          | Jane               | Smith             |
| Jennifer            | Williams           | John               | Doe               |
| Charles             | Moore              | Sarah              | Miller            |
| Jessica             | Taylor             | Mary               | Brown             |

**Solution Area:**

```sql
-- Paste your SQL solution here
```

**Question 5:**

**Explanation:** Find the departments that have more than 2 employees. Return the department name and the number of employees in that department.

**Expected Output:**

| department_name | employee_count |
|-----------------|----------------|
| Sales           | 3              |
| Engineering     | 4              |

**Solution Area:**

```sql
-- Paste your SQL solution here
```

**Question 6:**

**Explanation:** For each project, find the employee who joined the project earliest. Return the project name, the first name, and the last name of the employee, along with their role in the project.

**Expected Output:**

| project_name  | first_name | last_name | role              |
|---------------|------------|-----------|-------------------|
| Project Alpha | John       | Doe       | Lead Engineer     |
| Project Beta  | Peter      | Jones     | Sales Representative|
| Project Gamma | David      | Wilson    | Marketing Specialist|
| Project Delta | Michael    | Davis     | Finance Analyst   |

**Solution Area:**

```sql
-- Paste your SQL solution here
```

**Question 7:**

**Explanation:** Calculate the total salary paid to employees in each department. Return the department name and the total salary, ordered by total salary in descending order.

**Expected Output:**

| department_name | total_salary |
|-----------------|--------------|
| Engineering     | 332000.00    |
| Sales           | 218000.00    |
| Finance         | 95000.00     |
| Marketing       | 135000.00    |
| Human Resources | 62000.00     |

**Solution Area:**

```sql
-- Paste your SQL solution here
```

**Question 8:**

**Explanation:** Find the names of employees who are not currently assigned to any project. Return their first and last names.

**Expected Output:**

| first_name | last_name |
|------------|-----------|

**Solution Area:**

```sql
-- Paste your SQL solution here
```

**Question 9:**

**Explanation:** For each employee, find the number of projects they are currently working on (assuming "currently" means projects whose end date is in the future or today). Return the employee's first and last name and the number of current projects.

**Expected Output:**

| first_name | last_name | current_projects |
|------------|-----------|------------------|
| John       | Doe       | 2                |
| Jane       | Smith     | 2                |
| Peter      | Jones     | 1                |
| Mary       | Brown     | 1                |
| David      | Wilson    | 1                |
| Sarah      | Miller    | 1                |
| Michael    | Davis     | 1                |
| Linda      | Garcia    | 1                |
| Robert     | Rodriguez | 0                |
| Jennifer   | Williams  | 0                |
| Charles    | Moore     | 1                |
| Jessica    | Taylor    | 1                |

**Solution Area:**

```sql
-- Paste your SQL solution here
```

**Question 10:**

**Explanation:** Find the department with the highest average salary among employees hired after January 1, 2022. Return the department name and the average salary.

**Expected Output:**

| department_name | average_salary |
|-----------------|----------------|
| Engineering     | 88333.33       |

**Solution Area:**

```sql
-- Paste your SQL solution here
```
