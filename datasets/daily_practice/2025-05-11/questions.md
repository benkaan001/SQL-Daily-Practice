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

| month_name     | total_rides | total_minutes | avg_duration | previous_avg | pct_change | trend_category      |
|----------------|-------------|---------------|--------------|--------------|------------|---------------------|
| January 2016   | 63          | 1042          | 00:17        | NULL         | NULL       | Initial Month       |
| February 2016  | 27          | 450           | 00:17        | 00:17        | 0%         | Stable              |
| March 2016     | 2           | 43            | 00:22        | 00:17        | 29.4%      | Significant Increase |
| April 2016     | 3           | 32            | 00:11        | 00:22        | -50.0%     | Significant Decrease |
| May 2016       | 2           | 39            | 00:20        | 00:11        | 81.8%      | Significant Increase |
| June 2016      | 1           | 19            | 00:19        | 00:20        | -5.0%      | Stable              |
| July 2016      | 2           | 244           | 02:02        | 00:19        | 542.1%     | Significant Increase |
| August 2016    | 1           | 29            | 00:29        | 02:02        | -76.2%     | Significant Decrease |
| December 2016  | 2           | 37            | 00:19        | 00:29        | -34.5%     | Significant Decrease |

**Your Solution:**

```sql
-- Write your solution here

```

## Question 3: Ride Purpose Word Analysis with Date Patterns

Analyze the relationship between ride purposes, day of week patterns, and word counts in locations. For this task:

1. Extract the day of week name (e.g., "Monday") from start_date
2. Count the number of words in each start_location and stop_location
3. Create categories based on purpose and word counts:
   - "Simple Business" - Business rides where both locations have 1 word
   - "Complex Business" - Business rides where either location has more than 1 word
   - "Personal" - All personal rides

For each combination of day name and purpose category:
1. Count the number of rides
2. Calculate average miles
3. Find the most common hour of day for rides (in 24-hour format)
4. Format a sample ride description as: "[Start] to [Stop] on [Formatted Date]"
   where [Formatted Date] is in the format "Weekday, Month DD, YYYY at HH:MM AM/PM"

Include only combinations with at least 2 rides, ordered by ride count (descending).

**Expected Output:**

| day_name | purpose_category | ride_count | avg_miles | peak_hour | sample_ride |
|----------|------------------|------------|-----------|-----------|-------------|
| Friday   | Complex Business | 8          | 9.4       | 11        | Durham to Cary on Friday, January 29, 2016 at 01:24 PM |
| Sunday   | Complex Business | 7          | 12.5      | 18        | Elmhurst to New York on Sunday, January 10, 2016 at 06:18 PM |
| Thursday | Complex Business | 6          | 10.2      | 15        | Raleigh to Cary on Thursday, January 28, 2016 at 03:51 PM |
| Tuesday  | Simple Business  | 5          | 2.2       | 16        | Cary to Cary on Tuesday, January 26, 2016 at 04:24 PM |
| Wednesday| Complex Business | 4          | 11.8      | 10        | Cary to Chapel Hill on Wednesday, February 03, 2016 at 10:35 AM |
| Monday   | Complex Business | 3          | 4.0       | 11        | East Harlem to NoMad on Monday, January 11, 2016 at 08:55 AM |

**Your Solution:**

```sql
-- Write your solution here

```

