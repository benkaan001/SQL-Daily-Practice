# SQL Daily Practice - 2025-07-14

### Question 1: Patients with New or Recurring Chronic Conditions

Identify patients who have been diagnosed with a "chronic condition" (for this problem, consider 'bronchitis', 'low back pain', or 'hypertension' as chronic) and have either:

1. A new diagnosis of a chronic condition in 2024 (meaning no prior diagnosis of that specific condition before 2024).
2. A recurring diagnosis of a chronic condition in 2024 (meaning they had a diagnosis of that specific condition before 2024 and again in 2024).
   Return patient_id, first_name, last_name, diagnosis_name, and diagnosis_status ('New' or 'Recurring').
   Order the results by patient_id ascending, then by diagnosis_name ascending.

**Expected Output:**

| patient_id | first_name | last_name | diagnosis_name                   | diagnosis_status |
| ---------- | ---------- | --------- | -------------------------------- | ---------------- |
| 1          | Alice      | Smith     | Simple chronic bronchitis        | New              |
| 2          | Bob        | Johnson   | Low back pain                    | New              |
| 4          | Diana      | Miller    | Essential (primary) hypertension | New              |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 2: Doctor's Most Common Primary Diagnoses

For each doctor_name, find their top 3 most frequently given primary diagnoses (based on diagnosis_name).

If a doctor has fewer than 3 primary diagnoses, list all of them.

Return doctor_name, diagnosis_name, diagnosis_count, and rank_by_doctor.

Order the results by doctor_name ascending, then by diagnosis_count descending, and diagnosis_name ascending.

**Expected Output:**

| doctor_name | diagnosis_name                                                            | diagnosis_count | rank_by_doctor |
| ----------- | ------------------------------------------------------------------------- | --------------- | -------------- |
| Dr. Chen    | Simple chronic bronchitis                                                 | 2               | 1              |
| Dr. Chen    | Allergic contact dermatitis, unspecified                                  | 1               | 2              |
| Dr. Chen    | Allergic rhinitis due to pollen                                           | 1               | 2              |
| Dr. Kim     | Low back pain                                                             | 2               | 1              |
| Dr. Kim     | Pain in knee, left                                                        | 1               | 2              |
| Dr. Kim     | Sprain of knee                                                            | 1               | 2              |
| Dr. Lee     | Encounter for general adult medical examination without abnormal findings | 3               | 1              |
| Dr. Lee     | Essential (primary) hypertension                                          | 1               | 2              |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 3: Patients with Complex Allergy Profiles

Identify patients who have both a blood_type recorded AND allergies listed, and have had at least one 'Emergency' visit_type.

For these patients, return patient_id, first_name, last_name, blood_type, and allergies.

Order the results by patient_id ascending.

**Expected Output:**

| patient_id | first_name | last_name | blood_type | allergies |
| ---------- | ---------- | --------- | ---------- | --------- |
| 3          | Charlie    | Brown     | B+         | Pollen    |

**Your Solution:**

```sql
--- Write your solution here

```
