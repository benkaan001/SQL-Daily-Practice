## Puzzle: The Unstable Environment Alert

**The Scenario:** As a building operations manager, you need to identify rooms where the HVAC system might be failing. A key symptom of failure is rapid, significant fluctuations in both temperature and humidity.

**Your Task:** Write a query to detect "instability events" in any `zone_id`. An instability event is defined as a sequence of three consecutive sensor readings (for the same zone and sensor type) where the environmental conditions are highly volatile. Specifically, an alert should be triggered at the timestamp of the *third* reading if:

1. The change between reading 1 and reading 2 is a "large swing."
2. AND the change between reading 2 and reading 3 is *also* a "large swing."

A "large swing" is defined as:

* An absolute change of more than 2.0 degrees for `TEMPERATURE`.
* An absolute change of more than 5.0 percent for `HUMIDITY`.

The final report should show the `zone_id`, the `sensor_type` that triggered the alert, and the `alert_timestamp` (the timestamp of the third volatile reading).

| **zone_id** | **sensor_type** | **alert_timestamp** |
| ----------------- | --------------------- | ------------------------- |
| ConfRoom-A        | HUMIDITY              | 2023-12-10 09:02:00.000   |
| ConfRoom-A        | TEMPERATURE           | 2023-12-10 09:03:00.000   |

**Your Solution:**

```
-- Write your solution here

```
