## Puzzle: May the 4th Exact Set Matching

**The Scenario:** General Rieekan needs to reorganize the Rebel fleet. He wants to find all rebel bases that have the *exact same* defensive capabilities as "Echo Base" on Hoth, so they can share standardized training manuals.

**Your Task:** Write a query to find any base that has the **exact same set** of `defense_system` records as 'Echo Base'.

* It cannot have fewer defenses (a subset).
* It cannot have extra defenses (a superset).
* It must be an exact 1-to-1 match of defense types.

Exclude 'Echo Base' itself from the final results. The report should show the `base_name` and the `defense_count`.

**Expected Output:**

| **base_name** | **defense_count** |

| Dantooine Enclave | 4 |

### Tips for Approaching the Problem

This is a classic "Exact Relational Division" problem. There are two brilliant ways to solve this in SQL: the `HAVING COUNT` trick, or the `GROUP_CONCAT` trick (if you are using MySQL).

**Approach 1: The `HAVING COUNT` Trick (Standard ANSI SQL)**

1. **Define the Target:** Create a CTE that lists the defenses of 'Echo Base' and another CTE to count exactly how many defenses Echo Base has (which is 4).
2. **Aggregate the Others:** Query the other bases and `GROUP BY base_name`.
3. **The Triple Check:** In your `HAVING` clause, you need to verify two things to guarantee an exact match:
   * `COUNT(*)` must equal the target count (4). This ensures it's not a subset.
   * `SUM(CASE WHEN defense_system IN (target_defenses) THEN 1 ELSE 0 END)` must ALSO equal the target count. This ensures that every defense counted actually belongs to the target list, preventing supersets or completely different sets of the same size.

**Approach 2: The `GROUP_CONCAT` Trick (MySQL Specific)**

1. In MySQL, you can use `GROUP_CONCAT(defense_system ORDER BY defense_system)` grouped by base. This turns the multiple rows of defenses into a single, alphabetically sorted, comma-separated string (e.g., "Deflector Shield,Ion Cannon,Snowspeeders,Turbolaser Battery").
2. Simply generate this string for Echo Base in a CTE, generate it for all other bases in your main query, and join/filter where the two strings are exactly identical!

**Your Solution:**

```sql
-- Write your solution here
```

