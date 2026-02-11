-- Схема таблиц для пользователей и событий

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    signup_date DATE
);

CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    user_id INT,
    event_time TIMESTAMP,
    event_type TEXT
);
