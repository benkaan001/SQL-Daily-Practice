## Question 1: Restaurant Performance Leaderboard by Cuisine

Create a performance leaderboard for restaurants. For each restaurant, calculate its total number of completed orders, average food cost, and average customer rating. Then, rank each restaurant within its `cuisine_type` based on its average rating in descending order. In case of a tie in rating, the restaurant with more orders should rank higher.

The report should only consider orders that have a `restaurant_rating`.

Expected Output:

| cuisine_type | restaurant_id | total_orders | avg_food_cost | avg_rating | rank_within_cuisine |
| ------------ | ------------- | ------------ | ------------- | ---------- | ------------------- |
| Indian       | 5             | 2            | 41.25         | 4.50       | 1                   |
| Italian      | 1             | 5            | 49.20         | 4.80       | 1                   |
| Japanese     | 4             | 3            | 67.67         | 5.00       | 1                   |
| Mexican      | 3             | 4            | 25.50         | 3.75       | 1                   |
| Thai         | 2             | 4            | 32.63         | 4.00       | 1                   |

Your Solution:

```sql
-- Write your solution here
```

## Question 2: Daily Rider Efficiency and Earnings

Analyze the daily performance of each delivery rider. For each day a rider completed at least one delivery, calculate their total earnings (delivery fee + tip), the total number of deliveries, and their average delivery time in minutes. Also, calculate their "active hours" for the day (the time from their first order's timestamp to their last delivery's timestamp) and their effective earnings per active hour.

The final report should only include days where a rider made more than one delivery. Order the results by `rider_id` and then by `work_date`.

Expected Output:

| delivery_date | rider_id | total_deliveries | total_earnings | avg_delivery_time_minutes | earnings_per_hour |
| ------------- | -------- | ---------------- | -------------- | ------------------------- | ----------------- |
| 2023-11-01    | 51       | 1                | 12.00          | 35.0000                   |                   |
| 2023-11-02    | 51       | 1                | 7.00           | 25.0000                   |                   |
| 2023-11-05    | 51       | 1                | 18.00          | 40.0000                   |                   |
| 2023-11-08    | 51       | 1                | 6.00           | 25.0000                   |                   |
| 2023-11-11    | 51       | 1                | 13.00          | 35.0000                   |                   |
| 2023-11-01    | 52       | 1                | 9.50           | 25.0000                   |                   |
| 2023-11-03    | 52       | 1                | 9.50           | 35.0000                   |                   |
| 2023-11-07    | 52       | 1                | 4.50           | 30.0000                   |                   |
| 2023-11-02    | 53       | 1                | 15.00          | 45.0000                   |                   |
| 2023-11-04    | 53       | 1                | 8.00           | 20.0000                   |                   |
| 2023-11-06    | 53       | 1                | 13.00          | 35.0000                   |                   |
| 2023-11-10    | 53       | 1                | 13.00          | 40.0000                   |                   |
| 2023-11-04    | 54       | 1                | 16.00          | 35.0000                   |                   |
| 2023-11-08    | 54       | 1                | 12.50          | 40.0000                   |                   |
| 2023-11-11    | 54       | 1                | 7.00           | 25.0000                   |                   |
| 2023-11-05    | 55       | 1                | 11.50          | 45.0000                   |                   |
| 2023-11-09    | 55       | 1                | 17.00          | 30.0000                   |                   |

Your Solution:

```sql
-- Write your solution here
```

## Question 3: Identifying Consecutive-Day "Power Users"

Identify "power users" who have placed an order on at least three consecutive days. This requires identifying continuous streaks of ordering days for each customer.

The report should show the `customer_id`, the `streak_start_date`, the `streak_end_date`, and the `consecutive_days` count for each streak that is 3 days or longer.

Order the results by `customer_id`.

Expected Output:

| customer_id | streak_start_date | streak_end_date | consecutive_days |
| ----------- | ----------------- | --------------- | ---------------- |
| 101         | 2023-11-01        | 2023-11-03      | 3                |
Your Solution:

```sql
-- Write your solution here
```
