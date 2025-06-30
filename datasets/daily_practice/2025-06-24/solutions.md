### Question 1: Sentiment Analysis of Product Reviews

For each product category, determine the overall "sentiment" based on review ratings.

A rating of 4 or 5 is considered 'Positive', 3 is 'Neutral', and 1 or 2 is 'Negative'.

Calculate the percentage of 'Positive', 'Neutral', and 'Negative' reviews for each category.

If a category has no reviews of a certain sentiment type, its percentage should be 0.00.

Round percentages to two decimal places.

Output category, positive_percentage, neutral_percentage, and negative_percentage.

Order the results by category ascending.

**Expected Output:**
| category          | posive_percentage | neutral_percentage | negavtive_percentage |
| ----------------- | ----------------- | ------------------ | -------------------- |
| Books             | 100.00            | 0.00               | 0.00                 |
| Electronics       | 69.23             | 15.38              | 15.38                |
| Food & Beverage   | 100.00            | 0.00               | 0.00                 |
| Office Supplies   | 83.33             | 16.67              | 0.00                 |
| Sports & Outdoors | 100.00            | 0.00               | 0.00                 |
| Wearables         | 33.33             | 33.33              | 33.33                |


**Your Solution:**

```sql
WITH counts AS (
	SELECT
		p.category,
		COUNT(r.rating) AS rating_count,
		SUM(CASE WHEN r.rating >= 4 THEN 1 ELSE 0 END) AS positive_count,
		SUM(CASE WHEN r.rating = 3 THEN 1 ELSE 0 END) AS neutral_count,
		SUM(CASE WHEN r.rating <= 2 THEN 1 ELSE 0 END) AS negative_count
	FROM
		Products p
	JOIN
		Reviews r ON p.product_id = r.product_id
	GROUP BY
		p.category
)
SELECT
	category,
	ROUND(IFNULL(positive_count * 100.00 / rating_count, 0), 2) AS positive_percentage,
	ROUND(IFNULL(neutral_count * 100.00 / rating_count, 0), 2) AS neutral_percentage,
	ROUND(IFNULL(negative_count * 100.00 / rating_count, 0), 2) AS negative_percentage
FROM
	counts
ORDER BY
	category;

```

### Question 2: Top N Most Reviewed Products per Category

Find the top 2 most reviewed products within each product category.

If there are ties in the number of reviews, order by product_name alphabetically.

Return category, product_name, number_of_reviews, and rank_in_category.

If a category has fewer than 2 products, or fewer than 2 distinct products with reviews, show all of them.

Order the results by category ascending, then by rank_in_category ascending.

**Expected Output:**
| category          | product_name               | number_of_reviews | rank_in_category |
| ----------------- | -------------------------- | ----------------- | ---------------- |
| Books             | Cookbook: Italian Classics | 2                 | 1                |
| Electronics       | Laptop Pro X               | 6                 | 1                |
| Electronics       | Mechanical Keyboard        | 3                 | 2                |
| Food & Beverage   | Organic Coffee Beans       | 3                 | 1                |
| Office Supplies   | Ergonomic Chair            | 3                 | 1                |
| Office Supplies   | Desk Lamp Smart            | 3                 | 1                |
| Sports & Outdoors | Yoga Mat Pro               | 2                 | 1                |
| Wearables         | Smartwatch Gen 5           | 3                 | 1                |

**Your Solution:**

```sql
WITH review_ranking AS (
	SELECT
		p.category,
		p.product_name,
		COUNT(r.review_id) AS number_of_reviews,
		DENSE_RANK() OVER (PARTITION BY p.category ORDER BY COUNT(r.review_id) DESC, p.product_name ASC) AS rank_in_category
	FROM
		Products p
	JOIN
		Reviews r ON p.product_id = r.product_id
	GROUP BY
		p.category,
		p.product_name
)
SELECT
	category,
	product_name,
	number_of_reviews,
	rank_in_category
FROM
	review_ranking
WHERE
	rank_in_category <= 2
ORDER BY
	category,
	rank_in_category;

```

### Question 3: Customers with Significant Rating Changes

Identify customers who have reviewed the same product more than once and whose latest rating for that product is significantly lower (a drop of 2 or more points) than their earliest rating for the same product.

Return customer_id, product_name, earliest_rating, latest_rating, and review_date_earliest, review_date_latest.

Order the results by customer_id ascending, then by product_name ascending.

**Expected Output:**

| **customer_id** | **product_name** | **earliest_rating** | **latest_rating** | **review_date_earliest** | **review_date_latest** |


**Your Solution:**

```sql
WITH ranked_reviews AS (
    SELECT
        r.customer_id,
        r.product_id,
        p.product_name,
        r.rating,
        r.review_date,
        ROW_NUMBER() OVER (PARTITION BY r.customer_id, r.product_id ORDER BY r.review_date ASC) AS rn_ascending,
        ROW_NUMBER() OVER (PARTITION BY r.customer_id, r.product_id ORDER BY r.review_date DESC) AS rn_descending,
        COUNT(r.review_id) OVER (PARTITION BY r.customer_id, r.product_id) AS review_count_for_product
    FROM
        Reviews r
    JOIN
        Products p ON r.product_id = p.product_id
),
early_late_reviews AS (
    SELECT
        customer_id,
       	product_id,
        product_name,
        MAX(CASE WHEN rn_ascending = 1 THEN rating END) AS earliest_rating,
        MAX(CASE WHEN rn_ascending = 1 THEN review_date END) AS review_date_earliest,
        MAX(CASE WHEN rn_descending = 1 THEN rating END) AS latest_rating,
        MAX(CASE WHEN rn_descending = 1 THEN review_date END) AS review_date_latest,
        MAX(review_count_for_product) AS total_reviews_for_product
    FROM
        ranked_reviews
    GROUP BY
        customer_id,
        product_id,
        product_name
    HAVING
        MAX(review_count_for_product) > 1
)
SELECT
    customer_id,
    product_name,
    earliest_rating,
    latest_rating,
    review_date_earliest,
    review_date_latest
FROM
    early_late_reviews
WHERE
    latest_rating <= earliest_rating - 2
ORDER BY
    customer_id,
    product_name;

```
