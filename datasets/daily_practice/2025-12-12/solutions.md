## Puzzle: The "Review Bombing" Detector

**The Scenario:** "Review bombing" occurs when a group of users coordinates to flood a product with negative reviews in a short period to harm its reputation. As a Trust & Safety analyst, you need to build an automated alert for this behavior.

**Your Task:** Write a query to identify any `product_id` that is under a "review bombing" attack. An attack is defined as receiving **5 or more** 1-star ratings within a  **60-minute moving window** .

The report should show the `product_id`, the `attack_start_time` (the timestamp of the first 1-star review in the burst), and the `attack_end_time` (the timestamp of the 5th 1-star review in that burst).

| **product_id** | **attack_start_time** | **attack_end_time** |
| -------------------- | --------------------------- | ------------------------- |
| 102                  | 2023-12-12 14:00:00.000     | 2023-12-12 14:25:00.000   |

### Tips for Approaching the Problem

1. **Filter for Negatives:** Start by isolating only the rows where `rating = 1`.
2. **Look Ahead (Window Functions):** The goal is to check if, for any given 1-star review, there are 4 *more* 1-star reviews in the next 60 minutes.
3. **The N-th Following Row:** Use the `LEAD()` window function with an offset. specifically `LEAD(review_timestamp, 4)`. This looks 4 rows ahead (finding the 5th item in the sequence including the current row). Partition by `product_id` and order by time.
4. **Calculate Duration:** Compare the current row's timestamp with the timestamp retrieved by `LEAD`. If the difference is `<= 60 minutes`, you have found a cluster of 5 reviews within the time limit.
5. **Clean Up:** Since a cluster of 6 reviews effectively contains *two* overlapping clusters of 5, you might get multiple rows for the same attack. You can simply return all of them, or `GROUP BY` / `DISTINCT` to clean it up.

**Your Solution:**

```sql
-- Write your solution here
```
