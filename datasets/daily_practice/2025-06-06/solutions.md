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
| Ivy Green         | 2023-01-01         | 2023-05-01       | 5                  | 25889.50 |                | 680.50 |

```sql
WITH customer_ltv AS (
  SELECT
    customer_id,
    SUM(total_amount) AS ltv
  FROM
    Orders
  GROUP BY
    customer_id
),
monthly_orders AS (
  SELECT
    customer_id,
    DATE_FORMAT(order_date, '%Y-%m-01') AS month_start_date
  FROM
    Orders
  GROUP BY
    customer_id,
    month_start_date
),
order_ranking AS (
  SELECT
    customer_id,
    month_start_date,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY month_start_date) AS rn,
    DATE_SUB(month_start_date, INTERVAL ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY month_start_date) MONTH) AS streaks_number
  FROM
    monthly_orders
),
consecutive_streaks AS (
  SELECT
    customer_id,
    MIN(month_start_date) AS streak_start_month,
    MAX(month_start_date) AS streak_end_month,
    COUNT(month_start_date) AS consecutive_months
  FROM
    order_ranking
  GROUP BY
    customer_id,
  	streaks_number
  HAVING
    consecutive_months >= 3
)
SELECT
  c.customer_name,
  cs.streak_start_month,
  cs.streak_end_month,
  cs.consecutive_months,
  cl.ltv
FROM
  consecutive_streaks cs
JOIN
  customer_ltv cl ON cl.customer_id = cs.customer_id
JOIN
  Customers c ON c.customer_id = cs.customer_id;
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
WITH ranked_avg_ratings AS (
    SELECT
    p.category,
    p.product_name,
    AVG(r.rating) AS avg_rating,
    DENSE_RANK() OVER (PARTITION BY p.category ORDER BY AVG(r.rating) DESC) AS review_rank,
    COUNT(DISTINCT r.review_id) AS total_review_count,
    SUM(
        CASE
        WHEN
            LOWER(r.review_text) LIKE '%great%'
            OR LOWER(r.review_text) LIKE '%excellent%'
            OR LOWER(r.review_text) LIKE '%love%'
            OR LOWER(r.review_text) LIKE '%good%'
            OR LOWER(r.review_text) LIKE '%amazing%' THEN 1
        ELSE 0
        END ) AS positive_review_count,
    SUM(
        CASE
        WHEN
            LOWER(r.review_text) LIKE '%bad%'
            OR LOWER(r.review_text) LIKE '%poor%'
            OR LOWER(r.review_text) LIKE '%disappointed%'
            OR LOWER(r.review_text) LIKE '%hate%'
            OR LOWER(r.review_text) LIKE '%awful%' THEN 1
        ELSE 0
        END ) AS negative_review_count

    FROM
    Products p
    JOIN
    Reviews r ON r.product_id = p.product_id
    GROUP BY
    p.category,
    p.product_name
)
SELECT
    category,
    product_name,
    ROUND(avg_rating, 2) AS avg_rating,
    ROUND(positive_review_count * 100 / total_review_count, 2) AS positive_review_percentage,
    ROUND(negative_review_count * 100 / total_review_count, 2) AS negative_review_percentage
FROM
    ranked_avg_ratings
WHERE
    review_rank = 1
ORDER BY
    category;
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
WITH monthly_sales AS (
    SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    SUM(total_amount) AS total_monthly_sales
    FROM
    Orders
    GROUP BY
    sales_month
),
previous_month_sales AS (
    SELECT
    sales_month,
    total_monthly_sales,
    LAG(total_monthly_sales, 1, NULL) OVER (ORDER BY sales_month) AS prev_month_total
    FROM
    monthly_sales
),
monthly_growth AS (
    SELECT
    sales_month,
    total_monthly_sales,
    ROUND(
        NULLIF((total_monthly_sales - prev_month_total)/prev_month_total * 100 , NULL)
        , 2) AS mom_growth_percentage
    FROM
    previous_month_sales

),
monthly_product_sales AS (
    SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    p.category,
    SUM(oi.quantity * oi.price_per_unit) AS category_sales_for_month,
    ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(o.order_date, '%Y-%m') ORDER BY SUM(o.total_amount) DESC ) AS rn
    FROM
    Orders o
    JOIN
    Order_Items oi ON o.order_id = oi.order_id
    JOIN
    Products p ON p.product_id = oi.product_id
    GROUP BY
    sales_month,
    p.category

)
SELECT
    mg.sales_month,
    mg.total_monthly_sales,
    mg.mom_growth_percentage,
    mps.category AS top_contributing_category,
    mps.category_sales_for_month
FROM
    monthly_growth mg
JOIN
    monthly_product_sales mps ON mg.sales_month = mps.sales_month
WHERE
    mps.rn = 1
ORDER BY
    mg.sales_month;
```
