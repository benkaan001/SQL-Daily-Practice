## Puzzle: The Viral Hit Detector

**The Scenario:** As a music platform analyst, you need to identify "viral hits" before they become mainstream. A key indicator of a song going viral is a sustained, rapid increase in its daily play count.

**Your Task:** Write a query to find all songs that have a "viral streak." A viral streak is defined as a period where the song's total daily play count increases by at least 100% (i.e., doubles or more) for 3 or more consecutive days.

The final report should show the `song_id`, `artist_id`, the `streak_start_date` (the first day of the 3+ day streak), the `streak_end_date` (the last day of the streak), and the `streak_length_days`.

| **song_id** | **artist_id** | **streak_start_date** | **streak_end_date** | **streak_length_days** |
| ----------------- | ------------------- | --------------------------- | ------------------------- | ---------------------------- |
| 1001              | 50                  | 2023-10-10                  | 2023-10-13                | 4                            |

### Tips for Approaching the Problem

1. **Calculate Daily Plays:** First, you need to get the total play count for each `song_id` on each day. A `GROUP BY DATE(play_timestamp), song_id, artist_id` is the perfect start.
2. **Find the Previous Day's Count:** To check for growth, you need to compare a day's play count to the previous day's count. The `LAG()` window function is ideal. Partition by `song_id, artist_id` and order by the date to get the `previous_day_play_count`.
3. **Identify Growth Days:** In a new CTE, use the `LAG()` result to create a "growth flag." Set a flag to `1` if the `current_day_play_count >= previous_day_play_count * 2`, and `0` otherwise. Also, handle the first day of data (where `LAG` is `NULL`) as a `0`.
4. **Group Consecutive Streaks (Gaps and Islands):** This is the key part of the puzzle. You need to group consecutive days where your `growth_flag` is `1`. A common method is to create two running counts:
   * `ROW_NUMBER()` over `(PARTITION BY song_id, artist_id ORDER BY date)`
   * `ROW_NUMBER()` over `(PARTITION BY song_id, artist_id, growth_flag ORDER BY date)`
   * The difference between these two row numbers will be a constant value for any continuous streak of the same `growth_flag`.
5. **Aggregate the Streaks:** `GROUP BY` your `song_id`, `artist_id`, your `growth_flag`, and the "difference" ID you just created. This groups all consecutive days of growth together.
6. **Final Filtering:** In your final `SELECT`, you can now `COUNT(*)` to get the `streak_length_days`, and find the `MIN(date)` and `MAX(date)` to get the streak start/end. Filter for `WHERE growth_flag = 1` and `streak_length_days >= 3`.

**Your Solution:**

```sql
-- Write your solution here
```
