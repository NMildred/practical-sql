-- This script demonstrates retention calculation using window functions.
-- Both PostgreSQL and ClickHouse versions are included for practice.
-- It calculates weekly retention for cohorts and cumulative retained users.
-- ================================================================

-- PostgreSQL query using window functions:

WITH cohorts AS (
    SELECT
        user_id,
        date_trunc('week', signup_date)::date AS cohort_week
    FROM users
),
activity AS (
    SELECT
        c.user_id,
        c.cohort_week,
        date_trunc('week', e.event_time)::date AS activity_week
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
    WHERE e.event_time::date >= c.cohort_week
),
distinct_activity AS (
    -- Remove duplicate users within the same week
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

-- =====================================================================

-- ClickHouse query using window functions:

WITH cohorts AS (
    SELECT
        user_id,
        toStartOfWeek(signup_date) AS cohort_week
    FROM users
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
    -- Remove duplicate users within the same week
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