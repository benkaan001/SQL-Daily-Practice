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
-- Write your solution here
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
-- Write your solution here
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
````sql
-- Write your solution here
