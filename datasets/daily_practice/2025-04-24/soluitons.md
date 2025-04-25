## Question 1: Favorite Customers

Find "favorite" customers based on the order count and the total cost of orders.
A customer is considered as a favorite if they have placed more than 3 orders and with the total cost of orders more than $100.
Output the customer's first name, city, number of orders, and total cost of orders.

**Expected Output:**

| first_name | city          | num_orders | total_cost |
| ---------- | ------------- | ---------- | ---------- |
| Jill       | Austin        | 8          | 535        |
| Mia        | Miami         | 7          | 540        |
| Farida     | San Francisco | 4          | 260        |

**Your Solution:**
```sql
SELECT
	c.first_name,
    c.city,
    COUNT(DISTINCT o.id) AS num_orders,
    SUM(o.total_order_cost) AS total_cost
FROM
	customers c
JOIN
	orders o ON o.cust_id = c.id
GROUP BY
	c.first_name,
    c.city,
    c.id
HAVING
	num_orders > 3
    AND total_cost > 100
ORDER BY
	num_orders DESC;
```

---

## Question 2: Customers with the Most Expensive Single Order

Find the customer(s) who placed the single most expensive order.
Output first_name, city, order_date, order_details, and total_order_cost.

**Expected Output:**

| first_name | city   | order_date | order_details | total_order_cost |
|------------|--------|------------|---------------|------------------|
| Mia        | Miami  | 2019-04-20 | Dresses       | 200              |

**Your Solution:**
```sql
SELECT
	c.first_name,
    c.city,
    o.order_date,
    o.order_details,
    o.total_order_cost
FROM
	customers c
JOIN
	orders o ON o.cust_id = c.id
ORDER BY
	o.total_order_cost DESC
LIMIT 1;
```

---

## Question 3: Customers Who Ordered in Every Month

Find customers who have placed at least one order in **every month** represented in the dataset (Jan, Feb, Mar, Apr 2019).
Output first_name and city.

**Expected Output:**

| first_name | city   |
|------------|--------|
| Mia        | Miami  |

**Your Solution:**
```sql
WITH grouped_orders AS (
  SELECT
      c.first_name,
      c.city,
      GROUP_CONCAT(DISTINCT MONTH(o.order_date) ORDER BY MONTH(o.order_date)) AS order_months
  FROM
      customers c
  JOIN
      orders o ON o.cust_id = c.id
  WHERE
      YEAR(o.order_date) = 2019
  GROUP BY
      c.first_name,
      c.id,
      c.city
)
SELECT
  	first_name,
  	city
FROM
  	grouped_orders
WHERE
  	order_months = '1,2,3,4';
```
---

