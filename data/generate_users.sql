-- Генерация пользователей для PostgreSQL
-- Этот запрос работает в PostgreSQL, так как используется функция random() и generate_series()

INSERT INTO users (user_id, signup_date)
SELECT
    id,
    DATE '2024-01-01' + (random() * 30)::INT  -- Генерация случайной даты в пределах 30 дней
FROM generate_series(1, 1000) id;

-- =====================================================================

-- Генерация пользователей для ClickHouse
-- Этот запрос адаптирован для ClickHouse, используется system.numbers и rand()

INSERT INTO users (user_id, signup_date)
SELECT
    number + 1,  -- Используем значение из system.numbers для user_id (от 1 до 1000)
    toDate('2025-01-01') + (rand() % 30)  -- Генерация случайной даты в пределах 30 дней
FROM system.numbers
LIMIT 1000;