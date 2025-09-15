## Puzzle: The Power User Streak

**The Scenario:** The product team wants to identify "power users" by finding who has the most consistent engagement with the application. A key metric for this is a user's longest continuous streak of daily activity.

**Your Task:** Write a query to find the longest continuous streak of days that each user was active. A "streak" is defined as a sequence of consecutive calendar days where the user had at least one event in the `feature_usage` table.

The final report should show the `user_id`, their `longest_streak_days`, the `streak_start_date`, and the `streak_end_date` for that longest streak. If a user has multiple streaks of the same maximum length, the most recent one should be reported.

| **user_id** | **longest_streak_days** | **streak_start_date** | **streak_end_date** |
| ----------------- | ----------------------------- | --------------------------- | ------------------------- |
| 101               | 3                             | 2023-09-01                  | 2023-09-03                |
| 102               | 5                             | 2023-09-01                  | 2023-09-05                |
| 103               | 1                             | 2023-09-10                  | 2023-09-10                |
| 104               | 3                             | 2023-09-08                  | 2023-09-10                |

**Your Solution:**

```sql
-- Step 1: Get a clean list of the distinct dates each user was active.
WITH DistinctUserActivity AS (
    SELECT DISTINCT
        user_id,
        DATE(event_timestamp) AS activity_date
    FROM
        feature_usage
),

-- Step 2: Use the "gaps and islands" technique on the clean, distinct dates.
StreakGroups AS (
    SELECT
        user_id,
        activity_date,
        -- This calculation is the key to identifying the streaks.
        DATE_SUB(activity_date, INTERVAL ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY activity_date) DAY) AS streak_group
    FROM
        DistinctUserActivity
),

-- Step 3: Calculate the duration and start/end dates for each streak.
Streaks AS (
    SELECT
        user_id,
        MIN(activity_date) AS streak_start_date,
        MAX(activity_date) AS streak_end_date,
        COUNT(*) AS streak_days
    FROM
        StreakGroups
    GROUP BY
        user_id,
        streak_group
),

-- Step 4: Rank each user's streaks to find their longest and most recent one.
RankedStreaks AS (
    SELECT
        user_id,
        streak_days AS longest_streak_days,
        streak_start_date,
        streak_end_date,
        -- Rank the streaks for each user. The best one is the longest,
        -- and if there's a tie, the most recent one wins.
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY streak_days DESC, streak_start_date DESC
        ) AS rn
    FROM
        Streaks
)

-- Final Step: Select only the #1 ranked streak for each user.
SELECT
    user_id,
    longest_streak_days,
    streak_start_date,
    streak_end_date
FROM
    RankedStreaks
WHERE
    rn = 1
ORDER BY
    user_id;
```
