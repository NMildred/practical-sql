-- ==========================================
-- Generate Users Dataset (PostgreSQL)
-- ==========================================

-- Insert random users into PostgreSQL users table
INSERT INTO users(user_id, signup_date)
SELECT
    ROW_NUMBER() OVER () AS user_id,                               -- Unique user ID (1 to 1000)
    DATE '2025-01-01'                                             -- Base date: Jan 1, 2025
        + INTERVAL '1 month' * (FLOOR(random() * 4)::int)        -- Random month offset within 0–3 months
        + INTERVAL '1 day' * (FLOOR(random() * 28)::int) AS signup_date  -- Random day within the selected month
FROM generate_series(1, 1000);                                    -- Generate 1000 users

-- ==========================================
-- Generate Users Dataset (ClickHouse)
-- ==========================================

-- Insert random users into ClickHouse users table
INSERT INTO users (user_id, signup_date)
SELECT
    number + 1 AS user_id,                                      -- Unique user ID (1 to 1000)
    addMonths(toDate('2025-01-01'), rand() % 4)                 -- Random cohort month within 4 months from Jan 2025
        + (rand() % 28) AS signup_date                           -- Random day within the selected month
FROM system.numbers
LIMIT 1000;                                                    -- Generate 1000 users