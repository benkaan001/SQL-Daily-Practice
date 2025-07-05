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
--- Write your solution here

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
--- Write your solution here

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
--- Write your solution here

```
