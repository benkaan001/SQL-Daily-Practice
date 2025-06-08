# Advanced SQL Practice Questions - Gym Management Database

## Question 1: Member Loyalty and Class Streak
*Task:* Identify members who have attended at least one class for 3 or more consecutive months. Show member_name, the start date of their streak, the end date of their streak, and the total number of consecutive months. Consider a month "active" if they attended at least one class.

*Expected Output:*
| member_name   | streak_start_month | streak_end_month | consecutive_months |
|---------------|--------------------|------------------|--------------------|
| Alice Johnson | 2022-03-01         | 2022-05-01       | 3                  |
| Alice Johnson | 2023-01-01         | 2023-03-01       | 3                  |
| Bob Smith     | 2022-03-01         | 2022-05-01       | 3                  |
| Charlie Davis | 2022-03-01         | 2022-05-01       | 3                  |
| David Wilson  | 2022-03-01         | 2022-05-01       | 3                  |
| Eva Green     | 2022-03-01         | 2022-05-01       | 3                  |
| Frank Moore   | 2022-03-01         | 2022-05-01       | 3                  |
| Grace Lee     | 2022-03-01         | 2022-05-01       | 3                  |
| Henry King    | 2022-03-01         | 2022-05-01       | 3                  |
| Irene Martinez| 2022-03-01         | 2022-05-01       | 3                  |
| Jack Brown    | 2022-03-01         | 2022-05-01       | 3                  |
| Karen White   | 2022-03-01         | 2022-05-01       | 3                  |
| Leo Harris    | 2022-03-01         | 2022-05-01       | 3                  |
| Mia Clark     | 2022-03-01         | 2022-05-01       | 3                  |
| Noah Lewis    | 2022-03-01         | 2022-05-01       | 3                  |
| Olivia Robinson| 2022-03-01        | 2022-05-01       | 3                  |
| Paul Walker   | 2022-03-01         | 2022-05-01       | 3                  |
| Quinn Hall    | 2022-03-01         | 2022-05-01       | 3                  |
| Ryan Allen    | 2022-03-01         | 2022-05-01       | 3                  |
| Sophia Young  | 2022-03-01         | 2022-05-01       | 3                  |
| Tyler Hernandez| 2022-03-01        | 2022-05-01       | 3                  |
| Uma King      | 2022-03-01         | 2022-05-01       | 3                  |
| Victor Scott  | 2022-03-01         | 2022-05-01       | 3                  |
| Wendy Green   | 2022-03-01         | 2022-05-01       | 3                  |
| Xavier Adams  | 2022-03-01         | 2022-05-01       | 3                  |
| Yara Nelson   | 2022-03-01         | 2022-05-01       | 3                  |
| Zachary Carter| 2022-03-01         | 2022-05-01       | 3                  |

```sql
-- Write your SQL query here
```

## Question 2: Trainer Performance Fluctuation
*Task:* For each trainer, calculate their average rating per month. Then, identify any month where their average rating dropped by more than 0.5 points compared to the previous month. Show trainer_name, month_year, current_month_avg_rating, and previous_month_avg_rating.

