# SQL Practice Questions - Gym Management Database
// Note: Use the tables (members, trainers, classes, class_enrollments, trainer_ratings, class_attendance) created in the dataset.
// Each question includes an explanation of the computation required.

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


