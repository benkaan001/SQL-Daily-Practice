## Question 1: Average Update Call Duration
Each request_id may have several calls; the first (earliest) call for each request_id is considered the “initial call” and all subsequent calls are “update calls.”  
Write a query to compute the average call_duration for **all update calls** across all request_ids.  
Output a single row with the column **average_update_duration** (rounded to two decimal places).

**Expected Output Format:**

| average_update_duration |
|-------------------------|
| 17.88                   |

**Your Solution:**
```sql
-- Write your solution here
```

## Question 2: Update Call Percentage per Request
For each request_id, compute the total duration for the initial call and for update calls separately.  
Then, calculate the percentage of the total call duration that update calls constitute (rounded to two decimal places).  
Output the following columns: request_id, total_initial_duration, total_update_duration, and update_percentage.

**Expected Output Format:**

| request_id | total_initial_duration | total_update_duration | update_percentage |
|------------|------------------------|-----------------------|-------------------|
| 1          | 28                     | 106                   | 79.10             |
| 2          | 3                      | 99                    | 97.06             |
| 3          | 15                     | 99                    | 86.84             |

**Your Solution:**
```sql
-- Write your solution here
```

## Question 3: Highest Average Update Call Duration
Identify the request_id(s) with the highest **average update call duration** among those request_ids that have at least three update calls.  
For each such request_id, calculate the average update call duration (rounded to two decimal places).  
Output the following columns: request_id and average_update_duration.

**Expected Output Format:**

| request_id | average_update_duration |
|------------|-------------------------|
| 2          | 19.80                   |
| 3          | 19.80                   |
| 1          | 15.14                   |

**Your Solution:**
```sql
-- Write your solution here
```
