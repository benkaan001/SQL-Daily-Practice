## Puzzle: The "Surging Budget" Trend

**The Scenario:** As a marketing strategist, you want to identify campaigns that are receiving significant, sustained budget increases. A campaign is deemed to be "surging" if its budget allocation is increased for 3 or more consecutive days on the  *same marketing channel* .

**Your Task:** Write a query to find all campaigns that have experienced a "surging budget" streak of 3 or more days. A streak requires:

1. A `budget_change` event where `budget_change > 0` (an increase).
2. The `budget_change` event must occur on the *same* `channel` as the previous day's increase.
3. The streak must be continuous for 3 or more calendar days.

The final report should show the `campaign_id`, the `channel` that experienced the surge, the `streak_start_date`, and the `streak_end_date` for the longest such streak.

| **campaign_id** | **channel** | **streak_start_date** | **streak_end_date** |
| --------------------- | ----------------- | --------------------------- | ------------------------- |
| Q4_Holiday            | Social            | 2023-11-02                  | 2023-11-05                |

### Tips for Approaching the Problem

1. **Isolate Positive Daily Change (Workout Days):** The first step is to focus only on days where the budget increased. Create a CTE that selects distinct combinations of `DATE(change_timestamp)` (the "day"), `campaign_id`, and `channel` where `budget_change > 0`.
2. **Identify Consecutive Days (Gaps and Islands):** This is a critical "gaps and islands" problem based on two criteria (`campaign_id` and `channel`).
   * Use the "difference trick" to create a grouping ID for consecutive dates: `DATE(change_timestamp) - ROW_NUMBER() OVER (PARTITION BY campaign_id, channel ORDER BY DATE(change_timestamp))`. This constant difference identifies a continuous streak of days.
3. **Aggregate and Filter:** Group the results by `campaign_id`, `channel`, and the `streak_group_id` calculated in the previous step.
4. **Final Selection:** In your final `SELECT` statement:
   * Use `COUNT(*)` to find the `streak_length_days`.
   * Use `MIN(date)` and `MAX(date)` for the start and end of the streak.
   * Use a `HAVING` clause to filter only for streaks where `COUNT(*) >= 3`.

**Your Solution:**

```sql
-- Write your solution here
```