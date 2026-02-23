-- ================================================================
-- Правильный запрос для PostgreSQL с учётом когорт:
-- В PostgreSQL используется функция DATE_TRUNC для округления даты до начала недели.


WITH cohorts AS (
    SELECT
        user_id,
        signup_date,
        date_trunc('week', signup_date)::date AS cohort_week  -- округление до начала недели
    FROM users
),
activity AS (
    SELECT
        c.user_id,
        c.cohort_week,
        date_trunc('week', e.event_time)::date AS activity_week  -- округление даты события
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
)
SELECT
    cohort_week,
    EXTRACT(WEEK FROM activity_week) - EXTRACT(WEEK FROM cohort_week) AS week_number,
    COUNT(DISTINCT user_id) AS retained_users
FROM activity
GROUP BY cohort_week, week_number
ORDER BY cohort_week, week_number;

-- =====================================================================

-- Правильный запрос для ClickHouse с учётом когорт:
-- В ClickHouse используется функция toStartOfWeek для округления даты до начала недели.


WITH cohorts AS (
    SELECT
        user_id,
        signup_date,
        toStartOfWeek(signup_date) AS cohort_week  -- Округление даты регистрации до начала недели (ClickHouse).
    FROM users
),
activity AS (
    SELECT
        c.cohort_week,
        toStartOfWeek(e.event_time) AS activity_week,  -- Округление даты события до начала недели (ClickHouse).
        c.user_id
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
)
SELECT
    cohort_week,
    dateDiff('week', cohort_week, activity_week) AS week_number,  -- Разница в неделях между датами
    COUNT(DISTINCT user_id) AS retained_users
FROM activity
GROUP BY cohort_week, week_number
ORDER BY cohort_week, week_number;
