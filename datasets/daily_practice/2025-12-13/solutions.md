## Puzzle: The "Golden Hour" Adoption

**The Scenario:** The product team believes that if a new user interacts with three specific core features— **Search, Filter, and Wishlist** —within the first hour of creating their account, they are highly likely to become a long-term retained user.

**Your Task:** Write a query to identify these "Golden Hour" users. Find all `user_id`s who performed *all three* specific actions (`SEARCH`, `FILTER`, `ADD_TO_WISHLIST`) within **60 minutes** of their `ACCOUNT_CREATED` event.

The report should show the `user_id` and their `account_created_time`.

| **user_id** | **account_created_time** |
| ----------------- | ------------------------------ |
| 101               | 2023-12-13 09:00:00            |
| 104               | 2023-12-13 12:00:00            |

### Tips for Approaching the Problem

1. **Pivot or Self-Join:** You need to check for the existence of four distinct events (`ACCOUNT_CREATED` + the 3 features). A common approach is to group by `user_id` and use conditional aggregation (`MIN(CASE WHEN event_type = ... THEN timestamp END)`) to flatten the timestamps into one row per user.
2. **Calculate Differences:** Once you have `created_at`, `search_at`, `filter_at`, and `wishlist_at` in the same row, you can easily check if the latter three are all non-null and within 60 minutes of `created_at`.
3. **Alternative:** Join the table to itself multiple times (one for each event type), matching on `user_id` and the time constraint.

**Your Solution:**

```sql
-- Write your solution here
```
