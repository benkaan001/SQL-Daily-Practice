## Puzzle: The Unfair Matchmaking Audit

**The Scenario:** As a data analyst for a competitive gaming platform, you're responsible for ensuring the matchmaking system is fair. The community has reported an increase in "unbalanced" matches. Your task is to audit the match history to find evidence of these unfair games.

**Your Task:** Write a query to identify all matches that are considered "unbalanced." A match is unbalanced if:

1. The difference in the average `player_skill_rating` between the 'blue' and 'red' teams is greater than 200.
2. AND the team with the lower average skill rating was the one that suffered the `DEFEAT`.

The final report should show the `match_id`, the `blue_team_avg_skill`, the `red_team_avg_skill`, and the `losing_team`.

| **match_id** | **blue_team_avg_skill** | **red_team_avg_skill** | **losing_team** |
| ------------------ | ----------------------------- | ---------------------------- | --------------------- |
| 2                  | 1250.00                       | 1475.00                      | blue                  |
| 4                  | 2150.00                       | 2375.00                      | blue                  |

### Tips for Approaching the Problem

1. **Calculate Team Averages:** The first step is to calculate the average skill rating for both the 'blue' and 'red' teams for each match. A Common Table Expression (CTE) using conditional aggregation (`AVG(CASE WHEN player_team = 'blue' THEN ... END)`) grouped by `match_id` is a very effective way to do this.
2. **Identify the Losing Team:** In the same CTE, you also need to determine which team lost. You can use a similar conditional aggregation to find this, for example: `MIN(CASE WHEN match_outcome = 'DEFEAT' THEN player_team END)`. Since all players on the losing team will have 'DEFEAT', this will correctly return the losing team's color.
3. **Apply the Unfairness Logic:** In your final `SELECT` statement, query from the CTE you created. Your `WHERE` clause will need to check two conditions:
   * The absolute difference between `blue_team_avg_skill` and `red_team_avg_skill` is greater than 200.
   * The team that lost (`losing_team`) is the same team that had the lower average skill rating. A `CASE` statement can be useful here: `(CASE WHEN blue_team_avg_skill < red_team_avg_skill THEN 'blue' ELSE 'red' END) = losing_team`.

**Your Solution:**

```sql
WITh avg_rankings AS (
SELECT
		match_id,
		AVG(CASE WHEN player_team = 'blue' THEN player_skill_rating END) AS blue_team_avg_skill,
		AVG(CASE WHEN player_team = 'red' THEN player_skill_rating END) AS red_team_avg_skill,
		MIN(CASE WHEN match_outcome = 'DEFEAT' THEN player_team END) AS losing_team
	FROM
		game_matches
	GROUP BY
		match_id
)
SELECT
	match_id,
	blue_team_avg_skill,
	red_team_avg_skill,
	losing_team
FROM
	avg_rankings
WHERE
	ABS(blue_team_avg_skill - red_team_avg_skill) > 200
	AND
		CASE
			WHEN losing_team = 'blue' THEN blue_team_avg_skill < red_team_avg_skill
			WHEN losing_team = 'red' THEN red_team_avg_skill < blue_team_avg_skill
		END;
```

