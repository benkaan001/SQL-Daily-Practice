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

```sql
SELECT 
  m.member_name,
  COUNT(l.loan_id) AS total_loans 
FROM 
  members m 
LEFT JOIN
  loans l ON m.member_id = l.member_id 
GROUP BY 
  m.member_name;
```

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

```sql
SELECT
  b.title,
  COUNT(r.review_id) AS total_reviews
FROM 
  books b 
LEFT JOIN
  reviews r ON r.book_id = b.book_id 
GROUP BY 
  b.title;
```
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

```sql
SELECT 
  b.title,
  ROUND(AVG(r.rating), 2) AS avg_rating
FROM 
  books b 
LEFT JOIN
  reviews r ON r.book_id = b.book_id 
GROUP BY 
  b.title;
```
---

### **Question 4: Monthly Loan Trends**  
*Task:* Aggregate total loans by month (derived from loan_date).

*Expected Output:*

| month   | total_loans |
|---------|-------------|
| 2021-02 | 3           |
| 2021-03 | 6           |

```sql
SELECT 
  DATE_FORMAT(loan_date, '%Y-%m') AS month,
  COUNT(loan_id) AS total_loans
FROM  
  loans 
GROUP BY 
  DATE_FORMAT(loan_date, '%Y-%m');
```
---

### **Question 5: Average Loan Duration per Member**  
*Task:* For each member, compute the average loan duration (in days) for returned books 
and round to two decimals.

*Expected Output:*

| member_name      | avg_loan_duration |
|------------------|-------------------|
| Alice Smith      | 12.00             |
| Bob Jones        | 10.00             |
| Diana Prince     | 9.00              |
| Edward Williams  | 9.00              |
```sql
SELECT 
  m.member_name,
  ROUND(AVG(DATEDIFF(l.return_date, l.loan_date)), 2) AS avg_loan_duration
FROM 
  members m 
LEFT JOIN
  loans l ON l.member_id = m.member_id 
WHERE 
  l.return_date IS NOT NULL 
GROUP BY 
  m.member_name;
```

---

### **Question 6: Top Genre by Number of Loans**  
*Task:* Join loans with books and compute total loans per genre. Return the genre with the highest total loans.

*Expected Output:*

| genre    | total_loans |
|----------|-------------|
| Fantasy  | 6           |

```sql
WITH books_ranked_by_genre AS (
  SELECT 
    b.genre,
    COUNT(l.loan_id) AS total_loans,
    DENSE_RANK() OVER (ORDER BY COUNT(l.loan_id) DESC) AS genre_rank
  FROM 
    books b 
  LEFT JOIN
    loans l ON l.book_id = b.book_id 
  GROUP BY 
    b.genre 
)
SELECT 
  genre, 
  total_loans 
FROM 
  books_ranked_by_genre 
WHERE 
  genre_rank = 1;
```

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

```sql
SELECT 
  m.member_name,
  MAX(l.loan_date) AS most_recent_loan_date
FROM 
  members m 
LEFT JOIN
  loans l ON l.member_id = m.member_id 
GROUP BY 
  m.member_name;
```
---

### **Question 8: Rank Members by Number of Loans**  
*Task:* Using a window function, rank members based on their number of loans (in descending order). 
In case of ties, order alphabetically by member_name.

*Expected Output:*

| member_name      | total_loans | loan_rank |
|------------------|-------------|-----------|
| Alice Smith      | 2           | 1         |
| Bob Jones        | 2           | 1         |
| Diana Prince     | 2           | 1         |
| Edward Williams  | 2           | 1         |
| Charlie Brown    | 1           | 2         |

```sql
SELECT 
  m.member_name,
  COUNT(l.loan_id) AS total_loans,
  DENSE_RANK() OVER (ORDER BY COUNT(l.loan_id) DESC) as loan_rank
FROM 
  members m 
LEFT JOIN
  loans l ON l.member_id = m.member_id 
GROUP BY 
  m.member_name
ORDER BY 
  loan_rank, m.member_name;
```

---

### **Question 9: Book Loan Share within Each Genre**  
*Task:* For each book, calculate its loan share (%) among books in the same genre. 
Round the value to two decimals.

*Expected Output:*

| title                               | genre    | book_loans | loan_share |
|-------------------------------------|----------|------------|------------|
| Harry Potter and the Philosopher's Stone | Fantasy  | 2          | 33.33      |
| A Game of Thrones                   | Fantasy  | 2          | 33.33      |
| The Hobbit                          | Fantasy  | 2          | 33.33      |
| Murder on the Orient Express        | Mystery  | 2          | 100.00     |
| The Shining                         | Horror   | 1          | 100.00     |

