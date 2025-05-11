## Question: Ride Efficiency Time-of-Day Analysis

Analyze the efficiency of rides (miles per minute) by time of day. Calculate the ride efficiency (miles divided by duration in minutes) for each ride. Then, categorize each ride into one of four time blocks:
- 'Morning' (6:00 AM - 11:59 AM)
- 'Afternoon' (12:00 PM - 5:59 PM)
- 'Evening' (6:00 PM - 9:59 PM)
- 'Night' (10:00 PM - 5:59 AM)

For each time block, find:
1. The average efficiency
2. The ride with the highest efficiency (include start_location, stop_location, miles, duration_minutes, and efficiency)
3. The ranking of time blocks by average efficiency

Round efficiency values to 2 decimal places.

**Expected Output:**

| time_block | avg_efficiency | most_efficient_start | most_efficient_stop | max_miles | duration_minutes | max_efficiency | efficiency_rank |
| ---------- | -------------- | -------------------- | ------------------- | --------- | ---------------- | -------------- | --------------- |
| Afternoon  | 1.42           | West Palm Beach      | Palm Beach          | 7.1       | 5                | 1.42           | 1               |
| Evening    | 0.85           | Fort Pierce          | Fort Pierce         | 5.1       | 6                | 0.85           | 2               |
| Morning    | 0.64           | Cary                 | Raleigh             | 18.7      | 29               | 0.64           | 3               |
| Night      | 0.42           | Fort Pierce          | Fort Pierce         | 5.0       | 12               | 0.42           | 4               |

**Your Solution:**

```sql
-- Write your solution here

```
