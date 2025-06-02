# Advanced SQL Practice Questions - E-commerce Database

## Question 1: Quarterly Category Growth
*Task:* For each product category and quarter, calculate the total sales, the number of unique customers, and the quarter-over-quarter growth rate in sales (show 0.00% for the first quarter). Show quarter, category, total_sales, unique_customers, and growth_rate.

*Expected Output:*
| quarter | category         | total_sales | unique_customers | growth_rate |
|---------|------------------|-------------|------------------|-------------|
| Q1 2023 | Electronics      | 2734.90     | 4                | 0.00%       |
| Q1 2023 | Home Appliances  | 201.96      | 3                | 0.00%       |
| Q1 2023 | Apparel          | 429.97      | 2                | 0.00%       |

```sql
-- Write your SQL query here
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
-- Write your SQL query here
```

## Question 3: Product Discount Tier Analysis
*Task:* For each price tier (Budget < $100, Mid-range $100-$500, Premium > $500), calculate the number of products, average discount percentage, and the best-selling product in each tier by quantity sold.

*Expected Output:*
| price_tier | num_products | avg_discount_percentage | best_seller      |
|------------|--------------|------------------------|------------------|
| Budget     | 5            | 5.83%                  | Toaster          |
| Mid-range  | 3            | 7.00%                  | Running Shoes    |
| Premium    | 2            | 3.33%                  | Laptop Pro       |

```sql
-- Write your SQL query here
```

## Question 4: Customer Order Completion Rate
*Task:* For each customer, show their name, total orders, delivered orders, and completion rate (delivered/total, as a percent rounded to 2 decimals).

*Expected Output:*
| customer_name    | total_orders | delivered_orders | completion_rate |
|------------------|-------------|------------------|----------------|
| John Smith       | 2           | 2                | 100.00%        |
| Sarah Johnson    | 2           | 1                | 50.00%         |
| David Jones      | 1           | 1                | 100.00%        |
| Emily Brown      | 1           | 0                | 0.00%          |
| Jennifer Davis   | 1           | 0                | 0.00%          |
| Lisa Garcia      | 1           | 0                | 0.00%          |
| Michael Williams | 1           | 0                | 0.00%          |
| Robert Miller    | 0           | 0                | 0.00%          |

```sql
-- Write your SQL query here
```

## Question 5: Fraud Detection - Rapid Repeat Orders
*Task:* Find all orders placed by the same customer within 24 hours of a previous order. Show order_id, customer name, order_date, and previous order date.

*Expected Output:*
| order_id | customer_name   | order_date  | prev_order_date |
|----------|-----------------|-------------|-----------------|
| 1004     | John Smith      | 2023-03-10  | 2023-02-01      |
| 1009     | Sarah Johnson   | 2023-03-20  | 2023-02-25      |

```sql
-- Write your SQL query here
```
