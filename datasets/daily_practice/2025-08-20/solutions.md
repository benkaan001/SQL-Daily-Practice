## 1: User Engagement Scoring

**Objective:** As a data analyst, you need to create a daily engagement score for each user. The score is calculated based on their actions within a 24-hour period (a "day" is a calendar date).

**Task:** Write a query that calculates a `daily_engagement_score` for each user on each day they were active. The score is determined by the following weights:

* `PLAY`: +1 point
* `LIKE`: +5 points
* `ADD_TO_PLAYLIST`: +10 points
* `SKIP`: -2 points

The final report should show the `activity_date`, `user_id`, and their calculated `daily_engagement_score`. Only include users with a positive final score.

**Expected Output:**

| activity_date | user_id | daily_engagement_score |
| ------------- | ------- | ---------------------- |
| 2023-12-15    | 101     | 18                     |
| 2023-12-15    | 103     | 7                      |
| 2023-12-16    | 101     | 2                      |
| 2023-12-16    | 104     | 1                      |
| 2023-12-16    | 105     | 1                      |
| 2023-12-16    | 108     | 1                      |

**Your Solution:**

```sql
SELECT
	DATE(event_timestamp) AS activity_date,
	user_id,
	SUM(CASE
		WHEN event_type = 'PLAY' THEN 1
		WHEN event_type = 'LIKE' THEN 5
		WHEN event_type = 'ADD_TO_PLAYLIST' THEN 10
		WHEN event_type = 'SKIP' THEN -2
		ELSE 0
	END) AS daily_engagement_score

FROM
	music_streaming_events
GROUP BY
	activity_date,
	user_id
HAVING
	daily_engagement_score > 0;
```


## Scenario 2: Conversion Funnel from 'Like' to 'Add to Playlist'

**Objective:** The product team wants to understand the user journey from liking a song to adding it to a playlist. They want to know how quickly this "conversion" happens.

**Task:** Find all instances where a user `LIKE`s a song and then `ADD_TO_PLAYLIST`s that *same song* within the  *same session* . For each of these successful conversion events, calculate the time difference in seconds between the 'LIKE' and the 'ADD_TO_PLAYLIST' event.

The report should show the `user_id`, `session_id`, `song_id`, and the calculated `time_to_convert_seconds`.

**Expected Output:**

| user_id | session_id | song_id | time_to_convert_seconds |
| ------- | ---------- | ------- | ----------------------- |
| 101     | sess_A     | 1002    | 5                       |

**Your Solution:**

```sql
WITH timestamped_events AS (
	SELECT
	 	user_id,
	 	session_id,
	 	song_id,
	 	MIN(CASE WHEN event_type = 'LIKE' THEN event_timestamp END) AS like_event_timestamp,
	 	MIN(CASE WHEN event_type = 'ADD_TO_PLAYLIST' THEN event_timestamp END) AS adding_event_timestamp
	FROM
		music_streaming_events
	GROUP BY
		user_id,
		session_id,
		song_id
)
SELECT
	user_id,
	session_id,
	song_id,
	TIMESTAMPDIFF(SECOND, like_event_timestamp, adding_event_timestamp ) AS time_to_convert_seconds
FROM
	timestamped_events
WHERE
	like_event_timestamp IS NOT NULL
	AND adding_event_timestamp IS NOT NULL
	AND adding_event_timestamp > like_event_timestamp;
```
