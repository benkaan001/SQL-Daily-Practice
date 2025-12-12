## Puzzle: The Double-Booking Audit

**The Scenario:** The scheduling system crashed, and manual entries resulted in some employees being scheduled for two different roles at the same time. This creates "ghost shifts" where no one shows up.

**Your Task:** Write a query to identify any employee who has overlapping shifts. An overlap occurs if the start of one shift is strictly before the end of another shift, and the end of that shift is strictly after the start of the other.

The report should show the `employee_id`, `shift1_start`, `shift1_end`, `shift2_start`, and `shift2_end` for the conflicting pair.

| **employee_id** | **shift1_start** | **shift1_end** | **shift2_start** | **shift2_end** |
| --------------------- | ---------------------- | -------------------- | ---------------------- | -------------------- |
| 102                   | 2023-12-07 09:00:00    | 2023-12-07 14:00:00  | 2023-12-07 13:00:00    | 2023-12-07 17:00:00  |

### Tips for Approaching the Problem

1. **Self-Join:** Join the table to itself (`s1` and `s2`) on `employee_id`.
2. **Avoid Duplicates:** Ensure `s1.assignment_id < s2.assignment_id` to avoid comparing a shift to itself or listing the same pair twice.
3. **Overlap Logic:** The condition for overlap is `s1.shift_start < s2.shift_end AND s1.shift_end > s2.shift_start`.

**Your Solution:**

```sql
-- Write your solution here
```
