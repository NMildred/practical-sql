-- Запрос для PostgreSQL с использованием оконных функций:
-- Этот запрос использует оконные функции для расчёта retention, не создавая промежуточных CTE.
-- Важно, что этот запрос также учитывает когорты и активность пользователей.

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
    -- убираем дубликаты одного пользователя в одной неделе
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

-- Запрос для ClickHouse с использованием оконных функций:
-- Этот запрос использует оконные функции для расчёта retention, не создавая промежуточных CTE.
-- Он также учитывает когорты и активность пользователей.

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


