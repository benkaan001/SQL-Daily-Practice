## Question 1: Channel Performance and Comment Distribution

The marketing team wants to understand the performance and nature of feedback from different channels.

Write a query to analyze the distribution of comment categories (`short_comments`, `mid_length_comments`, `long_comments`) for each `source_channel`. Your output should include the channel, the total number of feedback entries for that channel, the count for each specific comment category, and the ratio of long comments to the total number of comments for that channel.

Order the results by the long comment ratio in descending order.

**Expected Output:**

| source_channel | total_feedback | short_comments | mid_length_comments | long_comments | long_comment_ratio |
| -------------- | -------------- | -------------- | ------------------- | ------------- | ------------------ |
| survey         | 16             | 8              | 5                   | 3             | 0.1875             |
| email          | 18             | 7              | 9                   | 2             | 0.1111             |
| social_media   | 20             | 9              | 10                  | 1             | 0.0500             |


**Your Solution:**
```sql
WITH grouped_feedback AS (

      SELECT 

        source_channel,

        COUNT(*) AS total_feedback,

        SUM(CASE WHEN comment_category = 'short_comments' THEN 1 ELSE 0 END) AS short_comments,

        SUM(CASE WHEN comment_category = 'mid_length_comments' THEN 1 ELSE 0 END) AS mid_length_comments,

        SUM(CASE WHEN comment_category = 'long_comments' THEN 1 ELSE 0 END) AS long_comments

      FROM 

        customer_feedback 

      GROUP BY 

        source_channel

    )

    SELECT

    source_channel,

        total_feedback,

        short_comments,

        mid_length_comments,

        long_comments,

        long_comments / total_feedback AS long_comment_ratio

    FROM 

    grouped_feedback

    ORDER BY 

    long_comment_ratio DESC;
```

---

## Question 2: Negative Keyword Hotspots

To prioritize improvements, the product team needs to identify the most frequently mentioned problems in detailed feedback.

Write a query that scans through feedback text categorized as `mid_length_comments` or `long_comments` for specific negative keywords: 'crash', 'slow', 'difficult', 'missing', and 'issue'. Count the number of feedback entries that mention each of these keywords. A single feedback entry should only be counted once per keyword, even if the keyword appears multiple times within that text.

The final output should list each keyword and its corresponding mention count, ordered from the most frequent to the least frequent.

**Expected Output:**

| keyword   | mention_count |
|-----------|---------------|
| crash     | 5             |
| slow      | 5             |
| issue     | 3             |
| difficult | 1             |
| missing   | 1             |


**Your Solution:**
```sql
WITH filtered_feedback AS (
  SELECT DISTINCT
  	feedback_text
  FROM
	customer_feedback
  WHERE
      comment_category IN ('mid_length_comments', 'long_comments')
)
(
SELECT
	'crash' AS keyword,
	SUM(CASE WHEN feedback_text LIKE '%crash%' THEN 1 ELSE 0 END) AS mention_count
FROM
	filtered_feedback
UNION ALL
SELECT
	'slow' AS keyword,
    SUM(CASE WHEN feedback_text LIKE '%slow%' THEN 1 ELSE 0 END) AS mention_count
FROM
	filtered_feedback
UNION ALL
SELECT
	'issue' AS keyword,
    SUM(CASE WHEN feedback_text LIKE '%issue%' THEN 1 ELSE 0 END) AS mention_count
FROM
	filtered_feedback
UNION ALL
SELECT
	'difficult' AS keyword,
    SUM(CASE WHEN feedback_text LIKE '%difficult%' THEN 1 ELSE 0 END) AS mention_count
FROM
	filtered_feedback
UNION ALL
SELECT
	'missing' AS keyword,
    SUM(CASE WHEN feedback_text LIKE '%missing%' THEN 1 ELSE 0 END) AS mention_count
FROM
	filtered_feedback
)
ORDER BY
	mention_count DESC;

```

---

## Question 3: Data Quality Check for Duplicate Feedback

The data integrity team suspects that there might be duplicate feedback entries in the dataset. They need a report that identifies these duplicates and summarizes their properties.

Write a query to find all feedback texts that appear more than once in the table. For each of these duplicate texts, calculate the total number of times it appears, the number of distinct source channels it came from, and the number of distinct comment categories it was assigned to.

This will help the team assess if the same feedback is being logged multiple times, potentially from different sources or with different classifications. Order the results by the occurrence count in descending order.

**Expected Output:**

| feedback_text                                  | occurrence_count | distinct_channels | distinct_categories |
|------------------------------------------------|------------------|-------------------|---------------------|
| Service could be better, not fully satisfied.  | 2                | 1                 | 1                   |
| Service needs enhancement for better satisfaction. | 2                | 1                 | 1                   |
| App crashes frequently, frustrating experience. | 2                | 1                 | 1                   |


**Your Solution:**
```sql
SELECT
  	feedback_text,
  	COUNT(*) AS occurance_count,
  	COUNT(DISTINCT source_channel) AS distinct_channels,
  	COUNT(DISTINCT comment_category) AS distinct_categories
FROM
  	customer_feedback
GROUP BY
  	feedback_text
HAVING
  	COUNT(*) > 1
ORDER BY
  	occurance_count DESC;
```
