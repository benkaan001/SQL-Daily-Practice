## Puzzle: The Cargo Load Balancer

**The Scenario:** As a logistics planner for an air freight company, you are responsible for ensuring planes are safely loaded. Each flight has a strict maximum weight capacity. Cargo items are brought out to the tarmac and loaded sequentially based on their `boarding_priority`.

If adding the next item in the queue would cause the flight to exceed its weight capacity, that item and all items behind it are left on the tarmac.

**Your Task:** Write a query to identify the *last* item that can safely be loaded onto each flight.

The report should show the `flight_id`, the flight's `max_weight_kg`, the `last_item_loaded`, and the `total_loaded_weight` (the cumulative weight of the plane after that final item is boarded). Order the results by `flight_id`.

**Expected Output:**

| **flight_id** | **max_weight_kg** | **last_item_loaded** | **total_loaded_weight** |
| ------------------- | ----------------------- | -------------------------- | ----------------------------- |
| FL-001              | 1000                    | Medical Supplies           | 900                           |
| FL-002              | 1500                    | Auto Parts                 | 1500                          |
| FL-003              | 800                     | Machine Tools              | 700                           |

### Tips for Approaching the Problem

1. **Calculate the Running Total:** You need to know the total weight of the plane  *as each item is loaded* . Use the `SUM()` window function on the `weight_kg` column. You must `PARTITION BY flight_id` and, crucially, `ORDER BY boarding_priority` so the sum accumulates in the exact order the items are loaded.
2. **Join the Capacity:** In a Common Table Expression (CTE), combine your running total calculation with a `JOIN` to the `flights` table. This allows you to compare the running cumulative weight against the `max_weight_kg` on the same row.
3. **Filter the Fits:** Query from your CTE and use a `WHERE` clause to filter out any items where the `cumulative_weight` strictly exceeds the `max_weight_kg`. Now you have a list of *only* the items that successfully made it onto the plane!
4. **Find the Last Item:** To isolate the final item loaded, you need to find the item with the highest `boarding_priority` among the items that fit. You can do this by wrapping step 3 in another CTE and adding a `ROW_NUMBER() OVER (PARTITION BY flight_id ORDER BY boarding_priority DESC)` window function.
5. **Final Selection:** Finally, select the rows where your new row number is `1`.

**Your Solution:**

```sql
WITH cumulative_cargo AS (
    SELECT 
        cm.manifest_id, 
        cm.flight_id, 
        cm.boarding_priority, 
        cm.item_name, 
        cm.weight_kg, 
        f.max_weight_kg,
        SUM(cm.weight_kg) OVER (PARTITION BY cm.flight_id ORDER BY cm.boarding_priority) AS cumulative_weight
    FROM
        cargo_manifest cm 
    JOIN 
        flights f ON cm.flight_id = f.flight_id 
), 
weight_sequences AS (
    SELECT 
        manifest_id, flight_id, boarding_priority, item_name, weight_kg, max_weight_kg, cumulative_weight,
        LEAD(cumulative_weight, 1) OVER (PARTITION BY flight_id ORDER BY boarding_priority) AS next_cumulative_weight
    FROM    
        cumulative_cargo 
)
SELECT 
    flight_id, 
    max_weight_kg,
    item_name AS last_item_loaded,
    cumulative_weight AS total_loaded_weight
FROM
    weight_sequences 
WHERE
    cumulative_weight <= max_weight_kg 
    -- make sure next item breaks capacity OR there are no more items (NULL)
    AND (next_cumulative_weight > max_weight_kg OR next_cumulative_weight IS NULL)
ORDER BY
    flight_id;
