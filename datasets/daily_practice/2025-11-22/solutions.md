## Puzzle: The Frictionless Conversion Rate

**The Scenario:** As a conversion rate optimization (CRO) specialist, you want to identify which specific user journeys are "frictionless." A frictionless journey is defined as a conversion that follows the ideal, pre-defined path without any deviations (such as viewing external pages or blog posts).

**Your Task:** Write a query to find all sessions that achieved `conversion_goal = 'Goal_A'` by following the **exact** prescribed sequence of three events, with *no other events of any type* occurring between them.

**The Prescribed Sequence (Path A):**

1. `VIEW_PAGE` on `/home`
2. Followed immediately by `CLICK_CTA` on `/home`
3. Followed immediately by `VIEW_PAGE` on `/checkout`
4. Followed immediately by `PURCHASE` on `/checkout`

The final report should show the `session_id`, `user_id`, the `purchase_timestamp`, and the `time_to_conversion_seconds` (time from the first event to the final event).

| **session_id** | **user_id** | **purchase_timestamp** | **time_to_conversion_seconds** |
| -------------------- | ----------------- | ---------------------------- | ------------------------------------ |
| sess_B               | 102               | 2023-12-01 11:03:00.000      | 180                                  |

### Tips for Approaching the Problem

1. **Identify ALL Sequential Pairs:** The first challenge is to check the entire sequence of events. Use the `LEAD()` window function to attach the details of the *next* event to the current event. You will need to use `LEAD()` multiple times (for `event_type`, `page_url`, and `event_timestamp`). Partition by `session_id`.
2. **Filter for the Start of the Path:** Create a CTE that filters for the exact starting pattern: `event_type = 'VIEW_PAGE'` AND `page_url = '/home'`.
3. **Check for Frictionless Sequence (The Hard Part):** The final step requires checking four consecutive events. This is done by checking the current row (`t1`), the next row (`t2`), the one after (`t3`), and the one after that (`t4`)—all attached via `LEAD()` or a self-join.
   * **t1** (`VIEW_PAGE`, `/home`) must be followed by...
   * **t2** (`CLICK_CTA`, `/home`).
   * **t3** (`VIEW_PAGE`, `/checkout`).
   * **t4** (`PURCHASE`, `/checkout`).
4. **Final Selection:** Filter your results to only show the rows that meet the full 4-step sequence criteria. The time-to-conversion is the difference between the `PURCHASE` timestamp (the third `LEAD` timestamp) and the `VIEW_PAGE /home` timestamp (the current row's timestamp).

**Your Solution:**

```sql
WITH user_paths AS (
    SELECT
 		event_id, user_id, session_id, event_timestamp, event_type, page_url, conversion_goal,
        LEAD(event_id, 1) OVER (PARTITION BY session_id ORDER BY event_timestamp) AS next_event_id
    FROM
        user_conversion_paths
)
SELECT
    path1.session_id,
    path1.user_id,
    path4.event_timestamp AS purchase_timestamp,
    TIMESTAMPDIFF(SECOND, path1.event_timestamp, path4.event_timestamp) AS time_to_conversion_seconds
FROM
    user_paths path1
JOIN
    user_paths path2
    ON path2.session_id = path1.session_id AND path2.event_id = path1.next_event_id
JOIN
    user_paths path3
    ON path3.session_id = path2.session_id AND path3.event_id = path2.next_event_id
JOIN
    user_paths path4
    ON path4.session_id = path3.session_id AND path4.event_id = path3.next_event_id
WHERE
    path1.event_type = 'VIEW_PAGE' AND path1.page_url = '/home'
    AND path2.event_type = 'CLICK_CTA' AND path2.page_url = '/home'
    AND path3.event_type = 'VIEW_PAGE' AND path3.page_url = '/checkout'
    AND path4.event_type = 'PURCHASE' AND path4.page_url = '/checkout'
    AND path4.conversion_goal = 'Goal_A';
```
