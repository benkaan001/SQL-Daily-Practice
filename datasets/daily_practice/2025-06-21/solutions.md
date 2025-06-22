### Question 1: Longest Consecutive Days Worked Per Employee

Find the employee_id, first_name, last_name, and the longest_consecutive_days an employee has logged attendance.

Attendance is defined by having an entry in AttendanceLogs for a given date.

If an employee has no logs, they should not appear in the result.

Order the results by longest_consecutive_days descending, then by employee_id ascending.

**Expected Output:**

| **employee_id** | **first_name** | **last_name** | **longest_consecutive_days** |
| --------------------- | -------------------- | ------------------- | ---------------------------------- |
| 101                   | Alice                | Smith               | 5                                  |
| 102                   | Bob                  | Johnson             | 4                                  |
| 103                   | Charlie              | Brown               | 3                                  |
| 104                   | Diana                | Miller              | 3                                  |
| 106                   | Frank                | Wilson              | 2                                  |
| 105                   | Eve                  | Davis               | 1                                  |
| 107                   | Grace                | Taylor              | 1                                  |
| 108                   | Henry                | Moore               | 1                                  |

**Your Solution:**

```sql
WITH daily_logs AS (
  SELECT DISTINCT
    employee_id,
    log_date
  FROM
      AttendanceLogs
),
streaks AS (
  SELECT
    employee_id,
    log_date,
    ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY log_date) AS row_num,
    TO_DAYS(log_date) AS days
  FROM
    daily_logs
),
streak_groups AS (
  SELECT
    employee_id,
    log_date,
    days - row_num AS group_id
  FROM
    streaks
),
consecutive_streaks AS (
  SELECT
      employee_id,
      group_id,
      COUNT(log_date) AS current_streak_length
  FROM
      streak_groups
  GROUP BY
      employee_id,
      group_id
)
SELECT
  e.employee_id,
  e.first_name,
  e.last_name,
  MAX(cs.current_streak_length) AS longest_consecutive_days
FROM
  Employees e
JOIN
  consecutive_streaks cs ON e.employee_id = cs.employee_id
GROUP BY
  e.employee_id,
  e.first_name,
  e.last_name
ORDER BY
  longest_consecutive_days DESC,
    employee_id ASC;

```

### Question 2: Average Productive Hours Per Department with Live Logs

Calculate the average daily productive hours for each department.

Productive hours for a given log entry are defined as the difference between log_out_time and log_in_time.

If log_out_time is NULL, assume the employee is still working and calculate their hours until the "current time" (for this problem, consider 17:00:00 on the log_date as the current time if log_out_time is NULL, but cap at 24:00:00 if the log_in_time extends past 17:00:00).

Exclude any log_date where log_in_time is after log_out_time or the assumed "current time".

Round the average_productive_hours to two decimal places.

Order the results by average_productive_hours descending.

**Expected Output:**

| department  | average_productive_hours |
| ----------- | ------------------------ |
| Sales       | 8.25                     |
| HR          | 8.02                     |
| Marketing   | 8.00                     |
| Engineering | 7.97                     |

**Your Solution:**

```sql
WITH productive_hours AS (
  SELECT
    al.employee_id,
    al.log_date,
    al.log_in_time,
    al.log_out_time,
    e.department,
    CONCAT(al.log_date, ' ', al.log_in_time) AS login_datetime,
    CASE
        WHEN al.log_out_time IS NOT NULL THEN CONCAT(al.log_date, ' ', al.log_out_time)
        WHEN al.log_in_time > '17:00:00' THEN CONCAT(DATE_ADD(al.log_date, INTERVAL 1 DAY), ' ', '00:00:00')
        ELSE CONCAT(al.log_date, ' ', '17:00:00')
    END AS effective_logout_datetime
  FROM
    AttendanceLogs al
  JOIN
    Employees e ON al.employee_id = e.employee_id
),
final_productive_hours AS (
  SELECT
    employee_id,
    log_date,
    department,
    TIMESTAMPDIFF(SECOND, login_datetime, effective_logout_datetime) / 3600.0 AS productive_hours_raw
  FROM
    productive_hours
  WHERE
    TIMESTAMPDIFF(SECOND, login_datetime, effective_logout_datetime) > 0
)
SELECT
  department,
  ROUND(AVG(productive_hours_raw), 2) AS average_productive_hours
FROM
  final_productive_hours
GROUP BY
  department
ORDER BY
  average_productive_hours DESC;
```

### Question 3: Employees with Irregular Log Patterns

Identify employees who have at least one log_out_time that is NULL (meaning they haven't logged out) AND have logged in for at least 3 distinct days within the current month (June 2025).

For these employees, return their employee_id, first_name, last_name, and the number_of_incomplete_logs.

Order the results by number_of_incomplete_logs descending, then by employee_id ascending.

**Expected Output:**

| employee_id | first_name | last_name | number_of_incomplete_logs |
| ----------- | ---------- | --------- | ------------------------- |
| 102         | Bob        | Johnson   | 2                         |
| 104         | Diana      | Miller    | 1                         |                             |

**Your Solution:**

```sql
WITH login_counts AS (
  SELECT
    employee_id,
    COUNT(DISTINCT log_date) AS distinct_login_date_count,
    SUM(CASE WHEN log_out_time IS NULL THEN 1 ELSE 0 END) AS number_of_incomplete_logs
  FROM
    AttendanceLogs
  WHERE
    log_date BETWEEN '2025-06-01' AND '2025-06-30'
  GROUP BY
    employee_id
  HAVING
    distinct_login_date_count >= 3
    AND number_of_incomplete_logs > 0
)
SELECT
  lc.employee_id,
  e.first_name,
  e.last_name,
  number_of_incomplete_logs
FROM
  login_counts lc
JOIN
  Employees e ON lc.employee_id = e.employee_id
ORDER BY
  number_of_incomplete_logs DESC,
  employee_id ASC;
```
