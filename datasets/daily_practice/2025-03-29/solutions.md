## Question 1: Identify Rows with Multiple Missing Values
The data engineering team at YouTube wants to focus on rows in the `user_flags` dataset that have missing values in more than one column.  
List all rows where two or more columns contain missing values.  
Output the following columns: `user_firstname`, `user_lastname`, `video_id`, `flag_id`.

**Expected Output Format:**

| user_firstname | user_lastname | video_id      | flag_id |
| -------------- | ------------- | ------------- | ------- |
| Courtney       |               | dQw4w9WgXcQ   |         |
| Gina           | Korman      |               |         |
| Greg           |             | 5qap5aO4i9A   |         |
| Bob            |             |               | flag2   |

**Your Solution:**
```sql
-- Write your solution here
```

## Question 2: Identify Rows Missing Both Video ID and Flag ID
For proper data cleaning, filter out the rows where both `video_id` and `flag_id` are missing.  
List these rows by outputting `user_firstname`, `user_lastname`, `video_id`, and `flag_id`.

**Expected Output Format:**

| user_firstname | user_lastname | video_id | flag_id |
| -------------- | ------------- | -------- | ------- |
| Gina           | Korman      |          |         |
| Bob            |             |          | flag2   |

**Your Solution:**
```sql
-- Write your solution here
```

## Question 3: Data Completeness Percentage
Calculate the percentage of rows with complete data (i.e. no missing values in any column) and the percentage with incomplete data in the `user_flags` table.  
Output two columns: `status` (with values 'Complete' and 'Incomplete') and `percentage` (rounded to two decimal places).

**Expected Output Format:**

| status     | percentage |
| ---------- | ---------- |
| Complete   | 16.67      |
| Incomplete | 83.33      |

**Your Solution:**
```sql
-- Write your solution here
```