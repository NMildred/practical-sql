-- 🔵 Level 3 — Solutions (Retention × LTV & Predictive LTV)

------------------------------------------------------------
-- Task 1: Retention Matrix per Cohort
-- Count retained users per cohort by lifetime month
WITH cohort_sizes AS
(
    SELECT
        toStartOfMonth(signup_date) AS cohort_month,
        COUNT(DISTINCT user_id) AS cohort_size
    FROM users
    GROUP BY cohort_month
)

SELECT
    toStartOfMonth(u.signup_date) AS cohort_month,

    dateDiff(
        'month',
        toStartOfMonth(u.signup_date),
        toStartOfMonth(o.order_date)
    ) AS lifetime_month,

    COUNT(DISTINCT o.user_id) AS retained_users,

    ROUND(COUNT(DISTINCT o.user_id) / cs.cohort_size, 3) AS retention_rate,

    SUM(o.revenue - o.cost) AS cohort_revenue,

    ROUND(SUM(o.revenue - o.cost) / cs.cohort_size, 2) AS ltv

FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
INNER JOIN cohort_sizes cs
    ON cs.cohort_month = toStartOfMonth(u.signup_date)

GROUP BY
    cohort_month,
    lifetime_month,
    cs.cohort_size

ORDER BY
    cohort_month,
    lifetime_month

------------------------------------------------------------
-- Task 2: LTV per Retained User
-- Average LTV per retained user for each cohort and lifetime month
WITH cohort_sizes AS
(
    SELECT
        toStartOfMonth(signup_date) AS cohort_month,
        COUNT(DISTINCT user_id) AS cohort_size
    FROM users
    GROUP BY cohort_month
)
SELECT
    toStartOfMonth(u.signup_date) AS cohort_month,
    dateDiff('month', toStartOfMonth(u.signup_date), toStartOfMonth(o.order_date)) AS lifetime_month,
    COUNT(DISTINCT o.user_id) AS retained_users,
    ROUND(SUM(if(o.refunded = 0, o.revenue - o.cost, 0)) / COUNT(DISTINCT o.user_id), 2) AS avg_ltv_per_retained_user
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
INNER JOIN cohort_sizes cs ON cs.cohort_month = toStartOfMonth(u.signup_date)
GROUP BY cohort_month, lifetime_month
ORDER BY cohort_month, lifetime_month;

------------------------------------------------------------
-- Task 3: Predictive LTV
-- Cumulative LTV and a simple predictive model using exponential decay
WITH user_profit AS
(
    SELECT
        o.user_id,
        toStartOfMonth(u.signup_date) AS cohort_month,
        dateDiff('month', toStartOfMonth(u.signup_date), toStartOfMonth(o.order_date)) AS lifetime_month,
        SUM(if(o.refunded = 0, o.revenue - o.cost, 0)) AS profit
    FROM orders o
    INNER JOIN users u ON o.user_id = u.user_id
    GROUP BY o.user_id, cohort_month, lifetime_month
)
SELECT
    cohort_month,
    lifetime_month,
    SUM(profit) AS cumulative_ltv,
    SUM(profit) / COUNT(DISTINCT user_id) AS avg_ltv_per_user,
    SUM(profit) / COUNT(DISTINCT user_id) * EXP(-0.1 * lifetime_month) AS predictive_ltv
FROM user_profit
GROUP BY cohort_month, lifetime_month
ORDER BY cohort_month, lifetime_month;

------------------------------------------------------------
-- Task 4: Insights Queries (Written)
-- Example queries to answer reflective questions

-- 1. Cohort with best retention at month 1
SELECT cohort_month, ROUND(retention_rate, 3) AS retention_m1
FROM (
    WITH cohort_sizes AS
    (
        SELECT toStartOfMonth(signup_date) AS cohort_month,
               COUNT(DISTINCT user_id) AS cohort_size
        FROM users
        GROUP BY cohort_month
    )
    SELECT
        toStartOfMonth(u.signup_date) AS cohort_month,
        COUNT(DISTINCT o.user_id) / cs.cohort_size AS retention_rate
    FROM orders o
    INNER JOIN users u ON o.user_id = u.user_id
    INNER JOIN cohort_sizes cs ON cs.cohort_month = toStartOfMonth(u.signup_date)
    WHERE dateDiff('month', toStartOfMonth(u.signup_date), toStartOfMonth(o.order_date)) = 1
    GROUP BY cohort_month, cs.cohort_size
) 
ORDER BY retention_m1 DESC
LIMIT 1;

-- 2. Check correlation between retention and average LTV
SELECT
    cohort_month,
    SUM(if(o.refunded = 0, o.revenue - o.cost, 0)) / COUNT(DISTINCT o.user_id) AS avg_ltv_per_retained_user,
    COUNT(DISTINCT o.user_id) / cs.cohort_size AS retention_rate
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
INNER JOIN (
    SELECT toStartOfMonth(signup_date) AS cohort_month, COUNT(DISTINCT user_id) AS cohort_size
    FROM users
    GROUP BY cohort_month
) cs ON cs.cohort_month = toStartOfMonth(u.signup_date)
GROUP BY cohort_month, cs.cohort_size
ORDER BY cohort_month;

-- 3. Patterns in early vs late lifetime months
-- Compare retention and average LTV for first 6 vs last 6 lifetime months
WITH cohort_data AS
(
    SELECT
        toStartOfMonth(u.signup_date) AS cohort_month,
        dateDiff('month', toStartOfMonth(u.signup_date), toStartOfMonth(o.order_date)) AS lifetime_month,
        COUNT(DISTINCT o.user_id) AS retained_users,
        SUM(if(o.refunded = 0, o.revenue - o.cost, 0)) / COUNT(DISTINCT o.user_id) AS avg_ltv_per_retained_user
    FROM orders o
    INNER JOIN users u ON o.user_id = u.user_id
    GROUP BY cohort_month, lifetime_month
)
SELECT
    cohort_month,
    lifetime_month,
    retained_users,
    ROUND(avg_ltv_per_retained_user, 2) AS avg_ltv_per_user,
    CASE
        WHEN lifetime_month <= 6 THEN 'Early months'
        ELSE 'Late months'
    END AS period
FROM cohort_data
ORDER BY cohort_month, lifetime_month;

------------------------------------------------------------
-- 4. Improve predictive LTV models using more data
-- Example: cumulative LTV including all lifetime months, can be fed into ML/stat models
WITH user_profit AS
(
    SELECT
        o.user_id,
        toStartOfMonth(u.signup_date) AS cohort_month,
        dateDiff('month', toStartOfMonth(u.signup_date), toStartOfMonth(o.order_date)) AS lifetime_month,
        SUM(if(o.refunded = 0, o.revenue - o.cost, 0)) AS profit
    FROM orders o
    INNER JOIN users u ON o.user_id = u.user_id
    GROUP BY o.user_id, cohort_month, lifetime_month
)
SELECT
    cohort_month,
    lifetime_month,
    SUM(profit) OVER (PARTITION BY cohort_month ORDER BY lifetime_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_ltv
FROM user_profit
ORDER BY cohort_month, lifetime_month;