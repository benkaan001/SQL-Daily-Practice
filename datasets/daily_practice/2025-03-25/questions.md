## Question 1: Top 3 Videos as First Watch
After a new user creates an account and starts watching videos, the watch history captures the user_id, video_id, and watch_date.  
Write a SQL query to find the top 3 videos that appear most frequently as part of users' first three watched videos (based on the earliest watch_date per user).  
Output the video_id and the count of how many times it has been watched among the first 3 records per user.

**Expected Output Format:**

| video_id | first_watch_count |
| -------- | ----------------- |
| 101      | 7                 |
| 103      | 5                 |
| 102      | 4                 |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 2: First Video Watched Per User
For each user, return the video they watched first along with the watch date.  
Output user_id, video_id, and watch_date of the very first video watched by each user.

**Expected Output Format:**

| user_id | video_id | watch_date |
| ------- | -------- | ---------- |
| 1       | 101      | 2025-03-11 |
| 2       | 101      | 2025-03-11 |
| 3       | 105      | 2025-03-10 |
| 4       | 104      | 2025-03-11 |
| 5       | 101      | 2025-03-12 |
| 6       | 102      | 2025-03-10 |
| 7       | 103      | 2025-03-10 |
| 8       | 105      | 2025-03-11 |
| 9       | 101      | 2025-03-10 |
| 10      | 105      | 2025-03-10 |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 3: Most Active Users
Find the top 3 users who have watched the most videos overall.  
Output the user_id and the total number of videos they have watched.

**Expected Output Format:**

| user_id | total_watches |
| ------- | ------------- |
| 9       | 4             |
| 3       | 4             |
| 1       | 3             |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 4: Video Popularity by Unique Viewers
For each video, list the number of distinct users who have watched the video and the total watch count.  
Order the results by the distinct user count in descending order.

**Expected Output Format:**

| video_id | unique_viewers | total_watches |
| -------- | -------------- | ------------- |
| 101      | 7              | 8             |
| 104      | 6              | 6             |
| 105      | 5              | 5             |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 5: Average Videos Watched Per User
Calculate the average number of videos watched per user and list the total number of users who have watched at least one video.

**Expected Output Format:**

| average_watches_per_user | total_users |
| ------------------------ | ----------- |
| 2.60                      | 10          |

**Your Solution:**
```sql
-- Write your solution here
```