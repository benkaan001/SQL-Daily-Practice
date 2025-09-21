## Puzzle: The Moderator Agreement Scorecard

**The Scenario:** As the head of Trust & Safety, you need to evaluate the performance of your automated content moderation system. You want to see how often your human moderators agree with the auto-mod's initial assessment and how quickly they process the items flagged for review.

**Your Task:** Write a query to create a performance scorecard for the human review process, but  *only for content that was first flagged by the `auto-mod`* . The final report should summarize performance based on the auto-mod's initial flag (`FLAG_FOR_REVIEW_APPROVE` vs. `FLAG_FOR_REVIEW_REJECT`).

For each `initial_flag_type`, calculate:

1. `total_auto_flags`: The total number of items flagged by the auto-mod with this assessment.
2. `total_human_reviews`: The number of those items that were subsequently reviewed by a human.
3. `human_agreement_rate_pct`: Of the items reviewed by a human, what percentage of the time did the human's final decision (`APPROVE`/`REJECT`) match the auto-mod's initial assessment? (e.g., if auto-mod said `FLAG_FOR_REVIEW_REJECT`, did the human also say `REJECT`?)
4. `avg_time_to_review_seconds`: The average time in seconds from the `AUTO_FLAG` event to the `MANUAL_REVIEW` event for reviewed items.

| **initial_flag_type** | **total_auto_flags** | **total_human_reviews** | **human_agreement_rate_pct** | **avg_time_to_review_seconds** |
| --------------------------- | -------------------------- | ----------------------------- | ---------------------------------- | ------------------------------------ |
| FLAG_FOR_REVIEW_APPROVE     | 1                          | 1                             | 100.00                             | 120.00                               |
| FLAG_FOR_REVIEW_REJECT      | 5                          | 4                             | 50.00                              | 697.50                               |


### Tips for Approaching the Problem

1.  **Isolate and Link Events:**
    * The first step is to connect each `AUTO_FLAG` event with its corresponding `MANUAL_REVIEW` event. The common link between them is the `content_id`.
    * Use a Common Table Expression (CTE) to select all `AUTO_FLAG` events.
    * Use another CTE to select all `MANUAL_REVIEW` events.
    * Perform a `LEFT JOIN` from your `auto_flags` CTE to your `manual_reviews` CTE on `content_id`. A `LEFT JOIN` is crucial because you need to count all auto-flags, even those that haven't been reviewed by a human yet.

2.  **Determine Agreement:**
    * After joining, you'll have rows with both the auto-mod's action (`event_type`) and the human's action (`event_details`). The core logic is to check if they match.
    * Use a `CASE` statement to create an "agreement flag." The logic will be:
        * `WHEN auto_flag.event_type = 'FLAG_FOR_REVIEW_APPROVE' AND manual_review.event_details = 'APPROVE' THEN 1`
        * `WHEN auto_flag.event_type = 'FLAG_FOR_REVIEW_REJECT' AND manual_review.event_details = 'REJECT' THEN 1`
        * `ELSE 0`
    * This will give you a `1` for every agreement, which you can easily sum up later.

3.  **Calculate Time to Review:**
    * In the same joined CTE, calculate the time difference between the `auto_flag.event_timestamp` and the `manual_review.event_timestamp`. A function like `TIMESTAMPDIFF()` is perfect for this.

4.  **Perform the Final Aggregation:**
    * With your prepared data from the join, you can now perform the final `GROUP BY` on the `initial_flag_type` (`auto_flags.event_type`).
    * `total_auto_flags` is a simple `COUNT(*)` or `COUNT(content_id)` of the auto-flags.
    * `total_human_reviews` is a `COUNT()` of a column from the `manual_reviews` side of the join (e.g., `COUNT(manual_reviews.content_id)`). This works because `COUNT` ignores the `NULL`s for unreviewed flags.
    * `human_agreement_rate_pct` can be calculated with `(SUM(agreement_flag) * 100.0) / COUNT(manual_reviews.content_id)`.
    * `avg_time_to_review_seconds` is a simple `AVG()` of the time difference you calculated.
**Your Solution:**

```sql
-- Write your solution here
```
