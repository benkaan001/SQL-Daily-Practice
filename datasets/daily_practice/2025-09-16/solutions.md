## Puzzle: The Last-Click Attribution Model

**The Scenario:** As a marketing analyst, you are tasked with implementing a "last-click" attribution model to measure the effectiveness of your advertising campaigns. You need to credit each purchase to the marketing campaign that the user last interacted with before buying.

**Your Task:** Write a query that attributes every `PURCHASE` event to a specific `campaign_id` or to 'Organic'. The rules are as follows:

1. A purchase is attributed to a campaign if the user had an `AD_CLICK` event for that campaign within the 7 days *prior* to the purchase.
2. If a user clicked on multiple ads from different campaigns within the 7-day window, the purchase should be attributed to the campaign associated with the *most recent* `AD_CLICK`.
3. If a purchase has no preceding `AD_CLICK` within the 7-day window for that user, it should be attributed to 'Organic'.

The final report should be a summary that shows the `attributed_source` (either a `campaign_id` or 'Organic'), the total number of `attributed_purchases`, and the `total_attributed_value` for that source.

| attributed_source | attributed_purchases | total_attributed_value |
| ----------------- | -------------------- | ---------------------- |
| black_friday_23   | 3                    | 325.00                 |
| cyber_monday_23   | 2                    | 1100.00                |
| Organic           | 4                    | 575.00                 |


**Your Solution:**

```sql
-- Step 1: For every individual purchase, find the most recent preceding ad click within the 7-day window.
WITH PurchaseAttribution AS (
    SELECT
        p.purchase_value,
        -- This correlated subquery is the key to the solution. For each purchase (p),
        -- it runs a small search to find the single, most recent ad click that meets the criteria.
        (SELECT
            ac.campaign_id
         FROM
            user_touchpoints ac
         WHERE
            ac.user_id = p.user_id
            AND ac.event_type = 'AD_CLICK'
            -- The click must have happened BEFORE the purchase
            AND ac.event_timestamp < p.event_timestamp
            -- And it must be within the 7-day attribution window
            AND ac.event_timestamp >= DATE_SUB(p.event_timestamp, INTERVAL 7 DAY)
         -- This ensures we only get the MOST RECENT click if there are multiple
         ORDER BY
            ac.event_timestamp DESC
         LIMIT 1
        ) AS campaign
    FROM
        user_touchpoints p
    WHERE
        p.event_type = 'PURCHASE'
)
-- Step 2: Aggregate the results to build the final report.
SELECT
    -- If the subquery found no campaign (returned NULL), the purchase is 'Organic'.
    COALESCE(campaign, 'Organic') AS attributed_source,
    COUNT(*) AS attributed_purchases,
    SUM(purchase_value) AS total_attributed_value
FROM
    PurchaseAttribution
GROUP BY
    attributed_source
ORDER BY
    attributed_source;
```

