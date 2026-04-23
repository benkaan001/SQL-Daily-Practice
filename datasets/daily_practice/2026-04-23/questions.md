## Puzzle: The Abandoned Cart Value

**The Scenario:** The retargeting team wants to send reminder emails to users who left items in their cart. They need a report of all "abandoned" sessions and the total dollar value of the items left behind to prioritize the highest-value carts.

**Your Task:** Write a query to identify all abandoned sessions, calculate the number of items left in the cart, and the total value of those items.

**Rules:**

1. A session is considered "abandoned" if it does **not** contain a `CHECKOUT` event.
2. The net items in the cart are calculated by counting `ADD_ITEM` events and subtracting `REMOVE_ITEM` events.
3. The net cart value is calculated by adding the `price` of `ADD_ITEM` events and subtracting the `price` of `REMOVE_ITEM` events.
4. Only include sessions that have at least 1 item remaining in the cart (exclude sessions where the user emptied their cart completely before leaving).
5. Order the results by `abandoned_value` in descending order.

The final report should show the `session_id`, the timestamp of their `last_activity`, the net `items_in_cart`, and the `abandoned_value`.

**Expected Output:**

| **session_id** | **last_activity** | **items_in_cart** | **abandoned_value** |

| sess_02 | 2026-04-23 11:15:00 | 1 | 200.00 |

| sess_04 | 2026-04-23 13:05:00 | 2 | 45.00 |

### Tips for Approaching the Problem

1. **Group by Session:** You are summarizing data at the session level, so `GROUP BY session_id` is your foundation.
2. **Filter Out Checkouts:** Use the `HAVING` clause combined with conditional aggregation to ensure the session does not contain a checkout event. For example: `SUM(CASE WHEN event_type = 'CHECKOUT' THEN 1 ELSE 0 END) = 0`.
3. **Conditional Math:** In your `SELECT` and `HAVING` clauses, use `CASE` statements to perform the addition and subtraction.
   * To get the cart value: add the `price` when the event is an `ADD_ITEM`, subtract the `price` when it's a `REMOVE_ITEM`, and add `0` otherwise. Wrap this in a `SUM()`.
4. **Find Last Activity:** The `last_activity` is simply the `MAX(event_timestamp)` for that session.
5. **Exclude Empty Carts:** Add a final condition to your `HAVING` clause to ensure the net number of items in the cart (calculated using the same conditional math concept as step 3) is strictly greater than zero.

**Your Solution:**

```sql
-- Write your solution here
```
