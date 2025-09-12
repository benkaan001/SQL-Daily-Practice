## Puzzle: The Overbooking Resolution

**The Scenario:** You're an analyst for a hotel chain investigating a bug in the booking system that occasionally double-books a room. The front desk staff typically resolves this by contacting one of the guests and moving them to a new room. You need to find all instances where this resolution process occurred.

**Your Task:** Write a query to identify "resolved overbookings." A resolved overbooking is a sequence of events where:

1. A guest's initial booking (`booking_A`) for a specific room has check-in/out dates that overlap with another guest's `CONFIRMED` booking (`booking_B`) for the exact same room.
2. The initial, conflicting booking (`booking_A`) has a `status` of `CANCELLED`.
3. The same guest from `booking_A` creates a new, `CONFIRMED` booking (`booking_C`) for a  *different room* , but for the *exact same check-in and check-out dates* as their cancelled booking.
4. The cancellation of `booking_A` and the creation of the new `booking_C` must occur within 1 hour of each other.

The final report should detail each successfully resolved incident, showing the `guest_id` who was moved, the original `conflicting_room_id`, the `conflicting_booking_id` that was cancelled, the `new_room_id`, and the `new_booking_id` they were moved to.

| guest_id | conflicting_room_id | conflicting_booking_id | new_room_id | new_booking_id |
| -------- | ------------------- | ---------------------- | ----------- | -------------- |
| 502      | 101                 | 102                    | 102         | 103            |
| 506      | 301                 | 107                    | 302         | 108            |

**Your Solution:**

```sql
SELECT
    cancelled_booking.guest_id,
    cancelled_booking.room_id AS conflicting_room_id,
    cancelled_booking.booking_id AS conflicting_booking_id,
    new_booking.room_id AS new_room_id,
    new_booking.booking_id AS new_booking_id
FROM
    hotel_bookings AS cancelled_booking
JOIN
    hotel_bookings AS conflicting_booking ON cancelled_booking.room_id = conflicting_booking.room_id
    AND cancelled_booking.guest_id != conflicting_booking.guest_id
    AND cancelled_booking.check_in_date < conflicting_booking.check_out_date
    AND cancelled_booking.check_out_date > conflicting_booking.check_in_date
JOIN
    hotel_bookings AS new_booking ON cancelled_booking.guest_id = new_booking.guest_id
WHERE
    -- Rule 1
    cancelled_booking.status = 'CANCELLED'
    -- Rule 2
    AND conflicting_booking.status = 'CONFIRMED'
    -- Rule 3
    AND new_booking.status = 'CONFIRMED'
    AND new_booking.room_id != cancelled_booking.room_id
    AND new_booking.check_in_date = cancelled_booking.check_in_date
    AND new_booking.check_out_date = cancelled_booking.check_out_date
    -- Rule 4
    AND TIMESTAMPDIFF(HOUR, cancelled_booking.booking_timestamp, new_booking.booking_timestamp) <= 1;
```
