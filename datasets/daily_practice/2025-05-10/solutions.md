## Question 4: Ride Efficiency Time-of-Day Analysis

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
|------------|----------------|----------------------|---------------------|-----------|------------------|----------------|----------------|
| Afternoon  | 0.62           | Chapel Hill          | Cary                | 23.3      | 33               | 0.71           | 1              |
| Evening    | 0.47           | Apex                 | Cary                | 5.5       | 19               | 0.29           | 2              |
| Morning    | 0.42           | Lake Wellingborough  | Whitebridge         | 7.6       | 14               | 0.54           | 3              |
| Night      | 0.38           | Fort Pierce          | Fort Pierce         | 5.0       | 12               | 0.42           | 4              |

**Your Solution:**

```sql
-- Write your solution here

```

## Question 5: Identifying Multi-Stop Business Trip Chains

A "trip chain" occurs when consecutive rides by the same category form a connected journey, where the stop_location of one ride matches the start_location of the next ride, with less than 60 minutes between them.

Write a query to identify all Business category trip chains that consist of at least 3 consecutive rides. For each chain:
1. Assign a chain_id
2. Calculate the total miles covered in the chain
3. Calculate the total duration in minutes
4. Count the number of stops in the chain
5. List all locations visited in order (as a comma-separated string)

Order the results by the number of stops in descending order, then by total miles in descending order.

**Expected Output:**

| chain_id | total_miles | total_duration | num_stops | locations_path |
|----------|-------------|----------------|-----------|----------------|
| 1        | 23.9        | 185            | 5         | Midtown,Flatiron District,Midtown,Midtown East,Midtown |
| 2        | 12.1        | 56             | 4         | Hudson Square,Lower Manhattan,Hudson Square,Hell's Kitchen |
| 3        | 35.8        | 92             | 3         | Cary,Raleigh,Fairmont |
| 4        | 14.4        | 45             | 3         | Whitebridge,Hazelwood,Whitebridge |

**Your Solution:**

```sql
-- Write your solution here

```