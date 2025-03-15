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
-- Write your solution here
```

## Question 2: Monthly Sales Trend
Write a query to show the total sales amount for each month of 2023, 
along with the month-over-month percentage change. Display 0.00% for the first month.
Round the results to 2 decimal points. Exclcude discounts and 'Cancelled' orders. 

Expected output:
| year_month | total_sales | mom_change_percent |
|------------|-------------|-------------------|
| 2023-02 | 939.97 | 0.00% |
| 2023-03 | 2599.85 | 0.64% ||
```sql

-- Write your solution here
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
-- Write your solution here
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
-- Write your solution here
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
-- Write your solution here
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
Create a query to find customers who made their first purchase in January or February 2023 
and then made another purchase in March 2023. 
Show their name, first purchase date, and most recent purchase date.

Expected output:
| customer_name | first_purchase_date | latest_purchase_date |
|---------------|---------------------|----------------------|
| John Smith | 2023-02-01 | 2023-03-10 |
| Sarah Johnson | 2023-02-25 | 2023-03-20 |

```sql
-- Write your solution here
```

## Question 8: Product Pair Analysis
Write a query to find pairs of products that are frequently purchased together (in the same order). 
Display the pair of product names and the number of times they were purchased together.

Expected output:


| product_1         | product_2         | times_bought_together |
|--------------------|-------------------|------------------------|
| Fitness Tracker    | Toaster           | 3                      |
| Gaming Mouse       | Fitness Tracker   | 2                      |
| Smartphone X       | Gaming Mouse      | 1                      |
| Laptop Pro         | Fitness Tracker   | 1                      |
| Laptop Pro         | Toaster           | 1                      |
| Running Shoes      | Fitness Tracker   | 1                      |
| Running Shoes      | Gaming Mouse      | 1                      |
| Gaming Mouse       | Toaster           | 1                      |
| Wireless Earbuds   | Fitness Tracker   | 1                      |
| Wireless Earbuds   | Toaster           | 1                      |
| Wireless Earbuds   | Toaster           | 1                      |
| Running Shoes      | Winter Jacket     | 1                      |


```sql
-- Write your solution here
```

-- ## Question 9: Customer Purchase Gaps
-- For each customer with multiple orders, calculate the number of days 
-- between consecutive orders. 
-- Include customers who have placed at least 2 orders.

-- Expected output:
-- | customer_id | customer_name | num_orders | days_between_orders |
-- |-------------|---------------|------------|-------------------------|
-- | 1 | John Smith | 2 | 37 |
-- | 2 | Sarah Johnson | 2 | 23 |

```sql
-- Write your solution here
```

## Question 10: Cumulative Discount Analysis
Create a query that calculates the cumulative discount amount 
provided to customers over time, ordered by date. 
Show the date, discount amount for that date, and running total discount.

| order_date               | daily_discount_amount | cumulative_discount |
|--------------------------|-----------------------|---------------------|
| 2023-02-01T00:00:00.000Z | 80                    | 80                  |
| 2023-02-10T00:00:00.000Z | 0                     | 80                  |
| 2023-02-25T00:00:00.000Z | 0                     | 80                  |
| 2023-03-05T00:00:00.000Z | 6                     | 86                  |
| 2023-03-10T00:00:00.000Z | 25                    | 110.99              |
| 2023-03-12T00:00:00.000Z | 0                     | 110.99              |
| 2023-03-15T00:00:00.000Z | 0                     | 110.99              |
| 2023-03-18T00:00:00.000Z | 32                    | 172.99              |
| 2023-03-20T00:00:00.000Z | 30                    | 172.99              |

```sql
-- Write your solution here
```