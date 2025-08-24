## Scenario 1: Dispatch Efficiency Analysis

**Objective:** As an operations manager, you need to measure the efficiency of the courier dispatch system. A key metric is the "time-to-assign," which is the duration between an order being created and a courier being assigned.

**Task:** For every order that was successfully assigned a courier, calculate the `time_to_assign_seconds`. The final report should show the `order_id`, the `restaurant_id`, the timestamp when the order was `created`, the timestamp when it was `assigned`, and the calculated `time_to_assign_seconds`.

Order the results by `order_id`.

**Expected Output:**

| order_id | restaurant_id | created_at          | assigned_at                | time_to_assign_seconds |
| -------- | ------------- | ------------------- | -------------------------- | ---------------------- |
| 101      | 1             | 2023-12-05 12:00:00 | 2023-12-05 12:00:45.500000 | 45.50                  |
| 102      | 2             | 2023-12-05 18:30:00 | 2023-12-05 18:33:10.200000 | 190.20                 |
| 103      | 1             | 2023-12-05 12:05:00 | 2023-12-05 12:06:00        | 60.00                  |
| 104      | 3             | 2023-12-05 12:10:00 | 2023-12-05 12:11:00        | 60.00                  |
| 105      | 2             | 2023-12-06 12:30:00 | 2023-12-06 12:30:30        | 30.00                  |
| 106      | 1             | 2023-12-06 19:00:00 | 2023-12-06 19:04:00        | 240.00                 |

**Your Solution:**

```sql
SELECT
	creations.order_id,
	creations.restaurant_id,
	creations.log_timestamp AS created_at,
	assignments.log_timestamp AS assigned_at,
	ROUND(TIMESTAMPDIFF(MICROSECOND, creations.log_timestamp, assignments.log_timestamp) / 1000000.0, 2) AS time_to_assign_seconds
FROM
	delivery_dispatch_logs creations
JOIN
	delivery_dispatch_logs assignments ON creations.order_id = assignments.order_id
	AND creations.restaurant_id = assignments.restaurant_id
WHERE
	creations.event_type = 'ORDER_CREATED'
	AND assignments.event_type = 'COURIER_ASSIGNED'
ORDER BY
	creations.order_id;
```

## Scenario 2: Courier Performance by Time of Day

**Objective:** You want to identify the most efficient couriers during different meal rushes. Efficiency is measured by "time-to-pickup": the duration between a courier being assigned an order and them picking it up.

**Task:**

1. Categorize each picked-up order into a `meal_rush` period: 'Lunch' (11:00 - 14:00) or 'Dinner' (18:00 - 21:00).
2. For each `meal_rush` period, find the `courier_id` with the lowest average `time_to_pickup_minutes`.
3. The report should show the `meal_rush`, the `best_courier_id`, and their `avg_time_to_pickup_minutes` for that period.

**Expected Output:**

| meal_rush | courier_id | avg_time_to_pickup_minutes |
| --------- | ---------- | -------------------------- |
| Dinner    | 503        | 21.00000000                |
| Lunch     | 501        | 12.91110000                |

**Your Solution:**

```sql
WITH meal_rushes AS (
	SELECT
		assignments.courier_id,
		CASE
			WHEN HOUR(pickups.log_timestamp) BETWEEN 11 AND 14 THEN 'Lunch'
			WHEN HOUR(pickups.log_timestamp) BETWEEN 18 AND 21 THEN 'Dinner'
		END AS meal_rush,
		TIMESTAMPDIFF(SECOND, assignments.log_timestamp, pickups.log_timestamp) / 60 AS time_to_pickup
	FROM
		delivery_dispatch_logs assignments
	JOIN
		delivery_dispatch_logs pickups ON assignments.log_timestamp  < pickups.log_timestamp
		AND assignments.order_id = pickups.order_id
	WHERE
		assignments.event_type = 'COURIER_ASSIGNED'
		AND pickups.event_type = 'ORDER_PICKED_UP'
),
averages AS (
	SELECT
		meal_rush,
		courier_id,
		AVG(time_to_pickup) AS avg_time_to_pickup_minutes
	FROM
		meal_rushes
	GROUP BY
		meal_rush,
		courier_id
),
ranked_deliveries AS (
	SELECT
		meal_rush,
		courier_id,
		avg_time_to_pickup_minutes,
		ROW_NUMBER() OVER (PARTITION BY meal_rush ORDER BY avg_time_to_pickup_minutes) AS rn
	FROM
		averages
)
SELECT
	meal_rush,
	courier_id,
	avg_time_to_pickup_minutes
FROM
	ranked_deliveries
WHERE
	rn = 1;
```
