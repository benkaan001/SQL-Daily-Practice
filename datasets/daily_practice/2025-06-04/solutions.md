# Advanced SQL Practice Questions - Gym Management Database

## Question 1: High-Engagement Member Upgrade Candidates
*Task:* Identify Gold or Silver members who have attended more than 10 classes in the last 3 months. Show their name, membership type, total attended classes, and the percentage of classes attended out of all available classes in that period. Order by total attended descending.

*Expected Output:*
| member_name     | membership_type | total_attended | percent_of_classes |
|-----------------|-----------------|----------------|-------------------|
| Alice Johnson   | Gold            | 12             | 80.00             |
| Bob Smith       | Silver          | 11             | 73.33             |

```sql
-- Write your SQL query here
```

## Question 2: Trainer Attendance Efficiency
*Task:* For each trainer, calculate the average attendance per class they taught, and the ratio of classes with full attendance (capacity reached). Show trainer name, specialty, avg_attendance, and full_class_ratio (rounded to 2 decimals). Only include trainers with at least 2 classes.

*Expected Output:*
| trainer_name   | specialty         | avg_attendance | full_class_ratio |
|---------------|-------------------|----------------|-----------------|
| Linda Brown   | Yoga              | 8.50           | 0.40            |
| Michael Green | CrossFit          | 7.25           | 0.25            |
| Alex Thompson | Boxing            | 9.00           | 0.67            |

```sql
-- Write your SQL query here
```

## Question 3: Class Series Completion Analysis
*Task:* For each class series (e.g., all Yoga or all CrossFit classes), count the number of unique members who enrolled in at least one class, the number who completed all classes in the series, and the completion rate (completed/all, as a percent rounded to 2 decimals). Show only series with at least 2 classes.

*Expected Output:*
| series_name    | total_enrolled | completed_all | completion_rate |
|---------------|----------------|---------------|----------------|
| Yoga Series   | 15             | 10            | 66.67          |
| CrossFit Series| 12            | 8             | 66.67          |

```sql
-- Write your SQL query here
```

## Question 4: Seasonal Attendance Trends
*Task:* For each season and year, calculate the total number of classes held, the average attendance per class, and the change in average attendance compared to the previous year (as a percent, null for first year). Show season, year, total_classes, avg_attendance, and yoy_change.

*Expected Output:*
| season | year | total_classes | avg_attendance | yoy_change |
|--------|------|--------------|---------------|------------|
| Spring | 2022 | 5            | 4.00          | null       |
| Summer | 2022 | 4            | 3.00          | null       |
| Winter | 2022 | 6            | 7.00          | null       |
| Fall   | 2023 | 5            | 3.20          | null       |
| Spring | 2023 | 4            | 3.00          | -25.00     |
| Summer | 2023 | 4            | 3.00          | 0.00       |
| Winter | 2023 | 4            | 3.00          | -57.14     |

```sql
-- Write your SQL query here
```

## Question 5: Trainer Specialization Loyalty
*Task:* For each trainer specialty, calculate the number of members who attended more than one class with trainers of that specialty, and the average number of repeat attendances per member. Show specialty, repeat_members, and avg_repeat_attendance. Order by avg_repeat_attendance descending.

*Expected Output:*
| specialty         | repeat_members | avg_repeat_attendance |
|------------------|---------------|----------------------|
| Yoga             | 5             | 2.40                 |
| CrossFit         | 4             | 2.25                 |
| Boxing           | 3             | 2.00                 |

```sql
-- Write your SQL query here
```
