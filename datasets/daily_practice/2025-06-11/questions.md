### Question 1: Identifying High-Value Customers with Purchase Patterns

Identify high-value customers and analyze their purchase patterns. For this task:

1. Calculate the total amount spent by each customer.
2. Count the number of distinct products purchased by each customer.
3. Calculate the average order value for each customer.
4. Rank customers based on their total spending in descending order.
5. Include only customers who have spent more than $2000 and purchased at least 3 distinct products.
6. Use a window function to assign ranks.

**Expected Output:**

| customer_id | total_spent | distinct_products | avg_order_value | rank |
|-------------|-------------|-------------------|-----------------|------|
| 109         | 2325.00     | 3                 | 775.00          | 1    |

```sql
-- Write your solution here
```
---

### Question 2: Discount Impact Analysis with Recovery Scenarios

Analyze the impact of discounts on revenue and explore recovery scenarios. For this task:

1. Calculate the total discount given for each product.
2. Calculate the percentage of total revenue lost due to discounts for each product.
3. Simulate two recovery scenarios:
   - Scenario A: Discounts are reduced by 50%.
   - Scenario B: Discounts are eliminated entirely.
4. Calculate the potential revenue recovery for each scenario.
5. Include only products with a total discount greater than $100.

**Expected Output:**

| product_name | total_discount | pct_revenue_lost | recovery_scenario_a | recovery_scenario_b |
|--------------|----------------|------------------|---------------------|---------------------|
| Laptop       | 200.00         | 8.33%            | 100.00              | 200.00              |
| Smartphone   | 125.00         | 5.00%            | 62.50               | 125.00              |

```sql
-- Write your solution here
```
---

### Question 3: Orders Without Customer Information with Advanced Ranking

Identify and rank orders without customer information using advanced criteria. For this task:

1. Include `order_id`, `product_name`, `order_date`, and `total_amount`.
2. Calculate the rank of each order based on `total_amount` in descending order.
3. For orders with the same `total_amount`, rank them by `order_date` in ascending order.
4. Additionally, calculate the cumulative total amount for all ranked orders.
5. Use window functions to assign ranks and calculate the cumulative total.

**Expected Output:**

| order_id | product_name | order_date  | total_amount | rank | cumulative_total |
|----------|--------------|-------------|--------------|------|------------------|
| 14       | Headphones   | 2025-06-14  | 450.00       | 1    | 450.00           |
| 19       | Router       | 2025-06-19  | 290.00       | 2    | 740.00           |
| 16       | Keyboard     | 2025-06-16  | 200.00       | 3    | 940.00           |

```sql
-- Write your solution here
```
---