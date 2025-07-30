## Question 1: Content Engagement Leaderboard

Create a leaderboard to identify the most engaging content for October 2023. The report should rank content based on total watch time and viewership.

1. For each piece of content (`content_id`), calculate the `total_watch_minutes` and the number of `unique_viewers`.
2. Rank each `content_id` within its `content_type` ('movie' or 'series'). The primary ranking criteria is `total_watch_minutes` (descending). Use `unique_viewers` (descending) as a tie-breaker.

The report should only include watch events that started in October 2023 and have a completed `watch_end_timestamp`.

**Expected Output:**

| content_type | content_id | series_title    | total_watch_minutes | unique_viewers | rank_in_category |
| ------------ | ---------- | --------------- | ------------------- | -------------- | ---------------- |
| movie        | 1001       |                 | 120                 | 1              | 1                |
| movie        | 1003       |                 | 105                 | 1              | 2                |
| movie        | 1002       |                 | 90                  | 1              | 3                |
| series       | 2001       | The Crown       | 100                 | 2              | 1                |
| series       | 3001       | Stranger Things | 90                  | 2              | 2                |
| series       | 2003       | The Crown       | 50                  | 1              | 3                |
| series       | 3002       | Stranger Things | 50                  | 1              | 3                |
| series       | 2002       | The Crown       | 48                  | 1              | 5                |

**Your Solution:**

```sql
WITH sessions AS (
	SELECT
		content_type,
		content_id,
		series_title,
		SUM(TIMESTAMPDIFF(MINUTE, watch_start_timestamp, watch_end_timestamp)) AS total_watch_minutes,
		COUNT(DISTINCT user_id) AS unique_viewers
	FROM
		watch_history
	WHERE
		DATE(watch_start_timestamp) BETWEEN '2023-10-01' AND '2023-10-31'
		AND watch_end_timestamp IS NOT NULL
	GROUP BY
		content_type,
		content_id,
		series_title
)
SELECT
	content_type,
	content_id,
	series_title,
	total_watch_minutes,
	unique_viewers,
	RANK() OVER (PARTITION BY content_type ORDER BY total_watch_minutes DESC, unique_viewers DESC) AS rank_in_category
FROM
	sessions;
```

## Question 2: Identifying Binge-Watching Sessions

Identify users who "binge-watch" a series. A binge-watching session is defined as watching three or more consecutive episodes of the same series, where the time between the end of one episode and the start of the next is less than 15 minutes.

Your report should show the `user_id`, the `series_title`, the number of `binged_episodes`, the `binge_session_start` (the start time of the first episode in the binge), and `binge_session_end` (the end time of the last episode in the binge).

**Expected Output:**

| user_id | series_title | binged_episodes | binge_session_start | binge_session_end   |
| ------- | ------------ | --------------- | ------------------- | ------------------- |
| 101     | The Crown    | 3               | 2023-10-01 20:00:00 | 2023-10-01 22:35:00 |
| 104     | The Witcher  | 3               | 2023-11-01 18:00:00 | 2023-11-01 20:40:00 |
**Your Solution:**

```sql
WITH session_history AS (
	SELECT
		user_id,
		series_title,
		episode_number,
		watch_start_timestamp,
		watch_end_timestamp,
		LAG(watch_end_timestamp, 1) OVER (PARTITION BY user_id, series_title ORDER BY season_number, episode_number)
		AS previous_episode_end

	FROM
		watch_history
	WHERE
		content_type = 'series'
		AND watch_end_timestamp IS NOT NULL
),
binges AS (
	SELECT
		user_id,
		series_title,
		watch_start_timestamp,
		watch_end_timestamp,
		CASE
			WHEN previous_episode_end IS NULL OR
			TIMESTAMPDIFF(MINUTE, previous_episode_end, watch_start_timestamp) >= 15 THEN 1
			ELSE 0
		END AS is_new_streak

	FROM
		session_history
),
binge_groups AS  (
	SELECT
		user_id,
		series_title,
		watch_start_timestamp,
		watch_end_timestamp,
		SUM(is_new_streak) OVER (PARTITION BY user_id, series_title ORDER BY watch_end_timestamp) AS binge_group_id
	FROM
		binges
)
SELECT
	user_id,
	series_title,
	COUNT(*) AS binged_episodes,
	MIN(watch_start_timestamp) AS binge_session_start,
	MAX(watch_end_timestamp) AS binge_session_end
FROM
	binge_groups
GROUP BY
	user_id,
	series_title,
	binge_group_id
HAVING
	COUNT(*) >= 3
ORDER BY
	user_id;

```

## Question 3: Monthly First and Last Content Watched

For each user, determine the very first and very last piece of content they watched each month.

The report should include the `user_id`, the `month` (formatted as 'YYYY-MM'), and then four columns: `first_content_id` and `first_content_start_time` for their first watch session of the month, and `last_content_id` and `last_content_start_time` for their last watch session of the month.

**Expected Output:**

| user_id | month   | first_content_id | first_content_start_time | last_content_id | last_content_start_time |
| ------- | ------- | ---------------- | ------------------------ | --------------- | ----------------------- |
| 101     | 2023-10 | 2001             | 2023-10-01 20:00:00      | 1001            | 2023-10-05 19:00:00     |
| 102     | 2023-10 | 1002             | 2023-10-02 18:00:00      | 2001            | 2023-10-08 11:00:00     |
| 103     | 2023-10 | 3001             | 2023-10-03 21:00:00      | 3002            | 2023-10-05 21:00:00     |
| 103     | 2023-11 | 1001             | 2023-11-01 19:30:00      | 1001            | 2023-11-01 19:30:00     |
| 104     | 2023-11 | 4001             | 2023-11-01 18:00:00      | 4004            | 2023-11-01 20:45:00     |
| 105     | 2023-11 | 2001             | 2023-11-02 10:00:00      | 3001            | 2023-11-02 11:00:00     |

**Your Solution:**

```sql
WITH ranked_contents AS (
	SELECT
		user_id,
		DATE_FORMAT(watch_start_timestamp, '%Y-%m') AS month,
		content_id,
		watch_start_timestamp,
		RANK() OVER (PARTITION BY user_id, DATE_FORMAT(watch_start_timestamp, '%Y-%m') ORDER BY watch_start_timestamp ) AS first_content_rank,
		RANK() OVER (PARTITION BY user_id, DATE_FORMAT(watch_start_timestamp, '%Y-%m') ORDER BY watch_start_timestamp DESC) AS last_content_rank
	FROM
		watch_history

)
SELECT
	user_id,
	month,
	MAX(CASE WHEN first_content_rank = 1 THEN content_id END) AS first_content_id,
	MAX(CASE WHEN first_content_rank = 1 THEN watch_start_timestamp END) AS first_content_start_time,
	MAX(CASE WHEN last_content_rank = 1 THEN content_id END) AS last_content_id,
	MAX(CASE WHEN last_content_rank = 1 THEN watch_start_timestamp END) AS last_content_start_time
FROM
	ranked_contents
WHERE
	first_content_rank = 1 OR last_content_rank = 1
GROUP BY
	user_id,
	month
ORDER BY
	user_id,
	month;
```
