### Question 1: Project Progress and Critical Milestones

For each project, calculate its overall progress_percentage based on the number of completed milestones versus total milestones.

Then, identify the next_critical_milestone for projects that are not yet 100% complete. A "critical milestone" is defined as a milestone that is NOT NULL for dependency_milestone_id and has not been completed (actual_completion_date is NULL). If multiple critical milestones are pending, identify the one with the earliest planned_end_date. If there's a tie, pick alphabetically by milestone_name.

Output project_id, project_name, progress_percentage (rounded to two decimal places), next_critical_milestone_name, and next_critical_milestone_planned_end_date.

If a project has no pending critical milestones, display NULL for the milestone fields.

Order the results by project_id ascending.

**Expected Output:**

| **project_id** | **project_name**       | **progress_percentage** | **next_critical_milestone_name** | **next_critical_milestone_planned_end_date** |
| -------------------- | ---------------------------- | ----------------------------- | -------------------------------------- | -------------------------------------------------- |
| 1                    | E-commerce Platform Relaunch | 83.33                         | Final Deployment                       | 2024-06-30                                         |
| 2                    | Internal CRM Development     | 75.00                         | Security Audit                         | 2024-08-31                                         |
| 3                    | Data Analytics Dashboard     | 66.67                         | Data Transformation Pipelines          | 2024-07-31                                         |
| 4                    | Mobile App v2.0              | 66.67                         | Core Functionality Build               | 2024-11-30                                         |

**Your Solution:**

```
--- Write your solution here

```

### Question 2: Milestone Performance Analysis

For each milestone that has been completed, calculate its `performance_status`:

* 'Ahead of Schedule' if `actual_completion_date` is before `planned_end_date`.
* 'On Schedule' if `actual_completion_date` is on the `planned_end_date`.
* 'Behind Schedule' if actual_completion_date is after planned_end_date.
  Also, calculate the days_difference (absolute difference between actual_completion_date and planned_end_date).
  Return project_name, milestone_name, planned_end_date, actual_completion_date, performance_status, and days_difference.
  Only include completed milestones.
  Order the results by project_name ascending, then by planned_end_date ascending.

**Expected Output:**

| **project_name**       | **milestone_name**      | **planned_end_date** | **actual_completion_date** | **performance_status** | **days_difference** |
| ---------------------------- | ----------------------------- | -------------------------- | -------------------------------- | ---------------------------- | ------------------------- |
| E-commerce Platform Relaunch | Requirements Gathering        | 2024-01-31                 | 2024-01-25                       | Ahead of Schedule            | 6                         |
| E-commerce Platform Relaunch | UI/UX Design Approval         | 2024-02-29                 | 2024-02-28                       | Ahead of Schedule            | 1                         |
| E-commerce Platform Relaunch | Frontend Development Complete | 2024-04-15                 | 2024-04-10                       | Ahead of Schedule            | 5                         |
| E-commerce Platform Relaunch | Backend API Integration       | 2024-05-31                 | 2024-05-25                       | Ahead of Schedule            | 6                         |
| E-commerce Platform Relaunch | Testing & QA                  | 2024-06-20                 | 2024-06-18                       | Ahead of Schedule            | 2                         |
| Internal CRM Development     | Database Schema Design        | 2024-03-20                 | 2024-03-18                       | Ahead of Schedule            | 2                         |
| Internal CRM Development     | User Module Development       | 2024-05-15                 | 2024-05-10                       | Ahead of Schedule            | 5                         |
| Internal CRM Development     | Reporting Module Dev          | 2024-07-31                 | 2024-08-05                       | Behind Schedule              | 5                         |
| Data Analytics Dashboard     | Data Source Connection        | 2024-05-30                 | 2024-05-28                       | Ahead of Schedule            | 2                         |
| Data Analytics Dashboard     | Dashboard UI Prototyping      | 2024-06-20                 | 2024-06-15                       | Ahead of Schedule            | 5                         |
| Data Analytics Dashboard     | User Training Materials       | 2024-08-20                 | 2024-08-15                       | Ahead of Schedule            | 5                         |
| Mobile App v2.0              | Feature Specifications        | 2024-07-31                 | 2024-07-28                       | Ahead of Schedule            | 3                         |
| Mobile App v2.0              | Cross-Platform Dev Setup      | 2024-08-15                 | 2024-08-10                       | Ahead of Schedule            | 5                         |

**Your Solution:**

```
--- Write your solution here

```

### Question 3: Longest Project Completion Chain

Find the project_name and the longest_completion_chain_days. The longest completion chain is the maximum number of days from the planned_start_date of a milestone to the actual_completion_date of its last dependent milestone in a chain where all intermediate milestones are completed.

If a milestone has no dependencies, its chain starts from its planned_start_date.

Only consider chains where all milestones in that specific chain are completed.

Output project_name and longest_completion_chain_days.

Order the results by longest_completion_chain_days descending.

**Expected Output:**

| **project_name**       | **longest_completion_chain_days** |
| ---------------------------- | --------------------------------------- |
| E-commerce Platform Relaunch | 168                                     |
| Internal CRM Development     | 157                                     |
| Mobile App v2.0              | 40                                      |
| Data Analytics Dashboard     | 62                                      |

**Your Solution:**

```
--- Write your solution here

```
