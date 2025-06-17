## Question 1: Delivery Agent Session Analysis

The operations team wants to analyze delivery agent "sessions," defined as consecutive deliveries made by an agent where the time between one delivery's `delivery_time` and the next delivery's `order_time` is less than 60 minutes.

Write a query to group orders into these sessions. The output should include the `agent_name`, `order_id`, `order_time`, and a unique `session_id` for each session. A new session starts when the time gap exceeds 60 minutes or when the agent changes.

Order the results by agent name and then by order time.

**Expected Output:**

| agent_name      | order_id | order_time          | session_id |
|-----------------|----------|---------------------|------------|
| Ethan Rodriguez | 1003     | 2023-03-01 18:30:00 | 1          |
| Ethan Rodriguez | 1009     | 2023-04-05 12:02:00 | 2          |
| Leo Martinez    | 1001     | 2023-03-01 12:05:00 | 3          |
| Leo Martinez    | 1004     | 2023-03-02 19:00:00 | 4          |
| Leo Martinez    | 1008     | 2023-04-05 12:00:00 | 5          |
| Leo Martinez    | 1012     | 2023-04-07 19:10:00 | 5          |
| Noah Patel      | 1007     | 2023-03-03 13:15:00 | 6          |
| Noah Patel      | 1013     | 2023-04-07 19:15:00 | 7          |
| Olivia Kim      | 1005     | 2023-03-02 20:05:00 | 8          |
| Olivia Kim      | 1011     | 2023-04-06 18:45:00 | 9          |
| Sophia Chen     | 1002     | 2023-03-01 12:10:00 | 10         |
| Sophia Chen     | 1006     | 2023-03-03 13:00:00 | 10         |
| Sophia Chen     | 1010     | 2023-04-06 18:30:00 | 11         |


**Your Solution:**
```sql
-- Write your solution here

```

---

## Question 2: City Performance Metrics and Ranking

Management wants a comparative view of performance across different cities for the month of March 2023.

Write a query that calculates key performance indicators for each city. The output should include the city, total number of orders, average delivery time in minutes (rounded to 2 decimal places), and the average tip percentage (`tip / order_value`).

Finally, rank each city based on a composite score calculated as `(1 - (avg_delivery_time / max_avg_delivery_time)) + (avg_tip_pct / max_avg_tip_pct)`. The city with the highest score is the best performing.

**Expected Output:**

| city       | total_orders | avg_delivery_time_mins | avg_tip_pct | performance_score | rank |
|------------|--------------|------------------------|-------------|-------------------|------|
| Metroville | 5            | 25.60                  | 0.1086      | 1.19              | 1    |
| Star City  | 2            | 32.50                  | 0.1264      | 1.00              | 2    |


**Your Solution:**
```sql
-- Write your solution here

```

---

## Question 3: Agent Earnings Pivot Table

The finance team requires a monthly summary of each delivery agent"s earnings (delivery fee + tip).

Write a query to create a pivot table showing the total earnings for each agent for the months of March and April 2023. The report should have `agent_name` as rows and the months (`March_Earnings`, `April_Earnings`) as columns.

If an agent had no earnings in a specific month, the value should be 0.00. Order the results by agent name alphabetically.

**Expected Output:**

| agent_name      | March_Earnings | April_Earnings |
|-----------------|----------------|----------------|
| Ethan Rodriguez | 8.50           | 10.50          |
| Leo Martinez    | 10.50          | 11.00          |
| Noah Patel      | 4.00           | 15.00          |
| Olivia Kim      | 13.00          | 7.00           |
| Sophia Chen     | 13.50          | 8.50           |


**Your Solution:**
```sql
-- Write your solution here
```