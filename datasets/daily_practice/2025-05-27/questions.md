# Advanced SQL Practice Questions - Project Management System

## Question 1: Project Completion Efficiency
*Task:* For each completed project, calculate the total number of tasks, the number of days taken from project start to end, and the average number of days per task. Order by average days per task ascending.

*Expected Output:*
| project_name     | total_tasks | project_days | avg_days_per_task |
|------------------|-------------|--------------|-------------------|
| Project Apollo   | 3           | 241          | 80.33             |
| Project Phoenix  | 3           | 350          | 116.67            |

```sql
-- Write your SQL query here
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
-- Write your SQL query here
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
-- Write your SQL query here
```
