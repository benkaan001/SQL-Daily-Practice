## Puzzle: The "Fastest Climbers" Chart

**The Scenario:** As a data engineer for a music streaming platform, the marketing team wants you to build the backend logic for a "Fastest Climbers" playlist. This playlist highlights songs that have jumped up the charts significantly compared to the previous week.

**Your Task:** Write a query to find all songs that experienced a positive rank increase from their previous week on the chart.

**Rules:**

1. A song's total score is calculated using a weighted formula: `(streams * 0.01) + downloads`.
2. Rank the songs for each specific `week_date` based on this score. Rank `1` goes to the highest score. If there is a tie in score, rank them alphabetically by `song_name`. Use the `RANK()` function.
3. Calculate the `rank_jump` for each song. A jump is defined as the `previous_week_rank` minus the `current_rank`. (e.g., Moving from Rank 4 to Rank 1 is a jump of `3`).
4. Filter out any songs that are "New Entries" (they were not on the chart in the immediately preceding week's data).

The final report should output the `song_name`, the `previous_week` date, the `current_week` date, the `previous_rank`, the `current_rank`, and the `rank_jump`.

Order the results by `rank_jump` descending, then by `song_name` ascending.

**Expected Output:**

| **song_name** | **previous_week** | **current_week** | **previous_rank** | **current_rank** | **rank_jump** |
| ------------------- | ----------------------- | ---------------------- | ----------------------- | ---------------------- | ------------------- |
| Asteroid Anthem     | 2026-05-08              | 2026-05-15             | 4                       | 1                      | 3                   |
| Lunar Lullaby       | 2026-05-01              | 2026-05-08             | 4                       | 2                      | 2                   |
| Asteroid Anthem     | 2026-05-01              | 2026-05-08             | 5                       | 4                      | 1                   |
| Neon Nights         | 2026-05-01              | 2026-05-08             | 2                       | 1                      | 1                   |

### Tips for Approaching the Problem

This puzzle requires layering two different types of window functions on top of each other.

1. **Calculate the Score:** Create your first Common Table Expression (CTE). Calculate the raw total score for every row using the formula provided.
2. **The First Window (Ranking):** In the same CTE (or a second one), use the `RANK()` window function. You need a separate ranking for each week, so you must `PARTITION BY week_date`. Order the window descending by your calculated score, and ascending by the song name to handle ties properly.
3. **The Second Window (Time Travel):** Now that you have every song's official rank for every week, you need to compare weeks. In a new CTE, use the `LAG()` window function.
   * This time, you want to track a specific song's journey over time, so you must `PARTITION BY song_name`.
   * Order the window by `week_date` ascending.
   * Pull both the previous week's date and the previous week's rank.
4. **Filter and Math:** In your final `SELECT` statement, query from your second window CTE.
   * Apply a `WHERE` clause to filter out `NULL` previous ranks (the new entries).
   * Filter where the calculated `previous_rank - current_rank` is strictly greater than `0`.

**Your Solution:**

```sql
-- Write your solution here
```
