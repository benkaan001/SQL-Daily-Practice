# SQL Practice Questions - Gym Management Database


## Question 16: Member Referral Analysis
Identify potential referrals by finding members who:
• Joined within 7 days of each other (using join_date from members),
• And have attended a similar set of classes.
Return pairs of member names, the day difference between their join dates,
 and the count of common classes attended.
Expected output:

| member_1      | member_2        | join_date_diff | common_classes |
| ------------- | --------------- | -------------- | -------------- |
| Charlie Davis | Edward Kim      | 1              | 3              |
| Kevin Durant  | Laura Palmer    | 1              | 1              |
| Chen Wei      | Aisha Khan      | 5              | 1              |
| Aisha Khan    | Yuki Tanaka     | 5              | 1              |
| Yuki Tanaka   | Lars Anderson   | 5              | 1              |
| Mohammed Ali  | Sofia Rodriguez | 6              | 1              |


```sql
SELECT DISTINCT
    m1.member_name AS member_1,
    m2.member_name AS member_2,
    ABS(DATEDIFF(m1.join_date, m2.join_date)) AS join_date_diff,
    (SELECT 
        COUNT(DISTINCT ce2.class_id)
     FROM 
        class_enrollments ce2
     WHERE 
        ce2.member_id = m2.member_id
       AND ce2.class_id IN (SELECT 
                                ce1.class_id
                            FROM 
                                class_enrollments ce1
                            WHERE 
                                ce1.member_id = m1.member_id)
    ) AS common_classes
FROM
    members m1
JOIN
    members m2 ON m1.member_id != m2.member_id AND m1.member_id < m2.member_id
WHERE
    ABS(DATEDIFF(m1.join_date, m2.join_date)) <= 7
HAVING
    common_classes > 0
ORDER BY
    join_date_diff, common_classes DESC;
```