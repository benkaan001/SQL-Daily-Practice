### Question 1: Project Performance Summary with Longest Task Duration

For each project, calculate the following:

1. `total_tasks`: Total number of tasks in the project.
2. `completed_tasks`: Number of tasks with 'Completed' status.
3. `completion_percentage`: Percentage of tasks completed, rounded to two decimal places. If no tasks, this should be 0.00.
4. `longest_task_name`: The name of the task within that project that had the longest duration (difference between `actual_end_date` and `actual_start_date`). If multiple tasks have the same longest duration, pick one alphabetically. If no tasks are completed or have valid start/end dates, this should be `NULL`.
5. `longest_task_duration_days`: The duration in days for the `longest_task_name`. If `longest_task_name` is `NULL`, this should also be `NULL`.

Order the results by `completion_percentage` descending, then by `project_id` ascending.

**Expected Output:**

| project_id | project_name           | total_tasks | completed_tasks | completion_percentage | longest_task_name   | longest_task_duration_days |
| ---------- | ---------------------- | ----------- | --------------- | --------------------- | ------------------- | -------------------------- |
| 1          | Website Redesign       | 7           | 4               | 57.14                 | Develop Backend     | 51                         |
| 3          | Internal Tools Upgrade | 4           | 2               | 50.00                 | Audit Current Tools | 18                         |
| 4          | Data Migration Project | 4           | 2               | 50.00                 | Data Transformation | 36                         |
| 2          | Mobile App Development | 5           | 2               | 40.00                 | Database Design     | 36                         |
| 5          | New Product Launch     | 3           | 1               | 33.33                 | Market Research     | 24                         |

**Your Solution:**

```sql
WITH aggregated_tasks AS (
  SELECT
    p.project_id,
    p.project_name,
    COUNT(DISTINCT t.task_id) AS total_tasks,
    SUM(CASE WHEN t.status = 'Completed' THEN 1 ELSE 0 END) AS completed_tasks
  FROM
    Tasks t
  JOIN
    Projects p ON p.project_id = t.project_id
  GROUP BY
    p.project_id,
    p.project_name
),
grouped_tasks AS (
  SELECT
    task_id,
    task_name,
    project_id,
    DATEDIFF(actual_end_date, actual_start_date) AS task_duration_days,
    ROW_NUMBER() OVER (PARTITION BY project_id ORDER BY DATEDIFF(actual_end_date, actual_start_date) DESC, task_name ASC) AS rn
  FROM
    Tasks
)
SELECT
  at.project_id,
  at.project_name,
  at.total_tasks,
  at.completed_tasks,
  ROUND(at.completed_tasks * 100.0 / at.total_tasks, 2) AS completion_percentage,
  gt.task_name AS longest_task_name,
  gt.task_duration_days AS longest_task_duration_days
FROM
  aggregated_tasks at
JOIN
  grouped_tasks gt ON at.project_id = gt.project_id
WHERE
  gt.rn = 1
ORDER BY
  completion_percentage DESC,
  project_id ASC;

```

### Question 2: Employee Overdue Task Report

Identify employees who are currently assigned to at least one task that is 'In Progress' or 'Not Started' and is past its due_date (relative to the current date: June 22, 2024).

For such employees, return their assigned_to name, the total_overdue_tasks_count, and the oldest_overdue_task_name (the task with the earliest due_date among their overdue tasks).

If an employee has multiple overdue tasks with the same earliest due_date, pick the task_name alphabetically.

Exclude employees with no assigned tasks or no overdue tasks.

Order the results by total_overdue_tasks_count descending, then by assigned_to ascending.

**Expected Output:**

| assigned_to | total_overdue_tasks_count | oldest_overdue_task_name |
| ----------- | ------------------------- | ------------------------ |
| Bob Johnson | 1                         | Integrate APIs           |

**Your Solution:**

```sql
WITH overdue_tasks AS (
  SELECT
    assigned_to,
    task_name,
    ROW_NUMBER() OVER (PARTITION BY assigned_to ORDER BY due_date ASC, task_name ASC) AS rn
  FROM
    Tasks
  WHERE
    status IN ('In Progress', 'Not Started')
    AND due_date < '2024-06-22'
  	AND assigned_to IS NOT NULL
),
assigned_tasks AS (
  SELECT
    assigned_to,
    COUNT(task_id) AS total_overdue_tasks_count
  FROM
    Tasks
  WHERE
    status IN ('In Progress', 'Not Started')
    AND due_date < '2024-06-22'
  GROUP BY
    assigned_to
  HAVING
  	total_overdue_tasks_count > 0
)
SELECT
  at.assigned_to,
  at.total_overdue_tasks_count,
  ot.task_name AS oldest_overdue_task_name
FROM
  assigned_tasks at
JOIN
  overdue_tasks ot ON ot.assigned_to = at.assigned_to
WHERE
  ot.rn = 1;
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

```sql
WITH task_summary AS (
    SELECT
        p.project_id,
        p.project_name,
        p.end_date AS project_end_date,
        COUNT(CASE WHEN t.priority = 'High' THEN t.task_id END) AS total_high_priority_tasks,
        COUNT(CASE WHEN t.priority = 'High' AND t.status = 'Completed' THEN t.task_id END) AS completed_high_priority_tasks,
        MIN(CASE WHEN t.priority = 'High' AND t.status = 'Completed' THEN t.actual_end_date END) AS earliest_high_priority_completion_date
    FROM
        Projects p
    JOIN
        Tasks t ON p.project_id = t.project_id
    GROUP BY
        p.project_id,
        p.project_name,
        p.end_date
)
SELECT
    ts.project_name,
    ts.project_end_date,
    ts.earliest_high_priority_completion_date
FROM
    task_summary ts
WHERE
    -- at least one high-priority task in the project
    ts.total_high_priority_tasks > 0
    -- all high-priority tasks equals the completed high-priority tasks
    AND ts.total_high_priority_tasks = ts.completed_high_priority_tasks
    -- the earliest completion date exists and is before the project's end_date
    AND ts.earliest_high_priority_completion_date IS NOT NULL
    AND ts.earliest_high_priority_completion_date < ts.project_end_date;
```
