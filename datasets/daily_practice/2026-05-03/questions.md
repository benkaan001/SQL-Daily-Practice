## Puzzle: The Traveling Courier (Asymmetrical Joins)

**The Scenario:** The logistics department tracks the daily routes of its delivery drivers. To reimburse them for gas, the team needs to calculate the exact distance each driver traveled. The database stores the sequence of cities each driver visited.

However, the `distance_matrix` table is highly optimized. To prevent redundant data, the distance between two cities is only stored once. The cities are sorted alphabetically into the `location_a` and `location_b` columns (e.g., the distance for a trip from 'Seattle' to 'Austin' is stored as `location_a = 'Austin'` and `location_b = 'Seattle'`).

**Your Task:** Write a query to calculate the total distance traveled and the number of "legs" (segments between two cities) driven by each driver.

*Rules:*

1. If a driver only made 1 stop (meaning they never traveled to a second city), their `total_legs` should be `0` and their `total_distance_km` should be `0`.
2. Drivers who traveled multiple legs should have the total sum of the distances between their consecutive stops.

The final report should show the `driver_id`, the `total_legs`, and the `total_distance_km`. Order the results by `total_distance_km` in descending order, then by `driver_id`.

**Expected Output:**

| **driver_id** | **total_legs** | **total_distance_km** |

| 102 | 3 | 6650 |

| 104 | 1 | 1450 |

| 101 | 2 | 560 |

| 103 | 0 | 0 |

*(Math check for Driver 102: Seattle -> Denver (2100) + Denver -> Austin (1450) + Austin -> Portland (3100) = 6650 km across 3 legs).*

### Tips for Approaching the Problem

1. **Construct the Legs:** To calculate distance, you need a starting point and an ending point on the same row. Use the `LEAD()` window function to peek at the *next* `stop_name` for a driver. Partition your window by `driver_id` and order it by `sequence_num`.
2. **The Alphabetical Join:** Now you need to join your generated "legs" to the `distance_matrix`. But since a driver might travel from 'Seattle' to 'Austin' (Z to A), while the matrix stores 'Austin' to 'Seattle' (A to Z), a simple `= AND =` join will fail half the time.
   * *The Trick:* Use the `LEAST()` and `GREATEST()` scalar functions inside your `JOIN` conditions!
   * `ON LEAST(current_stop, next_stop) = matrix.location_a`
   * `AND GREATEST(current_stop, next_stop) = matrix.location_b`
3. **Handle Single Stops (NULLs):** For the last stop of every driver (or the *only* stop for Driver 103), the `LEAD()` function will return `NULL`. A `LEFT JOIN` to the distance matrix will elegantly leave the distance for these "non-legs" as `NULL`.
4. **Aggregate Safely:** Group your final results by `driver_id`.
   * Use `COUNT(next_stop)` to safely count only the valid legs (ignoring the `NULL` next stops at the end of the route).
   * Use `COALESCE(SUM(distance_km), 0)` to sum up the mileage and ensure that a driver with 0 legs returns `0` instead of `NULL`.

**Your Solution:**

```sql
-- Write your solution here
```
