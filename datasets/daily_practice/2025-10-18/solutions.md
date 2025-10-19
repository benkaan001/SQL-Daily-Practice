## Puzzle: The Conflicting Feature Flag Audit

**The Scenario:** As a platform engineer, you need to ensure the feature flag system is configured correctly. A critical issue is "conflicting rules," where a feature is broadly enabled for a user segment but simultaneously disabled for a more specific sub-segment, leading to unpredictable behavior for users.

**Your Task:** Write a query to find all currently active feature flags that are in a conflicting state. A conflict is defined as:

1. A feature is `ENABLED` for a broad segment (e.g., for `ALL` countries, where `country IS NULL`).
2. The same feature is also `DISABLED` for a more specific sub-segment that falls within that broad segment (e.g., for a specific country like 'CA').
3. Both the `ENABLED` and `DISABLED` rules must be the *most recent* rules for their respective segments.

The report should show the `feature_name`, the `conflicting_segment` (e.g., 'country'), and the specific `conflicting_value` (e.g., 'CA') that is disabled.

| **feature_name** | **conflicting_segment** | **conflicting_value** |
| ---------------------- | ----------------------------- | --------------------------- |
| new_profile_page       | country                       | CA                          |
| new_chat               | device_type                   | android                     |

### Tips for Approaching the Problem

1. **Find the Latest Rule for Each Segment:** The first step is to find the most recent status for each unique feature/segment combination. A segment is defined by the combination of `country` and `device_type`. Use a window function like `ROW_NUMBER() OVER (PARTITION BY feature_name, country, device_type ORDER BY log_timestamp DESC)` to identify the latest rule for each segment.
2. **Separate Enabled and Disabled Rules:** In a CTE, select only the most recent rules (where your row number is 1). It's helpful to create two separate CTEs from this result: one for all active `ENABLED` rules and one for all active `DISABLED` rules.
3. **Use a Self-Join to Find Conflicts:** `JOIN` the `enabled_rules` CTE to the `disabled_rules` CTE on `feature_name`. This will pair every active enabled rule with every active disabled rule for the same feature.
4. **Define the Conflict Logic:** The core of the puzzle is in the `JOIN` and `WHERE` conditions. A conflict exists if an enabled rule's segment is a "parent" of a disabled rule's segment. For example:
   * `enabled_rule.country IS NULL` (applies to all countries) AND `disabled_rule.country IS NOT NULL` (a specific country).
   * OR `enabled_rule.device_type IS NULL` AND `disabled_rule.device_type IS NOT NULL`.
   * You must also ensure that the non-conflicting segments match (e.g., if checking for a country conflict, the `device_type`s should match, or one should be NULL).

**Your Solution:**

```sql
WITH ranked_status AS (
    SELECT
        feature_name,
        status,
        country,
        device_type,
        ROW_NUMBER() OVER (PARTITION BY feature_name, country, device_type ORDER BY log_timestamp DESC) AS rn
    FROM
        feature_flags
),
enabled_rules AS (
    SELECT
    	feature_name,
    	country,
    	device_type
    FROM
    	ranked_status
    WHERE
    	rn = 1
    	AND status = 'ENABLED'
),
disabled_rules AS (
    SELECT
    	feature_name,
    	country,
    	device_type
    FROM
    	ranked_status
    WHERE
    	rn = 1
    	AND status = 'DISABLED'
)
SELECT
    er.feature_name,
    CASE
        WHEN er.country IS NULL AND dr.country IS NOT NULL THEN 'country'
        WHEN er.device_type IS NULL AND dr.device_type IS NOT NULL THEN 'device_type'
    END AS conflicting_segment,
    CASE
        WHEN er.country IS NULL AND dr.country IS NOT NULL THEN dr.country
        WHEN er.device_type IS NULL AND dr.device_type IS NOT NULL THEN dr.device_type
    END AS conflicting_value
FROM
    enabled_rules er
JOIN
    disabled_rules dr ON er.feature_name = dr.feature_name
WHERE
    (
        er.country IS NULL AND dr.country IS NOT NULL AND
        (er.device_type = dr.device_type OR er.device_type IS NULL)
    )
    OR
    (
        er.device_type IS NULL AND dr.device_type IS NOT NULL AND
        (er.country = dr.country OR er.country IS NULL)
    );
```
