## Question 1: Airline On-Time Performance Report

Generate a performance report for each airline. The report should include the airline's name, the total number of flights operated, the percentage of flights that were 'On Time', the percentage that were 'Delayed', and the percentage that were 'Cancelled'. Additionally, calculate the average arrival delay in minutes, but only for flights that were 'Delayed'.

Order the results by the on-time percentage in descending order.

Expected Output:

| airline            | total_flights | on_time_pct | delayed_pct | cancelled_pct | avg_delay_minutes |
| ------------------ | ------------- | ----------- | ----------- | ------------- | ----------------- |
| United Airlines    | 5             | 60.00       | 20.00       | 20.00         | 10.0000           |
| American Airlines  | 5             | 60.00       | 20.00       | 20.00         | 40.0000           |
| Delta Air Lines    | 4             | 50.00       | 50.00       | 0.00          | 20.0000           |
| Southwest Airlines | 2             | 0.00        | 50.00       | 50.00         | 15.0000           |
Your Solution:

```sql
WITH categorized_flights AS (
	SELECT
		airline,
		COUNT(flight_number) AS total_flights,
		SUM(CASE WHEN status='On Time' THEN 1 ELSE 0 END) AS on_time_flights,
		SUM(CASE WHEN status='Delayed' THEN 1 ELSE 0 END) AS delayed_flights,
		SUM(CASE WHEN status='Cancelled' THEN 1 ELSE 0 END) AS cancelled_flights,
		AVG(CASE WHEN status='Delayed' THEN TIMESTAMPDIFF(MINUTE, scheduled_arrival, actual_arrival) END) AS avg_delay_minutes
	FROM
		flight_schedules
	GROUP BY
		airline
)
SELECT
	airline,
	total_flights,
	ROUND(on_time_flights * 100.0 / total_flights, 2) AS on_time_pct,
	ROUND(delayed_flights * 100.0 / total_flights, 2) AS delayed_pct,
	ROUND(cancelled_flights * 100.0 / total_flights, 2) AS cancelled_pct,
	ROUND(avg_delay_minutes, 2) AS avg_delay_minutes
FROM
	categorized_flights
ORDER BY
	on_time_pct DESC;
```

## Question 2: Identifying Potential Connecting Flights

Find all pairs of flights that could serve as a connecting flight route from 'JFK' to 'MIA'. A valid connection consists of two separate flights where:

1. The first flight's destination is the second flight's origin.
2. The second flight must depart *after* the first flight arrives.
3. The layover time (time between the first flight's arrival and the second flight's departure) must be between 1 hour and 4 hours.
4. Both flights must not be 'Cancelled'.

The report should show the flight numbers, airlines, and scheduled times for both legs of the journey.

Order the results by the scheduled departure time of the first flight.

Expected Output:

| leg1_flight_number | leg1_airline    | leg1_origin | leg1_destination | leg1_arrival_time   | leg2_flight_number | leg2_airline      | leg2_origin | leg2_destination | leg2_departure_time |
| ------------------ | --------------- | ----------- | ---------------- | ------------------- | ------------------ | ----------------- | ----------- | ---------------- | ------------------- |
| UA126              | United Airlines | JFK         | ORD              | 2023-08-04 12:00:00 | AA459              | American Airlines | ORD         | MIA              | 2023-08-04 13:00:00 |

Your Solution:

```sql
SELECT
	leg1.flight_number AS leg1_flight_number,
	leg1.airline AS leg1_airline,
	leg1.origin_airport AS leg1_origin,
	leg1.destination_airport AS leg1_destination,
	leg1.scheduled_arrival AS leg1_arrival_time,
	leg2.flight_number AS leg2_flight_number,
	leg2.airline AS leg2_airline,
	leg2.origin_airport AS leg2_origin,
	leg2.destination_airport AS leg2_destination,
	leg2.scheduled_departure AS leg2_departure_time
FROM
	flight_schedules leg1
JOIN
	flight_schedules leg2 ON leg1.destination_airport = leg2.origin_airport
WHERE
	leg1.status <> 'Cancelled'
	AND leg2.status <> 'Cancelled'
	AND leg1.origin_airport = 'JFK'
	AND leg2.destination_airport = 'MIA'
	AND TIMESTAMPDIFF(HOUR, leg1.scheduled_arrival, leg2.scheduled_departure) BETWEEN 1 AND 4
ORDER BY
	leg1.scheduled_departure;
```

## Question 3: Longest Period Without a Cancellation at JFK

Determine the longest continuous period, in days, that the 'JFK' airport operated without any flight cancellations.

The output should show the start date of this period (the day after the last cancellation before the period started, or the first day of data if no prior cancellations exist) and the end date (the day a cancellation occurred, ending the streak), and the total duration of this period in days.

Expected Output:

| streak_start_date | streak_end_date | duration_days |
| --------------------------- | ------------------------- | ----------------------- |
| 2023-08-03                  | 2023-08-06                | 3                       |

Your Solution:

```sql
WITH jfk_streaks AS (
    SELECT
        DATE(fs.scheduled_departure) AS flight_date,
        (
        SELECT
        	COUNT(*)
        FROM
         	flight_schedules c
        WHERE
         	c.origin_airport = 'JFK'
           AND c.status = 'Cancelled'
           AND DATE(c.scheduled_departure) < DATE(fs.scheduled_departure)
        )
        AS streak_group
    FROM
        flight_schedules fs
    WHERE
        fs.origin_airport = 'JFK'
        AND fs.status <> 'Cancelled'
),
streak_duration AS (
    SELECT
        MIN(flight_date) AS streak_start_date,
        MAX(flight_date) AS streak_end_date,
        DATEDIFF(MAX(flight_date), MIN(flight_date)) + 1 AS duration_days
    FROM
        jfk_streaks
    GROUP BY
        streak_group
)
SELECT
    streak_start_date,
    streak_end_date,
    duration_days
FROM
    streak_duration
ORDER BY
    duration_days DESC
LIMIT 1;
```
