## Puzzle: The First Response SLA

**The Scenario:** Customer support has a Service Level Agreement (SLA) to respond to new tickets within  **30 minutes** . You need to calculate the "First Response Time" for every ticket and flag those that breached the SLA.

**Your Task:** For each ticket, find the time difference between the *first* message sent by a `CUSTOMER` and the *first* subsequent message sent by an `AGENT`.

The report should show `ticket_id`, `customer_first_msg`, `agent_first_response`, `minutes_to_respond`, and an `sla_status` ('PASS' or 'FAIL').

| **ticket_id** | **customer_first_msg** | **agent_first_response** | **minutes_to_respond** | **sla_status** |
| ------------------- | ---------------------------- | ------------------------------ | ---------------------------- | -------------------- |
| 1                   | 2023-12-09 09:00:00          | 2023-12-09 09:15:00            | 15                           | PASS                 |
| 2                   | 2023-12-09 10:00:00          | 2023-12-09 12:00:00            | 120                          | FAIL                 |
| 3                   | 2023-12-09 14:00:00          | 2023-12-09 14:10:00            | 10                           | PASS                 |

### Tips for Approaching the Problem

1. **Find Firsts:** Create two CTEs: `first_customer_msg` (MIN timestamp per ticket where sender is CUSTOMER) and `first_agent_msg` (MIN timestamp per ticket where sender is AGENT).
2. **Join:** Join them on `ticket_id`.
3. **Calculate:** `TIMESTAMPDIFF` for minutes, `CASE` for SLA status.

**Your Solution:**

```sql
-- Write your solution here
```
