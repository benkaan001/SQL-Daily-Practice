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

**Your Solution:**

```sql
-- Write your solution here
```
