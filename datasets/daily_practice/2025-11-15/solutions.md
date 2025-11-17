## Puzzle: The "First Score" Reconstruction

**The Scenario:** As a game analyst, you need to find each player's *initial high score* for every level they've completed. However, the `HIGH_SCORE_BEATEN` event only fires when a player beats their previous high score. For a player's *very first* completion of a level, this event fires simultaneously (or near-simultaneously) with the `LEVEL_COMPLETE` event to log their initial score.

**Your Task:** Write a query to find the `initial_high_score` for every `user_id` and `level_id` pair. The "initial high score" is defined as the score from the `HIGH_SCORE_BEATEN` event that is associated with the *first* `LEVEL_COMPLETE` event for that user and level.

A `HIGH_SCORE_BEATEN` event is associated with a `LEVEL_COMPLETE` event if it occurs for the same user and level within 10 seconds of the `LEVEL_COMPLETE` event.

| **user_id** | **level_id** | **first_completion_time** | **initial_high_score** |
| ----------------- | ------------------ | ------------------------------- | ---------------------------- |
| 101               | 1                  | 2023-11-10 09:00:00.000         | 1500                         |
| 102               | 1                  | 2023-11-10 11:00:00.000         | 2000                         |
| 102               | 2                  | 2023-11-12 14:00:00.000         | 500                          |
| 103               | 1                  | 2023-11-11 09:30:00.000         | 900                          |
| 104               | 1                  | 2023-11-13 13:00:00.000         | NULL                         |

### Tips for Approaching the Problem

1. **Isolate Event Types:** The first step is to separate the two event types. Create a CTE for `LEVEL_COMPLETE` events (let's call it `completions`) and another for `HIGH_SCORE_BEATEN` events (`high_scores`).
2. **Find the First Completion:** The problem is about the *first* completion. In your `completions` CTE, use `ROW_NUMBER() OVER (PARTITION BY user_id, level_id ORDER BY event_timestamp ASC)` to rank the completions for each user and level.
3. **Filter for Firsts:** Create a new CTE (`first_completions`) by selecting only the rows where your `rank = 1`. This gives you a clean list of every user's first-ever completion for each level.
4. **Connect Scores to Completions:** Now, `LEFT JOIN` your `first_completions` CTE to your `high_scores` CTE. A `LEFT JOIN` is crucial because not every first completion might have a high score event (as seen with User 104).
5. **Define the Join Conditions:** The join conditions must be precise:
   * `ON first_completions.user_id = high_scores.user_id`
   * `AND first_completions.level_id = high_scores.level_id`
   * `AND high_scores.event_timestamp >= first_completions.event_timestamp` (score must be at or after completion)
   * `AND high_scores.event_timestamp < TIMESTAMPADD(SECOND, 10, first_completions.event_timestamp)` (score must be within 10 seconds after completion)

**Your Solution:**

```sql
WITH high_scores AS (
	SELECT
		user_id,
      level_id,
      event_timestamp,
      score
	FROM
		game_logs
	WHERE
		event_type = 'HIGH_SCORE_BEATEN'
),
completions AS (
	SELECT
		user_id,
      level_id,
      event_timestamp,
      event_type,
      score,
		ROW_NUMBER() OVER (PARTITION BY user_id, level_id ORDER BY event_timestamp) AS rn
	FROM
		game_logs
	WHERE
		event_type = 'LEVEL_COMPLETE'
)
SELECT
	c.user_id,
	c.level_id,
	c.event_timestamp AS first_completion_time,
	hs.score AS initial_high_score
FROM
	high_scores hs
RIGHT JOIN
 	completions c ON c.user_id = hs.user_id
 	AND c.level_id = hs.level_id
	AND hs.event_timestamp >= c.event_timestamp
	AND hs.event_timestamp < TIMESTAMPADD(SECOND, 10, c.event_timestamp)
WHERE
	c.rn = 1;
```