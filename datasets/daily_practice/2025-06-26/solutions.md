### Question 1: Course Completion Rate by Difficulty

Calculate the course completion rate (percentage of completed enrollments) for each course difficulty level.

A course is considered "completed" if completion_date is not NULL and progress_percentage is 100.00.

If a difficulty level has no enrollments, it should not appear in the results. If it has enrollments but no completions, its completion rate should be 0.00.

Round completion_rate_percentage to two decimal places.

Output difficulty, total_enrollments, total_completions, and completion_rate_percentage.

Order the results by difficulty in the order of 'Beginner', 'Intermediate', 'Advanced'.

**Expected Output:**

| **difficulty** | **total_enrollments** | **total_completions** | **completion_rate_percentage** |
| -------------------- | --------------------------- | --------------------------- | ------------------------------------ |
| Beginner             | 5                           | 3                           | 60.00                                |
| Intermediate         | 5                           | 2                           | 40.00                                |
| Advanced             | 2                           | 0                           | 0.00                                 |

**Your Solution:**

```
--- Write your solution here

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

```
--- Write your solution here

```

### Question 3: Average Time to Complete Intermediate Courses

Calculate the average time (in days) it takes for students to complete 'Intermediate' difficulty courses.

Only consider enrollments where completion_date is not NULL and progress_percentage is 100.00.

The time to complete is the difference between completion_date and enrollment_date.

Round the average_completion_time_days to two decimal places.

Output course_name, average_completion_time_days, and overall_intermediate_avg_days (the average completion time across all intermediate courses).

Order results by average_completion_time_days ascending.

**Expected Output:**

| **course_name**      | **average_completion_time_days** | **overall_intermediate_avg_days** |
| -------------------------- | -------------------------------------- | --------------------------------------- |
| SQL for Data Analysis      | 50.00                                  | 55.50                                   |
| Cloud Computing Essentials | 60.00                                  | 55.50                                   |

**Your Solution:**

```
--- Write your solution here

```
