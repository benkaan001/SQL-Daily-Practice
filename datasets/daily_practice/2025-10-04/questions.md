## Puzzle: The "Win-Back" Campaign Analysis

**The Scenario:** The marketing team wants to measure the effectiveness of their "win-back" campaigns, which target users who have recently downgraded their subscriptions. A successful win-back is when a user who downgraded is convinced to upgrade again.

**Your Task:** Write a query to identify every instance of a successful "win-back." A win-back is defined as a `DOWNGRADED` event that is followed by an `UPGRADED` event for the same `subscription_id` at some later point.

The report should show the `user_id`, `subscription_id`, the `downgrade_timestamp`, and the `subsequent_upgrade_timestamp`. It should also calculate the `time_to_winback_days` (the number of days between the downgrade and the upgrade). The report should only include the *first* win-back event for any given downgrade.

| **user_id** | **subscription_id** | **downgrade_timestamp** | **subsequent_upgrade_timestamp** | **time_to_winback_days** |
| ----------------- | ------------------------- | ----------------------------- | -------------------------------------- | ------------------------------ |
| 101               | sub_A                     | 2023-06-20 14:00:00.000       | 2023-08-25 11:30:00.000                | 65.88                          |
| 104               | sub_D                     | 2023-08-01 10:00:00.000       | 2023-09-01 10:00:00.000                | 31.00                          |
| 106               | sub_F                     | 2023-04-20 11:00:00.000       | 2023-04-28 15:00:00.000                | 8.17                           |

### Tips for Approaching the Problem

1. **Isolate Downgrades and Upgrades:** The problem revolves around connecting `DOWNGRADED` events to later `UPGRADED` events. A good first step is to create two separate Common Table Expressions (CTEs): one for all downgrade events and one for all upgrade events.
2. **Connect the Events:** You can then `JOIN` your `downgrades` CTE to your `upgrades` CTE. The join conditions should be on the same `subscription_id` and, crucially, the `upgrade_timestamp` must be greater than the `downgrade_timestamp`.
3. **Find the *****First***** Upgrade:** The join in the previous step will match a downgrade with *every* subsequent upgrade. The puzzle requires only the *first* one. To solve this, you can use the `ROW_NUMBER()` window function.
4. **Rank the Upgrades:** In a CTE after the join, create a `ROW_NUMBER()` partitioned by the `downgrade` event's details (e.g., its `event_id` or `timestamp`) and ordered by the `upgrade_timestamp` ascending. This will assign a `1` to the very first upgrade that occurred after each downgrade.
5. **Final Filtering:** In your final `SELECT` statement, filter for rows where the row number is `1`. Then you can calculate the `time_to_winback_days` using a function like `TIMESTAMPDIFF`.

**Your Solution:**

```sql
-- Write your solution here
```
