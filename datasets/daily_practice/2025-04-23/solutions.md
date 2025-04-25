## Question 1: Customers with Highest Total Spend

Find the customer(s) with the highest total spend across all their orders.
Output cust_id and total_spend.

**Expected Output:**

| cust_id | total_spend |
|---------|-------------|
| 15      | 540         |

**Your Solution:**
```sql
SELECT
	cust_id,
    SUM(total_order_cost) AS total_spend
FROM
	orders
GROUP BY
	cust_id
ORDER BY
	total_spend DESC
LIMIT 1;
```
---

## Question 2: Most Popular Order Detail

Find the order_details value(s) that appear most frequently in the orders table.
Output order_details and order_count.

**Expected Output:**

| order_details | order_count |
| ------------- | ----------- |
| Coat          | 5           |
| Shirts        | 5           |
| Shoes         | 4           |
| Skirt         | 3           |


**Your Solution:**
```sql
WITH ranked_orders AS (
  SELECT
      order_details,
      COUNT(*) AS order_count,
      DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
  FROM
      orders
  GROUP BY
      order_details
)
SELECT
	order_details,
    order_count
FROM
	ranked_orders
WHERE
	rnk <= 3;
```

---

## Question 3: Customers with Orders in Every Month

Find customers who have placed at least one order in **every month** represented in the dataset (Jan, Feb, Mar, Apr 2019).
Output cust_id.

**Expected Output:**

| cust_id |
|---------|
| 15      |


**Your Solution:**
```sql
WITH orders_per_month AS (
  SELECT
    cust_id,
    GROUP_CONCAT(DISTINCT MONTH(order_date) ORDER BY MONTH(order_date)) AS order_months
  FROM
    orders
  WHERE
  	YEAR(order_date) = 2019
  GROUP BY
  	cust_id
)
SELECT
	cust_id
FROM
	orders_per_month
WHERE
	order_months = '1,2,3,4';
```
---
