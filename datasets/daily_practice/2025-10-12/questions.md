## Puzzle: The "Preview to Watch" Conversion Funnel

**The Scenario:** As a product analyst for a streaming service, you need to measure the effectiveness of the new "content preview" feature. The key question is: how often does watching a preview lead a user to watch the full content shortly after?

**Your Task:** Write a query to identify every successful "preview conversion." A conversion is defined as a `PREVIEW_WATCH` event that is followed by a `FULL_WATCH` event for the **same user** and the **same `content_id`** within a  **1-hour window** .

The final report should show the `user_id`, `session_id`, `content_id`, the `preview_start_time`, the `full_watch_start_time`, and the calculated `time_to_convert_minutes`. If a user watches multiple previews for the same content before a full watch, match the full watch to the *most recent* preview.

| **user_id** | **session_id** | **content_id** | **preview_start_time** | **full_watch_start_time** | **time_to_convert_minutes** |
| ----------------- | -------------------- | -------------------- | ---------------------------- | ------------------------------- | --------------------------------- |
| 101               | sess_A               | 1001                 | 2023-10-12 10:00:00.000      | 2023-10-12 10:05:00.000         | 5.00                              |
| 105               | sess_E               | 1004                 | 2023-10-12 15:05:00.000      | 2023-10-12 15:10:00.000         | 5.00                              |
| 106               | sess_F               | 1005                 | 2023-10-12 16:00:00.000      | 2023-10-12 16:08:00.000         | 8.00                              |

### Tips for Approaching the Problem

1. **Isolate Event Types:** The easiest way to start is by creating two separate Common Table Expressions (CTEs): one for all `PREVIEW_WATCH` events and another for all `FULL_WATCH` events.
2. **Connect Previews to Potential Conversions:** `JOIN` the `previews` CTE to the `full_watches` CTE. The join conditions are key:
   * `ON previews.user_id = full_watches.user_id`
   * `AND previews.content_id = full_watches.content_id`
   * `AND previews.event_timestamp < full_watches.event_timestamp` (ensuring the watch happens *after* the preview).
3. **Find the Correct Preview:** The join above might match a single `FULL_WATCH` to multiple prior `PREVIEW_WATCH` events. The puzzle asks you to match it to the *most recent* preview. To do this, you can use the `ROW_NUMBER()` window function. After your join, partition by the `full_watch` event (`log_id` is a good unique identifier) and order by the `preview_timestamp DESC`. This will assign a `1` to the most recent preview before each full watch.
4. **Final Filtering and Calculation:** In your final `SELECT` statement, query from the CTE where you created the row number.
   * Filter for rows where your row number is `1`.
   * Filter for rows where the time difference between the full watch and the preview is less than 60 minutes.
   * Calculate the `time_to_convert_minutes`.

**Your Solution:**

```sql
-- Write your solution here
```
