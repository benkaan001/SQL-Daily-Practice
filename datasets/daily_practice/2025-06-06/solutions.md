# Advanced SQL Practice Questions - E-commerce Order Analysis

**Dataset Schema:**

*   `Customers`: `customer_id` (PK), `customer_name`, `email`, `join_date`
*   `Products`: `product_id` (PK), `product_name`, `category`, `price`
*   `Orders`: `order_id` (PK), `customer_id` (FK), `order_date`, `total_amount`
*   `Order_Items`: `order_item_id` (PK), `order_id` (FK), `product_id` (FK), `quantity`, `price_per_unit`
*   `Reviews`: `review_id` (PK), `product_id` (FK), `customer_id` (FK), `rating` (1-5), `review_date`, `review_text`

---

## Question 1: Customer Purchase Streak and LTV
*Task:* Identify customers who have made a purchase in at least 3 consecutive months. For these customers, calculate their Lifetime Value (LTV - total amount spent from the `Orders` table). Show `customer_name`, the `streak_start_month` (first day of the month), `streak_end_month` (first day of the month), `consecutive_months`, and `ltv`. Order by `customer_name`, then `streak_start_month`.

*Expected Output:*
| customer_name | streak_start_month | streak_end_month | consecutive_months | ltv    |
|---------------|--------------------|------------------|--------------------|--------|
| Alice Wonderland | 2023-01-01         | 2023-03-01       | 3                  | 550.75 |
| Bob The Builder  | 2023-02-01         | 2023-05-01       | 4                  | 720.00 |
| Bob The Builder  | 2023-07-01         | 2023-09-01       | 3                  | 720.00 |
| Charlie Chaplin  | 2023-01-01         | 2023-04-01       | 4                  | 680.50 |

```sql
-- Write your SQL query here
```

## Question 2: Product Performance and Review Sentiment Analysis
*Task:* For each product `category`, find the product with the highest average `rating`. Also, calculate the percentage of reviews for that top product that contain positive keywords (e.g., 'great', 'excellent', 'love', 'good', 'amazing') versus negative keywords (e.g., 'bad', 'poor', 'disappointed', 'hate', 'awful'). Consider keywords case-insensitively. Show `category`, `top_product_name`, `avg_rating` (rounded to 2 decimal places), `positive_review_percentage` (rounded to 2 decimal places), and `negative_review_percentage` (rounded to 2 decimal places). Order by `category`.

*Expected Output:*
| category    | top_product_name      | avg_rating | positive_review_percentage | negative_review_percentage |
|-------------|-----------------------|------------|----------------------------|----------------------------|
| Books       | The Midnight Library  | 4.52       | 90.00                      | 2.50                       |
| Clothing    | Men's Performance Tee | 4.18       | 75.00                      | 10.00                      |
| Electronics | Smartwatch Series X   | 4.81       | 85.00                      | 5.00                       |
| Home Goods  | Ergonomic Office Chair| 4.65       | 88.00                      | 3.00                       |

```sql
-- Write your SQL query here
```

## Question 3: Order Lag Time Analysis by Customer Tenure
*Task:* Segment customers based on their `join_date` relative to '2023-12-31':
    - "New": joined in the last 6 months (i.e., join_date >= '2023-07-01').
    - "Established": joined between 6 and 12 months ago (i.e., join_date >= '2023-01-01' and < '2023-07-01').
    - "Veteran": joined more than 12 months ago (i.e., join_date < '2023-01-01').
For each `customer_tenure_segment`, calculate the average time (in days) between a customer's consecutive orders. Show `customer_tenure_segment` and `avg_days_between_orders` (rounded to 1 decimal place). Order by `customer_tenure_segment`.

*Expected Output:*
| customer_tenure_segment | avg_days_between_orders |
|-------------------------|---------------------------|
| Established             | 25.0                      |
| New                     | 15.5                      |
| Veteran                 | 30.2                      |

```sql
-- Write your SQL query here
```

## Question 4: Monthly Sales Growth and Top Contributing Product Category
*Task:* Calculate the month-over-month (MoM) sales growth percentage based on `total_amount` from `Orders`. For each month, also identify the product `category` that contributed the most to that month's sales (based on `Order_Items` and `Products` tables). Show `sales_month` (formatted as 'YYYY-MM'), `total_monthly_sales` (rounded to 2 decimal places), `mom_growth_percentage` (rounded to 2 decimal places, show NULL for the first month), `top_contributing_category`, and `category_sales_for_month` (rounded to 2 decimal places). Order by `sales_month`.

*Expected Output:*
| sales_month | total_monthly_sales | mom_growth_percentage | top_contributing_category | category_sales_for_month |
|-------------|---------------------|-----------------------|---------------------------|--------------------------|
| 2023-01     | 10500.50            | NULL                  | Electronics               | 4500.25                  |
| 2023-02     | 12200.75            | 16.19                 | Electronics               | 5200.50                  |
| 2023-03     | 11550.00            | -5.33                 | Clothing                  | 4800.00                  |
| 2023-04     | 13050.20            | 12.99                 | Books                     | 5500.70                  |
| 2023-05     | 12800.00            | -1.92                 | Home Goods                | 5000.00                  |

```sql
-- Write your SQL query here
```
