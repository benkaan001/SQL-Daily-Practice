## Question 1: Users with the Most Friends

Find the user(s) who have 2 or more friends.
Output user_id, user_name, and friend_count.

**Expected Output:**

| user_id | user_name | friend_count |
| ------- | --------- | ------------ |
| 3       | Emma      | 3            |
| 1       | Karl      | 2            |
| 2       | Hans      | 2            |
| 10      | John      | 2            |

**Your Solution:**
```sql
SELECT
	u.user_id,
    u.user_name,
    COUNT(DISTINCT f.friend_id) AS friend_count
FROM
	users u
JOIN
	friendships f ON u.user_id = f.user_id
GROUP BY
	u.user_id,
    u.user_name
HAVING
	friend_count >= 2
ORDER BY
	friend_count DESC;
```
---

## Question 2: Users Who Are Not Anyone's Friend

Find users who do **not** appear as a friend_id in the friendships table (i.e., no one has added them as a friend).
Output user_id and user_name.

**Expected Output:**

| user_id | user_name |
| ------- | --------- |
|         |           |


**Your Solution:**
```sql
SELECT
	u.user_id,
    u.user_name
FROM
	users u
WHERE NOT EXISTS (
  SELECT
  	1
  FROM
  	friendships
  WHERE
  	u.user_id = friend_id
  );
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
SELECT
    f1.user_id AS user_id_1,
    u1.user_name AS user_name_1,
    f1.friend_id AS user_id_2,
    u2.user_name AS user_name_2
FROM
    friendships f1
JOIN
    friendships f2
    ON f1.user_id = f2.friend_id
    AND f1.friend_id = f2.user_id
JOIN
    users u1 ON f1.user_id = u1.user_id
JOIN
    users u2 ON f1.friend_id = u2.user_id
WHERE
    f1.user_id < f1.friend_id
ORDER BY
    user_id_1, user_id_2;
```
---
