## Puzzle: The Cross-Pollination Matrix

**The Scenario:** The Product team wants to understand the "upsell" pathways within your application. Specifically, they want to know: if a user adopts Feature X as their very first feature, what is the most likely feature they will adopt next?

**Your Task:** Create a cross-pollination matrix. For every feature that served as a user's *initial entry point* into the platform, count how many of those users subsequently adopted other specific features.

**Rules:**

1. Determine each user's "Origin Feature" (the feature with the earliest `adoption_date` for that user).
2. For all *subsequent* features adopted by that user (where the `adoption_date` is strictly greater than the origin feature's date), count the occurrences.
3. The report should pivot the subsequent features into columns: `adopted_dashboard`, `adopted_reporting`, and `adopted_api_access`.

The final report should show the `origin_feature`, the `total_users_started_here` (the count of users whose first feature was this one), and the three pivoted counts representing what those users did next. Order alphabetically by `origin_feature`.

**Expected Output:**

| **origin_feature** | **total_users_started_here** | **adopted_dashboard** | **adopted_reporting** | **adopted_api_access** |
| ------------------------ | ---------------------------------- | --------------------------- | --------------------------- | ---------------------------- |
| API_Access               | 1                                  | 1                           | 0                           | 0                            |
| Dashboard                | 3                                  | 0                           | 1                           | 2                            |
| Reporting                | 2                                  | 1                           | 0                           | 1                            |

*(Example Check: 3 users (101, 103, 104) started on the Dashboard. Of those 3, zero later adopted the Dashboard (because they already had it), one (101) later adopted Reporting, and two (101, 104) later adopted API Access).*

### Tips for Approaching the Problem

1. **Find the Origin Feature:** First, establish the baseline for every user. Create a Common Table Expression (CTE) that uses the `ROW_NUMBER()` window function, partitioned by `user_id` and ordered by `adoption_date`. The row where `rank = 1` is that user's "Origin Feature".
2. **Isolate Origins:** Create a second CTE that selects only the rows from the first CTE where the rank is 1. This gives you a clean list of `user_id`, `origin_feature_name`, and `origin_adoption_date`.
3. **Join to Subsequent Adoptions:** In your main query, select from your "Origins" CTE. Then, `LEFT JOIN` the original `feature_adoption_log` table back onto it.
   * Join on `user_id = user_id`.
   * Add a crucial condition: `subsequent_log.adoption_date > origin_cte.origin_adoption_date`. This ensures you only join features adopted *after* the origin feature. The `LEFT JOIN` ensures users like 103 (who never adopted a second feature) are still counted in the `total_users_started_here` column.
4. **Pivot and Aggregate:** Group the results by the `origin_feature`.
   * `COUNT(DISTINCT origin_cte.user_id)` gives you the total users who started there.
   * Use conditional aggregation (`SUM(CASE WHEN subsequent_log.feature_name = 'Dashboard' THEN 1 ELSE 0 END)`) to pivot the subsequent adoptions into their respective columns.

**Your Solution:**

```sql
-- Write your solution here

```
