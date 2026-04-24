## Puzzle: "Last Non-Direct Click" Attribution

**The Scenario:** Marketing teams hate attributing sales to "Direct" traffic (when a user simply types the URL into their browser). It usually means a previous marketing campaign did the hard work of acquiring the user, but the user just remembered the website name later!

To solve this, companies use the **"Last Non-Direct Click"** attribution model. This model ignores 'Direct' visits and gives 100% of the credit to the last known marketing channel, *unless* the user has absolutely no other prior touchpoints besides 'Direct'.

**Your Task:** Write a query to attribute a `traffic_channel` to every single sale in the `sales_conversions` table.

**The Rules:**

1. Only look at visits that occurred *strictly before* the specific `sale_timestamp`.
2. Find the most recent visit that is NOT 'Direct'.
3. If no non-direct visits exist (or if all prior visits were 'Direct'), fall back and use 'Direct'.
4. If the user has *no prior visits on record at all* (like User 105), attribute the sale to 'Unknown'.

The final report should show the `sale_id`, `user_id`, `attributed_channel`, and `revenue`. Order the results by `sale_id`.

**Expected Output:**

| **sale_id** | **user_id** | **attributed_channel** | **revenue** |

| 1 | 101 | Organic Search | 150.00 |

| 2 | 102 | Social Media | 200.00 |

| 3 | 103 | Direct | 50.00 |

| 4 | 104 | Email | 100.00 |

| 5 | 104 | Paid Search | 300.00 |

| 6 | 105 | Unknown | 75.00 |

### Tips for Approaching the Problem

1. **Join Sales to Prior Visits:** Start by taking the `sales_conversions` table and doing a `LEFT JOIN` to the `website_visits` table. The join conditions should match the `user_id` and ensure the visit occurred *before* the sale (`v.visit_timestamp < s.sale_timestamp`).
2. **The Ranking Trick:** For each sale, you might have joined multiple preceding visits. You need to pick exactly one. The `ROW_NUMBER()` window function partitioned by `sale_id` is perfect.
3. **Sorting by Priority:** The "magic" of this puzzle is in the `ORDER BY` clause of your window function. You want the most recent *non-direct* visit. If none exist, you want the most recent *direct* visit. You can achieve this by using a `CASE` statement in the `ORDER BY` to assign a lower sort priority to 'Direct' visits (e.g., `CASE WHEN traffic_channel = 'Direct' THEN 1 ELSE 0 END ASC`), followed by `visit_timestamp DESC`.
4. **Handle Missing Data:** Because you used a `LEFT JOIN`, sales with no prior visits will have a `NULL` channel. Use `COALESCE` in your final `SELECT` statement to label these as 'Unknown'.

**Your Solution:**

```sql
-- Write your solution here
```
