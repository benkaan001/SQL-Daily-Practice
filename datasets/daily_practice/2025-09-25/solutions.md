## Puzzle: The Loan Application Funnel - Time in Stage Analysis

**The Scenario:** As a business analyst for a fintech company, you need to understand the bottlenecks in your loan application process. To do this, you must calculate how much time each application spends in each stage of its lifecycle.

**Your Task:** Write a query that transforms the event log into a "time-in-stage" report. For each `application_id`, the report must show each `stage` it went through, the `start_time` of that stage, the `end_time` of that stage, and the `duration_in_hours` (rounded to two decimal places).

The `end_time` for a stage is the `start_time` of the next stage. The final stage for any application will not have an `end_time` (it should be `NULL`).

| **application_id** | **stage**           | **start_time**    | **end_time**      | **duration_in_hours** |
| ------------------------ | ------------------------- | ----------------------- | ----------------------- | --------------------------- |
| A-101                    | SUBMITTED                 | 2023-11-01 10:00:00.000 | 2023-11-01 11:30:00.000 | 1.50                        |
| A-101                    | UNDERWRITING_STARTED      | 2023-11-01 11:30:00.000 | 2023-11-02 14:00:00.000 | 26.50                       |
| A-101                    | APPROVED                  | 2023-11-02 14:00:00.000 | 2023-11-03 09:00:00.000 | 19.00                       |
| A-101                    | FUNDS_DISBURSED           | 2023-11-03 09:00:00.000 | NULL                    | NULL                        |
| B-202                    | SUBMITTED                 | 2023-11-05 09:00:00.000 | 2023-11-05 09:30:00.000 | 0.50                        |
| B-202                    | UNDERWRITING_STARTED      | 2023-11-05 09:30:00.000 | 2023-11-06 15:00:00.000 | 29.50                       |
| B-202                    | ADDITIONAL_DOCS_REQUESTED | 2023-11-06 15:00:00.000 | 2023-11-08 11:00:00.000 | 44.00                       |
| B-202                    | ADDITIONAL_DOCS_RECEIVED  | 2023-11-08 11:00:00.000 | 2023-11-08 16:00:00.000 | 5.00                        |
| B-202                    | APPROVED                  | 2023-11-08 16:00:00.000 | 2023-11-09 10:00:00.000 | 18.00                       |
| B-202                    | FUNDS_DISBURSED           | 2023-11-09 10:00:00.000 | NULL                    | NULL                        |
| C-303                    | SUBMITTED                 | 2023-11-10 14:00:00.000 | 2023-11-10 14:15:00.000 | 0.25                        |
| C-303                    | UNDERWRITING_STARTED      | 2023-11-10 14:15:00.000 | 2023-11-11 16:00:00.000 | 25.75                       |
| C-303                    | REJECTED                  | 2023-11-11 16:00:00.000 | NULL                    | NULL                        |
| D-404                    | SUBMITTED                 | 2023-11-12 11:00:00.000 | 2023-11-12 11:10:00.000 | 0.17                        |
| D-404                    | UNDERWRITING_STARTED      | 2023-11-12 11:10:00.000 | NULL                    | NULL                        |

### Tips for Approaching the Problem

1. **Find the Next Event:** The key to this problem is converting the event log into a series of states with start and end times. For any given event, its `end_time` is the timestamp of the *next* event for the same application. The `LEAD()` window function is the perfect tool for this.
2. **Partition and Order Correctly:** When using `LEAD()`, you must tell it how to group and order the data.
   * You want to look at each application's history separately, so you need to `PARTITION BY application_id`.
   * The events must be in chronological order, so you must `ORDER BY event_timestamp`.
3. **Calculate the Duration:** Once you have the `start_time` (the `event_timestamp` of the current row) and the `end_time` (the result of your `LEAD()` function), you can calculate the duration. A function like `TIMESTAMPDIFF(SECOND, start_time, end_time) / 3600.0` will give you the difference in hours as a decimal.
4. **Structure with a CTE:** It's cleanest to perform the `LEAD()` calculation inside a Common Table Expression (CTE). Then, your final `SELECT` statement can query from that CTE to calculate the duration and format the output.

**Your Solution:**

```sql
WITH ordered_applications AS (
	SELECT
		application_id,
		event_timestamp,
		event_type,
		LEAD(event_timestamp, 1) OVER (PARTITION BY application_id ORDER BY event_timestamp) AS next_event_timestamp
	FROM
		loan_applications
)
SELECT
	application_id,
	event_type,
	event_timestamp AS start_time,
	next_event_timestamp AS end_time,
	ROUND(TIMESTAMPDIFF(MINUTE, event_timestamp, next_event_timestamp) / 60.0, 2) AS duration_in_hours
FROM
	ordered_applications;
```
