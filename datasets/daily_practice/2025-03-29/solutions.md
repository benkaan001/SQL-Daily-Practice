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
SELECT
	*
FROM
	user_flags
WHERE
	(user_firstname IS NULL) + (user_lastname IS NULL) + (video_id IS NULL) + (flag_id IS NULL) > 1;
```

```sql
SELECT
  user_firstname,
  user_lastname,
  video_id,
  flag_id
FROM
  (
    SELECT
      *,
      (CASE WHEN user_firstname IS NULL THEN 1 ELSE 0 END) +
      (CASE WHEN user_lastname IS NULL THEN 1 ELSE 0 END) +
      (CASE WHEN video_id IS NULL THEN 1 ELSE 0 END) +
      (CASE WHEN flag_id IS NULL THEN 1 ELSE 0 END) AS null_count
 	FROM
      	user_flags
  )t
WHERE
	null_count > 1;
```


## Question 2: Identify Rows Missing Both Video ID and Flag ID
For proper data cleaning, filter out the rows where both `video_id` and `flag_id` are missing.  
List these rows by outputting `user_firstname`, `user_lastname`, `video_id`, and `flag_id`.

**Expected Output Format:**

| user_firstname | user_lastname | video_id | flag_id |
| -------------- | ------------- | -------- | ------- |
| Gina           | Korman      |          |         |


**Your Solution:**
```sql
SELECT
  user_firstname,
  user_lastname,
  video_id,
  flag_id
FROM
  user_flags
WHERE
  video_id IS NULL and flag_id IS NULL;
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
WITH incomplete_rows AS (
    SELECT
        COUNT(*) AS incomplete_count
    FROM
        user_flags
    WHERE
        user_firstname IS NULL
        OR user_lastname IS NULL
        OR video_id IS NULL
        OR flag_id IS NULL
), complete_rows AS (
    SELECT
        COUNT(*) AS complete_count
    FROM
        user_flags
)
SELECT
    'Complete' AS status,
    ROUND(
      ((SELECT complete_count FROM complete_rows) - (SELECT incomplete_count FROM incomplete_rows)) 
      / (SELECT complete_count FROM complete_rows) * 100
    , 2) AS percentage

UNION ALL
SELECT 
    'Incomplete' AS status,
    ROUND(
      (SELECT incomplete_count FROM incomplete_rows) / (SELECT complete_count FROM complete_rows) * 100
    , 2) AS percentage;
```