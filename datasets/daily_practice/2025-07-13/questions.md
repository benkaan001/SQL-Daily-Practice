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

| **carrier** | **total_shipments** | **on_time_percentage** | **early_percentage** | **late_percentage** |
| ----------------- | ------------------------- | ---------------------------- | -------------------------- | ------------------------- |
| DHL               | 3                         | 0.00                         | 66.67                      | 33.33                     |
| FedEx             | 2                         | 50.00                        | 50.00                      | 0.00                      |
| UPS               | 2                         | 100.00                       | 0.00                       | 0.00                      |

**Your Solution:**

```sql
--- Write your solution here

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
--- Write your solution here

```

### Question 3: Longest Time in Transit by Origin Warehouse

For each origin_warehouse, calculate the average_transit_days for shipments that have been successfully delivered.

Transit days are defined as the difference between the event_timestamp of the 'Picked Up' event and the event_timestamp of the 'Delivered' event for each shipment.

If a shipment has no 'Picked Up' or 'Delivered' events, or if the 'Picked Up' event is missing for a delivered shipment, exclude it.

Round average_transit_days to two decimal places.

Output origin_warehouse, average_transit_days.

Order the results by average_transit_days descending.

**Expected Output:**

| **origin_warehouse** | **average_transit_days** |
| -------------------------- | ------------------------------ |
| Warehouse A                | 14.25                          |
| Warehouse B                | 5.00                           |
| Warehouse C                | 3.96                           |

**Your Solution:**

```sql
--- Write your solution here

```
