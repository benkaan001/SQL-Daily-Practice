## Puzzle: The "Ratio" Detector

**The Scenario:** On social media, if a post has significantly more comments than likes, it's often a sign of controversy (getting "ratioed").

**Your Task:** Write a query to find all posts where the number of `COMMENT`s is at least **double** the number of `LIKE`s.

The output should show `post_id`, `like_count`, `comment_count`, and the `ratio` (comments/likes).

| **post_id** | **like_count** | **comment_count** | **ratio** |
| ----------------- | -------------------- | ----------------------- | --------------- |
| 2                 | 1                    | 3                       | 3.00            |

### Tips

1. **Aggregate:** Group by `post_id` and count interactions by type.
2. **Filter:** `HAVING comment_count >= like_count * 2`.

**Your Solution:**

```sql
-- Write your solution here
```
