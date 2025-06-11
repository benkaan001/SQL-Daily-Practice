### Question 1: Identifying Feedback Trends by Source Channel

Analyze the feedback trends by `source_channel`. For this task:

1. Count the total number of feedback entries for each `source_channel`.
2. Calculate the percentage of feedback entries for each `source_channel` relative to the total feedback.
3. Include only `source_channel` values with more than 5 feedback entries.

**Expected Output:**

| source_channel | total_feedback | percentage_feedback |
| -------------- | -------------- | ------------------- |
| email          | 12             | 40.00%              |
| survey         | 9              | 30.00%              |
| social_media   | 9              | 30.00%              |

```sql
WITH total_feedback_count AS (
  SELECT
  	COUNT(*)  AS feedback_count
  FROM
  	feedback
)
SELECT
	source_channel,
    COUNT(feedback_id) AS total_feedback,
    CONCAT(
        ROUND(
            COUNT(feedback_id) / (SELECT feedback_count FROM total_feedback_count) * 100
        ,2)
    , '%') AS percentage_feedback
FROM
	feedback
GROUP BY
	source_channel
HAVING
	COUNT(feedback_id) > 5;
```
---

### Question 2: Analyzing Long Comments by Source Channel

Identify the distribution of `long_comments` across `source_channel`. For this task:

1. Count the total number of `long_comments` for each `source_channel`.
2. Calculate the average length of `feedback_text` (in characters) for `long_comments` in each `source_channel`.
3. Include only `source_channel` values with at least 2 `long_comments`.

**Expected Output:**

| source_channel | total_long_comments | avg_text_length |
| -------------- | ------------------- | --------------- |
| email          | 2                   | 167             |
| survey         | 3                   | 185             |

```sql
-- Write your solution here
```
---

### Question 3: Filtering and Categorizing Feedback

Find feedback entries that are **not short** and come from `social_media`. For this task:

1. Include `feedback_id`, `feedback_text`, `source_channel`, and `comment_category`.
2. Order the results by `feedback_id` in ascending order.

**Expected Output:**

| feedback_id | feedback_text                                                                                                                                                                   | source_channel | comment_category    |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ------------------- |
| 9           | Had some issues with billing, but they were resolved quickly.                                                                                                                   | social_media   | mid_length_comments |
| 15          | Terrible experience, the app crashes all the time.                                                                                                                              | social_media   | mid_length_comments |
| 16          | Staff is not very helpful, and the service is slow.                                                                                                                             | social_media   | mid_length_comments |
| 20          | Navigating the website was challenging, and the customer support response time was slower than expected. Improvements in these areas would greatly enhance the user experience. | social_media   | long_comments       |
| 29          | Service could be better, not fully satisfied.                                                                                                                                   | social_media   | mid_length_comments |

```sql
SELECT
    feedback_id,
    feedback_text,
    source_channel,
    comment_category
FROM
    feedback
WHERE
    comment_category NOT LIKE '%short%'
    AND source_channel = 'social_media'
ORDER BY
    feedback_id;
```
---
