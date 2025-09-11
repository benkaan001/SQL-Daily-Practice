## Puzzle: The Demoralized Courier

**The Scenario:** The operations team has a hypothesis that when a delivery courier receives a low rating (a score of 2 or less), their performance on subsequent deliveries suffers for the rest of their shift. You are tasked with verifying this by analyzing their delivery timeliness.

**Your Task:** Write a query to identify every instance where a courier received a low rating. For each of these instances, calculate the courier's average delivery lateness *before* the low-rated delivery and their average delivery lateness *after* the low-rated delivery on that same day.

Lateness is defined as the difference in minutes between the actual `ORDER_DELIVERED` time and the `estimated_delivery_time`. A negative value means the delivery was early. The analysis should only include couriers who completed at least one delivery both before and after receiving the low rating on the same day.

The final report should show the `courier_id`, the `low_rated_order_id`, the `rating_received_timestamp`, the `avg_lateness_before_bad_rating`, and the `avg_lateness_after_bad_rating`.

| **courier_id** | **low_rated_order_id** | **rating_received_timestamp** | **avg_lateness_before_bad_rating** | **avg_lateness_after_bad_rating** |
| -------------------- | ---------------------------- | ----------------------------------- | ---------------------------------------- | --------------------------------------- |
| 101                  | 2                            | 2023-10-10 15:00:00.000             | -5.00                                    | 10.00                                   |

**Your Solution:**

```sql
-- Write your solution here
```
