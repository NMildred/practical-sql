/*
=========================================
Level 1 — Foundations
Solutions for ClickHouse
=========================================
*/

-- --------------------------------------------------
-- 1. Регистрации по дням
-- --------------------------------------------------
SELECT
    signup_date,
    count() AS users_registered
FROM users
GROUP BY signup_date
ORDER BY signup_date;


-- --------------------------------------------------
-- 2. Активные пользователи
-- --------------------------------------------------
SELECT
    uniq(user_id) AS active_users
FROM events;


-- --------------------------------------------------
-- 3. Доля вернувшихся пользователей
-- --------------------------------------------------
SELECT
    uniq(e.user_id) / toFloat64(uniq(u.user_id)) AS return_rate
FROM users u
LEFT JOIN events e
    ON u.user_id = e.user_id;


-- --------------------------------------------------
-- 4. Среднее количество событий на пользователя
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
-- 5. Проверка качества данных
-- --------------------------------------------------

-- Пользователи без событий
SELECT
    count() AS users_without_events
FROM users u
LEFT JOIN events e
    ON u.user_id = e.user_id
WHERE e.user_id IS NULL;

-- События без пользователя (проверка целостности)
SELECT
    count() AS orphan_events
FROM events e
LEFT JOIN users u
    ON e.user_id = u.user_id
WHERE u.user_id IS NULL;
