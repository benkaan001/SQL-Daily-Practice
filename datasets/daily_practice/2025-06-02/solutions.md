# Advanced SQL Practice Questions - E-commerce Database

## Question 1: Quarterly Category Growth
*Task:* For each product category and quarter, calculate the total sales, the number of unique customers, and the quarter-over-quarter growth rate in sales (show 0.00% for the first quarter). Show quarter, category, total_sales, unique_customers, and growth_rate.

*Expected Output:*
| quarter | category        | total_sales | unique_customers | growth_rate |
| ------- | --------------- | ----------- | ---------------- | ----------- |
| Q1 2023 | Apparel         | 429.97      | 2                | 0.00%       |
| Q1 2023 | Electronics     | 2734.90     | 5                | 0.00%       |
| Q1 2023 | Home Appliances | 201.96      | 4                | 0.00%       |

```sql
WITH quarterly_sales AS (
    SELECT
        YEAR(o.order_date) AS sales_year,
        QUARTER(o.order_date) AS sales_quarter_num,
        CONCAT('Q', QUARTER(o.order_date), ' ', YEAR(o.order_date)) AS quarter,
        p.category,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100)) AS total_sales,
        COUNT(DISTINCT o.customer_id) AS unique_customers
    FROM
        orders o
    JOIN
        order_items oi ON o.order_id = oi.order_id
    JOIN
        products p ON oi.product_id = p.product_id
    WHERE
        o.status != 'Cancelled'
    GROUP BY
        sales_year,
        sales_quarter_num,
        quarter,
        p.category
), quarterly_sales_growth AS (
  SELECT
    quarter,
    category,
    total_sales,
    unique_customers,
    LAG(total_sales, 1) OVER (PARTITION BY category ORDER BY sales_year, sales_quarter_num) AS previous_quarter_sales_sum
  FROM
    quarterly_sales
)
SELECT
   quarter,
   category,
   ROUND(total_sales, 2) AS total_sales,
   unique_customers,
   CASE
    WHEN previous_quarter_sales_sum IS NULL THEN '0.00%'
    WHEN previous_quarter_sales_sum = 0 THEN 'N/A'
    ELSE CONCAT(ROUND(((total_sales - previous_quarter_sales_sum) * 100) / previous_quarter_sales_sum, 2 ), '%')
   END AS growth_rate

FROM
  quarterly_sales_growth
```

## Question 2: Customer Value Segmentation
*Task:* Segment customers into "Low", "Medium", and "High" value based on their total spend (Low < $200, Medium $200-$1000, High > $1000). Show customer name, total spent, and value segment.

*Expected Output:*
| customer_name    | total_spent | value_segment |
|------------------|-------------|---------------|
| Michael Williams | 0.00        | Low           |
| Robert Miller    | 0.00        | Low           |
| David Jones      | 149.99      | Low           |
| Lisa Garcia      | 169.97      | Low           |
| Jennifer Davis   | 237.97      | Medium        |
| Sarah Johnson    | 389.97      | Medium        |
| John Smith       | 1004.96     | High          |
| Emily Brown      | 1413.97     | High          |

```sql
SELECT
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  ROUND(SUM(oi.quantity * oi.unit_price * (100 - discount) / 100), 2) AS total_spent,
  CASE
    WHEN SUM(oi.quantity * oi.unit_price * (100 - discount) / 100) < 200 THEN 'Low'
    WHEN SUM(oi.quantity * oi.unit_price * (100 - discount) / 100) BETWEEN 200 AND 1000 THEN 'Medium'
    ELSE 'High'
  END AS value_segment
FROM
  customers c
JOIN
  orders o ON o.customer_id = c.customer_id
JOIN
  order_items oi ON oi.order_id = o.order_id
WHERE
  o.status != "Cancelled"
GROUP BY
  customer_name;
```

## Question 3: Product Discount Tier Analysis
*Task:* For each price tier (Budget < $100, Mid-range $100-$500, Premium > $500), calculate the number of products, average discount percentage, and the best-selling product in each tier by quantity sold.

