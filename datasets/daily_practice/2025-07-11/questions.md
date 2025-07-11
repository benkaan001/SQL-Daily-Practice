# SQL Daily Practice - 2025-07-11

## Questions

### Question 1: Customer Net Spend and Return Rate

Calculate the net_spend for each customer, defined as (total orders amount - total returned amount).

Also, calculate the return_rate_percentage for each customer, defined as (total returned amount / total orders amount) * 100. If a customer has no orders, they should not appear. If they have orders but no returns, their return rate should be 0.00.

Exclude shipping fees from these calculations.

Output customer_id, net_spend (rounded to two decimal places), and return_rate_percentage (rounded to two decimal places).

Order the results by customer_id ascending.

**Expected Output:**

| customer_id | net_spend | return_rate_percentage |
| ----------- | --------- | ---------------------- |
| 1           | 126.50    | 76.85                  |
| 2           | -22.00    | 103.24                 |
| 3           | 83.50     | 32.39                  |
| 4           | 72.00     | 0.00                   |
| 5           | 585.00    | 0.00                   |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 2: Monthly Refund Value by Return Reason

Calculate the total refund_value for each reason for return on a monthly basis for 2024.

If a return has a NULL reason, categorize it as 'No Reason Provided'.

Output month_year (format %Y-%m), return_reason, and total_refund_value (rounded to two decimal places).

Order the results by month_year ascending, then by return_reason ascending.

**Expected Output:**

| month_year | return_reason            | total_refund_value |
| ---------- | ------------------------ | ------------------ |
| 2024-01    | Changed mind             | 100.00             |
| 2024-01    | Defective product        | 150.00             |
| 2024-02    | No Reason Provided       | 300.00             |
| 2024-03    | Product not as described | 400.00             |
| 2024-03    | Wrong size               | 50.00              |
| 2024-04    | Damaged in transit       | 120.00             |
| 2024-04    | Duplicate order          | 40.00              |
**Your Solution:**

```sql
--- Write your solution here

```

### Question 3: Orders with High Return-to-Order Time

Identify orders where the time between order_date and return_date is greater than the average return-to-order time for all returned orders.

Only consider orders that have been returned.

Output order_id, customer_id, order_date, return_date, and days_to_return.

Round days_to_return to zero decimal places.

Order the results by days_to_return descending, then by order_id ascending.

**Expected Output:**

| order_id | customer_id | order_date | return_date | days_to_return |
| -------- | ----------- | ---------- | ----------- | -------------- |
| 103      | 2           | 2024-01-05 | 2024-02-01  | 27             |
| 105      | 1           | 2024-02-15 | 2024-03-01  | 15             |
| 109      | 3           | 2024-04-05 | 2024-04-20  | 15             |                      |

**Your Solution:**

```sql
--- Write your solution here

```
