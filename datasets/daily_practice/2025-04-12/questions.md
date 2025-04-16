## Question 1: Average Earnings per Order by Weekday and Hour

Calculate the average net earnings per order segmented by the weekday and hour when the order was placed.
* Use `customer_placed_order_datetime` to extract the weekday (in text format, e.g., Monday) and the hour (0–23).
* Compute the net earnings as `order_total + tip_amount - discount_amount - refunded_amount`.
* Round the average net earnings to two decimals.

**Expected Output Format (Based on first 40 rows):**

| day_of_week | hour | average_net_earnings |
| ----------- | ---- | -------------------- |
| Monday      | 0    | 31.47                |
| Monday      | 1    | 36.59                |
| Monday      | 4    | 26.66                |
| Monday      | 16   | 32.41                |
| Monday      | 23   | 28.44                |
| Tuesday     | 0    | 18.03                |
| Tuesday     | 1    | 27.26                |
| Tuesday     | 17   | 15.84                |
| Tuesday     | 19   | 38.73                |
| Tuesday     | 20   | 56.13                |
| Wednesday   | 1    | 31.79                |
| Wednesday   | 3    | 56.32                |
| Wednesday   | 4    | 12.29                |
| Thursday    | 0    | 34.56                |
| Thursday    | 16   | 104.84               |
| Thursday    | 21   | 141.37               |
| Friday      | 17   | 41.30                |
| Friday      | 20   | 25.03                |
| Friday      | 23   | 114.03               |
| Saturday    | 3    | 28.69                |
| Saturday    | 4    | 40.18                |
| Saturday    | 16   | 36.38                |
| Saturday    | 18   | 59.81                |
| Saturday    | 19   | 56.24                |
| Sunday      | 0    | 51.35                |
| Sunday      | 5    | 673.75               |
| Sunday      | 16   | 28.60                |
| Sunday      | 17   | 25.22                |
| Sunday      | 23   | 38.04                |

**Your Solution:**
```sql
-- Write your solution here
```
---


## Question 2: Regional Sales Performance

For each `delivery_region`, calculate the following:
* The total net earnings (i.e. sum of `order_total + tip_amount - discount_amount - refunded_amount`).
* The average net earnings per order.
* The total number of orders.
Round monetary values to two decimals.

**Expected Output Format :**


| delivery_region | total_net_earnings | average_net_earnings | order_count |
| --------------- | ------------------ | -------------------- | ----------- |
| San Jose        | 1122.74            | 46.78                | 24          |
| Palo Alto       | 405.01             | 33.75                | 12          |
| Mountain View   | 63.30              | 31.65                | 2           |
| null            | 778.59             | 389.30               | 2           |

*(Note: The NULL region includes the rows explicitly marked NULL in the data provided)*


**Your Solution:**

```sql
-- Write your solution here
```
---

## Question 3: On-Time vs. Late Delivery Earnings

An order is considered "Late" if the difference (in minutes) between `delivered_to_consumer_datetime` and `placed_order_with_restaurant_datetime` is more than 60 minutes; otherwise, it is "On-Time."
* Exclude orders where either `placed_order_with_restaurant_datetime` or `delivered_to_consumer_datetime` is NULL.
* Write a query that calculates, for each `delivery_status` category ("On-Time" and "Late"):
    * The average net earnings per order
    * The number of orders in each category
* Round monetary values to two decimals, and display the `delivery_status` as shown below.

**Expected Output Format :**

| delivery_status | average_net_earnings | order_count |
|-----------------|----------------------|-------------|
| On-Time         | 38.21                | 31          |
| Late            | 101.44               | 4           |

**Your Solution:**

```sql
-- Write your solution here
```