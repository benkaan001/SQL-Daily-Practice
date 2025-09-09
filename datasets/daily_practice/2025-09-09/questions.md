## Puzzle: The Tailgating Detective

**The Scenario:** As a security analyst, you're investigating "tailgating," where an unauthorized person follows someone through a secure door. Your system logs every swipe, granting or denying access. A potential indicator of tailgating is when an `access_granted` swipe is immediately followed by an `access_denied` swipe from a different employee at the same door. The second swipe is denied because the door is already open from the first swipe.

**Your Task:** Write a query to find all potential tailgating events. A tailgating event is defined as a swipe that was `access_denied` for one employee, but it occurred within 5 seconds *after* an `access_granted` swipe from a *different* employee at the exact same `door_id`.

The final report should show the `door_id`, the `authorized_employee_id` and their `grant_timestamp`, and the `tailgating_employee_id` and their `denied_timestamp`.

| **door_id** | **authorized_employee_id** | **grant_timestamp** | **tailgating_employee_id** | **denied_timestamp** |
| ----------------- | -------------------------------- | ------------------------- | -------------------------------- | -------------------------- |
| Server_Room       | 102                              | 2023-12-18 09:15:00.000   | 103                              | 2023-12-18 09:15:02.000    |
| Break_Room        | 104                              | 2023-12-18 12:01:00.000   | 101                              | 2023-12-18 12:01:04.000    |

**Your Solution:**

```
-- Write your solution here

```
