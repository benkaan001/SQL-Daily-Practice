## Question 1: Find Drafts Containing Specific Words

Find all draft_id and contents from the drafts table where the contents field contains 
either the word "Hello" or the word "SQL".

**Expected Output Format:**

| draft_id | contents                                                                                |
| -------- | --------------------------------------------------------------------------------------- |
| 1        | Hello world, this is a draft. #announcement                                             |
| 2        | This draft contains an email: alice@example.com and some text. Hello again!             |
| 4        | Another draft: use SQL functions to manipulate text. #SQL                               |
| 5        | Final draft; testing text manipulation, word count, and pattern matching. #testing #SQL |


**Your Solution:**
```sql
SELECT
	draft_id,
    contents
FROM
	drafts
WHERE
	contents LIKE '%Hello%' OR contents LIKE '%SQL%';
```

## Question 2: Find Authors Whose Names Start with A or B

Find all unique author names from the drafts table where the author's name 
starts with either the letter "A" or the letter "B".

**Expected Output Format:**

| author |
| ------ |
| Alice  |
| Bob    |

**Your Solution:**
```sql
SELECT
	DISTINCT author
FROM
	drafts
WHERE
	author LIKE 'A%' OR author LIKE 'B%';
```


## Question 3: Find Drafts Containing Email

Find all draft_id and contents from the drafts table where the contents field 
contains at least one email pattern `name@domain.com`

**Expected Output Format:**

| contents                                                                    |
| --------------------------------------------------------------------------- |
| This draft contains an email: alice@example.com and some text. Hello again! |

**Your Solution:**
```sql
SELECT
	contents
FROM
	drafts
WHERE
	contents REGEXP '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.com';
```


## Question 4: Email Domain Extraction
Extract the domain name. 

**Expected Output Format:**

| domain         | 
| -------------- |
| example.com    |

**Your Solution:**
```sql
SELECT
	SUBSTRING_INDEX(SUBSTRING_INDEX(contents, '@', -1), ' ', 1) AS domain
FROM
	drafts
WHERE
	contents REGEXP '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.com';
```


## Question 5: Reverse the Contents Text
For each draft, output the `draft_id` and a reversed version of the `contents` text (i.e. characters in the contents are in reverse order).  
Output two columns: `draft_id` and `reversed_contents`.

**Expected Output Format:**

| draft_id | reversed_contents                                                                       |
| -------- | --------------------------------------------------------------------------------------- |
| 1        | tnemecnuonna# .tfard a si siht ,dlrow olleH                                             |
| 2        | !niaga olleH .txet emos dna moc.elpmaxe@ecila :liame na sniatnoc tfard sihT             |
| 3        | noitaripsni# .saedi ruoy erahs dna ,sthguoht ruoy tfarD .nuf si gnitfarD                |
| 4        | LQS# .txet etalupinam ot snoitcnuf LQS esu :tfard rehtonA                               |
| 5        | LQS# gnitset# .gnihctam nrettap dna ,tnuoc drow ,noitalupinam txet gnitset ;tfard laniF |

**Your Solution:**
```sql
SELECT
	draft_id,
	REVERSE(contents) AS reversed_contents
FROM
	drafts;
```
