## Puzzle: The Ride-Sharing Funnel

**The Scenario:** As a data analyst for a ride-sharing company, you need to understand the lifecycle of a trip. The raw event data is sequential, but you need to present it as a summary for each trip, showing how long each stage took.

**Your Task:** Write a query that transforms the event log into a trip summary. For each `trip_id`, you need to calculate the duration in seconds for each key stage of the funnel:

1. `driver_wait_seconds`: Time from `REQUEST` to `ACCEPT`.
2. `rider_wait_seconds`: Time from `ACCEPT` to `PICKUP`.
3. `trip_duration_seconds`: Time from `PICKUP` to `DROPOFF`.
4. `time_to_cancel_seconds`: Time from the *previous event* to either `CANCEL_RIDER` or `CANCEL_DRIVER`.
5. `final_status`: The last known status of the trip (`DROPOFF`, `CANCEL_RIDER`, `CANCEL_DRIVER`, or `REQUEST` if it timed out).

If a stage did not occur for a trip (e.g., `trip_duration_seconds` for a cancelled trip), the value should be `NULL`.

| trip_id | driver_wait_seconds | rider_wait_seconds | trip_duration_seconds | time_to_cancel_seconds | final_status  |
| ------- | ------------------- | ------------------ | --------------------- | ---------------------- | ------------- |
| 101     | 60                  | 240                | 600                   |                        | DROPOFF       |
| 102     | 60                  |                    |                       | 120                    | CANCEL_DRIVER |
| 103     |                     |                    |                       | 60                     | CANCEL_RIDER  |
| 104     | 90                  | 390                | 720                   |                        | DROPOFF       |
| 105     |                     |                    |                       |                        | REQUEST       |

**Your Solution:**

```sql
WITH trip_times AS (
	SELECT
		trip_id,
		MIN(CASE WHEN event_type = 'REQUEST' THEN event_timestamp END) AS request_time,
		MIN(CASE WHEN event_type = 'ACCEPT' THEN event_timestamp END) AS accept_time,
		MIN(CASE WHEN event_type = 'PICKUP' THEN event_timestamp END) AS pickup_time,
		MIN(CASE WHEN event_type = 'DROPOFF' THEN event_timestamp END) AS dropoff_time,
		MIN(CASE WHEN event_type IN ('CANCEL_RIDER', 'CANCEL_DRIVER') THEN event_timestamp END) AS cancel_time
	FROM
		trip_events
	GROUP BY
		trip_id
),
trip_categories AS (
	SELECT
		trip_id,
		ROUND(TIMESTAMPDIFF(SECOND, request_time, accept_time), 2) AS driver_wait_seconds,
		ROUND(TIMESTAMPDIFF(SECOND, accept_time, pickup_time ), 2) AS rider_wait_seconds,
		ROUND(TIMESTAMPDIFF(SECOND, pickup_time, dropoff_time), 2) AS trip_duration_seconds,
		ROUND(TIMESTAMPDIFF(SECOND, COALESCE(dropoff_time, pickup_time, accept_time, request_time),cancel_time), 2) AS time_to_cancel_seconds
	FROM
		trip_times
)
SELECT
	trip_id,
	driver_wait_seconds,
	rider_wait_seconds,
	trip_duration_seconds,
	time_to_cancel_seconds,
	CASE
		WHEN driver_wait_seconds IS NULL AND time_to_cancel_seconds IS NOT NULL THEN 'CANCEL_RIDER'
		WHEN rider_wait_seconds IS NULL AND time_to_cancel_seconds IS NOT NULL THEN 'CANCEL_DRIVER'
		WHEN time_to_cancel_seconds IS NULL AND trip_duration_seconds IS NOT NULL THEN 'DROPOFF'
		WHEN time_to_cancel_seconds IS NULL AND driver_wait_seconds IS NULL THEN 'REQUEST'
		ELSE 'UNKNOWN'
	END AS final_status

FROM
	trip_categories;
```
