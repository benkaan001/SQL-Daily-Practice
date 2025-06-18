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

```
--- Write your solution here

```

### Question 2: Average Productive Hours Per Department with Live Logs

Calculate the average daily productive hours for each department.

Productive hours for a given log entry are defined as the difference between log_out_time and log_in_time.

If log_out_time is NULL, assume the employee is still working and calculate their hours until the "current time" (for this problem, consider 17:00:00 on the log_date as the current time if log_out_time is NULL, but cap at 24:00:00 if the log_in_time extends past 17:00:00).

Exclude any log_date where log_in_time is after log_out_time or the assumed "current time".

Round the average_productive_hours to two decimal places.

Order the results by average_productive_hours descending.

**Expected Output:**

| **department** | **average_productive_hours** |
| -------------------- | ---------------------------------- |
| Sales                | 8.33                               |
| Engineering          | 8.08                               |
| HR                   | 8.00                               |
| Marketing            | 8.00                               |

**Your Solution:**

```
--- Write your solution here

```

### Question 3: Employees with Irregular Log Patterns

Identify employees who have at least one log_out_time that is NULL (meaning they haven't logged out) AND have logged in for at least 3 distinct days within the current month (June 2025).

For these employees, return their employee_id, first_name, last_name, and the number_of_incomplete_logs.

Order the results by number_of_incomplete_logs descending, then by employee_id ascending.

**Expected Output:**

| **employee_id** | **first_name** | **last_name** | **number_of_incomplete_logs** |
| --------------------- | -------------------- | ------------------- | ----------------------------------- |
| 102                   | Bob                  | Johnson             | 2                                   |
| 104                   | Diana                | Miller              | 1                                   |

**Your Solution:**

```
--- Write your solution here

```
