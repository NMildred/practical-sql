-- This script calculates weekly cohort retention.
-- PostgreSQL and ClickHouse versions are included for practice.
-- It outputs the number of retained users per week for each cohort.
-- ================================================================
-- Correct PostgreSQL query accounting for cohorts:
-- PostgreSQL uses DATE_TRUNC to round dates to the start of the week.

WITH cohorts AS (
    SELECT
        user_id,
        signup_date,
        date_trunc('week', signup_date)::date AS cohort_week  -- Round signup date to the start of the week
    FROM users
),
activity AS (
    SELECT
        c.user_id,
        c.cohort_week,
        date_trunc('week', e.event_time)::date AS activity_week  -- Round event date to the start of the week
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
)
SELECT
    cohort_week,
    EXTRACT(WEEK FROM activity_week) - EXTRACT(WEEK FROM cohort_week) AS week_number,  -- Weeks since cohort
    COUNT(DISTINCT user_id) AS retained_users  -- Number of retained users
FROM activity
GROUP BY cohort_week, week_number
ORDER BY cohort_week, week_number;

-- =====================================================================

-- Correct ClickHouse query accounting for cohorts:
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
    dateDiff('week', cohort_week, activity_week) AS week_number,  -- Difference in weeks between cohort and activity
    COUNT(DISTINCT user_id) AS retained_users  -- Number of retained users
FROM activity
GROUP BY cohort_week, week_number
ORDER BY cohort_week, week_number;