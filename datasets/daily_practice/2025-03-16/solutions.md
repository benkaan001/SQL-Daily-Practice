# SQL Practice Questions - Gym Management Database

## Question 1: Member Attendance Analysis
Write a query to find the top 3 most engaged members based on their class attendance records from the class_attendance table. 
Calculate the attendance rate as (number of records with status 'present' or 'late') divided by (total attendance records for the member).
Output the member name, total class attendance count, and their computed attendance rate.
Expected output:
| member_name | total_classes | attendance_rate |
|-------------|---------------|-----------------|
| Alice Johnson | 5 | 1.00 |
| Bob Smith | 4 | 0.75 |
| Charlie Davis | 3 | 0.67 |

```sql
-- Write your solution here
```

## Question 2: Trainer Performance Metrics
Using the trainer_ratings table and classes table, calculate each trainer's average rating and count the number of classes they teach.
Include only trainers with at least 2 ratings. Order the results by average rating in descending order.
Expected output:
| trainer_name | avg_rating | total_classes | total_ratings |
|--------------|------------|---------------|---------------|
| Linda Brown | 4.75 | 3 | 2 |
| Michael Green | 4.50 | 3 | 2 |

```sql
-- Write your solution here
```

## Question 3: Class Capacity Utilization
Write a query to analyze the capacity utilization of each class from the classes table.
Join with enrollments if needed to count current enrollment. Show only classes where the ratio (enrolled / capacity) is over 80%.
Return the class name, trainer name, capacity, current enrollment count, and the utilization percentage.
Expected output:
| class_name       | trainer_name   | capacity | enrolled | utilization_pct |
|------------------|----------------|----------|----------|-----------------|
| Boxing Advanced  | Alex Thompson  | 10       | 9        | 90.0%           |
| HIIT Challenge   | Kim Jong       | 18       | 16       | 88.9%           |

```sql
-- Write your solution here
```

## Question 4: Membership Type Analysis
Using the members table, show the distribution of different membership_types.
For each type, count the total members and count those that are active (membership_type not NULL).
Calculate the retention rate as (active_members / total_members) expressed as a percentage.
Expected output:
| membership_type | total_members | active_members | retention_rate |
|-----------------|---------------|----------------|----------------|
| Gold            | 7             | 6              | 85.7%          |
| Platinum        | 4             | 4              | 100.0%         |
| Silver          | 5             | 5              | 100.0%         |

```sql
-- Write your solution here
```

## Question 5: Trainer Specialization Impact
Analyze how trainer specializations affect class attendance.
Join the trainers, classes, and class_attendance tables to compute for each specialty:
• The average attendance rate per class (consider attendance statuses).
• Total number of classes taught.
Expected output:
| specialty     | avg_attendance_rate | total_classes |
|---------------|---------------------|---------------|
| Yoga          | 0.92                | 3             |
| CrossFit      | 0.88                | 3             |
| HIIT Training | 0.85                | 2             |

```sql
-- Write your solution here
```

## Question 6: Member Engagement Timeline
Create a query that breaks down each member’s class attendance by month.
Display for each member the monthly count of their attended classes (use class_attendance) and a running total (cumulative sum) of classes attended.
Expected output:
| member_name    | year_month | monthly_classes | cumulative_classes |
|----------------|------------|-----------------|--------------------|
| Alice Johnson  | 2022-03   | 2               | 2                  |
| Alice Johnson  | 2022-04   | 3               | 5                  |
| Bob Smith      | 2022-03   | 1               | 1                  |

```sql
-- Write your solution here
```

## Question 7: Class Popularity Trends
Calculate the average enrollment rate of each class type by quarter.
Group by quarter (e.g. 2023 Q4) and class name. Enrollment rate can be computed as (enrolled / capacity).
Expected output:
| quarter   | class_name       | avg_enrollment_pct |
|-----------|------------------|--------------------|
| 2023 Q4   | Boxing Advanced  | 90.0%              |
| 2023 Q4   | HIIT Challenge   | 88.9%              |
| 2023 Q3   | Zumba Dance      | 84.0%              |

```sql
-- Write your solution here
```

## Question 8: Member Cross-Training Analysis
Identify members who participate in classes of different types.
For each member, determine the number of distinct class types they attend and identify their most frequently attended class type.
Expected output:
| member_name   | class_types | favorite_class |
|---------------|-------------|----------------|
| Alice Johnson | 3           | Yoga           |
| Bob Smith     | 2           | CrossFit       |

```sql
-- Write your solution here
```

## Question 9: Trainer Schedule Optimization
Identify any potential scheduling conflicts in the classes table where a trainer is assigned multiple classes that start within 2 hours of each other on the same day.
Return the trainer name, the day of the conflict, the names of the two conflicting classes, and the hours between them.
Expected output:
| trainer_name  | class_date | class_1      | class_2      | hours_between |
|---------------|------------|--------------|--------------|---------------|
| Linda Brown   | 2023-11-29 | Morning Yoga | Power Yoga   | 1.5           |

```sql
-- Write your solution here
```

## Question 10: Peak Hour Analysis
Determine the busiest time slots for class attendance.
Group class sessions by predefined time slots (e.g., 08:00-10:00, 17:00-19:00) and compute:
• Total classes within the slot,
• Average attendance across classes,
• Utilization percentage (attendance relative to capacity).
Expected output:
| time_slot   | total_classes | avg_attendance | utilization_pct |
|-------------|---------------|----------------|-----------------|
| 08:00-10:00 | 25            | 18             | 90.0%           |
| 17:00-19:00 | 20            | 16             | 85.0%           |

```sql
-- Write your solution here
```
