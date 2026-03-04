-- ================================================================
-- Level 3 — Advanced Cases (Senior)
-- Retention for Active Users Only
-- PostgreSQL and ClickHouse
-- ================================================================

-- ================================================================
-- PostgreSQL Version
-- Retention only for users with more than one event
-- ================================================================

WITH active_users AS (
    -- Identify users with more than one event
    SELECT user_id
    FROM events
    GROUP BY user_id
    HAVING COUNT(*) > 1
),
cohorts AS (
    -- Define cohort as the week of signup for active users
    SELECT u.user_id, date_trunc('week', u.signup_date)::date AS cohort_week
    FROM users u
    JOIN active_users a ON u.user_id = a.user_id
),
activity AS (
    -- Get events for active users, rounded to week
    SELECT 
        c.user_id,
        c.cohort_week,
        date_trunc('week', e.event_time)::date AS activity_week
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
    WHERE e.event_time::date >= c.cohort_week
),
distinct_activity AS (
    -- Remove duplicate events per user per week
    SELECT DISTINCT cohort_week, activity_week, user_id
    FROM activity
),
weekly_retention AS (
    -- Calculate weekly retention
    SELECT
        cohort_week,
        activity_week,
        COUNT(user_id) AS retained_users_week
    FROM distinct_activity
    GROUP BY cohort_week, activity_week
)
-- Final result with cumulative retention
SELECT
    cohort_week,
    activity_week,
    retained_users_week,
    SUM(retained_users_week) OVER (
        PARTITION BY cohort_week
        ORDER BY activity_week
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_retained_users
FROM weekly_retention
ORDER BY cohort_week, activity_week;

-- ================================================================
-- ClickHouse Version
-- Retention only for active users (more than one event)
-- ================================================================

WITH active_users AS (
    SELECT user_id
    FROM events
    GROUP BY user_id
    HAVING COUNT(*) > 1  -- More than one event
),
cohorts AS (
    SELECT
        u.user_id,
        toStartOfWeek(u.signup_date) AS cohort_week
    FROM users u
    JOIN active_users a ON u.user_id = a.user_id
),
activity AS (
    SELECT
        c.user_id,
        c.cohort_week,
        toStartOfWeek(e.event_time) AS activity_week
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
    WHERE e.event_time >= c.cohort_week
),
distinct_activity AS (
    SELECT DISTINCT cohort_week, activity_week, user_id
    FROM activity
),
weekly_retention AS (
    SELECT
        cohort_week,
        activity_week,
        COUNT(user_id) AS retained_users_week
    FROM distinct_activity
    GROUP BY cohort_week, activity_week
)
SELECT
    cohort_week,
    activity_week,
    retained_users_week,
    SUM(retained_users_week) OVER (
        PARTITION BY cohort_week
        ORDER BY activity_week
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_retained_users
FROM weekly_retention
ORDER BY cohort_week, activity_week;