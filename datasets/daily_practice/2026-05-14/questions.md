## Puzzle: The Peak Departmental Census

**The Scenario:** As a data engineer for a hospital network, you are tasked with identifying the "Peak Census" for every department. The "Census" is the number of patients physically present in a department at any given moment. Knowing the peak occupancy is critical for staffing levels and emergency bed planning.

**Your Task:** Write a query to find the maximum number of patients that were simultaneously admitted to each department on  **'2026-05-14'** .

For every department, your report must show:

1. `department`: The name of the department.
2. `peak_patient_count`: The absolute maximum number of concurrent patients.
3. `peak_start_time`: The *first* timestamp during the day when that maximum count was reached.

**Rules:**

* A patient is considered present at the exact moment of `admit_timestamp` and stays until the exact moment of `discharge_timestamp`.
* If a discharge and an admission happen at the exact same time, the admission should be processed first to capture the momentary peak.

**Expected Output:**

| **department** | **peak_patient_count** | **peak_start_time** |
| -------------------- | ---------------------------- | ------------------------- |
| Cardiology           | 4                            | 2026-05-14 11:00:00       |
| Neurology            | 3                            | 2026-05-14 11:30:00       |

### Tips for Approaching the Problem

1. **Unpivot into a Timeline:** The data is currently in ranges (start to end). To find concurrency, you need to turn these into a single chronological stream of "Events."
   * Create a CTE that selects the `admit_timestamp` and assigns a `+1` (patient arriving).
   * `UNION ALL` that with a selection of `discharge_timestamp` and assign a `-1` (patient leaving).
2. **Calculate the Running Total:** Use a window function to calculate the cumulative sum of these `+1` and `-1` values.
   * `PARTITION BY department` and `ORDER BY event_timestamp`.
   * **Tie-breaking:** In your `ORDER BY`, if two timestamps are equal, ensure the `+1` events are processed before `-1` events to accurately reflect the peak count.
3. **Rank and Isolate:** Now that you have the occupancy count at every point in time:
   * Find the maximum count per department.
   * Use `ROW_NUMBER()` or `RANK()` to find the earliest timestamp where that maximum occurred.

**Your Solution:**

```sql
-- Write your solution here
```
