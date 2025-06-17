## Question 1: Delivery Agent Session Analysis

The operations team wants to analyze delivery agent "sessions," defined as consecutive deliveries made by an agent where the time between one delivery's `delivery_time` and the next delivery's `order_time` is less than 48 hours.

Write a query to group orders into these sessions. The output should include the `agent_name`, `order_id`, `order_time`, and a unique `session_id` for each session. A new session starts when the time gap exceed 48 hours.

Order the results by agent name and then by order time.

**Expected Output:**

| agent_name      | order_id | order_time          | session_id |
| --------------- | -------- | ------------------- | ---------- |
| Ethan Rodriguez | 1003     | 2023-03-01 18:30:00 | 1          |
| Ethan Rodriguez | 1009     | 2023-04-05 12:02:00 | 2          |
| Leo Martinez    | 1001     | 2023-03-01 12:05:00 | 3          |
| Leo Martinez    | 1004     | 2023-03-02 19:00:00 | 3          |
| Leo Martinez    | 1008     | 2023-04-05 12:00:00 | 4          |
| Leo Martinez    | 1012     | 2023-04-07 19:10:00 | 5          |
| Noah Patel      | 1007     | 2023-03-03 13:15:00 | 6          |
| Noah Patel      | 1013     | 2023-04-07 19:15:00 | 7          |
| Olivia Kim      | 1005     | 2023-03-02 20:05:00 | 8          |
| Olivia Kim      | 1011     | 2023-04-06 18:45:00 | 9          |
| Sophia Chen     | 1002     | 2023-03-01 12:10:00 | 10         |
| Sophia Chen     | 1006     | 2023-03-03 13:00:00 | 11         |
| Sophia Chen     | 1010     | 2023-04-06 18:30:00 | 12         |


**Your Solution:**
```sql
WITH delivery_gaps AS (
  SELECT
  	da.agent_name,
  	o.order_id,
  	o.order_time,
  	LAG(o.delivery_time, 1) OVER (PARTITION BY da.agent_id ORDER BY o.order_time) AS previous_delivery_time
  FROM
  	orders o
  JOIN
  	delivery_agents da ON o.agent_id = da.agent_id
),
sessions AS (
  SELECT
  	agent_name,
  	order_id,
  	order_time,
    CASE
      WHEN previous_delivery_time IS NULL OR TIMESTAMPDIFF(HOUR, previous_delivery_time, order_time) >= 48 THEN 1
      ELSE 0
    END AS is_new_session
  FROM
  	delivery_gaps
),
grouped_sessions AS (
  SELECT
  	agent_name,
  	order_id,
  	order_time,
  	SUM(is_new_session) OVER (PARTITION BY agent_name ORDER BY order_time) AS session_group_id
  FROM
  	sessions
)
SELECT
    agent_name,
    order_id,
    order_time,
    DENSE_RANK() OVER (ORDER BY agent_name, session_group_id) AS session_id
FROM
	grouped_sessions;
```

---

## Question 2: City Performance Metrics and Ranking

Management wants a comparative view of performance across different cities for the month of March 2023.

Write a query that calculates key performance indicators for each city. The output should include the city, total number of orders, average delivery time in minutes (rounded to 2 decimal places), and the average tip percentage (`tip / order_value`).

Finally, rank each city based on a composite score calculated as `(1 - (avg_delivery_time / max_avg_delivery_time)) + (avg_tip_pct / max_avg_tip_pct)`. The city with the highest score is the best performing.

**Expected Output:**

| city       | total_orders | avg_delivery_time_mins | avg_tip_pct | performance_score | rnk |
| ---------- | ------------ | ---------------------- | ----------- | ----------------- | --- |
| Metroville | 5            | 31.6000                | 0.10        | 0.77              | 1   |
| Star City  | 2            | 20.0000                | 0.13        | 1.37              | 2   |


**Your Solution:**
```sql
WITH city_stats AS (
    SELECT
        da.city,
        COUNT(o.order_id) AS total_orders,
        AVG(TIMESTAMPDIFF(MINUTE, o.order_time, o.delivery_time)) AS avg_delivery_time_mins,
        AVG(o.tip / o.order_value) AS avg_tip_pct
    FROM
        delivery_agents da
    JOIN
        orders o ON o.agent_id = da.agent_id
    WHERE
        o.order_time BETWEEN '2023-03-01' AND '2023-03-31'
    GROUP BY
        da.city
),
city_scores AS (
    SELECT
        city,
        total_orders,
        avg_delivery_time_mins,
        avg_tip_pct,
        (1 - (avg_delivery_time_mins / MAX(avg_delivery_time_mins) OVER ()))
        + (avg_tip_pct / MAX(avg_tip_pct) OVER ()) AS performance_score
    FROM
        city_stats
)
SELECT
    city,
    total_orders,
    ROUND(avg_delivery_time_mins, 2) AS avg_delivery_time_mins,
    ROUND(avg_tip_pct, 4) AS avg_tip_pct,
    ROUND(performance_score, 2) AS performance_score,
    RANK() OVER (ORDER BY performance_score DESC) as `rank`
FROM
    city_scores;

```

---

## Question 3: Agent Earnings Pivot Table

The finance team requires a monthly summary of each delivery agent"s earnings (delivery fee + tip).

Write a query to create a pivot table showing the total earnings for each agent for the months of March and April 2023. The report should have `agent_name` as rows and the months (`March_Earnings`, `April_Earnings`) as columns.

If an agent had no earnings in a specific month, the value should be 0.00. Order the results by agent name alphabetically.

**Expected Output:**

| agent_name      | March_Earnings | April_Earnings |
| --------------- | -------------- | -------------- |
| Ethan Rodriguez | 8.50           | 10.50          |
| Leo Martinez    | 14.50          | 14.00          |
| Noah Patel      | 4.00           | 15.00          |
| Olivia Kim      | 13.00          | 7.00           |
| Sophia Chen     | 16.50          | 8.50           |


**Your Solution:**
```sql
SELECT
  da.agent_name,
  ROUND(SUM(CASE WHEN MONTHNAME(o.delivery_time) = 'March' THEN o.delivery_fee + o.tip ELSE 0 END), 2) AS March_Earnings,
  ROUND(SUM(CASE WHEN MONTHNAME(o.delivery_time) = 'April' THEN o.delivery_fee + o.tip ELSE 0 END), 2) AS April_Earnings
FROM
  orders o
RIGHT JOIN
  delivery_agents da ON da.agent_id = o.agent_id
GROUP BY
  da.agent_name
ORDER BY
  da.agent_name;
```