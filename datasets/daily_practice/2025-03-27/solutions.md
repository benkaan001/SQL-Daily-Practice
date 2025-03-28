## Question 1: Highest Daily Order Cost by Customer
Find the customer with the highest daily total order cost between 2025-01-01 and 2025-03-01.  
For each customer on a given day, sum the total_order_cost if they placed more than one order.  
Return the customer's first name, the summed total_order_cost, and the order date for the day that had the highest total for that customer.

**Expected Output Format:**

| first_name | daily_total_order_cost | order_date  |
| ---------- | ---------------------- | ----------- |
| Alice      | 1250                   | 2025-01-05  |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 2: Highest Average Order Cost among Customers
For each customer, compute the average order cost across all their orders.  
Then, identify the customer with the highest average order cost.  
Return the customer's first name, average order cost, and the total number of orders they placed.

**Expected Output Format:**

| first_name | average_order_cost | total_orders |
| ---------- | ------------------ | ------------ |
| Edward     | 1540               | 2            |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 3: Highest Total Order Cost Day per City
For each city, determine which day (order_date) had the highest total order cost (summing orders from all customers in that city) between 2025-01-01 and 2025-03-01.  
Output the city, the date, and the total order cost for that day.

**Expected Output Format:**

| city       | order_date  | total_order_cost |
| ---------- | ----------- | ---------------- |
| Los Angeles| 2025-02-15  | 1580             |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 4: First Word Frequency in Order Details
Extract the first word from the `order_details` column for each order (ignoring punctuation).  
Count how many times each first word appears across all orders.  
Output two columns: the first word and the frequency count.

**Expected Output Format:**

| first_word  | frequency |
| ----------- | --------- |
| Electronics | 3         |
| Furniture   | 2         |
| Book        | 1         |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 5: Monthly Order Trends
Aggregate the orders on a monthly basis for the period 2025-01-01 to 2025-03-01.  
For each month (formatted as YYYY-MM), count the total number of orders and sum the total_order_cost.  
Output three columns: month, order_count, and total_order_cost.

**Expected Output Format:**

| month   | order_count | total_order_cost |
| ------- | ----------- | ---------------- |
| 2025-01 | 4           | 2750             |
| 2025-02 | 4           | 3030             |
| 2025-03 | 1           | 200              |

**Your Solution:**
```sql
-- Write your solution here
```
