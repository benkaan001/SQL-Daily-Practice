## Question 1: Keyword Analysis by File Prefix

Analyze the occurrence of specific keywords within the file contents, categorized by the prefix of the filename.
For this task:

1. Extract the filename prefix before the first underscore `_` or period `.`. If no underscore or period exists, use the full filename as the prefix. For example, 'draft1.txt' has prefix 'draft1', 'report_q1.txt' has prefix 'report', 'final.txt' would have prefix 'final'. (For our dataset: 'draft1', 'draft2', 'report', 'final'). Let's refine this: prefix is the part before the first `_` if present, otherwise before the first `.` e.g. `draft1.txt` -> `draft1`, `report_q1.txt` -> `report`, `final_summary.txt` -> `final`. For simplicity in this example, let's define prefixes as 'draft' for 'draft1.txt' and 'draft2.txt', 'report' for 'report_q1.txt', and 'final' for 'final_summary.txt'.
2. Consider the keywords "bull" and "bear".
3. For each file prefix and each keyword, count how many files with that prefix contain the given keyword. A keyword is considered present if it appears as a whole word (e.g., "bull" in "bull market", not "bull" in "bullish").

Output the `file_prefix`, `keyword`, and `files_with_keyword_count`.
Order the results by `file_prefix` alphabetically, then by `keyword` alphabetically.

**Expected Output:**

```
| file_prefix | keyword | files_with_keyword_count |
|-------------|---------|--------------------------|
| draft       | bear    | 1                        |
| draft       | bull    | 2                        |
| final       | bear    | 1                        |
| final       | bull    | 1                        |
| report      | bear    | 1                        |
| report      | bull    | 1                        |
```

**Your Solution:**

````sql
-- Write your solution here
````

## Question 2: Document Word Count and Keyword Density

For each document in the `google_file_store` table, calculate its total word count and the density of the word "market".

1. Calculate the `total_word_count` for each file. Assume words are separated by spaces. Punctuation attached to words (e.g., "market.") should be handled such that "market." is counted as the word "market" for keyword matching, but contributes to the overall word count as one word. For simplicity in word counting, you can count space-separated tokens.
2. Count occurrences of the whole word "market" in the `contents`.
3. Calculate `market_density` as: (number of "market" occurrences / `total_word_count`) * 100.

Output `filename`, `total_word_count`, and `market_density` (rounded to two decimal places).
Order the results by `market_density` in descending order, then by `filename` alphabetically.


**Expected Output:**

```
| filename          | total_word_count | market_density |
|-------------------|------------------|----------------|
| draft2.txt        | 19               | 10.53          |
| final_summary.txt | 24               | 8.33           |
| draft1.txt        | 13               | 7.69           |
| report_q1.txt     | 19               | 5.26           |
```

**Your Solution:**

````sql
-- Write your solution here
````


## Question 3: Identifying Sentences with Keyword Co-occurrence

Identify filenames and the specific sentences within their `contents` that contain both the word "bull" AND the word "market".

1. A sentence is defined as a segment of text ending with a period (`.`).
2. Both "bull" and "market" must appear as whole words within the same sentence.

Output `filename` and `sentence_containing_both`. If a file has multiple such sentences, each should be a new row in the output.
Order the results by `filename` alphabetically, then by `sentence_containing_both` alphabetically.


**Expected Output:**

```
| filename          | sentence_containing_both                                                    |
|-------------------|-----------------------------------------------------------------------------|
| draft1.txt        | The stock exchange predicts a bull market.                                  |
| draft2.txt        | Further analysis of the stock exchange suggests the bull market might continue. |
| final_summary.txt | Final summary: The predicted bull market materialized.                      |
| report_q1.txt     | Q1 report: The market showed strong bull signals.                           |
```

**Your Solution:**

````sql
-- Write your solution here
````
