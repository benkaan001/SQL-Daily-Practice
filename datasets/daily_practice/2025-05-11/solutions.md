## Question 1: Extracting and Analyzing Location Patterns

Parse the `start_location` and `stop_location` fields to identify location patterns. For this task:

1. Extract the first word from each location name
2. Create a concatenated string showing the first word of start_location and stop_location connected by '->'
3. Calculate the frequency of each pattern
4. Calculate the average mileage for each pattern

Include only 'Business' rides. Filter out patterns that appear fewer than 2 times. Order results by frequency (descending), then by average mileage (descending).

**Expected Output:**


| location_pattern  | frequency | avg_miles | min_date            | max_date            | duration_dates |
| ----------------- | --------- | --------- | ------------------- | ------------------- | -------------- |
| Cary->Cary        | 14        | 2.58      | 2016-01-07 13:27:00 | 2016-02-04 20:55:00 | 28             |
| Morrisville->Cary | 6         | 6.35      | 2016-01-15 00:41:00 | 2016-06-03 23:06:00 | 140            |
| Raleigh->Cary     | 5         | 19.74     | 2016-01-20 13:25:00 | 2016-03-07 15:45:00 | 47             |
| Cary->Raleigh     | 4         | 16.55     | 2016-01-20 10:36:00 | 2016-02-06 16:53:00 | 17             |
| Cary->Morrisville | 4         | 7.93      | 2016-01-10 08:05:00 | 2016-02-13 14:41:00 | 34             |
| Fort->Fort        | 4         | 4.90      | 2016-01-01 21:11:00 | 2016-01-05 17:45:00 | 3              |
| Cary->Durham      | 3         | 10.40     | 2016-01-15 11:43:00 | 2016-02-05 12:07:00 | 21             |
| Durham->Cary      | 3         | 10.30     | 2016-01-15 13:26:00 | 2016-02-05 13:41:00 | 21             |
| Apex->Cary        | 3         | 5.63      | 2016-01-29 21:21:00 | 2016-02-07 18:17:00 | 8              |
| Midtown->Midtown  | 3         | 1.87      | 2016-01-11 13:32:00 | 2016-02-14 15:03:00 | 34             |
| New->Queens       | 2         | 12.95     | 2016-01-10 15:08:00 | 2016-01-12 17:00:00 | 2              |
| Unknown->Unknown  | 2         | 6.20      | 2016-08-21 10:00:00 | 2016-12-17 16:12:00 | 118            |

**Your Solution:**

```sql
SELECT
	CONCAT(
      SUBSTRING_INDEX(start_location, ' ', 1),
      '->',
      SUBSTRING_INDEX(stop_location, ' ', 1)
          )
    AS location_pattern,
    COUNT(*) AS frequency,
    ROUND(AVG(miles), 2) AS avg_miles,
	MIN(start_date) AS min_date,
    MAX(end_date) AS max_date,
    TIMESTAMPDIFF(DAY, MIN(start_date), MAX(end_date)) AS duration_dates
FROM
	uber_rides
WHERE
	category = 'Business'
GROUP BY
	location_pattern
HAVING
	frequency >= 2
ORDER BY
	frequency DESC, avg_miles DESC;

```

## Question 2: Monthly Ride Duration Trends with Date Formatting

Analyze how ride durations have changed over time by month. For this task:

1. Format the month as "Month YYYY" (e.g., "January 2016")
2. Calculate the following for each month:
   - Total number of rides
   - Total minutes traveled
   - Average ride duration in minutes, formatted as HH:MM (hours:minutes)
   - Percentage change in average duration from previous month
3. Categorize each month based on the following rules:
   - If average duration increased by more than 10% from previous month: "Significant Increase"
   - If average duration decreased by more than 10% from previous month: "Significant Decrease"
   - Otherwise: "Stable"

Order results chronologically by month.

**Expected Output:**

| month_name     | total_rides | total_minutes | avg_duration | previous_avg | | month_name    | total_rides | total_minutes | avg_duration | previous_avg | pct_change | trend_category       |
| ------------- | ----------- | ------------- | ------------ | ------------ | ---------- | -------------------- |
| January 2016  | 59          | 1083          | 00:18        |              |            | Initial Month        |
| February 2016 | 27          | 534           | 00:19        | 18.36        | 7.75%      | Stable               |
| March 2016    | 2           | 43            | 00:21        | 19.78        | 8.71%      | Stable               |
| April 2016    | 3           | 31            | 00:10        | 21.50        | -51.94%    | Significant Decrease |
| May 2016      | 2           | 39            | 00:19        | 10.33        | 88.71%     | Significant Increase |
| June 2016     | 1           | 19            | 00:19        | 19.50        | -2.56%     | Stable               |
| July 2016     | 2           | 212           | 01:46        | 19.00        | 457.89%    | Significant Increase |
| August 2016   | 1           | 29            | 00:29        | 106.00       | -72.64%    | Significant Decrease |
| December 2016 | 2           | 49            | 00:24        | 29.00        | -15.52%    | Significant Decrease |

**Your Solution:**

```sql
WITH monthly_rides AS (
    SELECT
        DATE_FORMAT(start_date, '%M %Y') AS month_name,
        YEAR(start_date) AS ride_year,
        MONTH(start_date) AS ride_month,
        COUNT(*) AS total_rides,
        SUM(TIMESTAMPDIFF(MINUTE, start_date, end_date)) AS total_minutes,
        AVG(TIMESTAMPDIFF(MINUTE, start_date, end_date)) AS average_duration_minutes
    FROM
        uber_rides
    GROUP BY
        month_name,
        ride_year,
        ride_month
    ORDER BY
        ride_year,
        ride_month
),
lagged_rides AS (
    SELECT
        month_name,
        ride_year,
        ride_month,
        total_rides,
        total_minutes,
        average_duration_minutes,
        LAG(average_duration_minutes) OVER (ORDER BY ride_year, ride_month) AS previous_average_duration_minutes
    FROM
        monthly_rides
),
computed_rides AS (
    SELECT
        month_name,
        ride_year,
        ride_month,
        total_rides,
        total_minutes,
        average_duration_minutes,
        previous_average_duration_minutes,
        ROUND(
            (average_duration_minutes - previous_average_duration_minutes) / NULLIF(previous_average_duration_minutes, 0) * 100
        , 2) AS pct_change_numeric,
        CASE
            WHEN average_duration_minutes IS NULL THEN '00:00'
            ELSE
                CONCAT(
                    LPAD(FLOOR(average_duration_minutes / 60), 2, '0'),
                    ':',
                    LPAD(MOD(average_duration_minutes, 60), 2, '0')
                )
        END AS avg_duration_formatted
    FROM
        lagged_rides
)
SELECT
    month_name,
    total_rides,
    total_minutes,
    avg_duration_formatted AS avg_duration,
    ROUND(previous_average_duration_minutes, 2) AS previous_avg,
    CASE
        WHEN pct_change_numeric IS NULL THEN NULL
        ELSE CONCAT(CAST(pct_change_numeric AS DECIMAL(10,2)), '%')
    END AS pct_change,
    CASE
        WHEN previous_average_duration_minutes IS NULL THEN 'Initial Month'
        WHEN pct_change_numeric > 10 THEN 'Significant Increase'
        WHEN pct_change_numeric < -10 THEN 'Significant Decrease'
        ELSE 'Stable'
    END AS trend_category
FROM
    computed_rides
ORDER BY
    ride_year,
    ride_month;

```

