# Advanced SQL Practice Questions - Gym Management Database

## Question 1: Membership Retention and Churn
*Task:* For each membership_type, calculate the number of members who joined in 2023, the number who have attended at least one class in the last 90 days (from the latest attendance date), and the churn rate (members with no attendance in the last 90 days / total joined in 2023, as a percent rounded to 2 decimals). Show only membership_types with at least 2 members joined in 2023.

*Expected Output:*
| membership_type | joined_2023 | active_last_90d | churn_rate |
|-----------------|-------------|-----------------|------------|
| Gold            | 4           | 2               | 50.00      |
| Silver          | 3           | 1               | 66.67      |

```sql
-- Write your SQL query here
```

## Question 2: Trainer Effectiveness by Feedback
*Task:* For each trainer with at least 3 ratings, show their name, specialty, average rating, and the percentage of ratings that are 5.0. Order by average rating descending, then percent_5star descending.

*Expected Output:*
| trainer_name   | specialty         | avg_rating | percent_5star |
|---------------|-------------------|------------|---------------|
| Linda Brown   | Yoga              | 4.80       | 80.00         |
| Michael Green | CrossFit          | 4.60       | 60.00         |
| Sarah White   | Pilates           | 4.50       | 50.00         |

```sql
-- Write your SQL query here
```

## Question 3: Class Overbooking Detection
*Task:* List all classes where the number of active enrollments exceeds the class capacity. Show class name, trainer name, capacity, active_enrollments, and the overbooked amount (active_enrollments - capacity).

*Expected Output:*
| class_name         | trainer_name   | capacity | active_enrollments | overbooked |
|--------------------|---------------|----------|--------------------|------------|
| Boxing Advanced    | Alex Thompson | 10       | 12                 | 2          |
| Functional Training| Sven Erikson  | 12       | 14                 | 2          |

```sql
-- Write your SQL query here
```

## Question 4: Most Popular Class Times
*Task:* For each day of the week, find the class with the highest attendance (present or late) on that day. Show weekday, class name, trainer name, and attendance_count. Order by weekday (Monday to Sunday).

*Expected Output:*
| weekday   | class_name        | trainer_name   | attendance_count |
|-----------|-------------------|---------------|------------------|
| Monday    | Morning Yoga      | Linda Brown   | 8                |
| Tuesday   | Pilates Basics    | Sarah White   | 6                |
| Wednesday | Zumba Dance       | Peter Parker  | 7                |
| Thursday  | Boxing Advanced   | Alex Thompson | 10               |
| Friday    | Functional Training| Sven Erikson | 9                |
| Saturday  | HIIT Challenge    | Kim Jong      | 12               |
| Sunday    | Senior Stretch    | David Cohen   | 5                |

```sql
-- Write your SQL query here
```

## Question 5: Trainer Specialization Impact on Retention
*Task:* For each trainer specialty, calculate the average number of repeat attendees per class (members who attended more than one class with the same specialty). Show specialty, avg_repeat_attendees, and total_classes. Order by avg_repeat_attendees descending.

*Expected Output:*
| specialty         | avg_repeat_attendees | total_classes |
|------------------|---------------------|---------------|
| Yoga             | 3.00                | 5             |
| CrossFit         | 2.50                | 5             |
| Pilates          | 2.00                | 2             |
| Boxing           | 1.50                | 3             |
| HIIT Training    | 1.00                | 3             |

```sql
-- Write your SQL query here
```
