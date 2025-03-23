## Question 1: Departmental Salary Ranking

For each department, rank employees based on their salary in descending order. Display the department, employee's full name, salary, and their rank within the department.

**Expected output:**

| department    | employee_name        | salary    | salary_rank |
|---------------|----------------------|-----------|-------------|
| Engineering   | Melissa Baker        | 130000.00 | 1           |
| Engineering   | David Wilson         | 120000.00 | 2           |
| Engineering   | Brian Moore          | 105000.00 | 3           |
| Engineering   | Mary Brown           | 90000.00  | 4           |
| Engineering   | Jennifer Clark       | 88000.00  | 5           |
| Engineering   | Thomas Young         | 70000.00  | 6           |
| Finance       | Linda Chang          | 95000.00  | 1           |
| Finance       | Kevin Turner         | 82000.00  | 2           |
| Finance       | Michael Lee          | 70000.00  | 3           |
| Finance       | Emily Hall           | 62000.00  | 4           |
| Human Resources| Jessica Allen        | 85000.00  | 1           |
| Human Resources| Christopher Scott    | 65000.00  | 2           |
| Marketing     | Sarah Garcia         | 80000.00  | 1           |
| Marketing     | Nicole Wright        | 63000.00  | 2           |
| Marketing     | Jane Smith           | 60000.00  | 3           |
| Marketing     | James Lewis          | 58000.00  | 4           |
| Sales         | John Doe             | 75000.00  | 1           |
| Sales         | Peter Jones          | 55000.00  | 2           |
| Sales         | Robert Taylor        | 52000.00  | 3           |
| Sales         | Amanda Adams         | 53000.00  | 4           |

## Question 2: High Priority Projects and Their Employees

Retrieve the names of all employees who are currently working on projects with 'High' priority. Display the employee's full name and the project name.

**Expected output:**

| employee_name   | project_name   |
|-----------------|----------------|
| Mary Brown      | Project Gamma  |
| David Wilson    | Project Gamma  |
| Jennifer Clark  | Project Gamma  |
| Thomas Young    | Project Gamma  |
| Brian Moore     | Project Gamma  |
| Melissa Baker   | Project Gamma  |
| John Doe        | Project Eta    |
| Peter Jones     | Project Eta    |
| Sarah Garcia    | Project Eta    |
| Michael Lee     | Project Eta    |
| Robert Taylor   | Project Eta    |
| Jennifer Clark  | Project Eta    |
| James Lewis     | Project Eta    |
| Emily Hall      | Project Eta    |
| Thomas Young    | Project Eta    |
| Jessica Allen   | Project Eta    |
| Christopher Scott| Project Eta    |
| Amanda Adams    | Project Eta    |
| Brian Moore     | Project Eta    |
| Nicole Wright   | Project Eta    |
| Kevin Turner    | Project Eta    |
| Melissa Baker   | Project Eta    |
| Jane Smith      | Project Iota   |
| Mary Brown      | Project Iota   |
| David Wilson    | Project Iota   |
| Sarah Garcia    | Project Iota   |
| Michael Lee     | Project Iota   |
| Linda Chang     | Project Iota   |
| Jennifer Clark  | Project Iota   |
| James Lewis     | Project Iota   |
| Emily Hall      | Project Iota   |
| Thomas Young    | Project Iota   |
| Jessica Allen   | Project Iota   |
| Christopher Scott| Project Iota   |
| Amanda Adams    | Project Iota   |
| Brian Moore     | Project Iota   |
| Nicole Wright   | Project Iota   |
| Kevin Turner    | Project Iota   |
| Melissa Baker   | Project Iota   |
| John Doe        | Project Lambda |
| Jane Smith      | Project Lambda |
| Peter Jones     | Project Lambda |
| Mary Brown      | Project Lambda |
| David Wilson    | Project Lambda |
| Sarah Garcia    | Project Lambda |
| Michael Lee     | Project Lambda |
| Linda Chang     | Project Lambda |
| Robert Taylor   | Project Lambda |
| Jennifer Clark  | Project Lambda |
| James Lewis     | Project Lambda |
| Emily Hall      | Project Lambda |
| Thomas Young    | Project Lambda |
| Jessica Allen   | Project Lambda |
| Christopher Scott| Project Lambda |
| Amanda Adams    | Project Lambda |
| Brian Moore     | Project Lambda |
| Nicole Wright   | Project Lambda |
| Kevin Turner    | Project Lambda |
| Melissa Baker   | Project Lambda |