*Expected Output:*
| trainer_name   | month_year | current_month_avg_rating | previous_month_avg_rating |
|----------------|------------|--------------------------|---------------------------|
| Michael Green  | 2022-11-01 | 4.00                     | 5.00                      |
| Sarah Connor   | 2022-11-01 | 3.50                     | 4.25                      |
| John Doe       | 2022-11-01 | 2.75                     | 3.50                      |
| Jane Smith     | 2022-11-01 | 4.50                     | 5.25                      |
| Emily Davis    | 2022-11-01 | 3.00                     | 3.75                      |
| Chris Brown    | 2022-11-01 | 4.25                     | 5.00                      |
| Anna Johnson   | 2022-11-01 | 3.75                     | 4.50                      |
| Robert Wilson  | 2022-11-01 | 2.50                     | 3.25                      |
| Jessica Lee    | 2022-11-01 | 4.75                     | 5.50                      |
| Michael Green  | 2022-12-01 | 3.50                     | 4.00                      |
| Sarah Connor   | 2022-12-01 | 3.00                     | 3.50                      |
| John Doe       | 2022-12-01 | 3.25                     | 2.75                      |
| Jane Smith     | 2022-12-01 | 4.00                     | 4.50                      |
| Emily Davis    | 2022-12-01 | 3.50                     | 3.00                      |
| Chris Brown    | 2022-12-01 | 4.00                     | 4.25                      |
| Anna Johnson   | 2022-12-01 | 3.25                     | 3.75                      |
| Robert Wilson  | 2022-12-01 | 2.75                     | 2.50                      |
| Jessica Lee    | 2022-12-01 | 4.50                     | 4.75                      |
| Michael Green  | 2023-01-01 | 4.00                     | 3.50                      |
| Sarah Connor   | 2023-01-01 | 3.50                     | 3.00                      |
| John Doe       | 2023-01-01 | 3.75                     | 3.25                      |
| Jane Smith     | 2023-01-01 | 4.25                     | 4.00                      |
| Emily Davis    | 2023-01-01 | 3.00                     | 3.50                      |
| Chris Brown    | 2023-01-01 | 4.50                     | 4.00                      |
| Anna Johnson   | 2023-01-01 | 3.75                     | 3.25                      |
| Robert Wilson  | 2023-01-01 | 2.50                     | 2.75                      |
| Jessica Lee    | 2023-01-01 | 4.75                     | 4.50                      |

```sql
-- Write your SQL query here
```

## Question 3: Class Popularity Trends and Peak Times
*Task:* Determine the most popular class (by total attendance) for each day of the week (e.g., Monday, Tuesday). Also, find the overall peak attendance hour for all classes combined. Show day_of_week, most_popular_class, total_attendance_for_class, and overall_peak_hour, peak_hour_attendance. (Assume schedule_date in `classes` table implies the time the class starts, and use `class_attendance` for attendance data).

*Expected Output:*
| day_of_week | most_popular_class | total_attendance_for_class | overall_peak_hour | peak_hour_attendance |
|-------------|--------------------|----------------------------|-------------------|----------------------|
| Monday      | Morning Yoga       | 8                          | 07:00             | 15                   |
| Tuesday     | Pilates Basics     | 7                          | 07:00             | 15                   |
| Wednesday   | HIIT Workout       | 10                         | 18:00             | 20                   |
| Thursday    | Evening Yoga       | 6                          | 19:00             | 18                   |
| Friday      | CrossFit Basics    | 9                          | 17:00             | 22                   |
| Saturday    | Zumba Class        | 12                         | 10:00             | 25                   |
| Sunday      | Rest Day           | 0                          | null              | 0                    |

```sql
-- Write your SQL query here
```

## Question 4: Member Cohort Analysis - First Class to Rating
*Task:* For cohorts of members based on their join_year and join_month, calculate the average time (in days) it takes for a member to give their first trainer rating after attending their first class. Show join_cohort (YYYY-MM), avg_days_to_first_rating.

*Expected Output:*
| join_cohort | avg_days_to_first_rating |
|-------------|--------------------------|
| 2022-01     | 5.5                      |
| 2022-02     | 3.0                      |
| 2022-03     | 4.0                      |
| 2022-04     | 6.5                      |
| 2022-05     | 7.0                      |
| 2022-06     | 8.0                      |
| 2022-07     | 4.5                      |
| 2022-08     | 3.5                      |
| 2022-09     | 6.0                      |
| 2022-10     | 5.0                      |
| 2022-11     | 7.5                      |
| 2022-12     | 4.0                      |
| 2023-01     | 3.0                      |
| 2023-02     | 6.0                      |
| 2023-03     | 5.5                      |
| 2023-04     | 4.5                      |
| 2023-05     | 3.5                      |
| 2023-06     | 6.5                      |
| 2023-07     | 7.0                      |
| 2023-08     | 4.0                      |
| 2023-09     | 5.0                      |
| 2023-10     | 7.5                      |
| 2023-11     | 3.0                      |
| 2023-12     | 6.0                      |

```sql
-- Write your SQL query here
```
