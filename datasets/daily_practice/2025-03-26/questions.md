## Question 1: Word Frequency in Drafts
Find the number of times each word appears in the `contents` column across all rows in the `drafts` table.  
The words should be normalized (for example, lowercased and punctuation removed) as much as possible using SQL built-in functions.  
Output two columns: `word` and `occurrences`.

**Expected Output Format:**

| word         | occurrences |
| ------------ | ----------- |
| hello        | 2           |
| draft        | 4           |
| this         | 2           |
| ...          | ...         |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 2: Average Word Count per Author
For each author, calculate the average number of words in the `contents` field.  
Assume words are separated by spaces (after removing punctuation).  
Output two columns: `author` and `average_word_count`.

**Expected Output Format:**

| author   | average_word_count |
| -------- | ------------------ |
| Alice    | 8                  |
| Bob      | 12                 |
| Charlie  | 10                 |
| Diana    | 14                 |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 3: Hashtag Extraction and Frequency
Extract all hashtags (words that begin with the '#' symbol) from the `contents` column, and list each unique hashtag along with the number of times it appears across all drafts.  
Output two columns: `hashtag` and `occurrences`.

**Expected Output Format:**

| hashtag      | occurrences |
| ------------ | ----------- |
| #announcement| 1           |
| #inspiration | 1           |
| #SQL         | 2           |
| #testing     | 1           |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 4: Email Domain Frequency
Some drafts contain email addresses within the `contents` column. Extract the domain (the part after the '@') from any email address in the contents and count how many times each domain appears.  
Output two columns: `domain` and `email_count`.

**Expected Output Format:**

| domain         | email_count |
| -------------- | ----------- |
| example.com    | 1           |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 5: Reverse the Contents Text
For each draft, output the `draft_id` and a reversed version of the `contents` text (i.e. characters in the contents are in reverse order).  
Output two columns: `draft_id` and `reversed_contents`.

**Expected Output Format:**

| draft_id | reversed_contents                                      |
| -------- | ------------------------------------------------------ |
| 1        | "!tnuocnomm a# .tfard a si siht ,dlrow olleH"           |
| 2        | "!niaga olleH .txet emos dna :moc.elpmaxe@ecila :liame"  |
| ...      | ...                                                  |

**Your Solution:**
```sql
-- Write your solution here
```
