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
WITH ranked_calls AS (
  SELECT
  	*,
   	ROW_NUMBER() OVER (PARTITION BY request_id ORDER BY created_on) AS rn
  FROM
  	calls
)
SELECT
	ROUND(AVG(call_duration), 2) AS average_update_duration
FROM
	ranked_calls
WHERE
	rn != 1;
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

WITH ranked_calls AS (
  SELECT
  	*,
  	ROW_NUMBER() OVER (PARTITION BY request_id ORDER BY created_on) AS rnk
  FROM
  	calls
), initial_calls AS (
  SELECT
  	request_id,
  	SUM(call_duration) AS total_initial_duration
  FROM
  	ranked_calls
  WHERE 
  	rnk = 1
  GROUP BY
  	request_id
), update_calls AS (
  SELECT
  	request_id,
  	SUM(call_duration) AS total_update_duration
  FROM
  	ranked_calls
  WHERE
  	rnk != 1
  GROUP BY
  	request_id
), all_calls AS (
  SELECT
  	request_id,
  	SUM(call_duration) AS total_call_duration
  FROM
  	calls
  GROUP BY
  	request_id
)
SELECT
	ic.request_id,
    ic.total_initial_duration,
    uc.total_update_duration,
    ROUND(uc.total_update_duration / ac.total_call_duration * 100, 2) AS update_percentage
FROM
	initial_calls ic
JOIN
	update_calls uc ON ic.request_id = uc.request_id
JOIN
	all_calls ac ON ac.request_id = uc.request_id;
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
WITH ranked_calls AS (
  SELECT
  	*,
    ROW_NUMBER() OVER (PARTITION BY request_id ORDER BY created_on) AS rn
  FROM
  	calls
), update_calls AS (
  SELECT
  	*
  FROM
  	ranked_calls
  WHERE
  	rn <> 1
)
SELECT
	request_id,
    ROUND(AVG(call_duration), 2) AS average_update_duration
FROM
	update_calls
GROUP BY
	request_id
HAVING 
	COUNT(DISTINCT id) >= 3
ORDER BY
	average_update_duration DESC;
```
