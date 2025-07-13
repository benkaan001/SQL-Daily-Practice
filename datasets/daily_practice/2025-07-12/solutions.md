# SQL Daily Practice - 2025-07-12

## Questions

### Question 1: Employees with Consistent High Performance and No Recent Promotion

Identify employees who have received a rating of 4 or 5 in all their performance reviews, but have not been promoted in the last 12 months (relative to July 12, 2025).

Return employee_id, first_name, last_name, department, and last_review_rating.

Exclude employees with no performance reviews.

Order the results by employee_id ascending.

**Expected Output:**

| employee_id | first_name | last_name | department  | last_review_rating |
| ----------- | ---------- | --------- | ----------- | ------------------ |
| 101         | Alice      | Smith     | Engineering | 5                  |
| 103         | Charlie    | Brown     | HR          | 4                  |
| 104         | Diana      | Miller    | Sales       | 5                  |

**Your Solution:**

```sql
WITH high_performers AS (
	SELECT
		employee_id
	FROM
		PerformanceReviews
	GROUP BY
		employee_id
	HAVING
		MIN(rating) >= 4
),
last_reviews AS (
	SELECT
		employee_id,
		rating,
		ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rn
	FROM
		PerformanceReviews
)
SELECT
	e.employee_id,
	e.first_name,
	e.last_name,
	e.department,
	lr.rating AS last_review_rating
FROM
	Employees e
JOIN
	high_performers hp ON hp.employee_id = e.employee_id
JOIN
	last_reviews lr ON lr.employee_id = hp.employee_id AND lr.rn = 1
WHERE
	e.employee_id NOT IN (
		SELECT
			employee_id
		FROM
			Promotions
		WHERE
			promotion_date > DATE_SUB('2025-07-12', INTERVAL 1 YEAR)
	)
ORDER BY
	e.employee_id;
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

| department  | average_time_to_promotion_days | promotion_rate_per_department |
| ----------- | ------------------------------ | ----------------------------- |
| Engineering | 872                            | 66.67                         |
| HR          | 394                            | 50.00                         |
| Sales       | 377                            | 50.00                         |

**Your Solution:**

```sql
WITH departments AS (
	SELECT
		e.employee_id,
		e.department,
		DATEDIFF(MIN(p.promotion_date), e.hire_date) AS promotion_days
	FROM
		Employees e
	RIGHT JOIN
		Promotions p ON e.employee_id = p.employee_id
	WHERE
		p.promotion_date IS NOT NULL
	GROUP BY
		e.employee_id,
		e.department
)
SELECT
	d.department,
	ROUND(AVG(d.promotion_days)) AS average_time_to_promotion_days,
	ROUND(
		COUNT(*) * 100 / (SELECT COUNT(department) FROM Employees e WHERE e.department = d.department)
	, 2) AS promotion_rate_per_department
FROM
	departments d
GROUP BY
	d.department
ORDER BY
	promotion_rate_per_department DESC,
	d.department ASC;
```

### Question 3: Salary Increase vs. Performance Rating Trend

For each employee who has had at least two performance reviews, compare their latest review rating with their earliest review rating, and their latest salary with their earliest salary (at the time of their earliest review).

Calculate rating_change (latest rating - earliest rating) and salary_growth_percentage ((latest salary - earliest salary) / earliest salary * 100).

Assume earliest salary is current_salary at hire_date for simplicity, and latest salary is current_salary from Employees table.

Output employee_id, first_name, last_name, earliest_review_date, earliest_rating, latest_review_date, latest_rating, rating_change, salary_growth_percentage (rounded to two decimal places).

Order the results by employee_id ascending.

**Expected Output:**

| employee_id | first_name | last_name | earliest_review_date | earliest_rating | latest_review_date | latest_rating | rating_change | salary_growth_percentage |
| ----------- | ---------- | --------- | -------------------- | --------------- | ------------------ | ------------- | ------------- | ------------------------ |
| 101         | Alice      | Smith     | 2023-07-01           | 5               | 2024-07-01         | 5             | 0             | 10.00                    |
| 102         | Bob        | Johnson   | 2023-07-15           | 4               | 2024-07-15         | 4             | 0             | 11.76                    |
| 103         | Charlie    | Brown     | 2023-08-01           | 3               | 2024-08-01         | 4             | 1             | 7.69                     |
| 104         | Diana      | Miller    | 2023-07-01           | 5               | 2024-07-01         | 5             | 0             | 20.00                    |
| 105         | Eve        | Davis     | 2023-08-10           | 3               | 2024-08-10         | 3             | 0             | 0.00                     |
| 106         | Frank      | Wilson    | 2023-07-20           | 4               | 2024-07-20         | 4             | 0             | 0.00                     |


**Your Solution:**

```sql
WITH ranked_reviews AS (
	SELECT
		employee_id,
		review_date,
		rating,
		ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_date ASC) AS rn_asc,
		ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rn_desc
	FROM
		PerformanceReviews

),
changes AS (
	SELECT
		rev_asc.employee_id,
		rev_asc.review_date AS earliest_review_date,
		rev_asc.rating AS earliest_rating,
		rev_desc.review_date AS latest_review_date,
		rev_desc.rating AS latest_rating
	FROM
		ranked_reviews rev_asc
	JOIN
	 	ranked_reviews rev_desc ON rev_asc.employee_id  = rev_desc.employee_id
	WHERE
		rev_asc.rn_asc  = 1 AND rev_desc.rn_desc = 1
		AND rev_asc.review_date  != rev_desc.review_date
),
salaries AS (
	SELECT
		employee_id,
		SUM(salary_increase) AS total_increase
	FROM
		Promotions
	GROUP BY
		employee_id
)
SELECT
	e.employee_id,
	e.first_name,
	e.last_name,
	c.earliest_review_date,
	c.earliest_rating,
	c.latest_review_date,
	c.latest_rating,
	(c.latest_rating - c.earliest_rating) AS rating_change,
	ROUND(
        COALESCE(s.total_increase, 0) * 100.0 / (e.current_salary - COALESCE(s.total_increase, 0))
    , 2) AS salary_growth_percentage
FROM
	Employees e
JOIN
 	changes c ON e.employee_id = c.employee_id
LEFT JOIN
	salaries s ON s.employee_id = c.employee_id
ORDER BY
	e.employee_id;
```

