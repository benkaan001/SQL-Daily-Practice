## Puzzle: The Jaccard Similarity (Recommendation Engine)

**The Scenario:** You are building the "Users Similar To You" feature for a movie streaming platform. To recommend movies accurately, you need to mathematically quantify how similar two users' tastes are. The standard data science metric for comparing sets of data is the  **Jaccard Similarity Index** .

The formula is: **Intersection / Union**

* **Intersection:** The number of movies *both* users liked.
* **Union:** The total number of unique movies liked by *either* user. (Mathematically: `Likes by A + Likes by B - Intersection`).

**Your Task:** Calculate the Jaccard Similarity between our target user ( **User 101** ) and every other user in the database who shares at least one liked movie with them.

The final report should show the `target_user`, the `comparison_user`, the `shared_likes` (Intersection), the `total_unique_likes` (Union), and the calculated `jaccard_similarity` (rounded to 2 decimal places).

Order the results by `jaccard_similarity` descending, then by `comparison_user` ascending.

**Expected Output:**

| **target_user** | **comparison_user** | **shared_likes** | **total_unique_likes** | **jaccard_similarity** |
| --------------------- | ------------------------- | ---------------------- | ---------------------------- | ---------------------------- |
| 101                   | 102                       | 5                      | 5                            | 1.00                         |
| 101                   | 103                       | 4                      | 6                            | 0.67                         |
| 101                   | 106                       | 5                      | 10                           | 0.50                         |
| 101                   | 104                       | 2                      | 5                            | 0.40                         |

*(Note: User 105 is excluded because they share 0 movies with User 101. User 106 shares all 5 of User 101's movies, but because User 106 liked 10 movies in total, their union is very large, diluting their similarity score to 0.50).*

### Tips for Approaching the Problem

1. **Calculate Total Likes per User:** The "Union" formula requires knowing how many total movies each user likes. Create a Common Table Expression (CTE) that calculates `COUNT(movie_id)` for every `user_id`. Let's call this `user_like_counts`.
2. **Find the Intersection (Shared Likes):** Create a second CTE to find the overlapping movies. You can `JOIN` the `user_movie_likes` table to itself.
   * Alias one table as `t1` (where `user_id = 101`) and the other as `t2` (where `user_id != 101`).
   * The join condition is `t1.movie_id = t2.movie_id`.
   * Group by `t2.user_id` and `COUNT()` the rows to get the `shared_likes`.
3. **Calculate the Union and Similarity:** In your final `SELECT` statement, query from your intersection CTE.
   * `JOIN` your `user_like_counts` CTE  *twice* —once to get the total likes for User 101, and once to get the total likes for the comparison user.
   * The `total_unique_likes` is `(total_likes_101 + total_likes_comparison - shared_likes)`.
   * The `jaccard_similarity` is `shared_likes / total_unique_likes`.

**Your Solution:**

```sql
-- Write your solution here
```
