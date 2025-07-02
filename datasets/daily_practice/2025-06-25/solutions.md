### Question 1: Patient Appointment Streak

Find patients who have completed at least 3 consecutive appointments with the same doctor for the same specialty where each subsequent appointment date is within 30 days of the previous one.

Return the patient_id, first_name, last_name, doctor_name, specialty, and the start_date_of_streak (the appointment_date of the first appointment in the streak).

A streak only considers 'Completed' appointments.

Order the results by patient_id ascending, then start_date_of_streak ascending.

**Expected Output:**

| **patient_id** | **first_name** | **last_name** | **doctor_name** | **specialty** | **start_date_of_streak** |
| -------------------- | -------------------- | ------------------- | --------------------- | ------------------- | ------------------------------ |
| 1                    | John                 | Doe                 | Dr. Adams             | General Practice    | 2024-01-05                     |
| 5                    | Bob                  | Brown               | Dr. Long              | Geriatrics          | 2024-01-01                     |

**Your Solution:**

```sql
WITH sorted_appointments AS (
    SELECT
        patient_id,
        doctor_name,
        appointment_date,
        specialty,
        LEAD(appointment_date, 1, NULL) OVER (PARTITION BY patient_id, doctor_name, specialty ORDER BY appointment_date) AS next_appointment_date
    FROM
        Appointments
    WHERE
        status = 'Completed'
),
filtered_patients AS (
    SELECT
        patient_id,
        doctor_name,
        specialty,
        COUNT(patient_id) AS appointment_count,
        MIN(appointment_date) AS start_date_of_streak
    FROM
        sorted_appointments
    WHERE
        DATEDIFF(next_appointment_date, appointment_date) <= 30
        AND next_appointment_date IS NOT NULL
    GROUP BY
        patient_id,
        doctor_name,
        specialty
    HAVING
        appointment_count >= 2
)
SELECT
    fp.patient_id,
    p.first_name,
    p.last_name,
    fp.doctor_name,
    fp.specialty,
    fp.start_date_of_streak
FROM
    filtered_patients fp
JOIN
    Patients p ON fp.patient_id = p.patient_id
ORDER BY
    fp.patient_id,
    fp.start_date_of_streak;
```

### Question 2: Doctor's Schedule Efficiency and No-Show Rate

For each doctor, calculate their total number of Scheduled appointments, Completed appointments, and their no_show_rate_percentage.

The no_show_rate_percentage is calculated as (Number of 'No-Show' appointments / Total number of 'Scheduled' or 'No-Show' appointments) * 100. If a doctor has no 'Scheduled' or 'No-Show' appointments, the rate should be 0.00.

Round no_show_rate_percentage to two decimal places.

Output doctor_name, specialty, total_scheduled_appointments, total_completed_appointments, and no_show_rate_percentage.

Order results by no_show_rate_percentage descending, then by doctor_name ascending.

**Expected Output:**
| doctor_name | specialty        | total_scheduled_appointments | total_completed_appointments | no_show_rate_percentage |
| ----------- | ---------------- | ---------------------------- | ---------------------------- | ----------------------- |
| Dr. Green   | Pediatrics       | 0                            | 2                            | 100.00                  |
| Dr. Adams   | General Practice | 0                            | 4                            | 0.00                    |
| Dr. Brown   | Orthopedics      | 0                            | 3                            | 0.00                    |
| Dr. Evans   | Dermatology      | 1                            | 1                            | 0.00                    |
| Dr. Gray    | Dentistry        | 0                            | 1                            | 0.00                    |
| Dr. Long    | Geriatrics       | 0                            | 3                            | 0.00                    |
| Dr. Smith   | Cardiology       | 1                            | 1                            | 0.00                    |
| Dr. White   | Ophthalmology    | 0                            | 1                            | 0.00                    |
**Your Solution:**

```sql
WITH appointment_counts AS (
	SELECT
		doctor_name,
		specialty,
		SUM(CASE WHEN status IN ('Scheduled') THEN 1 ELSE 0 END) AS total_scheduled_appointments,
		SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS total_completed_appointments,
		SUM(CASE WHEN status = 'No-Show' THEN 1 ELSE 0 END) AS no_show_count,
		SUM(CASE WHEN status IN ('Scheduled', 'No-Show') THEN 1 ELSE 0 END) AS total_scheduled_or_no_show
	FROM
		Appointments
	GROUP BY
		doctor_name,
		specialty
)
SELECT
	doctor_name,
	specialty,
	total_scheduled_appointments,
	total_completed_appointments,
	ROUND(IFNULL(no_show_count * 100.00 / NULLIF(total_scheduled_or_no_show, 0), 0), 2) AS no_show_rate_percentage
FROM
	appointment_counts
ORDER BY
	no_show_rate_percentage DESC,
	doctor_name ASC;
```

### Question 3: Patients Requiring Follow-up from Same Specialty

Identify patients who had a 'Completed' appointment with a specific specialty in January 2024 and do not have any subsequent 'Scheduled' or 'Completed' appointments with any doctor in the same specialty within 90 days after their last January 2024 appointment in that specialty. These patients might require a follow-up.

Return patient_id, first_name, last_name, specialty, and last_jan_2024_appointment_date.

Order the results by patient_id ascending, then by specialty ascending.

**Expected Output:**

| patient_id | first_name | last_name | specialty  | last_jan_2024_appointment_date |
| ---------- | ---------- | --------- | ---------- | ------------------------------ |
| 1          | John       | Doe       | Cardiology | 2024-01-10                     |
| 4          | Alice      | Williams  | Dentistry  | 2024-01-25                     |
| 5          | Bob        | Brown     | Geriatrics | 2024-01-15                     |

**Your Solution:**

```sql
WITH last_jan_appointments AS (
	SELECT
		patient_id,
		specialty,
		MAX(appointment_date) AS last_jan_2024_appointment_date
	FROM
		Appointments
	WHERE
		status = 'Completed'
		AND appointment_date BETWEEN '2024-01-01' AND '2024-01-31'
	GROUP BY
		patient_id,
		specialty
),
subsequent_appointments AS (
	SELECT
		patient_id,
		specialty,
		appointment_date
	FROM
		Appointments
	WHERE
		status IN ('Scheduled', 'Completed')
)
SELECT
	lja.patient_id,
	p.first_name,
	p.last_name,
	lja.specialty,
	lja.last_jan_2024_appointment_date

FROM
	last_jan_appointments lja
JOIN
	Patients p ON lja.patient_id = p.patient_id
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			subsequent_appointments sa
		WHERE
			sa.patient_id = lja.patient_id
			AND sa.specialty = lja.specialty
			AND sa.appointment_date > lja.last_jan_2024_appointment_date
			AND sa.appointment_date <= DATE_ADD(lja.last_jan_2024_appointment_date, INTERVAL 90 DAY)

	)
ORDER BY
	patient_id,
	specialty;

```
