## Puzzle: The "Legendary Hero" Achievement Path

**The Scenario:** As a game designer, you want to track how many players are completing the prestigious "Legendary Hero" questline. This title is only awarded to players who complete three specific achievements in a precise, chronological order.

**The Path:**

1. First, achieve 'Troll Slayer'.
2. *After* achieving 'Troll Slayer', achieve 'Dragon Whelpling'.
3. *After* achieving 'Dragon Whelpling', achieve 'Lich Bane'.

**Your Task:** Write a query to find all players who have successfully completed this 3-step sequence in the correct order. The report should show the `player_id` and the exact timestamps for when they achieved each of the three steps.

**Note:** A player may achieve other, unrelated achievements (or even repeat achievements) in between these steps. The query should only find the *first time* they achieved each step in the correct sequence.

| player_id | troll_slayer_at | dragon_whelpling_at | lich_bane_at |

| 101 | 2023-11-02 11:00:00 | 2023-11-04 13:00:00 | 2023-11-05 14:00:00 |

| 104 | 2023-11-10 18:00:00 | 2023-11-11 19:00:00 | 2023-11-13 21:00:00 |

### Tips for Approaching the Problem

1. **Pivot the Data:** The easiest way to check for a sequence is to get the timestamps for all three required achievements into a single row for each player. This is a "pivot" operation.
2. **Use Conditional Aggregation:** `GROUP BY player_id`. In your `SELECT` statement, use conditional aggregation to find the *first time* (the `MIN()`) each achievement was completed.
   * `MIN(CASE WHEN achievement_name = 'Troll Slayer' THEN event_timestamp END) AS troll_slayer_at`
   * `MIN(CASE WHEN achievement_name = 'Dragon Whelpling' THEN event_timestamp END) AS dragon_whelpling_at`
   * `MIN(CASE WHEN achievement_name = 'Lich Bane' THEN event_timestamp END) AS lich_bane_at`
3. **Create a CTE:** Put the query from the first two steps into a Common Table Expression (CTE) called `PlayerFirstTimestamps`.
4. **Filter for the Sequence:** In your final `SELECT` statement, query from your `PlayerFirstTimestamps` CTE. The `WHERE` clause is the most important part. You must check two conditions:
   * That the player has completed all three achievements (i.e., none of the columns are `NULL`).
   * That they were completed in the correct order:
     WHERE troll_slayer_at < dragon_whelpling_at AND dragon_whelpling_at < lich_bane_at

**Your Solution:**

```sql
SELECT
	player_id,
	MIN(CASE WHEN achievement_name = 'Troll Slayer' THEN achievement_timestamp END) AS troll_slayer_at,
	MIN(CASE WHEN achievement_name = 'Dragon Whelpling' THEN achievement_timestamp END) AS dragon_whelpling_at,
	MIN(CASE WHEN achievement_name = 'Lich Bane' THEN achievement_timestamp END) AS lich_bane_at
FROM
	player_achievements
GROUP BY
	player_id
HAVING
	troll_slayer_at < dragon_whelpling_at
	AND dragon_whelpling_at < lich_bane_at;
```
