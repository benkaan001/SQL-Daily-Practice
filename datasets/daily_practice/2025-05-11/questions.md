## Question 1: Extracting and Analyzing Location Patterns

Parse the `start_location` and `stop_location` fields to identify location patterns. For this task:

1. Extract the first word from each location name
2. Create a concatenated string showing the first word of start_location and stop_location connected by '->'
3. Calculate the frequency of each pattern
4. Calculate the average mileage for each pattern

Include only 'Business' rides. Filter out patterns that appear fewer than 2 times. Order results by frequency (descending), then by average mileage (descending).

**Expected Output:**

| location_pattern | frequency | avg_miles | min_date            | max_date            | duration_days |
|------------------|-----------|-----------|---------------------|---------------------|---------------|
| Cary->Cary       | 8         | 3.4       | 2016-01-18 14:55:00 | 2016-01-29 10:56:00 | 11            |
| Fort->Fort       | 4         | 4.9       | 2016-01-01 21:11:00 | 2016-01-05 17:31:00 | 4             |
| Cary->Raleigh    | 3         | 18.3      | 2016-01-20 10:36:00 | 2016-01-28 12:28:00 | 8             |
| Whitebridge->Hazelwood | 2    | 2.2      | 2016-01-26 10:41:00 | 2016-01-26 12:33:00 | 0             |
| Raleigh->Cary    | 2         | 16.9      | 2016-01-20 13:25:00 | 2016-03-07 15:19:00 | 47            |

**Your Solution:**

```sql
-- Write your solution here

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

| month_name    | total_rides | total_minutes | avg_duration | previous_avg | pct_change | trend_category       |
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
-- Write your solution here

```
