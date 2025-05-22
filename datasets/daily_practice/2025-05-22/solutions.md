## Question 1: Multi-Year Launch Summary

For each company:
1. Count the total number of unique products launched (across all years).
2. Identify the earliest year and latest year in which they launched at least one product.
3. Include only companies with at least 2 unique products.

**Expected Output:**

| company_name | total_unique_products | earliest_year | latest_year |
|--------------|-----------------------|---------------|------------|
| Jeep         | 5                     | 2019          | 2020       |
| Honda        | 5                     | 2019          | 2020       |
| Chevrolet    | 4                     | 2019          | 2020       |
| Toyota       | 3                     | 2019          | 2020       |
| Ford         | 3                     | 2019          | 2020       |

**Your Solution:**
````sql
SELECT
	company_name,
    COUNT(DISTINCT product_name) AS total_unique_products,
    MIN(launch_year) AS earliest_yer,
    MAX(launch_year) AS latest_year
FROM
	product_launches
GROUP BY
    company_name
HAVING
	total_unique_products > 2
ORDER BY
	total_unique_products DESC;
````

---

## Question 2: Product Name Length Analysis

For each company:
1. Calculate the average length of its product names (in characters).
2. Determine the minimum and maximum product name lengths.
3. Show the total count of its unique products.
4. Filter out all companies whose average product name length is less than 6.0.

Order by average length (descending).

**Expected Output:**

| company_name | avg_length | min_length | max_length | total_products |
|--------------|-----------|------------|------------|----------------|
| Jeep         | 8.00      | 7          | 9          | 5              |
| Chevrolet    | 7.25      | 4          | 11         | 4              |
| Ford         | 6.33      | 4          | 9          | 3              |
| Toyota       | 6.00      | 5          | 7          | 3              |

**Your Solution:**
````sql
SELECT
	company_name,
    ROUND(AVG(LENGTH(product_name)), 2) AS avg_length,
    MIN(LENGTH(product_name)) AS min_length,
    MAX(LENGTH(product_name)) AS max_length,
    COUNT(DISTINCT product_name) AS total_products
FROM
	product_launches
GROUP BY
	company_name
HAVING
	AVG(LENGTH(product_name)) >= 6
ORDER BY
	AVG(LENGTH(product_name)) DESC;
````

---

## Question 3: Net Difference in Launches (2019 vs. 2020)

Calculate how many products each company launched in 2019 and 2020. Then:
1. Compute the net difference as `(products_2020 - products_2019)`.
2. Include all companies that launched at least one product in either year.
3. Sort by net difference descending, then by company name ascending.

**Expected Output:**

| company_name | net_difference |
|--------------|----------------|
| Chevrolet    | 2              |
| Jeep         | 1              |
| Ford         | -1             |
| Toyota       | -1             |
| Honda        | -3             |

**Your Solution:**
```sql
SELECT
	company_name,
    SUM(CASE WHEN launch_year = 2020 THEN 1 ELSE 0 END)
    - SUM(CASE WHEN launch_year = 2019 THEN 1 ELSE 0 END)
    AS net_difference
FROM
	product_launches
WHERE
	launch_year IN (2019, 2020)
GROUP BY
	company_name
ORDER BY
	net_difference DESC,
    company_name ASC;

--- CTE approach
WITH products_2020 AS (
  SELECT
  	company_name,
  	COUNT(*) AS 2020_product_count
  FROM
  	product_launches
  WHERE
  	launch_year = 2020
  GROUP BY
  	company_name
)
, products_2019 AS (
  SELECT
  	company_name,
  	COUNT(*) AS 2019_product_count
  FROM
  	product_launches
  WHERE
  	launch_year = 2019
  GROUP BY
  	company_name
)
SELECT
	p2.company_name,
    2020_product_count - 2019_product_count AS net_difference
FROM
	products_2020 p2
JOIN
	products_2019 p1 ON p2.company_name = p1.company_name
ORDER BY
	net_difference DESC,
    company_name ASC;
```