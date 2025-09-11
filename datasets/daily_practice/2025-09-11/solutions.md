## Puzzle: The Demoralized Courier

**The Scenario:** The operations team has a hypothesis that when a delivery courier receives a low rating (a score of 2 or less), their performance on subsequent deliveries suffers for the rest of their shift. You are tasked with verifying this by analyzing their delivery timeliness.

**Your Task:** Write a query to identify every instance where a courier received a low rating. For each of these instances, calculate the courier's average delivery lateness *before* the low-rated delivery and their average delivery lateness *after* the low-rated delivery on that same day.

Lateness is defined as the difference in minutes between the actual `ORDER_DELIVERED` time and the `estimated_delivery_time`. A negative value means the delivery was early. The analysis should only include couriers who completed at least one delivery both before and after receiving the low rating on the same day.

The final report should show the `courier_id`, the `low_rated_order_id`, the `rating_received_timestamp`, the `avg_lateness_before_bad_rating`, and the `avg_lateness_after_bad_rating`.

| courier_id | low_rated_order_id | rating_received_timestamp | avg_lateness_before_bad_rating | avg_lateness_after_bad_rating |
| ---------- | ------------------ | ------------------------- | ------------------------------ | ----------------------------- |
| 101        | 2                  | 2023-10-10 15:00:00       | -5.0000                        | 10.0000                       |

**Your Solution:**

```sql
-- Step 1: Create a clean summary for every completed order with all key timestamps and the final rating.
WITH OrderSummary AS (
    SELECT
        order_id,
        courier_id,
        MAX(CASE WHEN event_type = 'ORDER_PLACED' THEN estimated_delivery_time END) AS estimated_delivery_time,
        MAX(CASE WHEN event_type = 'ORDER_DELIVERED' THEN event_timestamp END) AS actual_delivery_time,
        MAX(CASE WHEN event_type = 'RATING_RECEIVED' THEN event_timestamp END) AS rating_received_timestamp,
        MAX(rating) AS rating
    FROM
        delivery_orders
    WHERE
        event_type IN ('ORDER_PLACED', 'ORDER_DELIVERED', 'RATING_RECEIVED')
    GROUP BY
        order_id, courier_id
    HAVING
        MAX(CASE WHEN event_type = 'ORDER_DELIVERED' THEN 1 ELSE 0 END) = 1 -- Ensure the order was actually delivered
),

-- Step 2: Calculate the lateness in minutes for every single delivery.
OrderLateness AS (
    SELECT
        order_id,
        courier_id,
        rating,
        rating_received_timestamp,
        TIMESTAMPDIFF(MINUTE, estimated_delivery_time, actual_delivery_time) AS lateness_minutes
    FROM
        OrderSummary
),

-- Step 3: Isolate the "trigger" events: the deliveries that received a low rating.
LowRatedTriggers AS (
    SELECT *
    FROM OrderLateness
    WHERE rating <= 2
)

-- Final Step: For each "trigger" event, find all other deliveries by that courier on the same day
-- and calculate the "before" and "after" averages.
SELECT
    t.courier_id,
    t.order_id AS low_rated_order_id,
    t.rating_received_timestamp,
    -- Conditionally average all deliveries that happened BEFORE the low rating
    AVG(CASE WHEN ol.rating_received_timestamp < t.rating_received_timestamp THEN ol.lateness_minutes END) AS avg_lateness_before_bad_rating,
    -- Conditionally average all deliveries that happened AFTER the low rating
    AVG(CASE WHEN ol.rating_received_timestamp > t.rating_received_timestamp THEN ol.lateness_minutes END) AS avg_lateness_after_bad_rating
FROM
    LowRatedTriggers t
-- Join back to the full list of that courier's deliveries
JOIN
    OrderLateness ol ON t.courier_id = ol.courier_id
    -- Ensure we are only comparing deliveries on the same day
    AND DATE(t.rating_received_timestamp) = DATE(ol.rating_received_timestamp)
GROUP BY
    t.courier_id,
    t.order_id,
    t.rating_received_timestamp
HAVING
    -- This is the crucial final filter from the prompt
    COUNT(CASE WHEN ol.rating_received_timestamp < t.rating_received_timestamp THEN 1 END) > 0
    AND COUNT(CASE WHEN ol.rating_received_timestamp > t.rating_received_timestamp THEN 1 END) > 0;
```
