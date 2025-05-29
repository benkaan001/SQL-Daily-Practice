# Advanced SQL Practice Questions - E-commerce Database

## Question 1: Multi-Order Customer Insights
*Task:* List all customers who have placed more than one order, showing their name, email, total number of orders, and total amount spent (after discounts, excluding 'Cancelled' orders). Order by total amount spent descending.

*Expected Output:*
| customer_name   | email                  | num_orders | total_spent |
|-----------------|------------------------|------------|-------------|
| John Smith      | john.smith@email.com   | 2          | 1004.96     |
| Sarah Johnson   | sarah.j@email.com      | 2          | 389.97      |

```sql
-- Write your SQL query here
```

## Question 2: Product Stock Turnover Rate
*Task:* For each product, calculate the turnover rate as (total quantity sold / initial stock quantity). Show product name, category, initial stock, total sold, and turnover rate (rounded to 2 decimals). Only include products with at least 1 sale.

*Expected Output:*
| product_name    | category         | initial_stock | total_sold | turnover_rate |
|-----------------|------------------|--------------|------------|--------------|
| Fitness Tracker | Electronics      | 120          | 4          | 0.03         |
| Gaming Mouse    | Electronics      | 90           | 3          | 0.03         |
| Toaster         | Home Appliances  | 35           | 3          | 0.09         |

```sql
-- Write your SQL query here
```

## Question 3: High-Value Order Detection
*Task:* Find all orders where the total amount (after discounts) is more than 2x the average order amount for that customer. Show order_id, customer name, order date, total amount, and the average for that customer.

*Expected Output:*
| order_id | customer_name   | order_date  | total_amount | avg_customer_order |
|----------|-----------------|-------------|--------------|-------------------|
| 1003     | Emily Brown     | 2023-03-05  | 1429.98      | 714.99            |

```sql
-- Write your SQL query here
```

## Question 4: Category Sales Contribution
*Task:* For each product category, calculate the total sales and its percentage contribution to overall sales (excluding 'Cancelled' orders). Show category, total_sales, and percent_of_total (rounded to 2 decimals).

*Expected Output:*
| category         | total_sales | percent_of_total |
|------------------|------------|------------------|
| Electronics      | 2734.90    | 81.23            |
| Home Appliances  | 201.96     | 6.00             |
| Apparel          | 429.97     | 12.77            |

```sql
-- Write your SQL query here
```

## Question 5: Customer Inactivity Detection
*Task:* List all customers who have not placed any orders in the last 30 days (from the latest order date in the dataset). Show their name, email, and last order date (if any).

*Expected Output:*
| customer_name   | email                  | last_order_date |
|-----------------|------------------------|-----------------|
| Michael Williams| mike.w@email.com       | 2023-02-10      |
| Lisa Garcia     | lisa.g@email.com       | 2023-03-15      |
| Robert Miller   | robert.m@email.com     | NULL            |

```sql
-- Write your SQL query here
```
