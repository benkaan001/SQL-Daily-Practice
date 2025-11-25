## Puzzle: The Long-Term Value Multiplier

**The Scenario:** As a customer retention analyst, you need to understand which acquisition channels bring in the most valuable users over the long term. Value is measured by the ratio of long-term spending to short-term spending.

**Your Task:** Write a query that groups users by their `acquisition_channel` and calculates the following aggregated metrics:

1. **`total_users`** : The count of unique users acquired through this channel.
2. **`avg_short_term_spend`** : The average total spending per user during the **first 30 days** following their `registration_date`.
3. **`avg_long_term_spend`** : The average total spending per user between **Day 91 and Day 180** following their `registration_date`.
4. **`value_multiplier`** : The ratio of `avg_long_term_spend` / `avg_short_term_spend`, rounded to two decimal places.

The report should only include channels where `avg_short_term_spend` is greater than zero and be ordered by the `value_multiplier` in descending order.

| acquisition_channel | total_users | avg_short_term_spend | avg_long_term_spend | value_multiplier |
| ------------------- | ----------- | -------------------- | ------------------- | ---------------- |
| Organic             | 2           | 55.00                | 60.00               | 1.09             |
| Paid Ad             | 1           | 85.00                | 0.00                | 0.00             |
| Referral            | 1           | 5.00                 | 0.00                | 0.00             |

### Tips for Approaching the Problem

1. **Define Time Windows per User:** This is the core challenge. You must calculate the exact date for Day 30, Day 91, and Day 180 *for each user* based on their unique `registration_date`.
   * Use `DATE_ADD(registration_date, INTERVAL 30 DAY)` for the Day 30 cutoff.
   * Use `DATE_ADD(registration_date, INTERVAL 91 DAY)` for the Day 91 start.
   * Use `DATE_ADD(registration_date, INTERVAL 180 DAY)` for the Day 180 end.
2. **Attribute Transactions to Windows:** Create a CTE that joins `user_registration` with `user_transactions`. Use a series of `CASE` statements to categorize each transaction amount based on when it occurred relative to the user's registration date (Day 1-30 vs. Day 91-180).
3. **Aggregate Spending per User:** In a second CTE, group the results by `user_id` and `acquisition_channel`. Calculate the `SUM(short_term_spend)` and `SUM(long_term_spend)` for each user.
4. **Final Channel Aggregation:** In your final `SELECT` statement, group by `acquisition_channel`. Calculate the total users (`COUNT(*)`) and the *average* of the individual user spend sums to get the final `avg_short_term_spend` and `avg_long_term_spend` per channel.

**Your Solution:**

```sql
-- Write your solution here
```
