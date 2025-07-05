### Question 1: Top 3 Most Engaged Users

Define "engagement score" for a user as (total likes received by their posts) * 1 + (total comments received by their posts) * 2.

Find the top 3 users with the highest engagement score.

Return user_id, username, and engagement_score.

If there's a tie in engagement_score, order by user_id ascending.

Only include users who have at least one post.

**Expected Output:**

| user_id | username | engagement_score |
| ------- | -------- | ---------------- |
| 103     | ChrisM   | 10               |
| 101     | AlexG    | 9                |
| 105     | EthanK   | 6                |


**Your Solution:**

```sql
WITH scores AS (
	SELECT
		u.user_id,
		u.username,
		SUM(CASE WHEN i.interaction_type = 'Like' THEN 1 ELSE 0 END) AS like_score,
		SUM(CASE WHEN i.interaction_type = 'Comment' THEN 1 ELSE 0 END) * 2 AS comment_score
	FROM
		Posts p
	LEFT JOIN
		Interactions i ON i.post_id = p.post_id
	LEFT JOIN
		Users u ON u.user_id = p.user_id
	GROUP BY
		u.user_id,
		u.username
),
ranked_scores AS (
	SELECT
		user_id,
		username,
		like_score + comment_score AS engagement_score,
		DENSE_RANK() OVER (ORDER BY like_score + comment_score DESC, user_id ASC) AS engagement_rank
	FROM
		scores

)
SELECT
	user_id,
	username,
	engagement_score
FROM
	ranked_scores
WHERE
	engagement_rank <= 3;

```

### Question 2: Posts with Negative Engagement (Ratio of Likes to Views)

Identify posts that have a "negative engagement ratio" defined as (total likes for the post / total views for the post) < 0.005.

Only consider posts that have at least one like and at least 100 views.

Return post_id, post_text, username of the poster, views_count, and likes_count.

If post_text is NULL, display '(No Text)' for post_text.

Order the results by views_count ascending, then by post_id ascending.

**Expected Output:**

| post_id | post_text                             | username | views_count | likes_count |
| ------- | ------------------------------------- | -------- | ----------- | ----------- |
| 12      | Harvesting tomatoes!                  | DanaW    | 300         | 1           |
| 5       | New photography series coming soon!   | BellaR   | 800         | 2           |
| 1       | Loving the new data science trends!   | AlexG    | 1500        | 3           |
| 2       | My thoughts on effective programming. | AlexG    | 2000        | 1           |
| 3       | Quick update from my workshop.        | AlexG    | 3000        | 1           |
| 8       | A deep dive into AI ethics.           | ChrisM   | 5000        | 2           |
| 9       | Future of tech is here.               | ChrisM   | 6000        | 3           |
| 10      | Just published a new paper.           | ChrisM   | 7000        | 1           |
| 13      | My daily fitness routine.             | EthanK   | 8000        | 5           |
| 14      | Healthy eating guide.                 | EthanK   | 9000        | 1           |


**Your Solution:**

```sql
WITH likes AS (
	SELECT
		post_id,
		SUM(CASE WHEN interaction_type = 'Like' THEN 1 ELSE 0 END) AS likes_count
	FROM
		Interactions
	GROUP BY
		post_id
),
engagements AS (
	SELECT
		p.post_id,
		p.post_text,
		u.username,
		p.views_count,
		l.likes_count
	FROM
		likes l
	JOIN
		Posts p ON p.post_id = l.post_id
	JOIN
		Users u ON u.user_id = p.user_id
	WHERE
		l.likes_count >= 1
		AND p.views_count >= 100
		AND l.likes_count * 1.0 / p.views_count < 0.005
)
SELECT
	post_id,
	COALESCE(post_text, '(No Text)') AS post_text,
	username,
	views_count,
	likes_count
FROM
	engagements
ORDER BY
	views_count ASC,
	post_id ASC;

```

### Question 3: Users with Posts but No Interactions in June 2025

Find users who have posted at least one post in June 2025 but have not received any 'Like' or 'Comment' interactions on any of their posts in June 2025.

Return user_id, username, and number_of_posts_in_june.

Order the results by user_id ascending.

**Expected Output:**

| **user_id** | **username** | **number_of_posts_in_june** |
| ----------------- | ------------------ | --------------------------------- |
| 104               | DanaW              | 1                                 |
| 106               | FionaL             | 2                                 |

**Your Solution:**

```sql
WITH june_posts AS (
	SELECT
		user_id,
		COUNT(post_id) AS number_of_posts_in_june
	FROM
		Posts
	WHERE
		post_date BETWEEN '2025-06-01' AND '2025-06-30'
	GROUP BY
		user_id
	HAVING
		COUNT(post_id) >= 1
),
users_with_interactions AS (
	SELECT
		p.user_id
	FROM
		Interactions i
	JOIN
		Posts p ON p.post_id = i.post_id
	WHERE
		i.interaction_date BETWEEN '2025-06-01' AND '2025-06-30'
)
SELECT
	u.user_id,
	u.username,
	jp.number_of_posts_in_june
FROM
	june_posts jp
JOIN
	Users u ON jp.user_id = u.user_id
WHERE
	u.user_id NOT IN (SELECT user_id FROM users_with_interactions)
ORDER BY
	u.user_id ASC;
```
