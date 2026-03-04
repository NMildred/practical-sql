-- ==========================================
-- Table schemas for PostgreSQL
-- ==========================================

-- 1. Drop the orders table if it already exists
DROP TABLE IF EXISTS orders;

-- 2. Create the orders table to store user order information
CREATE TABLE orders
( 
    order_id    BIGINT PRIMARY KEY, -- Unique identifier for each order
    user_id     INT NOT NULL, -- User ID (links to the users table)
    order_date  DATE NOT NULL, -- Date when the order was placed
    revenue     DOUBLE PRECISION NOT NULL, -- Revenue generated from the order
    cost        DOUBLE PRECISION NOT NULL, -- Cost associated with the order
    refunded    SMALLINT NOT NULL -- Refund flag (1 = refunded, 0 = not refunded)
);

-- Optional: create an index for faster queries by user_id and order_date
CREATE INDEX idx_orders_user_date ON orders(user_id, order_date);

-- 3. Drop the users table if it already exists
DROP TABLE IF EXISTS users;

-- 4. Create the users table to store user signup information
CREATE TABLE users
(
    user_id      INT PRIMARY KEY, -- Unique identifier for each user
    signup_date  DATE NOT NULL -- Date when the user signed up
);

-- Optional: index for faster queries by signup_date
CREATE INDEX idx_users_signup_date ON users(signup_date);

-- ==========================================
-- Table schemas for ClickHouse
-- ==========================================

-- 1. Drop the orders table if it already exists
DROP TABLE IF EXISTS orders;

-- 2. Create the orders table to store user order information
CREATE TABLE IF NOT EXISTS orders
(
    order_id    UInt64, -- Unique identifier for each order
    user_id     UInt32, -- User ID (links to the users table)
    order_date  Date, -- Date when the order was placed
    revenue     Float64,  -- Revenue generated from the order
    cost        Float64,  -- Cost associated with the order
    refunded    UInt8 -- Refund flag (1 = refunded, 0 = not refunded)
)
-- 🔹 Using MergeTree engine for ClickHouse
-- 🔹 ORDER BY improves query performance on user_id and order_date
ENGINE = MergeTree()
ORDER BY (user_id, order_date);

-- 3. Drop the users table if it already exists
DROP TABLE IF EXISTS users;

-- 4. Create the users table to store users signup information
CREATE TABLE IF NOT EXISTS users
(
    user_id UInt32,
    signup_date Date
)
ENGINE = MergeTree()
ORDER BY (user_id);