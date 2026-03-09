## Puzzle: The Longest Winning Streak

**The Scenario:** The community team for an online competitive game wants to introduce an "Unstoppable" badge to display on player profiles. To do this, they need to calculate the maximum number of consecutive wins each player has ever achieved.

**Your Task:** Write a query to calculate the **longest winning streak** (consecutive 'WIN' outcomes) for each player in the database.

*Rules:*

1. Any outcome other than 'WIN' (i.e., 'LOSS' or 'DRAW') breaks a winning streak.
2. If a player has never won a match, their longest winning streak should be reported as `0`.

The report should output the `player_id` and the `longest_win_streak`. Order the results by the `longest_win_streak` in descending order, then by `player_id`.

**Expected Output:**

| **player_id** | **longest_win_streak** |
| ------------------- | ---------------------------- |
| 103                 | 5                            |
| 101                 | 4                            |
| 102                 | 1                            |
| 104                 | 0                            |

### Tips for Approaching the Problem

This requires identifying "islands" of consecutive wins. The mathematical difference between two specific `ROW_NUMBER()` window functions is the standard trick for this.

1. **Calculate Two Row Numbers:** In a CTE, assign two different sequential row numbers to your data:
   * `rn1`: A row number partitioned by `player_id` and ordered by `match_date`. (Numbers every match chronologically).
   * `rn2`: A row number partitioned by `player_id` **and** `outcome`, ordered by `match_date`. (Numbers wins separately from losses/draws).
2. **The Magic Difference:** Subtract `rn2` from `rn1` (`rn1 - rn2`). You will notice that for any continuous, unbroken sequence of the exact same outcome, this mathematical difference results in the exact same constant number. This constant number acts as a unique `streak_group_id`!
3. **Aggregate the Streaks:** In a second CTE, filter the data where `outcome = 'WIN'`, group by the `player_id` and the `streak_group_id` you just created, and use `COUNT(*)` to find the length of each winning streak.
4. **Find the Maximum:** Finally, query a distinct list of all players (so you don't lose Player 104 who has 0 wins), `LEFT JOIN` it to your aggregated streaks, group by `player_id`, and find the `MAX(streak_length)`. Use `COALESCE` or `IFNULL` to turn NULLs into 0.

**Your Solution:**

```sql
-- Write your solution here
```
