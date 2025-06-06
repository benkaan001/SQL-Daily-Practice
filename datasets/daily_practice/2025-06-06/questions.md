## Question 1: Customer Purchase Streak and LTV
*Task:* Identify customers who have made a purchase in at least 3 consecutive months. For these customers, calculate their Lifetime Value (LTV - total amount spent from the `Orders` table). Show `customer_name`, the `streak_start_month` (first day of the month), `streak_end_month` (first day of the month), `consecutive_months`, and `ltv`. Order by `customer_name`, then `streak_start_month`.

*Expected Output:*
| customer_name     | streak_start_month | streak_end_month | consecutive_months | ltv      |
| ----------------- | ------------------ | ---------------- | ------------------ | -------- |
| Alice Wonderland  | 2023-01-01         | 2023-03-01       | 3                  | 550.75   |
| Bob The Builder   | 2023-02-01         | 2023-05-01       | 4                  | 720.00   |
| Charlie Chaplin   | 2023-01-01         | 2023-04-01       | 4                  | 680.50   |
| David Copperfield | 2023-01-01         | 2023-03-01       | 3                  | 180.00   |
| Grace Kelly       | 2023-01-01         | 2023-04-01       | 4                  | 460.00   |
| Henry Ford        | 2023-01-01         | 2023-05-01       | 5                  | 24996.19 |
| Ivy Green         | 2023-01-01         | 2023-05-01       | 5                  | 25889.50 |
```sql
-- Write your SQL query here
```

## Question 2: Product Performance and Review Sentiment Analysis
*Task:* For each product `category`, find the product with the highest average `rating`. Also, calculate the percentage of reviews for that top product that contain positive keywords (e.g., 'great', 'excellent', 'love', 'good', 'amazing') versus negative keywords (e.g., 'bad', 'poor', 'disappointed', 'hate', 'awful'). Consider keywords case-insensitively. Show `category`, `top_product_name`, `avg_rating` (rounded to 2 decimal places), `positive_review_percentage` (rounded to 2 decimal places), and `negative_review_percentage` (rounded to 2 decimal places). Order by `category`.

*Expected Output:*
| category    | product_name          | avg_rating | positive_review_percentage | negative_review_percentage |
| ----------- | --------------------- | ---------- | -------------------------- | -------------------------- |
| Books       | Another Great Book    | 4.00       | 100.00                     | 0.00                       |
| Clothing    | Men's Performance Tee | 3.43       | 57.14                      | 28.57                      |
| Electronics | Smartwatch Series X   | 4.20       | 40.00                      | 20.00                      |
| Home Goods  | Scented Candle Large  | 5.00       | 100.00                     | 0.00                       |
```sql
-- Write your SQL query here
```


## Question 3: Monthly Sales Growth and Top Contributing Product Category
*Task:* Calculate the month-over-month (MoM) sales growth percentage based on `total_amount` from `Orders`. For each month, also identify the product `category` that contributed the most to that month's sales (based on `Order_Items` and `Products` tables). Show `sales_month` (formatted as 'YYYY-MM'), `total_monthly_sales` (rounded to 2 decimal places), `mom_growth_percentage` (rounded to 2 decimal places, show NULL for the first month), `top_contributing_category`, and `category_sales_for_month` (rounded to 2 decimal places). Order by `sales_month`.

*Expected Output:*
| sales_month | total_monthly_sales | mom_growth_percentage | top_contributing_category | category_sales_for_month |
| ----------- | ------------------- | --------------------- | ------------------------- | ------------------------ |
| 2023-01     | 10445.71            |                       | Electronics               | 4800.21                  |
| 2023-02     | 12107.48            | 15.91                 | Electronics               | 5289.97                  |
| 2023-03     | 10885.75            | -10.09                | Clothing                  | 4885.00                  |
| 2023-04     | 11925.00            | 9.55                  | Books                     | 5497.50                  |
| 2023-05     | 11188.50            | -6.18                 | Home Goods                | 5088.50                  |
| 2023-07     | 109.99              | -99.02                | Electronics               | 79.99                    |
| 2023-08     | 285.01              | 159.12                | Books                     | 109.00                   |
| 2023-09     | 50.00               | -82.46                | Clothing                  | 36.00                    |
```sql
-- Write your SQL query here
```
