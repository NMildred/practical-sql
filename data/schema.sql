-- Схема таблиц для PostgreSQL

-- Таблица пользователей
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,  -- Автоматически увеличиваемый идентификатор пользователя
    signup_date DATE            -- Дата регистрации
);

-- Таблица событий
CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,  -- Автоматически увеличиваемый идентификатор события
    user_id INT,                  -- Идентификатор пользователя
    event_time TIMESTAMP,         -- Время события
    event_type TEXT               -- Тип события (например, 'activity', 'click', 'purchase')
);

-- Схема таблиц для ClickHouse

-- Таблица пользователей
CREATE TABLE users (
    user_id Int32,
    signup_date Date
) ENGINE = MergeTree()
ORDER BY user_id;

CREATE TABLE events (
    event_id Int32,
    user_id Int32,
    event_time DateTime,
    event_type String
) ENGINE = MergeTree()
ORDER BY event_id;