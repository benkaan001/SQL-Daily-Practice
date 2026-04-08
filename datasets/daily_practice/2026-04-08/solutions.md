## Puzzle: The Prorated Upgrade Bill

**The Scenario:** A SaaS company bills its users on the 1st of every month for the entire month upfront. If a user decides to upgrade their plan mid-month, they immediately get access to the new tier, but they must be billed a prorated charge to cover the price difference for the remainder of that specific month.

**Your Task:** Write a query to calculate the exact `prorated_charge` for every upgrade event in the database.

**The Billing Rules:**

1. The upgrade takes effect immediately on the `upgrade_date`. The user must pay the difference in price for all days from the `upgrade_date` to the last day of the month,  **inclusive** .
   *(e.g., An upgrade on April 16th means there are 15 billable days remaining in the 30-day month).*
2. The daily rate should be calculated dynamically based on the exact number of days in the specific month the upgrade occurred. (Do not hardcode 30 days, as some months have 28 or 31 days).
3. The final `prorated_charge` should be rounded to 2 decimal places.

The report should show the `user_id`, `upgrade_date`, the `old_plan` name, the `new_plan` name, and the calculated `prorated_charge`.

**Expected Output:**

| **user_id** | **upgrade_date** | **old_plan** | **new_plan** | **prorated_charge** |
| ----------------- | ---------------------- | ------------------ | ------------------ | ------------------------- |
| 101               | 2026-04-16             | Basic              | Pro                | 15.00                     |
| 102               | 2026-04-21             | Pro                | Max                | 20.00                     |
| 103               | 2026-03-02             | Basic              | Max                | 87.10                     |
| 104               | 2026-02-28             | Pro                | Max                | 2.14                      |

### Tips for Approaching the Problem

1. **Join the Pricing Tiers:** Your `plan_upgrades` table only contains IDs. You'll need to join the `subscription_plans` table **twice** (using two different aliases) to fetch both the old plan's price/name and the new plan's price/name in the same row.
2. **Find Total Days in Month:** To figure out how many days are in a specific month, you can use the `LAST_DAY(date)` function, which returns the final date of the month (e.g., '2026-04-30'). From there, you can extract just the day number using `DAY(LAST_DAY(date))`.
3. **Calculate Days Remaining:** The number of days the new plan is active is the total days in the month minus the upgrade day, **plus one** (since the upgrade day itself is inclusive).
   *Formula: `Total_Days_In_Month - DAY(upgrade_date) + 1`*
4. **The Proration Formula:** Calculate the total price difference (`new_price - old_price`), multiply it by the active days, and divide it by the total days in the month. Don't forget to wrap the whole calculation in `ROUND(..., 2)`.

**Your Solution:**

```sql
-- Write your solution here
```

