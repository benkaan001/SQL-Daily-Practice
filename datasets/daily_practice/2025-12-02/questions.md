## Puzzle: The "Boomerang" Escalation

**The Scenario:** As a Support Operations Manager, you want to identify inefficient ticket routing. A common inefficiency is the "Boomerang Effect," where a ticket is escalated from Tier 1 to Tier 2, but then quickly sent back down to Tier 1. This suggests the escalation was either premature or the Tier 2 agent rejected it improperly.

**Your Task:** Write a query to find all "Boomerang" incidents. A Boomerang is defined as a sequence of assignments for a single ticket that follows the pattern:  **Tier 1 -> Tier 2 -> Tier 1** .

Conditions for a valid Boomerang:

1. The sequence must be strictly chronological (prev -> current -> next).
2. The total time elapsed from the initial 'Tier 1' assignment to the return 'Tier 1' assignment must be  **less than or equal to 4 hours** .

The final report should show the `ticket_id`, the `escalated_agent_id` (the Tier 2 agent who received it), the `escalation_time` (when it moved to Tier 2), and the `boomerang_duration_minutes` (time from initial T1 assignment to return T1 assignment).

| **ticket_id** | **escalated_agent_id** | **escalation_time** | **boomerang_duration_minutes** |
| ------------------- | ---------------------------- | ------------------------- | ------------------------------------ |
| 101                 | 201                          | 2023-12-01 09:30:00.000   | 75.00                                |
| 104                 | 201                          | 2023-12-02 14:10:00.000   | 20.00                                |

### Tips for Approaching the Problem

1. **Analyze the "Middle" State:** The easiest way to solve 3-step sequence problems is to focus on the middle event. In this case, look for rows where `assigned_tier` is  **'Tier 2'** .
2. **Look Back and Look Ahead:** For every 'Tier 2' event, use window functions to see what happened immediately before and immediately after.
   * `LAG(assigned_tier) ...` to get the previous tier.
   * `LEAD(assigned_tier) ...` to get the next tier.
   * `LAG(change_timestamp) ...` to get the timestamp of the *previous* event (the start of the sequence).
   * `LEAD(change_timestamp) ...` to get the timestamp of the *next* event (the end of the sequence).
3. **Partition and Order:** Ensure your window functions are `PARTITIONED BY ticket_id` and `ORDERED BY change_timestamp`.
4. **Construct a CTE:** Create a CTE that selects the current row's details along with the four calculated window columns (prev tier, next tier, prev time, next time).
5. **Filter for the Pattern:** In your final `SELECT` statement:
   * Filter for rows where the *current* tier is 'Tier 2'.
   * Check that *prev* tier is 'Tier 1' AND *next* tier is 'Tier 1'.
   * Check that `TIMESTAMPDIFF(MINUTE, prev_time, next_time)` is <= 240 (4 hours).

**Your Solution:**

```sql
-- Write your solution here
```
