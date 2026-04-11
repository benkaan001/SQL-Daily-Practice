## Puzzle: The InfoSec Compliance Audit (Relational Division)

**The Scenario:** The Information Security (InfoSec) team is running their quarterly compliance audit. They need a report detailing exactly where every employee stands regarding the company's mandatory security training.

**Your Task:** Write a query to calculate the training compliance status for *every* employee.

You must evaluate their progress strictly against the modules where `is_mandatory = TRUE`. Optional modules should not count towards or against their compliance score.

The final report should show the `emp_id`, `emp_name`, the `mandatory_modules_completed` (count), and their `compliance_status`.

**Rules for Compliance Status:**

* `'COMPLIANT'`: The employee has completed all available mandatory modules.
* `'IN PROGRESS'`: The employee has completed at least 1, but not all, mandatory modules.
* `'NOT STARTED'`: The employee has completed 0 mandatory modules.

Order the results alphabetically by `emp_name`.

**Expected Output:**

| **emp_id** | **emp_name** | **mandatory_modules_completed** | **compliance_status** |

| 101 | Alice | 4 | COMPLIANT |

| 102 | Bob | 2 | IN PROGRESS |

| 103 | Charlie | 0 | NOT STARTED |

| 104 | Diana | 4 | COMPLIANT |

| 105 | Evan | 0 | NOT STARTED |

*(Note: Diana and Evan both took optional modules, but it correctly did not affect their mandatory module counts).*

### Tips for Approaching the Problem

1. **Find the Target Number:** First, figure out how many mandatory modules exist in total. You can do this with a simple scalar subquery or CTE: `(SELECT COUNT(*) FROM training_modules WHERE is_mandatory = TRUE)`. This is the "finish line" you need to compare everyone against.
2. **Start with All Employees:** Because Charlie has no training records, and Evan has no *mandatory* training records, an `INNER JOIN` would cause them to disappear from the report entirely! You must start your main query with the `employees` table and `LEFT JOIN` the rest of the data to ensure no one is left behind.
3. **Join and Filter Simultaneously:** You only want to count *mandatory* completions. The best way to do this is to `LEFT JOIN` the `training_completions` table, and then `LEFT JOIN` the `training_modules` table to it, bringing over the `is_mandatory` flag.
   *(Pro-tip: If you put `WHERE is_mandatory = TRUE` at the very end of your query, it will turn your LEFT JOIN into an INNER JOIN and erase Charlie! Instead, handle the filtering inside your conditional aggregation step).*
4. **Conditional Aggregation:** Group by the employee. Use a `SUM(CASE WHEN ...)` statement to count the number of completed modules *only if* the joined module's `is_mandatory` flag is TRUE.
5. **Assign the Status:** Use a `CASE` statement in your `SELECT` clause to compare your calculated count against the "Target Number" from Step 1 to assign the text labels.

**Your Solution:**

```sql
-- Write your solution here
```
