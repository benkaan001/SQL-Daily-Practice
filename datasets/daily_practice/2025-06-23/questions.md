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
--- Write your solution here

```

### Question 2: User Session Duration Analysis

For each user, calculate their average daily activity duration (in minutes) for days where they have both a 'login' and a 'logout' activity.

An "activity day" duration is defined as the time between the earliest 'login' activity and the latest 'logout' activity for the same user on the same calendar day. If a user logs in but does not have a corresponding logout on the same day, that day's activity should be excluded from this calculation.

Return user_id, username, and average_daily_activity_duration_minutes.

Round average_daily_activity_duration_minutes to two decimal places.

Only include users who have at least one complete "activity day" (i.e., at least one day with both a login and a logout).

Order the results by user_id ascending.


**Expected Output:**

| user_id | username | average_session_duration_minutes |
| ------- | -------- | -------------------------------- |
| 1       | userA    | 371.25                           |
| 2       | userB    | 590.00                           |
| 3       | userC    | 480.00                           |
| 4       | userD    | 240.00                           |
| 8       | userH    | 540.00                           |

**Your Solution:**

```sql
--- Write your solution here
```
