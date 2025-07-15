# SQL Daily Practice - 2025-07-15


### Question 1: Departmental Grade Distribution

For each department that offers courses, calculate the percentage of 'A' grades (grade >= 3.80), 'B' grades (3.00 <= grade < 3.80), 'C' grades (2.00 <= grade < 3.00), and 'Below C' grades (grade < 2.00) awarded across all semesters.

If a department has no grades in a certain range, its percentage should be 0.00.

Round percentages to two decimal places.

Output department, a_percentage, b_percentage, c_percentage, and below_c_percentage.

Order the results by department ascending.

**Expected Output:**

| department       | a_percentage | b_percentage | c_percentage | below_c_percentage |
| ---------------- | ------------ | ------------ | ------------ | ------------------ |
| Computer Science | 0.40         | 0.40         | 0.20         | 0.00               |
| History          | 0.00         | 1.00         | 0.00         | 0.00               |
| Mathematics      | 0.33         | 0.50         | 0.00         | 0.17               |
| Physics          | 1.00         | 0.00         | 0.00         | 0.00               |

**Your Solution:**

```sql
SELECT
	c.department,
	ROUND(AVG(CASE WHEN g.grade >= 3.80 THEN 1 ELSE 0 END), 2) AS a_percentage,
	ROUND(AVG(CASE WHEN g.grade >= 3.00 AND g.grade < 3.80  THEN 1 ELSE 0 END), 2) AS b_percentage,
	ROUND(AVG(CASE WHEN g.grade >= 2.00 AND g.grade < 3.00 THEN 1 ELSE 0 END), 2) AS c_percentage,
	ROUND(AVG(CASE WHEN g.grade < 2.00 THEN 1 ELSE 0 END), 2) AS below_c_percentage
FROM
	Courses c
LEFT JOIN
	Grades g ON g.course_id  = c.course_id
GROUP BY
	c.department
ORDER BY
	c.department;
```

### Question 2: Student Academic Standing by Semester

For each student, determine their `academic_standing` for each semester they have grades, based on their average grade for that semester:

* 'Excellent' if average grade >= 3.50
* 'Good' if 2.50 <= average grade < 3.50
* 'Probation' if average grade < 2.50
  Return student_id, first_name, last_name, semester, semester_average_grade (rounded to two decimal places), and academic_standing.
  Order the results by student_id ascending, then by semester (chronologically: Fall 2023, Spring 2024, Summer 2024).

**Expected Output:**

| student_id | first_name | last_name | semester    | ROUND(semester_average_grade, 2) | academic_standing |
| ---------- | ---------- | --------- | ----------- | -------------------------------- | ----------------- |
| 101        | Alice      | Smith     | Fall 2023   | 3.75                             | Excellent         |
| 101        | Alice      | Smith     | Spring 2024 | 3.90                             | Excellent         |
| 101        | Alice      | Smith     | Summer 2024 | 4.00                             | Excellent         |
| 102        | Bob        | Johnson   | Fall 2023   | 3.00                             | Good              |
| 102        | Bob        | Johnson   | Spring 2024 | 3.50                             | Excellent         |
| 102        | Bob        | Johnson   | Summer 2024 | 2.50                             | Good              |
| 103        | Charlie    | Brown     | Fall 2023   | 4.00                             | Excellent         |
| 103        | Charlie    | Brown     | Spring 2024 | 3.80                             | Excellent         |
| 103        | Charlie    | Brown     | Summer 2024 | 3.00                             | Good              |
| 104        | Diana      | Miller    | Fall 2023   | 3.50                             | Excellent         |
| 104        | Diana      | Miller    | Spring 2024 | 3.00                             | Good              |
| 105        | Eve        | Davis     | Spring 2024 | 3.00                             | Good              |
| 106        | Frank      | Wilson    | Fall 2023   | 1.50                             | Probation         |

**Your Solution:**

```sql
WITH avg_grades AS (
	SELECT
		g.student_id,
		s.first_name,
		s.last_name,
		g.semester,
		AVG(g.grade) AS semester_average_grade
	FROM
		Grades g
	JOIN
		Students s ON s.student_id = g.student_id
	WHERE
		g.grade IS NOT NULL
	GROUP BY
		g.student_id,
		g.semester
)
SELECT
	student_id,
	first_name,
	last_name,
	semester,
	ROUND(semester_average_grade, 2),
	CASE
		WHEN semester_average_grade >= 3.50 THEN 'Excellent'
		WHEN semester_average_grade< 3.50 AND semester_average_grade >= 2.50 THEN 'Good'
		ELSE 'Probation'
	END AS academic_standing

FROM
	avg_grades
ORDER BY
    student_id,
    SUBSTRING_INDEX(semester, ' ', -1),  -- sort by the year (the last part of the 'semester' string)
    CASE								 -- sort by the season's chronological order
        WHEN semester LIKE 'Spring%' THEN 1
        WHEN semester LIKE 'Summer%' THEN 2
        WHEN semester LIKE 'Fall%'   THEN 3
        ELSE 4
    END;
```

### Question 3: Courses with Significant Grade Variance

Identify courses where the standard deviation of grades is higher than the average standard deviation of grades across all courses.

Only consider courses with at least 2 grades recorded.

Return course_id, course_name, department, and grade_standard_deviation (rounded to two decimal places).

Order the results by grade_standard_deviation descending, then by course_id ascending.

**Expected Output:**

| course_id | course_name          | department       | grade_standard_deviation |
| --------- | -------------------- | ---------------- | ------------------------ |
| 1002      | Calculus I           | Mathematics      | 1.26                     |
| 1006      | Operating Systems    | Computer Science | 0.92                     |
| 1001      | Intro to Programming | Computer Science | 0.84                     |

**Your Solution:**

```sql
WITH std AS (
	SELECT
		g.course_id,
		c.course_name,
		c.department,
		STDDEV_SAMP(g.grade) AS grade_standard_deviation
	FROM
		Grades g
	JOIN
		Courses c ON c.course_id  = g.course_id
	GROUP BY
		g.course_id,
		c.course_name,
		c.department
	HAVING
		COUNT(g.grade_id) >= 2
)
SELECT
	course_id,
	course_name,
	department,
	ROUND(grade_standard_deviation, 2) AS grade_standard_deviation
FROM
	std
WHERE
	grade_standard_deviation > (SELECT STDDEV_SAMP(grade) FROM Grades)
ORDER BY
	grade_standard_deviation DESC,
	course_id ASC;

```
