## Question 1: Tier-Based Engagement Ranking

The Product team wants to identify top-tier engagers within each subscription category.

Write a query that parses the `plan_name` to extract the "Category" (the part before the colon). For each category (e.g., 'PREMIUM', 'BASIC'), find the users and rank them based on their total `view_duration_mins`.

The report should include the `category`, `user_id`, `total_viewtime`, and their `rank_within_category`. If two users have the same view time, the one who joined earlier (`join_date`) should rank higher.

| **category** | **user_id** | **total_viewtime** | **rank_within_category** |
| ------------------ | ----------------- | ------------------------ | ------------------------------ |
| BASIC              | 2                 | 75                       | 1                              |
| BASIC              | 4                 | 58                       | 2                              |
| PREMIUM            | 5                 | 175                      | 1                              |
| PREMIUM            | 3                 | 145                      | 2                              |
| PREMIUM            | 1                 | 125                      | 3                              |

**Your Solution:**

```
-- Write your solution here

```

## Question 2: Series Completion & Season Drop-off

We need to analyze how users move from Season 1 to Season 2 of the show "Midnight Sun".

Find all users who watched at least one episode of "Midnight Sun | S01". For these users, calculate:

1. The total minutes they spent watching "Midnight Sun" in Season 1.
2. A boolean flag `watched_season_2` (1 if they watched any episode of "Midnight Sun | S02", else 0).

The output should show `user_id`, `s1_total_minutes`, and `watched_season_2`.

| **user_id** | **s1_total_minutes** | **watched_season_2** |
| ----------------- | -------------------------- | -------------------------- |
| 1                 | 95                         | 0                          |
| 2                 | 15                         | 0                          |
| 3                 | 90                         | 1                          |
| 4                 | 5                          | 0                          |
| 5                 | 40                         | 0                          |

**Your Solution:**

```
-- Write your solution here

```

## Question 3: Outlier View Detection by Genre

Identify "Outlier Views"—interactions where the `view_duration_mins` was higher than the 90th percentile of durations for that specific genre.

To do this, use a window function to calculate the 90th percentile of `view_duration_mins` partitioned by `genre`. Return the `view_id`, `genre`, `show_title`, and `view_duration_mins` for any view that meets this criteria.

| **view_id** | **genre** | **show_title** | **view_duration_mins** |
| ----------------- | --------------- | -------------------- | ---------------------------- |
| 8                 | Sci-Fi          | Midnight Sun         | S02                          |
| 13                | Documentary     | Ocean Blue           | S01                          |

**Your Solution:**

```sql
-- Write your solution here
```
