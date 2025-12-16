## Puzzle: The Support Ticket Ping-Pong

**The Scenario:** A ticket "Ping-Pong" occurs when a ticket bounces back and forth between the agent (`OPEN`) and the customer (`PENDING_CUSTOMER`) multiple times without being resolved. This indicates a difficult issue or poor communication.

**Your Task:** Identify tickets that have switched from `OPEN` to `PENDING_CUSTOMER`  **3 or more times** .

The report should list the `ticket_id` and the `ping_pong_count` (the number of times it transitioned from Open to Pending).

| **ticket_id** | **ping_pong_count** |
| ------------------- | ------------------------- |
| 102                 | 3                         |

### Tips for Approaching the Problem

1. **Identify Transitions:** You need to count specific state transitions. Use `LEAD()` to see the *next* status for each row.
2. **Filter Specific Pattern:** Filter the results to find rows where `current_status = 'OPEN'` and `next_status = 'PENDING_CUSTOMER'`.
3. **Count and Filter:** Group by `ticket_id` and count these specific transitions. Keep tickets where the count is `>= 3`.

**Your Solution:**

```sql
-- Write your solution here
```
