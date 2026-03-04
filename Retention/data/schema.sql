-- Table schema for PostgreSQL

-- Users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,  -- Auto-incrementing user identifier
    signup_date DATE             -- Registration date
);

-- Events table
CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,  -- Auto-incrementing event identifier
    user_id INT,                  -- User identifier
    event_time TIMESTAMP,         -- Event timestamp
    event_type TEXT               -- Event type (e.g., 'activity', 'click', 'purchase')
);

-- Table schema for ClickHouse

-- Users table
CREATE TABLE users (
    user_id Int32,
    signup_date Date
) ENGINE = MergeTree()
ORDER BY user_id;

-- Events table
CREATE TABLE events (
    event_id Int32,
    user_id Int32,
    event_time DateTime,
    event_type String
) ENGINE = MergeTree()
ORDER BY event_id;