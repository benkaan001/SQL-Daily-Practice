# SQL Practice Questions - Gym Management Database
// Note: Use the tables (members, trainers, classes, class_enrollments, trainer_ratings, class_attendance) created in the dataset.
// Each question includes an explanation of the computation required.


## Question 11: Member Upgrade Potential
Identify Gold members (from the members table) who attend more than 8 classes per month (using class_attendance).
These members may be candidates for a Platinum membership upgrade.
Show their name, current membership type, monthly attended classes count. 

Expected output:
 member_name   | membership_type | monthly_classes |
| ------------- | --------------- | --------------- |
| Alice Johnson | Gold            | 11              |

```sql
-- Write your solution here
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
-- Write your solution here
```



## Question 14: Class Series Completion
Track a class series (for example, a sequence like 'Beginner to Advanced Yoga') to measure completion rates.
For a given series, count how many members enrolled, how many completed the full series, and calculate the completion rate.
Expected output:
| series_name  | total_enrolled | completed | completion_rate |
|--------------|----------------|-----------|-----------------|
| Yoga Series  | 15             | 12        | 80.0%           |
| CrossFit Series | 10         | 7         | 70.0%           |

```sql
-- Write your solution here
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
-- Write your solution here
```
