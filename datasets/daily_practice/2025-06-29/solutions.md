### Question 1: Customer Lifetime Value (CLV) by Registration Cohort and Region

Calculate the Customer Lifetime Value (CLV) for each customer, defined as the SUM(quantity * price_per_unit - COALESCE(discount_applied, 0)) of all their sales.

Then, group customers by their registration_month (formatted as %Y-%m) and region. For each cohort, calculate the average_clv and the total_customers_in_cohort.

Output registration_month, region, average_clv (rounded to two decimal places), and total_customers_in_cohort.

Order the results by registration_month ascending, then by region ascending.

Only include cohorts with at least one customer who has made a purchase.

**Expected Output:**

| registration_month | region | average_clv | total_customers_in_cohort |
| ------------------ | ------ | ----------- | ------------------------- |
| 2023-01            | North  | 2410.00     | 1                         |
| 2023-01            | South  | 665.00      | 1                         |
| 2023-02            | East   | 1370.00     | 1                         |
| 2023-02            | West   | 350.00      | 1                         |
| 2023-03            | North  | 1330.00     | 1                         |
| 2023-03            | South  | 60.00       | 1                         |
| 2023-04            | East   | 400.00      | 1                         |

**Your Solution:**

```sql
WITH lifetime_value AS(
	SELECT
		customer_id,
		SUM(quantity * price_per_unit - COALESCE(discount_applied, 0)) AS clv
	FROM
		Sales
	GROUP BY
		customer_id
)
SELECT
	DATE_FORMAT(c.registration_date, '%Y-%m') AS registration_month,
	c.region,
	ROUND(AVG(lv.clv), 2) AS average_clv,
	COUNT(lv.clv) AS total_customers_in_cohort
FROM
	lifetime_value lv
JOIN
	Customers c ON c.customer_id = lv.customer_id
GROUP BY
	c.region,
	registration_month
HAVING
	total_customers_in_cohort >= 1
ORDER BY
	registration_month ASC,
	c.region ASC;
```

### Question 2: Product Performance by Quarterly Sales

For each product_name, calculate its total revenue for each quarter of 2024.

Revenue for a sale is quantity * price_per_unit - COALESCE(discount_applied, 0).

Display the results in a pivoted table format, with product_name as rows and Q1_2024_Revenue, Q2_2024_Revenue, Q3_2024_Revenue, Q4_2024_Revenue as columns.

If a product has no sales in a quarter, display 0.00 for that quarter's revenue.

Round revenues to two decimal places.

Order the results by product_name ascending.

**Expected Output:**

| product_name   | Q1_2024_Revenue | Q2_2024_Revenue | Q3_2024_Revenue | Q4_2024_Revenue |
| -------------- | --------------- | --------------- | --------------- | --------------- |
| Case           | 30.00           | 0.00            | 0.00            | 0.00            |
| Chair          | 100.00          | 0.00            | 0.00            | 0.00            |
| Charger        | 20.00           | 0.00            | 0.00            | 0.00            |
| Desk           | 250.00          | 0.00            | 0.00            | 0.00            |
| External SSD   | 0.00            | 120.00          | 0.00            | 0.00            |
| Gaming Console | 0.00            | 450.00          | 0.00            | 0.00            |
| Headphones     | 0.00            | 135.00          | 0.00            | 0.00            |
| Keyboard       | 75.00           | 0.00            | 0.00            | 0.00            |
| Laptop         | 950.00          | 950.00          | 0.00            | 0.00            |
| Monitor        | 290.00          | 0.00            | 0.00            | 0.00            |
| Mouse          | 25.00           | 0.00            | 0.00            | 0.00            |
| Projector      | 0.00            | 400.00          | 0.00            | 0.00            |
| Smart TV       | 760.00          | 0.00            | 0.00            | 0.00            |
| Smartphone     | 670.00          | 680.00          | 0.00            | 0.00            |
| Soundbar       | 120.00          | 0.00            | 0.00            | 0.00            |
| Stylus Pen     | 0.00            | 20.00           | 0.00            | 0.00            |
| Tablet         | 480.00          | 0.00            | 0.00            | 0.00            |
| Webcam         | 60.00           | 0.00            | 0.00            | 0.00            |

