## Puzzle: The Orphaned Room Revenue Loss

**The Scenario:** As a revenue manager for a hotel chain, you need to identify "orphaned room nights." An orphan occurs when a booking is `CANCELLED`, and the same `room_id` is *not* successfully re-booked by a *new* reservation starting within 24 hours of the *original* (cancelled) `check_in_date`. Identifying these helps quantify potential revenue loss.

**Your Task:** Write a query to find all `booking_id`s that were `CANCELLED` and resulted in an orphaned room night. The report should show the `booking_id` of the cancelled reservation, the `room_id`, and its `original_check_in_date`.

| **cancelled_booking_id** | **room_id** | **original_check_in_date** |
| ------------------------------ | ----------------- | -------------------------------- |
| 105                            | 40                | 2024-01-10                       |

### Tips for Approaching the Problem

1. **Identify Original Bookings:** The first step is to get the original details for all bookings. Create a CTE (`original_bookings`) that selects `booking_id`, `room_id`, and `check_in_date` for all `event_type = 'CREATED'` events.
2. **Isolate Cancellations:** Create a second CTE (`cancelled_bookings`) that selects the `booking_id` and `event_timestamp` for all `event_type = 'CANCELLED'` events.
3. **Create a List of "Lost" Bookings:** `JOIN` your `original_bookings` CTE with your `cancelled_bookings` CTE on `booking_id`. This gives you a clean list of all cancelled bookings, their `room_id`, and their `original_check_in_date`.
4. **Find Re-Bookings:** The key is to check if a "rescuing" booking exists. Use your `original_bookings` CTE again (aliased as `re_bookings`). `LEFT JOIN` your "lost bookings" (from step 3) to `re_bookings` (from step 1).
5. **Define the `LEFT JOIN` Conditions:** The join conditions must find a valid "rescue":
   * `ON lost.room_id = re_bookings.room_id` (Same room)
   * `AND lost.booking_id != re_bookings.booking_id` (Must be a *different* booking)
   * `AND re_bookings.check_in_date >= lost.original_check_in_date` (Re-booking starts on or after)
   * `AND re_bookings.check_in_date <= TIMESTAMPADD(HOUR, 24, lost.original_check_in_date)` (Re-booking starts within 24 hours of the original check-in)
6. **Final Filtering:** In your final `SELECT`, filter for rows where the `re_bookings.booking_id` is `NULL`. This means no "rescuing" booking was found, and the room was orphaned.

**Your Solution:**

```sql
-- Write your solution here
```
