## Puzzle: The "Resurrected User" Report

**The Scenario:** The marketing team ran a "We Miss You" email campaign yesterday. Today ('2023-12-14'), they want to measure its success by identifying "Resurrected Users."

**Your Task:** Identify users who logged in on **'2023-12-14'** but had been completely inactive (no logins) for at least the **60 days** prior to that date.

The report should show the `user_id`, the `current_login_date` ('2023-12-14'), and the `previous_login_date` (the last time they were seen before today).

| **user_id** | **current_login_date** | **previous_login_date** |
| ----------------- | ---------------------------- | ----------------------------- |
| 102               | 2023-12-14                   | 2023-09-15                    |

### Tips for Approaching the Problem

1. **Identify Current Logins:** Create a CTE or filter to find all distinct users who logged in on '2023-12-14'.
2. **Find Previous Login:** For these users, find the `MAX(login_timestamp)` from the table where the date is *strictly less than* '2023-12-14'.
3. **Calculate Gap:** Compare the `current_login_date` and `previous_login_date`. If the difference is `>= 60 days`, they are resurrected.

**Your Solution:**

```sql
-- Write your solution here
```
