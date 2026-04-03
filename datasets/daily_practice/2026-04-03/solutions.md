## Puzzle: The Dynamic Pricing Calculator

**The Scenario:** A boutique hotel uses a dynamic pricing engine, meaning the cost of a room changes daily based on demand and seasonality. A guest's total bill is calculated by summing the specific `nightly_rate` for every single night they sleep in the room.

**Your Task:** Write a query to calculate the `total_cost` for each reservation.

*The Catch:* Guests are charged for the nights they sleep in the room. They are **not** charged for their `check_out` date, because they leave that morning!

The final report should show the `res_id`, `guest_name`, `room_type`, `check_in`, `check_out`, and the calculated `total_cost`. Order the results by `res_id`.

**Expected Output:**

| **res_id** | **guest_name** | **room_type** | **check_in** | **check_out** | **total_cost** |
| ---------------- | -------------------- | ------------------- | ------------------ | ------------------- | -------------------- |
| 1                | Alice Smith          | Standard            | 2026-04-02         | 2026-04-04          | 200.00               |
| 2                | Bob Johnson          | Standard            | 2026-04-03         | 2026-04-06          | 400.00               |
| 3                | Charlie Davis        | Suite               | 2026-04-04         | 2026-04-05          | 350.00               |
| 4                | Diana Prince         | Suite               | 2026-04-01         | 2026-04-08          | 1950.00              |

### Tips for Approaching the Problem

1. **The Non-Equi Join:** You don't always have to join tables using an equals sign (`=`). You can join a single row in the `reservations` table to *multiple* rows in the `room_rates` table by using a date range in your `ON` clause!
2. **Join Conditions:** * First, ensure you are joining on the matching `room_type`.
   * Second, ensure the `rate_date` from the pricing table is greater than or equal to (`>=`) the `check_in` date.
   * Third, ensure the `rate_date` is strictly less than (`<`) the `check_out` date to ensure they aren't billed for the morning they leave.
3. **Aggregate:** Because your join caused each reservation to multiply into several rows (one for each night of their stay), you now need to group the data back together. `GROUP BY` the reservation details and `SUM()` the `nightly_rate` to get the final bill.

**Your Solution:**

```sql
SELECT
	r.res_id, 
	r.guest_name, 
	r.room_type, 
	r.check_in, 
	r.check_out,
	SUM(rr.nightly_rate) AS total_cost 
FROM
	reservations r 
JOIN
	room_rates rr ON r.room_type = rr.room_type 
	AND rr.rate_date >= r.check_in 
	AND rr.rate_date < r.check_out
GROUP BY
	r.res_id,
	r.guest_name, 
	r.room_type,
	r.check_in,
	r.check_out
ORDER BY
	r.res_id;
```
```sql
-- Alternative solution using recursive approach 
WITH RECURSIVE stay_dates AS (
    (
	SELECT 
        res_id,
        guest_name,
        room_type,
        check_in,
        check_out,
        check_in AS billable_date
    FROM
        reservations
	)
    UNION ALL 
    (
	-- must add 1 day to the billable date, continuing until the day before checkout
	SELECT
        res_id,
        guest_name,
        room_type,
        check_in,
        check_out,
        DATE_ADD(billable_date, INTERVAL 1 DAY)
    FROM
        stay_dates  
    WHERE
        -- stop generating dates before the checkout date is reached
        DATE_ADD(billable_date, INTERVAL 1 DAY) < check_out 
	)
)
SELECT 
    sd.res_id,
    sd.guest_name,
    sd.room_type,
    sd.check_in,
    sd.check_out,
    SUM(rr.nightly_rate) AS total_cost
FROM 
    stay_dates sd
JOIN 
    room_rates rr ON sd.room_type = rr.room_type 
	AND sd.billable_date = rr.rate_date
GROUP BY 
    sd.res_id,
    sd.guest_name,
    sd.room_type,
    sd.check_in,
    sd.check_out
ORDER BY 
    sd.res_id;
```