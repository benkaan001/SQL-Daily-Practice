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

| CHURNED | 1 |

| NEW | 1 |

| RETAINED | 2 |

| RESURRECTED | 1 |

### Tips for Approaching the Problem

This can be a famously messy query if you try to `LEFT JOIN` and `RIGHT JOIN` different months together (especially since MySQL lacks a `FULL OUTER JOIN`).

There is a much more elegant "Pivot" approach using Conditional Aggregation!

1. **Calculate User Metrics:** Create a Common Table Expression (CTE) and `GROUP BY user_id`. For every user in the entire database, you want to calculate three things on a single row:
   * `active_mar`: Use `MAX(CASE WHEN ... THEN 1 ELSE 0 END)` to flag if they had any logins in '2026-03'.
   * `active_feb`: Use the same logic to flag if they had any logins in '2026-02'.
   * `first_active_month`: Use `MIN(DATE_FORMAT(login_date, '%Y-%m'))` to find their absolute first month on the platform.
2. **Categorize the Users:** In your final `SELECT` statement (querying from the CTE), use a standard `CASE` statement. Because you have `active_mar`, `active_feb`, and `first_active_month` right next to each other, the logic perfectly matches the definitions in the prompt!
   * *Example for NEW:* `WHEN active_mar = 1 AND first_active_month = '2026-03' THEN 'NEW'`
3. **Filter Out Irrelevant Users:** In your main query, add a `WHERE` clause to filter out users who weren't active in either of the months being analyzed: `WHERE active_mar = 1 OR active_feb = 1`.
4. **Aggregate:** Wrap your `CASE` statement in the `GROUP BY` clause and `COUNT(*)` the results.

**Your Solution:**

```sql
-- Write your solution here
```
