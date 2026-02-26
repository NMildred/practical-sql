-- This script calculates cohort-based weekly retention.
-- PostgreSQL and ClickHouse versions are included for practice.
-- ================================================================

-- PostgreSQL uses DATE_TRUNC to round dates to the start of the week.

WITH cohorts AS (
    SELECT
        user_id,
        signup_date,
        DATE_TRUNC('week', signup_date) AS cohort_week  -- Round signup date to the start of the week
    FROM users
),
activity AS (
    SELECT
        c.cohort_week,
        DATE_TRUNC('week', e.event_time) AS activity_week,  -- Round event date to the start of the week
        c.user_id
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
)
SELECT
    cohort_week,
    activity_week,
    COUNT(DISTINCT user_id) AS retained_users  -- Count unique users retained in each cohort
FROM activity
GROUP BY 1, 2  -- Group by cohort and activity weeks
ORDER BY 1, 2;  -- Sort by cohort and activity weeks

-- =====================================================================

-- ClickHouse uses toStartOfWeek to round dates to the start of the week.

WITH cohorts AS (
    SELECT
        user_id,
        signup_date,
        toStartOfWeek(signup_date) AS cohort_week  -- Round signup date to the start of the week
    FROM users
),
activity AS (
    SELECT
        c.cohort_week,
        toStartOfWeek(e.event_time) AS activity_week,  -- Round event date to the start of the week
        c.user_id
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
)
SELECT
    cohort_week,
    activity_week,
    COUNT(DISTINCT user_id) AS retained_users  -- Count unique users retained in each cohort
FROM activity
GROUP BY cohort_week, activity_week  -- Group by cohort and activity weeks
ORDER BY cohort_week, activity_week;  -- Sort by cohort and activity weeks