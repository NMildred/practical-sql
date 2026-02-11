-- Генерация пользователей
INSERT INTO users (user_id, signup_date)
SELECT
    id,
    DATE '2024-01-01' + (random() * 30)::INT
FROM generate_series(1, 1000) id;
