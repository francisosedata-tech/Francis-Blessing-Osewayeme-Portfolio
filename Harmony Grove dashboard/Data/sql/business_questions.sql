-- ============================================================
-- HARMONY GROVE - Business Question Queries
-- ============================================================

-- ------------------------------------------------------------
-- Q1: Does client rating predict tutor churn?
-- ------------------------------------------------------------
WITH tutor_avg_rating AS (
    SELECT
        tutor_id,
        AVG(client_rating) AS avg_rating,
        COUNT(*) AS n_rated_sessions
    FROM bookings
    WHERE client_rating IS NOT NULL
    GROUP BY tutor_id
)
SELECT
    CASE
        WHEN tar.avg_rating >= 4.5 THEN '4.5 - 5.0'
        WHEN tar.avg_rating >= 4.0 THEN '4.0 - 4.49'
        WHEN tar.avg_rating >= 3.5 THEN '3.5 - 3.99'
        WHEN tar.avg_rating >= 3.0 THEN '3.0 - 3.49'
        ELSE 'Below 3.0'
    END AS rating_bucket,
    COUNT(*) AS total_tutors,
    SUM(CASE WHEN t.status = 'Inactive' THEN 1 ELSE 0 END) AS churned_tutors,
    ROUND(
        SUM(CASE WHEN t.status = 'Inactive' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1
    ) AS churn_rate_pct
FROM tutor_avg_rating tar
JOIN tutors t ON tar.tutor_id = t.tutor_id
GROUP BY rating_bucket
ORDER BY rating_bucket DESC;


-- ------------------------------------------------------------
-- Q2: Why are tutors leaving? (exit reason breakdown)
-- ------------------------------------------------------------
SELECT
    exit_reason,
    COUNT(*) AS n_tutors,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct_of_exits
FROM tutors
WHERE status = 'Inactive'
GROUP BY exit_reason
ORDER BY n_tutors DESC;


-- ------------------------------------------------------------
-- Q3: Which segment and lesson type drive the most revenue?
-- ------------------------------------------------------------
SELECT
    c.segment,
    b.lesson_type,
    COUNT(*) AS total_bookings,
    SUM(b.price_naira) AS total_revenue_naira
FROM bookings b
JOIN clients c ON b.client_id = c.client_id
WHERE b.status = 'Completed'
GROUP BY c.segment, b.lesson_type
ORDER BY total_revenue_naira DESC;

-- Revenue split by source (Booking / Corporate Contract / Subscription)
SELECT 'Bookings' AS revenue_source, SUM(price_naira) AS revenue
FROM bookings WHERE status = 'Completed' AND contract_id IS NULL
UNION ALL
SELECT 'Corporate Contracts', SUM(ct.contract_value_naira)
FROM corporate_contracts ct
UNION ALL
SELECT 'Subscriptions', SUM(price_naira)
FROM subscriptions
ORDER BY revenue DESC;


-- ------------------------------------------------------------
-- Q4: Corporate contract utilization - are pre-paid sessions used?
-- ------------------------------------------------------------
SELECT
    ct.status,
    SUM(ct.sessions_included) AS total_sessions_included,
    COUNT(b.booking_id) AS total_sessions_used,
    ROUND(COUNT(b.booking_id) * 100.0 / SUM(ct.sessions_included), 2) AS utilization_rate_pct
FROM corporate_contracts ct
LEFT JOIN bookings b
    ON b.contract_id = ct.contract_id
    AND b.status = 'Completed'
GROUP BY ct.status
ORDER BY utilization_rate_pct DESC;


-- ------------------------------------------------------------
-- Q5: Which referral source drives the most client engagement?
-- ------------------------------------------------------------
SELECT
    c.referral_source,
    COUNT(DISTINCT c.client_id) AS total_clients,
    COUNT(b.booking_id) AS total_completed_bookings,
    ROUND(COUNT(b.booking_id) * 1.0 / COUNT(DISTINCT c.client_id), 2) AS avg_bookings_per_client
FROM clients c
LEFT JOIN bookings b ON c.client_id = b.client_id AND b.status = 'Completed'
GROUP BY c.referral_source
ORDER BY avg_bookings_per_client DESC;


-- ------------------------------------------------------------
-- Bonus: Subscription renewal rate by plan
-- ------------------------------------------------------------
SELECT
    plan,
    COUNT(*) AS total_subscriptions,
    SUM(CASE WHEN renewed_flag = 1 THEN 1 ELSE 0 END) AS renewed_count,
    ROUND(SUM(CASE WHEN renewed_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS renewal_rate_pct
FROM subscriptions
GROUP BY plan
ORDER BY renewal_rate_pct DESC;
