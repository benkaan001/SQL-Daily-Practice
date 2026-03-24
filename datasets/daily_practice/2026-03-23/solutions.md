## Puzzle: First-Touch vs. Last-Touch Attribution

**The Scenario:** The marketing team is arguing over budget allocation. The Social Media manager claims they drive all the new traffic, while the Email Marketing manager claims they drive all the sales. To settle the debate, they need a report analyzing the customer journey from discovery to conversion.

**Your Task:** Write a query to generate an attribution summary for every user who successfully made a purchase.

For each of these converted users, the report must show:

1. `first_touch_channel`: The marketing channel of their very first interaction with the site.
2. `last_touch_channel`: The marketing channel associated with their *first* successful purchase event.
3. `days_to_conversion`: The number of days that elapsed between their first touch and their first purchase.

Order the results by `user_id`.

**Expected Output:**

| **user_id** | **first_touch_channel** | **last_touch_channel** | **days_to_conversion** |
| ----------------- | ----------------------------- | ---------------------------- | ---------------------------- |
| 101               | Social Media                  | Email Promo                  | 9                            |
| 102               | Paid Search                   | Paid Search                  | 0                            |
| 104               | Influencer Link               | Direct Traffic               | 50                           |
| 105               | Email Promo                   | Organic Search               | 1                            |

### Tips for Approaching the Problem

This problem requires identifying two specific, independent events for each user and placing them on the same row.

1. **Find the First Purchase (Last Touch):** Start by isolating the conversion event. Create a Common Table Expression (CTE) that filters for `is_purchase = TRUE`. Because a user might make multiple purchases over their lifetime (like User 105), use the `ROW_NUMBER()` window function partitioned by `user_id` and ordered by `touch_timestamp ASC` to isolate their *very first* purchase.
2. **Find the First Touch:** Create a second CTE to find the absolute first interaction for each user, regardless of whether it was a purchase or not. Again, `ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY touch_timestamp ASC)` is the perfect tool here.
3. **Join the Touches:** In your main query, `JOIN` your first touch CTE with your first purchase CTE on `user_id`. (Since we only want a report on users who converted, an `INNER JOIN` ensures users like 103 are excluded).
4. **Calculate Time to Conversion:** Use the `DATEDIFF()` function to calculate the difference in days between the purchase timestamp and the initial touch timestamp.

**Your Solution:**

```sql
WITH touch_times AS (
    SELECT 
        user_id, 
        MIN(touch_timestamp) AS first_touch_timestamp,
        MIN(CASE WHEN is_purchase = TRUE THEN touch_timestamp END) AS last_touch_timestamp
    FROM
        marketing_touches
    GROUP BY
        user_id
),
joint_data AS (
    SELECT
        mt.user_id,
        CASE WHEN tt.first_touch_timestamp = mt.touch_timestamp THEN mt.marketing_channel END AS first_touch_channel,
        CASE WHEN tt.last_touch_timestamp = mt.touch_timestamp THEN mt.marketing_channel END AS last_touch_channel,
        DATEDIFF(tt.last_touch_timestamp, tt.first_touch_timestamp) AS days_to_conversion
    FROM
        touch_times tt  
    JOIN
        marketing_touches mt ON tt.user_id = mt.user_id 
    WHERE 
        tt.last_touch_timestamp IS NOT NULL -- users who never converted
)
SELECT 
    user_id, 
    MIN(first_touch_channel) AS first_touch_channel, 
    MIN(last_touch_channel) AS last_touch_channel, 
    MIN(days_to_conversion) AS days_to_conversion
FROM
    joint_data 
GROUP BY
    user_id
ORDER BY 
    user_id;
```
