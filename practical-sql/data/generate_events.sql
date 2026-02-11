-- Генерация событий
INSERT INTO events (user_id, event_time, event_type)
SELECT
    u.user_id,
    u.signup_date + (random() * 30)::INT,
    'activity'
FROM users u
WHERE random() < 0.7;
