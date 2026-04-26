## Puzzle: The Top Product Substitution

**The Scenario:** As a product analyst for a grocery delivery app, you want to improve the "Out of Stock" recommendations. To do this, you need to analyze historical user behavior to see what items users naturally substitute when they remove something from their cart.

**Your Task:** Write a query to find the **#1 most common substitution** for every product that has been removed.

A valid "substitution" occurs when:

1. An `ADD` event is the *very next* event logged in the user's session after a `REMOVE` event.
2. The `ADD` event occurs within **3 minutes** (180 seconds) of that `REMOVE` event.

The final report should show the `removed_product`, its `top_substitution`, and the `substitution_count` (how many times that specific swap happened).

Order the results alphabetically by the `removed_product`.

**Expected Output:**

| **removed_product** | **top_substitution** | **substitution_count** |

| Organic Eggs | Standard Eggs | 2 |

| Oranges | Banana | 1 |

| Whole Milk | Oat Milk | 2 |

*(Note: 'Avocado' is excluded because the subsequent 'ADD' took longer than 3 minutes. 'Apples' is excluded because the immediately following event was another 'REMOVE', not an 'ADD').*

### Tips for Approaching the Problem

1. **Look Ahead:** Because the rules state the substitution must be the *very next* event in the session, the `LEAD()` window function is perfect. In a CTE, partition by `session_id` and order by `event_timestamp`.
   * Fetch the `LEAD(action)` to get the next action.
   * Fetch the `LEAD(product_name)` to get the potential substituted item.
   * Fetch the `LEAD(event_timestamp)` to check the time gap.
2. **Filter for Valid Substitutions:** Create a second CTE that filters the results from the first one. You only want to keep rows where:
   * The current `action` is 'REMOVE'.
   * The next `action` is 'ADD'.
   * `TIMESTAMPDIFF(MINUTE, current_timestamp, next_timestamp) <= 3`.
3. **Count the Pairs:** In a third CTE, `GROUP BY` the removed product and the substituted product, and use `COUNT(*)` to see how many times each specific pair occurred.
4. **Rank and Isolate the Top Match:** Now that you have the frequencies of all substitutions, use `ROW_NUMBER() OVER (PARTITION BY removed_product ORDER BY substitution_count DESC)` to rank them. In your final `SELECT`, filter for rank `1`.

**Your Solution:**

```sql
-- Write your solution here
```
