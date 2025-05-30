**[Question 1] Top Performing Search Terms by Click-Through Rate (CTR)**

For search terms that appeared at least 3 times in the logs:

1. Calculate their total number of appearances.
2. Calculate their total number of clicks.
3. Calculate their overall Click-Through Rate (CTR) as `(total_clicks / total_appearances) * 100`.
4. Rank these search terms based on their CTR in descending order. If CTRs are equal, rank them alphabetically by `search_term`.

Output the `search_term`, `total_appearances`, `total_clicks`, `ctr` (formatted to two decimal places), and its `rank`.


**Expected Results**

```
| search_term | total_appearances | total_clicks | ctr    | rank |
|-------------|-------------------|--------------|--------|------|
| cat         | 8                 | 7            | 87.50  | 1    |
| rabbit      | 10                | 7            | 70.00  | 2    |
| dog         | 9                 | 4            | 44.44  | 3    |
```

**Your Solution:**

````sql
-- Write your solution here
````

---

**[Question 2] Click Distribution Across Top Search Positions**

Analyze the click behavior for search results appearing in positions 1 through 3.
For each of these top 3 positions:

1. Calculate the total number of times a search result appeared at that position.
2. Calculate the total number of times a search result was clicked at that position.
3. Calculate the click rate for that position as `(total_clicks_at_position / total_appearances_at_position) * 100`.

Output `search_results_position`, `total_appearances_at_position`, `total_clicks_at_position`, and `click_rate_at_position` (formatted to two decimal places).
Order the results by `search_results_position` in ascending order.


**Expected Results**

```
| search_results_position | total_appearances_at_position | total_clicks_at_position | click_rate_at_position |
|-------------------------|-------------------------------|--------------------------|------------------------|
| 1                       | 13                            | 9                        | 69.23                  |
| 2                       | 8                             | 4                        | 50.00                  |
| 3                       | 7                             | 6                        | 85.71                  |
```

**Your Solution:**

````sql
-- Write your solution here
````

---

**[Question 3] Search Session Analysis - Clicks per Search ID**

Analyze user engagement within individual search sessions. For each `search_id`:

1. Calculate the total number of search results shown in that session.
2. Calculate the total number of search results clicked in that session.
3. Calculate the session click rate as `(total_results_clicked / total_results_shown) * 100`.
   Include only search sessions that had at least one click.

Output `search_id`, `total_results_shown`, `total_results_clicked`, and `session_click_rate` (formatted to two decimal places).
Order the results by `session_click_rate` in descending order, then by `search_id` in ascending order.

**Expected Results**

```
| search_id | total_results_shown | total_results_clicked | session_click_rate |
|-----------|-----------------------|-----------------------|--------------------|
| 1         | 1                     | 1                     | 100.00             |
| 2         | 1                     | 1                     | 100.00             |
| 3         | 1                     | 1                     | 100.00             |
| 5         | 1                     | 1                     | 100.00             |
| 6         | 1                     | 1                     | 100.00             |
| 14        | 2                     | 2                     | 100.00             |
| 18        | 1                     | 1                     | 100.00             |
| 42        | 1                     | 1                     | 100.00             |
| 51        | 1                     | 1                     | 100.00             |
| 52        | 1                     | 1                     | 100.00             |
| 53        | 1                     | 1                     | 100.00             |
| 57        | 2                     | 2                     | 100.00             |
| 68        | 2                     | 2                     | 100.00             |
| 69        | 1                     | 1                     | 100.00             |
| 90        | 1                     | 1                     | 100.00             |
| 120       | 1                     | 1                     | 100.00             |
| 123       | 1                     | 1                     | 100.00             |
| 720       | 1                     | 1                     | 100.00             |
| 63        | 2                     | 1                     | 50.00              |
| 97        | 2                     | 1                     | 50.00              |
```

**Your Solution:**

````sql
-- Write your solution here
````
