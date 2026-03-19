## Puzzle: The Top 3-Step User Journeys

**The Scenario:** The UX team wants to optimize the website's navigation layout. To do this effectively, they need to know the most common sequences of pages that users visit. Your task is to find the most frequent continuous "3-step paths" taken by users within a single session.

**Your Task:** Reconstruct the viewing sequences for every session. Combine any 3 consecutive page views into a single string formatted as `Page1 > Page2 > Page3`.

Count how many times each specific 3-step path occurs across the entire platform. Return the **top 3** most popular paths.

*Note: A single session with 5 page views (A -> B -> C -> D -> E) contains three valid 3-step paths: (A>B>C), (B>C>D), and (C>D>E).*

**Expected Output:**

| **journey_path**    | **path_count** |
| ------------------------- | -------------------- |
| Home > Search > Product   | 3                    |
| Search > Product > Cart   | 3                    |
| Product > Cart > Checkout | 2                    |

### Tips for Approaching the Problem

1. **Look Ahead:** You need to fetch the next two pages for *every* page view in the table to construct a 3-step path starting from that page. The `LEAD()` window function is perfect for this.
2. **Partition and Order:** Use `LEAD(page_name, 1)` to get the 2nd step, and `LEAD(page_name, 2)` to get the 3rd step. You must `PARTITION BY session_id` so that your paths don't accidentally bleed across different users' sessions. Order the window by `view_timestamp`.
3. **Concatenate the Path:** In a Common Table Expression (CTE), use a string concatenation function like `CONCAT(step_1, ' > ', step_2, ' > ', step_3)` to create the final path string.
4. **Filter Out Incomplete Paths:** If a page is the very last or second-to-last page visited in a session, it won't have enough subsequent pages to form a full 3-step path. Be sure to filter out rows where your 3rd step is `NULL`.
5. **Aggregate:** In your final query, `GROUP BY` your concatenated path string, count the occurrences using `COUNT(*)`, and `ORDER BY` the count descending. Finally, apply a `LIMIT 3` to get the top results.

**Your Solution:**

```sql
-- Write your solution here
```
