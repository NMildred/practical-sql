-- ================================================================
-- Level 1 — Foundations
-- Reference solutions for ClickHouse
-- ================================================================

-- --------------------------------------------------
-- 1. Daily Registrations
-- Count the number of users registered each day
-- --------------------------------------------------
SELECT
    signup_date,
    count() AS users_registered
FROM users
GROUP BY signup_date
ORDER BY signup_date;

-- --------------------------------------------------
-- 2. Active Users
-- Count users who performed at least one event
-- --------------------------------------------------
SELECT
    uniq(user_id) AS active_users
FROM events;

-- --------------------------------------------------
-- 3. Share of Returning Users
-- Calculate the share of users with at least one event after registration
-- --------------------------------------------------
SELECT
    uniq(e.user_id) / toFloat64(uniq(u.user_id)) AS return_rate
FROM users u
LEFT JOIN events e
    ON u.user_id = e.user_id;

-- --------------------------------------------------
-- 4. Average Events per User
-- Calculate the average number of events per user (only users with events)
-- --------------------------------------------------
SELECT
    avg(event_count) AS avg_events_per_user
FROM (
    SELECT
        user_id,
        count() AS event_count
    FROM events
    GROUP BY user_id
) t;

-- --------------------------------------------------
-- 5. Data Quality Checks
-- --------------------------------------------------

-- Users without events
SELECT
    count() AS users_without_events
FROM users u
LEFT JOIN events e
    ON u.user_id = e.user_id
WHERE e.user_id IS NULL;

-- Events without a corresponding user (referential integrity check)
SELECT
    count() AS orphan_events
FROM events e
LEFT JOIN users u
    ON e.user_id = u.user_id
WHERE u.user_id IS NULL;