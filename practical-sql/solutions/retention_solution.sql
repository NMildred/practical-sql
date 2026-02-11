
-- Решение задачи по retention
WITH cohorts AS (
    SELECT
        user_id,
        signup_date,
        DATE_TRUNC('week', signup_date) AS cohort_week
    FROM users
),
activity AS (
    SELECT
        c.cohort_week,
        DATE_TRUNC('week', e.event_time) AS activity_week,
        c.user_id
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
)
SELECT
    cohort_week,
    activity_week,
    COUNT(DISTINCT user_id) AS retained_users
FROM activity
GROUP BY 1, 2
ORDER BY 1, 2;
