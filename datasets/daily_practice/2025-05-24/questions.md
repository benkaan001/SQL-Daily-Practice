### Question 1: Call Counts By User Status

1. For each user status, calculate the total number of calls made.
2. Count how many distinct users in each status made at least one call.
3. Sort the result by total calls (descending), then by status (ascending).

**Expected Output:**

| status   | total_calls | distinct_users |
|----------|------------|----------------|
| free     | 15         | 8              |
| paid     | 15         | 6              |
| inactive | 10         | 6              |

**Your Solution:**
````sql
-- Write your solution here
````

---

### Question 2: Monthly Calling Patterns

1. Group the calls into March 2020 and April 2020.
2. For each month, show:
   - Total calls
   - Number of distinct callers
   - Average calls per active user (total calls / distinct callers)
3. Sort by month in ascending order (March first, then April).

**Expected Output:**

| month  | total_calls | distinct_users | avg_calls_per_user |
|--------|------------|----------------|---------------------|
| March  | 20         | 15             | 1.33               |
| April  | 20         | 16             | 1.25               |

**Your Solution:**
````sql
-- Write your solution here
````

---

### Question 3: Top 2 Users in Each Company

1. For each `company_id`, rank users by their total call counts in descending order.
2. Keep ties within the same rank.
3. Return only the top two ranks per company.

**Expected Output:**

| company_id | user_id | user_rank |
|------------|---------|-----------|
| 1          | 1859    | 1         |
| 1          | 1525    | 2         |
| 1          | 1854    | 2         |
| 2          | 1181    | 1         |
| 2          | 1891    | 1         |
| 2          | 1162    | 1         |
| 2          | 1857    | 4         |
| 2          | 1910    | 4         |
| 3          | 1093    | 1         |
| 3          | 1503    | 1         |

**Your Solution:**
````sql
-- Write your solution here
