## Puzzle 1: The Conversion Conundrum

**The Scenario:** The marketing team launched a campaign for "Winter Getaways" to Zurich (ZRH). They need to understand the full conversion funnel for users who showed interest in this specific destination.

**Your Task:** Write a query that answers the following questions for user sessions involving Zurich:

1. **Of all unique users who searched for a flight to 'ZRH', what percentage of them also viewed a hotel in 'ZRH'?**
2. **Of those users who searched for a flight AND viewed a hotel in 'ZRH', what percentage of them went on to book either a flight or a hotel to 'ZRH' within the same session?**

**The final report should present these two conversion rates.**

**Expected Output:**

| search_to_view_rate | view_to_book_rate |
| ------------------- | ----------------- |
| 66.67               | 50.00             |

**Your Solution:**

```sql
WITH flags AS (
    SELECT
        user_id,
        -- Flag is 1 if this user ever searched for a flight to ZRH
        MAX(CASE
            WHEN event_type = 'search_flights' AND JSON_UNQUOTE(JSON_EXTRACT(details, '$.destination')) = 'ZRH'
            THEN 1 ELSE 0
        END) AS searched_zrh_flight,

        -- Flag is 1 if this user ever viewed a hotel in ZRH
        MAX(CASE
            WHEN event_type = 'view_hotel' AND JSON_UNQUOTE(JSON_EXTRACT(details, '$.city')) = 'ZRH'
            THEN 1 ELSE 0
        END) AS viewed_zrh_hotel,

        -- Flag is 1 if this user ever booked a flight OR hotel to ZRH
        MAX(CASE
            WHEN event_type IN ('book_flight', 'book_hotel') AND (JSON_UNQUOTE(JSON_EXTRACT(details, '$.destination')) = 'ZRH' OR JSON_UNQUOTE(JSON_EXTRACT(details, '$.city')) = 'ZRH')
            THEN 1 ELSE 0
        END) AS booked_zrh
    FROM
        travel_events
    GROUP BY
        user_id
)
SELECT
    -- Rate 1: (# of users who searched AND viewed) / (# of users who searched)
    ROUND(
        SUM(CASE WHEN searched_zrh_flight = 1 AND viewed_zrh_hotel = 1 THEN 1 ELSE 0 END) * 100.0 /
        SUM(searched_zrh_flight),
    2) AS search_to_view_rate,

    -- Rate 2: (# of users who searched, viewed, AND booked) / (# of users who searched AND viewed)
    ROUND(
        SUM(CASE WHEN searched_zrh_flight = 1 AND viewed_zrh_hotel = 1 AND booked_zrh = 1 THEN 1 ELSE 0 END) * 100.0 /
        SUM(CASE WHEN searched_zrh_flight = 1 AND viewed_zrh_hotel = 1 THEN 1 ELSE 0 END),
    2) AS view_to_book_rate
FROM
    flags;
```

## Puzzle 2: The "Lost Revenue" What-If

**The Scenario:** Cancellations are hurting the bottom line. The finance team wants to quantify the impact of "last-minute" cancellations and project the potential savings if this problem were partially solved.

**Your Task:**

1. **Identify all "last-minute" cancellations. A cancellation is considered last-minute if the **` cancel_booking` event occurs within 48 hours of the initial ` book_flight` or ` book_hotel` event for the same ` booking_id`.
2. **Calculate the **` total_lost_revenue` from these specific cancellations.
3. **Project the **` potential_recovered_revenue` assuming the company could implement a policy that prevents 25% of this lost revenue.

**The final report should contain the **` total_lost_revenue` and the ` potential_recovered_revenue`.

**Expected Output:**

| total_lost_revenue | potential_recovered_revenue |
| ------------------ | --------------------------- |
| 450.0              | 112.5                       |


**Your Solution:**

```sql
WITH bookings AS (
    SELECT
        JSON_UNQUOTE(JSON_EXTRACT(details, '$.booking_id')) AS booking_id,
        MAX(CASE WHEN event_type IN ('book_flight', 'book_hotel') THEN JSON_UNQUOTE(JSON_EXTRACT(details, '$.value')) END) AS value,
        MIN(CASE WHEN event_type IN ('book_flight', 'book_hotel') THEN event_timestamp END) AS booking_timestamp,
        MIN(CASE WHEN event_type = 'cancel_booking' THEN event_timestamp END) AS cancel_timestamp
    FROM
        travel_events
    WHERE
        JSON_UNQUOTE(JSON_EXTRACT(details, '$.booking_id')) IS NOT NULL
    GROUP BY
        booking_id
)
SELECT
    SUM(value) AS total_lost_revenue,
    ROUND(SUM(value) * 0.25, 2) AS potential_recovered_revenue
FROM
    bookings
WHERE
    cancel_timestamp IS NOT NULL
    AND TIMESTAMPDIFF(HOUR, booking_timestamp, cancel_timestamp) <= 48;
```

## Puzzle 3: The Ghost Booking Detective

**The Scenario:** A bug has been reported where some users are able to book a flight without having first performed a flight search in their current session. This indicates a flaw in the user workflow.

**Your Task:** Find all sessions where a ` book_flight` event occurred without a preceding ` search_flights` event  *within that same session* **.**

**The report should list the **` session_id`, ` user_id`, and the ` booking_timestamp` of these "ghost bookings."

**Expected Output:**

| session_id | user_id | booking_timestamp   |
| ---------- | ------- | ------------------- |
| sess_D     | 104     | 2023-11-16 14:00:00 |
| sess_F     | 106     | 2023-11-18 13:05:00 |

**Your Solution:**

```sql
-SELECT
    bookings.session_id,
    bookings.user_id,
    bookings.event_timestamp AS booking_timestamp
FROM
    travel_events bookings
WHERE
    bookings.event_type = 'book_flight'
    AND NOT EXISTS (
        SELECT 1
        FROM travel_events searches
        WHERE
            -- The search must be in the same session
            searches.session_id = bookings.session_id
            -- It must be a search event
            AND searches.event_type = 'search_flights'
            -- And it must have happened before the booking
            AND searches.event_timestamp < bookings.event_timestamp
    );
```
