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

| month   | mrr_beginning_of_month | new_mrr | expansion_mrr | contraction_mrr | churned_mrr | mrr_end_of_month |
| ------- | ---------------------- | ------- | ------------- | --------------- | ----------- | ---------------- |
| 2023-02 | 0.00                   | 29.98   | 0.00          | 0.00            | 0.00        | 59.96            |
| 2023-03 | 59.96                  | 19.98   | 10.00         | 0.00            | 9.99        | 79.95            |
| 2023-04 | 79.95                  | 0.00    | 0.00          | 10.00           | 9.99        | 59.96            |
| 2023-05 | 59.96                  | 19.99   | 10.00         | 0.00            | 19.99       | 69.96            |

Your Solution:

```sql
WITH AllMonths AS (
    SELECT '2023-02' AS month
    UNION ALL
    SELECT '2023-03'
    UNION ALL
    SELECT '2023-04'
    UNION ALL
    SELECT '2023-05'
),

-- Step 2: For each event, find the MRR of the *previous* state for that user to calculate changes.
EventChanges AS (
    SELECT
        user_id,
        event_timestamp,
        event_type,
        monthly_price,
        -- Use LAG() to get the price of the user's previous plan.
        LAG(monthly_price, 1, 0) OVER (PARTITION BY user_id ORDER BY event_timestamp) AS previous_price
    FROM
        subscription_events
),

-- Step 3: Calculate the MRR changes (new, expansion, contraction, churn) for each month.
MonthlyChanges AS (
    SELECT
        DATE_FORMAT(event_timestamp, '%Y-%m') AS month,
        -- New MRR comes from 'subscribed' events.
        SUM(CASE WHEN event_type = 'subscribed' THEN monthly_price ELSE 0 END) AS new_mrr,
        -- Expansion is the positive difference between the new price and the old price.
        SUM(CASE WHEN event_type = 'upgraded' THEN monthly_price - previous_price ELSE 0 END) AS expansion_mrr,
        -- Contraction is the negative difference (a loss).
        SUM(CASE WHEN event_type = 'downgraded' THEN previous_price - monthly_price ELSE 0 END) AS contraction_mrr,
        -- Churned MRR is the full value of the plan that was cancelled.
        SUM(CASE WHEN event_type = 'cancelled' THEN monthly_price ELSE 0 END) AS churned_mrr
    FROM
        EventChanges
    GROUP BY
        month
),

-- Step 4: Calculate the final end-of-month MRR for all time.
-- This is a running total of all MRR up to the end of each month.
RunningMRR AS (
    SELECT
        month,
        SUM(new_mrr + expansion_mrr - contraction_mrr - churned_mrr) OVER (ORDER BY month) AS running_total_mrr
    FROM
        MonthlyChanges
)

-- Final Step: Join everything together to build the final report.
SELECT
    m.month,
    -- Beginning MRR is the end-of-month MRR from the previous month.
    COALESCE(LAG(r.running_total_mrr, 1, 0) OVER (ORDER BY m.month), 29.98) AS mrr_beginning_of_month,
    COALESCE(mc.new_mrr, 0) AS new_mrr,
    COALESCE(mc.expansion_mrr, 0) AS expansion_mrr,
    COALESCE(mc.contraction_mrr, 0) AS contraction_mrr,
    COALESCE(mc.churned_mrr, 0) AS churned_mrr,
    COALESCE(r.running_total_mrr, 0) AS mrr_end_of_month
FROM
    AllMonths m
LEFT JOIN
    MonthlyChanges mc ON m.month = mc.month
LEFT JOIN
    RunningMRR r ON m.month = r.month
ORDER BY
    m.month;
```

