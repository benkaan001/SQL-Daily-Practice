## Puzzle: The Tournament Leaderboard (Unpivoting Data)

**The Scenario:** The administrators of an online chess platform want to display a global leaderboard. The raw database logs matches based on the color pieces each player controlled (`white_player_id` vs `black_player_id`). To build a personal leaderboard, you need to calculate every player's overall win/loss record, regardless of which color they were playing!

**Your Task:** Write a query to generate the leaderboard. For every player who has played  *at least one match* , calculate their total matches, wins, losses, draws, and win percentage.

**Rules:**

1. The `win_percentage` should be calculated as `(total_wins / total_matches) * 100`.
2. Round the `win_percentage` to two decimal places.
3. Do not include players who have never played a match (like Evan).

The final report should show `player_name`, `total_matches`, `total_wins`, `total_losses`, `total_draws`, and `win_percentage`. Order the results by `win_percentage` descending, and then by `total_matches` descending to break any ties.

**Expected Output:**

| **player_name** | **total_matches** | **total_wins** | **total_losses** | **total_draws** | **win_percentage** |
| --------------------- | ----------------------- | -------------------- | ---------------------- | --------------------- | ------------------------ |
| Alice                 | 4                       | 3                    | 0                      | 1                     | 75.00                    |
| Bob                   | 3                       | 1                    | 1                      | 1                     | 33.33                    |
| Charlie               | 4                       | 1                    | 3                      | 0                     | 25.00                    |
| Diana                 | 3                       | 0                    | 1                      | 2                     | 0.00                     |

### Tips for Approaching the Problem

This is a classic "unpivot" problem. A single row in the matches table represents *two* different outcomes for *two* different players. You need to split each match into two separate rows.

1. **Unpivot with UNION ALL:** Create a Common Table Expression (CTE) that stacks two separate queries on top of each other.
   * **Query 1 (White's Perspective):** Select the `white_player_id` as `player_id`. Use a `CASE` statement to evaluate the `result` column and translate it into a standard outcome from White's perspective (e.g., if result is 'WHITE_WIN', then 'WIN'; if 'BLACK_WIN', then 'LOSS').
   * **Query 2 (Black's Perspective):** `UNION ALL` a second query that selects the `black_player_id` as `player_id`. Use a `CASE` statement to translate the outcome from Black's perspective (e.g., if result is 'BLACK_WIN', then 'WIN').
2. **The Unified Timeline:** By doing this, you have created a vertical list of every single time a player participated in a match and what *their personal outcome* was ('WIN', 'LOSS', or 'DRAW').
3. **Join to Players:** In your main `SELECT` statement, query from your unified CTE and `JOIN` it to the `players` table using the `player_id` to fetch the names.
4. **Aggregate the Stats:** `GROUP BY` the `player_name`.
   * Use `COUNT(*)` for total matches.
   * Use conditional aggregation (`SUM(CASE WHEN outcome = 'WIN' THEN 1 ELSE 0 END)`) to count the specific wins, losses, and draws.
   * Calculate the percentage using the counts.

**Your Solution:**

```sql
-- Write your solution here
```

