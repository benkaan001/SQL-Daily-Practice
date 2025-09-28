## Puzzle: The Unoccupied Home Alert

**The Scenario:** You are a security analyst for a smart home system. You need to create an alert that detects potentially unauthorized activity. The alert should trigger if motion is detected inside the house, but the main entry door was not opened recently, suggesting the house should be empty and secure.

**Your Task:** Write a query to find all `MOTION_DETECTED` events that are considered anomalous. An anomaly is defined as a motion detection event where there was no preceding `DOOR_OPENED` event from the `Entryway` within the last 15 minutes.

The report should show the `device_id` and `room` where the anomalous motion was detected, and the `anomalous_motion_time`.

| **device_id**   | **room** | **anomalous_motion_time** |
| --------------------- | -------------- | ------------------------------- |
| bedroom_motion_sensor | Bedroom        | 2023-11-29 07:30:00.000         |
| living_room_motion    | Living Room    | 2023-11-29 14:00:00.000         |
| kitchen_motion_sensor | Kitchen        | 2023-11-30 19:20:00.000         |

### Tips for Approaching the Problem

1. **Isolate Key Events:** The problem revolves around two types of events: `MOTION_DETECTED` (from any room) and `DOOR_OPENED` (specifically from the 'Entryway'). It's helpful to think about these as two separate sets of data to begin with.
2. **Connect Motion to Prior Door Events:** For every single `MOTION_DETECTED` event, you need to look backwards in time to find the *most recent* 'Entryway' door opening that happened *before* it. A correlated subquery or a `LEFT JOIN` combined with a window function can achieve this.
3. **Using a Subquery/Join:** You can `LEFT JOIN` the `smart_home_events` table to itself. Let's call them `motion_events` and `door_events`. The join condition would be `door_events.event_timestamp < motion_events.event_timestamp`. This connects every motion event to all preceding door events.
4. **Find the MOST Recent Door Event:** After the join, you will have many door events for each motion event. You only care about the latest one. Within your query (perhaps after the join), you can use `MAX(door_events.event_timestamp)` grouped by the `motion_events` details to find the most recent door opening before each motion event.
5. **Final Filtering Logic:** Once you have a table showing each motion event and the timestamp of the last entryway door opening before it, the final step is to apply the filter. Your `WHERE` clause should check for two conditions:
   * The last door opening is `NULL` (meaning no one has ever entered through the front door).
   * The time difference between the `motion_event` and the `last_door_opening` is greater than 15 minutes.

**Your Solution:**

```sql
-- Write your solution here
```
