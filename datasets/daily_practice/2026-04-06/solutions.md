## Puzzle: The Hotel Availability Search (Anti-Joins)

**The Scenario:** A potential guest wants to book a room for a spring getaway. They want to check in on **April 15th, 2026** and check out on  **April 18th, 2026** . The booking engine needs to query the database to show them exactly which rooms are free for those specific dates.

**Your Task:** Write a query to return a list of all rooms that are available for a stay from `check_in_date = '2026-04-15'` to `check_out_date = '2026-04-18'`.

**Rules for Availability:**

1. Guests only sleep in the room on the nights *between* check-in and check-out. (In this case, the nights of the 15th, 16th, and 17th).
2. It is perfectly acceptable for the new guest to check in on the exact same day a previous guest checks out.
3. It is perfectly acceptable for the new guest to check out on the exact same day a future guest checks in.

The final report should show the `room_id`, `room_type`, and `nightly_rate` of the available rooms. Order the results by `room_id`.

**Expected Output:**

| **room_id** | **room_type** | **nightly_rate** |

| 101 | Standard | 100.00 |

| 105 | Suite | 250.00 |

*(Note: Room 101 is available because Alice leaves on the 15th, freeing it up for the new guest. The new guest leaves on the 18th, just in time for Bob to check in!)*

### Tips for Approaching the Problem

1. **Think Inversely (The "Anti-Join"):** It is actually much harder to write logic that proves a room *is* available. It is much easier to find the rooms that are  **UNAVAILABLE** , and then simply exclude them from a master list of all rooms!
2. **The Universal Overlap Formula:** Two date ranges overlap if and only if: `(Start_A < End_B) AND (End_A > Start_B)`.
   * Apply this to our requested dates (A) and the existing reservation dates (B).
   * `Requested_Check_In < Existing_Check_Out AND Requested_Check_Out > Existing_Check_In`.
3. **Put it Together:** * Create a subquery that `SELECT`s the `room_id` from the `reservations` table where the overlapping condition is met (using the requested dates of '2026-04-15' and '2026-04-18').
   * In your main query, select from the `rooms` table `WHERE room_id NOT IN (...)` using the subquery you just built.

**Your Solution:**

```sql
-- Write your solution here
```

