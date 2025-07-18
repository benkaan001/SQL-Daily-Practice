## Question 1: Daily Platform Usage and Spending Habits

Create a daily summary report that shows user activity and spending across different platforms.

The report must calculate the total number of sessions, the number of unique users, the total duration of all sessions in minutes, and the total spend for each day and platform combination. Exclude sessions where `total_spend` is NULL from the `total_spend` calculation but include them in all other counts.

Order the results by date and then by platform.

**Expected Output:**

| session_date | platform | total_sessions | unique_users | total_duration_minutes | total_daily_spend |
| ------------ | -------- | -------------- | ------------ | ---------------------- | ----------------- |
| 2023-03-01   | Desktop  | 1              | 1            | 35                     | 49.99             |
| 2023-03-01   | Mobile   | 2              | 2            | 55                     | 19.99             |
| 2023-03-02   | Desktop  | 2              | 2            | 115                    | 240.40            |
| 2023-03-02   | Tablet   | 1              | 1            | 30                     | 0.00              |
| 2023-03-03   | Desktop  | 1              | 1            | 45                     | 75.00             |
| 2023-03-03   | Mobile   | 2              | 2            | 40                     | 25.00             |
| 2023-03-04   | Desktop  | 1              | 1            | 55                     | 250.00            |
| 2023-03-04   | Mobile   | 1              | 1            | 15                     | 12.50             |
| 2023-03-04   | Tablet   | 1              | 1            | 30                     | 0.00              |
| 2023-03-05   | Desktop  | 2              | 2            | 70                     | 110.75            |
| 2023-03-05   | Mobile   | 1              | 1            | 15                     | 0.00              |
| 2023-03-06   | Desktop  | 2              | 2            | 85                     | 211.99            |
| 2023-03-06   | Mobile   | 1              | 1            | 15                     | 9.99              |
| 2023-03-07   | Desktop  | 1              | 1            | 10                     | 0.00              |
| 2023-03-07   | Mobile   | 2              | 2            | 55                     | 55.50             |
| 2023-03-07   | Tablet   | 1              | 1            | 20                     | 35.00             |
| 2023-03-08   | Desktop  | 1              | 1            | 45                     | 180.00            |
| 2023-03-08   | Mobile   | 1              | 1            | 35                     | 22.75             |
| 2023-03-08   | Tablet   | 1              | 1            | 30                     | 40.00             |  |

**Your Solution:**

```sql
SELECT
	DATE(session_start) AS session_date,
	platform,
	COUNT(*) AS total_sessions,
	COUNT(DISTINCT user_id) AS unique_users,
	SUM(TIMESTAMPDIFF(MINUTE, session_start, session_end)) AS total_duration_minutes,
	ROUND(SUM(CASE WHEN total_spend IS NULL THEN 0 ELSE total_spend END), 2) AS total_daily_spend
FROM
	user_sessions
GROUP BY
	DATE(session_start),
	platform
ORDER BY
	session_date,
	platform;
```

## Question 2: User Session Ranking by Duration

For each user, rank their sessions by duration in descending order.

The output should include the `user_id`, `session_id`, `platform`, the session duration in minutes, and the rank of that session among all sessions for that user.

Order the results by `user_id` and then by the session rank.

**Expected Output:**

| **user_id** | **session_id** | **platform** | **duration_minutes** | **session_rank** |
| ----------------- | -------------------- | ------------------ | -------------------------- | ---------------------- |
| 101               | 8                    | Desktop            | 45                         | 1                      |
| 101               | 1                    | Desktop            | 35                         | 2                      |
| 101               | 3                    | Mobile             | 25                         | 3                      |
| 101               | 15                   | Mobile             | 15                         | 4                      |
| 101               | 22                   | Mobile             | 15                         | 4                      |
| 102               | 6                    | Desktop            | 40                         | 1                      |
| 102               | 18                   | Desktop            | 45                         | 2                      |
| 102               | 24                   | Mobile             | 35                         | 3                      |
| 102               | 2                    | Mobile             | 30                         | 4                      |
| 102               | 12                   | Tablet             | 30                         | 4                      |
| 103               | 4                    | Desktop            | 75                         | 1                      |
| 103               | 16                   | Desktop            | 40                         | 2                      |
| 103               | 25                   | Tablet             | 30                         | 3                      |
| 103               | 9                    | Mobile             | 20                         | 4                      |
| 104               | 5                    | Tablet             | 30                         | 1                      |
| 104               | 11                   | Mobile             | 15                         | 2                      |
| 104               | 20                   | Desktop            | 10                         | 3                      |
| 105               | 14                   | Desktop            | 40                         | 1                      |
| 105               | 7                    | Mobile             | 20                         | 2                      |
| 106               | 10                   | Desktop            | 55                         | 1                      |
| 106               | 21                   | Mobile             | 40                         | 2                      |
| 107               | 13                   | Desktop            | 30                         | 1                      |
| 108               | 17                   | Mobile             | 15                         | 1                      |
| 109               | 19                   | Tablet             | 20                         | 1                      |
| 110               | 23                   | Desktop            | 45                         | 1                      |

