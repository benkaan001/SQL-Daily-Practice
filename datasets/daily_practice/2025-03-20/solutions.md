**Question 1:**

**Explanation:** Find the names of all customers who have placed at least one order for a product in the 'Electronics' category. Return the unique customer names.

**Expected Output:**

| name          |
|---------------|
| Alice Smith   |
| Bob Johnson   |
| Charlie Brown |
| Frank Miller  |

**Solution Area:**

```sql
SELECT DISTINCT
	c.name
FROM 
	customers c
JOIN 
	orders o ON o.customer_id = c.customer_id
JOIN 
	order_details od ON od.order_id = o.order_id
JOIN 	
	products p ON p.product_id = od.product_id
WHERE EXISTS (
  	SELECT 1 
  	FROM products 
  	WHERE category = 'Electronics' 
  	AND product_id = od.product_id)
-- WHERE p.category = 'Electronics'  -- simpler approach
ORDER BY
	c.name;
```

**Question 2:**

**Explanation:** For each customer, find the total number of orders they have placed. Return the customer's name and the total number of orders, ordered by the number of orders in descending order.

**Expected Output:**

| name          | total_orders |
|---------------|--------------|
| Alice Smith   | 3            |
| Bob Johnson   | 2            |
| Charlie Brown | 2            |
| Frank Miller  | 1            |
| Grace Davis   | 1            |
| Diana Lee     | 1            |
| Eve Williams  | 1            |

**Solution Area:**

```sql
SELECT
	c.name,
    COUNT(o.order_id) AS total_orders
FROM
	customers c
LEFT JOIN 
	orders o ON o.customer_id = c.customer_id
GROUP BY
	c.name
ORDER BY
	total_orders DESC;
```

**Question 3:**

**Explanation:** Find the names of all products that have been ordered more than twice in total across all orders. Return the unique product names.

**Expected Output:**

| name     |
| -------- |
| Laptop   |
| Mouse    |
| Keyboard |
| T-Shirt  |
| Jeans    |
| Book     |
| Pen      |
| Notebook |

**Solution Area:**

```sql
SELECT DISTINCT
	p.name
FROM
	products p 
JOIN 
	order_details od ON p.product_id = od.product_id
GROUP BY
	p.name
HAVING
	SUM(od.quantity) > 2;
```

**Question 4:**

**Explanation:** For each order, calculate the total amount paid for the items in that order (quantity * unit_price from `OrderDetails`). Return the `order_id` and the `total_paid_amount` for each order.

**Expected Output:**

| order_id | total_paid_amount |
|----------|-------------------|
| 101      | 1325.00           |
| 102      | 180.00            |
| 103      | 75.00             |
| 104      | 1485.00           |
| 105      | 50.00             |
| 106      | 165.00            |
| 107      | 65.00             |
| 108      | 1320.00           |
| 109      | 30.00             |
| 110      | 195.00            |
| 111      | 35.00             |

**Solution Area:**

```sql
SELECT
	o.order_id,
    SUM(od.quantity * od.unit_price) AS total_amount_paid
FROM
	orders o 
LEFT JOIN 
	order_details od ON od.order_id = o.order_id
GROUP BY
	o.order_id;
```

**Question 5:**

**Explanation:** Find the customer who has spent the maximum total amount across all their orders. Return the customer's name and their total spending. If there is a tie, you can return any one of them.

**Expected Output:**

| name            | total_spending |
|-----------------|----------------|
| Charlie Brown   | 1440.00        |

**Solution Area:**

```sql
SELECT
	c.name,
    SUM(od.quantity * od.unit_price) AS total_spending
FROM 	
	customers c
JOIN 
	orders o ON o.customer_id = c.customer_id
JOIN 
	order_details od ON od.order_id = o.order_id
GROUP BY
	c.name
ORDER BY
	total_spending DESC
LIMIT 1;
```

**Question 6:**

**Explanation:** List all products along with the number of times they have been ordered. Return the product name and the order count, ordered by the order count in descending order.

**Expected Output:**

| name     | order_count |
| -------- | ----------- |
| Jeans    | 4           |
| Laptop   | 3           |
| Mouse    | 3           |
| Keyboard | 3           |
| T-Shirt  | 3           |
| Book     | 3           |
| Pen      | 3           |
| Notebook | 2           |

**Solution Area:**

```sql
SELECT
	p.name,
    COUNT(od.order_id) AS order_count
FROM
	products p
LEFT JOIN 
	order_details od ON od.product_id = p.product_id
GROUP BY 
	p.name
ORDER BY 
	order_count DESC;
```

**Question 7:**

**Explanation:** Find the names of customers who have placed orders only for products in the 'Apparel' category.

**Expected Output:**

| name          |
|---------------|
| Bob Johnson   |

**Solution Area:**

```sql
SELECT DISTINCT
    c.name
FROM
    customers c
JOIN
    orders o ON c.customer_id = o.customer_id
WHERE NOT EXISTS (
    SELECT 1
    FROM order_details od
    JOIN products p ON od.product_id = p.product_id
    WHERE od.order_id = o.order_id
      AND p.category <> 'Apparel'
)
AND EXISTS (
    SELECT 1
    FROM order_details od
    JOIN products p ON od.product_id = p.product_id
    WHERE od.order_id = o.order_id
      AND p.category = 'Apparel'
);
```

**Question 8:**

**Explanation:** For each product category, find the average price of the products in that category. Return the category name and the average price.

**Expected Output:**

| category    | average_price |
|-------------|---------------|
| Apparel     | 40.00         |
| Books       | 15.00         |
| Electronics | 433.33        |
| Stationery  | 3.75          |

**Solution Area:**

```sql
SELECT
	category,
    TRUNCATE(AVG(price), 2) AS average_price
FROM
	products
GROUP BY
	category;
```

**Question 9:**

**Explanation:** Find the names of customers who have placed at least one order in the month of March 2024. Return the unique customer names.

**Expected Output:**

| name          |
|---------------|
| Alice Smith   |
| Charlie Brown |

**Solution Area:**

```sql
SELECT
	c.name
FROM
	customers c
JOIN
	orders o ON o.customer_id = c.customer_id
WHERE
	YEAR(o.order_date) = 2024 
    AND MONTH(o.order_date) = 3;
```

**Question 10:**

**Explanation:** Find the order that has the highest number of distinct products. Return the `order_id`.

**Expected Output:**

| order_id |
| -------- |
| 108      |
| 101      |
| 104      |
| 106      |
| 102      |
| 105      |
| 107      |
| 110      |
| 103      |
| 109      |
| 111      |

**Solution Area:**

```sql
3
SELECT
14
    order_id
15
FROM
16
    order_details
17
GROUP BY
18
    order_id
19
ORDER BY
20
    COUNT(DISTINCT product_id)  DESC;
```
