-- Ошибочный запрос для retention (не учитывает когорты)
SELECT
    DATE_TRUNC('week', event_time) AS week,
    COUNT(DISTINCT user_id) AS active_users
FROM events
GROUP BY 1
ORDER BY 1;
