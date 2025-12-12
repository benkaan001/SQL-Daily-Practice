## Puzzle: The Zombie Revenue

**The Scenario:** A "Zombie Subscriber" is a user who is paying for a subscription (`status = 'ACTIVE'`) but has not logged into the platform for over 90 days (relative to '2023-12-06'). These users are high churn risks or might issue chargebacks.

**Your Task:** Find all zombie subscribers and calculate the total monthly revenue they represent.

The report should list the `user_id`, `last_login_date`, `days_since_login`, and `monthly_fee`.

| **user_id** | **last_login_date** | **days_since_login** | **monthly_fee** |
| ----------------- | ------------------------- | -------------------------- | --------------------- |
| 102               | 2023-09-01                | 96                         | 20.00                 |

### Tips

1. **Find Last Login:** Group `user_logins` to find the `MAX(login_time)` for each user.
2. **Join and Filter:** Join with `subscriptions` and filter for `ACTIVE` users where `DATEDIFF` > 90.

**Your Solution:**

```sql
-- Write your solution here
```
