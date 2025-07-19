## Question 1: Monthly Product Sales Analysis

You are given a table of e-commerce sales data. Write a query to calculate the total number of unique products sold, the total number of units sold, and the total revenue for each product category, grouped by month.

The month should be formatted as 'YYYY-MM'. Total revenue for a product is `quantity * price_per_unit`.

Order the results by month (chronologically) and then by product category alphabetically.

**Expected Output:**

| **sales_month** | **category** | **unique_products_sold** | **total_units_sold** | **total_revenue** |
| --------------------- | ------------------ | ------------------------------ | -------------------------- | ----------------------- |
| 2023-01               | Electronics        | 2                              | 8                          | 2519.94                 |
| 2023-01               | Home & Kitchen     | 2                              | 8                          | 289.92                  |
| 2023-02               | Apparel            | 2                              | 25                         | 749.75                  |
| 2023-02               | Electronics        | 1                              | 5                          | 2499.95                 |
| 2023-02               | Toys & Games       | 1                              | 15                         | 299.85                  |
| 2023-03               | Apparel            | 1                              | 10                         | 499.90                  |
| 2023-03               | Books              | 1                              | 20                         | 259.80                  |
| 2023-03               | Electronics        | 1                              | 1                          | 499.99                  |
| 2023-03               | Home & Kitchen     | 2                              | 12                         | 689.88                  |

**Your Solution:**

```sql
-- Write your solution here

```

## Question 2: Identifying High-Value Customers

Identify "High-Value Customers" who have made at least 3 separate transactions and have a total lifetime spend greater than $500.

Your report should list the `customer_id`, the total number of transactions they've made, and their total lifetime spend, rounded to two decimal places.

Order the results by total lifetime spend in descending order.

**Expected Output:**

| **customer_id** | **transaction_count** | **total_lifetime_spend** |
| --------------------- | --------------------------- | ------------------------------ |
| 102                   | 3                           | 2909.86                        |
| 101                   | 5                           | 2229.68                        |
| 104                   | 4                           | 1069.81                        |

**Your Solution:**

```sql
-- Write your solution here

```

## Question 3: Time Between a Customer's First and Second Purchase

For every customer who has made more than one purchase, calculate the number of days between their first and second purchase.

The output should include the `customer_id` and the calculated `days_between_first_and_second_purchase`.

Order the results by `customer_id`.

**Expected Output:**

| **customer_id** | **days_between_first_and_second_purchase** |
| --------------------- | ------------------------------------------------ |
| 101                   | 15                                               |
| 102                   | 34                                               |
| 103                   | 15                                               |
| 104                   | 23                                               |

**Your Solution:**

```sql
-- Write your solution here

```
