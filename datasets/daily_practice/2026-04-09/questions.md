## Puzzle: The Dynamic Surge Pricing Engine

**The Scenario:** You are a backend data engineer for a popular ride-sharing app. The app uses a dynamic pricing model to balance supply and demand. When a user opens the app to request a ride, the system calculates a `surge_multiplier` based on how many *other* people in that exact same zone have requested a ride in the last 10 minutes.

**Your Task:** Write a query to calculate the `surge_multiplier` for every ride request in the database.

**Surge Pricing Rules:**

Count the number of *prior* requests in the same `zone_id` that occurred within the **10 minutes strictly before** (and including) the current request's timestamp. (Do not count the current request itself in this total).

* **0 to 2 prior requests:** Multiplier is `1.00` (Normal)
* **3 to 5 prior requests:** Multiplier is `1.50` (Busy)
* **6 or more prior requests:** Multiplier is `2.00` (Surge)

The final report should show the `request_id`, `zone_id`, `request_timestamp`, the calculated `prior_requests_count`, and the final `surge_multiplier` (formatted to 2 decimal places). Order the results by `zone_id` and then `request_timestamp`.

**Expected Output:**

| **request_id** | **zone_id** | **request_timestamp** | **prior_requests_count** | **surge_multiplier** |
| -------------------- | ----------------- | --------------------------- | ------------------------------ | -------------------------- |
| 1                    | Zone-A            | 2026-04-09 08:00:00.000     | 0                              | 1.00                       |
| 2                    | Zone-A            | 2026-04-09 08:05:00.000     | 1                              | 1.00                       |
| 3                    | Zone-A            | 2026-04-09 08:12:00.000     | 1                              | 1.00                       |
| 8                    | Zone-A            | 2026-04-09 18:00:00.000     | 0                              | 1.00                       |
| 9                    | Zone-A            | 2026-04-09 18:02:00.000     | 1                              | 1.00                       |
| 10                   | Zone-A            | 2026-04-09 18:05:00.000     | 2                              | 1.00                       |
| 11                   | Zone-A            | 2026-04-09 18:09:00.000     | 3                              | 1.50                       |
| 4                    | Zone-B            | 2026-04-09 17:00:00.000     | 0                              | 1.00                       |
| 5                    | Zone-B            | 2026-04-09 17:02:00.000     | 1                              | 1.00                       |
| 6                    | Zone-B            | 2026-04-09 17:04:00.000     | 2                              | 1.00                       |
| 7                    | Zone-B            | 2026-04-09 17:06:00.000     | 3                              | 1.50                       |
| 8                    | Zone-B            | 2026-04-09 17:07:00.000     | 4                              | 1.50                       |
| 9                    | Zone-B            | 2026-04-09 17:08:00.000     | 5                              | 1.50                       |
| 10                   | Zone-B            | 2026-04-09 17:09:00.000     | 6                              | 2.00                       |

*(Note: Request 3 in Zone A at 08:12 only sees 1 prior request because the 08:00 request is 12 minutes old and falls outside the 10-minute window!)*

### Tips for Approaching the Problem

1. **ROWS vs. RANGE:** A standard `ROWS BETWEEN` window frame counts physical rows, which doesn't work here because requests don't happen at predictable, steady intervals. You must use `RANGE BETWEEN` to look back using actual calendar time math!
2. **The Window Frame:** To count requests in the preceding 10 minutes, your window function's frame clause should be:
   `RANGE BETWEEN INTERVAL 10 MINUTE PRECEDING AND CURRENT ROW`
3. **Subtract the Current Row:** The window function above will count *every* row in that time window, including the current request itself. Since the rules ask for *prior* requests, simply subtract `1` from the result of your window function.
4. **Assign the Multiplier:** In your final `SELECT` statement, wrap a `CASE` statement around the count you calculated in your CTE to assign the 1.0, 1.5, or 2.0 multipliers.

**Your Solution:**

```sql
-- Write your solution here
```
