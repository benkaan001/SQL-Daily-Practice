# SQL Daily Practice - 2025-07-11

### Question 1: Customer Net Spend and Return Rate

Calculate the net_spend for each customer, defined as (total orders amount - total returned amount).

Also, calculate the return_rate_percentage for each customer, defined as (total returned amount / total orders amount) * 100. If a customer has no orders, they should not appear. If they have orders but no returns, their return rate should be 0.00.

Exclude shipping fees from these calculations.

Output customer_id, net_spend (rounded to two decimal places), and return_rate_percentage (rounded to two decimal places).

Order the results by customer_id ascending.

**Expected Output:**

| customer_id | net_spend | return_rate_percentage |
| ----------- | --------- | ---------------------- |
| 1           | 126.50    | 76.85                  |
| 2           | -22.00    | 103.24                 |
| 3           | 83.50     | 32.39                  |
| 4           | 72.00     | 0.00                   |
| 5           | 585.00    | 0.00                   |

**Your Solution:**

```sql
WITH categorized_spend AS (
	SELECT
		o.customer_id,
		SUM(o.total_amount - o.shipping_fee) AS total_spend,
		SUM(COALESCE(r.returned_amount, 0)) AS total_returned_amount
	FROM
		Orders o
	LEFT JOIN
		Returns r ON o.order_id = r.order_id
	GROUP BY
		o.customer_id
)
SELECT
 	customer_id,
 	total_spend - total_returned_amount AS net_spend,
 	ROUND(COALESCE(total_returned_amount * 100.0 / total_spend, 2), 2) AS return_rate_percentage
FROM
	categorized_spend
ORDER BY
	customer_id ASC;
```

### Question 2: Monthly Refund Value by Return Reason

Calculate the total refund_value for each reason for return on a monthly basis for 2024.

If a return has a NULL reason, categorize it as 'No Reason Provided'.

Output month_year (format %Y-%m), return_reason, and total_refund_value (rounded to two decimal places).

Order the results by month_year ascending, then by return_reason ascending.

**Expected Output:**

| month_year | return_reason            | total_refund_value |
| ---------- | ------------------------ | ------------------ |
| 2024-01    | Changed mind             | 100.00             |
| 2024-01    | Defective product        | 150.00             |
| 2024-02    | No Reason Provided       | 300.00             |
| 2024-03    | Product not as described | 400.00             |
| 2024-03    | Wrong size               | 50.00              |
| 2024-04    | Damaged in transit       | 120.00             |
| 2024-04    | Duplicate order          | 40.00              |

**Your Solution:**

```sql
SELECT
	DATE_FORMAT(return_date, '%Y-%m') AS month_year,
	COALESCE(reason, 'No Reason Provided') AS return_reason,
	ROUND(COALESCE(SUM(returned_amount), 0), 2) AS total_refund_value
FROM
	Returns
GROUP BY
	month_year,
	reason
ORDER BY
	month_year ASC,
	return_reason ASC;
```

### Question 3: Orders with High Return-to-Order Time

Identify orders where the time between order_date and return_date is greater than the average return-to-order time for all returned orders.

Only consider orders that have been returned.

Output order_id, customer_id, order_date, return_date, and days_to_return.

Round days_to_return to zero decimal places.

Order the results by days_to_return descending, then by order_id ascending.

**Expected Output:**

| order_id | customer_id | order_date | return_date | days_to_return |
| -------- | ----------- | ---------- | ----------- | -------------- |
| 103      | 2           | 2024-01-05 | 2024-02-01  | 27             |
| 105      | 1           | 2024-02-15 | 2024-03-01  | 15             |
| 109      | 3           | 2024-04-05 | 2024-04-20  | 15             |

**Your Solution:**

```sql
WITH avg_rto AS (
SELECT
	AVG(DATEDIFF(r.return_date, o.order_date)) AS average_rto
FROM
	Orders o
RIGHT JOIN
	Returns r ON o.order_id = r.order_id
)
SELECT
 	o.order_id,
 	o.customer_id,
 	o.order_date,
 	r.return_date,
 	ROUND(DATEDIFF(r.return_date, o.order_date)) AS days_to_return
FROM
	Orders o
JOIN
	Returns r ON o.order_id = r.order_id
WHERE
	DATEDIFF(r.return_date, o.order_date) > (SELECT average_rto FROM avg_rto)
ORDER BY
	days_to_return DESC,
	o.order_id ASC;
```
