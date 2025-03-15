# SQL Practice Questions - E-commerce Database

## Question 1: Customer Purchase Analysis
Write a query to find the top 3 customers who have spent the most money on orders. 
Include their full name (concatenated), email, and total amount spent.
Make sure to apply discounts when applicable and exclude 'Cancelled' orders.

Expected output:
| customer_name | email | total_spent |
|---------------|-------|-------------|
| Emily Brown | emily.b@email.com | 1413.97 |
| John Smith | john.smith@email.com | 1004.96 |
| Sarah Johnson | sarah.j@email.com | 389.97 |

```sql
WITH customer_purchases AS (
  SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    email,
    ROUND(
      SUM((oi.quantity * oi.unit_price) * (1 - oi.discount/100 ))
    ,2) AS total_spent,
    DENSE_RANK() OVER (ORDER BY SUM((oi.quantity * oi.unit_price) * (1 - oi.discount/100 )) DESC) AS rk
  FROM 
    customers c 
  LEFT JOIN
    orders o ON o.customer_id = c.customer_id 
  LEFT JOIN
    order_items oi ON oi.order_id = o.order_id
  WHERE 
    o.status != 'Cancelled'
  GROUP BY 
    1, 2
  ORDER BY 
    total_spent DESC
) 
SELECT
  customer_name,
  email,
  total_spent
FROM 
  customer_purchases
WHERE 
  rk <= 3;
```

## Question 2: Monthly Sales Trend
Write a query to show the total sales amount for each month of 2023, 
along with the month-over-month percentage change. Display 0.00% for the first month.
Round the results to 2 decimal points. Exclcude discounts and 'Cancelled' orders. 

Expected output:
| year_month | total_sales | mom_change_percent |
|------------|-------------|-------------------|
| 2023-02 | 939.97 | 0.00% |
| 2023-03 | 2599.85 | 0.64% |

```sql

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS 'year_month',
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM
        orders o
    JOIN
        order_items oi ON o.order_id = oi.order_id
    WHERE
        o.status != 'Cancelled'
        AND YEAR(o.order_date) = 2023
    GROUP BY
        DATE_FORMAT(o.order_date, '%Y-%m') 
),
lagged_sales AS (
    SELECT
        'year_month',
        total_sales,
        LAG(total_sales, 1, 0) OVER (ORDER BY 'year_month') AS previous_month_sales
    FROM
        monthly_sales
)
SELECT
    'year_month',
    ROUND(total_sales, 2) AS total_sales,
    CASE
        WHEN previous_month_sales = 0 THEN '0.00%'
        ELSE CONCAT(
            CAST(
                ROUND(((total_sales - previous_month_sales) / previous_month_sales) * 100, 2)
            AS CHAR),
            '%'
        )
    END AS mom_change_percent
FROM
    lagged_sales
ORDER BY
    'year_month';
```


## Question 3: Product Performance Analysis
Write a query to find the best-selling products by quantity sold. 
Include the product name, category, total quantity sold, 
total revenue generated, and average sale price (after discounts).

Expected output:
| product_name | category | total_quantity | total_revenue | avg_sale_price |
|--------------|----------|----------------|--------------|----------------|
| Fitness Tracker | Electronics | 4 | 319.96 | 79.99 |
| Gaming Mouse | Electronics | 3 | 124.98 | 41.66 |
| Toaster | Home Appliances | 3 | 111.97 | 37.62  |

```sql
SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100)), 2) AS total_revenue,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100)) / SUM(oi.quantity), 2) AS avg_sale_price
FROM
    products p
LEFT JOIN
    order_items oi ON p.product_id = oi.product_id
LEFT JOIN
    orders o ON o.order_id = oi.order_id
GROUP BY
    p.product_name,
    p.category
ORDER BY
    total_quantity DESC
LIMIT 3;
```

## Question 4: Customer Segmentation by Purchase Frequency
Create a query that segments customers by the number of orders they've placed. 
Categories are: "One-time" (1 order), "Repeat" (2 orders), and "Loyal" (3+ orders). 
Show how many customers are in each segment.

