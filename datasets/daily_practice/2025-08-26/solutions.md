## Scenario 1: Player Sessionization and Churn Risk Analysis

**Objective:** The marketing team wants to identify players who are at risk of churning. A key indicator is a significant drop in playtime. Your task is to compare a player's initial engagement with their most recent engagement to flag them as "at risk".

**Task:**

1. First, group all events for each player into "sessions." A new session starts after a `LOGIN` event or if there has been more than 60 minutes of inactivity since the player's last event. A session ends at a `LOGOUT` event or the last known event before the inactivity gap.
2. For each player, calculate their average session duration during their **first 2 days** of activity.
3. Then, calculate their average session duration during their **most recent 2 days** of activity in the dataset.
4. A player is "at risk" if their recent average session duration is less than 30% of their initial average session duration.

The final report should list the `player_id`, their `initial_avg_session_minutes`, their `recent_avg_session_minutes`, and a boolean flag `is_at_risk`.

**Expected Output:**

| **player_id** | **initial_avg_session_minutes** | **recent_avg_session_minutes** | **is_at_risk** |
| ------------------- | ------------------------------------- | ------------------------------------ | -------------------- |
| 101                 | 90.00                                 | 20.00                                | true                 |
| 102                 | 120.00                                | 120.00                               | false                |
| 103                 | 55.00                                 | 55.00                                | false                |
| 105                 | NULL                                  | 2.00                                 | false                |

**Your Solution:**

```sql
-- Write your solution here
```

## Scenario 2: In-Game Economy - Time-to-Purchase After Level Up

**Objective:** The game design team needs to understand the "velocity" of in-game items—how quickly players purchase items after they become available through leveling up.

**Task:** For each time a player levels up, find the very first `ITEM_PURCHASE` they make *after* that level-up event. Calculate the time difference in minutes between the `LEVEL_UP` and the subsequent purchase.

The final report should show the `player_id`, the `new_level` they achieved, the `item_id` of their first purchase after leveling up, and the `time_to_purchase_minutes`. If a player levels up but makes no subsequent purchases, they should not appear in the results.

**Expected Output:**

| **player_id** | **new_level** | **item_id** | **time_to_purchase_minutes** |
| ------------------- | ------------------- | ----------------- | ---------------------------------- |
| 102                 | 5                   | sword_of_valor    | 5.00                               |
| 105                 | 5                   | shield_of_ages    | 2.00                               |

**Your Solution:**

```sql
-- Write your solution here
```

## Scenario 3: Matchmaking Fairness Audit

**Objective:** The competitive integrity team is investigating claims of unfair matchmaking. You need to audit matches to see which players are frequently being placed in "unfair" losses.

**Task:**

1. An "unfair loss" is a `MATCH_END` event where a player is the `loser_id` and the `winner_level` is at least 5 levels greater than the `loser_level`.
2. For every player who has participated in at least one match, calculate the total number of matches they've played and the percentage of those matches that were "unfair losses".
3. The final report should flag any player whose `unfair_loss_rate` is 50% or greater.

**Expected Output:**

| **player_id** | **total_matches_played** | **unfair_loss_rate** | **is_flagged** |
| ------------------- | ------------------------------ | -------------------------- | -------------------- |
| 101                 | 2                              | 0.00                       | false                |
| 103                 | 2                              | 50.00                      | true                 |
| 104                 | 1                              | 0.00                       | false                |
| 105                 | 1                              | 0.00                       | false                |

**Your Solution:**

```sql
-- Write your solution here
```
