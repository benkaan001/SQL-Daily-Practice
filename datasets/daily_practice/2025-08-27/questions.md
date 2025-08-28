## Puzzle 1: The Conversion Conundrum

**The Scenario:** The marketing team launched a campaign for "Winter Getaways" to Zurich (ZRH). They need to understand the full conversion funnel for users who showed interest in this specific destination.

**Your Task:** Write a query that answers the following questions for user sessions involving Zurich:

1. **Of all unique users who searched for a flight to 'ZRH', what percentage of them also viewed a hotel in 'ZRH'?**
2. **Of those users who searched for a flight AND viewed a hotel in 'ZRH', what percentage of them went on to book either a flight or a hotel to 'ZRH' within the same session?**

**The final report should present these two conversion rates.**

**Expected Output:**

| search_to_view_rate | view_to_book_rate |
| ------------------- | ----------------- |
| 66.67               | 50.00             |


**Your Solution:**

```sql
-- Write your solution here
```

## Puzzle 2: The "Lost Revenue" What-If

**The Scenario:** Cancellations are hurting the bottom line. The finance team wants to quantify the impact of "last-minute" cancellations and project the potential savings if this problem were partially solved.

**Your Task:**

1. **Identify all "last-minute" cancellations. A cancellation is considered last-minute if the **`cancel_booking` event occurs within 48 hours of the initial `book_flight` or `book_hotel` event for the same `booking_id`.
2. **Calculate the **`total_lost_revenue` from these specific cancellations.
3. **Project the **`potential_recovered_revenue` assuming the company could implement a policy that prevents 25% of this lost revenue.

**The final report should contain the **`total_lost_revenue` and the `potential_recovered_revenue`.

**Expected Output:**

| total_lost_revenue | potential_recovered_revenue |
| ------------------ | --------------------------- |
| 450.0              | 112.5                       |


**Your Solution:**

```sql
-- Write your solution here
```

## Puzzle 3: The Ghost Booking Detective

**The Scenario:** A bug has been reported where some users are able to book a flight without having first performed a flight search in their current session. This indicates a flaw in the user workflow.

**Your Task:** Find all sessions where a `book_flight` event occurred without a preceding `search_flights` event  *within that same session* **.**

**The report should list the **`session_id`, `user_id`, and the `booking_timestamp` of these "ghost bookings."

**Expected Output:**

| session_id | user_id | booking_timestamp   |
| ---------- | ------- | ------------------- |
| sess_D     | 104     | 2023-11-16 14:00:00 |
| sess_F     | 106     | 2023-11-18 13:05:00 |

**Your Solution:**

```sql
-- Write your solution here
```
