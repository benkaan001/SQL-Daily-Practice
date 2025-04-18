## Question 1: Percentage of Transactions on First and Last Day of Promotion

For each promotion, calculate the percentage of total transactions (by units_sold) that occurred on the first and last day of the promotion.  
Output promotion_id, pct_first_day, pct_last_day (rounded to 2 decimals).

**Expected Output:**

| promotion_id | pct_first_day | pct_last_day |
| ------------ | ------------- | ------------ |
| 1            | 11.69         | 22.08        |
| 2            | 56.14         | 40.35        |
| 3            | 19.35         | 0.00         |
| 4            | 0.00          | 0.00         |
| 5            | 0.00          | 0.00         |

**Your Solution:**
```sql
-- Write your solution here
```

---

## Question 2: Top Product by Units Sold per Promotion

For each promotion, find the product_id with the highest total units_sold.  
If there is a tie, return all such product_ids.  
Output promotion_id, product_id, total_units_sold.

**Expected Output:**

| promotion_id | product_id | total_units_sold |
| ------------ | ---------- | ---------------- |
| 1            | 1          | 16               |
| 2            | 1          | 12               |
| 2            | 6          | 12               |
| 3            | 3          | 23               |
| 4            | 5          | 8                |
| 5            | 9          | 20               |


**Your Solution:**
```sql
-- Write your solution here
```

---

## Question 3: Promotion Effectiveness by Media Type

For each media_type, calculate the average units_sold per promotion (across all promotions of that type).  
Output media_type, avg_units_sold_per_promo (rounded to 2 decimals).

**Expected Output:**

| media_type | avg_units_sold_per_promo |
|------------|-------------------------|
| Internet   | 77.00                   |
| Broadcast  | 32.50                   |
| Print      | 31.00                   |
| Outdoor    | 20.00                   |

**Your Solution:**
```sql
-- Write your solution here
```

