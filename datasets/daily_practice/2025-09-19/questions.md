## Puzzle: First Feature Adoption Impact

**The Scenario:** As a product manager, you want to understand if the first feature a user interacts with (after logging in) has an impact on their overall engagement, measured by their average session length.

**Your Task:** Write a query that determines the `first_feature_adopted` for each user. Then, for each of these "first features," calculate the number of `unique_users` who adopted it first and their subsequent `avg_session_length_minutes` across all of their sessions.

A "first feature" is the first `feature_name` a user interacts with that is *not* 'login' or 'logout' across their entire history. A session's length is the time difference between its earliest and latest event.

The final report should be ordered by `first_feature_adopted` alphabetically.

| **first_feature_adopted** | **unique_users** | **avg_session_length_minutes** |
| ------------------------------- | ---------------------- | ------------------------------------ |
| dashboard                       | 2                      | 37.50                                |
| reporting                       | 1                      | 30.00                                |
| settings                        | 1                      | 10.00                                |

### Tips for Approaching the Problem

1. **Isolate Core Feature Events:** Start by filtering out 'login' and 'logout' events, as they aren't considered "features" for this analysis.
2. **Find the First Event for Each User:** The key is to identify the very first feature event for each user across their entire history. A window function like `ROW_NUMBER()` or `FIRST_VALUE()` partitioned by `user_id` and ordered by `event_timestamp` is perfect for this.
3. **Calculate Session Durations:** In a separate step or CTE, calculate the duration of each session. You can do this by grouping by `session_id` and finding the `MIN()` and `MAX()` `event_timestamp`.
4. **Join and Aggregate:**
   * Join your "first feature" results (from step 2) with the session duration data.
   * Finally, group by the `first_feature_adopted` and calculate the `COUNT(DISTINCT user_id)` and `AVG(session_duration)`.

**Your Solution:**

```sql
-- Write your solution here
```