*Expected Output:*
| price_tier | num_products | avg_discount_percentage | product_name    |
| ---------- | ------------ | ----------------------- | --------------- |
| Budget     | 4            | 6.36%                   | Fitness Tracker |
| Mid-range  | 3            | 7.00%                   | Running Shoes   |
| Premium    | 2            | 5.00%                   | Smartphone X    |


```sql
WITH tier_metrics AS (
  SELECT
    CASE
      WHEN p.price < 100 THEN 'Budget'
      WHEN p.price BETWEEN 100 AND 500 THEN 'Mid-range'
      ELSE 'Premium'
    END AS price_tier,
    COUNT(DISTINCT p.product_id) AS num_products,
    CONCAT(
      ROUND(AVG(oi.discount), 2)
    , '%') AS avg_discount_percentage
  FROM
    products p
  JOIN
    order_items oi ON oi.product_id = p.product_id
  JOIN
    orders o ON oi.order_id = o.order_id
  WHERE
    o.status != "Cancelled"
  GROUP BY
    price_tier
)
,product_tier_sales AS (
  SELECT
    p.product_name,
    CASE
      WHEN p.price < 100 THEN 'Budget'
      WHEN p.price BETWEEN 100 AND 500 THEN 'Mid-range'
      ELSE 'Premium'
    END AS price_tier,
    SUM(oi.quantity) AS total_units_sold
  FROM
    products p
  JOIN
    order_items oi ON oi.product_id = p.product_id
  JOIN
    orders o ON oi.order_id = o.order_id
  WHERE
    o.status != "Cancelled"
  GROUP BY
    p.product_name,
    price_tier
)
,ranked_tiers AS (
  SELECT
    product_name,
    price_tier,
    ROW_NUMBER() OVER(PARTITION BY price_tier ORDER BY total_units_sold DESC) AS tier_rank
  FROM
    product_tier_sales
)
SELECT
  tm.price_tier,
  tm.num_products,
  tm.avg_discount_percentage,
  rt.product_name
FROM
  ranked_tiers rt
JOIN
  tier_metrics tm ON rt.price_tier = tm.price_tier
WHERE
  rt.tier_rank = 1;
```

## Question 4: Customer Order Completion Rate
*Task:* For each customer, show their name, total orders, delivered orders, and completion rate (delivered/total, as a percent rounded to 2 decimals).

*Expected Output:*
| customer_name    | total_orders | delivered_orders | completion_rate |
| ---------------- | ------------ | ---------------- | --------------- |
| John Smith       | 2            | 1                | 50.00%          |
| Sarah Johnson    | 2            | 1                | 50.00%          |
| Michael Williams | 1            | 0                | 0.00%           |
| Emily Brown      | 1            | 0                | 0.00%           |
| David Jones      | 1            | 1                | 100.00%         |
| Lisa Garcia      | 1            | 0                | 0.00%           |
| Robert Miller    | 0            | 0                | 0.00%           |
| Jennifer Davis   | 1            | 0                | 0.00%           |
```sql
-- Write your SQL query here
```

## Question 5: Fraud Detection - Rapid Repeat Orders
*Task:* Find all orders placed by the same customer within 30 days of a previous order. Show order_id, customer name, order_date, and previous order date.

*Expected Output:*
| order_id | customer_name   | order_date  | prev_order_date |
|----------|-----------------|-------------|-----------------|
| 1009     | Sarah Johnson   | 2023-03-20  | 2023-02-25      |

```sql
WITH grouped_customers AS (
  SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    order_date
  FROM
    orders o
  JOIN
    customers c ON c.customer_id = o.customer_id
  WHERE
    o.status != "Cancelled"
  GROUP BY
    o.order_id,
    customer_name,
    order_date
), previous_orders AS (
  SELECT
    order_id,
    customer_name,
    order_date,
    LAG(order_date, 1, 0) OVER (PARTITION BY customer_name ORDER BY order_date) AS prev_order_date
  FROM
    grouped_customers
)
SELECT
  order_id,
  customer_name,
  order_date,
  prev_order_date
FROM
  previous_orders
WHERE
  DATEDIFF(order_date, prev_order_date) <= 30;
```
