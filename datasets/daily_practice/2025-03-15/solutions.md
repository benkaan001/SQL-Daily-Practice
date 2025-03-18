# SQL Practice Questions - E-commerce Database

## Question 11: Product Category Performance by Quarter
Analyze the sales performance of each product category by quarter. 
Include the quarter (Q1, Q2, etc.), category, total sales, 
and the category's percentage contribution to total sales for that quarter.

Expected output:
| quarter | category | total_sales | percentage_of_quarterly_sales |
|---------|----------|-------------|-------------------------------|
| Q1 2023 | Electronics | 2734.9 | 81.23% |
| Q1 2023 | Home Appliances | 201.96 | 6.00% |
| Q1 2023 | Apparel | 429.97 | 12.77% |

```sql
WITH q1_total_sales AS (
    SELECT
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)) AS total_sale
    FROM
        order_items oi
    JOIN
        orders o ON o.order_id = oi.order_id
    WHERE
        o.status != 'Cancelled'
        AND o.order_date BETWEEN '2023-01-01' AND '2023-03-31'
),
q1_orders AS ( 
    SELECT
        o.order_id
    FROM
        orders o
    WHERE
        o.status != 'Cancelled'
        AND o.order_date BETWEEN '2023-01-01' AND '2023-03-31'
)
SELECT
    'Q1 2023' AS quarter,
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)), 2) as total_sales,
    CONCAT(
        CAST(
            ROUND(
                SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)) / (SELECT total_sale FROM q1_total_sales) * 100
            , 2)
        AS CHAR),
    '%') AS percentage_of_quarterly_sales
FROM
    products p
LEFT JOIN
    order_items oi ON oi.product_id = p.product_id
LEFT JOIN
    q1_orders qo ON oi.order_id = qo.order_id 
WHERE qo.order_id IS NOT NULL -- remember to only consider orders from q1 and non-cancelled
GROUP BY
    quarter,
    p.category;
```

## Question 12: Customer Lifetime Value with Percentile Ranking
Calculate the Customer Lifetime Value (total amount spent) 
and assign a percentile rank to each customer. 
Display the customer name, total spent, and percentile.

Expected output:
| customer_name    | total_spent | percentile_rank |
| ---------------- | ----------- | --------------- |
| Michael Williams | 0.00        | 0%              |
| Robert Miller    | 0.00        | 0%              |
| David Jones      | 149.99      | 28.9%           |
| Lisa Garcia      | 169.97      | 43%             |
| Jennifer Davis   | 237.97      | 56.9%           |
| Sarah Johnson    | 389.97      | 71%             |
| John Smith       | 1004.96     | 86%             |
| Emily Brown      | 1413.97     | 100%            |

```sql
WITH customer_spending AS (
    SELECT
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        ROUND(COALESCE(SUM(
            CASE
                WHEN o.status = 'Cancelled' THEN 0.00
                ELSE oi.quantity * oi.unit_price * (1 - oi.discount / 100)
            END
        ), 0.00), 2) AS total_spent
    FROM
        customers c
    LEFT JOIN
        orders o ON o.customer_id = c.customer_id
    LEFT JOIN
        order_items oi ON oi.order_id = o.order_id
    GROUP BY
        CONCAT(c.first_name, ' ', c.last_name)
)
SELECT
    customer_name,
    total_spent,
    CONCAT(
      SUBSTRING(
      	CAST(
          ROUND(PERCENT_RANK() OVER (ORDER BY total_spent), 2) * 100 
      	AS CHAR)
      , 1, 4)
    , '%') as percentile_rank
FROM
    customer_spending;
```

## Question 13: Product Profitability Analysis with Price Tiers
Create a query that categorizes products into price tiers: "Budget" (<$100), "Mid-range" ($100-$500), and "Premium" (>$500). Then calculate the average discount percentage given for products in each tier.

Expected output:
| price_tier | num_products | avg_discount_percentage |
| ---------- | ------------ | ----------------------- |
| Budget     | 5            | 5.83%                   |
| Mid-range  | 3            | 7.00%                   |
| Premium    | 2            | 3.33%                   |
```sql
SELECT
    CASE
        WHEN p.price < 100 THEN 'Budget'
        WHEN p.price BETWEEN 100 AND 500 THEN 'Mid-range'
        ELSE 'Premium'
    END AS price_tier,
    COUNT(DISTINCT p.product_id) AS num_products,
    CONCAT(
        ROUND(AVG(CASE WHEN oi.discount IS NOT NULL THEN oi.discount ELSE 0 END), 2),
        '%'
    ) AS avg_discount_percentage
FROM
    products p
LEFT JOIN
    order_items oi ON oi.product_id = p.product_id
GROUP BY
    1;

```

