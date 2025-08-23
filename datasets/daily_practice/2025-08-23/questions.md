## Scenario 1: Dispatch Efficiency Analysis

**Objective:** As an operations manager, you need to measure the efficiency of the courier dispatch system. A key metric is the "time-to-assign," which is the duration between an order being created and a courier being assigned.

**Task:** For every order that was successfully assigned a courier, calculate the `time_to_assign_seconds`. The final report should show the `order_id`, the `restaurant_id`, the timestamp when the order was `created`, the timestamp when it was `assigned`, and the calculated `time_to_assign_seconds`.

Order the results by `order_id`.

**Expected Output:**

| **order_id** | **restaurant_id** | **created_at** | **assigned_at** | **time_to_assign_seconds** |
| ------------------ | ----------------------- | -------------------- | --------------------- | -------------------------------- |
| 101                | 1                       | 2023-12-05 12:00:00  | 2023-12-05 12:00:45   | 45.50                            |
| 102                | 2                       | 2023-12-05 18:30:00  | 2023-12-05 18:33:10   | 190.20                           |
| 103                | 1                       | 2023-12-05 12:05:00  | 2023-12-05 12:06:00   | 60.00                            |
| 104                | 3                       | 2023-12-05 12:10:00  | 2023-12-05 12:11:00   | 60.00                            |
| 105                | 2                       | 2023-12-06 12:30:00  | 2023-12-06 12:30:30   | 30.00                            |
| 106                | 1                       | 2023-12-06 19:00:00  | 2023-12-06 19:04:00   | 240.00                           |

**Your Solution:**

```sql
-- Write your solution here
```

## Scenario 2: Courier Performance by Time of Day

**Objective:** You want to identify the most efficient couriers during different meal rushes. Efficiency is measured by "time-to-pickup": the duration between a courier being assigned an order and them picking it up.

**Task:**

1. Categorize each picked-up order into a `meal_rush` period: 'Lunch' (11:00 - 14:00) or 'Dinner' (18:00 - 21:00).
2. For each `meal_rush` period, find the `courier_id` with the lowest average `time_to_pickup_minutes`.
3. The report should show the `meal_rush`, the `best_courier_id`, and their `avg_time_to_pickup_minutes` for that period.

**Expected Output:**

| **meal_rush** | **best_courier_id** | **avg_time_to_pickup_minutes** |
| ------------------- | ------------------------- | ------------------------------------ |
| Dinner              | 502                       | 21.83                                |
| Lunch               | 503                       | 13.50                                |

**Your Solution:**

```sql
-- Write your solution here
```

## Scenario 3: Detecting "Hoarded" Orders

**Objective:** A "hoarded" order occurs when a courier accepts an order but significantly delays picking it up, often to wait for another nearby order to become available. This negatively impacts customer experience.

**Task:** Identify orders that were likely "hoarded." An order is considered hoarded if:

1. The time from `COURIER_ASSIGNED` to `ORDER_PICKED_UP` is greater than the `estimated_prep_time_mins` for that order.
2. During this waiting period, the same courier was assigned *another* order.

The report should show the `hoarded_order_id`, the `courier_id`, the `time_assigned`, the `time_picked_up`, and the `next_assigned_order_id` that the courier accepted while waiting.

**Expected Output:**

| **hoarded_order_id** | **courier_id** | **time_assigned** | **time_picked_up** | **next_assigned_order_id** |
| -------------------------- | -------------------- | ----------------------- | ------------------------ | -------------------------------- |
| 103                        | 501                  | 2023-12-05 12:06:00     | 2023-12-05 12:20:00      | 104                              |

**Your Solution:**

```sql
-- Write your solution here
```
