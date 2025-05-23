# SQL Practice Questions - Gym Management Database

## Question 6: Member Engagement Timeline
Create a query that breaks down each member’s class attendance by month.
Display for each member the monthly count of their attended classes (use class_attendance) and a running total (cumulative sum) of classes attended.
Expected output:
| member_name     | year_and_month | monthly_classes | cumulative_classes |
| --------------- | -------------- | --------------- | ------------------ |
| Aisha Khan      | 2023-12        | 1               | 1                  |
| Alice Johnson   | 2022-03        | 1               | 1                  |
| Alice Johnson   | 2022-05        | 1               | 2                  |
| Alice Johnson   | 2022-07        | 1               | 3                  |
| Alice Johnson   | 2022-09        | 1               | 4                  |
| Alice Johnson   | 2023-01        | 1               | 5                  |
| Alice Johnson   | 2023-03        | 1               | 6                  |
| Alice Johnson   | 2023-05        | 1               | 7                  |
| Alice Johnson   | 2023-07        | 1               | 8                  |
| Alice Johnson   | 2023-08        | 1               | 9                  |
| Alice Johnson   | 2023-09        | 2               | 11                 |
| Alice Johnson   | 2023-10        | 2               | 13                 |
| Alice Johnson   | 2023-11        | 3               | 16                 |
| Alice Johnson   | 2023-12        | 11              | 27                 |
| Bob Smith       | 2022-03        | 1               | 1                  |
| Bob Smith       | 2023-01        | 1               | 2                  |
| Bob Smith       | 2023-03        | 1               | 3                  |
| Charlie Davis   | 2022-03        | 1               | 1                  |
| Charlie Davis   | 2022-05        | 1               | 2                  |
| Charlie Davis   | 2023-05        | 1               | 3                  |
| Charlie Davis   | 2023-12        | 1               | 4                  |
| Chen Wei        | 2023-12        | 1               | 1                  |
| Diana Lee       | 2022-07        | 1               | 1                  |
| Diana Lee       | 2023-07        | 1               | 2                  |
| Edward Kim      | 2022-07        | 1               | 1                  |
| Edward Kim      | 2023-08        | 1               | 2                  |
| Edward Kim      | 2023-12        | 1               | 3                  |
| Fiona Clark     | 2022-09        | 1               | 1                  |
| Fiona Clark     | 2023-09        | 1               | 2                  |
| Fiona Clark     | 2023-12        | 1               | 3                  |
| George Martin   | 2023-01        | 1               | 1                  |
| George Martin   | 2023-09        | 1               | 2                  |
| George Martin   | 2023-12        | 1               | 3                  |
| Hannah Lee      | 2023-03        | 1               | 1                  |
| Hannah Lee      | 2023-10        | 1               | 2                  |
| Hannah Lee      | 2023-12        | 1               | 3                  |
| Ian Wright      | 2023-05        | 1               | 1                  |
| Ian Wright      | 2023-10        | 1               | 2                  |
| Julia Roberts   | 2023-07        | 1               | 1                  |
| Julia Roberts   | 2023-11        | 1               | 2                  |
| Julia Roberts   | 2023-12        | 1               | 3                  |
| Kevin Durant    | 2023-08        | 1               | 1                  |
| Kevin Durant    | 2023-11        | 1               | 2                  |
| Kevin Durant    | 2023-12        | 1               | 3                  |
| Laura Palmer    | 2023-09        | 1               | 1                  |
| Laura Palmer    | 2023-11        | 1               | 2                  |
| Marcus Aurelius | 2023-09        | 1               | 1                  |
| Marcus Aurelius | 2023-12        | 1               | 2                  |
| Mohammed Ali    | 2023-11        | 2               | 2                  |
| Nina Simone     | 2023-10        | 1               | 1                  |
| Nina Simone     | 2023-11        | 1               | 2                  |
| Nina Simone     | 2023-12        | 1               | 3                  |
| Oliver Twist    | 2023-10        | 1               | 1                  |
| Oliver Twist    | 2023-12        | 1               | 2                  |
| Priya Patel     | 2023-11        | 1               | 1                  |
| Priya Patel     | 2023-12        | 1               | 2                  |
| Sofia Rodriguez | 2023-12        | 1               | 1                  |
| Yuki Tanaka     | 2023-12        | 1               | 1                  |
```sql
WITH monthly_attendance AS (
  SELECT
   m.member_name,
   DATE_FORMAT(ca.attendance_date, '%Y-%m') AS year_and_month,
   COUNT(DISTINCT ca.class_id) AS monthly_classes
  FROM
   members m
  JOIN 
   class_attendance ca ON m.member_id = ca.member_id
  WHERE 
   ca.status != 'absent'
  GROUP BY 
   m.member_name, year_and_month
)
SELECT 	
  member_name,
  year_and_month,
  monthly_classes,
  SUM(monthly_classes) OVER (PARTITION BY member_name ORDER BY year_and_month) AS cumulative_classes
FROM 
  monthly_attendance;
```

## Question 7: Class Popularity Trends
Calculate the average enrollment rate of each class type by quarter.
Group by quarter (e.g. 2023 Q4) and class name. Enrollment rate can be computed as (enrolled / capacity).
Expected output:

| quarter | class_name          | avg_enrollment_pct |
| ------- | ------------------- | ------------------ |
| 2023 Q4 | Boxing Advanced     | 100.00%            |
| 2023 Q4 | Functional Training | 75.00%             |
| 2023 Q4 | Morning HIIT        | 55.00%             |
| 2023 Q4 | HIIT Challenge      | 44.44%             |
| 2023 Q4 | Power Yoga          | 25.00%             |
| 2022 Q3 | Advanced Yoga       | 15.00%             |
| 2023 Q1 | Morning Yoga        | 15.00%             |
| 2022 Q1 | Beginner Yoga       | 10.00%             |
| 2022 Q2 | Intro to CrossFit   | 6.67%              |
| 2023 Q4 | Nutrition Workshop  | 6.67%              |
| 2022 Q3 | Pilates Basics      | 5.56%              |


```sql
WITH class_schedules AS (
    SELECT
        c.class_id,
        c.class_name,
        c.capacity,
        CASE
            WHEN MONTH(c.schedule_date) BETWEEN 1 AND 3 THEN CONCAT(YEAR(c.schedule_date), ' Q1')
            WHEN MONTH(c.schedule_date) BETWEEN 4 AND 6 THEN CONCAT(YEAR(c.schedule_date), ' Q2')
            WHEN MONTH(c.schedule_date) BETWEEN 7 AND 9 THEN CONCAT(YEAR(c.schedule_date), ' Q3')
            WHEN MONTH(c.schedule_date) BETWEEN 10 AND 12 THEN CONCAT(YEAR(c.schedule_date), ' Q4')
        END AS quarter
    FROM classes c
),
enrollment_counts AS (
    SELECT
        ce.class_id,
        COUNT(ce.enrollment_id) AS enrollment_count
    FROM class_enrollments ce
    GROUP BY ce.class_id
)
SELECT
    cs.quarter,
    cs.class_name,
    CONCAT(
        ROUND(AVG((ec.enrollment_count / cs.capacity) * 100), 2),
        '%'
    ) AS avg_enrollment_pct
FROM 
	class_schedules cs
JOIN 
	enrollment_counts ec ON cs.class_id = ec.class_id
GROUP BY 
	cs.quarter, 
    cs.class_name
ORDER BY 
	AVG((ec.enrollment_count / cs.capacity) * 100) DESC;
```


