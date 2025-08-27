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
-- Write your solution here
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
-- Write your solution here
```
