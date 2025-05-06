## Question 1: Students with Above Average Total Score

Find all students whose total score (sum of all 3 assignments) is **above the average total score** for the class.
Output student and total_score.

**Expected Output:**

| student       | total_score |
| ------------- | ----------- |
| Donna Jimenez | 279         |
| Karen Austin  | 268         |
| Tom Saunders  | 258         |
| John Miranda  | 252         |
| Matthew Ward  | 245         |
| Tracie Lopez  | 244         |


**Your Solution:**
```sql
WITH class_average AS (
   SELECT
      	SUM(assignment1 + assignment2 + assignment3) / COUNT(*) average
      FROM
      	assignments
)
SELECT
	student,
    (assignment1 + assignment2 + assignment3) AS total_score
FROM
	assignments
WHERE
	(assignment1 + assignment2 + assignment3) > ( SELECT average FROM class_average)
ORDER BY
	total_score DESC;
```
---

## Question 2: Assignment with the Highest Average Score

Find which assignment (assignment1, assignment2, or assignment3) had the highest average score across all students.
Output assignment_name and avg_score (rounded to 2 decimals).

**Expected Output:**

| assignment_name | avg_score |
| --------------- | --------- |
| assignment3     | 78.5      |

**Your Solution:**
```sql
WITH assignment_averages AS (
  SELECT
  	'assignment1' AS assignment_name,
  	AVG(assignment1) AS avg_score
  FROM
  	assignments
  UNION ALL
  SELECT
  	'assignment2' AS assignment_name,
  	AVG(assignment2) AS avg_score
  FROM
  	assignments
  UNION ALL
  SELECT
  	'assignment3' AS assignment_name,
  	AVG(assignment3) AS avg_score
  FROM
  	assignments
)
SELECT
	assignment_name,
    ROUND(avg_score, 2) AS avg_score
FROM
	assignment_averages
ORDER BY
	avg_score DESC
LIMIT 1;
```
---

## Question 3: Students with the Most Improved Performance

Find the student(s) who improved the most from assignment1 to assignment3 (i.e., assignment3 - assignment1 is the largest).
Output student and improvement.

**Expected Output:**

| student        | improvement |
| -------------- | ----------- |
| John Miranda   | 3           |
| Tom Saunders   | 10          |
| Scott Taylor   | 10          |
| Natalie Palmer | 10          |
| Rachael Smith  | 4           |

*(But the highest improvement is 10, so only Tom Saunders, Scott Taylor, and Natalie Palmer are included.)*

| student        | improvement |
| -------------- | ----------- |
| Tom Saunders   | 10          |
| Scott Taylor   | 10          |
| Natalie Palmer | 10          |

**Your Solution:**
```sql
WITH ranked_students AS (
  SELECT
      student,
      (assignment3 - assignment1) AS improvement,
  	  DENSE_RANK() OVER (ORDER BY (assignment3 - assignment1) DESC) AS rnk
  FROM
      assignments
)
SELECT
	student,
    improvement
FROM
	ranked_students
WHERE
	rnk = 1;
```
---

