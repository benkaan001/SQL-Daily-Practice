## Puzzle: A/B Test Significance Analysis

**The Scenario:** You are a data scientist analyzing the results of the `'button_color_exp'` A/B test. To determine if the "treatment" (new button color) had a meaningful impact, you need to calculate key performance indicators for both the 'control' and 'treatment' groups.

**Your Task:** Write a query that produces a summary report for the `'button_color_exp'` experiment. For each `variation_name` ('control' and 'treatment'), you must calculate:

1. `total_users`: The total number of unique users who saw the page.
2. `purchasing_users`: The number of unique users who made a 'purchase'.
3. `conversion_rate_pct`: The percentage of users who saw the page and also made a purchase.
4. `avg_purchase_value`: The average `value` for all 'purchase' events.

The final report should compare the two variations side-by-side.

| **variation_name** | **total_users** | **purchasing_users** | **conversion_rate_pct** | **avg_purchase_value** |
| ------------------------ | --------------------- | -------------------------- | ----------------------------- | ---------------------------- |
| control                  | 5                     | 2                          | 40.00                         | 55.00                        |
| treatment                | 5                     | 3                          | 60.00                         | 80.00                        |

### Tips for Approaching the Problem

1. **Isolate the Experiment:** Start by filtering the `experiment_events` table to only include records where `experiment_id = 'button_color_exp'`. It's best to do this in a CTE.
2. **Use Conditional Aggregation:** The core of this problem can be solved efficiently with conditional aggregation. After filtering, `GROUP BY variation_name`.
3. **Calculate Each Metric:**
   * `total_users`: Can be calculated with `COUNT(DISTINCT user_id)`.
   * `purchasing_users`: Can be calculated by counting the unique users but *only* when a purchase event occurs. The syntax `COUNT(DISTINCT CASE WHEN event_name = 'purchase' THEN user_id END)` is perfect for this.
   * `avg_purchase_value`: Use the `AVG()` function, but again, only consider rows where `event_name = 'purchase'`. `AVG(CASE WHEN event_name = 'purchase' THEN value END)`.
4. **Combine for Conversion Rate:** Once you have the counts for `total_users` and `purchasing_users` from the conditional aggregations, you can calculate the `conversion_rate_pct` using the formula: `(purchasing_users * 100.0) / total_users`. Multiplying by `100.0` ensures decimal division.

**Your Solution:**

```sql
-- Write your solution here
```