```sql 
WITH genre_loan_count AS (
  SELECT 
    b.genre,
    COUNT(l.loan_id) AS genre_count
  FROM 
    books b 
  LEFT JOIN
    loans l ON l.book_id = b.book_id
  GROUP BY 
    b.genre
)
SELECT 
  b.title,
  b.genre,
  COUNT(l.loan_id) AS total_loans,
  ROUND(COUNT(l.loan_id)/(SELECT genre_count FROM genre_loan_count WHERE genre = b.genre ) * 100,2) AS loan_share
FROM 
  books b 
LEFT JOIN
  loans l ON b.book_id = l.book_id 
GROUP BY 
  b.title,
  b.genre; 
```
---

### **Question 10: Members with Overlapping Loans**  
*Task:* List members who have overlapping loans. 
An overlap occurs if a member has two loans whose date ranges overlap. 
Return member full name and the count of overlapping loan pairs.

*Expected Output:*

| member_name      | overlapping_loans |
|------------------|-------------------|
| Alice Smith      | 1                 |
| Bob Jones        | 1                 |
| Diana Prince     | 1                 |
| Edward Williams  | 1                 |

```sql
WITH overlapping_loans_cte AS (
  SELECT
    l1.member_id
  FROM 
    loans l1 
  INNER JOIN
    loans l2 ON l1.member_id = l2.member_id 
    AND l1.loan_id < l2.loan_id 
    AND l1.loan_date < COALESCE(l2.return_date, '9999-12-31') 
), members_cte AS (
  SELECT 
    member_id,
    member_name
  FROM 
    members
)
SELECT 
  mc.member_name,
  COUNT(olc.member_id) AS overlapping_loans 
FROM 
  overlapping_loans_cte olc 
JOIN
  members_cte mc ON mc.member_id = olc.member_id
GROUP BY 
  member_name;

```



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

```sql
WITH loan_duration_cte AS (
  SELECT 
    m.member_name,
    l.loan_id,
    DATEDIFF(COALESCE(l.return_date, 0), l.loan_date) AS longest_loan_duration
  FROM 
    members m 
  LEFT JOIN
    loans l ON l.member_id = m.member_id 
  WHERE 
    l.return_date IS NOT NULL
  GROUP BY 
    m.member_name,
    l.loan_id
)
SELECT 
  member_name,
  MAX(longest_loan_duration) AS longest_loan_duration
FROM 
  loan_duration_cte 
GROUP BY 
  member_name;
```
---

### **Question 12: Members with No Reviews**  
*Task:* Return the full name of members who have not written any reviews.

*Expected Output:*

| member_name      |
|------------------|
|                  |

```sql
SELECT 
  m.member_name 
FROM 
  members m 
LEFT JOIN
  reviews r ON r.member_id = m.member_id 
WHERE 
  r.review_id IS NULL;
```

---

### **Question 13: Average Rating per Author**  
*Task:* For each author, compute the average rating (out of 5) based on reviews of their books. 
Round the average to 2 decimals.

*Expected Output:*

| author_name           | avg_rating |
|-----------------------|------------|
| J.K. Rowling          | 5.00       |
| George R.R. Martin    | 4.00       |
| J.R.R. Tolkien        | 3.00       |
| Agatha Christie       | 5.00       |
| Stephen King          | 4.00       |

```sql
SELECT 
  a.author_name,
  ROUND(AVG(r.rating), 2) AS avg_rating
FROM 
  authors a 
LEFT JOIN
  books b ON a.author_id = b.author_id 
LEFT JOIN
  reviews r ON r.book_id = b.book_id 
GROUP BY 
  a.author_name;
```
---

### **Question 14: Members with All Loans Returned**  
*Task:* List members who have returned all the books they borrowed. 
Return member full name and total number of loans.

*Expected Output:*

| member_name      | total_loans |
|------------------|-------------|
| Alice Smith      | 2           |

```sql
WITH laon_count_cte AS (
  SELECT 
    m.member_name,
    COUNT(l.loan_id) AS total_loans
  FROM 
    members m 
  LEFT JOIN
    loans l ON l.member_id = m.member_id 
  GROUP BY 
    m.member_name
)
SELECT 
  m.member_name,
  COUNT(l.loan_id) AS total_loans
FROM 
  members m 
LEFT JOIN
  loans l ON l.member_id = m.member_id 
WHERE 
  return_date IS NOT NULL
GROUP BY 
  m.member_name
HAVING 
  COUNT(l.loan_id) = (SELECT total_loans FROM laon_count_cte WHERE member_name = m.member_name);
```

---

### **Question 15: Most Borrowed Book per Genre**  
*Task:* For each genre, return the book with the highest number of loans. In case of ties, return the book with the earliest published date.

*Expected Output:*

| genre    | title                               | total_loans |
|----------|-------------------------------------|-------------|
| Fantasy  | Harry Potter and the Philosopher's Stone | 2       |
| Mystery  | Murder on the Orient Express        | 2           |
| Horror   | The Shining                         | 1           |

