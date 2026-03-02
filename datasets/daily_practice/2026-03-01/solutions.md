## Puzzle: The Cohort Retention Matrix

**The Scenario:** As a Growth Data Analyst, the product team wants to understand user retention over time. The standard metric for this is N-Month Cohort Retention: what percentage of users from a specific monthly signup cohort are still active in the N-th calendar month after their signup?

**Your Task:** Calculate the Month 1 and Month 2 retention rates for each monthly signup cohort in the database.

**Rules:**

1. A "cohort" is defined by the year and month a user signed up (e.g., '2026-01').
2. "Month 1" activity means the user logged in during the calendar month exactly 1 month *after* their signup month. (e.g., For a Jan signup, Month 1 is Feb).
3. "Month 2" activity means the user logged in during the calendar month exactly 2 months *after* their signup month.
4. Rates should be rounded to two decimal places.

The report should show the `signup_cohort`, the total `cohort_size` (number of users who signed up that month), the `month_1_retention_pct`, and the `month_2_retention_pct`.

**Expected Output:**

| **signup_cohort** | **cohort_size** | **month_1_retention_pct** | **month_2_retention_pct** |
| ----------------------- | --------------------- | ------------------------------- | ------------------------------- |
| 2026-01                 | 3                     | 33.33                           | 66.67                           |
| 2026-02                 | 2                     | 50.00                           | 0.00                            |

### Tips for Approaching the Problem

1. **Determine the Cohorts:** First, find the cohort month for each user and group by this to calculate the initial `cohort_size`. A CTE is perfect for this base table. You can format the date as 'YYYY-MM'.
2. **Calculate Relative Activity Months:** You need to know how many calendar months passed between a user's `signup_date` and each of their `login_date`s.
   * Use a function like `TIMESTAMPDIFF(MONTH, DATE_FORMAT(signup_date, '%Y-%m-01'), DATE_FORMAT(login_date, '%Y-%m-01'))` to safely find the calendar month difference regardless of the specific day of the month. Let's call this `months_since_signup`.
3. **Isolate Unique Active Users:** A user might log in 15 times in Month 1, but they only count as *one* retained user. You need a CTE that lists `user_id`, `signup_cohort`, and `months_since_signup`, ensuring you use `DISTINCT` so each user is only counted once per relative month.
4. **Pivot and Aggregate:** Join your unique monthly activity records back to your initial cohort size CTE. Group by the `signup_cohort` and use conditional aggregation to count the retained users:
   * `SUM(CASE WHEN months_since_signup = 1 THEN 1 ELSE 0 END)`
5. **Calculate Percentages:** Finally, divide your pivoted counts by the `cohort_size` and multiply by 100 to get the final retention percentages.

**Your Solution:**

```sql
WITH cohort_sizes AS (
    SELECT 
        DATE_FORMAT(signup_date, '%Y-%m') AS signup_cohort, 
        COUNT(DISTINCT user_id) AS cohort_size
    FROM 
        app_users 
    GROUP BY 
        DATE_FORMAT(signup_date, '%Y-%m')
),
user_activity AS (
    SELECT 
        u.user_id,
        DATE_FORMAT(u.signup_date, '%Y-%m') AS signup_cohort,
        TIMESTAMPDIFF(MONTH, DATE_FORMAT(u.signup_date, '%Y-%m-01'), DATE_FORMAT(l.login_date, '%Y-%m-01')) AS months_since_signup
    FROM 
        app_users u
    JOIN 
        app_logins l ON u.user_id = l.user_id
),
retention_counts AS (
    SELECT
        signup_cohort,
        COUNT(DISTINCT CASE WHEN months_since_signup = 1 THEN user_id END) AS month_1_retained,
        COUNT(DISTINCT CASE WHEN months_since_signup = 2 THEN user_id END) AS month_2_retained
    FROM
        user_activity
    GROUP BY
        signup_cohort
)
SELECT 
    c.signup_cohort,
    c.cohort_size,
    ROUND((IFNULL(r.month_1_retained, 0) / c.cohort_size) * 100, 2) AS month_1_retention_pct,
    ROUND((IFNULL(r.month_2_retained, 0) / c.cohort_size) * 100, 2) AS month_2_retention_pct
FROM 
    cohort_sizes c
LEFT JOIN 
    retention_counts r ON c.signup_cohort = r.signup_cohort
ORDER BY 
    c.signup_cohort;
```
