## Puzzle: The Out-of-Bounds Sensor Alert

**The Scenario:** As an IoT monitoring engineer, you need to identify sensor readings that fall outside their expected operating range. This could indicate a sensor malfunction or an environmental anomaly requiring investigation.

**Your Task:** Write a query that finds all sensor readings where the `reading_value` is either below the `expected_min` or above the `expected_max`. For each anomalous reading, the report should show:

1. `sensor_id`: The ID of the sensor.
2. `sensor_type`: The type of sensor.
3. `reading_timestamp`: The time of the anomalous reading.
4. `reading_value`: The value recorded.
5. `expected_range`: The expected range formatted as 'min - max' (e.g., '10.00 - 30.00').
6. `deviation`: The absolute difference between the `reading_value` and the closest boundary (either `expected_min` or `expected_max`).

Order the results by `sensor_id` and then `reading_timestamp`.

| **sensor_id** | **sensor_type** | **reading_timestamp** | **reading_value** | **expected_range** | **deviation** |
| ------------------- | --------------------- | --------------------------- | ----------------------- | ------------------------ | ------------------- |
| H-001               | Humidity              | 2023-12-01 12:01:00.000     | 72.50                   | 40.00 - 70.00            | 2.50                |
| P-001               | Pressure              | 2023-12-01 11:01:00.000     | 99.80                   | 100.00 - 105.00          | 0.20                |
| T-002               | Temperature           | 2023-12-02 09:01:00.000     | 32.50                   | 10.00 - 30.00            | 2.50                |
| T-002               | Temperature           | 2023-12-02 09:03:00.000     | 8.00                    | 10.00 - 30.00            | 2.00                |

### Tips for Approaching the Problem

1. **Identify Anomalies:** The core logic is to filter the `iot_sensor_readings` table. Your `WHERE` clause should check if `reading_value < expected_min` OR `reading_value > expected_max`.
2. **Format the Range:** Use a string concatenation function (like `CONCAT` in MySQL) to combine `expected_min`, a separator (' - '), and `expected_max` into the `expected_range` string. You might need to format the numbers to ensure consistent decimal places.
3. **Calculate Deviation:** This is the trickiest part. You need the *absolute difference* between the reading and the *closest* boundary it crossed. A `CASE` statement is perfect for this:
   * `WHEN reading_value < expected_min THEN expected_min - reading_value`
   * `WHEN reading_value > expected_max THEN reading_value - expected_max`
   * `ELSE 0` (or `NULL`, though this shouldn't happen with the `WHERE` clause)
4. **Combine in Final SELECT:** Put all the pieces together in your `SELECT` statement, applying the filtering, formatting, and calculation logic.

**Your Solution:**

```sqll
-- Write your solution here
```

