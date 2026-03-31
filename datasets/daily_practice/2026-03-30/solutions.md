## Puzzle: The Consecutive Seating Finder

**The Scenario:** A local cinema is upgrading its online ticketing system. They want to implement a feature that automatically suggests groups of seats for larger families. You have been tasked with writing the backend query that powers this feature.

**Your Task:** Write a query to find all continuous blocks of **3 or more** `AVAILABLE` seats in the same row.

The final report should output the `row_letter`, the `start_seat` (the lowest seat number in the block), the `end_seat` (the highest seat number in the block), and the total `consecutive_seats` in that block.

Order the results alphabetically by `row_letter`, and then numerically by `start_seat`.

**Expected Output:**

| **row_letter** | **start_seat** | **end_seat** | **consecutive_seats** |
| -------------------- | -------------------- | ------------------ | --------------------------- |
| A                    | 2                    | 4                  | 3                           |
| B                    | 4                    | 6                  | 3                           |
| D                    | 1                    | 4                  | 4                           |
| D                    | 6                    | 8                  | 3                           |

### Tips for Approaching the Problem

This is a pristine example of the "Gaps and Islands" problem, and because the `seat_number` is a sequential integer, there is a very elegant mathematical trick to solve it!

1. **Filter for Availability:** Start by creating a Common Table Expression (CTE) that filters the table down to ONLY the seats where `status = 'AVAILABLE'`.
2. **The "Sequential Difference" Trick:** In your CTE, add a `ROW_NUMBER() OVER (PARTITION BY row_letter ORDER BY seat_number)` window function.
3. **Generate a Group ID:** Here is the magic: subtract the `ROW_NUMBER` you just calculated from the `seat_number`.
   * If you have seats 4, 5, and 6, their row numbers will be 1, 2, and 3.
   * (4 - 1 =  **3** ), (5 - 2 =  **3** ), (6 - 3 =  **3** ).
   * As long as the seats are perfectly sequential, that mathematical difference will be a constant number! The moment a seat is booked (skipping a number), the difference changes, creating a brand new, unique "Group ID" for the next island of seats.
4. **Aggregate the Islands:** In your final query, `GROUP BY` the `row_letter` and your calculated `group_id`.
5. **Final Filtering:** Use `MIN(seat_number)` and `MAX(seat_number)` to find the boundaries of the block, `COUNT(*)` to find the length, and a `HAVING` clause to ensure you only return blocks where the count is `>= 3`.

**Your Solution:**

```sql
WITH available_seats AS (
	SELECT
		row_letter, 
		seat_number, 
		ROW_NUMBER() OVER (PARTITION BY row_letter ORDER BY seat_number) AS rn
	FROM
		cinema_seats
	WHERE
		status <> 'BOOKED'
),
sequential_groups AS (
	SELECT
		row_letter, 
		seat_number, 
		seat_number - rn AS group_id
	FROM
		available_seats 
)
SELECT
	row_letter, 
	MIN(seat_number) AS seat_start,
	MAX(seat_number) AS seat_end, 
	COUNT(seat_number) AS consecutive_seats
FROM
	sequential_groups 
GROUP BY
	row_letter,
	group_id 
HAVING
	COUNT(seat_number) >= 3
ORDER BY	
	row_letter,
	seat_start;
```
