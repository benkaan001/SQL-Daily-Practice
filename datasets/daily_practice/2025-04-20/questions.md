## Question 1: Companies with More Than 2 Users Speaking English, German, French, or Spanish

Find the IDs of companies that have more than 2 **distinct users** who speak **English, German, French, or Spanish**.  
Only consider users whose state is 'active'.

**Expected Output:**

| company_id |
|------------|
| 100        |
| 101        |
| 102        |

---

## Question 2: Most Popular Language Per Company

For each company, find the language spoken by the highest number of **active** users.  
If there is a tie, return all tied languages for that company.  
Output company_id and language.

**Expected Output:**

| company_id | language |
|------------|----------|
| 100        | english  |
| 101        | german   |
| 102        | english  |
| 102        | spanish  |

---

## Question 3: First Activation Per Company

For each company, find the user who was the **first to activate** (earliest activated_at date) among active users.  
If there is a tie, return all tied user_ids.  
Output company_id, user_id, and activated_at.

**Expected Output:**

| company_id | user_id | activated_at |
|------------|---------|--------------|
| 100        | 1       | 2023-01-01   |
| 101        | 3       | 2023-01-03   |
| 102        | 4       | 2023-01-04   |
