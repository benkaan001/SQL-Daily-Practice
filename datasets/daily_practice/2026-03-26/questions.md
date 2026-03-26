## Puzzle: The Habit-Forming Threshold (Time to 3rd Purchase)

**The Scenario:** The Growth Marketing team believes that once a customer makes their 3rd purchase, they are officially "locked in" as a loyal user. They want to analyze how long it typically takes for users to reach this habit-forming threshold so they can optimize their onboarding email campaigns.

**Your Task:** Write a query to calculate the number of days it takes for each eligible customer to make their 3rd purchase, measured from the date of their very first purchase.

Exclude any customers who have made fewer than 3 purchases.

The final report should show the `customer_id`, the `first_order_date`, the `third_order_date`, and the `days_to_third_order`. Order the results from the fastest adopters to the slowest (ascending by `days_to_third_order`).

**Expected Output:**

| **customer_id** | **first_order_date** | **third_order_date** | **days_to_third_order** |
| --------------------- | -------------------------- | -------------------------- | ----------------------------- |
| 103                   | 2026-02-01                 | 2026-02-10                 | 9                             |
| 101                   | 2026-01-01                 | 2026-02-10                 | 40                            |
| 104                   | 2026-01-05                 | 2026-03-06                 | 60                            |

### Tips for Approaching the Problem

While you could solve this using a `GROUP BY` and conditional aggregation, there is a much more elegant way using window functions with offsets!

1. **Rank the Orders:** Start by using the `ROW_NUMBER()` window function to assign a chronological rank to each customer's orders (partition by `customer_id` and order by `order_date`).
2. **Look Two Steps Ahead:** In the exact same Common Table Expression (CTE), you can find the date of the 3rd order while you are looking at the 1st order! The `LEAD()` window function accepts an optional "offset" parameter. By using `LEAD(order_date, 2)`, you are telling SQL to look exactly two rows ahead of the current row within the partition.
3. **Calculate the Difference:** Now that your 1st order row also has the date of the 3rd order attached to it, you can easily calculate the time difference using `DATEDIFF(end_date, start_date)`.
4. **Filter the Results:** In your final `SELECT` statement, query from your CTE. You only want to keep the rows where `row_number = 1` (since you only need one summary row per customer) AND where your fetched `third_order_date` is `NOT NULL` (to filter out people who haven't reached 3 orders yet).

**Your Solution:**

```sql
-- Write your solution here
```
