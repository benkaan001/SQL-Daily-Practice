## Question 1: Hourly Website Traffic Analysis

Analyze the website log data to determine traffic patterns by the hour of the day.

Your report should show the hour of the day (0-23), the total number of requests (hits), the number of unique visitors (counting distinct authenticated users and distinct IP addresses for unauthenticated guests), and the total bytes sent during that hour across all days.

Order the results by the hour of the day.

**Expected Output:**

| hour | total_hits | unique_visitors | total_bytes_sent |
| ---- | ---------- | --------------- | ---------------- |
| 8    | 6          | 3               | 112445           |
| 9    | 5          | 4               | 50705            |
| 10   | 1          | 1               | 512              |
| 11   | 2          | 2               | 26900            |
| 14   | 3          | 1               | 53776            |
| 15   | 2          | 2               | 26522            |
| 18   | 2          | 2               | 35060            |

**Your Solution:**

```sql
-- Write your solution here
```

## Question 2: Daily Error Rate Monitoring

Calculate the daily error rate for the website. An "error" is defined as any request with an HTTP status code of 400 or greater.

The report should include the date, the total number of requests for that day, the total number of errors, and the error rate calculated as a percentage, rounded to two decimal places.

Order the results by date.

**Expected Output:**

| log_date   | total_requests | error_count | error_rate_pct |
| ---------- | -------------- | ----------- | -------------- |
| 2023-04-01 | 9              | 2           | 22.22          |
| 2023-04-02 | 7              | 1           | 14.29          |
| 2023-04-03 | 5              | 1           | 20.00          |

**Your Solution:**

```sql
-- Write your solution here
```

## Question 3: User Conversion Funnel Analysis

Identify users who have shown purchase intent by first viewing a product and then visiting their cart on the same day.

The output should list the `user_id`, the date of the activity, the timestamp of their first product view on that day, and the timestamp of their first cart visit on that day. Only include authenticated users (`user_id` is not NULL).

Order the results by `user_id` and then by date.

**Expected Output:**

| user_id | activity_date | first_product_view_ts | first_cart_view_ts  |
| ------- | ------------- | --------------------- | ------------------- |
| 101     | 2023-04-01    | 2023-04-01 09:15:30   | 2023-04-01 09:16:10 |
| 104     | 2023-04-02    | 2023-04-02 14:01:25   | 2023-04-02 14:02:00 |

**Your Solution:**

```sql
-- Write your solution here
```
