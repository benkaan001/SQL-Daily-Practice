## Question 1: Courier Efficiency Benchmarking

**The Scenario:** Operations managers want to identify couriers who are consistently faster than their peers. Speed is measured as the time taken from `pickup_time` to `delivery_time`.

**Your Task:** For each courier, calculate their average delivery time in minutes. Then, compare this average against the overall average delivery time of all couriers who have picked up orders from the same *store type* (the first part of `store_category` before the colon, e.g., 'Restaurant').

The report should show the `courier_id`, the `general_category`, the courier's `avg_delivery_time`, and the `category_avg_delivery_time`.

| **courier_id** | **general_category** | **courier_avg_time** | **category_avg_time** |
| -------------------- | -------------------------- | -------------------------- | --------------------------- |
| 501                  | Restaurant                 | 25.00                      | 25.00                       |
| 501                  | Groceries                  | 30.00                      | 33.33                       |
| 502                  | Restaurant                 | 30.00                      | 25.00                       |
| 502                  | Groceries                  | 35.00                      | 33.33                       |
| 503                  | Restaurant                 | 15.00                      | 25.00                       |
| 503                  | Groceries                  | 30.00                      | 33.33                       |
| 504                  | Restaurant                 | 20.00                      | 25.00                       |

### Tips for Approaching the Problem

1. Use `SUBSTRING_INDEX` or `REGEXP_SUBSTR` to extract the 'Restaurant' or 'Groceries' part from the `store_category`.
2. Use a CTE to calculate the average per courier and per category.
3. Apply window functions to get the category-wide average across all couriers in that category.

**Your Solution:**

```
-- Write your solution here

```

## Question 2: Revenue Concentration - The 80/20 VIP Rule

**The Scenario:** We want to identify our most valuable customers. The Pareto principle suggests that 20% of customers often contribute to 80% of total revenue.

**Your Task:** Calculate the cumulative percentage of total revenue contributed by each customer, ordered by their lifetime spend (highest spenders first). A customer is considered a "VIP" if they are part of the group that contributes to the top 60% of total platform revenue.

The report should show `customer_id`, `total_spend`, `cumulative_revenue_pct`, and `is_vip`.

| **customer_id** | **total_spend** | **cumulative_revenue_pct** | **is_vip** |
| --------------------- | --------------------- | -------------------------------- | ---------------- |
| 1005                  | 120.00                | 21.05                            | YES              |
| 1002                  | 125.00                | 42.98                            | YES              |
| 1003                  | 85.00                 | 57.89                            | YES              |
| 1004                  | 95.00                 | 74.56                            | NO               |
| 1001                  | 85.00                 | 89.47                            | NO               |
| 1006                  | 60.00                 | 100.00                           | NO               |

### Tips for Approaching the Problem

1. Use an empty window `SUM(order_value) OVER()` to get the total platform revenue denominator.
2. Use `SUM(total_spend) OVER(ORDER BY total_spend DESC)` to get the running total.
3. Compare the running percentage to 60.0 to assign the VIP flag.

**Your Solution:**

```
-- Write your solution here

```

## Question 3: Preparing Latency Trends

**The Scenario:** Stores can sometimes become overwhelmed. We want to detect if the "Preparation Time" (time from `order_time` to `pickup_time`) for a store's most recent order is significantly higher than its historical average.

**Your Task:** For each store, find the preparation time of its  **most recent order** . Compare this to the average preparation time of all **previous** orders for that same store. Flag any store where the current prep time is more than 50% higher than the historical average.

The report should show `store_id`, `latest_prep_time_mins`, `historical_avg_prep_time_mins`, and `latency_status` ('SPIKE' or 'NORMAL').

| **store_id** | **latest_prep_time_mins** | **historical_avg_prep_time_mins** | **latency_status** |
| ------------------ | ------------------------------- | --------------------------------------- | ------------------------ |
| 1                  | 30.00                           | 16.25                                   | SPIKE                    |
| 2                  | 15.00                           | 15.00                                   | NORMAL                   |
| 3                  | 10.00                           | 25.00                                   | NORMAL                   |

### Tips for Approaching the Problem

1. Use `ROW_NUMBER()` or `RANK()` partitioned by `store_id` and ordered by `order_time DESC` to isolate the most recent order.
2. Use a window function with a frame like `ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING` to calculate the average of all rows *before* the current one.
3. Filter the results to only show the row where `ROW_NUMBER = 1`.

**Your Solution:**

```sql
-- Write your solution here

```
