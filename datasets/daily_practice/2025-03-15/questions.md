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
-- Write your solution here
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
-- Write your solution here
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
-- Write your solution here
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
-- Write your solution here
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
-- Write your solution here
```