## Puzzle: The "People You May Know" Engine

**The Scenario:** The Growth Team at a social network wants to increase user connectivity. They have asked you to build the backend logic for a "People You May Know" (PYMK) recommendation widget. The core algorithm suggests 2nd-degree connections (friends of your friends) to the user.

**Your Task:** Write a query to generate friend recommendations for  **User 101** .

A valid recommendation must meet all of the following rules:

1. They are a direct friend of at least one of User 101's direct friends.
2. They are **not** User 101.
3. They are **not** already a direct friend of User 101.

The final report should show the `recommended_friend_id` and the `mutual_friend_count` (how many direct friends User 101 shares with the recommended person). Order the results by the `mutual_friend_count` in descending order, and then by the `recommended_friend_id` in ascending order to break any ties.

**Expected Output:**

| **recommended_friend_id** | **mutual_friend_count** |
| ------------------------------- | ----------------------------- |
| 105                             | 2                             |
| 106                             | 2                             |
| 107                             | 1                             |

*(Note: User 108 does not appear because they are a 3rd-degree connection, not a friend of one of User 101's direct friends).*

### Tips for Approaching the Problem

1. **Define the Direct Network:** Start by creating a Common Table Expression (CTE) that simply lists all the `friend_id`s for `user_id = 101`. This is your list of direct friends.
2. **Find the 2nd Degree Network:** Create a second CTE to find the "friends of friends." You can do this by querying the `friendships` table and joining it back to your `direct_friends` CTE. You are looking for rows where the `user_id` is in your direct friends list. The `friend_id` in these rows represents the potential recommendations!
3. **Filter Out Invalid Matches:** In your final `SELECT` query, pull from the 2nd-degree network CTE. You must apply a `WHERE` clause to filter out two things:
   * Exclude User 101 (`recommended_friend_id != 101`).
   * Exclude anyone already in the direct network (`recommended_friend_id NOT IN (SELECT friend_id FROM direct_friends)`).
4. **Count the Mutuals:** Finally, `GROUP BY` the `recommended_friend_id` and use `COUNT()` to aggregate the results. Because of how you joined in Step 2, counting the rows will exactly match the number of mutual friends they share.

**Your Solution:**

```sql
-- Write your solution here
```
