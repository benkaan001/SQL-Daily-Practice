## Puzzle: The Viral Coefficient (2-Level Referrals)

**The Scenario:** The Growth team is building a "viral loop" dashboard to reward users who act as super-connectors. A super-connector doesn't just invite friends; they invite friends who are active enough to invite *other* friends.

**Your Task:** Write a query to calculate the Level 1 (direct) and Level 2 (indirect) referral counts for any user who has successfully referred at least one person.

* `direct_referrals`: The number of users directly invited by this user.
* `indirect_referrals`: The number of users invited by this user's direct referrals.

The final report should show the `user_id`, their `direct_referrals`, and `indirect_referrals`. Order the results by `user_id`.

**Expected Output:**

| **user_id** | **direct_referrals** | **indirect_referrals** |
| ----------------- | -------------------------- | ---------------------------- |
| 101               | 3                          | 3                            |
| 102               | 2                          | 1                            |
| 103               | 1                          | 0                            |
| 105               | 1                          | 0                            |
| 109               | 1                          | 0                            |

*(Note: User 101 directly referred 102, 103, and 104. Those three users went on to refer 105, 106, and 107, resulting in 3 indirect referrals for 101).*

### Tips for Approaching the Problem

This problem requires joining the table to itself multiple times to walk down the referral chain.

1. **The Base Table (Referrers):** Start by querying the `user_referrals` table and `JOIN`ing it to itself. Let's alias the first instance as `u1` (the referrer) and the second instance as `u2` (the direct referral).
2. **Join Condition 1:** Link them using `ON u1.user_id = u2.referred_by_id`. Because you are using an `INNER JOIN`, this will automatically filter out any users in `u1` who never referred anyone.
3. **The Indirect Referrals:** To find the Level 2 referrals, `LEFT JOIN` the table to itself a third time (alias `u3`). The condition here is linking the direct referrals to *their* subsequent referrals: `ON u2.user_id = u3.referred_by_id`. We use a `LEFT JOIN` here because a direct referral might not have invited anyone, and we still want to count them!
4. **The Cartesian Trap:** Because this is a 1-to-Many-to-Many relationship, your rows will multiply. If `u2` invited two people, the `u1` + `u2` combination will appear twice in your joined data. If you just use standard `COUNT()`, it will severely overcount the direct referrals!
5. **Count Distinct:** To solve the trap, group by `u1.user_id`. Then, use `COUNT(DISTINCT u2.user_id)` to get the accurate number of direct referrals, and `COUNT(DISTINCT u3.user_id)` to get the accurate number of indirect referrals.

**Your Solution:**

```sql
SELECT 
	first.user_id AS first_referer_user_id,
	COUNT(DISTINCT second.user_id) AS direct_referals,
	COUNT(third.user_id) AS indirect_referrals
FROM
	user_referrals first
JOIN 
	user_referrals second ON first.user_id = second.referred_by_id 
LEFT JOIN 
	user_referrals third ON second.user_id = third.referred_by_id  
GROUP BY
	first.user_id;
```