**Your Solution:**

```sql
WITH monthly_sales AS (
    SELECT
        product_name,
        MONTH(sale_date) AS sale_month,
        SUM(quantity * price_per_unit - COALESCE(discount_applied, 0)) AS monthly_total
    FROM
        Sales
    WHERE
        YEAR(sale_date) = 2024
    GROUP BY
        product_name,
        MONTH(sale_date)
)
SELECT
    product_name,
    ROUND(SUM(CASE WHEN sale_month BETWEEN 1 AND 3 THEN monthly_total ELSE 0 END), 2) AS Q1_2024_Revenue,
    ROUND(SUM(CASE WHEN sale_month BETWEEN 4 AND 6 THEN monthly_total ELSE 0 END), 2) AS Q2_2024_Revenue,
    ROUND(SUM(CASE WHEN sale_month BETWEEN 7 AND 9 THEN monthly_total ELSE 0 END), 2) AS Q3_2024_Revenue,
    ROUND(SUM(CASE WHEN sale_month BETWEEN 10 AND 12 THEN monthly_total ELSE 0 END), 2) AS Q4_2024_Revenue
FROM
    monthly_sales
GROUP BY
    product_name
ORDER BY
    product_name ASC;

```

### Question 3: Customers with Decreasing Monthly Spend

Identify customers who have made purchases in at least two consecutive months in 2024, and whose total spend (revenue) in the current month was strictly less than their total spend in the previous month.

Return customer_id, customer_name, month_year (of the current month where spend decreased, format %Y-%m), current_month_spend, and previous_month_spend.

Only show instances where spending decreased.

Order the results by customer_id ascending, then by month_year ascending.

**Expected Output:**

| customer_id | customer_name | month_year | current_month_spend | previous_month_spend |
| ----------- | ------------- | ---------- | ------------------- | -------------------- |
| 1           | Alice Johnson | 2024-02    | 75.00               | 975.00               |
| 1           | Alice Johnson | 2024-04    | 120.00              | 290.00               |
| 2           | Bob Williams  | 2024-05    | 20.00               | 135.00               |

**Your Solution:**

```sql
WITH monthly_sales AS (
	SELECT
		customer_id,
		DATE_FORMAT(sale_date, '%Y-%m') AS month_year,
		MONTH(sale_date) AS month_numeric,
		SUM(price_per_unit * quantity - COALESCE(discount_applied, 0.00)) AS monthly_spend
	FROM
		Sales
	WHERE
		YEAR(sale_date) = 2024
	GROUP BY
		customer_id,
		DATE_FORMAT(sale_date, '%Y-%m'),
		MONTH(sale_date)
),
grouped_sales AS (
	SELECT
		ms.customer_id,
		c.customer_name,
		ms.month_year,
		ms.month_numeric AS current_month_numeric,
		ms.monthly_spend AS current_month_spend,
		LAG(ms.month_numeric, 1, NULL) OVER (PARTITION BY ms.customer_id ORDER BY ms.month_numeric) AS previous_month_numeric,
		LAG(ms.monthly_spend, 1, 0) OVER (PARTITION BY ms.customer_id ORDER BY ms.month_year) AS previous_month_spend
	FROM
		monthly_sales ms
	JOIN
		Customers c ON c.customer_id = ms.customer_id
)
SELECT
	customer_id,
	customer_name,
	month_year,
	current_month_spend,
	previous_month_spend
FROM
	grouped_sales
WHERE
	current_month_spend < previous_month_spend
	AND current_month_numeric - previous_month_numeric = 1
ORDER BY
	customer_id  ASC,
	current_month_numeric ASC;
```
