## Question 1: Monthly Recurring Revenue (MRR) Movement

Calculate the monthly movement of Monthly Recurring Revenue (MRR). For each month, you need to calculate:

1. `mrr_beginning_of_month`: The MRR from active subscriptions at the start of the month.
2. `new_mrr`: MRR gained from new subscriptions started that month.
3. `expansion_mrr`: MRR gained from upgrades.
4. `contraction_mrr`: MRR lost from downgrades.
5. `churned_mrr`: MRR lost from subscriptions that were cancelled that month.
6. `mrr_end_of_month`: The MRR at the end of the month, calculated from the above components.

The report should cover the months from February to May 2023.

Expected Output:

| month | mrr_beginning_of_month | new_mrr | expansion_mrr | contraction_mrr | churned_mrr | mrr_end_of_month |
| --------------- | -------------------------------- | ----------------- | ----------------------- | ------------------------- | --------------------- | -------------------------- |
| 2023-02         | 29.98                            | 29.98             | 0.00                    | 0.00                      | 0.00                  | 59.96                      |
| 2023-03         | 59.96                            | 9.99              | 10.00                   | 0.00                      | 9.99                  | 69.96                      |
| 2023-04         | 69.96                            | 0.00              | 0.00                    | 10.00                     | 9.99                  | 49.97                      |
| 2023-05         | 49.97                            | 19.99             | 10.00                   | 0.00                      | 19.99                 | 59.97                      |

Your Solution:

```sql
-- Write your solution here
```

## Question 2: User Subscription Status History

For each user, determine their active subscription plan and its price at the end of each month from January to May 2023. If a user was not subscribed at the end of a given month, they should not appear in the results for that month.

The report should show the `user_id`, the `month` (formatted as 'YYYY-MM'), the `active_plan_id`, and `active_monthly_price` as of the last day of that month.

Order the results by `user_id` and then by `month`.

Expected Output:

| user_id | month | active_plan_id | active_monthly_price |
| ----------------- | --------------- | ------------------------ | ------------------------------ |
| 101               | 2023-01         | basic                    | 9.99                           |
| 101               | 2023-02         | basic                    | 9.99                           |
| 101               | 2023-03         | pro                      | 19.99                          |
| 101               | 2023-04         | pro                      | 19.99                          |
| 102               | 2023-01         | pro                      | 19.99                          |
| 102               | 2023-02         | pro                      | 19.99                          |
| 102               | 2023-03         | pro                      | 19.99                          |
| 102               | 2023-04         | pro                      | 19.99                          |
| 102               | 2023-05         | pro                      | 19.99                          |
| 103               | 2023-02         | pro                      | 19.99                          |
| 103               | 2023-03         | pro                      | 19.99                          |
| 103               | 2023-04         | basic                    | 9.99                           |
| 103               | 2023-05         | basic                    | 9.99                           |
| 104               | 2023-02         | basic                    | 9.99                           |
| 104               | 2023-03         | basic                    | 9.99                           |
| 105               | 2023-03         | basic                    | 9.99                           |
| 105               | 2023-04         | basic                    | 9.99                           |
| 105               | 2023-05         | pro                      | 19.99                          |
| 107               | 2023-05         | pro                      | 19.99                          |

Your Solution:

```sql
-- Write your solution here
```

## Question 3: Cohort-Based Retention Rate

Analyze user retention based on their subscription start month. Create a cohort for each month a user first subscribed. Then, for each cohort, calculate the percentage of users who were still active in the subsequent months.

The output should include the `cohort_month` (the month of first subscription), the number of `new_users` in that cohort, and the retention percentages for `Month 1`, `Month 2`, `Month 3`, etc., following the cohort month. A user is considered retained in a month if they have not cancelled  *before the end of that month* .

Expected Output:

| cohort_month | new_users | month_1_retention | month_2_retention | month_3_retention | month_4_retention |
| ---------------------- | ------------------- | --------------------------- | --------------------------- | --------------------------- | --------------------------- |
| 2023-01                | 2                   | 100.00                      | 100.00                      | 100.00                      | 50.00                       |
| 2023-02                | 2                   | 100.00                      | 50.00                       | 50.00                       | NULL                        |
| 2023-03                | 2                   | 50.00                       | 50.00                       | NULL                        | NULL                        |
| 2023-05                | 1                   | NULL                        | NULL                        | NULL                        | NULL                        |

Your Solution:

```sql
-- Write your solution here
```
