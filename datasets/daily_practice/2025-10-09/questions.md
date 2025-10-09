## Puzzle: The Lost Package Locator

**The Scenario:** As a warehouse operations analyst, you're tasked with identifying packages that have likely been lost or misplaced within the fulfillment center. A key indicator of a lost package is a lack of activity for an extended period.

**Your Task:** Write a query to find all packages that are considered "lost" as of the cutoff time `'2023-12-14 12:00:00'`. A package is defined as lost if:

1. Its most recent status is *not* `LOADED_ON_TRUCK`.
2. There has been no new event for the package for more than 48 hours relative to the cutoff time.

The final report should show the `package_id`, its `last_known_status`, the `last_seen_timestamp`, and how many `hours_since_last_seen` (rounded to two decimal places).

| **package_id** | **last_known_status** | **last_seen_timestamp** | **hours_since_last_seen** |
| -------------------- | --------------------------- | ----------------------------- | ------------------------------- |
| PKG-102              | MOVED_TO_BIN                | 2023-12-10 15:30:00.000       | 92.50                           |
| PKG-103              | SORTED                      | 2023-12-11 11:30:00.000       | 72.50                           |

### Tips for Approaching the Problem

1. **Find the Latest Event:** The first step is to determine the most recent (current) status for every package. A window function like `ROW_NUMBER()` is perfect for this. Partition by `package_id` and order by `event_timestamp DESC` to assign a `1` to the latest event for each package.
2. **Isolate Current Status:** In a Common Table Expression (CTE), select only the rows where the rank from the previous step is `1`. This gives you a clean list of each package and its most up-to-date status and timestamp.
3. **Filter Out Completed Packages:** From your CTE of current statuses, filter out any packages that have already been successfully shipped. Your `WHERE` clause should exclude packages where `event_type = 'LOADED_ON_TRUCK'`.
4. **Calculate Time Since Last Seen:** For the remaining packages, calculate how long it has been since their last event. This will be the time difference between the `event_timestamp` and the fixed analysis time (`'2023-12-14 12:00:00'`). Use a function like `TIMESTAMPDIFF()` to get the duration in hours.
5. **Final Filtering:** In your final `SELECT` statement, apply the last piece of logic: filter the results to only include packages where the calculated `hours_since_last_seen` is greater than 48.

**Your Solution:**

```sql
-- Write your solution here
```
