# SQL Daily Practice - 2025-07-16 Solutions


### Question 1: Monthly Ticket Performance by Category

For each category and month in 2024, calculate the total_tickets_created, total_tickets_resolved, and the resolution_rate_percentage.

A ticket is considered "resolved" if its status is 'Resolved' or 'Closed' and resolved_date is not NULL.

The resolution_rate_percentage is calculated as (total_tickets_resolved / total_tickets_created) * 100. If total_tickets_created is 0, the rate should be 0.00.

Round resolution_rate_percentage to two decimal places.

Output month_year (format %Y-%m), category, total_tickets_created, total_tickets_resolved, and resolution_rate_percentage.

Order the results by month_year ascending, then by category ascending.

```sql
--- Write your solution here
```

### Question 2: Customers with Pending High-Priority Tickets

Identify customer_ids and customer_names who currently have at least one 'High' priority ticket that is still 'Open' or 'In Progress'.

For these customers, also count their total_high_priority_tickets (including resolved ones) and their total_open_or_in_progress_high_priority_tickets.

Order the results by customer_id ascending.

**Expected Output:**

| **customer_id** | **customer_name** | **total_high_priority_tickets** | **total_open_or_in_progress_high_priority_tickets** |
| --------------------- | ----------------------- | ------------------------------------- | --------------------------------------------------------- |
| 101                   | Alice Smith             | 2                                     | 1                                                         |
| 102                   | Bob Johnson             | 2                                     | 1                                                         |
| 106                   | Fiona Hall              | 1                                     | 1                                                         |

**Your Solution:**

```sql
--- Write your solution here
```

### Question 3: Average Resolution Time by Priority and Category

Calculate the average_resolution_time_days for tickets, grouped by priority and category.

Resolution time is the difference between resolved_date and created_date.

Only include tickets that have a status of 'Resolved' or 'Closed' and a non-NULL resolved_date.

Round average_resolution_time_days to two decimal places.

Output priority, category, and average_resolution_time_days.

Order the results by priority (High, Medium, Low), then by category ascending.

```sql
--- Write your solution here
```
