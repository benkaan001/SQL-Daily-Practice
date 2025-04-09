## Question 1: Average Duration of Initial Calls
Each unique request_id may have multiple calls. The very first call for each request_id (based on created_on) is considered the “initial call.”  
Write a query to compute the average call_duration (in minutes) for all initial calls across all request_ids.  
Output a single row with the column **average_initial_duration** (rounded to two decimal places).

**Expected Output Format:**

| average_initial_duration |
|--------------------------|
| 15.33                    |

**Your Solution:**
```sql
WITH initial_calls AS(
  SELECT
    id,
    call_duration,
    ROW_NUMBER() OVER (PARTITION BY request_id ORDER BY created_on) AS call_rank
  FROM
  	calls
)
SELECT
	ROUND(AVG(call_duration), 2) AS average_initial_duration
FROM
	initial_calls
WHERE
	call_rank = 1;
```

## Question 2: Total Call Duration and Count per Request
For each request_id, calculate the total call duration (sum of call_duration) and the total number of calls.  
Output the following columns: request_id, total_call_duration, and call_count.

**Expected Output Format:**

| request_id | total_call_duration | call_count |
|------------|---------------------|------------|
| 1          | 134                 | 8          |
| 2          | 102                 | 6          |
| 3          | 114                 | 6          |

**Your Solution:**
```sql
SELECT
	request_id,
    SUM(call_duration) AS total_call_duration,
    COUNT(DISTINCT id) AS call_count
FROM
	calls
GROUP BY
	request_id;
```

## Question 3: Request with the Highest Average Call Duration
Calculate the average call duration for each request_id across all of its calls. Then, determine which request_id has the highest average call duration.  
Output the following columns: request_id and average_call_duration (rounded to two decimal places).  
If multiple request_ids have the same highest average, return all.

**Expected Output Format:**

| request_id | average_call_duration |
|------------|-----------------------|
| 3          | 19.00                 |

**Your Solution:**
```sql
WITH ranked_call_averages AS (
  SELECT
  	request_id,
  	ROUND(AVG(call_duration), 2) AS average_call_duration,
  	RANK() OVER (ORDER BY AVG(call_duration) DESC) AS call_rank
  FROM
  	calls
  GROUP BY
  	request_id
)
SELECT
	request_id,
    average_call_duration
FROM
	ranked_call_averages
WHERE
	call_rank = 1;
```
