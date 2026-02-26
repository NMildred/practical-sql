-- User data generation for PostgreSQL
-- This query works in PostgreSQL because it uses random() and generate_series()

INSERT INTO users (user_id, signup_date)
SELECT
    id,
    DATE '2024-01-01' + (random() * 30)::INT  -- Generate a random date within 30 days
FROM generate_series(1, 1000) id;

-- =====================================================================

-- User data generation for ClickHouse
-- This query is adapted for ClickHouse using system.numbers and rand()

INSERT INTO users (user_id, signup_date)
SELECT
    number + 1,  -- Use values from system.numbers as user_id (1 to 1000)
    toDate('2025-01-01') + (rand() % 30)  -- Generate a random date within 30 days
FROM system.numbers
LIMIT 1000;