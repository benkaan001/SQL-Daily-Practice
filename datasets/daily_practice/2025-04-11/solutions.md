## Question 1: Customer Call Frequency in Evening Hours
Each client’s request_id can have many calls. The first call for a given request_id is considered an “initial call” and any subsequent calls are “update calls.”  
Write a SQL query to count how many unique request_ids (i.e. customers) have a total of 3 or more calls (both initial and update calls combined) that occur between 3:00 PM and 6:00 PM (inclusive).  
Output a single row with the column **customer_count**.

**Expected Output Format:**

| customer_count |
|----------------|
| 1              |

**Your Solution:**
```sql
SELECT
	COUNT(DISTINCT request_id) AS customer_count
FROM
	calls
WHERE
	TIME(created_on) BETWEEN '15:00:00' AND '18:00:00'
GROUP BY
	request_id
HAVING 
	COUNT(id) >= 3;
```

## Question 2: Update Call Duration Ratio per Request
For each request_id, determine the total call duration for the initial call (i.e. the earliest call) and for all update calls (all other calls). Then, compute the percentage of the total call duration that comes from update calls (rounded to two decimal places).  
Output the following columns: request_id, initial_duration, update_duration, and update_percentage.

**Expected Output Format:**

| request_id | initial_duration | update_duration | update_percentage |
|------------|------------------|-----------------|-------------------|
| 1          | 28               | 106             | 79.10             |
| 2          | 3                | 99              | 97.06             |
| 3          | 15               | 99              | 86.84             |

**Your Solution:**
```sql
WITH ranked_calls AS (
  SELECT
  	*,
  	ROW_NUMBER() OVER (PARTITION BY request_id ORDER BY created_on) AS rn
  FROM
  	calls
), initial_calls AS (
  SELECT
  	request_id,
  	SUM(call_duration) AS initial_duration
  FROM
  	ranked_calls
  WHERE
  	rn = 1
  GROUP BY
  	request_id
), update_calls AS (
  SELECT
  	request_id,
  	SUM(call_duration) AS update_duration
  FROM
  	ranked_calls
  WHERE
  	rn <> 1
  GROUP BY
  	request_id
), all_calls AS (
  SELECT
  	request_id,
  	SUM(call_duration) AS all_calls_duration
  FROM
  	calls
  GROUP BY
  	request_id
)
SELECT
	ac.request_id,
    ic.initial_duration,
    uc.update_duration,
    ROUND((uc.update_duration/ac.all_calls_duration) * 100, 2) AS update_percentage
FROM
	initial_calls ic
JOIN
	update_calls uc ON ic.request_id = uc.request_id
JOIN
	all_calls ac ON ac.request_id = uc.request_id;
```

## Question 3: Average Duration of Early Morning Initial Calls
Consider only initial calls (the first call per request_id).  
Write a SQL query to calculate the average call_duration for those initial calls that occurred between 5:00 AM and 7:00 AM.  
Output a single row with the column **average_initial_duration** (rounded to two decimal places).

**Expected Output Format:**

| average_initial_duration |
|--------------------------|
| 28.00                    |

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
	ROUND(AVG(call_duration), 2) AS average_initial_duration
FROM
	ranked_calls
WHERE
	rn = 1 
	AND TIME(created_on) BETWEEN '05:00:00' AND '07:00:00';
```
