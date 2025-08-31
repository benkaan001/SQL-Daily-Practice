## Question 1: Driver Work Session Analysis

Group individual trips into "work sessions" for each driver. A new session begins for a driver if the time between the end of their last trip and the start of their next trip is more than 4 hours.

For each session, calculate the `driver_id`, a unique `session_id` (e.g., by date and session number for that driver), the `session_start_time`, `session_end_time`, `total_trips_in_session`, and the `total_fare_in_session`.

Order the results by `driver_id` and then by `session_start_time`.

**Expected Output:**

| **driver_id** | **session_id** | **session_start_time** | **session_end_time** | **total_trips_in_session** | **total_fare_in_session** |
| ------------------- | -------------------- | ---------------------------- | -------------------------- | -------------------------------- | ------------------------------- |
| 101                 | 1                    | 2023-11-15 08:00:00          | 2023-11-15 09:30:00        | 3                                | 45.50                           |
| 101                 | 2                    | 2023-11-15 14:00:00          | 2023-11-15 14:45:00        | 1                                | 35.00                           |
| 101                 | 3                    | 2023-11-17 08:00:00          | 2023-11-17 08:25:00        | 1                                | 16.50                           |
| 102                 | 1                    | 2023-11-15 10:00:00          | 2023-11-15 10:45:00        | 2                                | 20.50                           |
| 102                 | 2                    | 2023-11-16 08:00:00          | 2023-11-16 08:30:00        | 1                                | 16.00                           |
| 102                 | 3                    | 2023-11-17 08:05:00          | 2023-11-17 08:30:00        | 1                                | 16.80                           |
| 102                 | 4                    | 2023-11-18 09:00:00          | 2023-11-18 09:20:00        | 1                                | 10.20                           |
| 103                 | 1                    | 2023-11-15 18:00:00          | 2023-11-15 20:10:00        | 3                                | 77.00                           |
| 104                 | 1                    | 2023-11-16 17:00:00          | 2023-11-16 17:20:00        | 1                                | 20.00                           |
| 105                 | 1                    | 2023-11-16 17:05:00          | 2023-11-16 17:25:00        | 1                                | 20.80                           |
| 106                 | 1                    | 2023-11-16 17:10:00          | 2023-11-16 17:30:00        | 1                                | 19.20                           |

**Your Solution:**

```sql
-- Write your solution here
```

## Question 2: Identifying Drivers Potentially Impacted by Low Ratings

Identify drivers whose average passenger rating dropped significantly after receiving a low rating. A "low rating" is defined as a score of 2 or less.

The goal is to compare a driver's average rating *before* the low-rated trip with their average rating *after* that trip. The report should only include drivers who have received at least one low rating and have completed at least one trip both before and after the low-rated trip.

The output should show the `driver_id`, the `low_rated_trip_id`, the driver's `avg_rating_before`, and their `avg_rating_after`.

**Expected Output:**

| **driver_id** | **low_rated_trip_id** | **avg_rating_before** | **avg_rating_after** |
| ------------------- | --------------------------- | --------------------------- | -------------------------- |
| 103                 | 9                           | 5.00                        | 4.00                       |

**Your Solution:**

```sql
-- Write your solution here
```

## Question 3: Zone-to-Zone Trip Analysis with Lag

For each distinct route (a `pickup_zone_id` to `dropoff_zone_id` pair), analyze the trip dynamics. The report should calculate the total number of trips, the average fare, and the average duration in minutes for that route.

Additionally, for each trip on a given route, calculate the `time_since_last_trip_on_route_minutes`. This is the time difference in minutes between the start of the current trip and the start of the immediately preceding trip  *on that same route* . The first trip on any route should have a NULL value for this metric.

The final report should show all trips, ordered by route and then by trip start time.

**Expected Output:**

| **pickup_zone_id** | **dropoff_zone_id** | **trip_id** | **trip_start_timestamp** | **time_since_last_trip_on_route_minutes** |
| ------------------------ | ------------------------- | ----------------- | ------------------------------ | ----------------------------------------------- |
| 1                        | 10                        | 1                 | 2023-11-15 08:00:00            | NULL                                            |
| 1                        | 10                        | 13                | 2023-11-17 08:00:00            | 2880.00                                         |
| 1                        | 10                        | 14                | 2023-11-17 08:05:00            | 5.00                                            |
| 2                        | 8                         | 5                 | 2023-11-15 10:00:00            | NULL                                            |
| 2                        | 10                        | 7                 | 2023-11-16 08:00:00            | NULL                                            |
| 3                        | 12                        | 4                 | 2023-11-15 14:00:00            | NULL                                            |
| 4                        | 15                        | 8                 | 2023-11-15 18:00:00            | NULL                                            |
| 4                        | 15                        | 10                | 2023-11-15 19:35:00            | 95.00                                           |
| 5                        | 1                         | 3                 | 2023-11-15 09:00:00            | NULL                                            |
| 8                        | 2                         | 6                 | 2023-11-15 10:25:00            | NULL                                            |
| 10                       | 2                         | 16                | 2023-11-18 09:00:00            | NULL                                            |
| 10                       | 5                         | 2                 | 2023-11-15 08:30:00            | NULL                                            |
| 15                       | 4                         | 9                 | 2023-11-15 18:45:00            | NULL                                            |
| 20                       | 25                        | 11                | 2023-11-16 17:00:00            | NULL                                            |
| 20                       | 25                        | 12                | 2023-11-16 17:05:00            | 5.00                                            |
| 20                       | 25                        | 13                | 2023-11-16 17:10:00            | 5.00                                            |

**Your Solution:**

```sql
-- Write your solution here
```
