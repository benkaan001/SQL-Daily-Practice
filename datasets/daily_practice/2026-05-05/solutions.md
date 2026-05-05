## Puzzle: The Recursive Bill of Materials (BOM) Explosion

**The Scenario:** A bicycle manufacturing company uses a multi-level Bill of Materials (BOM). A finished bicycle is made of sub-assemblies (like wheels) and raw materials (like frames). Those sub-assemblies are, in turn, made of further raw materials (like spokes, rims, and tires).

The finance team needs to know the total manufacturing cost of the finished products. The cost of an assembly is strictly the sum of all its underlying raw materials, scaled by the quantities required.

**Your Task:** Write a query to calculate the exact `total_cost` to manufacture every "top-level" product. A top-level product is an `ASSEMBLY` that is *never* used as a component inside another product (i.e., its `part_id` does not exist in the `child_part_id` column of the BOM table).

The final report should show the `top_level_product` name and the calculated `total_cost`. Order the results alphabetically by product name.

**Expected Output:**

| **top_level_product** | **total_cost** |

| Mountain Bike | 504.00 |

| Road Bike | 770.00 |

*(Math check for Mountain Bike: 1 Frame ($200) + 1 Gears ($80) + 1 Handlebar ($30) + 2 Wheels. Each wheel is 1 Tire ($25) + 1 Rim ($40) + 32 Spokes ($32) = $97. Total = 310 + 2 * 97 = $504).*

### Tips for Approaching the Problem

This requires "walking the tree" from top to bottom using a `WITH RECURSIVE` CTE!

1. **The Anchor Member:** Start your recursive CTE by selecting the "top-level" assemblies. You can find these by selecting `parent_part_id`s from the `bill_of_materials` table that do *not* appear in the `child_part_id` column. Select the top-level ID, the top-level name, the immediate `child_part_id`, and its `quantity`.
2. **The Recursive Member:** `UNION ALL` your anchor to the recursive step. `JOIN` the CTE itself to the `bill_of_materials` table, linking the CTE's `child_part_id` to the BOM's `parent_part_id`.
3. **Cumulative Quantities (The Trick!):** As you walk down the tree, you must multiply the quantities! If a bike needs 2 wheels, and a wheel needs 32 spokes, the bike needs `2 * 32 = 64` spokes. In your recursive `SELECT`, calculate `cte.cumulative_quantity * bom.quantity`.
4. **Aggregate the Raw Materials:** Your recursive CTE will generate a flat list of every single component attached to a top-level product. In your final `SELECT` statement outside the CTE, `JOIN` this generated list back to the `parts` table using the `child_part_id`.
5. **Filter and Sum:** Apply a `WHERE` clause to filter for *only* rows where `part_type = 'RAW_MATERIAL'`. (This naturally filters out intermediate sub-assemblies like wheels from your math). Finally, `GROUP BY` the top-level product name and `SUM(cumulative_qty * cost)`.

**Your Solution:**

```sql
-- Write your solution here
```

