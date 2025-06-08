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
-- Write your SQL query here
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
-- Write your SQL query here
```

---

## Question 3: Viewing Streaks for a Movie

For the movie 'Space Odyssey', find all users who watched it more than once (on different days). For each such user, show:
- Name
- Number of times watched
- The earliest and latest view dates
- The number of days between first and last view

Order by number of times watched descending, then name ascending.

**Expected Output:**

| name    | times_watched | first_view  | last_view   | days_between |
|---------|---------------|-------------|-------------|--------------|

```sql
-- Write your SQL query here
```
