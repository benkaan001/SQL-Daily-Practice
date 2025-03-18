# SQL Practice Questions - Gym Management Database
// Note: Use the tables (members, trainers, classes, class_enrollments, trainer_ratings, class_attendance) created in the dataset.
// Each question includes an explanation of the computation required.

## Question 1: Member Attendance Analysis
Write a query to find the top 3 most engaged members based on their class attendance records from the class_attendance table. 
Calculate the attendance rate as (number of records with status 'present' or 'late') divided by (total attendance records for the member).
Output the member name, total class attendance count, and their computed attendance rate. In attendance_rate DESC, total_classes DESC  order.

Expected output:

| member_name   | total_classes | attendance_rate |
| ------------- | ------------- | --------------- |
| Alice Johnson | 31            | 1.00            |
| Charlie Davis | 5             | 1.00            |
| Bob Smith     | 4             | 1.00            |

```sql
-- Write your solution here
```

Using the trainer_ratings table and classes table, calculate each trainer's average rating and count the number of classes they teach.
Include only trainers with at least 2 ratings. Order the results by average rating in descending order.
Expected output:
| trainer_name  | avg_rating | total_classes | total_ratings |
| ------------- | ---------- | ------------- | ------------- |
| Alex Thompson | 5.00       | 3             | 6             |
| Quincy Adams  | 5.00       | 1             | 2             |
| Sarah White   | 5.00       | 2             | 4             |
| Linda Brown   | 4.80       | 5             | 25            |
| Kim Jong      | 4.50       | 3             | 6             |
| Michael Green | 4.40       | 5             | 25            |
| David Cohen   | 4.00       | 3             | 3             |
| Maria Garcia  | 4.00       | 2             | 2             |

```sql
-- Write your solution here
```

## Question 3: Class Capacity Utilization
Write a query to analyze the capacity utilization of each class from the classes table.
Join with enrollments if needed to count current enrollment. Show only classes where the ratio (enrolled / capacity) is over 80%.
Return the class name, trainer name, capacity, current enrollment count, and the utilization percentage.
Expected output:

| class_name          | trainer_name  | capacity | enrolled | utilization_pct |
| ------------------- | ------------- | -------- | -------- | --------------- |
| Boxing Advanced     | Alex Thompson | 10       | 10       | 100.00          |
| Functional Training | Sven Erikson  | 12       | 9        | 75.00           |

```sql
-- Write your solution here
```

## Question 4: Membership Type Analysis
Using the members table, show the distribution of different membership_types.
For each type, count the total members and count those that are active (membership_type not NULL).
Calculate the retention rate as (active_members / total_members) expressed as a percentage.
Expected output:
| membership_type | total_members | active_members | retention_rate |
| --------------- | ------------- | -------------- | -------------- |
| Gold            | 10            | 10             | 100.00%        |
| Platinum        | 6             | 6              | 100.00%        |
| Regular         | 2             | 2              | 100.00%        |
| Silver          | 7             | 7              | 100.00%        |
| VIP             | 4             | 4              | 100.00%        |

```sql
-- Write your solution here
```

## Question 5: Trainer Specialization Impact
Analyze how trainer specializations affect class attendance.
Join the trainers, classes, and class_attendance tables to compute for each specialty:
• The average attendance rate per class (consider attendance statuses).
• Total number of classes taught.
Order the results based on the toal_classes in descending order.
Expected output:
| specialty           | avg_attendance_rate | total_classes |
| ------------------- | ------------------- | ------------- |
| CrossFit            | 0.950000            | 5             |
| Yoga                | 0.900000            | 5             |
| Boxing              | 1.000000            | 3             |
| HIIT Training       | 1.000000            | 3             |
| Senior Fitness      | 1.000000            | 3             |
| Dance Fitness       | 1.000000            | 2             |
| Pilates             | 1.000000            | 2             |
| Zumba               | 1.000000            | 2             |
| Functional Training | 1.000000            | 1             |
| Nutrition           | 1.000000            | 1             |
| Strength Training   | 1.000000            | 1             |
| Cardio              |                     | 0             |

```sql
-- Write your solution here
```

