### Question 1: Top 3 Highest Paid Employees Per Department

Retrieve the first name, last name, salary, department name, and rank of the top 3 highest-paid employees within each department. In case of ties in salary, all employees with the same salary should receive the same rank, and the next rank should be skipped (i.e., use a rank function that handles ties). If a department has fewer than 3 employees, display all of them. Order the results by department name ascending, then by salary descending, and finally by employee ID ascending.

**Expected Output:**

| **first_name** | **last_name** | **salary** | **department_name** | **employee_rank** |
| -------------------- | ------------------- | ---------------- | ------------------------- | ----------------------- |
| Alice                | Williams            | 130000.00        | Engineering               | 1                       |
| Liam                 | Harris              | 92000.00         | Engineering               | 2                       |
| Kevin                | White               | 90000.00         | Engineering               | 3                       |
| Mia                  | Martin              | 90000.00         | Engineering               | 3                       |
| Charlie              | Davis               | 115000.00        | Finance                   | 1                       |
| Rachel               | Clark               | 80000.00         | Finance                   | 2                       |
| Tina                 | Walker              | 80000.00         | Finance                   | 2                       |
| Sam                  | Lewis               | 72000.00         | Finance                   | 3                       |
| Bob                  | Brown               | 95000.00         | Human Resources           | 1                       |
| Paul                 | Martinez            | 65000.00         | Human Resources           | 2                       |
| Quinn                | Robinson            | 50000.00         | Human Resources           | 3                       |
| Peter                | Jones               | 110000.00        | Marketing                 | 1                       |
| Hannah               | Anderson            | 70000.00         | Marketing                 | 2                       |
| Julia                | Jackson             | 70000.00         | Marketing                 | 2                       |
| Ian                  | Thomas              | 55000.00         | Marketing                 | 3                       |
| Jane                 | Smith               | 120000.00        | Sales                     | 1                       |
| Ethan                | Wilson              | 62000.00         | Sales                     | 2                       |
| Diana                | Miller              | 60000.00         | Sales                     | 3                       |
| Fiona                | Moore               | 60000.00         | Sales                     | 3                       |

**Your Solution:**

```
--- Write your solution here

```

### Question 2: Salary Comparison Between Managed and Unmanaged Employees

Calculate the average salary of employees who report to a manager (i.e., `manager_id` is NOT NULL) and the average salary of employees who do not report to a manager (i.e., `manager_id` is NULL). Display both averages in a single result set, aliasing them as `avg_salary_managed` and `avg_salary_unmanaged` respectively. Consider that `department_id` can be NULL for unmanaged employees (e.g., CEO).

**Expected Output:**

| **avg_salary_managed** | **avg_salary_unmanaged** |
| ---------------------------- | ------------------------------ |
| 84500.00                     | 145000.00                      |

**Your Solution:**

```
--- Write your solution here

```

### Question 3: Departments with Below Average Employee Tenure

Identify departments where the average tenure (time in years an employee has been with the company) of their employees is less than the overall average tenure of all employees across the entire company. Return the `department_name` and `average_tenure_years` for these departments. The average tenure should be calculated from the `hire_date` up to the current date (June 18, 2025). Round the average tenure years to two decimal places. Exclude employees with NULL `hire_date` if any (though none in this dataset). Order the results by `average_tenure_years` ascending.

**Expected Output:**

| **department_name** | **average_tenure_years** |
| ------------------------- | ------------------------------ |
| Human Resources           | 3.79                           |
| Sales                     | 4.00                           |
| Marketing                 | 4.86                           |

**Your Solution:**

```
--- Write your solution here

```