## Question 14: Order Completion Rate Analysis
Write a query to analyze the order completion rate by customer. 
Show each customer's name, total orders, delivered orders, 
nd their completion rate (delivered/total).

Expected output:
| customer_name    | total_orders | delivered_orders | completion_rate |
| ---------------- | ------------ | ---------------- | --------------- |
| John Smith       | 2            | 2                | 100.00%         |
| Sarah Johnson    | 2            | 1                | 50.00%          |
| David Jones      | 1            | 1                | 100.00%         |
| Emily Brown      | 1            | 0                | 0.00%           |
| Jennifer Davis   | 1            | 0                | 0.00%           |
| Lisa Garcia      | 1            | 0                | 0.00%           |
| Michael Williams | 1            | 0                | 0.00%           |
| Robert Miller    | 0            | 0                | 0.00%           |

```sql
WITH order_deliveries AS (
  SELECT 
	CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(CASE WHEN o.status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders
  FROM 
      customers c 
  LEFT JOIN 
      orders o ON o.customer_id = c.customer_id
  LEFT JOIN 
      order_items oi ON oi.order_id = o.order_id
  GROUP BY
      1
)
SELECT 
	customer_name,
    total_orders,
    delivered_orders,
    CONCAT(
      CAST(
      	ROUND(
          COALESCE(delivered_orders / total_orders, 0) * 100
        , 2)
      AS CHAR) 
    , '%') AS completion_rate
FROM 
	order_deliveries
ORDER BY 
	total_orders DESC;
```

## Question 15: Detecting Potential Fraud Orders
Create a query to flag potentially fraudulent orders based on the following criteria:
1. Orders where the shipping address is different from the customer's previous orders
2. Orders with a total amount 50% higher than the customer's average order amount
3. Orders placed within 24 hours of a previous order

| order_id | customer_name | order_date | total_amount | flag_reason                 |
| -------- | ------------- | ---------- | ------------ | --------------------------- |
| 1001     | John Smith    | 2023-02-01 | 849.98       | amount_50_percent_above_avg |
| 1009     | Sarah Johnson | 2023-03-20 | 329.98       | amount_50_percent_above_avg |

```sql
WITH customer_address_count AS (
    SELECT
        customer_id,
        COUNT(DISTINCT shipping_address) AS address_count
    FROM
        orders
    GROUP BY
        customer_id
), customers_with_multiple_shipping_addresses AS(
    SELECT
        customer_id
    FROM
        customer_address_count
    WHERE
        address_count > 1
), avg_customer_orders AS (
    SELECT
        customer_id,
        AVG(total_amount) AS customer_average
    FROM
        orders
    GROUP BY
        customer_id
), orders_above_average AS (
    SELECT
        o.order_id,
        o.customer_id
    FROM
        avg_customer_orders aco
    JOIN
        orders o ON o.customer_id = aco.customer_id
    WHERE
        o.total_amount > aco.customer_average * 1.5
), previous_day_orders AS (
    SELECT
        customer_id,
        order_id,
        order_date,
        LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_order_date
    FROM
        orders
), customers_with_previous_day_orders AS (
    SELECT
        customer_id
    FROM
        previous_day_orders
    WHERE
        prev_order_date IS NOT NULL
        AND TIMESTAMPDIFF(HOUR, prev_order_date, order_date) < 24
)
SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date,
    o.total_amount,
    'different_shipping_address' AS flag_reason
FROM
    orders o
JOIN
    customers c ON o.customer_id = c.customer_id
WHERE
    o.customer_id IN (SELECT customer_id FROM customers_with_multiple_shipping_addresses)

UNION ALL

SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date,
    o.total_amount,
    'amount_50_percent_above_avg' AS flag_reason
FROM
    orders o
JOIN
    customers c ON o.customer_id = c.customer_id
WHERE
    o.order_id IN (SELECT order_id FROM orders_above_average)

UNION ALL

SELECT
    pdo.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    pdo.order_date,
    o.total_amount,
    'too_many_orders_within_24hours' AS flag_reason
FROM
    previous_day_orders pdo
JOIN
    customers c ON pdo.customer_id = pdo.customer_id
JOIN
    orders o ON pdo.order_id = o.order_id
WHERE
    pdo.customer_id IN (SELECT customer_id FROM customers_with_previous_day_orders);
```