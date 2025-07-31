## Question 1: Agent Performance and Ticket Volume

Generate a report that summarizes the performance of each support agent. The report should only include agents who have handled at least one ticket.

The report must contain the agent's ID, the total number of tickets they've closed, their average satisfaction rating (rounded to two decimal places), and their average time to resolution in hours (rounded to two decimal places). Tickets without a `satisfaction_rating` or `date_closed` should be excluded from the average calculations but not from the total ticket count if the agent is assigned.

Order the results by the total number of tickets handled in descending order.

**Expected Output:**

| **agent_id** | **total_tickets_handled** | **avg_satisfaction_rating** | **avg_resolution_time_hours** |
| ------------------ | ------------------------------- | --------------------------------- | ----------------------------------- |
| 501                | 6                               | 3.25                              | 67.25                               |
| 502                | 5                               | 4.50                              | 25.47                               |
| 503                | 4                               | 5.00                              | 24.38                               |
| 504                | 4                               | 5.00                              | 49.50                               |
| 505                | 3                               | 4.00                              | 48.21                               |

**Your Solution:**

```sql
-- Write your solution here
```

## Question 2: Customer Ticket Analysis

For each customer who has submitted at least one ticket, find their first ticket and their most recent ticket.

The output should include the `customer_id`, the `product_category` and `date_opened` of their first ticket, and the `product_category` and `date_opened` of their most recent ticket.

Order the results by `customer_id`.

**Expected Output:**

| **customer_id** | **first_ticket_category** | **first_ticket_date** | **latest_ticket_category** | **latest_ticket_date** |
| --------------------- | ------------------------------- | --------------------------- | -------------------------------- | ---------------------------- |
| 101                   | Electronics                     | 2023-01-15 10:30:00         | Software                         | 2023-02-04 11:00:00          |
| 102                   | Software                        | 2023-01-16 11:05:00         | Software                         | 2023-01-30 09:00:00          |
| 103                   | Home Goods                      | 2023-01-17 14:00:00         | Electronics                      | 2023-01-27 16:00:00          |
| 104                   | Electronics                     | 2023-01-19 16:20:00         | Electronics                      | 2023-02-06 17:30:00          |
| 105                   | Apparel                         | 2023-01-20 13:15:00         | Home Goods                       | 2023-02-02 13:00:00          |
| 106                   | Home Goods                      | 2023-01-22 11:50:00         | Home Goods                       | 2023-02-08 14:00:00          |
| 107                   | Electronics                     | 2023-01-23 10:00:00         | Electronics                      | 2023-02-03 15:00:00          |
| 108                   | Books                           | 2023-01-25 09:45:00         | Books                            | 2023-02-09 18:00:00          |
| 109                   | Home Goods                      | 2023-01-26 12:10:00         | Home Goods                       | 2023-01-26 12:10:00          |
| 110                   | Software                        | 2023-01-28 11:30:00         | Software                         | 2023-01-28 11:30:00          |
| 111                   | Apparel                         | 2023-02-01 10:00:00         | Apparel                          | 2023-02-01 10:00:00          |
| 112                   | Home Goods                      | 2023-02-05 16:00:00         | Home Goods                       | 2023-02-05 16:00:00          |
| 113                   | Software                        | 2023-02-07 09:20:00         | Software                         | 2023-02-07 09:20:00          |

**Your Solution:**

```sql
-- Write your solution here

```

## Question 3: Unresolved High-Priority Tickets

Management needs a list of all 'High' or 'Critical' priority tickets that are still open (i.e., `date_closed` is NULL).

For each of these tickets, the report should show the `ticket_id`, `priority`, how many days the ticket has been open as of '2023-02-15', and the `product_category`. The report should also include a column named `follow_up_agent`, which should display the `agent_id` if one is assigned, otherwise it should display 'Unassigned'.

Order the results by the number of days open, from longest to shortest.

**Expected Output:**

| **ticket_id** | **priority** | **days_open** | **product_category** | **follow_up_agent** |
| ------------------- | ------------------ | ------------------- | -------------------------- | ------------------------- |
| 12                  | High               | 20                  | Home Goods                 | 504                       |

**Your Solution:**

```sql
-- Write your solution here
```

