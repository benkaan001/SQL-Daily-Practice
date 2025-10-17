
## Puzzle: The Disconnected Device Detector

**The Scenario:** As an IoT platform administrator, you are responsible for monitoring the health and uptime of a fleet of remote devices. A critical part of your job is to detect when a device has gone offline unexpectedly so that a support ticket can be generated.

**Your Task:** Write a query to identify every instance where a device is considered to have gone "offline." A device is marked as offline if there is a time gap of **more than 10 minutes** between its consecutive `ONLINE` heartbeat events.

The final report should show the `device_id`, the timestamp of its `last_seen_online` heartbeat before the gap, and the `offline_duration_minutes` (the time between the last seen heartbeat and the next heartbeat of any kind).

| **device_id** | **last_seen_online** | **offline_duration_minutes** |
| ------------------- | -------------------------- | ---------------------------------- |
| D-001               | 2023-10-15 10:05:00.000    | 15.00                              |
| D-002               | 2023-10-15 11:10:00.000    | 35.00                              |
| D-004               | 2023-10-15 13:05:00.000    | 30.00                              |

### Tips for Approaching the Problem

1. **Look at Consecutive Events:** The core of the problem is comparing each heartbeat event to the one that comes immediately after it for the same device. The `LEAD()` window function is the perfect tool for this, as it can "look ahead" in your ordered dataset.
2. **Partition and Order:** When using `LEAD()`, you must `PARTITION BY device_id` to look at each device's history separately. The history needs to be in chronological order, so you must `ORDER BY event_timestamp`.
3. **Fetch the Next Timestamp:** Use `LEAD(event_timestamp)` in a CTE to get the timestamp of the *next* event and attach it to each row. This allows you to easily compare the current event's time with the next one's.
4. **Calculate the Gap and Filter:** In your final `SELECT` statement, query from the CTE you created.
   * Filter for rows where the `status` is `ONLINE`, as the gap must start from an online heartbeat.
   * Calculate the time difference in minutes between the `next_event_timestamp` and the current `event_timestamp`. A function like `TIMESTAMPDIFF()` is ideal.
   * Add a `WHERE` clause to only include rows where this calculated time difference is greater than 10 minutes.

**Your Solution:**

```sql
WITH seen_times AS (
	SELECT
		device_id,
		event_timestamp,
		status,
		LEAD(event_timestamp, 1) OVER (PARTITION BY device_id ORDER BY event_timestamp) AS next_event_timestamp
	FROM
		device_heartbeats
)
SELECT
	device_id,
	event_timestamp,
	ROUND(TIMESTAMPDIFF(MINUTE, event_timestamp, next_event_timestamp), 2) AS offline_duration_minutes
FROM
	seen_times
WHERE
	TIMESTAMPDIFF(MINUTE, event_timestamp, next_event_timestamp) > 10
	AND status = 'ONLINE';
```