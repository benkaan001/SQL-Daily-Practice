## Puzzle: The "First Pass Success" Rate

**The Scenario:** As a game designer, you want to understand the difficulty progression. A key metric is the "First Pass Success Rate" for each level: what percentage of players who attempt a level for the *very first time* manage to complete it successfully on that first attempt?

**Your Task:** Write a query that calculates the `first_pass_success_rate_pct` for each `level_id`. The report must show:

1. `level_id`: The game level.
2. `total_first_attempts`: The number of unique players who attempted this level for the first time.
3. `successful_first_attempts`: The number of those players whose very first attempt resulted in 'COMPLETED'.
4. `first_pass_success_rate_pct`: The (successful_first_attempts / total_first_attempts) * 100, rounded to two decimal places.

| **level_id** | **total_first_attempts** | **successful_first_attempts** | **first_pass_success_rate_pct** |
| ------------------ | ------------------------------ | ----------------------------------- | ------------------------------------- |
| 1                  | 4                              | 3                                   | 75.00                                 |
| 2                  | 3                              | 2                                   | 66.67                                 |
| 3                  | 1                              | 0                                   | 0.00                                  |

### Tips for Approaching the Problem

1. **Identify First Attempts:** The core of the problem is isolating each player's *very first attempt* at each level. The `ROW_NUMBER()` window function is perfect for this. Partition by `player_id` and `level_id`, and order by `attempt_start_timestamp ASC`. The row with `rank = 1` for each group is the first attempt.
2. **Filter for First Attempts:** Create a Common Table Expression (CTE) that selects only the rows where the rank calculated in the previous step is `1`. This CTE will now contain only the first attempt data for every player on every level they tried.
3. **Aggregate by Level:** Now you can `GROUP BY level_id` using the results from your "first attempts" CTE.
4. **Calculate Metrics:**
   * `total_first_attempts`: This is simply `COUNT(*)` in your aggregated result, as each row in the CTE represents one unique player's first attempt at that level.
   * `successful_first_attempts`: Use conditional aggregation. Count the rows where the `outcome` was 'COMPLETED'. The syntax `COUNT(CASE WHEN outcome = 'COMPLETED' THEN 1 END)` or `SUM(CASE WHEN outcome = 'COMPLETED' THEN 1 ELSE 0 END)` works well.
   * `first_pass_success_rate_pct`: Calculate this using the two counts from above: `(successful_first_attempts * 100.0) / total_first_attempts`.

**Your Solution:**

```sql
-- Write your solution here
```
