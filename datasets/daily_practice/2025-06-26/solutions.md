### Question 1: Course Completion Rate by Difficulty

Calculate the course completion rate (percentage of completed enrollments) for each course difficulty level.

A course is considered "completed" if completion_date is not NULL and progress_percentage is 100.00.

If a difficulty level has no enrollments, it should not appear in the results. If it has enrollments but no completions, its completion rate should be 0.00.

Round completion_rate_percentage to two decimal places.

Output difficulty, total_enrollments, total_completions, and completion_rate_percentage.

Order the results by difficulty in the order of 'Beginner', 'Intermediate', 'Advanced'.

**Expected Output:**

| difficulty   | total_enrollments | total_completions | completion_rate_percentage |
| ------------ | ----------------- | ----------------- | -------------------------- |
| Beginner     | 7                 | 4                 | 57.14                      |
| Intermediate | 9                 | 3                 | 33.33                      |
| Advanced     | 2                 | 0                 | 0.00                       |


**Your Solution:**

```sql
WITH completions AS (
	SELECT
		c.difficulty,
		CASE
			WHEN c.difficulty = 'Beginner' THEN 1
			WHEN c.difficulty = 'Intermediate' THEN 2
			ELSE 3
		END AS difficulty_order,
		COUNT(DISTINCT enrollment_id) AS total_enrollments,
		SUM(CASE WHEN e.completion_date IS NOT NULL AND e.progress_percentage = 100.00 THEN 1 ELSE 0 END) AS total_completions
	FROM
		Courses c
	JOIN
		Enrollments e ON e.course_id  = c.course_id
	GROUP BY
		c.difficulty,
		difficulty_order
)
SELECT
	difficulty,
	total_enrollments,
	total_completions,
	ROUND(IFNULL(total_completions  * 100.0 / total_enrollments, 0), 2) AS completion_rate_percentage
FROM
	completions
ORDER BY
	difficulty_order;

```

### Question 2: Students with Diverse Course Completions

Find student_ids and the number_of_categories they have completed courses in, considering only categories where they have completed at least one course.

A student completes a course if completion_date is not NULL and progress_percentage is 100.00.

Also, show the most_completed_category for each student (the category in which they completed the most courses). If there's a tie, choose the category alphabetically.

Only include students who have completed at least one course.

Order the results by number_of_categories descending, then by student_id ascending.

**Expected Output:**

| **student_id** | **number_of_categories** | **most_completed_category** |
| -------------------- | ------------------------------ | --------------------------------- |
| 1                    | 2                              | Programming                       |
| 2                    | 1                              | Data Science                      |
| 3                    | 1                              | Programming                       |
| 4                    | 1                              | Data Science                      |
| 7                    | 1                              | IT & Software                     |

**Your Solution:**

```sql
WITH completions AS (
    SELECT
        e.student_id,
        c.category,
        COUNT(e.enrollment_id) AS courses_completed_in_category
    FROM
        Enrollments e
    JOIN
        Courses c ON e.course_id = c.course_id
    WHERE
        e.completion_date IS NOT NULL
        AND e.progress_percentage = 100.00
    GROUP BY
        e.student_id,
        c.category
),
ranked_completions AS (
    SELECT
        student_id,
        category,
        courses_completed_in_category,
        DENSE_RANK() OVER (PARTITION BY student_id ORDER BY courses_completed_in_category DESC, category ASC) AS category_rank
    FROM
        completions
),
completion_counts AS (
    SELECT
        student_id,
        COUNT(DISTINCT category) AS number_of_categories,
        MAX(CASE WHEN category_rank = 1 THEN category END) AS most_completed_category
    FROM
        ranked_completions
    GROUP BY
        student_id
)
SELECT
    student_id,
    number_of_categories,
    most_completed_category
FROM
   completion_counts
ORDER BY
    number_of_categories DESC,
    student_id ASC;

```

### Question 3: Average Time to Complete Intermediate Courses

Calculate the average time (in days) it takes for students to complete 'Intermediate' difficulty courses.

Only consider enrollments where completion_date is not NULL and progress_percentage is 100.00.

The time to complete is the difference between completion_date and enrollment_date.

Round the average_completion_time_days to two decimal places.

Output course_name, average_completion_time_days, and overall_intermediate_avg_days (the average completion time across all intermediate courses).

Order results by average_completion_time_days ascending.

**Expected Output:**

| course_name                | ROUND(average_completion_time_days, 2) | overall_completion_avg_days |
| -------------------------- | -------------------------------------- | --------------------------- |
| SQL for Data Analysis      | 48.00                                  | 54.00                       |
| Cloud Computing Essentials | 60.00                                  | 54.00                       |

**Your Solution:**

```sql
WITH intermediate_completions AS (
	SELECT
		c.course_name,
		AVG(TIMESTAMPDIFF(DAY, e.enrollment_date, e.completion_date)) AS average_completion_time_days
	FROM
		Courses c
	JOIN
		Enrollments e ON c.course_id = e.course_id
	WHERE
		c.difficulty = 'Intermediate'
		AND e.completion_date IS NOT NULL
		AND e.progress_percentage = 100.00
	GROUP BY
		c.course_name
)
SELECT
	course_name,
	ROUND(average_completion_time_days, 2),
	ROUND(AVG(average_completion_time_days) OVER (), 2) AS overall_completion_avg_days
FROM
	intermediate_completions
ORDER BY
	average_completion_time_days;

```
