## Puzzle: The Flawless Combo Score (Running Total with Reset)

**The Scenario:** In a new action RPG, players earn "Combo Points" for consecutive attacks. However, if a player is hit by an enemy (`DAMAGE_TAKEN`), their running combo multiplier breaks, and their current combo score is immediately reset to zero.

The game developers want a leaderboard that displays the absolute highest combo score each player ever achieved in a single, unbroken chain of attacks.

**Your Task:** Write a query to calculate the `max_combo_score` for each player.

The final report should show the `player_id` and their `max_combo_score`. Order the results by the `max_combo_score` in descending order, and then by `player_id` to break any ties.

**Expected Output:**

| **player_id** | **max_combo_score** |

| 103 | 50 |

| 101 | 35 |

| 102 | 10 |

| 104 | 0 |

### Tips for Approaching the Problem

This is a classic "Running Total with Reset" problem. Standard window functions will just sum everything up, so you need a way to restart the aggregation every time a `DAMAGE_TAKEN` event occurs.

1. **The Reset Flag:** Create a Common Table Expression (CTE) and define a flag that evaluates to `1` when `event_type = 'DAMAGE_TAKEN'` and `0` otherwise.
2. **Create the Combo Group ID:** In the exact same CTE, you can use a cumulative sum on the flag you just conceptualized!
   Use `SUM(CASE WHEN event_type = 'DAMAGE_TAKEN' THEN 1 ELSE 0 END) OVER (PARTITION BY player_id ORDER BY event_timestamp)`.
   *Why this works:* Every time a player takes damage, this running sum increases by 1. Because consecutive attacks add 0 to the sum, they will all share the exact same running sum number. This mathematically isolates each continuous attack streak into its own unique `combo_group_id`!
3. **Aggregate the Streaks:** Create a second CTE that queries from the first one. `GROUP BY player_id` and the `combo_group_id`. Calculate the total score for each distinct combo sequence using `SUM(combo_points)`.
4. **Find the Max:** In your final `SELECT` statement, query from your aggregated streaks. `GROUP BY player_id` one last time, and find the `MAX(total_combo_score)`.

**Your Solution:**

```sql
-- Write your solution here
```

