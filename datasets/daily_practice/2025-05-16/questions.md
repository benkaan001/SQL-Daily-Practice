**[Question 1]**
Find the total number of distinct recipients (`to_user`) for each sender (`from_user`) and rank the senders based on this count. The sender who has the highest number of distinct recipients should have a rank of 1.
Output the sender, their distinct recipients count, and their rank.

- Order by the distinct recipient count in descending order.
- If multiple senders have the same count, sort them alphabetically by `from_user`.
- Assign a unique rank to each sender (e.g., if three senders tie for first place based on count and are then sorted alphabetically, they get ranks 1, 2, and 3).

**Expected Results**

```
from_user | distinct_recipients | rank
userB     | 3                   | 1
userA     | 2                   | 2
userD     | 2                   | 3
userE     | 2                   | 4
userC     | 1                   | 5
```

**Your Solution:**

```sql
-- Write your solution here

```

---

**[Question 2]**
Find the total number of emails each user has *received* (i.e., appears in the `to_user` column) and rank them based on this total. The user who has received the most emails is ranked 1.
Output the user, the total emails received, and their rank.

- Order by total emails received in descending order.
- If multiple users have the same total, sort them alphabetically by `to_user`.
- Assign a unique rank to each user.


**Expected Results**

```
to_user | total_emails_received | rank
userC   | 4                     | 1
userA   | 2                     | 2
userB   | 2                     | 3
userD   | 1                     | 4
userE   | 1                     | 5
```

**Your Solution:**

```sql
-- Write your solution here

```

---

**[Question 3]**
Compute the average `day` for each sender (`from_user`) and rank them by their average day in descending order. The sender with the highest average day should have rank 1.
Output the sender, their average day (formatted to two decimal places), and their rank.

- Order by the average of `day` descending.
- If multiple senders share the same average, sort them alphabetically by `from_user`.
- Assign a unique rank to each sender.


**Expected Results**

```
from_user | average_day | rank
userD     | 9.00        | 1
userB     | 5.67        | 2
userA     | 3.50        | 3
userC     | 3.00        | 4
userE     | 3.00        | 5
```
**Your Solution:**

```sql
-- Write your solution here

```
