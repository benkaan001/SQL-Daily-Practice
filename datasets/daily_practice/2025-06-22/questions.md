### Question 1: Project Performance Summary with Longest Task Duration

For each project, calculate the following:

1. `total_tasks`: Total number of tasks in the project.
2. `completed_tasks`: Number of tasks with 'Completed' status.
3. `completion_percentage`: Percentage of tasks completed, rounded to two decimal places. If no tasks, this should be 0.00.
4. `longest_task_name`: The name of the task within that project that had the longest duration (difference between `actual_end_date` and `actual_start_date`). If multiple tasks have the same longest duration, pick one alphabetically. If no tasks are completed or have valid start/end dates, this should be `NULL`.
5. `longest_task_duration_days`: The duration in days for the `longest_task_name`. If `longest_task_name` is `NULL`, this should also be `NULL`.

Order the results by `completion_percentage` descending, then by `project_id` ascending.

**Expected Output:**

| **project_id** | **project_name** | **total_tasks** | **completed_tasks** | **completion_percentage** | **longest_task_name** | **longest_task_duration_days** |
| -------------------- | ---------------------- | --------------------- | ------------------------- | ------------------------------- | --------------------------- | ------------------------------------ |
| 3                    | Internal Tools Upgrade | 4                     | 2                         | 50.00                           | Audit Current Tools         | 18                                   |
| 1                    | Website Redesign       | 7                     | 4                         | 57.14                           | Develop Backend             | 51                                   |
| 4                    | Data Migration Project | 4                     | 2                         | 50.00                           | Data Transformation         | 36                                   |
| 2                    | Mobile App Development | 5                     | 2                         | 40.00                           | Define Features             | 11                                   |
| 5                    | New Product Launch     | 3                     | 1                         | 33.33                           | Market Research             | 24                                   |

**Your Solution:**

```
--- Write your solution here

```

### Question 2: Employee Overdue Task Report

Identify employees who are currently assigned to at least one task that is 'In Progress' or 'Not Started' and is past its due_date (relative to the current date: June 22, 2025).

For such employees, return their assigned_to name, the total_overdue_tasks_count, and the oldest_overdue_task_name (the task with the earliest due_date among their overdue tasks).

If an employee has multiple overdue tasks with the same earliest due_date, pick the task_name alphabetically.

Exclude employees with no assigned tasks or no overdue tasks.

Order the results by total_overdue_tasks_count descending, then by assigned_to ascending.

**Expected Output:**

| **assigned_to** | **total_overdue_tasks_count** | **oldest_overdue_task_name** |
| --------------------- | ----------------------------------- | ---------------------------------- |
| Bob Johnson           | 1                                   | Integrate APIs                     |
| Charlie Brown         | 2                                   | Deploy Website                     |
| Diana Miller          | 1                                   | Testing Phase                      |
| Henry King            | 1                                   | Load Data                          |

**Your Solution:**

```
--- Write your solution here

```

### Question 3: Projects with Rapid High Priority Task Completion

Find projects where all their 'High' priority tasks have been 'Completed' and the earliest actual_end_date among these completed 'High' priority tasks is before the overall end_date of the project.

Return the project_name, the project_end_date, and the earliest_high_priority_completion_date.

Only include projects that have at least one 'High' priority task.

Order the results by earliest_high_priority_completion_date ascending.

**Expected Output:**

| **project_name** | **project_end_date** | **earliest_high_priority_completion_date** |
| ---------------------- | -------------------------- | ------------------------------------------------ |
| Internal Tools Upgrade | 2025-01-31                 | 2024-06-19                                       |

**Your Solution:**

```
--- Write your solution here

```
