## Puzzle: Monthly Growth Accounting

**The Scenario:** The Growth team uses a "Growth Accounting" framework to understand the health of the active user base. Instead of just looking at total active users, they categorize users into four specific buckets every month to see where growth or decay is coming from.

**Your Task:** Write a query to categorize users and count the number of users in each status bucket for the target month of  **March 2026 ('2026-03')** .

**The Four Categories for March 2026:**

1. **`NEW`** : The user's *first-ever* login occurred in March 2026.
2. **`RETAINED`** : The user logged in during March 2026 AND also logged in during February 2026.
3. **`RESURRECTED`** : The user logged in during March 2026, did *not* log in during February 2026, but had logged in during some previous month (e.g., January).
4. **`CHURNED`** : The user logged in during February 2026, but did *not* log in during March 2026.

*(Note: If a user was inactive in both February and March, they are already churned and should not be counted in this specific report).*

The final report should show the `user_status` and the `user_count`. Order the results alphabetically by `user_status`.

**Expected Output:**

| **user_status** | **user_count** |
| --------------------- | -------------------- |
| CHURNED               | 1                    |
| NEW                   | 1                    |
| RETAINED              | 2                    |
| RESURRECTED           | 1                    |

**Your Solution:**

```sql
-- Write your solution here
```
