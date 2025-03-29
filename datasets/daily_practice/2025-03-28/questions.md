## Question 1: Monthly Percentage of Extremely Late Deliveries
A delivery is flagged as extremely late if the actual_delivery_time is more than 20 minutes after the predicted_delivery_time (strictly greater than 20 minutes).  
Calculate, for each month, the percentage of orders that arrive extremely late.  
Output the month (in 'YYYY-MM' format) and the percentage of extremely late orders (rounded to two decimal places).

**Expected Output Format:**

| month   | extremely_late_percentage |
| ------- | ------------------------- |
| 2025-01 | 50.00                     |
| 2025-02 | 66.67                     |
| 2025-03 | 50.00                     |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 2: Driver with Highest Average Delay for Extremely Late Deliveries
For deliveries that are flagged as extremely late, determine the driver with the highest average delay (in minutes).  
Calculate the delay as the difference between actual_delivery_time and predicted_delivery_time (in minutes).  
Return the driver_id and their average delay for these deliveries (rounded to one decimal place).

**Expected Output Format:**

| driver_id | average_delay_minutes |
| --------- | --------------------- |
| DR1      | 23.5                  |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 3: Restaurant Performance: Late Order Ratio
For each restaurant, calculate the total number of orders and the number of extremely late orders, then compute the ratio (as a percentage) of extremely late orders.  
Output the restaurant_id and the percentage of extremely late orders (rounded to two decimal places).

**Expected Output Format:**

| restaurant_id | late_order_percentage |
| ------------- | --------------------- |
| R1            | 66.67                 |
| R2            | 33.33                 |
| R3            | 66.67                 |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 4: Delivery Rating Comparison by Month
For each month between 2025-01-01 and 2025-03-01, compute the average delivery rating for on-time (or within 20 minutes) deliveries versus extremely late deliveries.  
Output the month, average rating for on-time deliveries, and average rating for extremely late deliveries (rounded to one decimal place).

**Expected Output Format:**

| month   | on_time_avg_rating | extremely_late_avg_rating |
| ------- | ------------------ | ------------------------- |
| 2025-01 | 4.0                | 4.5                      |
| 2025-02 | 4.2                | 3.7                      |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 5: Top Consumers with Most Extremely Late Deliveries in March
For the month of March 2025, identify the top 3 consumers with the highest count of extremely late deliveries.  
Output their consumer_id along with the count of extremely late deliveries.

**Expected Output Format:**

| consumer_id | extremely_late_count |
| ----------- | -------------------- |
| C2          | 2                    |
| C5          | 1                    |
| C3          | 0                    |

**Your Solution:**
```sql
-- Write your solution here
```