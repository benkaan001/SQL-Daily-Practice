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
WITH ride_efficiency AS (
  SELECT
      CASE
          WHEN TIME(start_date) BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
          WHEN TIME(start_date) BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
          WHEN TIME(start_date) BETWEEN '18:00:00' AND '21:59:59' THEN 'Evening'
          ELSE 'Night'
      END AS time_block,
      start_location,
      stop_location,
      TIMESTAMPDIFF(MINUTE, start_date, end_date) AS ride_duration_minutes,
      miles,
      ROUND(miles / TIMESTAMPDIFF(MINUTE, start_date, end_date), 2) AS efficiency
  FROM
      uber_rides
  WHERE
  	  TIMESTAMPDIFF(MINUTE, start_date, end_date) > 0
),ranked_rides AS (
    SELECT
        time_block,
        start_location,
        stop_location,
        ride_duration_minutes,
        miles,
  		efficiency,
        RANK() OVER(PARTITION BY time_block ORDER BY efficiency DESC) AS efficiency_rank
    FROM
        ride_efficiency
),time_block_summary AS (
    SELECT
        time_block,
        ROUND(AVG(efficiency), 2) AS avg_efficiency,
        MAX(CASE WHEN efficiency_rank = 1 THEN start_location END) AS most_efficient_start,
        MAX(CASE WHEN efficiency_rank = 1 THEN stop_location END) AS most_efficient_stop,
        MAX(CASE WHEN efficiency_rank = 1 THEN miles END) AS max_miles,
        MAX(CASE WHEN efficiency_rank = 1 THEN ride_duration_minutes END) AS duration_minutes,
        MAX(CASE WHEN efficiency_rank = 1 THEN efficiency END) AS max_efficiency
    FROM
        ranked_rides
    WHERE
  	    efficiency_rank = 1
    GROUP BY
        time_block
)
SELECT
    time_block,
    avg_efficiency,
    most_efficient_start,
    most_efficient_stop,
    max_miles,
    duration_minutes,
    max_efficiency,
    RANK() OVER (ORDER BY avg_efficiency DESC) AS efficiency_rank
FROM
    time_block_summary
ORDER BY
    efficiency_rank;

```
