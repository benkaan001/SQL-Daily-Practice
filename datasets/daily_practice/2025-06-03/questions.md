# Advanced SQL Practice Questions - Gym Management Database

## Question 1: Trainer Effectiveness by Feedback
*Task:* For each trainer with at least 1 rating, show their name, specialty, average rating, and the percentage of ratings that are 5.0. Order by average rating descending, then percent_5star descending.

*Expected Output:*
| trainer_name  | specialty         | avg_rating | percent_5star |
| ------------- | ----------------- | ---------- | ------------- |
| Linda Brown   | Yoga              | 5.00       | 100.00        |
| Sarah White   | Pilates           | 5.00       | 100.00        |
| Quincy Adams  | Strength Training | 5.00       | 100.00        |
| Michael Green | CrossFit          | 4.00       | 0.00          |
| Peter Parker  | Zumba             | 4.00       | 0.00          |

```sql
-- Write your SQL query here
```

## Question 2: Class Overbooking Detection
*Task:* List all classes where the number of active enrollments exceeds the class capacity. Show class name, trainer name, capacity, active_enrollments, and the overbooked amount (active_enrollments - capacity).

*Expected Output:*
*Expected Output:*
| class_name         | trainer_name   | capacity | active_enrollments | overbooked |
|--------------------|---------------|----------|--------------------|------------|

```sql
-- Write your SQL query here
```

## Question 3: Most Popular Class Times
*Task:* For each day of the week, find the class with the highest attendance (present or late) on that day. Show weekday, class name, trainer name, and attendance_count. Order by weekday (Monday to Sunday).

*Expected Output:*
| weekday   | class_name         | trainer_name  | attendance_count |
| --------- | ------------------ | ------------- | ---------------- |
| Wednesday | Nutrition Workshop | Fatima Hassan | 2                |
| Thursday  | Beginner Yoga      | Linda Brown   | 2                |
| Friday    | Boxing Advanced    | Alex Thompson | 1                |
| Saturday  | Morning HIIT       | Kim Jong      | 1                |

```sql
-- Write your SQL query here
```

