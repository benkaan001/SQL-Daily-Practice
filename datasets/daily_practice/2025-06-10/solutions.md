## Question 1: User Order Statistics

For each user, calculate the total number of orders placed in June 2025, the total amount spent, and the average order value (rounded to 2 decimals).

- Show user name, total orders, total amount spent, and average order value.
- Only include users who placed at least 2 orders in June 2025.
- Order by total amount spent descending, then user name ascending.

**Expected Output:**

| name    | total_orders | total_amount | avg_order_value |
|---------|--------------|--------------|-----------------|
| Alice   | 4            | 425.50       | 106.38          |
| Eve     | 2            | 230.00       | 115.00          |

```sql
-- Write your solution here
```

---

## Question 2: User Login Patterns

For each user, find their longest streak of consecutive login days in June 2025, and the longest gap (in days) between any two login days in June 2025.

- Show user name, longest_streak (days), longest_gap (days).
- If a user only logged in once, longest_streak should be 1 and longest_gap should be NULL.
- Order by longest_streak descending, then name ascending.

**Expected Output:**

| name    | longest_streak | longest_gap |
|---------|----------------|-------------|
| Alice   | 3              | 1           |
| Diana   | 2              | 2           |

```sql
-- Write your solution here
```

---

## Question 3: Order Status Analysis

For each order status in June 2025, calculate:
- The total number of orders with that status
- The total amount of those orders
- The average order value (rounded to 2 decimals)

Show order status, total orders, total amount, and average order value. Order by total amount descending.

**Expected Output:**

| status     | total_orders | total_amount | avg_order_value |
|------------|--------------|--------------|-----------------|
| Completed  | 8            | 835.50       | 104.44          |
| Pending    | 3            | 265.00       | 88.33           |
| Cancelled  | 2            | 220.00       | 110.00          |

```sql
-- Write your solution here
```
