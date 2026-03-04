-- ==========================================
-- Generate Orders Dataset (PostgreSQL)
-- ==========================================

-- Insert random orders into PostgreSQL orders table
INSERT INTO orders(order_id, user_id, order_date, revenue, cost, refunded)
SELECT
    ROW_NUMBER() OVER () AS order_id,                         -- Unique order ID
    u.user_id,                                                -- User ID
    u.signup_date + (FLOOR(random() * 120)::int) AS order_date, -- Random day within 120 days after signup
    ROUND(20 + FLOOR(random() * 1481) + random(), 2) AS revenue, -- Revenue: 20–1500
    ROUND(
        (20 + FLOOR(random() * 1481) + random()) * (0.40 + FLOOR(random() * 41)/100.0), 2
    ) AS cost,                                                -- Cost: 40–80% of revenue
    CASE WHEN random() < 0.10 THEN 1 ELSE 0 END AS refunded  -- Refund flag: 10% chance
FROM (
    SELECT
        u.user_id,                                           -- User ID from users table
        u.signup_date,                                       -- User signup date
        gs.order_idx                                        -- Order index for generating multiple orders per user
    FROM users u
    CROSS JOIN LATERAL generate_series(1, (FLOOR(random() * 10) + 1)::int) AS gs(order_idx)  -- Generate 1–10 orders per user
) u;

-- ==========================================
-- Generate Orders Dataset (ClickHouse)
-- ==========================================

-- Insert random orders into ClickHouse orders table
INSERT INTO orders
SELECT
    rowNumberInAllBlocks() AS order_id,                              -- Unique order ID
    u.user_id,                                                        -- User ID from users table
    addDays(u.signup_date, rand(toUInt32(u.user_id * 100 + order_idx)) % 120) AS order_date,  -- Random day within 120 days after signup
    round(20 + rand(toUInt32(u.user_id * 200 + order_idx)) % 1481 + rand() / 4294967295, 2) AS revenue,  -- Revenue: 20–1500
    round(revenue * ((40 + rand(toUInt32(u.user_id * 300 + order_idx)) % 41) / 100.0), 2) AS cost,  -- Cost: 40–80% of revenue
    if(rand(toUInt32(u.user_id * 400 + order_idx)) % 100 < 10, 1, 0) AS refunded  -- Refund flag: 10% chance
FROM
(
    SELECT
        user_id,                                                     -- User ID
        signup_date,                                                 -- Signup date
        arrayJoin(range(rand() % 10 + 1)) AS order_idx               -- Generate 1–10 orders per user
    FROM users
) u;