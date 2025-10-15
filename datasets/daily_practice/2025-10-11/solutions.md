## Puzzle: The Delay Bottleneck Analysis with JSON

**The Scenario:** As a logistics analyst, you're tasked with identifying which transit hubs are the biggest bottlenecks and, more importantly, *why* shipments are getting delayed. The `details` of each delay are now stored in a JSON field.

**Your Task:** Write a query to find the root cause of shipment delays. For every `DELAYED` shipment, you must:

1. Identify the location of the *most recent* `IN_TRANSIT` event that occurred *before* the delay.
2. Extract the `reason` for the delay from the JSON `details` field.

Finally, aggregate this data to count how many shipments were delayed for each reason at each of these "bottleneck" locations. The report should show the `bottleneck_location`, the `delay_reason`, and the `total_delayed_shipments`, ordered by the count in descending order.

| **bottleneck_location** | **delay_reason** | **total_delayed_shipments** |
| ----------------------------- | ---------------------- | --------------------------------- |
| Chicago, IL                   | Weather conditions     | 1                                 |
| Chicago, IL                   | High volume            | 1                                 |
| Atlanta, GA                   | Weather conditions     | 1                                 |
| Denver, CO                    | Mechanical issue       | 1                                 |

### Tips for Approaching the Problem

1. **Extract JSON Data:** The key new element is extracting data from the `details` column. In MySQL, you can use the function `JSON_EXTRACT(details, '$.reason')` and then unquote the result with `JSON_UNQUOTE()`, or use the shorthand `details->>'$.reason'`. It's best to do this in an initial CTE that filters for `DELAYED` events.
2. **Isolate Event Types:** Create two CTEs: one for all `DELAYED` events (with the `reason` extracted) and another for all `IN_TRANSIT` events.
3. **Connect Delays to Prior Transits:** `JOIN` your `delayed_events` CTE to your `in_transit_events` CTE. The join conditions should be on the same `shipment_id` and the `in_transit_timestamp` must be less than the `delayed_timestamp`.
4. **Find the *****Most Recent***** Transit Event:** The join will connect a delay to *all* of its preceding transit events. You only care about the one that happened immediately before the delay. Use the `ROW_NUMBER()` window function.
   * In a new CTE after the join, partition by the `shipment_id` and `delayed_timestamp`.
   * Order by the `in_transit_timestamp` in `DESC`ending order. This will assign a rank of `1` to the most recent transit event before each delay.
5. **Filter and Aggregate:** In your final `SELECT` statement, query from the CTE where you created the rank.
   * Filter for rows where the rank is `1`.
   * `GROUP BY` the `location` of the transit event and the `delay_reason` you extracted.
   * Use `COUNT(*)` to get the `total_delayed_shipments` for each combination.

**Your Solution:**

```sql
-- Write your solution here
```

