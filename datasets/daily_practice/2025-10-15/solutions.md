## Puzzle: The Guild Armory Census

**The Scenario:** The guild masters of a fantasy world are preparing for an inter-realm tournament. To assess their readiness, they need an inventory report—a census of the armaments held by all of their members.

**Your Task:** Write a query to create a "Guild Armory Report." For each guild, the report must show the `guild_name`, the total number of `members`, and a pivoted summary of their combined inventory. The summary should show the total quantity of items for each of the main combat types: `total_weapons`, `total_armor`, and `total_potions`. 'Quest Item' types should be ignored.

The final report should include all guilds, even those with no members or no relevant items, and be ordered by `guild_name`.

| **guild_name** | **members** | **total_weapons** | **total_armor** | **total_potions** |
| -------------------- | ----------------- | ----------------------- | --------------------- | ----------------------- |
| Circle of Magi       | 1                 | 1                       | 1                     | 0                       |
| Horde Vanguard       | 3                 | 1                       | 2                     | 60                      |
| The Silent Blades    | 0                 | 0                       | 0                     | 0                       |
| The Silver Hand      | 3                 | 3                       | 6                     | 20                      |


### Tips for Approaching the Problem

1. **Start with the Guilds:** The report needs to include all guilds, even empty ones. This means you should start your query with the `guilds` table and use `LEFT JOIN` to connect to the other tables.
2. **Connect the Tables:**
   * `LEFT JOIN` `guilds` to `guild_members` on `guild_id`.
   * Then, `LEFT JOIN` the result to `player_inventory` on `player_id`.
3. **Pivot with Conditional Aggregation:** The main challenge is to pivot the `item_type`s into columns. This is a perfect use case for conditional aggregation. After grouping by `guild_name`, use expressions like:
   * `SUM(CASE WHEN item_type = 'Weapon' THEN quantity ELSE 0 END) AS total_weapons`
   * Repeat this pattern for 'Armor' and 'Potion'.
   * Remember to handle `NULL` quantities that may result from the `LEFT JOIN` by using `COALESCE(quantity, 0)`.
4. **Count the Members:** To get the total member count for each guild, you can use `COUNT(DISTINCT gm.player_id)`. The `DISTINCT` is important, and using a column from `guild_members` ensures that you only count players who are actually in a guild.

**Your Solution:**

```sql
SELECT
	g.guild_name,
	COUNT(DISTINCT pi.player_id) AS members,
	SUM(CASE WHEN pi.item_type = 'Weapon' THEN pi.quantity  ELSE 0 END) AS total_weapons,
	SUM(CASE WHEN pi.item_type = 'Armor' THEN pi.quantity  ELSE 0 END) AS total_armor,
	SUM(CASE WHEN pi.item_type = 'Potion' THEN pi.quantity ELSE 0 END) AS toalt_potions
FROM
	guilds g
LEFT JOIN
	guild_members gm ON g.guild_id = gm.guild_id
LEFT JOIN
	player_inventory pi ON pi.player_id = gm.player_id
GROUP BY
	g.guild_name
ORDER BY
	g.guild_name;
```
