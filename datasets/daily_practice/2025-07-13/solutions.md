# SQL Daily Practice - 2025-07-13

### Question 1: Carrier Performance Analysis

For each `carrier`, calculate the `total_shipments`, `on_time_percentage`, `early_percentage`, and `late_percentage`.

* 'On Time' if `actual_delivery_date` = `planned_delivery_date`.
* 'Early' if `actual_delivery_date` < `planned_delivery_date`.
* 'Late' if actual_delivery_date > planned_delivery_date.
  Only consider shipments that have been delivered.
  Round percentages to two decimal places.
  Output carrier, total_shipments, on_time_percentage, early_percentage, and late_percentage.
  Order the results by carrier ascending.

**Expected Output:**

| carrier | total_shipments | on_time_percentage | early_percentage | late_percentage |
| ------- | --------------- | ------------------ | ---------------- | --------------- |
| DHL     | 3               | 0.00               | 66.67            | 33.33           |
| FedEx   | 2               | 50.00              | 50.00            | 0.00            |
| UPS     | 2               | 100.00             | 0.00             | 0.00            |

**Your Solution:**

```sql
SELECT
    s.carrier,
    COUNT(s.shipment_id) AS total_shipments,
    ROUND(SUM(CASE WHEN s.actual_delivery_date = s.planned_delivery_date THEN 1 ELSE 0 END) * 100.0 / COUNT(s.shipment_id), 2) AS on_time_percentage,
    ROUND(SUM(CASE WHEN s.actual_delivery_date < s.planned_delivery_date THEN 1 ELSE 0 END) * 100.0 / COUNT(s.shipment_id), 2) AS early_percentage,
    ROUND(SUM(CASE WHEN s.actual_delivery_date > s.planned_delivery_date THEN 1 ELSE 0 END) * 100.0 / COUNT(s.shipment_id), 2) AS late_percentage
FROM
    Shipments s
WHERE
    s.actual_delivery_date IS NOT NULL
GROUP BY
    s.carrier
ORDER BY
    s.carrier ASC;

```

### Question 2: Shipments with Unresolved Exceptions

Identify shipments that have an event_type of 'Exception' but have not yet reached 'Delivered' status.

For these shipments, return shipment_id, order_id, destination_city, carrier, and the last_exception_date.

If a shipment has multiple exceptions, use the latest event_timestamp for last_exception_date.

Order the results by shipment_id ascending.

**Expected Output:**

| **shipment_id** | **order_id** | **destination_city** | **carrier** | **last_exception_date** |
| --------------------- | ------------------ | -------------------------- | ----------------- | ----------------------------- |
| 1007                  | 7                  | Denver                     | FedEx             | 2024-03-05                    |

**Your Solution:**

```sql
SELECT
	s.shipment_id,
	s.order_id,
	s.destination_city,
	s.carrier,
	MAX(DATE(de.event_timestamp)) AS last_exception_date
FROM
	Shipments s
JOIN
	DeliveryEvents de ON de.shipment_id = s.shipment_id
WHERE
	de.event_type = 'Exception'
	AND s.actual_delivery_date IS NULL
GROUP BY
	s.shipment_id,
	s.order_id,
	s.destination_city,
	s.carrier
ORDER BY
	s.shipment_id ASC;

```

### Question 3: Longest Time in Transit by Origin Warehouse

For each origin_warehouse, calculate the average_transit_days for shipments that have been successfully delivered.

Transit days are defined as the difference between the event_timestamp of the 'Picked Up' event and the event_timestamp of the 'Delivered' event for each shipment.

If a shipment has no 'Picked Up' or 'Delivered' events, or if the 'Picked Up' event is missing for a delivered shipment, exclude it.

Round average_transit_days to two decimal places.

Output origin_warehouse, average_transit_days.

Order the results by average_transit_days descending.

**Expected Output:**

| origin_warehouse | average_transit_days |
| ---------------- | -------------------- |
| Warehouse A      | 5.00                 |
| Warehouse B      | 5.00                 |
| Warehouse C      | 0.00                 |

**Your Solution:**

```sql
WITH pickups AS (
	SELECT
		s.origin_warehouse,
		s.order_id,
		CASE WHEN de.event_type = 'Picked Up' THEN de.event_timestamp END AS pickup_time,
		CASE WHEN de.event_type = 'Delivered' THEN de.event_timestamp END AS delivery_time
	FROM
		Shipments s
	JOIN
		DeliveryEvents de ON de.shipment_id = s.shipment_id
	WHERE
		s.actual_delivery_date IS NOT NULL
),
grouped_pickups AS (
	SELECT
		origin_warehouse,
		order_id,
		MIN(pickup_time) AS pickup_time,
		MIN(delivery_time) AS delivery_date
	FROM
		pickups
	GROUP BY
		origin_warehouse,
		order_id
)
SELECT
	s.origin_warehouse,
	ROUND(
		AVG(COALESCE(DATEDIFF(gp.delivery_date, gp.pickup_time ), 0))
	, 2) AS average_transit_days
FROM
	grouped_pickups gp
RIGHT JOIN
	Shipments s ON gp.origin_warehouse = s.origin_warehouse
GROUP BY
	s.origin_warehouse
ORDER BY
	average_transit_days DESC;
```
