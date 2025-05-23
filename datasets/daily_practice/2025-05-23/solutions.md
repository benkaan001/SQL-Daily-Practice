## Question 1: Daily Usage Summary

For each user:
1. Count the total number of events recorded.
2. Count the number of distinct days on which they performed any actions.
3. Order the result by the total number of events, descending.

**Expected Output:**

| user_id | total_events | distinct_days |
|---------|-------------|---------------|
| 1       | 12          | 2             |
| 0       | 11          | 2             |
| 2       | 4           | 1             |

**Your Solution:**
````sql
-- Write your solution here
````

---

## Question 2: Scroll Frequency Analysis

For each user:
1. Calculate the total number of scroll actions (`scroll_up` or `scroll_down`).
2. Compute the ratio of scroll actions to overall events (scroll_ratio).
3. Sort by scroll_ratio descending, then by user_id ascending.

**Expected Output:**

| user_id | total_scroll_events | scroll_ratio |
|---------|---------------------|--------------|
| 2       | 3                   | 0.75         |
| 1       | 8                   | 0.67         |
| 0       | 5                   | 0.45         |

**Your Solution:**
````sql
-- Write your solution here
````

---

## Question 3: Average Session Time

A session is defined as the time from the latest `page_load` to the earliest valid `page_exit` on each day (only if `page_load` is before `page_exit`). For each user:
1. Calculate the session time per day (in minutes).
2. Return each user’s average session time across all their valid sessions.
3. Include users who have no valid session with a NULL average time.

**Expected Output:**

| user_id | average_session_time |
|---------|----------------------|
| 0       | 31.39               |
| 1       | 0.58                |
| 2       | NULL                |

**Your Solution:**
````sql
-- Write your solution here
