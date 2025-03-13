# E-commerce Analytics: 20 SQL Practice Questions

## Intermediate Level Questions (1-10)

### Question 1: Customer Order Summary
*Task:* Calculate total orders and total spend per customer segment.

*Expected Output:*

| segment  | total_orders | total_spend |
|----------|--------------|-------------|
| Regular  | 4            | 1632.00     |
| Premium  | 3            | 1180.00     |
| VIP      | 1            |  200.00     |


```sql
SELECT
  c.segment, 
  COUNT(oi.order_id) AS total_orders,
  SUM((oi.quantity * oi.unit_price) * (100 - oi.discount_percent)/100) AS total_spend
FROM 
  customers c 
LEFT JOIN
  orders o ON o.customer_id = c.customer_id
LEFT JOIN
  order_items oi ON oi.order_id = o.order_id
GROUP BY 
  c.segment;
```

### Question 2: Product Performance
*Task:* Show top 3 products by revenue (price * quantity - discount).

*Expected Output:*

| product_name    | total_revenue |
|-----------------|---------------|
| Gaming Laptop   | 2040.00       |
| Wireless Earbuds| 450.00        |
| Running Shoes   | 220.00        |

```sql
-- In case there may be a tie
WITH ranked_products AS (
  SELECT 
    p.product_name,
    SUM((oi.unit_price * oi.quantity) * (100 - oi.discount_percent) / 100) as total_revenue,
    DENSE_RANK() OVER (ORDER BY SUM((oi.unit_price * oi.quantity) * (100 - oi.discount_percent) / 100) DESC) AS rk
  FROM
    products p 
  LEFT JOIN
    order_items oi ON oi.product_id = p.product_id 
  GROUP BY 
    p.product_name
)
SELECT 
  product_name,
  total_revenue
FROM 
  ranked_products 
WHERE
  rk <= 3;
```

```sql 
-- Assuming no ties exist
SELECT 
  p.product_name,
  SUM((oi.unit_price * oi.quantity) * (100 - oi.discount_percent) / 100) as total_revenue
FROM
  products p 
LEFT JOIN
  order_items oi ON oi.product_id = p.product_id 
GROUP BY 
  p.product_name
ORDER BY 
  total_revenue DESC 
LIMIT 3;
```


### Question 3: Campaign Effectiveness
*Task:* Calculate conversion rate (conversions/clicks) per campaign.

*Expected Output:*

| campaign_name | conversion_rate |
|---------------|----------------|
| Spring Sale   | 0.10          |
| New Customer  | 0.10          |
| Flash Sale    | 0.10          |

```sql
SELECT 
  mc.campaign_name,
  AVG(cp.conversions / cp.clicks) AS conversion_rate
FROM 
  marketing_campaigns mc
LEFT JOIN
  campaign_performance cp ON cp.campaign_id = mc.campaign_id
GROUP BY 
  mc.campaign_name;
```


### Question 4: Campaign ROI
*Task:* Calculate the Return on Investment (ROI) for each marketing campaign.
ROI = (Revenue - Investment) / Investment

Assume that any order placed by a customer during the campaign's active dates 
(inclusive) is attributed to that campaign. 

The total cost of the campaign is the sum of the spend recorded in the campaign_performance table. 
If there is no spend data available for a campaign in the campaign_performance table, 
use the budget from the marketing_campaigns table as the total cost.

*Expected Output:*

| campaign_name | ROI  |
|---------------|------|
| Spring Sale   |-0.2  |
| New Customer  |-0.79 |
| Flash Sale    |-0.81 |

```sql
WITH order_revenues AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) AS order_revenue
    FROM
        orders o
    JOIN
        order_items oi ON o.order_id = oi.order_id
    GROUP BY
        o.order_id, o.customer_id, o.order_date
),
campaign_attributed_revenue AS (
    SELECT
        mc.campaign_id,
        mc.campaign_name,
        SUM(orv.order_revenue) AS campaign_revenue
    FROM
        marketing_campaigns mc
    LEFT JOIN
        order_revenues orv ON orv.order_date >= mc.start_date AND orv.order_date <= mc.end_date
    GROUP BY
        mc.campaign_id, mc.campaign_name
),
campaign_costs AS (
    SELECT
        mc.campaign_id,
        COALESCE(SUM(cp.spend), mc.budget) AS total_cost
    FROM
        marketing_campaigns mc
    LEFT JOIN
        campaign_performance cp ON mc.campaign_id = cp.campaign_id
    GROUP BY
        mc.campaign_id, mc.budget
)
SELECT
    car.campaign_name,
    CASE
        WHEN cc.total_cost > 0 THEN ROUND((car.campaign_revenue - cc.total_cost) / cc.total_cost, 2)
        ELSE NULL -- Avoid division by zero
    END AS ROI
FROM
    campaign_attributed_revenue car
JOIN
    campaign_costs cc ON car.campaign_id = cc.campaign_id;
```


