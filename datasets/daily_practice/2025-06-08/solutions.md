## Question 1: Top Movie Genres by Total Watch Time

Find the top 3 movie genres by total watch time (sum of `watch_time_min`) across all users. For each genre, show:
- The total watch time
- The number of unique users who watched movies in that genre
- The average watch time per user (rounded to 1 decimal)

Order by total watch time descending, then genre alphabetically.

**Expected Output:**

| genre       | total_watch_time | unique_users | avg_watch_time_per_user |
| ----------- | ---------------- | ------------ | ----------------------- |
| Sci-Fi      | 420              | 3            | 140.00                  |
| Action      | 240              | 2            | 120.00                  |
| Documentary | 240              | 3            | 80.00                   |
```sql

SELECT
  m.genre,
  SUM(vh.watch_time_min) AS total_watch_time,
  COUNT(DISTINCT u.user_id) AS unique_users,
  ROUND(SUM(vh.watch_time_min) / COUNT(DISTINCT u.user_id), 2) AS avg_watch_time_per_user
FROM
  subscriptions s
JOIN
  users u ON u.user_id = s.user_id
JOIN
  viewing_history vh ON vh.user_id = u.user_id
JOIN
  movies m ON m.movie_id = vh.movie_id
GROUP BY
  m.genre
ORDER BY
  total_watch_time DESC
LIMIT 3;
```
---

## Question 2: User Retention and Viewing Activity

For each user, show:
- Name
- Country
- Subscription plan
- Number of movies watched in June 2025
- The date of their most recent view

Only include users who watched at least 2 movies in June 2025. Order by number of movies watched descending, then name ascending.

**Expected Output:**

| name    | country | plan     | movies_watched_june | last_view_date |
| ------- | ------- | -------- | ------------------- | -------------- |
| Alice   | USA     | Premium  | 3                   | 2025-06-08     |
| Charlie | USA     | Premium  | 3                   | 2025-06-08     |
| Eve     | USA     | Standard | 3                   | 2025-06-08     |
| Diana   | UK      | Basic    | 2                   | 2025-06-06     |

```sql
SELECT
	u.name,
    u.country,
   	s.plan,
    COUNT(vh.movie_id) AS movies_watched_june,
    MAX(vh.view_date) AS last_view_date
FROM
	users u
JOIN
	viewing_history vh ON vh.user_id = u.user_id
JOIN
	subscriptions s ON u.user_id = s.user_id
WHERE
	MONTH(vh.view_date) = 6
GROUP BY
	u.name,
    u.country,
    s.plan
HAVING
	COUNT(vh.movie_id) >= 2
ORDER BY
	movies_watched_june DESC,
    u.name ASC;
```
---

## Question 3: Viewing Streaks for a Movie

For the movie 'Space Odyssey', find all users who watched it more than once (on different days). For each such user, show:
- Name
- Number of times watched
- The earliest and latest view dates
- The number of days between first and last view

Order by number of times watched descending, then name ascending.

```sql
SELECT
	u.name,
    COUNT(DISTINCT vh.view_date) AS times_watched,
    MIN(vh.view_date) AS first_view,
    MAX(vh.view_date) AS last_view,
    COALESCE(
      DATEDIFF(MAX(vh.view_date), MIN(vh.view_date))
    , 0) AS days_between
FROM
	movies m
JOIN
	viewing_history vh ON vh.movie_id = m.movie_id
JOIN
	users u ON u.user_id = vh.user_id
WHERE
	m.title = 'Space Odyssey'
GROUP BY
	u.name
HAVING
	days_between >= 1
ORDER BY
	times_watched DESC,
    u.name ASC;
```

**Expected Output:**

| name    | times_watched | first_view  | last_view   | days_between |
|---------|---------------|-------------|-------------|--------------|

