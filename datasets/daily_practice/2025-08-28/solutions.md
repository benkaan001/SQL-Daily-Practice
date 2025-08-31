## Puzzle 1: The Gradual Rollout Tracker

**The Scenario:** The product team is gradually rolling out the `new_search_algo` feature. They need a daily report that tracks the cumulative percentage of the user base that has been exposed to the new feature.

**Your Task:** Write a query that calculates the cumulative number of unique users exposed to the `new_search_algo` feature each day. Then, assuming a total user base of 10 unique users (101 through 110), calculate the `cumulative_exposure_pct` for each day.

The final report should show the `rollout_date`, the `daily_new_users_exposed`, and the `cumulative_exposure_pct`.

**Expected Output:**

| rollout_date | daily_new_users_exposed | cumulative_exposure_pct |
| ------------ | ----------------------- | ----------------------- |
| 2023-11-20   | 2                       | 20.00                   |
| 2023-11-21   | 3                       | 50.00                   |
| 2023-11-22   | 1                       | 60.00                   |

**Your Solution:**

```sql
WITH exposures AS (
	SELECT
		DATE(event_timestamp) AS rollout_date,
		COUNT(DISTINCT user_id) AS daily_new_users_exposed,
		SUM(CASE WHEN event_type = 'USER_EXPOSED' THEN 1 ELSE 0 END) AS exposure_count
	FROM
		feature_flag_events
	WHERE
		JSON_UNQUOTE(JSON_EXTRACT(details, '$.feature_name')) = 'new_search_algo'
	GROUP BY
		DATE(event_timestamp)

)
SELECT
	rollout_date,
	daily_new_users_exposed,
	ROUND(100.0 *
		(SUM(exposure_count) OVER (ORDER BY rollout_date) / 10)
	, 2) AS cumulative_exposure_pct
FROM
	exposures;
```

## Puzzle 2: The Error Correlation Detective

**The Scenario:** An engineer suspects that enabling the `new_checkout_ui` feature is causing a spike in errors in the `checkout_service`. You need to verify if users exposed to this feature are more likely to generate errors than those who weren't.

**Task:**

1. Identify all users who were exposed to the `new_checkout_ui` feature.
2. For this group of "exposed users," calculate their `error_rate` (percentage of exposed users who triggered an `APP_ERROR` from the `checkout_service`).
3. For comparison, calculate the `error_rate` for all "unexposed users" (those who had an `APP_ERROR` from `checkout_service` but were *not* exposed to the feature). *Note: In this dataset, there are no unexposed users with checkout errors, so the rate will be 0.*

The final report should compare the `error_rate` for the `user_group` ('Exposed' vs. 'Unexposed').

**Expected Output:**

| **user_group** | **error_rate** |
| -------------------- | -------------------- |
| Exposed              | 66.67                |
| Unexposed            | 0.00                 |

**Your Solution:**

```sql
-- Step 1: Find the exact time window when the 'new_checkout_ui' feature was active.
WITH FeatureWindow AS (
    SELECT
        MIN(CASE WHEN event_type = 'FLAG_ENABLED' THEN event_timestamp END) AS enabled_at,
        MAX(CASE WHEN event_type = 'FLAG_DISABLED' THEN event_timestamp END) AS disabled_at
    FROM
        feature_flag_events
    WHERE
        JSON_UNQUOTE(JSON_EXTRACT(details, '$.feature_name')) = 'new_checkout_ui'
),

-- Step 2: Identify the unique set of users who were exposed to the feature *during its active window*.
ExposedUsers AS (
    SELECT DISTINCT
        user_id
    FROM
        feature_flag_events, FeatureWindow
    WHERE
        event_type = 'USER_EXPOSED'
        AND JSON_UNQUOTE(JSON_EXTRACT(details, '$.feature_name')) = 'new_checkout_ui'
        AND event_timestamp BETWEEN FeatureWindow.enabled_at AND FeatureWindow.disabled_at
),

-- Step 3: Identify the unique set of users who had a relevant checkout service error.
CheckoutErrors AS (
    SELECT DISTINCT
        user_id
    FROM
        feature_flag_events
    WHERE
        event_type = 'APP_ERROR'
        AND JSON_UNQUOTE(JSON_EXTRACT(details, '$.source')) = 'checkout_service'
)

-- Final Step: Calculate the rates by comparing the user sets.
SELECT
    'Exposed' AS user_group,
    ROUND(
        (SELECT COUNT(*) FROM ExposedUsers eu JOIN CheckoutErrors ce ON eu.user_id = ce.user_id) * 100.0 /
        (SELECT COUNT(*) FROM ExposedUsers),
    2) AS error_rate

UNION ALL

SELECT
    'Unexposed' AS user_group,
    ROUND(
        -- Find the count of users who had a checkout error but were NOT in the exposed set.
        (SELECT COUNT(*) FROM CheckoutErrors ce LEFT JOIN ExposedUsers eu ON ce.user_id = eu.user_id WHERE eu.user_id IS NULL) * 100.0 /
        -- This part is tricky, but for this prompt, we can assume the unexposed group with errors is 0.
        (SELECT COUNT(DISTINCT user_id) FROM feature_flag_events WHERE user_id NOT IN (SELECT user_id FROM ExposedUsers)),
    2) AS error_rate;
```

## Puzzle 3: The Rollback Reaction Timer

**The Scenario:** When a feature causes critical errors, it's crucial to disable (rollback) it quickly. Your task is to measure this "time-to-detect-and-rollback" for the `new_checkout_ui` feature.

**Task:** Write a query to calculate the time difference between the `FLAG_ENABLED` event for the `new_checkout_ui` feature and its subsequent `FLAG_DISABLED` event. More importantly, also find the timestamp of the very first `APP_ERROR` that occurred *between* the enable and disable events.

The final report should show the `feature_name`, the `time_to_first_error_seconds`, and the `total_time_to_rollback_minutes`.

**Expected Output:**

| **feature_name** | **time_to_first_error_seconds** | **total_time_to_rollback_minutes** |
| ---------------------- | ------------------------------------- | ---------------------------------------- |
| new_checkout_ui        | 150.50                                | 10.00                                    |

**Your Solution:**

```sql
WITH feature_timestamps AS (
    SELECT
        JSON_UNQUOTE(JSON_EXTRACT(details, '$.feature_name')) AS feature_name,
        MIN(CASE WHEN event_type = 'FLAG_ENABLED' THEN event_timestamp END) AS enabled_time,
        MAX(CASE WHEN event_type = 'FLAG_DISABLED' THEN event_timestamp END) AS disabled_time
    FROM
        feature_flag_events
    WHERE
        JSON_UNQUOTE(JSON_EXTRACT(details, '$.feature_name')) = 'new_checkout_ui'
    GROUP BY
        feature_name
)
SELECT
    ft.feature_name,
    ROUND(TIMESTAMPDIFF(MICROSECOND, ft.enabled_time, MIN(errors.event_timestamp)) / 1000000.0, 2) AS time_to_first_error_seconds,
    ROUND(TIMESTAMPDIFF(MINUTE, ft.enabled_time, ft.disabled_time), 2) AS total_time_to_rollback_minutes
FROM
    feature_timestamps ft
JOIN
    feature_flag_events errors ON errors.event_timestamp BETWEEN ft.enabled_time AND ft.disabled_time
WHERE
    errors.event_type = 'APP_ERROR'
    AND JSON_UNQUOTE(JSON_EXTRACT(errors.details, '$.source')) = 'checkout_service'
GROUP BY
    ft.feature_name, ft.enabled_time, ft.disabled_time;
```
