## Puzzle 1: The Lost Edit

**The Scenario:** An engineer is debugging an issue where users report losing work. The theory is that some `DOC_EDIT` events are happening in a "ghost" state, where a user edits a document they haven't officially created or been added to in their session.

**Your Task:** Identify every `DOC_EDIT` event that occurred for a `user_id` and `doc_id` pair *without* a preceding `DOC_CREATE` event by that same user for that same document.

The report should show the `user_id`, `doc_id`, and the `timestamp` of the first "lost" edit.

| **user_id** | **doc_id** | **first_lost_edit_timestamp** |
| ----------------- | ---------------- | ----------------------------------- |
| 2                 | 101              | 2023-11-01 11:00:00.000             |
| 4                 | 102              | 2023-11-02 09:20:00.000             |
| 6                 | 103              | 2023-11-03 14:01:15.000             |
| 8                 | 104              | 2023-11-04 16:05:00.000             |

**Your Solution:**

```sql
-- Write your solution here
```

## Puzzle 2: Collaboration Velocity

**The Scenario:** The product team wants to measure how quickly users respond to each other's comments. This "collaboration velocity" is a key metric for user engagement.

**Your Task:** For every `COMMENT_ADD` event that is a direct reply to another comment, calculate the `response_time_seconds` between the original comment and the reply. The report should only include direct replies (where `reply_to` is not null) and should show the `doc_id`, the original `comment_id`, the `responder_user_id`, and the calculated `response_time_seconds`.

| **doc_id** | **comment_id** | **responder_user_id** | **response_time_seconds** |
| ---------------- | -------------------- | --------------------------- | ------------------------------- |
| 101              | 1                    | 1                           | 120.000                         |
| 104              | 3                    | 7                           | 30.000                          |
| 104              | 4                    | 8                           | 30.000                          |

**Your Solution:**

```sql
-- Write your solution here
```

## Puzzle 3: The Edit Conflict

**The Scenario:** When two users edit a document simultaneously, one person's changes can overwrite the other's. You need to find every instance where this "edit conflict" occurred. A conflict is defined as a `DOC_EDIT` by one user that is immediately followed by a `DOC_EDIT` from a different user on the same document within 30 seconds.

**Your Task:** Identify these conflict events. The report should show the `doc_id`, the `first_editor_id`, their `edit_timestamp`, the `conflicting_editor_id`, and their `edit_timestamp`.

| **doc_id** | **first_editor_id** | **first_edit_timestamp** | **conflicting_editor_id** | **conflicting_edit_timestamp** |
| ---------------- | ------------------------- | ------------------------------ | ------------------------------- | ------------------------------------ |
| 103              | 5                         | 2023-11-03 14:01:00.000        | 6                               | 2023-11-03 14:01:15.000              |
| 103              | 6                         | 2023-11-03 14:01:15.000        | 5                               | 2023-11-03 14:01:30.000              |

**Your Solution:**

```sql
-- Write your solution here
```
