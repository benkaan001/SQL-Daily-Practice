## Puzzle: The Double-Billing Refund (Date Overlaps)

**The Scenario:** Due to a frontend glitch, several users were able to purchase new subscriptions without their old ones being properly terminated. This resulted in "double-billing" where users held two active subscriptions at the exact same time. The Customer Success team needs to issue prorated refunds for the exact number of overlapping days.

**Your Task:** Write a query to find all pairs of subscriptions for the same user that overlap in time. For each pair, calculate the precise start and end dates of the overlapping period, and the total duration of the overlap in days.

*Rules:*

1. Assume both `start_date` and `end_date` are inclusive. A 1-day overlap (e.g., ending and starting on the exact same day) counts as `1` day.
2. Do not compare a subscription to itself.
3. Each overlapping pair should only appear in the results once (e.g., if Sub 1 and Sub 2 overlap, do not also output a row for Sub 2 and Sub 1).

The final report should show the `user_id`, `sub_id_1`, `sub_id_2`, the calculated `overlap_start`, `overlap_end`, and `overlap_duration_days`. Order the results by `user_id`.

**Expected Output:**

| **user_id** | **sub_id_1** | **sub_id_2** | **overlap_start** | **overlap_end** | **overlap_duration_days** |
| ----------------- | ------------------ | ------------------ | ----------------------- | --------------------- | ------------------------------- |
| 101               | 1                  | 2                  | 2026-01-15              | 2026-01-31            | 17                              |
| 103               | 5                  | 6                  | 2026-03-10              | 2026-03-15            | 6                               |
| 104               | 7                  | 8                  | 2026-04-05              | 2026-04-10            | 6                               |
| 105               | 9                  | 10                 | 2026-05-15              | 2026-05-15            | 1                               |

### Tips for Approaching the Problem

1. **The Self-Join Setup:** You need to compare rows within the same table. `JOIN` the `user_subscriptions` table to itself (aliased as `s1` and `s2`) on `user_id`.
2. **Preventing Duplicates:** To ensure you only compare distinct pairs and don't get mirror duplicates (A-B and B-A), add `s1.sub_id < s2.sub_id` to your `JOIN` condition.
3. **The Universal Overlap Formula:** Two date ranges overlap if and only if: `Start_A <= End_B AND End_A >= Start_B`. Add this logic to your `WHERE` or `JOIN` conditions.
4. **Calculating the Boundary:** * The overlap *starts* at the later of the two start dates: `GREATEST(s1.start_date, s2.start_date)`.
   * The overlap *ends* at the earlier of the two end dates: `LEAST(s1.end_date, s2.end_date)`.
5. **Calculating Duration:** Use the `DATEDIFF()` function on your calculated `overlap_end` and `overlap_start`. Remember to add `+ 1` to the result so that inclusive boundaries are counted correctly.

**Your Solution:**

```sql
-- Write your solution here
```
