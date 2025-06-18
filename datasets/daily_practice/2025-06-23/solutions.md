### Question 1: Users with Increasing Daily Login Count

Identify users who have shown an increasing trend in their daily login counts over at least two consecutive days within June 2025.

A login is defined by an activity_type of 'login'.

Return the user_id, username, start_date_of_trend (the first day of the increasing streak), and trend_length_days.

Only consider streaks of 2 or more days. If a user has multiple such streaks, return the longest one. If there's a tie for the longest streak, return the one with the earliest start_date_of_trend.

**Expected Output:**

| **user_id** | **username** | **start_date_of_trend** | **trend_length_days** |
| ----------------- | ------------------ | ----------------------------- | --------------------------- |
| 2                 | userB              | 2025-06-16                    | 3                           |

**Your Solution:**

```
--- Write your solution here

```

### Question 2: Monthly Active Users (MAU) by Country and Growth

Calculate the Monthly Active Users (MAU) for each country for each month in 2025.

An active user is defined as any user who has at least one 'login' or 'purchase' activity in that month.

If a country has no active users in a month, it should not appear.

Also, calculate the month-over-month MAU growth rate percentage for each country.

The growth rate should be ((Current Month MAU - Previous Month MAU) / Previous Month MAU) * 100.

Round growth_rate_percentage to two decimal places.

For the first month of activity for a country, previous_month_mau and growth_rate_percentage should be NULL.

Output country, month_year (format %Y-%m), current_month_mau, previous_month_mau, and growth_rate_percentage.

Order the results by country ascending, then by month_year ascending.

**Expected Output:**

| **country** | **month_year** | **current_month_mau** | **previous_month_mau** | **growth_rate_percentage** |
| ----------------- | -------------------- | --------------------------- | ---------------------------- | -------------------------------- |
| Canada            | 2025-06              | 1                           | ``                    | ``                        |
| France            | 2025-06              | 1                           | ``                    | ``                        |
| Germany           | 2025-06              | 0                           | ``                    | ``                        |
| UK                | 2025-05              | 1                           | ``                    | ``                        |
| USA               | 2025-06              | 2                           | ``                    | ``                        |
| USA               | 2025-11              | 1                           | 2                            | -50.00                           |

**Your Solution:**

```
--- Write your solution here

```

### Question 3: User Session Duration Analysis

For each user, calculate their average session duration (in minutes) for sessions that start with a 'login' and end with a 'logout' on the same day.

A session is defined as the time between a 'login' and the immediately following 'logout' for the same user on the same day. If a 'login' is not followed by a 'logout' on the same day, that session is considered incomplete and should be excluded from this calculation.

Return user_id, username, and average_session_duration_minutes.

Round average_session_duration_minutes to two decimal places.

Only include users who have at least one complete session.

Order the results by user_id ascending.

**Expected Output:**

| **user_id** | **username** | **average_session_duration_minutes** |
| ----------------- | ------------------ | ------------------------------------------ |
| 1                 | userA              | 322.50                                     |
| 2                 | userB              | 570.00                                     |
| 3                 | userC              | 480.00                                     |
| 4                 | userD              | 60.00                                      |
| 8                 | userH              | 540.00                                     |

**Your Solution:**

```
--- Write your solution here

```
