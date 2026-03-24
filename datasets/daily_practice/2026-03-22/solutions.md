## Puzzle: Time to First Purchase Conversion

**The Scenario:** The marketing team wants to analyze the "Time to First Purchase" to understand how different acquisition channels perform. They want to see what percentage of users from each channel convert quickly versus those who take longer, or those who never convert at all.

**Your Task:** For each `acquisition_channel`, calculate the percentage of total signups that fall into four specific conversion speed categories based on their *first* purchase:

1. `same_day_pct`: Purchased on the exact same day they signed up.
2. `within_7_days_pct`: Purchased between 1 and 7 days after signup.
3. `over_7_days_pct`: Purchased strictly more than 7 days after signup.
4. `never_purchased_pct`: Has no recorded purchases in the system.

The report should display the `acquisition_channel`, `total_users` acquired from that channel, and the four percentage columns (rounded to two decimal places).

Order the results alphabetically by `acquisition_channel`.

**Expected Output:**

| **acquisition_channel** | **total_users** | **same_day_pct** | **within_7_days_pct** | **over_7_days_pct** | **never_purchased_pct** |
| ----------------------------- | --------------------- | ---------------------- | --------------------------- | ------------------------- | ----------------------------- |
| Organic Search                | 2                     | 50.00                  | 0.00                        | 0.00                      | 50.00                         |
| Paid Social                   | 2                     | 50.00                  | 50.00                       | 0.00                      | 0.00                          |
| Referral                      | 2                     | 0.00                   | 0.00                        | 100.00                    | 0.00                          |

### Tips for Approaching the Problem

1. **Find the First Purchase:** A user might have many purchases. You only care about their *first* one. Create a Common Table Expression (CTE) that finds the `MIN(purchase_date)` for each `user_id` from the `user_purchases` table.
2. **Join Users to First Purchases:** Query from the `app_users` table and `LEFT JOIN` it to your first purchases CTE. A `LEFT JOIN` is essential so that users who never purchased (like User 104) are still included in the dataset.
3. **Calculate the Time Gap:** Use `DATEDIFF(first_purchase_date, signup_date)` to find the exact number of days it took for a user to convert.
4. **Bucket and Aggregate:** Group your results by `acquisition_channel`. Use conditional aggregation (e.g., `SUM(CASE WHEN ... THEN 1 ELSE 0 END)`) to count how many users fall into each of the four categories based on the `DATEDIFF` result (or if the date is `NULL` for the "never purchased" bucket).
5. **Calculate Percentages:** To get the final percentages, divide each conditional sum by the total count of users for that channel `COUNT(*)`, multiply by 100, and `ROUND()` the result.

**Your Solution:**

```sql
WITH first_purchases AS (
    SELECT
        user_id,
        MIN(purchase_date) AS purchase_date
    FROM
        user_purchases
    GROUP BY
        user_id 
),
combined_data AS (
    SELECT 
        au.user_id, 
        au.signup_date, 
        au.acquisition_channel, 
        fp.purchase_date
    FROM
        app_users au 
    LEFT JOIN 
        first_purchases fp ON au.user_id = fp.user_id 
),
purhcase_counts AS (
    SELECT 
        acquisition_channel,
        COUNT(*) AS total_users,
        SUM(CASE WHEN purchase_date = signup_date THEN 1 ELSE 0 END) AS same_day_count,
        SUM(CASE WHEN ABS(DATEDIFF(signup_date, purchase_date)) BETWEEN 1 AND 7 THEN 1 ELSE 0 END) AS within_7_days_count,
        SUM(CASE WHEN ABS(DATEDIFF(purchase_date, signup_date)) > 7 THEN 1 ELSE 0 END) AS over_7_days_count,
        SUM(CASE WHEN purchase_date IS NULL THEN 1 ELSE 0 END) AS never_purchased_count
    FROM
        combined_data
    GROUP BY
        acquisition_channel 
)
SELECT
    acquisition_channel, 
    total_users, 
    ROUND((same_day_count / NULLIF(total_users, 0) * 100.0), 2) AS same_day_pct, 
    ROUND((within_7_days_count / NULLIF(total_users, 0) * 100.0), 2) AS within_7_days_pct, 
    ROUND((over_7_days_count / NULLIF(total_users, 0) * 100.0), 2) AS over_7_days_pct, 
    ROUND((never_purchased_count / NULLIF(total_users, 0) * 100.0), 2) AS never_purchased_pct
FROM
    purhcase_counts 
ORDER BY 
    acquisition_channel;
```