### Question 5: Customer Lifetime Value
*Task:* Calculate the lifetime value of each customer (total spend per customer). 
Exclude 'Cancelled' orders in the revenue calculations.

*Expected Output:*

| customer_id | lifetime_value |
|-------------|----------------|
| 1           | 1482.00        |
| 2           | 220.00         |
| 3           | 200.00         |
| 4           | 150.00         |
| 5           | 960.00         |

```sql
SELECT  
  c.customer_id,
  SUM((oi.quantity * oi.unit_price) * (100 - oi.discount_percent) / 100) as lifetime_value
FROM 
  customers c 
LEFT JOIN
  orders o ON o.customer_id = c.customer_id 
LEFT JOIN
  order_items oi ON oi.order_id = o.order_id 
WHERE 
  o.status != 'Cancelled'
GROUP BY 
  c.customer_id;
```


### Question 6: Geographic Distribution of Sales
*Task:* Calculate total sales per country for orders that are 'Delivered' or 'Shipped'.

*Expected Output:*

| country | total_sales |
|---------|-------------|
| USA     | 1530.00     |
| UK      | 1036.00     |
| Canada  | 200.00      |

```sql
SELECT 
  c.country,
  SUM((oi.quantity * oi.unit_price) * (100 - oi.discount_percent) / 100) AS total_sales
FROM 
  customers c 
LEFT JOIN
  orders o ON c.customer_id = o.customer_id 
LEFT JOIN
  order_items oi ON oi.order_id = o.order_id 
WHERE 
  o.status IN ('Delivered', 'Shipped')
GROUP BY 
  c.country;
```


### Question 7: Inventory Management
*Task:* Calculate total quantity sold per product.

*Expected Output:*

| product_name    | total_quantity |
|-----------------|----------------|
| Gaming Laptop   | 2              |
| Wireless Earbuds| 2              |
| Running Shoes   | 1              |
| Coffee Maker    | 1              |
| Protein Powder  | 0              |

```sql
SELECT 
  p.product_name,
  COALESCE(SUM(CASE WHEN o.status IN ('Delivered', 'Shipped') THEN 1 ELSE 0 END), 0) AS total_quantity
FROM 
  products p
LEFT JOIN
  order_items oi ON oi.product_id = p.product_id
LEFT JOIN
  orders o ON oi.order_id = o.order_id 
GROUP BY 
  p.product_name;
```

### Question 8: Customer Satisfaction Metrics
*Task:* Calculate the average resolution time for support tickets.

*Expected Output:*

| average_resolution_time |
|-------------------------|
| 1.0                     |

```sql 
SELECT
  AVG(DATEDIFF(resolved_date, created_date)) AS average_resolution_time
FROM
  support_tickets
WHERE 
  status IN ('Resolved', 'Closed');
```



### Question 10: Market Segment Analysis
*Task:* Calculate the average spend per customer segment.

*Expected Output:*

| segment  | average_spend |
|----------|---------------|
| Regular  | 816.00        |
| Premium  | 518.00        |
| VIP      | 200.00        |

```sql
WITH customer_total_spend AS (
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.unit_price * (100 - oi.discount_percent) / 100) AS total_spend
    FROM
        orders o
    JOIN
        order_items oi ON o.order_id = oi.order_id
    WHERE
        o.status != 'Cancelled'
    GROUP BY
        o.customer_id
)
SELECT
    c.segment,
    AVG(cts.total_spend) AS average_spend
FROM
    customers c
LEFT JOIN
    customer_total_spend cts ON c.customer_id = cts.customer_id
GROUP BY
    c.segment;
```


