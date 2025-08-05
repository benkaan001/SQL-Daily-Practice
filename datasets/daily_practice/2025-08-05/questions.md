## Question 1: Course Completion Funnel

Analyze the student completion funnel for each course. The report should show:

1. `total_enrollments`: The total number of unique users who enrolled.
2. `total_started`: The number of users who started at least one lesson.
3. `total_completed`: The number of users who successfully passed the final quiz for the course. Assume the quiz with the highest `lesson_or_quiz_id` for a given course is the final one, and a passing score is 70 or higher.
4. `completion_rate`: The percentage of users who enrolled and went on to complete the course.

Order the results by `course_id`.

**Expected Output:**

| **course_id** | **total_enrollments** | **total_started** | **total_completed** | **completion_rate_pct** |
| ------------------- | --------------------------- | ----------------------- | ------------------------- | ----------------------------- |
| 1001                | 3                           | 2                       | 1                         | 33.33                         |
| 1002                | 2                           | 2                       | 2                         | 100.00                        |
| 1003                | 1                           | 1                       | 0                         | 0.00                          |

**Your Solution:**

```sql
-- Write your solution here
```

## Question 2: Identifying "At-Risk" Students

Identify students who are currently "at-risk" as of '2023-11-01'. An at-risk student is defined as someone who has an active course enrollment but meets one of the following criteria:

1. They enrolled in a course but have not started the first lesson within 7 days of enrolling.
2. They have started a course but have shown no activity (of any type) for more than 14 consecutive days.

A student is no longer considered at-risk for a course once they have completed it (passed the final quiz). The report should show the `user_id`, `course_id`, the date of their `last_activity_timestamp` for that course, and the specific `risk_reason`.

**Expected Output:**

| **user_id** | **course_id** | **last_activity_timestamp** | **risk_reason**          |
| ----------------- | ------------------- | --------------------------------- | ------------------------------ |
| 102               | 1001                | 2023-10-02 11:45:00               | Inactive for more than 14 days |
| 104               | 1001                | 2023-10-15 09:00:00               | Did not start within 7 days    |
| 105               | 1003                | 2023-10-22 12:00:00               | Inactive for more than 14 days |

**Your Solution:**

```sql
-- Write your solution here
```

## Question 3: Quiz Performance and Difficulty Analysis

Analyze the performance on all quizzes to gauge their difficulty. For each quiz (`lesson_or_quiz_id`) in each course:

1. Calculate the `avg_first_attempt_score`. This should only consider the very first score a user gets on that specific quiz.
2. Calculate the `pass_rate_pct`, which is the percentage of first attempts that scored 70 or higher.
3. Calculate the `avg_attempts_to_pass`, which is the average number of attempts it took for users who eventually passed the quiz. Users who never passed should be excluded from this specific calculation.

Order the results by `course_id` and then `lesson_or_quiz_id`.

**Expected Output:**

| **course_id** | **lesson_or_quiz_id** | **avg_first_attempt_score** | **pass_rate_pct** | **avg_attempts_to_pass** |
| ------------------- | --------------------------- | --------------------------------- | ----------------------- | ------------------------------ |
| 1001                | 1                           | 95.00                             | 100.00                  | 1.00                           |
| 1002                | 1                           | 78.50                             | 50.00                   | 1.50                           |
| 1002                | 2                           | 94.00                             | 100.00                  | 1.00                           |

**Your Solution:**

```sql
-- Write your solution here
```
