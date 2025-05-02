## Question 1: Users with the Most Friends

Find the user(s) who have the highest number of friends.
Output user_id, user_name, and friend_count.

**Expected Output:**

| user_id | user_name | friend_count |
| ------- | --------- | ------------ |
| 3       | Emma      | 3            |
| 10      | John      | 2            |

**Your Solution:**
```sql
-- Write your solution here
```
---

## Question 2: Users Who Are Not Anyone's Friend

Find users who do **not** appear as a friend_id in the friendships table (i.e., no one has added them as a friend).
Output user_id and user_name.

**Expected Output:**

| user_id | user_name |
| ------- | --------- |
| 1       | Karl      |
| 2       | Hans      |

**Your Solution:**
```sql
-- Write your solution here
```
---

## Question 3: Users with Mutual Friendships

Find all pairs of users who are friends with each other (i.e., both (A,B) and (B,A) exist in the friendships table, and A < B to avoid duplicates).
Output user_id_1, user_name_1, user_id_2, user_name_2.

**Expected Output:**

| user_id_1 | user_name_1 | user_id_2 | user_name_2 |
| --------- | ----------- | --------- | ----------- |
| 1         | Karl        | 3         | Emma        |
| 2         | Hans        | 3         | Emma        |
| 7         | Sarah       | 10        | John        |
| 9         | Anna        | 10        | John        |

**Your Solution:**
```sql
-- Write your solution here
```
---
