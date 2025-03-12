─────────────────────────────  
## 10 Intermediate-Level Questions

Each question below is followed by the expected result set (based on the sample data) in table format so you can code your solution and later compare with the expected output.

---

### **Question 1: Total Loans per Member**  
*Task:* Return each member's name and total number of loans.

*Expected Output:*

| member_name      | total_loans |
|------------------|-------------|
| Alice Smith      | 2           |
| Bob Jones        | 2           |
| Charlie Brown    | 1           |
| Diana Prince     | 2           |
| Edward Williams  | 2           |

---

### **Question 2: Total Reviews per Book**  
*Task:* Return each book's title and total number of reviews.

*Expected Output:*

| title                               | total_reviews |
|-------------------------------------|---------------|
| Harry Potter and the Philosopher's Stone | 2         |
| A Game of Thrones                   | 2             |
| The Hobbit                          | 2             |
| Murder on the Orient Express        | 2             |
| The Shining                         | 1             |

---

### **Question 3: Average Rating per Book**  
*Task:* For each book, compute the average rating (out of 5) based on customer reviews. Round the average to 2 decimals.

*Expected Output:*

| title                               | avg_rating |
|-------------------------------------|------------|
| Harry Potter and the Philosopher's Stone | 5.00   |
| A Game of Thrones                   | 4.00       |
| The Hobbit                          | 3.00       |
| Murder on the Orient Express        | 5.00       |
| The Shining                         | 4.00       |

---

### **Question 4: Monthly Loan Trends**  
*Task:* Aggregate total loans by month (derived from loan_date).

*Expected Output:*

| month   | total_loans |
|---------|-------------|
| 2021-02 | 3           |
| 2021-03 | 6           |

---

### **Question 5: Average Loan Duration per Member**  
*Task:* For each member, compute the average loan duration (in days) for returned books and round to two decimals.

*Expected Output:*

| member_name      | avg_loan_duration |
|------------------|-------------------|
| Alice Smith      | 12.00             |
| Bob Jones        | 10.00             |
| Diana Prince     | 9.00              |
| Edward Williams  | 9.00              |

---

### **Question 6: Top Genre by Number of Loans**  
*Task:* Join loans with books and compute total loans per genre. Return the genre with the highest total loans.

*Expected Output:*

| genre    | total_loans |
|----------|-------------|
| Fantasy  | 6           |

---

### **Question 7: Most Recent Loan per Member**  
*Task:* Return each member's most recent loan date.

*Expected Output:*

| member_name      | most_recent_loan_date |
|------------------|-----------------------|
| Alice Smith      | 2021-03-10            |
| Bob Jones        | 2021-03-05            |
| Charlie Brown    | 2021-03-10            |
| Diana Prince     | 2021-03-15            |
| Edward Williams  | 2021-03-20            |

---

### **Question 8: Rank Members by Number of Loans**  
*Task:* Using a window function, rank members based on their number of loans (in descending order). In case of ties, order alphabetically by member_name.

*Expected Output:*

| member_name      | total_loans | loan_rank |
|------------------|-------------|-----------|
| Alice Smith      | 2           | 1         |
| Bob Jones        | 2           | 1         |
| Diana Prince     | 2           | 1         |
| Edward Williams  | 2           | 1         |
| Charlie Brown    | 1           | 2         |

---

### **Question 9: Book Loan Share within Each Genre**  
*Task:* For each book, calculate its loan share (%) among books in the same genre. Round the value to two decimals.

*Expected Output:*

| title                               | genre    | book_loans | loan_share |
|-------------------------------------|----------|------------|------------|
| Harry Potter and the Philosopher's Stone | Fantasy  | 2          | 33.33      |
| A Game of Thrones                   | Fantasy  | 2          | 33.33      |
| The Hobbit                          | Fantasy  | 2          | 33.33      |
| Murder on the Orient Express        | Mystery  | 2          | 100.00     |
| The Shining                         | Horror   | 1          | 100.00     |

---

### **Question 10: Members with Overlapping Loans**  
*Task:* List members who have overlapping loans. An overlap occurs if a member has two loans whose date ranges overlap. Return member full name and the count of overlapping loan pairs.

