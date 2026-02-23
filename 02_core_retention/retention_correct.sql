-- ================================================================
-- Правильный запрос для PostgreSQL с учётом когорт:
-- В PostgreSQL используется функция DATE_TRUNC для округления даты до начала недели.


WITH cohorts AS (
    SELECT
        user_id,
        signup_date,
        DATE_TRUNC('week', signup_date) AS cohort_week  -- Округление даты регистрации до начала недели.
    FROM users
),
activity AS (
    SELECT
        c.cohort_week,
        DATE_TRUNC('week', e.event_time) AS activity_week,  -- Округление даты события до начала недели.
        c.user_id
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
)
SELECT
    cohort_week,
    activity_week,
    COUNT(DISTINCT user_id) AS retained_users  -- Подсчёт уникальных пользователей, оставшихся в когорт.
FROM activity
GROUP BY 1, 2  -- Группировка по неделям когорт и активности.
ORDER BY 1, 2;  -- Сортировка по неделям когорт и активности.

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
    activity_week,
    COUNT(DISTINCT user_id) AS retained_users  -- Подсчёт уникальных пользователей, оставшихся в когорт.
FROM activity
GROUP BY cohort_week, activity_week  -- Группировка по неделям когорт и активности.
ORDER BY cohort_week, activity_week;  -- Сортировка по неделям когорт и активности.