Expected output:
| segment | customer_count |
|---------|----------------|
| One-time | 4 |
| Repeat | 2 |
| Loyal | 0 |

```sql
WITH order_counts AS (
    SELECT
        c.customer_id,
        COUNT(o.order_id) AS order_count
    FROM
        customers c
    LEFT JOIN
        orders o ON o.customer_id = c.customer_id
    WHERE
        o.status != 'Cancelled'
    GROUP BY
        c.customer_id
),
customer_segments AS (
    SELECT
        CASE
            WHEN oc.order_count = 1 THEN 'One-time'
            WHEN oc.order_count = 2 THEN 'Repeat'
            WHEN oc.order_count >= 3 THEN 'Loyal'
            ELSE 'No Orders'
        END AS segment,
        COUNT(oc.customer_id) AS customer_count
    FROM
        order_counts oc
    GROUP BY
        segment
), all_segments AS (
  SELECT 
    'One-time' AS segment 
    UNION ALL 
    SELECT 'Repeat'
    UNION ALL 
    SELECT 'Loyal'

)
SELECT
    aseg.segment,
    COALESCE(cseg.customer_count, 0) AS customer_count
FROM
  all_segments aseg
LEFT JOIN 
  customer_segments cseg ON aseg.segment = cseg.segment;
```

## Question 5: Product Inventory Analysis with Rolling Stock
Write a query to analyze the inventory of products with a "low stock" flag 
for any product with less than 40 items in stock. 
Include a rolling sum of stock within each category.

Expected output:
| product_id | product_name | category | stock_quantity | low_stock | rolling_stock_in_category |
|------------|--------------|----------|----------------|-----------|---------------------------|
| 102 | Laptop Pro | Electronics | 30 | YES | 30 |
| 103 | Coffee Maker | Home Appliances | 25 | YES | 25 |
| 110 | Toaster | Home Appliances | 35 | YES | 65 |
| 106 | Blender | Home Appliances | 40 | NO | 100 |

```sql
SELECT
    product_id,
    product_name,
    category,
    stock_quantity,
    CASE WHEN stock_quantity < 40 THEN 'YES' ELSE 'NO' END AS low_stock,
    SUM(stock_quantity) OVER (PARTITION BY category ORDER BY stock_quantity) AS rolling_stock_in_category
FROM
    products 
WHERE
    stock_quantity <= 40 
ORDER BY
    category, 
    stock_quantity;
```

## Question 6: Order Fulfillment Time Analysis
Write a query to calculate the average time in days between order date and delivery date for each status. Include only statuses that have at least one delivered order.

Expected output:
| status | avg_fulfillment_days | order_count |
|--------|----------------------|-------------|
| Delivered | 4.00 | 3 |

```sql
-- Write your solution here
```

## Question 7: Customer Retention Analysis
Create a query to find customers who made their first purchase in January or February 2023 and then made another purchase in March 2023. Show their name, first purchase date, and most recent purchase date.

Expected output:
| customer_name | first_purchase_date | latest_purchase_date |
|---------------|---------------------|----------------------|
| John Smith | 2023-02-01 | 2023-03-10 |
| Sarah Johnson | 2023-02-25 | 2023-03-20 |

```sql
-- Write your solution here
```

## Question 8: Product Pair Analysis
Write a query to find pairs of products that are frequently purchased together (in the same order). Display the pair of product names and the number of times they were purchased together.

Expected output:
| product_1 | product_2 | times_bought_together |
|-----------|-----------|----------------------|
| Fitness Tracker | Gaming Mouse | 3 |
| Fitness Tracker | Toaster | 2 |
| Gaming Mouse | Toaster | 2 |

```sql
-- Write your solution here
```

## Question 9: Customer Purchase Gaps
For each customer with multiple orders, calculate the average number of days between consecutive orders. Include customers who have placed at least 2 orders.

Expected output:
| customer_id | customer_name | num_orders | avg_days_between_orders |
|-------------|---------------|------------|-------------------------|
| 1 | John Smith | 2 | 37 |
| 2 | Sarah Johnson | 2 | 23 |