*Expected Output:*

| member_name      | overlapping_loans |
|------------------|-------------------|
| Alice Smith      | 1                 |
| Bob Jones        | 1                 |
| Diana Prince     | 1                 |
| Edward Williams  | 1                 |

─────────────────────────────  
## 10 Advanced-Level Questions

Each question below is followed by the expected result set (based on the sample data) in table format so you can code your solution and later compare with the expected output.

---

### **Question 11: Longest Loan Duration per Member**  
*Task:* For each member, return the longest loan duration (in days) for returned books.

*Expected Output:*

| member_name      | longest_loan_duration |
|------------------|-----------------------|
| Alice Smith      | 14                    |
| Bob Jones        | 10                    |
| Diana Prince     |  9                    |
| Edward Williams  |  9                    |

---

### **Question 12: Members with No Reviews**  
*Task:* Return the full name of members who have not written any reviews.

*Expected Output:*

| member_name      |
|------------------|
|                  |

---

### **Question 13: Average Rating per Author**  
*Task:* For each author, compute the average rating (out of 5) based on reviews of their books. Round the average to 2 decimals.

*Expected Output:*

| author_name           | avg_rating |
|-----------------------|------------|
| J.K. Rowling          | 5.00       |
| George R.R. Martin    | 4.00       |
| J.R.R. Tolkien        | 3.00       |
| Agatha Christie       | 5.00       |
| Stephen King          | 4.00       |

---

### **Question 14: Members with All Loans Returned**  
*Task:* List members who have returned all the books they borrowed. Return member full name and total number of loans.

*Expected Output:*

| member_name      | total_loans |
|------------------|-------------|
| Alice Smith      | 2           |


---

### **Question 15: Most Borrowed Book per Genre**  
*Task:* For each genre, return the book with the highest number of loans. In case of ties, return the book with the earliest published date.

*Expected Output:*

| genre    | title                               | total_loans |
|----------|-------------------------------------|-------------|
| Fantasy  | Harry Potter and the Philosopher's Stone | 2       |
| Mystery  | Murder on the Orient Express        | 2           |
| Horror   | The Shining                         | 1           |

---

### **Question 16: Members with the Highest Average Rating Given**  
*Task:* For each member, compute the average rating they have given in their reviews. Return the top 3 members with the highest average rating, rounded to 2 decimals.

*Expected Output:*

| member_name      | avg_rating |
|------------------|------------|
| Alice Smith      | 4.50       |
| Diana Prince     | 4.50       |
| Edward Williams  | 4.00       |

---

### **Question 17: Authors with the Most Books Borrowed**  
*Task:* For each author, compute the total number of times their books have been borrowed. Return the top 3 authors with the highest total loans.

*Expected Output:*

| author_name           | total_loans |
|-----------------------|-------------|
| J.K. Rowling          | 2           |
| George R.R. Martin    | 2           |
| J.R.R. Tolkien        | 2           |

---

### **Question 18: Members with the Most Overdue Loans**  
*Task:* For each member, compute the total number of overdue loans (loans not returned within 30 days). Return the top 3 members with the highest number of overdue loans.

*Expected Output:*

| member_name      | overdue_loans |
|------------------|---------------|
| Bob Jones        | 1             |
| Charlie Brown    | 1             |
| Diana Prince     | 1             |

---

### **Question 19: Average Loan Duration per Genre**  
*Task:* For each genre, compute the average loan duration (in days) for returned books. Round the average to 2 decimals.

*Expected Output:*

| genre    | avg_loan_duration |
|----------|-------------------|
| Fantasy  | 10.50             |
| Mystery  | 10.00             |


---

### **Question 20: Members with the Most Reviews Written**  
*Task:* For each member, compute the total number of reviews they have written. Return the top 3 members with the highest number of reviews.

*Expected Output:*

| member_name      | total_reviews |
|------------------|---------------|
| Alice Smith      | 2             |
| Bob Jones        | 2             |
| Diana Prince     | 2             |

─────────────────────────────  
Use this dataset and these 20 questions to practice your SQL coding skills. When you're ready, code your solutions and share them for review. Good luck!