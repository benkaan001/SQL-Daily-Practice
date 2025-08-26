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
-- Write your solution here
```