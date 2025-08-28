## Puzzle 1: The Gradual Rollout Tracker

**The Scenario:** The product team is gradually rolling out the `new_search_algo` feature. They need a daily report that tracks the cumulative percentage of the user base that has been exposed to the new feature.

**Your Task:** Write a query that calculates the cumulative number of unique users exposed to the `new_search_algo` feature each day. Then, assuming a total user base of 10 unique users (101 through 110), calculate the `cumulative_exposure_pct` for each day.

The final report should show the `rollout_date`, the `daily_new_users_exposed`, and the `cumulative_exposure_pct`.

**Expected Output:**

| **rollout_date** | **daily_new_users_exposed** | **cumulative_exposure_pct** |
| ---------------------- | --------------------------------- | --------------------------------- |
| 2023-11-20             | 2                                 | 20.00                             |
| 2023-11-21             | 3                                 | 50.00                             |
| 2023-11-22             | 1                                 | 60.00                             |

**Your Solution:**

```sql
-- Write your solution here
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
-- Write your solution here
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
-- Write your solution here
```
