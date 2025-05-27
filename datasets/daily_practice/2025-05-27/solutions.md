# Advanced SQL Practice Questions - Project Management System

## Question 1: Project Completion Efficiency
*Task:* For each completed project, calculate the total number of tasks, the number of days taken from project start to end, and the average number of days per task. Order by average days per task ascending.

*Expected Output:*
| project_name     | total_tasks | project_days | avg_days_per_task |
|------------------|-------------|--------------|-------------------|
| Project Apollo   | 3           | 242          | 80.67             |
| Project Phoenix  | 4           | 350          | 87.50             |

```sql
-- Write your SQL query here
```

## Question 2: Employee Task Load Analysis
*Task:* List all employees with the number of tasks assigned, the number of 'High' priority tasks, and the percentage of their tasks that are 'High' priority. Only include employees with at least 2 tasks. Order by percentage descending.

*Expected Output:*
| first_name | last_name | total_tasks | high_priority_tasks | high_priority_pct |
|------------|-----------|-------------|--------------------|-------------------|
| Alice      | Johnson   | 3           | 3                  | 100.00            |
| John       | Smith     | 3           | 3                  | 100.00            |
| Diana      | Miller    | 2           | 0                  | 0.00              |

```sql
-- Write your SQL query here
```

## Question 3: Task Dependency Chains
*Task:* Find all tasks that are part of a dependency chain of length 2 or more (i.e., a task that depends on another task, which itself depends on another). Show the task name, project name, and the chain length (2 or 3 only for this dataset).

*Expected Output:*
| task_name           | project_name     | chain_length |
|---------------------|------------------|--------------|
| Final Testing       | Project Phoenix  | 2            |
| Integration Testing | Project Apollo   | 2            |
| Documentation       | Project Nova     | 2            |

```sql
-- Write your SQL query here
```

## Question 4: Project Update Frequency
*Task:* For each project, calculate the number of updates and the average number of days between updates (use project start date for the first update). Show only projects with more than 1 update.

*Expected Output:*
| project_name     | num_updates | avg_days_between_updates |
|------------------|-------------|-------------------------|
| (No projects with >1 update in this dataset) |

```sql
-- Write your SQL query here
```

## Question 5: Unassigned High Priority Tasks
*Task:* List all 'High' priority tasks that are not assigned to any employee, including the project name and task name.

*Expected Output:*
| project_name     | task_name           |
|------------------|--------------------|
| Project Nova     | Resource Allocation|

```sql
-- Write your SQL query here
```
