## Question 1: Daily Usage Summary

For each user:
1. Count the total number of events recorded.
2. Count the number of distinct days on which they performed any actions.
3. Order the result by the total number of events, descending.

**Expected Output:**

| user_id | total_events | distinct_days |
|---------|-------------|---------------|
| 1       | 12          | 2             |
| 0       | 11          | 2             |
| 2       | 4           | 1             |

**Your Solution:**
````sql
SELECT
	user_id,
    COUNT(*) AS total_events,
    COUNT(DISTINCT DATE(activity_timestamp)) AS distinct_days
FROM
	user_activities
GROUP BY
	user_id
ORDER BY
	total_events DESC;
````

---

## Question 2: Scroll Frequency Analysis

For each user:
1. Calculate the total number of scroll actions (`scroll_up` or `scroll_down`).
2. Compute the ratio of scroll actions to overall events (scroll_ratio).
3. Sort by scroll_ratio descending, then by user_id ascending.

**Expected Output:**

| user_id | total_scroll_events | scroll_ratio |
|---------|---------------------|--------------|
| 2       | 3                   | 0.75         |
| 1       | 8                   | 0.67         |
| 0       | 5                   | 0.45         |

**Your Solution:**
````sql
WITH scroll_events AS (
  SELECT
      user_id,
      SUM(CASE WHEN action LIKE 'scroll%' THEN 1 ELSE 0 END) AS total_scroll_events,
  	  COUNT(*) AS overall_events
  FROM
      user_activities
  GROUP BY
      user_id
)
SELECT
	user_id,
    total_scroll_events,
    ROUND(total_scroll_events / overall_events, 2) AS scroll_ratio
FROM
	scroll_events
ORDER BY
	scroll_ratio DESC;
````

---

## Question 3: Average Session Time

A session is defined as the time from the latest `page_load` to the earliest valid `page_exit` on each day (only if `page_load` is before `page_exit`). For each user:
1. Calculate the session time per day (in minutes).
2. Return each user’s average session time across all their valid sessions.
3. Include users who have no valid session with a NULL average time.

**Expected Output:**

| user_id | average_session_time |
|---------|----------------------|
| 0       | 31.39               |
| 1       | 0.58                |
| 2       | NULL                |

**Your Solution:**
````sql
WITH page_events AS (
  SELECT
  	user_id,
  	DATE(activity_timestamp) AS activity_date,
  	MAX(CASE
  		WHEN action = 'page_load' THEN activity_timestamp
  		ELSE NULL
  	END) AS page_load_time,
  	MIN(CASE
  		WHEN action = 'page_exit' THEN activity_timestamp
  		ELSE NULL
  	END) AS page_exit_time
  FROM
  	user_activities
  GROUP BY
  	user_id,
  	DATE(activity_timestamp)
)
SELECT
	user_id,
    ROUND(
      AVG(
        CASE
            WHEN page_load_time IS NOT NULL AND page_exit_time IS NOT NULL AND page_load_time < page_exit_time THEN TIMESTAMPDIFF(SECOND, page_load_time, page_exit_time) / 60
            ELSE NULL
        END
      )
    , 2) AS average_session_time
FROM
    page_events
GROUP BY
	user_id;
```
