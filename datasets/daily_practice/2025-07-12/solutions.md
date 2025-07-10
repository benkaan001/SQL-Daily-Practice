# SQL Daily Practice - 2025-07-12

## Questions

### Question 1: Employees with Consistent High Performance and No Recent Promotion

Identify employees who have received a rating of 4 or 5 in all their performance reviews, but have not been promoted in the last 12 months (relative to July 12, 2025).

Return employee_id, first_name, last_name, department, and last_review_rating.

Exclude employees with no performance reviews.

Order the results by employee_id ascending.

**Expected Output:**

| **employee_id** | **first_name** | **last_name** | **department** | **last_review_rating** |
| --------------------- | -------------------- | ------------------- | -------------------- | ---------------------------- |
| 106                   | Frank                | Wilson              | Marketing            | 4                            |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 2: Departmental Promotion Velocity

For each department, calculate the average_time_to_promotion_days for employees who have been promoted at least once.

The time to promotion is the difference between hire_date and promotion_date for their first promotion.

If a department has no promotions, it should not appear in the result.

Also, calculate the promotion_rate_per_department as (number of unique employees promoted / total employees in department) * 100.

Round average_time_to_promotion_days to zero decimal places and promotion_rate_per_department to two decimal places.

Output department, average_time_to_promotion_days, and promotion_rate_per_department.

Order the results by promotion_rate_per_department descending, then by department ascending.

**Expected Output:**

| **department** | **average_time_to_promotion_days** | **promotion_rate_per_department** |
| -------------------- | ---------------------------------------- | --------------------------------------- |
| HR                   | 395                                      | 50.00                                   |
| Sales                | 377                                      | 50.00                                   |
| Engineering          | 691                                      | 33.33                                   |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 3: Salary Increase vs. Performance Rating Trend

For each employee who has had at least two performance reviews, compare their latest review rating with their earliest review rating, and their latest salary with their earliest salary (at the time of their earliest review).

Calculate rating_change (latest rating - earliest rating) and salary_growth_percentage ((latest salary - earliest salary) / earliest salary * 100).

Assume earliest salary is current_salary at hire_date for simplicity, and latest salary is current_salary from Employees table.

Output employee_id, first_name, last_name, earliest_review_date, earliest_rating, latest_review_date, latest_rating, rating_change, salary_growth_percentage (rounded to two decimal places).

Order the results by employee_id ascending.

**Expected Output:**

| **employee_id** | **first_name** | **last_name** | **earliest_review_date** | **earliest_rating** | **latest_review_date** | **latest_rating** | **rating_change** | **salary_growth_percentage** |
| --------------------- | -------------------- | ------------------- | ------------------------------ | ------------------------- | ---------------------------- | ----------------------- | ----------------------- | ---------------------------------- |
| 101                   | Alice                | Smith               | 2023-07-01                     | 5                         | 2024-07-01                   | 5                       | 0                       | 10.00                              |
| 102                   | Bob                  | Johnson             | 2023-07-15                     | 4                         | 2024-07-15                   | 4                       | 0                       | 0.00                               |
| 103                   | Charlie              | Brown               | 2023-08-01                     | 3                         | 2024-08-01                   | 4                       | 1                       | 0.00                               |
| 104                   | Diana                | Miller              | 2023-07-01                     | 5                         | 2024-07-01                   | 5                       | 0                       | 0.00                               |
| 105                   | Eve                  | Davis               | 2023-08-10                     | 3                         | 2024-08-10                   | 3                       | 0                       | 0.00                               |
| 106                   | Frank                | Wilson              | 2023-07-20                     | 4                         | 2024-07-20                   | 4                       | 0                       | 0.00                               |

**Your Solution:**

```sql
--- Write your solution here

```

