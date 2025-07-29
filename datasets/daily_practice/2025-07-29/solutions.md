## Question 1: Daily Regional Playtime Analysis

Generate a daily report summarizing player engagement for each region. The report should include the `log_date`, the `region`, the count of `daily_active_players` (unique players), the `total_sessions` (total logins), and the `total_playtime_hours` (sum of all session durations in hours, rounded to two decimal places).

Order the results by `log_date` and then by `region`.

**Expected Output:**

| **log_date** | **region** | **daily_active_players** | **total_sessions** | **total_playtime_hours** |
| ------------------ | ---------------- | ------------------------------ | ------------------------ | ------------------------------ |
| 2023-12-01         | APAC             | 1                              | 3                        | 1.50                           |
| 2023-12-01         | EU               | 1                              | 2                        | 7.50                           |
| 2023-12-01         | NA               | 1                              | 1                        | 1.50                           |
| 2023-12-02         | APAC             | 1                              | 1                        | 0.50                           |
| 2023-12-02         | EU               | 1                              | 1                        | 4.00                           |
| 2023-12-02         | NA               | 2                              | 2                        | 2.75                           |
| 2023-12-03         | APAC             | 1                              | 1                        | 0.50                           |
| 2023-12-03         | EU               | 1                              | 1                        | 1.00                           |
| 2023-12-03         | NA               | 1                              | 1                        | 1.50                           |
| 2023-12-04         | APAC             | 2                              | 2                        | 1.50                           |
| 2023-12-04         | EU               | 1                              | 1                        | 4.00                           |
| 2023-12-05         | EU               | 1                              | 1                        | 1.50                           |
| 2023-12-05         | NA               | 1                              | 1                        | 1.00                           |
| 2023-12-06         | EU               | 1                              | 1                        | 1.50                           |
| 2023-12-07         | EU               | 1                              | 1                        | 1.50                           |

**Your Solution:**

```sql
-- Write your solution here
```

## Question 2: Player Login Streaks

Identify players who have logged in on three or more consecutive days. For each such streak, the report should show the `player_id`, the `streak_start_date`, the `streak_end_date`, and the `streak_duration` in days.

A player can have multiple streaks. For example, if a player logs in on days 1, 2, 3, and then again on days 7, 8, 9, this should result in two separate streaks in the output.

Order the results by `player_id` and then by `streak_start_date`.

**Expected Output:**

| **player_id** | **streak_start_date** | **streak_end_date** | **streak_duration** |
| ------------------- | --------------------------- | ------------------------- | ------------------------- |
| 101                 | 2023-12-01                  | 2023-12-03                | 3                         |
| 103                 | 2023-12-01                  | 2023-12-04                | 4                         |
| 105                 | 2023-12-05                  | 2023-12-07                | 3                         |

**Your Solution:**

```sql
-- Write your solution here
```

## Question 3: Identifying Top 5% Longest Sessions per Region

Create a report that identifies the top 5% longest player sessions within each region. A session is defined by a single record in the `player_logins` table.

The output should include the `region`, `player_id`, the `session_duration_minutes`, and the session's percentile rank within its region. The percentile rank should be calculated based on session duration.

Order the results by `region` and then by `session_duration_minutes` in descending order.

**Expected Output:**

| **region** | **player_id** | **session_duration_minutes** | **percentile_rank** |
| ---------------- | ------------------- | ---------------------------------- | ------------------------- |
| APAC             | 103                 | 30                                 | 0.00                      |
| EU               | 102                 | 240                                | 0.00                      |
| NA               | 101                 | 105                                | 0.00                      |

**Your Solution:**

```sql
-- Write your solution here
```
