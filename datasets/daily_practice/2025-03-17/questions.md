# SQL Practice Questions - Gym Management Database
// Note: Use the tables (members, trainers, classes, class_enrollments, trainer_ratings, class_attendance) created in the dataset.
// Each question includes an explanation of the computation required.


## Question 11: Member Upgrade Potential
Identify Silver members (from the members table) who attend more than 8 classes per month (using class_attendance).
These members may be candidates for a Gold membership upgrade.
Show their name, current membership type, monthly attended classes count, and an estimated potential savings value.
Expected output:
| member_name  | current_type | monthly_classes | potential_savings |
|--------------|--------------|-----------------|-------------------|
| Bob Smith    | Silver       | 12              | $25.00            |
| Julia Roberts| Silver       | 10              | $20.00            |

```sql
-- Write your solution here
```

## Question 12: Trainer Revenue Impact
Estimate the revenue impact contributed by each trainer.
Using class attendance and membership types (with assumed membership fee values), calculate:
• Total number of classes they taught,
• Total class attendees,
• A computed revenue impact.
Expected output:
| trainer_name  | total_classes | total_attendees | revenue_impact  |
|---------------|---------------|-----------------|-----------------|
| Linda Brown   | 45            | 360             | $18,000.00      |
| Michael Green | 38            | 304             | $15,200.00      |

```sql
-- Write your solution here
```

## Question 13: Member Churn Risk
Identify members who are at risk of churning. 
For each member, compute the average attendance from historical data versus recent attendance; flag if there’s a decrease of more than 50%.
Output the member name, their average attendance, recent attendance, the percentage decline, and a risk level (e.g., High).
Expected output:
| member_name   | avg_attendance | recent_attendance | decline_pct | risk_level |
|---------------|----------------|-------------------|-------------|------------|
| Charlie Davis | 8              | 3                 | 62.5%       | High       |
| Diana Lee     | 6              | 2                 | 66.7%       | High       |

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
Group the data by season and year (using schedule_date) and calculate the average attendance along with year-over-year percentage change.
Expected output:
| season | year | avg_attendance | yoy_change |
|--------|------|----------------|------------|
| Summer | 2023 | 85.5%         | +5.5%      |
| Summer | 2022 | 80.0%         | null       |

```sql
-- Write your solution here
```

## Question 16: Member Referral Analysis
Identify potential referrals by finding members who:
• Joined within 7 days of each other (using join_date from members),
• And have attended a similar set of classes.
Return pairs of member names, the day difference between their join dates, and the count of common classes attended.
Expected output:
| member_1    | member_2    | join_date_diff | common_classes |
|-------------|-------------|----------------|----------------|
| Priya Patel | Mohammed Ali| 5              | 3              |
| Aisha Khan  | Yuki Tanaka | 5              | 2              |

```sql
-- Write your solution here
```

## Question 17: Class Time Optimization
Analyze class attendance by day of week and by time slot.
Return for each combination the average attendance rate and suggest recommended classes that perform best in that time slot.
Expected output:
| day_of_week | time_slot | avg_attendance_rate | recommended_classes |
|-------------|-----------|---------------------|---------------------|
| Monday      | Morning   | 92.5%              | Yoga, HIIT          |
| Wednesday   | Evening   | 88.0%              | CrossFit, Boxing    |

```sql
-- Write your solution here
```

## Question 18: Trainer Effectiveness Score
Develop a composite effectiveness score for trainers using:
• Their average rating (from trainer_ratings),
• Average class attendance rate,
• Member retention in their classes.
Combine these into an overall score.
Expected output:
| trainer_name  | avg_rating | attendance_rate | member_retention | effectiveness_score |
|---------------|------------|-----------------|------------------|---------------------|
| Linda Brown   | 4.8        | 95%             | 88%              | 92.3                |
| Michael Green | 4.5        | 92%             | 85%              | 89.0                |

```sql
-- Write your solution here
```

## Question 19: Revenue Optimization Analysis
Assess how optimized scheduling can influence revenue.
Using historical attendance data and membership types, compute:
• The current revenue per class type,
• The estimated optimized revenue,
• The percentage increase potential,
and provide recommendations for scheduling adjustments.
Expected output:
| class_type | current_revenue | optimized_revenue | potential_increase | recommended_changes |
|------------|-----------------|-------------------|--------------------|---------------------|
| Yoga       | $12,000         | $15,000           | 25%                | Add evening slots   |
| CrossFit   | $10,000         | $13,000           | 30%                | Increase capacity   |

```sql
-- Write your solution here
```

## Question 20: Member Lifecycle Analysis
Examine the progression of members through various lifecycle stages.
For each stage (e.g., New Member, Regular, Premium), determine:
• The average duration (in months),
• The typical classes attended,
• Upgrade rate from one stage to the next,
• And associated churn risk.
Expected output:
| lifecycle_stage | avg_duration_months | typical_classes                   | upgrade_rate | churn_risk |
|-----------------|---------------------|-----------------------------------|--------------|------------|
| New Member      | 3                   | Beginner Yoga, Intro CrossFit     | 35%          | Low        |
| Regular         | 8                   | Mixed Classes                     | 25%          | Medium     |
| Premium         | 15                  | Advanced Classes                  | N/A          | Low        |

```sql
-- Write your solution here
```
