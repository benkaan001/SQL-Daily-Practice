## Question 1: Departmental Performance Snapshot

Create a report that summarizes the latest performance review for each department.

For each department, find the average performance score, average potential score, and the total number of projects completed from the most recent review cycle (reviews conducted in December 2023).

Order the results by department name alphabetically.

**Expected Output:**

| **department** | **avg_performance_score** | **avg_potential_score** | **total_projects_completed** |
| -------------------- | ------------------------------- | ----------------------------- | ---------------------------------- |
| Engineering          | 4.60                            | 4.60                          | 20                                 |
| Marketing            | 4.00                            | 3.95                          | 10                                 |
| Sales                | 4.20                            | 4.37                          | 39                                 |

**Your Solution:**

```sql
-- Write your solution here

```

## Question 2: Employee Performance Progression

Analyze the performance progression of each employee between their reviews. For each review, compare the performance score to the score from their immediately preceding review.

The output should include the `employee_id`, `review_date`, the current `performance_score`, the `previous_performance_score`, and the change in score. The first review for each employee should have a NULL `previous_performance_score`.

Order the results by `employee_id` and then by `review_date`.

**Expected Output:**

| **employee_id** | **review_date** | **performance_score** | **previous_performance_score** | **score_change** |
| --------------------- | --------------------- | --------------------------- | ------------------------------------ | ---------------------- |
| 101                   | 2022-12-15            | 4.50                        | NULL                                 | NULL                   |
| 101                   | 2023-06-15            | 4.60                        | 4.50                                 | 0.10                   |
| 101                   | 2023-12-15            | 4.80                        | 4.60                                 | 0.20                   |
| 102                   | 2022-12-15            | 4.20                        | NULL                                 | NULL                   |
| 102                   | 2023-06-15            | 4.00                        | 4.20                                 | -0.20                  |
| 102                   | 2023-12-15            | 4.30                        | 4.00                                 | 0.30                   |
| 103                   | 2022-12-20            | 3.80                        | NULL                                 | NULL                   |
| 103                   | 2023-06-20            | 4.10                        | 3.80                                 | 0.30                   |
| 103                   | 2023-12-20            | 4.00                        | 4.10                                 | -0.10                  |
| 104                   | 2022-12-20            | 4.00                        | NULL                                 | NULL                   |
| 104                   | 2023-06-22            | 3.50                        | 4.00                                 | -0.50                  |
| 104                   | 2023-12-22            | 3.80                        | 3.50                                 | 0.30                   |
| 105                   | 2023-06-18            | 4.80                        | NULL                                 | NULL                   |
| 105                   | 2023-12-18            | 4.70                        | 4.80                                 | -0.10                  |
| 106                   | 2023-06-20            | 4.90                        | NULL                                 | NULL                   |
| 106                   | 2023-12-20            | 4.70                        | 4.90                                 | -0.20                  |
| 107                   | 2023-06-22            | 4.30                        | NULL                                 | NULL                   |
| 107                   | 2023-12-22            | 4.20                        | 4.30                                 | -0.10                  |
| 108                   | 2023-12-20            | 3.90                        | NULL                                 | NULL                   |

**Your Solution:**

```sql
-- Write your solution here

```

## Question 3: Identifying High-Potential Employees Due for Promotion

Identify employees who are strong candidates for promotion based on their latest review in 2023. A strong candidate is defined as having a `performance_score` of 4.5 or higher and a `potential_score` of 4.8 or higher.

The report should also calculate the number of months since their last promotion as of their latest review date. Exclude employees who have never been promoted (`last_promotion_date` is NULL).

Order the results by the months since the last promotion in descending order.

**Expected Output:**

| **employee_id** | **department** | **latest_review_date** | **performance_score** | **potential_score** | **months_since_last_promotion** |
| --------------------- | -------------------- | ---------------------------- | --------------------------- | ------------------------- | ------------------------------------- |
| 101                   | Engineering          | 2023-12-15                   | 4.80                        | 4.90                      | 5                                     |
| 105                   | Engineering          | 2023-12-18                   | 4.70                        | 4.80                      | 5                                     |

**Your Solution:**

```sql
-- Write your solution here

```
