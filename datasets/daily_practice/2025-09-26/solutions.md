## Puzzle: The "Golden Path" User Journey

**The Scenario:** As a product analyst, you need to measure how effectively users follow the primary "golden path" within the application during a single session. This path represents the ideal user journey for creating a new project.

**The Golden Path:**

1. User views the dashboard (`PAGE_VIEW` of `/dashboard`).
2. Then, they click the create project button (`FEATURE_CLICK` of `Create Project`).
3. Finally, they save the new project (`FEATURE_CLICK` of `Save Project`).

**Your Task:** Write a query that reconstructs the user journey for each session that contains at least one of these "golden path" events. The report must show the `user_id`, `session_id`, and a timeline of up to three columns: `step_1_time` (dashboard view), `step_2_time` (project creation), and `step_3_time` (project save).

If a user completes a step in the correct sequence, the timestamp of that event should be shown. If a step is skipped or done out of order, the value for that step and all subsequent steps should be `NULL`.

| **user_id** | **session_id** | **step_1_time**   | **step_2_time**   | **step_3_time**   |
| ----------------- | -------------------- | ----------------------- | ----------------------- | ----------------------- |
| 101               | sess_A               | 2023-11-15 09:00:00.000 | 2023-11-15 09:01:30.000 | 2023-11-15 09:04:00.000 |
| 101               | sess_C               | 2023-11-16 11:00:00.000 | 2023-11-16 11:01:00.000 | NULL                    |
| 102               | sess_B               | NULL                    | NULL                    | NULL                    |
| 103               | sess_D               | 2023-11-16 14:00:00.000 | NULL                    | NULL                    |
| 104               | sess_E               | 2023-11-17 08:30:00.000 | 2023-11-17 08:32:00.000 | 2023-11-17 08:33:00.000 |

### Tips for Approaching the Problem

1. **Isolate Path Events:** The first step is to get the timestamps for each of the three specific "golden path" events for each session. You can use conditional aggregation (`MIN(CASE WHEN ... THEN ... END)`) grouped by `user_id` and `session_id` to pivot these events into columns. This gives you the time for each event if it exists in the session.
2. **Verify the Sequence:** The core challenge is checking if the events happened in the correct order. In your final `SELECT` statement, you will use a series of `CASE` statements to build the timeline.
3. **Build the Timeline Step-by-Step:**
   * **Step 1:** The `step_1_time` is simply the timestamp of the `/dashboard` page view.
   * **Step 2:** The `step_2_time` should only be populated if the `Create Project` event happened *after* the `/dashboard` event. So, your `CASE` statement will look something like `CASE WHEN time_of_step_2 > time_of_step_1 THEN time_of_step_2 ELSE NULL END`.
   * **Step 3:** The `step_3_time` is even stricter. It should only be populated if Step 2 is valid AND the `Save Project` event happened *after* the `Create Project` event. This will require a nested `CASE` or a more complex condition checking all three timestamps.
4. **Filter Out Irrelevant Sessions:** Your final `WHERE` clause should filter out any sessions where none of the three "golden path" events occurred at all, to keep the final report clean.

**Your Solution:**

```sql
WITH ordered_sessions AS (
    SELECT
        user_id,
        session_id,
        MIN(CASE WHEN event_type = 'PAGE_VIEW' AND event_details = '/dashboard' THEN event_timestamp END) AS time_step_1,
        MIN(CASE WHEN event_type = 'FEATURE_CLICK' AND event_details = 'Create Project' THEN event_timestamp END) AS time_step_2,
        MIN(CASE WHEN event_type = 'FEATURE_CLICK' AND event_details = 'Save Project' THEN event_timestamp END) AS time_step_3
    FROM
        saas_events
    GROUP BY
        user_id,
        session_id
)
SELECT
    user_id,
    session_id,
    CASE
        WHEN time_step_1 IS NOT NULL AND (time_step_2 IS NULL OR time_step_1 < time_step_2) THEN time_step_1
        ELSE NULL
    END AS step_1_time,
    CASE
        WHEN time_step_1 IS NOT NULL AND (time_step_2 IS NULL OR time_step_1 < time_step_2)
        AND time_step_2 > time_step_1 THEN time_step_2
        ELSE NULL
    END AS step_2_time,
    CASE
        WHEN time_step_1 IS NOT NULL AND (time_step_2 IS NULL OR time_step_1 < time_step_2) AND time_step_2 > time_step_1 AND time_step_3 > time_step_2 THEN time_step_3
        ELSE NULL
    END AS step_3_time
FROM
    ordered_sessions
WHERE
    time_step_1 IS NOT NULL
    OR time_step_2 IS NOT NULL
    OR time_step_3 IS NOT NULL
ORDER BY
    user_id,
	session_id;
```
