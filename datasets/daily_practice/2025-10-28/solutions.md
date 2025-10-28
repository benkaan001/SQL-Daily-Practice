## Puzzle: The Ambitious Candidate Progression

**The Scenario:** As an HR analyst, you're interested in identifying candidates who show significant career progression ambition. Specifically, you want to find candidates who first applied for a 'Junior' level position and later applied for a 'Senior' or 'Lead' position within the  *same department* .

**Your Task:** Write a query to identify all instances where a candidate first applied for a 'Junior' role and subsequently applied for a 'Senior' or 'Lead' role in the same `department`. The report should show the `candidate_id`, the `department`, the `job_title` and `application_date` of their first Junior application, and the `job_title` and `application_date` of their first Senior/Lead application that occurred *after* the Junior application.

| **candidate_id** | **department** | **first_junior_job_title** | **first_junior_app_date** | **subsequent_senior_lead_job_title** | **subsequent_senior_lead_app_date** |
| ---------------------- | -------------------- | -------------------------------- | ------------------------------- | ------------------------------------------ | ----------------------------------------- |
| 101                    | Engineering          | Junior Software Engineer         | 2023-09-01                      | Senior Software Engineer                   | 2023-10-15                                |
| 104                    | Marketing            | Junior Marketing Associate       | 2023-09-15                      | Marketing Lead                             | 2023-11-01                                |

### Tips for Approaching the Problem

1. **Isolate Junior and Senior/Lead Applications:** It's helpful to start by creating two separate Common Table Expressions (CTEs). One CTE (`junior_apps`) selects all applications where `job_level = 'Junior'`, and the other CTE (`senior_lead_apps`) selects all applications where `job_level IN ('Senior', 'Lead')`.
2. **Find the *****First***** Junior Application:** Within the `junior_apps` CTE, you only care about the *very first* time a candidate applied for a junior role in a specific department. Use the `ROW_NUMBER()` window function partitioned by `candidate_id` and `department`, ordered by `application_date ASC`. Keep only rows where the rank is 1.
3. **Find the *****First***** Subsequent Senior/Lead Application:** Similarly, within the `senior_lead_apps` CTE, you need the *first* application for a senior/lead role in a department. Use `ROW_NUMBER()` partitioned by `candidate_id` and `department`, ordered by `application_date ASC`. Keep only rows where the rank is 1.
4. **Join the CTEs:** Now, `JOIN` your filtered `first_junior_apps` CTE with your filtered `first_senior_lead_apps` CTE. The join conditions are crucial:
   * `ON first_junior_apps.candidate_id = first_senior_lead_apps.candidate_id`
   * `AND first_junior_apps.department = first_senior_lead_apps.department`
   * `AND first_senior_lead_apps.application_date > first_junior_apps.application_date` (This ensures the senior/lead application happened *after* the junior one).
5. **Final Selection:** Select the required columns from the joined result.

**Your Solution:**

```sql
WITH joined_applications AS (
	SELECT
		junior.candidate_id,
		junior.department,
		junior.job_title AS first_junior_job_title,
		junior.application_date AS first_junior_app_date,
		senior.job_title AS subsequent_senior_lead_job_title,
		senior.application_date AS subsequent_senior_lead_app_date,
		ROW_NUMBER() OVER (PARTITION BY junior.candidate_id ORDER BY senior.application_date) AS rn
	FROM
		job_applications junior
	JOIN
		job_applications senior ON senior.candidate_id = junior.candidate_id
		AND junior.department = senior.department
		AND YEAR(junior.application_date) = YEAR(senior.application_date)
		AND junior.application_date < senior.application_date
	WHERE
		junior.job_level = 'Junior'
		AND senior.job_level != 'Junior'
)
SELECT
	candidate_id,
	department,
	first_junior_job_title,
	first_junior_app_date,
	subsequent_senior_lead_job_title,
	subsequent_senior_lead_app_date
FROM
	joined_applications
WHERE
	rn = 1;
```
