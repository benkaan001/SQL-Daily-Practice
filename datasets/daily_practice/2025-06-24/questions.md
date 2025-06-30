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
--- Write your solution here

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
--- Write your solution here

```

### Question 3: Customers with Significant Rating Changes

Identify customers who have reviewed the same product more than once and whose latest rating for that product is significantly lower (a drop of 2 or more points) than their earliest rating for the same product.

Return customer_id, product_name, earliest_rating, latest_rating, and review_date_earliest, review_date_latest.

Order the results by customer_id ascending, then by product_name ascending.

**Expected Output:**

| **customer_id** | **product_name** | **earliest_rating** | **latest_rating** | **review_date_earliest** | **review_date_latest** |


**Your Solution:**

```sql
--- Write your solution here

```
