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
SELECT
  t.trainer_name,
  t.specialty,
  ROUND(AVG(tr.rating), 2) AS avg_rating,
  ROUND((SUM(CASE WHEN tr.rating = 5 THEN 1 ELSE 0 END) / COUNT(tr.rating) * 100), 2) AS percent_5star
FROM
  trainers t
JOIN
  trainer_ratings tr ON t.trainer_id = tr.trainer_id
GROUP BY
  t.trainer_name,
  t.specialty
HAVING
  COUNT(tr.rating) >= 1
ORDER BY
  avg_rating DESC,
  percent_5star DESC;
```

## Question 2: Class Overbooking Detection
*Task:* List all classes where the number of active enrollments exceeds the class capacity. Show class name, trainer name, capacity, active_enrollments, and the overbooked amount (active_enrollments - capacity).

*Expected Output:*
| class_name         | trainer_name   | capacity | active_enrollments | overbooked |
|--------------------|---------------|----------|--------------------|------------|


```sql
SELECT
  c.class_name,
  t.trainer_name,
  c.capacity,
  SUM(CASE WHEN ce.status = "active" THEN 1 ELSE 0 END) AS active_enrollments,
  ABS(SUM(CASE WHEN ce.status = "active" THEN 1 ELSE 0 END) - c.capacity)  AS overbooked
FROM
  classes c
JOIN
  trainers t ON c.trainer_id = t.trainer_id
JOIN
  class_enrollments ce ON ce.class_id = c.class_id
GROUP BY
  c.class_name,
  t.trainer_name,
  c.capacity
HAVING
  SUM(CASE WHEN ce.status = "active" THEN 1 ELSE 0 END) - c.capacity > 0;
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
WITH weekday_based_attendance AS (
  SELECT
    DAYNAME(ca.attendance_date) AS weekday_nonnumeric,
    WEEKDAY(ca.attendance_date) AS weekday_numeric,
    c.class_name,
    t.trainer_name,
    COUNT(*) AS attendance_count
  FROM
    class_attendance ca
  JOIN
    classes c ON ca.class_id = c.class_id
  JOIN
    trainers t ON c.trainer_id = t.trainer_id
  WHERE
    ca.status IN ('present', 'late')
  GROUP BY
    weekday_nonnumeric,
    weekday_numeric,
    c.class_name,
    t.trainer_name
),
ranked_attendance AS (
  SELECT
    weekday_nonnumeric,
    weekday_numeric,
    class_name,
    trainer_name,
    attendance_count,
    ROW_NUMBER() OVER (PARTITION BY weekday_nonnumeric ORDER BY attendance_count DESC) AS row_num
  FROM
    weekday_based_attendance
)
SELECT
  weekday_nonnumeric AS 'weekday',
  class_name,
  trainer_name,
  attendance_count
FROM
  ranked_attendance
WHERE
  row_num = 1
ORDER BY
  weekday_numeric;
```

