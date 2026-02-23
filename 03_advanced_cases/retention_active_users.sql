-- 03_advanced_cases/solutions/retention_active_users.sql
-- PostgreSQL

WITH active_users AS (
    -- Находим пользователей с более чем одним событием
    SELECT user_id
    FROM events
    GROUP BY user_id
    HAVING COUNT(*) > 1
),
cohorts AS (
    -- Фиксируем когорту по неделе регистрации для активных пользователей
    SELECT u.user_id, date_trunc('week', u.signup_date)::date AS cohort_week
    FROM users u
    JOIN active_users a ON u.user_id = a.user_id
),
activity AS (
    -- Берем события активных пользователей, округляем дату события до недели
    SELECT 
        c.user_id,
        c.cohort_week,
        date_trunc('week', e.event_time)::date AS activity_week
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
    WHERE e.event_time::date >= c.cohort_week
),
distinct_activity AS (
    -- Убираем повторные события одного пользователя в одной неделе
    SELECT DISTINCT cohort_week, activity_week, user_id
    FROM activity
),
weekly_retention AS (
    -- Подсчет retention по каждой неделе
    SELECT
        cohort_week,
        activity_week,
        COUNT(user_id) AS retained_users_week
    FROM distinct_activity
    GROUP BY cohort_week, activity_week
)
-- Финальный результат с кумулятивным retention
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

-- Retention только для "активных" пользователей (больше одного события) ClickHouse

WITH active_users AS (
    SELECT user_id
    FROM events
    GROUP BY user_id
    HAVING COUNT(*) > 1  -- больше одного события
),
cohorts AS (
    SELECT
        u.user_id,
        date_trunc('week', u.signup_date)::date AS cohort_week
    FROM users u
    JOIN active_users a ON u.user_id = a.user_id
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