**Your Solution:**

```sql
	SELECT
		user_id,
		session_id,
		platform,
		TIMESTAMPDIFF(MINUTE, session_start, session_end) AS duration_minutes
	FROM
	 	user_sessions
)
SELECT
	user_id,
	session_id,
	platform,
	duration_minutes,
	RANK() OVER (PARTITION BY user_id ORDER BY duration_minutes DESC) AS session_rank
FROM
	session_times
ORDER BY
	user_id,
	session_rank;
```

## Question 3: Identifying Back-to-Back Sessions

Find all instances where a user starts a new session after their previous session ending.

For each such occurrence, the report should show the `user_id`, the `platform` and `session_end` time of the first session, and the `platform` and `session_start` time of the subsequent session. Also, calculate the time difference in minutes between the two sessions.

Order the results by `user_id` and then by the end time of the first session.

**Expected Output:**

| user_id | previous_platform | previous_session_end | next_platform | next_session_start  | idle_time_minutes |
| ------- | ----------------- | -------------------- | ------------- | ------------------- | ----------------- |
| 101     | Desktop           | 2023-03-01 08:35:00  | Mobile        | 2023-03-01 19:00:00 | 625               |
| 101     | Mobile            | 2023-03-01 19:25:00  | Desktop       | 2023-03-03 11:00:00 | 2375              |
| 101     | Desktop           | 2023-03-03 11:45:00  | Mobile        | 2023-03-05 18:45:00 | 3300              |
| 101     | Mobile            | 2023-03-05 19:00:00  | Mobile        | 2023-03-07 21:00:00 | 3000              |
| 102     | Mobile            | 2023-03-01 09:45:00  | Desktop       | 2023-03-02 14:30:00 | 1725              |
| 102     | Desktop           | 2023-03-02 15:10:00  | Tablet        | 2023-03-04 20:00:00 | 3170              |
| 102     | Tablet            | 2023-03-04 20:30:00  | Desktop       | 2023-03-06 17:00:00 | 2670              |
| 102     | Desktop           | 2023-03-06 17:45:00  | Mobile        | 2023-03-08 11:00:00 | 2475              |
| 103     | Desktop           | 2023-03-02 11:15:00  | Mobile        | 2023-03-03 16:00:00 | 1725              |
| 103     | Mobile            | 2023-03-03 16:20:00  | Desktop       | 2023-03-06 11:20:00 | 4020              |
| 103     | Desktop           | 2023-03-06 12:00:00  | Tablet        | 2023-03-08 15:00:00 | 3060              |
| 104     | Tablet            | 2023-03-02 11:30:00  | Mobile        | 2023-03-04 15:10:00 | 3100              |
| 104     | Mobile            | 2023-03-04 15:25:00  | Desktop       | 2023-03-07 13:30:00 | 4205              |
| 105     | Mobile            | 2023-03-03 08:05:00  | Desktop       | 2023-03-05 12:00:00 | 3115              |
| 106     | Desktop           | 2023-03-04 13:55:00  | Mobile        | 2023-03-07 16:50:00 | 4495              |


**Your Solution:**

```sql
WITH ranked_sessions AS (
	SELECT
		user_id,
		session_start,
		session_end,
		platform,
		ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY session_end) AS rn
	FROM user_sessions
)

SELECT
	p.user_id,
	p.platform AS previous_platform,
	p.session_end AS previous_session_end,
	n.platform AS next_platform,
	n.session_start AS next_session_start,
	TIMESTAMPDIFF(MINUTE, p.session_end, n.session_start) AS idle_time_minutes
FROM
	ranked_sessions p
JOIN
	ranked_sessions n
	ON p.user_id = n.user_id
	AND n.rn = p.rn + 1
ORDER BY
	p.user_id, p.session_end;
```
