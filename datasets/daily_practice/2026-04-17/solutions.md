## Puzzle: The "Next Best Action" (Second Purchase Analysis)

**The Scenario:** The Growth Marketing team wants to optimize their post-purchase email flows. They want to know: if a customer's *very first* purchase is the "Starter Kit," what should the automated follow-up email recommend they buy next?

To answer this, you need to find the most common *second* purchase made by users whose *first* purchase was the Starter Kit.

**Your Task:** Write a query that identifies all users whose chronological first purchase was exactly `'Starter Kit'`. For that specific cohort of users, aggregate their second purchases.

The report should show the `second_product_name`, the `purchase_count` (how many users bought it as their second item), and the `conversion_rate_pct`.

The `conversion_rate_pct` is the percentage of the original cohort that went on to buy this specific second item. *(Note: Users who bought the Starter Kit but never made a second purchase should still be counted in the cohort baseline denominator!)*

Order the results by `purchase_count` in descending order.

**Expected Output:**

| **second_product_name** | **purchase_count** | **conversion_rate_pct** |

| Refill Pack | 3 | 50.00 |

| Advanced Kit | 2 | 33.33 |

*(Note: There were 6 total users whose first purchase was the Starter Kit. 3 of them bought the Refill Pack next, resulting in a 50.00% conversion rate).*

### Tips for Approaching the Problem

1. **Rank the Purchases:** First, you need to establish the chronological order of purchases for every user. Create a Common Table Expression (CTE) that uses the `ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY purchase_timestamp)` window function.
2. **Isolate the Cohort:** Create a second CTE that filters your ranked data. You only want the `user_id`s where the rank is `1` AND the `product_name` is `'Starter Kit'`. This establishes your baseline group of eligible users.
3. **Get the Baseline Count:** You will need the total number of users in this cohort to calculate the percentages later. You can calculate this on the fly using a scalar subquery: `(SELECT COUNT(*) FROM cohort_cte)`.
4. **Find the Second Purchases:** In your main `SELECT` statement, query from your ranked purchases table again. Filter for rows where the rank is `2`, but make sure you `JOIN` or `IN` filter against your cohort CTE to ensure you are only looking at the second purchases of the "Starter Kit" first-buyers.
5. **Aggregate and Calculate:** Group by the `product_name` (which is now the second product). Count the users, and calculate the percentage by dividing by the scalar subquery from Step 3. Don't forget to multiply by 100.0 to handle decimal math!

**Your Solution:**

```sql
-- Write your solution here
```
