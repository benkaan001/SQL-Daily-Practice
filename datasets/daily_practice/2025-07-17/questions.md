# SQL Daily Practice - 2025-07-17

### Question 1: Customers at Risk of Churn (Inactivity)

Identify customer_ids who have had a gap of more than 30 days between any two consecutive Login or Purchase events.

For each such customer, return their customer_id, the start_date_of_inactivity (the date of the earlier event in the gap), and the end_date_of_inactivity (the date of the later event in the gap).

If a customer has multiple such gaps, return all of them.

Order the results by customer_id ascending, then by start_date_of_inactivity ascending.

**Expected Output:**

| customer_id | start_date_of_inactivity | end_date_of_inactivity |
| ----------- | ------------------------ | ---------------------- |
| 1           | 2024-01-10               | 2024-02-15             |
| 3           | 2024-01-20               | 2024-03-01             |
| 3           | 2024-03-01               | 2024-05-10             |
| 5           | 2024-03-01               | 2024-04-01             |

**Your Solution:**

```sql
--- Write your solution here
```

### Question 2: Monthly Customer Acquisition and Churn Rate

Calculate the `newly_acquired_customers` and `churned_customers` for each month in 2024.

For each month in 2024, calculate metrics based on customer events.

A customer is newly_acquired in a month if their very first recorded event falls in that month.

The number of churned_customers is the total count of all 'Cancellation' events that occurred in that month.

Calculate retained_activity_events, defined as the total count of events in a month, excluding any customer's first-ever event and any 'Cancellation' events.

Calculate the churn_to_activity_ratio using the formula:
(churned_customers / (retained_activity_events + newly_acquired_customers)) * 100

Round the churn_to_activity_ratio to two decimal places. If the denominator is 0, the rate should be 0.00.

For January 2024, the churn_to_activity_ratio should be NULL.

Output month_year (format YYYY-MM), newly_acquired_customers, churned_customers, and churn_to_activity_ratio.

Order the results by month_year ascending.

**Expected Output:**

| month_year | newly_acquired_customers | churned_customers | churn_to_activity_ratio |
| ---------- | ------------------------ | ----------------- | ----------------------- |
| 2024-01    | 4                        | 0                 |                         |
| 2024-02    | 0                        | 0                 | 0.00                    |
| 2024-03    | 0                        | 1                 | 16.67                   |
| 2024-04    | 1                        | 1                 | 33.33                   |
| 2024-05    | 0                        | 0                 | 0.00                    |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 3: Customer Lifetime Value (CLV) with Event Count

Calculate the Customer Lifetime Value (CLV) for each customer, defined as the SUM(value) for all 'Purchase' and 'Subscription_Renewal' events.

Also, count the total_events (all event types) for each customer.

Return customer_id, total_clv (rounded to two decimal places, 0.00 if no value events), and total_events.

Order the results by total_clv descending, then by customer_id ascending.

**Expected Output:**

| customer_id | total_clv | total_events |
| ----------- | --------- | ------------ |
| 1           | 155.00    | 9            |
| 2           | 120.00    | 5            |
| 3           | 75.00     | 4            |
| 4           | 10.00     | 2            |
| 5           | 0.00      | 5            |

**Your Solution:**

```sql
--- Write your solution here

```
