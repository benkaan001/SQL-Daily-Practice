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
-- Write your solution here
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
-- Write your solution here
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
-- Write your solution here
```
