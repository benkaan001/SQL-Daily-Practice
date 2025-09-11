## Puzzle: The Device Uptime SLA

**The Scenario:** As a Site Reliability Engineer for a smart home platform, you are responsible for ensuring devices meet their Service Level Agreement (SLA) for uptime. The raw data you have is an event log of when devices change their `ONLINE`/`OFFLINE` status. You need to calculate the daily uptime percentage for each device.

**Your Task:** Write a query to calculate the `total_uptime_minutes` and `uptime_percentage` for each device for the specific date of  **'2023-12-20'** .

To do this, you must first transform the event log into a state log that shows the start and end of each status period. Be careful to handle periods that cross day boundaries (e.g., a device that was already 'ONLINE' at the beginning of the day or remained 'ONLINE' at the end of the day). A full day has 1440 minutes.

The final report should be ordered by `device_id`.

| **device_id** | **total_uptime_minutes** | **uptime_percentage** |
| ------------------- | ------------------------------ | --------------------------- |
| Camera-B            | 60.00                          | 4.17                        |
| LightStrip-D        | 720.00                         | 50.00                       |
| SmartLock-C         | 3.00                           | 0.21                        |
| Thermostat-A        | 1050.00                        | 72.92                       |

**Your Solution:**

```sql
-- Write your solution here
```
