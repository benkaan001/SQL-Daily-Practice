## Question 1: Average Mileage for Unspecified Business Rides

You're given a table of Uber rides. Find the average mileage of 'Business' category rides where the 'purpose' is not specified (i.e., it is NULL).

Round the average mileage to one decimal place.

**Expected Output:**

| **avg_mileage_null_purpose** |
| ---------------------------------- |
| 6.1                                |

**Your Solution:**

```sql
-- Write your solution here

```

## Question 2: Busiest Day for Meetings

For all rides with the purpose 'Meeting', determine which day of the week (e.g., Monday, Tuesday, Sunday) had the highest number of such rides.

Output the day_name and the count_of_meetings. If there's a tie for the highest count, output all tied days.

**Expected Output:**

| **day_name** | **count_of_meetings** |
| ------------------ | --------------------------- |
| Sunday             | 8                           |

**Your Solution:**

```sql
-- Write your solution here

```

## Question 3: Long Duration Business "Round Trips"

Identify 'Business' category rides that started and stopped at the same location and had a travel duration of more than 10 minutes.

List the start_location, stop_location, miles, and duration_minutes (calculated as the difference between end_date and start_date in minutes).

Order the results by duration_minutes in descending order, then by start_date in ascending order.

**Expected Output:**

| start_location   | stop_location    | miles | duration_minutes |
| ---------------- | ---------------- | ----- | ---------------- |
| Houston          | Houston          | 21.9  | 36               |
| Unknown Location | Unknown Location | 4.8   | 34               |
| Unknown Location | Unknown Location | 7.6   | 29               |
| Cary             | Cary             | 7.7   | 19               |
| Kar?chi          | Kar?chi          | 4.1   | 15               |
| Fort Pierce      | Fort Pierce      | 4.7   | 14               |
| Cary             | Cary             | 4.6   | 14               |
| Fort Pierce      | Fort Pierce      | 4.8   | 13               |
| Fort Pierce      | Fort Pierce      | 5.0   | 12               |
| Cary             | Cary             | 4.8   | 11               |
| Cary             | Cary             | 5.2   | 11               |

**Your Solution:**

```sql
-- Write your solution here

```

