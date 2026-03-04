-- Event generation for PostgreSQL
-- This query works in PostgreSQL because it uses random()

INSERT INTO events (event_id, user_id, event_time, event_type)
SELECT
    row_number() OVER () AS event_id,  -- Unique event identifier
    u.user_id,
    u.signup_date + (random() * 30)::INT,  -- Random date within 30 days after signup
    'activity'  -- Event type
FROM users u
WHERE random() < 0.7;  -- Randomly select ~70% of users

-- =====================================================================

-- Event generation for ClickHouse
-- This query is adapted for ClickHouse using rand() and cityHash64()

INSERT INTO events (event_id, user_id, event_time, event_type)
SELECT
    row_number() OVER () AS event_id,  -- Unique event identifier
    u.user_id,
    toDate(u.signup_date) + (rand() % 30),  -- Random date within 30 days after signup
    'activity'  -- Event type
FROM users u
WHERE cityHash64(toString(u.user_id)) % 100 < 70;  -- Deterministically select ~70% of users