## Advanced Level Questions (11-20)

### Question 11: Customer Retention Analysis
*Task:* Calculate the retention rate of customers (percentage of customers who made repeat purchases).

*Expected Output:*

| retention_rate |
|----------------|
| 0.20           |

```sql
WITH multi_order_counts AS (
  SELECT 
    c.customer_id,
    COUNT(o.order_date) AS order_count
  FROM 
    customers c 
  LEFT JOIN
    orders o ON o.customer_id = c.customer_id 
  WHERE 
    o.status != 'Cancelled'
  GROUP BY 
    c.customer_id
  HAVING 
    COUNT(o.order_date) > 1
), total_customers AS (
  SELECT 
    COUNT(*) AS total_customer_count
  FROM 
    customers
)
SELECT
  ROUND(
    COUNT(customer_id) / (SELECT total_customer_count FROM total_customers)
    , 2) AS retention_rate
FROM 
  multi_order_counts;
```

### Question 12: Product Cancellation Rate
*Task:* Calculate the cancellation rate of products (percentage of products cancelled).

*Expected Output:*

| product_name    | cancellation_rate |
|-----------------|-------------------|
| Gaming Laptop   | 0.00              |
| Wireless Earbuds| 0.00              |
| Running Shoes   | 0.50              |
| Coffee Maker    | 0.00              |
| Protein Powder  | 0.00              |

```sql
SELECT 
  p.product_name,
  COALESCE(
    SUM(CASE WHEN o.status = 'Cancelled' THEN 1 ELSE 0 END)/ COUNT(o.order_id)
    , 0) cancellation_rate
FROM 
  products p 
LEFT JOIN
  order_items oi ON oi.product_id = p.product_id 
LEFT JOIN
  orders o ON o.order_id = oi.order_id 
GROUP BY
  p.product_name; 
```

### Question 13: Customer Churn Analysis
*Task:* Calculate the churn rate of customers (percentage of customers who did not make a purchase in the last 6 months). 
Assume that the current date is '2022-09-15'

*Expected Output:*

| churn_rate |
|------------|
| 0.40       |

```sql
WITH last_purchase_dates AS (
    SELECT
        customer_id,
        MAX(order_date) AS last_purchase_date
    FROM
        orders
    WHERE
        status != 'Cancelled'
    GROUP BY
        customer_id
),
churned_customers AS (
    SELECT
        COUNT(DISTINCT c.customer_id) AS churn_count
    FROM
        customers c
    LEFT JOIN
        last_purchase_dates lpd ON c.customer_id = lpd.customer_id
    WHERE
        lpd.last_purchase_date IS NULL OR lpd.last_purchase_date < DATE_SUB('2022-09-15', INTERVAL 6 MONTH)
),
total_customers AS (
    SELECT 
      COUNT(*) AS total_customer_count
    FROM 
      customers
)
SELECT
    ROUND(
      (SELECT churn_count FROM churned_customers) / (SELECT total_customer_count FROM total_customers)
    , 2) AS churn_rate;
```


### Question 14: Sales Trend Analysis
*Task:* Calculate the monthly sales trend (total sales per month).

*Expected Output:*

| month | total_sales |
|-------|-------------|
| Mar   | 2868.00     |

```sql
SELECT 
  SUBSTRING(MONTHNAME(o.order_date), 1, 3) AS month, 
  SUM((oi.quantity * oi.unit_price) * (100 - oi.discount_percent) / 100) AS total_sales
FROM 
  orders o
LEFT JOIN
  order_items oi ON oi.order_id = o.order_id 
WHERE 
  o.status != 'Cancelled'
GROUP BY 
  SUBSTRING(MONTHNAME(o.order_date), 1, 3);
```

### Question 15: Customer Segmentation
*Task:* Segment customers based on their purchase behavior (e.g., high spenders, low spenders).
Low Spender < 100, Medium Spender 100 - 499, High Spender 500+

*Expected Output:*

| customer_id | segment       |
|-------------|---------------|
| 1           | High Spender  |
| 2           | Low Spender   |
| 3           | Medium Spender|
| 4           | Medium Spender|
| 5           | High Spender  |

