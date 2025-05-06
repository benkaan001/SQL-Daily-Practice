## Question 1: Customers with Only One Type of Interaction

Find customers who have only ever performed one type of interaction (e.g., only 'click', only 'view', etc.).
Output customer_id and interaction_type.

**Expected Output:**

| customer_id | interaction_type |
| ----------- | ---------------- |
| 3           | view             |
| 6           | click            |
| 10          | view             |

**Your Solution:**
```sql
  SELECT
  	customer_id
  FROM
  	interactions
  GROUP BY
  	customer_id
  HAVING
  	COUNT(DISTINCT interaction_type ) = 1
)
SELECT DISTINCT
	customer_id,
    interaction_type
FROM
	interactions
WHERE
	customer_id IN (SELECT customer_id FROM single_interaction_customers);

-- Alternative solution
SELECT
    customer_id,
    MIN(interaction_type) AS interaction_type
FROM
    interactions
GROUP BY
    customer_id
HAVING
    COUNT(DISTINCT interaction_type) = 1;
```
---

## Question 2: Most Active Customer by Content Creation

Find the customer(s) who created the most content items.
Output customer_id and content_count.

**Expected Output:**

| customer_id | content_count |
| ----------- | ------------- |
| 6           | 3             |
| 2           | 3             |

**Your Solution:**
```sql
WITH ranked_customers AS (
  SELECT
      customer_id,
      COUNT(*) AS content_count,
      DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
  FROM
      contents
  GROUP BY
      customer_id
)
SELECT
	customer_id,
    content_count
FROM
	ranked_customers
WHERE
	rnk = 1;
```
---

## Question 3: Customers with Interactions but No Content

Find customers who have at least one interaction but have **never** created any content.
Output customer_id.

**Expected Output:**

| customer_id |
| ----------- |
| 3           |
| 5           |
| 7           |

**Your Solution:**
```sql
SELECT DISTINCT
	i.customer_id
FROM
	interactions i
WHERE NOT EXISTS (
  SELECT
  	1
  FROM
  	contents
  WHERE
  	customer_id = i.customer_id
);

-- Alternative solution
SELECT DISTINCT
	i.customer_id
FROM
	contents c
RIGHT JOIN
	interactions i ON i.customer_id = c.customer_id
WHERE
	c.content_type IS NULL;
```
---
