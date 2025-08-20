
## 1: User Engagement Scoring

**Objective:** As a data analyst, you need to create a daily engagement score for each user. The score is calculated based on their actions within a 24-hour period (a "day" is a calendar date).

**Task:** Write a query that calculates a `daily_engagement_score` for each user on each day they were active. The score is determined by the following weights:

* `PLAY`: +1 point
* `LIKE`: +5 points
* `ADD_TO_PLAYLIST`: +10 points
* `SKIP`: -2 points

The final report should show the `activity_date`, `user_id`, and their calculated `daily_engagement_score`. Only include users with a positive final score.

**Expected Output:**

| **activity_date** | **user_id** | **daily_engagement_score** |
| ----------------------- | ----------------- | -------------------------------- |
| 2023-12-15              | 101               | 20                               |
| 2023-12-15              | 102               | -3                               |
| 2023-12-15              | 103               | 8                                |
| 2023-12-16              | 101               | 2                                |
| 2023-12-16              | 104               | 1                                |
| 2023-12-16              | 105               | 1                                |
| 2023-12-16              | 106               | -1                               |
| 2023-12-16              | 107               | -1                               |
| 2023-12-16              | 108               | 1                                |

**Your Solution:**

```sql
-- Write your solution here
```

## Scenario 2: Skip Rate Anomaly Detection

**Objective:** You are tasked with finding songs that are performing poorly compared to their artist's other work. A key indicator of a poor song is an unusually high skip rate.

**Task:** Identify songs where the `skip_rate` is at least 50 percentage points higher than the artist's average skip rate across all their other songs. A "skip" is defined as a 'PLAY' event followed immediately by a 'SKIP' event for the same song by the same user in the same session.

The report should show the `artist_id`, the anomalous `song_id`, the `song_skip_rate`, and the `artist_avg_skip_rate` for comparison.

**Expected Output:**

| **artist_id** | **song_id** | **song_skip_rate** | **artist_avg_skip_rate** |
| ------------------- | ----------------- | ------------------------ | ------------------------------ |
| 4                   | 3002              | 66.67                    | 0.00                           |

**Your Solution:**

```sql
-- Write your solution here
```

## Scenario 3: Conversion Funnel from 'Like' to 'Add to Playlist'

**Objective:** The product team wants to understand the user journey from liking a song to adding it to a playlist. They want to know how quickly this "conversion" happens.

**Task:** Find all instances where a user `LIKE`s a song and then `ADD_TO_PLAYLIST`s that *same song* within the  *same session* . For each of these successful conversion events, calculate the time difference in seconds between the 'LIKE' and the 'ADD_TO_PLAYLIST' event.

The report should show the `user_id`, `session_id`, `song_id`, and the calculated `time_to_convert_seconds`.

**Expected Output:**

| **user_id** | **session_id** | **song_id** | **time_to_convert_seconds** |
| ----------------- | -------------------- | ----------------- | --------------------------------- |
| 101               | sess_A               | 1002              | 5                                 |

**Your Solution:**

```sql
-- Write your solution here
```
