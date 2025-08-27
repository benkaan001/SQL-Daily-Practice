## Scenario 1: In-Game Economy - Time-to-Purchase After Level Up

**Objective:** The game design team needs to understand the "velocity" of in-game items—how quickly players purchase items after they become available through leveling up.

**Task:** For each time a player levels up, find the very first `ITEM_PURCHASE` they make *after* that level-up event. Calculate the time difference in minutes between the `LEVEL_UP` and the subsequent purchase.

The final report should show the `player_id`, the `new_level` they achieved, the `item_id` of their first purchase after leveling up, and the `time_to_purchase_minutes`. If a player levels up but makes no subsequent purchases, they should not appear in the results.

**Expected Output:**

| player_id | new_level | MIN(item_id)   | MIN(time_to_purchase_minutes) |
| --------- | --------- | -------------- | ----------------------------- |
| 102       | 5         | sword_of_valor | 5                             |
| 105       | 5         | shield_of_ages | 2                             |

**Your Solution:**

```sql
-- Step 1: Isolate all 'LEVEL_UP' events to serve as our starting point
WITH LevelUpEvents AS (
    SELECT
        player_id,
        event_timestamp AS level_up_time,
        JSON_UNQUOTE(JSON_EXTRACT(details, '$.new_level')) AS new_level
    FROM
        game_events
    WHERE
        event_type = 'LEVEL_UP'
),

-- Step 2: For each level-up event, find all subsequent purchases and rank them by time
RankedPurchases AS (
    SELECT
        lu.player_id,
        lu.new_level,
        lu.level_up_time,
        p.event_timestamp AS purchase_time,
        JSON_UNQUOTE(JSON_EXTRACT(p.details, '$.item_id')) AS item_id,
        -- This ranks all of a player's purchases that happened after they leveled up.
        -- The one with rank = 1 is the first one.
        ROW_NUMBER() OVER (
            PARTITION BY lu.player_id, lu.level_up_time
            ORDER BY p.event_timestamp
        ) AS purchase_rank
    FROM
        LevelUpEvents lu
    JOIN
        game_events p ON lu.player_id = p.player_id
    WHERE
        p.event_type = 'ITEM_PURCHASE'
        -- The purchase must happen after the level-up
        AND p.event_timestamp > lu.level_up_time
)

-- Final Step: Select only the #1 ranked purchase for each level-up event
SELECT
    player_id,
    new_level,
    item_id,
    ROUND(TIMESTAMPDIFF(SECOND, level_up_time, purchase_time) / 60.0, 2) AS time_to_purchase_minutes
FROM
    RankedPurchases
WHERE
    purchase_rank = 1
ORDER BY
    player_id;
```

## Scenario 2: Matchmaking Fairness Audit

**Objective:** The competitive integrity team is investigating claims of unfair matchmaking. You need to audit matches to see which players are frequently being placed in "unfair" losses.

**Task:**

1. An "unfair loss" is a `MATCH_END` event where a player is the `loser_id` and the `winner_level` is at least 5 levels greater than the `loser_level`.
2. For every player who has participated in at least one match, calculate the total number of matches they've played and the percentage of those matches that were "unfair losses".
3. The final report should flag any player whose `unfair_loss_rate` is 50% or greater.

**Expected Output:**

| player_id | total_matches_played | unfair_loss_rate | is_flagged |
| --------- | -------------------- | ---------------- | ---------- |
| 101       | 2                    | 0.00             | false      |
| 103       | 2                    | 50.00            | true       |
| 104       | 1                    | 0.00             | false      |

**Your Solution:**

```sql
WITH matches AS (
	SELECT
		event_id,
		player_id,
		event_type,
		JSON_UNQUOTE(JSON_EXTRACT(details, '$.match_id')) AS match_id,
		JSON_UNQUOTE(JSON_EXTRACT(details, '$.winner_level')) AS winner_level,
		JSON_UNQUOTE(JSON_EXTRACT(details, '$.loser_level')) AS loser_level,
		JSON_UNQUOTE(JSON_EXTRACT(details, '$.winner_id')) AS winner_id,
		JSON_UNQUOTE(JSON_EXTRACT(details, '$.loser_id')) AS loser_id
	FROM
		game_events
	WHERE
		event_type = 'MATCH_END'
),
stats AS (
	SELECT
		player_id,
		COUNT(*) as total_matches_played,
		SUM(CASE WHEN winner_level - loser_level >= 5 AND loser_id = player_id THEN 1 ELSE 0 END) AS unfair_loss_count
	FROM
		matches
	GROUP BY
		player_id
	HAVING
		total_matches_played >= 1
)
SELECT
	player_id,
	total_matches_played,
	ROUND(unfair_loss_count * 100.0 / total_matches_played, 2) AS unfair_loss_rate,
	CASE WHEN unfair_loss_count * 100.0 / total_matches_played >= 50.00 THEN 'true' ELSE 'false' END AS is_flagged
FROM
	stats;
```
