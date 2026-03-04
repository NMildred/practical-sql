-- 🟡 Level 2 — Solutions (Cohort Analysis & Average LTV)

------------------------------------------------------------
-- Task 1: LTV per User with Cohorts
-- Calculate net profit (LTV) per user along with cohort month
SELECT
    o.user_id,
    toStartOfMonth(u.signup_date) AS cohort_month,
    SUM(if(o.refunded = 0, o.revenue - o.cost, 0)) AS ltv
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
GROUP BY o.user_id, cohort_month
ORDER BY cohort_month, ltv DESC;

-- Calculate net profit (LTV) per user along with cohort week
SELECT
    o.user_id,
    toStartOfWeek(u.signup_date) AS cohort_week,
    SUM(if(o.refunded = 0, o.revenue - o.cost, 0)) AS ltv
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
GROUP BY
    o.user_id,
    cohort_week
ORDER BY
    cohort_week,
    ltv DESC;
------------------------------------------------------------
-- Task 2: Average and Median LTV per Cohort
-- Calculate average and median LTV for each cohort month
WITH user_ltv AS
(
    SELECT
        o.user_id,
        toStartOfMonth(u.signup_date) AS cohort_month,
        SUM(if(o.refunded = 0, o.revenue - o.cost, 0)) AS ltv
    FROM orders o
    INNER JOIN users u ON o.user_id = u.user_id
    GROUP BY o.user_id, cohort_month
)
SELECT
    cohort_month,
    ROUND(AVG(ltv), 2) AS avg_ltv,
    ROUND(quantile(0.5)(ltv), 2) AS median_ltv
FROM user_ltv
GROUP BY cohort_month
ORDER BY cohort_month;

------------------------------------------------------------
-- Task 3: Cohort Insights (Written)
-- Example queries to answer reflective questions

-- 1. Cohort with highest average LTV
SELECT cohort_month, AVG(ltv) AS avg_ltv
FROM (
    SELECT
        o.user_id,
        toStartOfMonth(u.signup_date) AS cohort_month,
        SUM(if(o.refunded = 0, o.revenue - o.cost, 0)) AS ltv
    FROM orders o
    INNER JOIN users u ON o.user_id = u.user_id
    GROUP BY o.user_id, cohort_month
) AS user_ltv
GROUP BY cohort_month
ORDER BY avg_ltv DESC
LIMIT 1;

-- 2. Cohorts with unusually high or low LTV
WITH cohort_stats AS
(
    SELECT 
        cohort_month,
        AVG(ltv) AS avg_ltv
    FROM
    (
        SELECT
            o.user_id,
            toStartOfMonth(u.signup_date) AS cohort_month,
            SUM(if(o.refunded = 0, o.revenue - o.cost, 0)) AS ltv
        FROM orders o
        INNER JOIN users u ON o.user_id = u.user_id
        GROUP BY o.user_id, cohort_month
    )
    GROUP BY cohort_month
),
stats AS
(
    SELECT 
        AVG(avg_ltv) AS mean_ltv,
        stddevPop(avg_ltv) AS std_ltv
    FROM cohort_stats
)

SELECT *
FROM cohort_stats
CROSS JOIN stats
WHERE avg_ltv > mean_ltv + std_ltv
   OR avg_ltv < mean_ltv - std_ltv
ORDER BY avg_ltv;

-- 3. Effect of refunds on cohort-level LTV
SELECT
    toStartOfMonth(u.signup_date) AS cohort_month,
    SUM(o.revenue - o.cost) AS total_ltv_including_refunds,
    SUM(if(o.refunded = 0, o.revenue - o.cost, 0)) AS total_ltv_excluding_refunds
FROM orders o
INNER JOIN users u 
    ON o.user_id = u.user_id
GROUP BY cohort_month
ORDER BY cohort_month;

-- 4. Why is **median LTV** sometimes better than average LTV?
Median LTV is sometimes better than average LTV because it is robust to outliers. 
In businesses where a small number of users generate extremely high revenue, 
the average can be misleading, while the median better reflects the typical user value.