```sql
with customer_total_spend AS (
  SELECT 
    c.customer_id,
    SUM((oi.quantity * oi.unit_price) * (100 - oi.discount_percent) / 100) as total_spend
  FROM 
   customers c 
  LEFT JOIN
    orders o ON o.customer_id = c.customer_id
  LEFT JOIN
    order_items oi ON oi.order_id = o.order_id 
  WHERE 
    o.status != 'Cancelled'
  GROUP BY 
    c.customer_id 
) 
SELECT 
  customer_id,
  CASE WHEN total_spend < 100 THEN 'Low Spender'
       WHEN total_spend BETWEEN 100 AND 499 THEN 'Medium Spender'
       ELSE 'High Spender'
  END AS segment
FROM 
  customer_total_spend;
```


### Question 16: Customer Acquisition Cost
*Task:* Calculate the customer acquisition cost 
(total marketing spend divided by the number of new customers acquired based on their join date).

*Expected Output:*

| acquisition_cost |
|------------------|
| 5900.00          |


```sql
WITH campaign_spend AS (
  SELECT 
    MIN(date) AS campaign_begin_date,
    MAX(date) AS campaign_end_date,
    SUM(spend) AS total_campaign_spend
  FROM 
    campaign_performance
), customer_counts AS (
  SELECT 
    COUNT(*) AS new_customer_count
  FROM 
    customers 
  WHERE 
    join_date BETWEEN (SELECT campaign_begin_date FROM campaign_spend) AND 
     (SELECT campaign_end_date FROM campaign_spend) 
)
SELECT 
  (SELECT total_campaign_spend FROM campaign_spend) /
  new_customer_count AS acquisition_cost
FROM 
  customer_counts;
```


### Question 17: Ticket Resolution Effectiveness Score
*Task:* Calculate the ratio of 'Resolved' support tickets to the total number of support tickets 
that have been resolved (including those marked as 'Resolved' or 'Closed'). 
This provides a measure of the proportion of explicitly 'Resolved' tickets among all completed tickets.

*Expected Output:*

| resolution_effectiveness_rate |
|-------------------------------|
| 0.5                           |


```sql
WITH resolved_tickets_count AS (
  SELECT
    COUNT(*) AS resolved_count
  FROM
    support_tickets
  WHERE
    status = 'Resolved'
), completed_tickets_count AS (
  SELECT
    COUNT(*) AS completed_count
  FROM
    support_tickets
  WHERE
    status IN ('Resolved', 'Closed')
)
SELECT
  ROUND(
    CAST((SELECT resolved_count FROM resolved_tickets_count) AS REAL)
    /
    (SELECT completed_count FROM completed_tickets_count)
  , 2) AS resolution_effectiveness_rate;
```



### Question 18: Product Popularity Ranking
*Task:* Calculate the popularity ranking of each product (based on the number of orders).

*Expected Output:*

| product_name    | popularity |
|-----------------|------------|
| Gaming Laptop   | 1          |
| Wireless Earbuds| 1          |
| Running Shoes   | 2          |
| Coffee Maker    | 2          |
| Protein Powder  | 2          |

```sql
SELECT 
  p.product_name,
  DENSE_RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS popularity
FROM 
  products p 
LEFT JOIN
  order_items oi ON oi.product_id = p.product_id
LEFT JOIN
  orders o ON o.order_id = oi.order_id
WHERE 
  o.status != 'Cancelled'
GROUP BY 
  p.product_name;
```

### Question 19: Customer Feedback Analysis
*Task:* Analyze customer feedback (e.g., positive, negative, neutral) based on support ticket resolution.
Assume: 'Resolved' == Positive -- ('In Progress','Open') == Pending -- 'Closed' == Unknown


*Expected Output:*

| feedback_type | count |
|---------------|-------|
| Positive      | 1     |
| Pending       | 2     |
| Unknown       | 1     |

```sql
WITH feedback_cte AS (
  SELECT 
    CASE 
      WHEN status = 'Resolved' THEN 'Positive'
      WHEN status = 'Closed' THEN 'Unknown'
      ELSE 'Pending'
    END AS feedback_type
  FROM 
    support_tickets
)
SELECT 
  feedback_type,
  COUNT(feedback_type) AS count 
FROM 
  feedback_cte
GROUP BY 
  feedback_type;
```
