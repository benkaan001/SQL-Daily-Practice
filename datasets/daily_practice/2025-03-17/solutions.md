# SQL Practice Questions - Gym Management Database


## Question 11: Member Upgrade Potential
Identify Gold members (from the members table) who attend more than 8 classes per month (using class_attendance).
These members may be candidates for a Platinum membership upgrade.
Show their name, current membership type, monthly attended classes count. 

Expected output:
 member_name   | membership_type | monthly_classes |
| ------------- | --------------- | --------------- |
| Alice Johnson | Gold            | 11              |

```sql
WITH attendance AS (
    SELECT
        m.member_id,
        m.member_name,
        MONTH(ca.attendance_date) AS month,
        COUNT(ca.attendance_id) AS monthly_classes
    FROM
        members m
    LEFT JOIN
        class_attendance ca ON ca.member_id = m.member_id
    WHERE
        ca.status != 'absent'
    GROUP BY
        m.member_id, m.member_name, MONTH(ca.attendance_date)
), monthly_member_attendance AS (
    SELECT
        member_id,
        member_name,
        month,
        monthly_classes
    FROM
        attendance
    WHERE
        monthly_classes > 8
)
SELECT
    mma.member_name,
    m.membership_type,
    mma.monthly_classes
FROM
    monthly_member_attendance mma
JOIN
    members m ON m.member_id = mma.member_id
WHERE
    m.membership_type = 'Gold';
```

## Question 12: Trainer Revenue Impact
Estimate the revenue impact contributed by each trainer.
Using class attendance and membership types, calculate:
• Total number of classes they taught,
• Total class attendees

Expected output:

| trainer_name  | total_classes | total_attendees |
| ------------- | ------------- | --------------- |
| Linda Brown   | 5             | 17              |
| Michael Green | 4             | 11              |
| Alex Thompson | 3             | 9               |
| Kim Jong      | 3             | 9               |
| David Cohen   | 3             | 8               |
| Sarah White   | 2             | 7               |
| Maria Garcia  | 2             | 6               |
| Fatima Hassan | 1             | 5               |
| Peter Parker  | 2             | 5               |
| Sven Erikson  | 1             | 4               |
| Quincy Adams  | 1             | 3               |



```sql
SELECT
	t.trainer_name,
    COUNT(DISTINCT c.class_id) AS total_classes,
    COUNT(ca.attendance_id) AS total_attendees -- remember attencance_id is primary key hence no need to filter by distinct
FROM 	
	trainers t 
LEFT JOIN
	classes c ON t.trainer_id = c.trainer_id
LEFT JOIN 
	class_attendance ca ON ca.class_id = c.class_id
WHERE 
	ca.status != 'absent'
GROUP BY 
	t.trainer_name
ORDER BY 
	total_attendees DESC;
```





## Question 15: Seasonal Attendance Patterns
Analyze class attendance data across seasons (e.g., Summer, Winter).
Group the data by season and year (using attendance_date) and calculate the average attendance along with year-over-year percentage change.

Expected output:
| season | year | avg_attendance | yoy_change |
| ------ | ---- | -------------- | ---------- |
| Spring | 2022 | 4.0            | null       |
| Summer | 2022 | 3.0            | null       |
| Winter | 2022 | 7.0            | null       |
| Fall   | 2023 | 3.2            | null       |
| Spring | 2023 | 3.0            | -25.0      |
| Summer | 2023 | 3.0            | 0.0        |
| Winter | 2023 | 3.0            | -57.1      |

```sql
WITH daily_attendance AS (
    SELECT
        YEAR(attendance_date) AS year,
        CASE
            WHEN MONTH(attendance_date) BETWEEN 1 AND 3 THEN 'Winter'
            WHEN MONTH(attendance_date) BETWEEN 4 AND 6 THEN 'Spring'
            WHEN MONTH(attendance_date) BETWEEN 7 AND 9 THEN 'Summer'
            ELSE 'Fall'
        END AS season,
        DATE(attendance_date) AS attendance_day,
        COUNT(attendance_id) AS daily_attendees
    FROM
        class_attendance
    WHERE status != 'absent'
    GROUP BY
        year, season, attendance_day
),
seasonal_attendance AS (
    SELECT
        year,
        season,
        AVG(daily_attendees) AS avg_daily_attendance
    FROM
        daily_attendance
    GROUP BY
        year, season
),
lagged_attendance AS (
    SELECT
        season,
        year,
        avg_daily_attendance,
        LAG(avg_daily_attendance, 1, NULL) OVER (PARTITION BY season ORDER BY year) AS prev_year_avg_attendance
    FROM
        seasonal_attendance
)
SELECT
    season,
    year,
    TRUNCATE(avg_daily_attendance, 1) AS avg_attendance,
    CASE
        WHEN prev_year_avg_attendance IS NOT NULL AND prev_year_avg_attendance != 0
        THEN TRUNCATE((avg_daily_attendance - prev_year_avg_attendance) / prev_year_avg_attendance * 100, 1)
        ELSE NULL
    END AS yoy_change
FROM
    lagged_attendance
ORDER BY
    year, season;
```
