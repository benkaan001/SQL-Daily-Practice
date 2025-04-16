## Question 1: Users Employed at Google on November 1st, 2021

Find IDs of LinkedIn users who were employed at Google on November 1st, 2021.  
Do **not** consider users who started or ended their employment at Google on that day, but **do** include users who changed their position within Google on that day.

**Expected Output:**

| user_id |
|---------|
| 4       |
| 6       |

**Your Solution:**
```sql
-- Write your solution here
```

---

## Question 2: Users with Multiple Google Positions

Find all user_ids who have held more than one distinct position at Google.  
Output user_id and the count of distinct Google positions.

**Expected Output:**

| user_id | google_position_count |
|---------|----------------------|
| 4       | 2                    |

**Your Solution:**
```sql
-- Write your solution here
```

---

## Question 3: Longest Continuous Employment at Any Company

For each user, find the employer where they had their longest continuous employment period.  
Output user_id, employer, and duration_days (number of days).

**Expected Output:**

| user_id | employer   | duration_days |
|---------|------------|--------------|
| 1       | Microsoft  | 567          |
| 2       | Microsoft  | (today - 2021-01-11) |
| 3       | Microsoft  | 497          |
| 4       | Google     | (today - 2021-11-01) |
| 5       | Microsoft  | (today - 2017-09-26) |
| 6       | Google     | (today - 2015-10-02) |

*For users with ongoing employment (end_date is NULL), use the current date for calculation.*

**Your Solution:**
```sql
-- Write your solution here
```
