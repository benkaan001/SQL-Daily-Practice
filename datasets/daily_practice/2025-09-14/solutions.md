## Puzzle: The Conversion Funnel Drop-off

**The Scenario:** As a product analyst, you are tasked with analyzing the user conversion funnel for your e-commerce platform. You need to understand not only how many users make it to each step but also where they are dropping off and how long they take between steps.

**Your Task:** Write a single query to analyze the entire user funnel. The funnel has four key steps in this order: `VIEW_ITEM`, `ADD_TO_CART`, `BEGIN_CHECKOUT`, and `PAYMENT_SUCCESS`. For each step, you must calculate:

1. `users_at_step`: The number of unique user sessions (`session_id`) that reached this step.
2. `drop_off_rate_pct`: The percentage of sessions that reached this step but did *not* proceed to the next one. The drop-off rate for the final step (`PAYMENT_SUCCESS`) is always 0.
3. `avg_time_to_next_step_seconds`: For the sessions that *did* proceed, what was the average time in seconds to get from the current step to the next one?

The final report should present these metrics for each of the four funnel steps, ordered chronologically.

| **funnel_step** | **users_at_step** | **drop_off_rate_pct** | **avg_time_to_next_step_seconds** |
| --------------------- | ----------------------- | --------------------------- | --------------------------------------- |
| VIEW_ITEM             | 6                       | 33.33                       | 25.83                                   |
| ADD_TO_CART           | 4                       | 25.00                       | 160.00                                  |
| BEGIN_CHECKOUT        | 3                       | 33.33                       | 50.00                                   |
| PAYMENT_SUCCESS       | 2                       | 0.00                        | NULL                                    |

**Your Solution:**

```sql
-- Write your solution here
```
