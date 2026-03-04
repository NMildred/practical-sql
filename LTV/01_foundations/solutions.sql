-- 🟢 Level 1 — Solutions (Updated for production-style data)

------------------------------------------------------------
-- Task 1: Historical LTV per User
-- Calculate net profit (LTV) for each user, considering only non-refunded orders
SELECT
    user_id,
    SUM(if(refunded = 0, revenue - cost, 0)) AS ltv
FROM orders
GROUP BY user_id
ORDER BY ltv DESC;

------------------------------------------------------------
-- Task 2: Top 5 Users by LTV
-- Take the LTV calculation from Task 1 and find top 5 users
SELECT *
FROM (
    SELECT
        user_id,
        SUM(if(refunded = 0, revenue - cost, 0)) AS ltv
    FROM orders
    GROUP BY user_id
) AS user_ltv
ORDER BY ltv DESC
LIMIT 5;

------------------------------------------------------------
-- Task 3: Data Check (Written)
-- These queries help answer the reflective questions

-- 1. Users with zero LTV
SELECT COUNT(*) AS zero_ltv_users
FROM (
    SELECT user_id, SUM(if(refunded = 0, revenue - cost, 0)) AS ltv
    FROM orders
    GROUP BY user_id
) AS t
WHERE ltv = 0;

-- 2. Users with negative profit
SELECT COUNT(*) AS negative_ltv_users
FROM (
    SELECT user_id, SUM(if(refunded = 0, revenue - cost, 0)) AS ltv
    FROM orders
    GROUP BY user_id
) AS t
WHERE ltv < 0;

-- 3. Check effect of refunds on overall LTV
SELECT
    SUM(revenue - cost) AS total_profit_including_refunds,
    SUM(if(refunded = 0, revenue - cost, 0)) AS total_profit_excluding_refunds
FROM orders;

-- 4. Potential issues (conceptual, to note separately)
-- Examples: high refund rates, missing orders, incorrect cost data, extreme outliers