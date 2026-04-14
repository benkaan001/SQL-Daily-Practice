## Puzzle: The Multi-Account Fraud Ring (Device Fingerprinting)

**The Scenario:** The Trust & Safety team is hunting for users who are creating multiple fake accounts to abuse platform promotions. They use a hidden `device_fingerprint` to track the physical hardware being used. If two *different* `user_id`s log in using the *exact same* device fingerprint within a  **12-hour window** , they are flagged as a "Linked Pair."

**Your Task:** Write a query to find all unique pairs of linked users.

*Rules:*

1. The logins from the two different users on the same device must occur within 12 hours (720 minutes) of each other.
2. To avoid duplicate pairs in your report (e.g., showing both 101-102 and 102-101), ensure the first user ID is always strictly less than the second user ID (`user_a_id < user_b_id`).
3. If two users share a device multiple times, only report them once, showing the *minimum* time difference observed between any of their linked logins.

The final report should show `user_a_id`, `user_b_id`, the `shared_device`, and the `min_time_diff_hours` (rounded to 2 decimal places). Order the results by `shared_device`, then by `user_a_id`.

**Expected Output:**

| **user_a_id** | **user_b_id** | **shared_device** | **min_time_diff_hours** |
| ------------------- | ------------------- | ----------------------- | ----------------------------- |
| 101                 | 102                 | dev_A_99x               | 2.50                          |
| 105                 | 106                 | dev_C_55z               | 0.25                          |
| 105                 | 107                 | dev_C_55z               | 1.00                          |
| 106                 | 107                 | dev_C_55z               | 0.75                          |
| 108                 | 109                 | dev_D_33w               | 1.00                          |

### Tips for Approaching the Problem

1. **The Self-Join:** You need to compare rows within the same `access_logs` table. `JOIN` the table to itself (aliased as `l1` and `l2`) on the `device_fingerprint`.
2. **Prevent Duplicates:** In your `JOIN` conditions, use `l1.user_id < l2.user_id`. This elegantly handles two things: it guarantees you are looking at two *different* users, and it forces the pair into a consistent order (smaller ID first), completely eliminating mirror duplicates.
3. **The Time Window:** You need to check if the time difference is 12 hours or less. Because `l1` could have happened *after* `l2` (since we forced the order by `user_id`, not by time), you must use the absolute value of the time difference: `ABS(TIMESTAMPDIFF(MINUTE, l1.login_timestamp, l2.login_timestamp)) <= 720`.
4. **Aggregate:** Group your results by `user_a_id`, `user_b_id`, and `shared_device`. Use `MIN()` on your time difference calculation to satisfy Rule 3. Don't forget to divide your minutes by 60.0 to convert it to hours!

**Your Solution:**

```sql
-- Write your solution here
```

