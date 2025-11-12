## Puzzle: The "Fast Start" Badge

**The Scenario:** A "Fast Start" badge is awarded to new users who show high engagement shortly after their first post. This helps to encourage and retain new creative members of the community.

**Your Task:** Identify all users who should be awarded the "Fast Start" badge. The badge is awarded to a user who receives at least **10** `LIKE_GIVEN` events (where they are the `liked_user_id` specified in the JSON) within **7 days** of their *first-ever* `POST_CREATED` event.

The report should show the `user_id` of the earner and their `first_post_timestamp`.

| user_id | first_post_timestamp |

| 102 | 2023-11-03 10:00:00.000 |

### Tips for Approaching the Problem

1. **Find First Post Times:** The first step is to find the timestamp of each user's *first-ever* `POST_CREATED` event. A Common Table Expression (CTE) using `MIN(event_timestamp)` grouped by `user_id` (and filtered for `event_type = 'POST_CREATED'`) is a good way to get this.
2. **Isolate 'Like Received' Events:** The second step is to get a clean list of all `LIKE_GIVEN` events. Since the `liked_user_id` is inside a JSON field, you will need to extract it. Use the function `JSON_UNQUOTE(JSON_EXTRACT(details, '$.liked_user_id'))` or the shorthand `details->>'$.liked_user_id'`.
3. **Join Posts and Likes:** `JOIN` your `first_post` CTE with your `likes` CTE on `user_id`.
4. **Apply the 7-Day Window:** In your `WHERE` clause, you must filter the likes to include only those that occurred *after* the `first_post_timestamp` and *before* the 7-day deadline (`like_timestamp <= TIMESTAMPADD(DAY, 7, first_post_timestamp)`).
5. **Count, Group, and Filter:** `GROUP BY` the `user_id` (and their `first_post_timestamp`). Use `COUNT(*)` to get the number of likes. Finally, use a `HAVING` clause to keep only the users where `COUNT(*) >= 10`.

**Your Solution:**

```sql
WITH first_posts AS (
    SELECT
        user_id,
        MIN(event_timestamp) AS first_post_timestamp
    FROM
        user_engagement_events
    WHERE
        event_type = 'POST_CREATED'
    GROUP BY
        user_id
),
likes_received AS (
    SELECT
        event_timestamp AS like_timestamp,
        details->>'$.liked_user_id' AS liked_user_id
    FROM
        user_engagement_events
    WHERE
        event_type = 'LIKE_GIVEN'
        AND details->>'$.liked_user_id' IS NOT NULL
)
SELECT
    fp.user_id,
    fp.first_post_timestamp
FROM
    first_posts fp
JOIN
    likes_received lr ON fp.user_id = lr.liked_user_id
WHERE -- 7-day window filter
    lr.like_timestamp > fp.first_post_timestamp
    AND lr.like_timestamp <= TIMESTAMPADD(DAY, 7, fp.first_post_timestamp)
GROUP BY
    fp.user_id,
    fp.first_post_timestamp
HAVING
    COUNT(*) >= 10;
```
