## Question 1: Friend Acceptance Rate by Sent Date

Calculate the friend acceptance rate for each date when friend requests were sent.
A request is sent if action = 'sent' and accepted if action = 'accepted'.
If a request is not accepted, there is no record of it being accepted in the table.
The output will only include dates where requests were sent and at least one of them was accepted.
Show the results ordered from the earliest to the latest date.

**Expected Output:**

| date       | acceptance_rate |
| ---------- | --------------- |
| 2020-01-04 | 0.75            |
| 2020-01-06 | 0.5             |

**Your Solution:**
```sql
-- Write your solution here
```
---

## Question 2: Users with Most Sent Requests

Find the user(s) who sent the most friend requests (action = 'sent').
Output user_id_sender and sent_count.

**Expected Output:**

| user_id_sender | sent_count |
| -------------- | ---------- |
| fffkfld9499    | 1          |
| ad4943sdz      | 1          |
| dfdfxf9483     | 1          |
| ffdfff4234234  | 1          |
| fg503kdsdd     | 1          |
| hh643dfert     | 1          |
| r4gfgf2344     | 1          |

*(All users sent 1 request; all are included.)*

**Your Solution:**
```sql
-- Write your solution here
```
---

## Question 3: Requests Accepted After More Than 5 Days

Find all friend requests that were accepted more than 5 days after they were sent.
Output user_id_sender, user_id_receiver, sent_date, accepted_date, days_to_accept.

**Expected Output:**

| user_id_sender | user_id_receiver | sent_date  | accepted_date | days_to_accept |
| -------------- | ---------------- | ---------- | ------------- | -------------- |
| dfdfxf9483     | 9djjjd9283       | 2020-01-04 | 2020-01-15    | 11             |
| fg503kdsdd     | ofp049dkd        | 2020-01-04 | 2020-01-10    | 6              |
| fffkfld9499    | 993lsldidif      | 2020-01-06 | 2020-01-10    | 4              |

*(Note: Only include if days_to_accept > 5; so only the first two rows are included in the final output.)*

**Your Solution:**
```sql
-- Write your solution here
```
---

