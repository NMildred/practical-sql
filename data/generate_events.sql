-- Генерация событий для PostgreSQL
-- Этот запрос работает в PostgreSQL, так как используется функция random()

INSERT INTO events (event_id, user_id, event_time, event_type)
SELECT
    row_number() OVER () AS event_id,  -- уникальный идентификатор события
    u.user_id,
    u.signup_date + (random() * 30)::INT,  -- случайная дата в пределах 30 дней
    'activity'  -- Тип события
FROM users u
WHERE random() < 0.7;  -- случайный выбор 70% пользователей
-- =====================================================================

-- Генерация событий для ClickHouse
-- Этот запрос адаптирован для ClickHouse, используется функция rand() и cityHash64()

INSERT INTO events (event_id, user_id, event_time, event_type)
SELECT
    row_number() OVER () AS event_id,  -- уникальный идентификатор события
    u.user_id,
    toDate(u.signup_date) + (rand() % 30),  -- случайная дата в пределах 30 дней
    'activity'  -- Тип события
FROM users u
WHERE cityHash64(toString(u.user_id)) % 100 < 70;  -- 70% случайных пользователей