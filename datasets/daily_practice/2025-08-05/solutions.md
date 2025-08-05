## Question 1: Course Completion Funnel

Analyze the student completion funnel for each course. The report should show:

1. `total_enrollments`: The total number of unique users who enrolled.
2. `total_started`: The number of users who started at least one lesson.
3. `total_completed`: The number of users who successfully passed the final quiz for the course. Assume the quiz with the highest `lesson_or_quiz_id` for a given course is the final one, and a passing score is 70 or higher.
4. `completion_rate`: The percentage of users who enrolled and went on to complete the course.

Order the results by `course_id`.

**Expected Output:**

| course_id | total_enrollments | total_started | total_completed | completion_rate_pct |
| --------- | ----------------- | ------------- | --------------- | ------------------- |
| 1001      | 3                 | 2             | 1               | 33.33               |
| 1002      | 2                 | 2             | 2               | 100.00              |
| 1003      | 1                 | 1             | 0               | 0.00                |

**Your Solution:**

```sql
WITH grouped_courses AS (
	SELECT
		course_id,
		COUNT(DISTINCT CASE WHEN activity_type = 'enroll' THEN user_id END) AS total_enrollments,
		COUNT(DISTINCT CASE WHEN activity_type = 'start_lesson' THEN user_id END) AS total_started
	FROM
		course_activity
	GROUP BY
		course_id
),
final_quizzes AS (
	SELECT
		course_id,
		MAX(lesson_or_quiz_id) AS final_quiz_id
	FROM
		course_activity
	WHERE
		activity_type = 'take_quiz'
	GROUP BY
		course_id
),
completed_courses AS (
	SELECT
		ca.course_id,
		COUNT(DISTINCT ca.user_id) AS total_completed
	FROM
		course_activity ca
	LEFT JOIN
		final_quizzes fq ON ca.course_id = fq.course_id
		AND ca.lesson_or_quiz_id = fq.final_quiz_id
	WHERE
		ca.quiz_score >= 70
	GROUP BY
		ca.course_id
)
SELECT
	gc.course_id,
	gc.total_enrollments,
	gc.total_started,
	COALESCE(cc.total_completed, 0) AS total_completed,
	ROUND(COALESCE(cc.total_completed, 0) * 100.0 / gc.total_enrollments, 2 ) AS completion_rate_pct
FROM
	completed_courses cc
RIGHT JOIN
	grouped_courses gc ON gc.course_id = cc.course_id
ORDER BY
	gc.course_id;
```

