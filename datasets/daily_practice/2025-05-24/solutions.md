### Question 1: Call Counts By User Status

1. For each user status, calculate the total number of calls made.
2. Count how many distinct users in each status made at least one call.
3. Sort the result by total calls (descending), then by status (ascending).

**Expected Output:**

| status   | total_calls | distinct_users |
|----------|------------|----------------|
| free     | 15         | 8              |
| paid     | 15         | 6              |
| inactive | 10         | 6              |

**Your Solution:**
````sql

SELECT
    u.status,
    COUNT(c.call_id) AS total_calls,
    COUNT(DISTINCT u.user_id) AS distinct_users
FROM
    rc_users u
JOIN
    rc_calls c ON u.user_id = c.user_id
GROUP BY
    u.status
ORDER BY
    total_calls DESC,
    u.status ASC;

-- Using CTE

WITH calls AS (
  SELECT
      u.status,
      COUNT(c.call_id) AS total_calls
  FROM
      rc_users u
  JOIN
      rc_calls c ON u.user_id = c.user_id
  GROUP BY
      u.status
)
, users AS (
  SELECT
  	u.status,
  	COUNT(DISTINCT u.user_id) AS distinct_users
  FROM
  	rc_users u
  LEFT JOIN
  	rc_calls c ON u.user_id = c.user_id
  WHERE
  	c.call_id IS NOT NULL
  GROUP BY
  	u.status
)
SELECT
	c.status,
    c.total_calls,
    u.distinct_users
FROM
	users u
JOIN
	calls c ON u.status = c.status
ORDER BY
	c.total_calls DESC,
    u.status ASC;
````

---

### Question 2: Monthly Calling Patterns

1. Group the calls into March 2020 and April 2020.
2. For each month, show:
   - Total calls
   - Number of distinct callers
   - Average calls per active user (total calls / distinct callers)
3. Sort by month in ascending order (March first, then April).

**Expected Output:**

| month  | total_calls | distinct_users | avg_calls_per_user |
|--------|------------|----------------|---------------------|
| March  | 20         | 15             | 1.33               |
| April  | 20         | 16             | 1.25               |

**Your Solution:**
````sql
WITH grouped_calls AS (
  SELECT
      DATE_FORMAT(c.call_date, '%M') AS month,
      MONTH(c.call_date) AS numeric_month,
      COUNT(c.call_id) AS total_calls,
      COUNT(DISTINCT u.user_id) AS distinct_users
  FROM
      rc_users u
  JOIN
      rc_calls c ON u.user_id = c.user_id
  WHERE
      DATE_FORMAT(c.call_date, '%M') IN ('March', 'April')
      AND YEAR(c.call_date) = 2020
  GROUP BY
      DATE_FORMAT(c.call_date, '%M'),
      MONTH(c.call_date)
)
SELECT
	month,
   total_calls,
   distinct_users,
   ROUND(total_calls / distinct_users, 2) AS avg_calls_per_user
FROM
	grouped_calls
ORDER BY
	numeric_month;

````

---

### Question 3: Top 2 Users in Each Company

1. For each `company_id`, rank users by their total call counts in descending order.
2. Keep ties within the same rank.
3. Return only the top two ranks per company.

**Expected Output:**

| company_id | user_id | user_rank |
| ---------- | ------- | --------- |
| 1          | 1859    | 1         |
| 1          | 1525    | 2         |
| 1          | 1854    | 2         |
| 2          | 1162    | 1         |
| 2          | 1181    | 1         |
| 2          | 1891    | 1         |
| 2          | 1857    | 2         |
| 2          | 1910    | 2         |
| 3          | 1093    | 1         |
| 3          | 1503    | 1         |

**Your Solution:**
````sql
WITH call_counts AS (
    SELECT
        u.company_id,
        u.user_id,
        COUNT(c.call_id) AS total_calls
    FROM
        rc_users u
    JOIN
        rc_calls c ON u.user_id = c.user_id
    GROUP BY
        u.company_id,
        u.user_id
)
,ranking AS (
    SELECT
        company_id,
        user_id,
        DENSE_RANK() OVER (PARTITION BY company_id ORDER BY total_calls DESC) AS user_rank
    FROM
        call_counts
)
SELECT
    company_id,
    user_id,
    user_rank
FROM
    ranking
WHERE
    user_rank <= 2
ORDER BY
    company_id ASC,
    user_rank ASC,
    user_id ASC;
```
