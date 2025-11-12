## Puzzle: The "Checkout Abandonment" Detector

**The Scenario:** As an e-commerce analyst, you need to find sessions where a user showed high purchase intent but ultimately abandoned their journey. This helps the product team investigate potential friction in the checkout process.

**Your Task:** Write a query to find all user sessions that followed the "High-Intent" path but did *not* result in a purchase.

The "High-Intent" path is defined as a user visiting `/home`, then (at any point later in the session) visiting `/products`, and then (at any point after that) visiting `/checkout`.

The session is considered "abandoned" if it followed this 3-step path but *never* had a subsequent visit to `/purchase_complete` within the same session.

The final report should show the `session_id`, `user_id`, and the `checkout_time` (the timestamp of the `/checkout` event).

| session_id | user_id | checkout_time |

| sess_B | 102 | 2023-11-11 11:02:00.000 |

| sess_E | 101 | 2023-11-11 14:02:00.000 |

### Tips for Approaching the Problem

1. **Use Window Functions to Find the Path:** This is a sequential path problem, but the events are not necessarily *immediately* consecutive.
   * First, in a CTE, get the `MIN()` timestamp for each of the four key pages (`/home`, `/products`, `/checkout`, `/purchase_complete`) for each `session_id`. You can use conditional aggregation (`MIN(CASE WHEN page_url = '/home' THEN ... END)`) grouped by `session_id`.
2. **Filter for the Path:** With your data pivoted into columns (`home_time`, `products_time`, `checkout_time`, `purchase_time`), you can easily check the "High-Intent" path logic.
3. **Apply the Logic:** Your `WHERE` clause should check for two conditions:
   * The path was followed in the correct order: `home_time < products_time` AND `products_time < checkout_time`.
   * The purchase was *not* completed: `purchase_time IS NULL` OR `purchase_time < checkout_time`. (The `IS NULL` check is the key one here).

**Your Solution:**

```sql
-- Write your solution here
```