```sql
WITH genre_loans AS(
  SELECT 
    b.genre,
    b.title,
    COUNT(l.loan_id) AS total_loans,
    ROW_NUMBER() OVER (PARTITION BY b.genre ORDER BY COUNT(l.loan_id) DESC) AS rk
  FROM 
    books b 
  LEFT JOIN
    loans l ON l.book_id = b.book_id
  GROUP BY 
    b.genre, 
    b.title 
)
SELECT 
  genre,
  title,
  total_loans 
FROM 
  genre_loans 
WHERE 
  rk = 1
ORDER BY 
  total_loans DESC;
```
---

### **Question 16: Members with the Highest Average Rating Given**  
*Task:* For each member, compute the average rating they have given in their reviews. 
Return the top 3 members with the highest average rating, rounded to 2 decimals.
In case of ties, order alphabetically by member_name in descending order.

*Expected Output:*

| member_name      | avg_rating |
|------------------|------------|
| Alice Smith      | 4.50       |
| Diana Prince     | 4.50       |
| Edward Williams  | 4.00       |

```sql
WITH ranked_members_cte AS (
  SELECT 
    m.member_name,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    ROW_NUMBER() OVER (ORDER BY AVG(r.rating) DESC, m.member_name DESC) AS row_num 
  FROM 
    members m 
  LEFT JOIN
    reviews r ON r.member_id = m.member_id 
  GROUP BY 
    m.member_name
)
SELECT 
  member_name,
  avg_rating
FROM 
  ranked_members_cte 
WHERE 
  row_num <= 3;
```

---

### **Question 17: Authors with the Most Books Borrowed**  
*Task:* For each author, compute the total number of times their books have been borrowed. 
Return the top 3 authors with the highest total loans.

*Expected Output:*

| author_name           | total_loans |
|-----------------------|-------------|
| J.K. Rowling          | 2           |
| George R.R. Martin    | 2           |
| J.R.R. Tolkien        | 2           |

```sql
SELECT 
  a.author_name,
  COUNT(l.loan_id) AS total_loans
FROM 
  authors a 
LEFT JOIN
  books b ON b.author_id = a.author_id
LEFT JOIN
  loans l ON l.book_id = b.book_id
GROUP BY 
  a.author_name
ORDER BY 
  total_loans DESC 
LIMIT 3;
```

---

### **Question 18: Members with the Most Overdue Loans**  
*Task:* For each member, compute the total number of overdue loans 
(loans not returned within 30 days). 
Return the top 3 members with the highest number of overdue loans.

*Expected Output:*

| member_name      | overdue_loans |
|------------------|---------------|
| Bob Jones        | 1             |
| Charlie Brown    | 1             |
| Diana Prince     | 1             |

```sql
SELECT 
  m.member_name,
  COUNT(l.loan_id) AS overdue_loans
FROM 
  members m 
LEFT JOIN
  loans l ON l.member_id = m.member_id 
WHERE 
  l.return_date IS NULL 
GROUP BY
  m.member_name 
ORDER BY 
  overdue_loans DESC 
LIMIT 3;
```
---

### **Question 19: Average Loan Duration per Genre**  
*Task:* For each genre, compute the average loan duration (in days) for returned books. Round the average to 2 decimals.

*Expected Output:*

| genre    | avg_loan_duration |
|----------|-------------------|
| Fantasy  | 10.50             |
| Mystery  | 10.00             |

```sql
SELECT 
  b.genre,
  ROUND(AVG(DATEDIFF(l.return_date, l.loan_date)), 2) AS avg_loan_duration
FROM 
  books b 
LEFT JOIN
  loans l ON l.book_id = b.book_id 
WHERE 
  l.return_date IS NOT NULL
GROUP BY
  b.genre;
```
---

### **Question 20: Members with the Most Reviews Written**  
*Task:* For each member, compute the total number of reviews they have written. 
Return the top 3 members with the highest number of reviews.

*Expected Output:*

| member_name      | total_reviews |
|------------------|---------------|
| Alice Smith      | 2             |
| Bob Jones        | 2             |
| Diana Prince     | 2             |

```sql
WITH member_rank_cte AS (
  SELECT 
    m.member_name,
    COUNT(r.review_id) AS total_reviews,
    ROW_NUMBER() OVER (ORDER BY COUNT(r.review_id) DESC, m.member_name) AS row_num
  FROM
    members m 
  LEFT JOIN
    reviews r ON r.member_id = m.member_id 
  GROUP BY 
    m.member_name
)
SELECT 
  member_name, 
  total_reviews
FROM 
  member_rank_cte 
WHERE 
  row_num <= 3;
```

─────────────────────────────  