-- This is a naive retention calculation example.
-- It measures weekly active users but does NOT calculate cohort-based retention.
-- Use this as a starting point before implementing proper cohort logic.
-- PostgreSQL uses DATE_TRUNC to round a date to the beginning of the week.

SELECT
    DATE_TRUNC('week', event_time) AS week,  -- Round date to start of week
    COUNT(DISTINCT user_id) AS active_users  -- Count unique users
FROM events
GROUP BY 1  -- Group by week
ORDER BY 1; -- Sort by week

-- =====================================================================

-- ClickHouse version:
-- ClickHouse uses toStartOfWeek to round a date to the beginning of the week.
-- Unique users are calculated using countDistinct().

SELECT
    toStartOfWeek(event_time) AS week,  -- Round date to start of week
    countDistinct(user_id) AS active_users  -- Count unique users
FROM events
GROUP BY week  -- Group by week
ORDER BY week; -- Sort by week

