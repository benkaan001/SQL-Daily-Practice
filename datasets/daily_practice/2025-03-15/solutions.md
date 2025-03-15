# SQL Practice Questions - E-commerce Database

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