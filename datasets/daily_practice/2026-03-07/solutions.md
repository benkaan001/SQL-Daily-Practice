## Puzzle: The Most Popular "Next" Page

**The Scenario:** The UX (User Experience) team is redesigning the website's navigation menus. To make data-driven decisions, they want to know user habits. For every single page on the site, they want to know the *most common page* users navigate to immediately afterward within the same session.

**Your Task:** Write a query that calculates the most frequent "next step" for every URL.

The final report should show the `current_page`, the `most_common_next_page`, and the `transition_count` (how many times that specific transition occurred). Only include pages that have a valid "next" page.

Order the results alphabetically by the `current_page`.

**Expected Output:**

| **current_page** | **most_common_next_page** | **transition_count** |

| ---------------------- | ------------------------------- | -------------------------- |

| /blog                  | /home                           | 2                          |

| /checkout              | /success                        | 2                          |

| /home                  | /products                       | 4                          |

| /products              | /checkout                       | 3                          |

### Tips for Approaching the Problem

1.**Look Ahead to the Next Page:** The very first step is to attach the subsequent page URL to the current row. The `LEAD(page_url) OVER (PARTITION BY session_id ORDER BY view_timestamp)` window function is designed exactly for this.

2.**Filter Out Session Ends:** The last page a user visits in their session will have a `NULL` next page. Filter these out in your first Common Table Expression (CTE) because they don't represent a page-to-page transition.

3.**Count the Transitions:** Once you have pairs of `(current_page, next_page)`, group by both columns and use `COUNT(*)` to tally how many times each specific transition path was taken.

4.**Rank the Transitions:** Now you have a list of all paths and their frequencies. You need to find the top one for each starting page. Use the `ROW_NUMBER()` window function. Partition by the `current_page` and order by your `transition_count` descending.

5.**Final Selection:** Wrap everything in a final query and select only the rows where the rank is `1`.

**Your Solution:**

```sql
-- Write your solution here
```
