## Puzzle: The Compliance Audit

**The Scenario:** As a compliance officer, you need to ensure all employees maintain their mandatory certifications. Your task is to audit the entire workforce and flag any certification that is currently **expired** or has an **invalid status** (Revoked, Pending, or Expired).

**Your Task:** Write a query to find all employees whose certifications are non-compliant as of the audit date  **'2024-01-01'** .

1. First, for each employee and `cert_name` combination, identify the *most recent* record.
2. If the `status` of the most recent record is anything other than 'Active', the compliance status is 'INVALID'.
3. If the `status` is 'Active', check the `expiry_date`. If the `expiry_date` is on or before the audit date, the compliance status is 'EXPIRED'.

The final report should show the `employee_id`, the non-compliant `cert_name`, the `latest_status`, and the `compliance_status` ('EXPIRED' or 'INVALID').

| **employee_id** | **cert_name** | **latest_status** | **compliance_status** |
| --------------------- | ------------------- | ----------------------- | --------------------------- |
| 101                   | First Aid (CPR)     | Active                  | EXPIRED                     |
| 102                   | Data Security       | Active                  | EXPIRED                     |
| 103                   | IT Security Lvl 1   | Revoked                 | INVALID                     |
| 105                   | First Aid (CPR)     | Pending                 | INVALID                     |
| 105                   | Safety Protocol     | Pending                 | INVALID                     |

### Tips for Approaching the Problem

1. **Identify Latest Records:** The absolute first step is isolating the latest record for each employee/cert combination. Use `ROW_NUMBER() OVER (PARTITION BY employee_id, cert_name ORDER BY issue_date DESC)` to assign a rank of 1 to the most recent log.
2. **Filter for Latest:** Create a CTE that selects only the rows where the rank is 1. This ensures you are always checking the true current state.
3. **Determine Compliance Status:** In your final `SELECT` statement, use a prioritized `CASE` statement to apply the compliance rules:
   * **Check for INVALID Status:** Check if `latest_status` is *not* 'Active'. If so, assign 'INVALID'.
   * **Check for EXPIRED Status:** If the status *is* 'Active', then check if the `expiry_date` is less than or equal to the cutoff date (`'2024-01-01'`). If so, assign 'EXPIRED'.
4. **Final Filtering:** Only include rows where the derived `compliance_status` is non-null (i.e., non-compliant).

**Your Solution:**

```sql
WITH certifications AS (
	SELECT
		log_id, employee_id, cert_name, issue_date, expiry_date, status,
		ROW_NUMBER() OVER (PARTITION BY employee_id, cert_name ORDER BY expiry_date DESC) AS rn
	FROM
		employee_certifications
),
certification_status AS (
	SELECT
		employee_id,
		cert_name,
		CASE WHEN rn = 1 THEN status END AS latest_status,
		CASE
			WHEN rn = 1 AND status <> 'Active' THEN 'INVALID'
			ELSE 'EXPIRED'
		END AS compliance_status

	FROM
		certifications

	WHERE
		expiry_date  <= '2024-01-01'
	    OR status <> 'Active'
)
SELECT
	employee_id,
	cert_name,
	latest_status,
	compliance_status
FROM
	certification_status
WHERE
	latest_status IS NOT NULL;
```
