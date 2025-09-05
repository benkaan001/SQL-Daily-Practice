## Puzzle 1: The Idle Courier

**The Scenario:** The operations team needs to understand courier downtime to optimize workforce allocation. Your task is to calculate the duration of significant "idle sessions" for each courier.

**Your Task:** An idle session begins when a courier's status first becomes `IDLE` after completing a delivery (`AT_DROPOFF`). The session ends when that courier is next `ASSIGNED` a new order. Write a query that identifies all such idle sessions lasting longer than 1 hour.

The report should show the `courier_id`, the `idle_session_start` time (the timestamp of the `AT_DROPOFF` event), the `idle_session_end` time (the timestamp of the next `ASSIGNED` event), and the `idle_duration_minutes`.

**Expected Output:**

| **courier_id** | **idle_session_start** | **idle_session_end** | **idle_duration_minutes** |
| -------------------- | ---------------------------- | -------------------------- | ------------------------------- |
| 201                  | 2023-11-25 09:15:00.000      | 2023-11-25 10:30:00.000    | 75.00                           |

**Your Solution:**

```
-- Write your solution here

```

## Puzzle 2: The Scenic Route

**The Scenario:** To ensure efficiency, you need to identify couriers who take significantly longer routes than necessary. This is measured by comparing the total distance they traveled to the direct distance between pickup and dropoff.

**Your Task:** For each completed delivery, calculate the total distance traveled by summing the Haversine distance between consecutive pings during the `EN_ROUTE_TO_DROPOFF` phase. Compare this to the direct Haversine distance between the `AT_PICKUP` location and the `AT_DROPOFF` location. Flag any delivery where the `total_distance_traveled` is more than 1.5 times the `direct_distance`.

*Note: For simplicity, you can use a simplified distance formula if Haversine is not available: `SQRT(POW((lat2-lat1)*111.32, 2) + POW((lon2-lon1)*111.32*COS(lat1/57.3), 2))` for distance in km.*

**Expected Output:**

| **order_id** | **courier_id** | **direct_distance_km** | **total_distance_traveled_km** | **efficiency_ratio** |
| ------------------ | -------------------- | ---------------------------- | ------------------------------------ | -------------------------- |
| 103                | 202                  | 2.11                         | 6.64                                 | 3.15                       |

**Your Solution:**

```
-- Write your solution here

```

## Puzzle 3: The Speeding Alert

**The Scenario:** The safety team needs to be alerted when a courier is speeding. A speeding alert is triggered if a courier has 3 or more consecutive pings where their `speed_kmh` is greater than 60 while they are `EN_ROUTE_TO_DROPOFF`.

**Your Task:** Write a query to find these speeding incidents. The report should identify the `courier_id`, the `order_id`, and the `alert_timestamp`, which is the timestamp of the 3rd consecutive speeding ping.

**Expected Output:**

| **courier_id** | **order_id** | **alert_timestamp** |
| -------------------- | ------------------ | ------------------------- |
| 203                  | 104                | 2023-11-26 14:08:00.000   |

**Your Solution:**

```
-- Write your solution here

```
