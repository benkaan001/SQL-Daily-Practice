## Puzzle: The Time-Weighted Average Temperature

**The Scenario:** A commercial farm uses smart sensors to monitor greenhouse temperatures. The system is designed to save bandwidth: it doesn't log the temperature every minute. Instead, it only logs a new row when the temperature actually  *changes* .

The agricultural scientists need to know the true average temperature for the standard 8-hour workday window (from  **08:00:00 to 16:00:00** ). If a room is 20°C for 7 hours and 30°C for 1 hour, the true average is much closer to 20°C, even though a simple SQL `AVG()` of the two numbers would output 25°C!

**Your Task:** Calculate both the "simple" average and the "time-weighted" average temperature for each sensor for the 8-hour window on April 27th.

**Rules for Time-Weighted Average:**

1. The analysis window starts exactly at `'2026-04-27 08:00:00'` and ends exactly at `'2026-04-27 16:00:00'` (Total duration: 8 hours, or 480 minutes).
2. The duration of any given temperature reading is the time difference in minutes between its `recorded_at` timestamp and the `recorded_at` timestamp of the *next* reading.
3. For the very last reading of the day, its duration lasts until the exact end of the window (`16:00:00`).
4. Formula: `SUM(temperature * duration_in_minutes) / Total_Window_Minutes`

The final report should show the `sensor_id`, the `simple_avg_temp` (standard average of the rows), and the true `time_weighted_avg_temp`. Round both averages to 2 decimal places.

**Expected Output:**

| **sensor_id** | **simple_avg_temp** | **time_weighted_avg_temp** |

| GH-1 | 23.33 | 22.50 |

| GH-2 | 25.00 | 26.88 |

| GH-3 | 25.00 | 24.08 |

### Tips for Approaching the Problem

1. **Find the End Time for Each Row:** To calculate how long a temperature state lasted, you need the timestamp of the *next* reading. The `LEAD()` window function, partitioned by `sensor_id` and ordered by `recorded_at`, is perfect for this.
2. **Handle the Cutoff:** The very last reading for a sensor won't have a "next" row, so `LEAD()` will return `NULL`. Use `COALESCE` or `IFNULL` to replace that `NULL` with the exact end of the reporting window: `'2026-04-27 16:00:00'`.
3. **Calculate Duration:** In a CTE, use a time-difference function like `TIMESTAMPDIFF(MINUTE, current_time, next_time)` to calculate exactly how many minutes the room stayed at that temperature.
4. **Aggregate:** In your final `SELECT` statement, group by `sensor_id`.
   * Calculate the `simple_avg_temp` using the standard `AVG(temperature)`.
   * Calculate the `time_weighted_avg_temp` by taking `SUM(temperature * duration_in_minutes)` and dividing by the total minutes in the 8-hour window (480.0).

**Your Solution:**

```sql
-- Write your solution here
```
