## Question 1: Percentage of Unsold Product Categories

Find what percentage of product categories (product_category) have **never** been sold (i.e., no sales for any product in that category).  
Round the result to two decimals.

**Expected Output:**

| pct_unsold_categories |
|----------------------|
| 00.00                |

**Your Solution:**
```sql
WITH all_categories AS (
  SELECT
      p.product_category,
      COUNT(p.product_id) AS product_count
  FROM
      products p
  GROUP BY
      p.product_category
), unsold_categories AS (
   SELECT
      p.product_category,
      COUNT(p.product_id) AS unsold_product_count
  FROM
      products p
  LEFT JOIN
  	  sales s ON s.product_id = p.product_id
  WHERE
  	  s.date_sold IS NULL
  GROUP BY
      p.product_category
)
SELECT
	ROUND(
      COALESCE(
      	COUNT(*) / SUM(CASE WHEN COALESCE(sc.unsold_product_count, 0) = ac.product_count THEN 1 ELSE 0 END) * 100
      	, 0)
      , 2) AS pct_unsold_categories
FROM
	unsold_categories sc
RIGHT JOIN
	all_categories ac ON ac.product_category = sc.product_category;
```

---

## Question 2: Top Selling Product Family by Units Sold

Find the product_family with the highest total units_sold.  
Output product_family and total_units_sold.

**Expected Output:**

| product_family | total_units_sold |
|---------------|------------------|
| CONSUMABLE    | 105              |

**Your Solution:**
```sql
SELECT
	p.product_family,
    SUM(s.units_sold) AS total_units_sold
FROM
	products p
LEFT JOIN
	sales s ON p.product_id = s.product_id
GROUP BY
	p.product_family
ORDER BY
	total_units_sold DESC
LIMIT 1;
```

---

## Question 3: Brand Diversity by Product Family

For each product_family, count the number of distinct brand_name values.  
Output product_family and brand_count.

**Expected Output:**

| product_family | brand_count |
|---------------|------------|
| GADGET        | 3          |
| CONSUMABLE    | 3          |
| ACCESSORY     | 1          |

**Your Solution:**
```sql
SELECT
	product_family,
    COUNT(DISTINCT brand_name) AS brand_count
FROM
	products
GROUP BY
	product_family
ORDER BY 
	brand_count DESC;
```

---