```sql
-- Write your solution here
```

## Question 10: Cumulative Discount Analysis
Create a query that calculates the cumulative discount amount provided to customers over time, ordered by date. Show the date, discount amount for that date, and running total discount.

| order_date | daily_discount_amount | cumulative_discount |
|------------|----------------------|---------------------|
| 2023-02-01 | 10.00 | 10.00 |
| 2023-02-10 | 0.00 | 10.00 |
| 2023-02-25 | 0.00 | 10.00 |
| 2023-03-05 | 15.00 | 25.00 |
| 2023-03-10 | 25.00 | 50.00 |
| 2023-03-12 | 0.00 | 50.00 |
| 2023-03-15 | 0.00 | 50.00 |
| 2023-03-18 | 25.00 | 75.00 |
| 2023-03-20 | 15.00 | 90.00 |

```sql
-- Write your solution here
```

## Question 11: Product Category Performance by Quarter
Analyze the sales performance of each product category by quarter. Include the quarter (Q1, Q2, etc.), category, total sales, and the category's percentage contribution to total sales for that quarter.

Expected output:
| quarter | category | total_sales | percentage_of_quarterly_sales |
|---------|----------|-------------|-------------------------------|
| Q1 2023 | Electronics | 3349.95 | 62.1% |
| Q1 2023 | Home Appliances | 154.98 | 2.9% |
| Q1 2023 | Apparel | 314.98 | 5.8% |

```sql
-- Write your solution here
```

## Question 12: Customer Lifetime Value with Percentile Ranking
Calculate the Customer Lifetime Value (total amount spent) and assign a percentile rank to each customer. Display the customer name, total spent, and percentile.

Expected output:
| customer_name | total_spent | percentile_rank |
|---------------|-------------|----------------|
| Emily Brown | 1429.98 | 100.0 |
| John Smith | 1079.96 | 85.7 |
| Michael Williams | 1299.99 | 71.4 |
| Sarah Johnson | 419.97 | 57.1 |
| David Jones | 149.99 | 42.9 |
| Lisa Garcia | 169.98 | 28.6 |
| Jennifer Davis | 279.98 | 14.3 |
| Robert Miller | 0.00 | 0.0 |

```sql
-- Write your solution here
```

## Question 13: Product Profitability Analysis with Price Tiers
Create a query that categorizes products into price tiers: "Budget" (<$100), "Mid-range" ($100-$500), and "Premium" (>$500). Then calculate the average discount percentage given for products in each tier.

Expected output:
| price_tier | num_products | avg_discount_percentage |
|------------|--------------|-------------------------|
| Budget | 5 | 5.00% |
| Mid-range | 3 | 11.67% |
| Premium | 2 | 2.50% |

```sql
-- Write your solution here
```

## Question 14: Order Completion Rate Analysis
Write a query to analyze the order completion rate by customer. Show each customer's name, total orders, delivered orders, and their completion rate (delivered/total).

Expected output:
| customer_name | total_orders | delivered_orders | completion_rate |
|---------------|--------------|------------------|-----------------|
| John Smith | 2 | 1 | 50.0% |
| Sarah Johnson | 2 | 1 | 50.0% |
| Michael Williams | 1 | 0 | 0.0% |
| Emily Brown | 1 | 0 | 0.0% |
| David Jones | 1 | 1 | 100.0% |
| Lisa Garcia | 1 | 0 | 0.0% |
| Jennifer Davis | 1 | 0 | 0.0% |

```sql
-- Write your solution here
```

## Question 15: Detecting Potential Fraud Orders
Create a query to flag potentially fraudulent orders based on the following criteria:
1. Orders where the shipping address is different from the customer's previous orders
2. Orders with a total amount 50% higher than the customer's average order amount
3. Orders placed within 24 hours of a previous order

| order_id | customer_name | order_date | total_amount | flag_reason |
|----------|---------------|------------|--------------|-------------|
| 1003 | Emily Brown | 2023-03-05 | 1429.98 | amount_50_percent_above_avg |

```sql
-- Write your solution here
```