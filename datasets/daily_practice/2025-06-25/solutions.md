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

```
--- Write your solution here

```

### Question 2: Doctor's Schedule Efficiency and No-Show Rate

For each doctor, calculate their total number of Scheduled appointments, Completed appointments, and their no_show_rate_percentage.

The no_show_rate_percentage is calculated as (Number of 'No-Show' appointments / Total number of 'Scheduled' or 'No-Show' appointments) * 100. If a doctor has no 'Scheduled' or 'No-Show' appointments, the rate should be 0.00.

Round no_show_rate_percentage to two decimal places.

Output doctor_name, specialty, total_scheduled_appointments, total_completed_appointments, and no_show_rate_percentage.

Order results by no_show_rate_percentage descending, then by doctor_name ascending.

**Expected Output:**

| **doctor_name** | **specialty** | **total_scheduled_appointments** | **total_completed_appointments** | **no_show_rate_percentage** |
| --------------------- | ------------------- | -------------------------------------- | -------------------------------------- | --------------------------------- |
| Dr. Green             | Pediatrics          | 2                                      | 2                                      | 50.00                             |
| Dr. Smith             | Cardiology          | 2                                      | 1                                      | 0.00                              |
| Dr. Adams             | General Practice    | 1                                      | 3                                      | 0.00                              |
| Dr. Brown             | Orthopedics         | 2                                      | 3                                      | 0.00                              |
| Dr. Evans             | Dermatology         | 1                                      | 1                                      | 0.00                              |
| Dr. Gray              | Dentistry           | 0                                      | 1                                      | 0.00                              |
| Dr. Long              | Geriatrics          | 0                                      | 3                                      | 0.00                              |
| Dr. White             | Ophthalmology       | 0                                      | 1                                      | 0.00                              |

**Your Solution:**

```
--- Write your solution here

```

### Question 3: Patients Requiring Follow-up from Same Specialty

Identify patients who had a 'Completed' appointment with a specific specialty in January 2024 and do not have any subsequent 'Scheduled' or 'Completed' appointments with any doctor in the same specialty within 90 days after their last January 2024 appointment in that specialty. These patients might require a follow-up.

Return patient_id, first_name, last_name, specialty, and last_jan_2024_appointment_date.

Order the results by patient_id ascending, then by specialty ascending.

**Expected Output:**

| **patient_id** | **first_name** | **last_name** | **specialty** | **last_jan_2024_appointment_date** |
| -------------------- | -------------------- | ------------------- | ------------------- | ---------------------------------------- |
| 3                    | Peter                | Jones               | Orthopedics         | 2024-01-20                               |
| 4                    | Alice                | Williams            | Dentistry           | 2024-01-25                               |

**Your Solution:**

```
--- Write your solution here

```
