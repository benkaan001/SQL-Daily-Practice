# Advanced SQL Practice Questions - Project Management System

## Question 1: Project Completion Efficiency
*Task:* For each completed project, calculate the total number of tasks, the number of days taken from project start to end, and the average number of days per task. Order by average days per task ascending.

*Expected Output:*
| project_name     | total_tasks | project_days | avg_days_per_task |
|------------------|-------------|--------------|-------------------|
| Project Apollo   | 3           | 241          | 80.33             |
| Project Phoenix  | 3           | 350          | 116.67            |

```sql
WITH completed_projects AS (
  SELECT
      Projects.project_name,
      COUNT(Tasks.task_id) AS total_tasks
  FROM
    Tasks
  JOIN
    Projects ON Projects.project_id = Tasks.project_id
  WHERE
    Projects.project_status = 'Completed'
  GROUP BY
    Projects.project_name
)
SELECT
  cp.project_name,
  cp.total_tasks,
  DATEDIFF(p.end_date, p.start_date) AS project_days,
  ROUND(
    DATEDIFF(p.end_date, p.start_date) / cp.total_tasks
  , 2) AS avg_days_per_task
FROM
  completed_projects cp
JOIN
  Projects p ON cp.project_name = p.project_name
ORDER BY
  avg_days_per_task;
```

## Question 2: Employee Task Load Analysis
*Task:* List all employees with the number of tasks assigned, the number of 'High' priority tasks, and the percentage of their tasks that are 'High' priority. Only include employees with at least 2 tasks. Order by percentage descending.

*Expected Output:*
| first_name | last_name | total_tasks | high_priority_tasks | high_priority_pct |
| ---------- | --------- | ----------- | ------------------- | ----------------- |
| John       | Smith     | 4           | 4                   | 100.00            |
| Alice      | Johnson   | 3           | 3                   | 100.00            |
| Bob        | Williams  | 2           | 1                   | 50.00             |
| Diana      | Miller    | 3           | 1                   | 33.33             |
| Charlie    | Brown     | 2           | 0                   | 0.00              |

```sql
WITH priority_tasks AS (
  SELECT
    e.first_name,
    e.last_name,
    COUNT(t.task_id) AS total_tasks,
    SUM(CASE WHEN t.priority = 'High' THEN 1 ELSE 0 END) AS high_priority_tasks
  FROM
    Employees e
  JOIN
    Tasks t ON e.employee_id = t.assigned_to
  GROUP BY
    e.first_name,
    e.last_name
  HAVING
    COUNT(t.task_id) >= 2
)
SELECT
  first_name,
  last_name,
  total_tasks,
  high_priority_tasks,
  ROUND(high_priority_tasks / total_tasks * 100, 2) AS high_priority_pct
FROM
  priority_tasks
ORDER BY
  high_priority_pct DESC;
```

## Question 3: Task Dependency Chains
*Task:* Find all tasks that are part of a dependency chain of length 2 or more (i.e., a task that depends on another task, which itself depends on another). Show the task name, project name, and the chain length (2 or 3 only for this dataset).

*Expected Output:*
| task_name           | project_name    | chain_length |
| ------------------- | --------------- | ------------ |
| Integration Testing | Project Apollo  | 2            |
| Testing and QA      | Project Gemini  | 2            |
| Final Testing       | Project Phoenix | 2            |

```sql
WITH RECURSIVE dependent_tasks AS (
  SELECT
    td.task_id AS current_task_id,
    t.task_name,
    p.project_name,
    td.depends_on AS direct_dependency_id,
    1 AS chain_length
  FROM
    Tasks t
  JOIN
    Projects p ON t.project_id = p.project_id
  JOIN
    TaskDependencies td ON td.task_id = t.task_id

  UNION ALL

  SELECT
    td2.task_id AS current_task_id,
    t2.task_name,
    p2.project_name,
    td2.depends_on AS direct_dependency_id,
    dt.chain_length + 1 AS chain_length
  FROM
    Tasks t2
  JOIN
    Projects p2 ON t2.project_id = p2.project_id
  JOIN
    TaskDependencies td2 ON td2.task_id = t2.task_id
  JOIN
    dependent_tasks dt ON dt.current_task_id = td2.depends_on
  WHERE
    dt.chain_length < 3

)
SELECT
  task_name,
  project_name,
  chain_length
FROM
  dependent_tasks
WHERE
  chain_length >= 2;
```

