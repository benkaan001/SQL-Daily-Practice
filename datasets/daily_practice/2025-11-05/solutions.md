## Puzzle: The "Password Spraying" Detector

**The Scenario:** As a security engineer, you're monitoring for two types of attacks. A "brute force" attack involves many login attempts on a  *single user* . A "password spraying" attack involves a few login attempts across  *many different users* . Your task is to build a detector for password spraying.

**Your Task:** Write a query to find all IP addresses that have conducted a password spraying attack. An attack is defined as an `ip_address` that makes at least one failed login attempt (`success = false`) against **5 or more unique usernames** within any  **30-minute window** .

The final report should show the `ip_address`, the `window_start_time` (the timestamp of the first failed attempt in the detected spray), the `window_end_time` (the timestamp of the last failed attempt in the spray), and the total `unique_usernames_attempted` during that window.

| ip_address    | window_start_time   | window_end_time     | unique_usernames_attempted |
| ------------- | ------------------- | ------------------- | -------------------------- |
| 198.51.100.82 | 2023-11-28 10:00:00 | 2023-11-28 10:06:00 | 7                          |
| 198.51.100.82 | 2023-11-28 10:01:00 | 2023-11-28 10:06:00 | 6                          |
| 198.51.100.82 | 2023-11-28 10:02:00 | 2023-11-28 10:06:00 | 5                          |
| 198.51.100.82 | 2023-11-28 10:45:00 | 2023-11-28 10:47:30 | 6                          |
| 198.51.100.82 | 2023-11-28 10:45:30 | 2023-11-28 10:47:30 | 5                          |

### Tips for Approaching the Problem

1. **Filter for Failed Attempts:** Start by creating a CTE that only includes rows where `success = false`. This is the pool of suspicious events.
2. **Establish the Sliding Window (Self-Join):** The correct method for "any 30-minute window" is to use a  **Self-Join** . Join the filtered table (let's call it `T1`) back to itself (let's call it `T2`) on two conditions:
   * `T1.ip_address = T2.ip_address` (Match the same attacker).
   * `T2.attempt_timestamp` must be between `T1.attempt_timestamp` and **30 minutes later** (i.e., `T2.attempt_timestamp <= DATE_ADD(T1.attempt_timestamp, INTERVAL 30 MINUTE)`). Here, `T1`'s timestamp acts as the potential **start time** for every 30-minute window.
3. **Group and Count:** `GROUP BY` the original window start time (`T1.attempt_timestamp`) and `T1.ip_address`.
4. **Calculate Metrics:** In your `SELECT` clause for the grouped data:
   * `COUNT(DISTINCT T2.username_attempted)` to get the number of unique users within that specific 30-minute window.
   * `MIN(T2.attempt_timestamp)` to find the true `window_start_time` (which is usually the `T1` time, but using MIN guarantees the first event).
   * `MAX(T2.attempt_timestamp)` to find the true `window_end_time` (the timestamp of the last event in the spray).
5. **Final Filtering:** Use the `HAVING` clause to filter the results to only include groups where the `unique_usernames_attempted` is  **5 or more** .



**Your Solution:**

```sql
SELECT
    -- Select the earliest timestamp and the latest timestamp of the events
    -- that satisfy the 5+ unique users condition within the 30-minute window.
    T1.ip_address,
    MIN(T2.attempt_timestamp) AS window_start_time,
    MAX(T2.attempt_timestamp) AS window_end_time,
    -- Count the unique usernames that fall within T1's 30-minute window
    COUNT(DISTINCT T2.username_attempted) AS unique_usernames_attempted
FROM
    login_attempts T1
JOIN
    login_attempts T2 ON
    -- Match attempts on the same IP address
    T1.ip_address = T2.ip_address AND
    -- Filter to ensure both T1 and T2 are failed attempts
    T1.success = FALSE AND T2.success = FALSE AND
    -- T2 must be later than or equal to T1's timestamp (T1 is the start of the window)
    T2.attempt_timestamp >= T1.attempt_timestamp AND
    -- T2 must be within 30 minutes of T1's timestamp (T1 defines the window end)
    T2.attempt_timestamp <= DATE_ADD(T1.attempt_timestamp, INTERVAL 30 MINUTE)
GROUP BY
    -- Group by the start of the window (T1's timestamp) and IP
    T1.ip_address,
    T1.attempt_timestamp
HAVING
    -- Filter to find windows with 5 or more unique usernames
    unique_usernames_attempted >= 5
ORDER BY
    window_start_time;
```
