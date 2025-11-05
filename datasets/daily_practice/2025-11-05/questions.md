## Puzzle: The "Password Spraying" Detector

**The Scenario:** As a security engineer, you're monitoring for two types of attacks. A "brute force" attack involves many login attempts on a  *single user* . A "password spraying" attack involves a few login attempts across  *many different users* . Your task is to build a detector for password spraying.

**Your Task:** Write a query to find all IP addresses that have conducted a password spraying attack. An attack is defined as an `ip_address` that makes at least one failed login attempt (`success = false`) against **5 or more unique usernames** within any  **30-minute window** .

The final report should show the `ip_address`, the `window_start_time` (the timestamp of the first failed attempt in the detected spray), the `window_end_time` (the timestamp of the last failed attempt in the spray), and the total `unique_usernames_attempted` during that window.

| ip_address | window_start_time | window_end_time | unique_usernames_attempted |

| 198.51.100.82 | 2023-11-28 10:00:00.000 | 2023-11-28 10:06:00.000 | 7 |

| 198.51.100.82 | 2023-11-28 10:45:00.000 | 2023-11-28 10:47:30.000 | 6 |

### Tips for Approaching the Problem

1. **Filter for Failed Attempts:** Start by creating a CTE that only includes rows where `success = false`. This is the pool of suspicious events.
2. **Group into Time Windows:** The main challenge is to group events into 30-minute windows  *per IP* . A common way to do this without complex window functions is to "floor" the timestamp to the nearest 30-minute interval. You can do this by converting the timestamp to a UNIX timestamp, dividing by the number of seconds in 30 minutes (1800), and then using `FLOOR()`. This creates a unique `window_id` for each 30-minute bucket.
3. **Aggregate by Window:** `GROUP BY` the `ip_address` and your calculated `window_id`.
4. **Calculate Metrics:** In your `SELECT` clause for the grouped data:
   * `COUNT(DISTINCT username_attempted)` to get the number of unique users.
   * `MIN(attempt_timestamp)` to find the `window_start_time`.
   * `MAX(attempt_timestamp)` to find the `window_end_time`.
5. **Final Filtering:** In your final `SELECT` statement (or using a `HAVING` clause), filter the results to only include groups where the `unique_usernames_attempted` is 5 or more.

**Your Solution:**

```sql
-- Write your solution here
```
