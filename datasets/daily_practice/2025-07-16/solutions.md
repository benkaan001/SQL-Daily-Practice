# SQL Daily Practice - 2025-07-16 Solutions


### Question 1: Monthly Ticket Performance by Category

For each category and month in 2024, calculate the total_tickets_created, total_tickets_resolved, and the resolution_rate_percentage.

A ticket is considered "resolved" if its status is 'Resolved' or 'Closed' and resolved_date is not NULL.

The resolution_rate_percentage is calculated as (total_tickets_resolved / total_tickets_created) * 100. If total_tickets_created is 0, the rate should be 0.00.

Round resolution_rate_percentage to two decimal places.

Output month_year (format %Y-%m), category, total_tickets_created, total_tickets_resolved, and resolution_rate_percentage.

Order the results by month_year ascending, then by category ascending.


**Expected Output:**
| year_and_month | category  | total_tickets_created | total_tickets_resolved | resolution_rate_percentage |
| -------------- | --------- | --------------------- | ---------------------- | -------------------------- |
| 2024-01        | Billing   | 1                     | 1                      | 100.00                     |
| 2024-01        | General   | 2                     | 2                      | 100.00                     |
| 2024-01        | Technical | 1                     | 1                      | 100.00                     |
| 2024-02        | Billing   | 1                     | 1                      | 100.00                     |
| 2024-02        | General   | 1                     | 1                      | 100.00                     |
| 2024-02        | Technical | 3                     | 1                      | 33.33                      |
| 2024-03        | Billing   | 1                     | 0                      | 0.00                       |
| 2024-03        | General   | 3                     | 3                      | 100.00                     |
| 2024-03        | Technical | 1                     | 1                      | 100.00                     |
| 2024-04        | Billing   | 2                     | 2                      | 100.00                     |
| 2024-04        | General   | 1                     | 1                      | 100.00                     |
| 2024-04        | Technical | 2                     | 1                      | 50.00                      |

```sql
WITH resolutions AS (
	SELECT
		DATE_FORMAT(created_date, '%Y-%m') AS year_and_month,
		category,
		COUNT(*) AS total_tickets_created,
		SUM(CASE WHEN status IN ('Resolved', 'Closed') AND resolved_date IS NOT NULL THEN 1 ELSE 0 END) AS total_tickets_resolved
	FROM
		Tickets
	WHERE
		YEAR(created_date) = 2024
	GROUP BY
		DATE_FORMAT(created_date, '%Y-%m'),
		category
)
SELECT
	year_and_month,
	category,
	total_tickets_created,
	total_tickets_resolved,
	ROUND((total_tickets_resolved * 100.0 / total_tickets_created), 2) AS resolution_rate_percentage
FROM
	resolutions
ORDER BY
	year_and_month,
	category;
```

### Question 2: Customers with Pending High-Priority Tickets

Identify customer_ids and customer_names who currently have at least one 'High' priority ticket that is still 'Open' or 'In Progress'.

For these customers, also count their total_high_priority_tickets (including resolved ones) and their total_open_or_in_progress_high_priority_tickets.

Order the results by customer_id ascending.

**Expected Output:**

| customer_id | customer_name | total_high_priority_tickets | total_open_or_in_progress_high_priority_tickets |
| ----------- | ------------- | --------------------------- | ----------------------------------------------- |
| 101         | Alice Smith   | 2                           | 1                                               |
| 102         | Bob Johnson   | 1                           | 1                                               |
| 106         | Fiona Hall    | 1                           | 1                                               |

**Your Solution:**

```sql
SELECT
	c.customer_id,
	c.customer_name,
	COUNT(t.ticket_id) AS total_high_priority_tickets,
	SUM(CASE WHEN t.status IN ('Open', 'In Progress') THEN 1 ELSE 0 END) AS total_open_or_in_progress_high_priority_tickets
FROM
	Customers c
JOIN
	Tickets t ON c.customer_id = t.customer_id
WHERE
	t.priority = 'High'
GROUP BY
	c.customer_id,
	c.customer_name
HAVING
	SUM(CASE WHEN t.status IN ('Open', 'In Progress') THEN 1 ELSE 0 END) > 0
ORDER BY
	c.customer_id;
```

### Question 3: Average Resolution Time by Priority and Category

Calculate the average_resolution_time_days for tickets, grouped by priority and category.

Resolution time is the difference between resolved_date and created_date.

Only include tickets that have a status of 'Resolved' or 'Closed' and a non-NULL resolved_date.

Round average_resolution_time_days to two decimal places.

Output priority, category, and average_resolution_time_days.

Order the results by priority (High, Medium, Low), then by category ascending.

**Expected Output:**

| priority | category  | average_resolution_time_days |
| -------- | --------- | ---------------------------- |
| High     | Technical | 1.00                         |
| Medium   | Billing   | 2.00                         |
| Medium   | Technical | 1.00                         |
| Low      | General   | 0.86                         |

```sql
SELECT
	priority,
	category,
	ROUND(AVG(DATEDIFF(resolved_date, created_date)), 2) AS average_resolution_time_days
FROM
	Tickets
WHERE
	status IN ('Resolved', 'Closed')
	AND resolved_date IS NOT NULL
GROUP BY
	priority,
	category
ORDER BY
	CASE
		WHEN priority = 'High' THEN 1
		WHEN priority = 'Medium' THEN 2
		WHEN priority = 'Low' THEN 3
	END ASC,
	category ASC;
```
