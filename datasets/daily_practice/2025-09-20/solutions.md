## Puzzle: The Community Reputation Score

**The Scenario:** As a community manager for a developer Q&A platform, you need to calculate a "reputation score" for each user. This score is a key indicator of a user's contribution and expertise within the community.

**Your Task:** Write a query that calculates the final `reputation_score` for each user based on the following rules:

* **+15 points** for each answer a user wrote that was accepted by the question's author.
* **+10 points** for every upvote received on their answers (each point in `score` on an answer is one upvote).
* **-2 points** for every downvote received on their answers (each negative point in `score` is one downvote, e.g., a score of -3 means 3 downvotes).
* **+5 points** for each question a user asked that received an accepted answer.

The final report should list the `user_id` and their total calculated `reputation_score`, ordered by the score in descending order.

| **user_id** | **reputation_score** |
| ----------------- | -------------------------- |
| 101               | 294                        |
| 102               | 115                        |
| 104               | 50                         |
| 103               | 25                         |

### Tips for Approaching the Problem

1. **Break It Down:** It's best to calculate the points for each rule separately. Think of using a Common Table Expression (CTE) for each scoring component.
2. **Points from Answers:**
   * **Accepted Answers:** Join the `forum_posts` table to itself to link questions to answers. Find where an answer's `post_id` matches the question's `accepted_answer_id`.
   * **Upvotes/Downvotes:** Filter for `post_type = 'ANSWER'`. Use a `CASE` statement to separate positive (`score > 0`) and negative (`score < 0`) scores, then multiply by the correct point values (+10 and -2).
3. **Points from Questions:** Filter for `post_type = 'QUESTION'` where `accepted_answer_id` is NOT NULL. Award 5 points for each such question.
4. **Combine the Scores:** Create CTEs for each of the above calculations, aggregated by `user_id`. Then, `UNION ALL` these separate scores into a single list of users and their points from different activities. Finally, perform a `SUM()` and `GROUP BY user_id` on this unified list to get the final score.

**Your Solution:**

```sql
WITH acceptance_scores AS (
	SELECT
		answers.user_id,
		15 AS reputation_score
	FROM
		forum_posts questions
	JOIN
		forum_posts answers ON questions.accepted_answer_id = answers.post_id
	WHERE
		answers.post_type  = 'ANSWER'
		AND questions.post_type = 'QUESTION'
),
upvote_scores AS (
	SELECT
		user_id,
		SUM(CASE WHEN score > 0 THEN score * 10 ELSE score * 2 END) AS repuation_score
	FROM
		forum_posts
	WHERE
		post_type = 'ANSWER'
	GROUP BY
		user_id
),
answer_scores AS (
	SELECT
		user_id,
		5 AS reputation_score
	FROM
		forum_posts
	WHERE
		post_type = 'QUESTION'
		AND accepted_answer_id IS NOT NULL

),
all_scores AS (
	SELECT
		*
	FROM
		acceptance_scores
	UNION ALL
	SELECT
		*
	FROM
		upvote_scores
	UNION ALL
	SELECT
		*
	FROM
		answer_scores
)
SELECT
	user_id,
	SUM(reputation_score) AS reputation_score
FROM
	all_scores
GROUP BY
	user_id
ORDER BY
	reputation_score DESC;
```
