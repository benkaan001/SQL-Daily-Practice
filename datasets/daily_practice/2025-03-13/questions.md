-- filepath: /Users/benkaan/Desktop/projects/SQL-Daily-Practice/questions.md
## SQL Practice Questions - Project Management System

**1.** **Task:** Retrieve the project name, start date, and end date for all projects that are currently active. Consider that 'Active' projects might have a NULL end_date.
**Expected Output:**

| project_name | start_date | end_date   |
|--------------|------------|------------|
| Project Titan  | 2023-05-01 | NULL       |
| Project Gemini | 2023-09-01 | 2024-03-31 |

**2.** **Task:** List the first name, last name, and job title of all employees whose phone number is not available (NULL).
**Expected Output:**

| first_name | last_name | job_title    |
|------------|-----------|--------------|
| Bob        | Williams  | Data Analyst |
| Diana      | Miller    | QA Engineer  |

**3.** **Task:** Find the average budget of all projects.
**Expected Output:**

| average_budget |
|----------------|
| 470000.00      |

**4.** **Task:** Retrieve the task name, start date, end date, and assigned employee's first name and last name for all tasks in the 'Project Titan' project. Include tasks that are not yet assigned (assigned_to is NULL).
**Expected Output:**

| task_name           | start_date | end_date   | first_name | last_name |
|---------------------|------------|------------|------------|-----------|
| Database Design     | 2023-05-01 | 2023-06-30 | Bob        | Williams  |
| Frontend Development| 2023-07-01 | NULL       | Charlie    | Brown     |
| API Development     | 2023-06-01 | NULL       | Bob        | Williams  |

**5.** **Task:** List the project names and the number of updates for each project.
**Expected Output:**

| project_name | number_of_updates |
|--------------|-------------------|
| Project Phoenix  | 1                 |
| Project Titan  | 1                 |
| Project Gemini | 1                 |
| Project Nova   | 1                 |
| Project Apollo | 1                 |

**6.** **Task:** Calculate the total budget of all completed projects.
**Expected Output:**

| total_budget |
|--------------|
| 1100000.00   |

**7.** **Task:** Find the employee who is assigned to the most tasks. Return the employee's first name and last name.
**Expected Output:**

| first_name | last_name |
|------------|-----------|
| Alice      | Johnson   |

**8.** **Task:** List the task names and their corresponding project names for all tasks that are currently 'In Progress'.
**Expected Output:**

| task_name           | project_name |
|---------------------|--------------|
| Frontend Development| Project Titan  |
| API Development     | Project Titan  |

**9.** **Task:** Retrieve the task ID and the task name for all tasks that do not have any dependencies.
**Expected Output:**

| task_id | task_name           |
|---------|---------------------|
| 1       | Requirements Gathering|
| 3       | Database Design     |
| 4       | Frontend Development|
| 7       | Project Planning    |
| 8       | Resource Allocation |
| 9       | System Design       |
| 11      | API Development     |
| 12      | Deployment          |
| 15      | Documentation       |

**10.** **Task:** Find the projects that have no tasks assigned to them.
**Expected Output:**

*(Empty result set with the current data, as all projects have tasks.)*

**11.** **Task:** List all employees who are not assigned to any task.
**Expected Output:**

*(Empty result set with the current data, as all employees are assigned to at least one task.)*

**12.** **Task:** Find the tasks for which the assigned employee's phone number is NULL. Return the task name and the employee's first name and last name.
**Expected Output:**

| task_name       | first_name | last_name |
|-----------------|------------|-----------|
| Database Design | Bob        | Williams  |
| API Development | Bob        | Williams  |
| Testing and QA  | Diana      | Miller    |
| Final Testing   | Diana      | Miller    |
| Integration Testing | Diana      | Miller    |

**13.** **Task:** Calculate the average end date of all tasks. Consider NULL end dates as the current date.
**Expected Output:**

| average_end_date |
|------------------|
| 2023-09-22       |

**14.** **Task:** Rank employees based on the number of tasks they are assigned to.
**Expected Output:**

| employee_id | first_name | last_name | number_of_tasks | employee_rank |
|-------------|------------|-----------|-----------------|---------------|
| 2           | Alice      | Johnson   | 3               | 1             |
| 1           | John       | Smith     | 3               | 1             |
| 3           | Bob        | Williams  | 2               | 3             |
| 5           | Diana      | Miller    | 2               | 3             |
| 4           | Charlie    | Brown     | 1               | 5             |

**15.** **Task:** Find the difference between the actual end date and the planned end date (start date + 6 months) for each task. If the task is still in progress (end date is NULL), consider the current date as the actual end date.
**Expected Output:**

| task_name           | date_difference |
|---------------------|-----------------|
| Requirements Gathering| -13 days        |
| Software Development| -30 days        |
| Database Design     | 0 days          |
| Frontend Development| 245 days        |
| Backend Development | 0 days          |
| Testing and QA      | 0 days          |
| Project Planning    | 0 days          |
| Resource Allocation | 275 days        |
| System Design       | 0 days          |
| Implementation      | 0 days          |
| API Development     | 245 days        |
| Deployment          | 0 days          |
| Integration Testing | 0 days          |
| Final Testing       | 0 days          |
| Documentation       | 275 days        |

**16.** **Task:** Identify the projects with the highest budget that are still in the 'Planning' status.
**Expected Output:**

| project_name | budget   |
|--------------|----------|
| Project Nova   | 200000.00|

**17.** **Task:** Calculate the number of tasks completed each month.
**Expected Output:**

| month   | number_of_tasks |
|---------|-----------------|
| 2023-02 | 1               |
| 2023-06 | 1               |
| 2023-10 | 1               |
| 2024-01 | 1               |
| 2024-03 | 3               |

**18.** **Task:** Find employees who have been hired after the start date of a specific project ('Project Phoenix').
**Expected Output:**

| first_name | last_name |
|------------|-----------|
| Alice      | Johnson   |
| Bob        | Williams  |
| Charlie    | Brown     |
| Diana      | Miller    |

**19.** **Task:** Identify tasks where the assigned employee's job title is 'Project Manager'.
**Expected Output:**

| task_name           |
|---------------------|
| Requirements Gathering|
| Project Planning    |
| Deployment          |
| System Design       |

**20.** **Task:** For each project, find the latest update date.
**Expected Output:**

| project_name | latest_update_date    |
|--------------|-----------------------|
| Project Phoenix  | 2024-03-13 15:01:23 |
| Project Titan  | 2024-03-13 15:01:23 |
| Project Gemini | 2024-03-13 15:01:23 |
| Project Nova   | 2024-03-13 15:01:23 |
| Project Apollo | 2024-03-13 15:01:23 |