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
-- Write your solution here
```