## Question 3: Employees Hired in a Specific Year

Find all employees who were hired in the year 2023. Display their full name, hire date, and department.

**Expected output:**

| employee_name   | hire_date  | department |
|-----------------|------------|------------|
| Sarah Garcia    | 2023-04-05 | Marketing  |
| James Lewis     | 2023-09-15 | Marketing  |
| Amanda Adams    | 2023-07-10 | Sales      |

## Question 4: Departments with Multiple Managers

Identify departments that have more than one employee with 'Manager' in their job title. Display the department name and the count of managers in that department.

**Expected output:**

| department | manager_count |
|------------|---------------|
| Sales      | 1             |
| Marketing  | 1             |
| Finance    | 1             |
| Human Resources | 1         |

## Question 5: Project Completion Rate

Calculate the percentage of projects that have been completed. Display the completion rate as a percentage with two decimal places.

**Expected output:**

| completion_rate |
|-----------------|
| 50.00%          |

## Question 6: Employees Not Assigned to Any Project

List the full names of employees who are not currently assigned to any project.

**Expected output:**

| employee_name   |
|-----------------|
| Linda Chang     |
| Emily Hall      |
| Jessica Allen   |
| Christopher Scott|
| Kevin Turner    |

## Question 7: Employees in Specific Locations

Find all employees who work in either 'New York' or 'London'. Display their full name, department, and the city they work in.

**Expected output:**

| employee_name | department | city     |
|---------------|------------|----------|
| John Doe      | Sales      | New York |
| Peter Jones   | Sales      | New York |
| Amanda Adams  | Sales      | New York |

## Question 8: Average Salary by Job Title

Calculate the average salary for each job title across all departments. Display the job title and the average salary, rounded to two decimal places.

**Expected output:**

| job_title              | average_salary |
|------------------------|----------------|
| Accountant             | 62000.00       |
| Content Creator        | 58000.00       |
| Data Engineer          | 105000.00      |
| Finance Manager        | 95000.00       |
| Financial Analyst      | 70000.00       |
| HR Manager             | 85000.00       |
| HR Specialist          | 65000.00       |
| Junior Software Engineer| 70000.00       |
| Lead Engineer          | 120000.00      |
| Marketing Lead         | 60000.00       |
| Marketing Manager      | 80000.00       |
| Marketing Specialist   | 60000.00       |
| Project Manager        | 75000.00       |
| Sales Manager          | 75000.00       |
| Sales Representative   | 53333.33       |
| SEO Specialist         | 63000.00       |
| Senior Financial Analyst| 82000.00       |
| Senior Software Engineer| 120000.00      |
| Software Architect     | 130000.00      |
| Software Engineer      | 86500.00       |

## Question 9: Projects Starting and Ending in the Same Year

Find all projects that started and ended in the same year. Display the project name and the year.

**Expected output:**

| project_name | year |
|--------------|------|
| Project Alpha| 2023 |
| Project Beta | 2023 |
| Project Zeta | 2023 |
| Project Theta| 2024 |
| Project Kappa| 2024 |
| Project Mu   | 2022 |

## Question 10: Employees Managed by Someone in a Different Department

List the full names of employees whose manager belongs to a different department than them.

**Expected output:**

| employee_name  | manager_name |
|----------------|--------------|
| Jane Smith     | John Doe     |
| Peter Jones    | John Doe     |
| Sarah Garcia   | John Doe     |
| Michael Lee    | Linda Chang  |
| Robert Taylor  | John Doe     |
| Jennifer Clark | David Wilson |
| James Lewis    | Sarah Garcia |
| Emily Hall     | Linda Chang  |
| Thomas Young   | David Wilson |
| Amanda Adams   | John Doe     |
| Brian Moore    | David Wilson |
| Nicole Wright  | Sarah Garcia |
| Kevin Turner   | Linda Chang  |
| Melissa Baker  | David Wilson |
