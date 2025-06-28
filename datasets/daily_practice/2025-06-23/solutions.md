### Question 1: Monthly Active Users (MAU) by Country and Growth

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

| country | month_year | current_month_mau | previous_month_mau | growth_rate_percentage |
| ------- | ---------- | ----------------- | ------------------ | ---------------------- |
| Canada  | 2025-06    | 1                 |                    |                        |
| France  | 2025-06    | 1                 |                    |                        |
| UK      | 2025-05    | 1                 |                    |                        |
| USA     | 2025-06    | 3                 |                    |                        |
| USA     | 2025-11    | 1                 | 3                  | -66.67                 |

**Your Solution:**

```sql
WITH monthly_users AS (
    SELECT
        u.country,
        DATE_FORMAT(al.activity_timestamp, '%Y-%m') AS month_year,
        MONTH(al.activity_timestamp) AS month_numeric,
        YEAR(al.activity_timestamp) AS year_numeric,
        COUNT(DISTINCT al.user_id) AS current_month_mau
    FROM
        ActivityLogs al
    JOIN
        Users u ON al.user_id = u.user_id
    WHERE
        al.activity_type IN ('login', 'purchase')
        AND YEAR(al.activity_timestamp) = 2025
        AND u.country IS NOT NULL
    GROUP BY
        u.country,
        month_year,
        month_numeric,
        year_numeric
),
maus AS (
    SELECT
        country,
        month_year,
        month_numeric,
        current_month_mau,
        LAG(current_month_mau, 1, 0) OVER (PARTITION BY country ORDER BY year_numeric, month_numeric) AS previous_month_mau
    FROM
        monthly_users
)
SELECT
    country,
    month_year,
    current_month_mau,
    NULLIF(previous_month_mau, 0) AS previous_month_mau,
    ROUND(
        (current_month_mau - previous_month_mau) * 100.0 / NULLIF(previous_month_mau, 0), 2
    ) AS growth_rate_percentage
FROM
    maus
ORDER BY
    country ASC,
    month_year ASC;

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
