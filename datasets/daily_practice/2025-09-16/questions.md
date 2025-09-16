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
-- Write your solution here
```
