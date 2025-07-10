# SQL Daily Practice - 2025-07-15


### Question 1: Departmental Grade Distribution

For each department that offers courses, calculate the percentage of 'A' grades (grade >= 3.80), 'B' grades (3.00 <= grade < 3.80), 'C' grades (2.00 <= grade < 3.00), and 'Below C' grades (grade < 2.00) awarded across all semesters.

If a department has no grades in a certain range, its percentage should be 0.00.

Round percentages to two decimal places.

Output department, a_percentage, b_percentage, c_percentage, and below_c_percentage.

Order the results by department ascending.

**Expected Output:**

| **department** | **a_percentage** | **b_percentage** | **c_percentage** | **below_c_percentage** |
| -------------------- | ---------------------- | ---------------------- | ---------------------- | ---------------------------- |
| Computer Science     | 50.00                  | 37.50                  | 12.50                  | 0.00                         |
| History              | 0.00                   | 100.00                 | 0.00                   | 0.00                         |
| Mathematics          | 33.33                  | 50.00                  | 0.00                   | 16.67                        |
| Physics              | 66.67                  | 0.00                   | 0.00                   | 0.00                         |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 2: Student Academic Standing by Semester

For each student, determine their `academic_standing` for each semester they have grades, based on their average grade for that semester:

* 'Excellent' if average grade >= 3.50
* 'Good' if 2.50 <= average grade < 3.50
* 'Probation' if average grade < 2.50
  Return student_id, first_name, last_name, semester, semester_average_grade (rounded to two decimal places), and academic_standing.
  Order the results by student_id ascending, then by semester (chronologically: Fall 2023, Spring 2024, Summer 2024).

**Expected Output:**

| **student_id** | **first_name** | **last_name** | **semester** | **semester_average_grade** | **academic_standing** |
| -------------------- | -------------------- | ------------------- | ------------------ | -------------------------------- | --------------------------- |
| 101                  | Alice                | Smith               | Fall 2023          | 3.75                             | Excellent                   |
| 101                  | Alice                | Smith               | Spring 2024        | 3.90                             | Excellent                   |
| 101                  | Alice                | Smith               | Summer 2024        | 4.00                             | Excellent                   |
| 102                  | Bob                  | Johnson             | Fall 2023          | 3.00                             | Good                        |
| 102                  | Bob                  | Johnson             | Spring 2024        | 3.50                             | Excellent                   |
| 102                  | Bob                  | Johnson             | Summer 2024        | 2.50                             | Good                        |
| 103                  | Charlie              | Brown               | Fall 2023          | 4.00                             | Excellent                   |
| 103                  | Charlie              | Brown               | Spring 2024        | 3.80                             | Excellent                   |
| 103                  | Charlie              | Brown               | Summer 2024        | 3.00                             | Good                        |
| 104                  | Diana                | Miller              | Fall 2023          | 3.50                             | Excellent                   |
| 104                  | Diana                | Miller              | Spring 2024        | 3.00                             | Good                        |
| 105                  | Eve                  | Davis               | Spring 2024        | 3.00                             | Good                        |
| 106                  | Frank                | Wilson              | Fall 2023          | 1.50                             | Probation                   |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 3: Courses with Significant Grade Variance

Identify courses where the standard deviation of grades is higher than the average standard deviation of grades across all courses.

Only consider courses with at least 2 grades recorded.

Return course_id, course_name, department, and grade_standard_deviation (rounded to two decimal places).

Order the results by grade_standard_deviation descending, then by course_id ascending.

**Expected Output:**

| **course_id** | **course_name** | **department** | **grade_standard_deviation** |
| ------------------- | --------------------- | -------------------- | ---------------------------------- |
| 1006                | Operating Systems     | Computer Science     | 0.92                               |
| 1002                | Calculus I            | Mathematics          | 0.81                               |
| 1001                | Intro to Programming  | Computer Science     | 0.75                               |

**Your Solution:**

```sql
--- Write your solution here

```
