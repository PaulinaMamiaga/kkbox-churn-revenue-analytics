-- LAYER: RAW_LAYER (Validation Phase)
-- INSPECT OUTLIERS IN RAW TABLES
-- OBJECTIVE: Identify extreme or suspicious values in key business metrics
--            before cleaning, feature engineering, and revenue analysis.

-------------------------------------------------------------------------------
-- STEP 1: Transaction Amount Outliers
-- Objective: Detect unusually high or suspicious payment amounts.
-------------------------------------------------------------------------------

SELECT
    msno AS customer_id,
    payment_plan_days,
    plan_list_price,
    actual_amount_paid,
    transaction_date
FROM `kkbox_raw.transactions_raw`
WHERE actual_amount_paid > 500
ORDER BY actual_amount_paid DESC;


-------------------------------------------------------------------------------
-- STEP 2: Subscription Duration Outliers
-- Objective: Detect unrealistic or extreme subscription plan durations.
-------------------------------------------------------------------------------

SELECT
    msno AS customer_id,
    payment_plan_days,
    actual_amount_paid,
    transaction_date
FROM `kkbox_raw.transactions_raw`
WHERE payment_plan_days > 365
   OR payment_plan_days < 0
ORDER BY payment_plan_days DESC;


-------------------------------------------------------------------------------
-- STEP 3: Age Outliers
-- Objective: Detect unrealistic customer ages in the demographic table.
-------------------------------------------------------------------------------

SELECT
    msno AS customer_id,
    bd AS customer_age,
    city,
    gender
FROM `kkbox_raw.members_raw`
WHERE bd > 100
   OR bd < 0
ORDER BY bd DESC;


-------------------------------------------------------------------------------
-- STEP 4: Listening Activity Outliers
-- Objective: Detect unusually high listening activity or playback duration.
-------------------------------------------------------------------------------

SELECT
    msno AS customer_id,
    date AS activity_date,
    num_100,
    total_secs
FROM `kkbox_raw.user_logs_raw`
WHERE total_secs > 86400
ORDER BY total_secs DESC;


-------------------------------------------------------------------------------
-- STEP 5: Extreme Playback Counts
-- Objective: Identify potentially abnormal listening behavior.
-------------------------------------------------------------------------------

SELECT
    msno AS customer_id,
    date AS activity_date,
    num_25,
    num_50,
    num_75,
    num_985,
    num_100
FROM `kkbox_raw.user_logs_raw`
WHERE num_100 > 1000
ORDER BY num_100 DESC;


-------------------------------------------------------------------------------
-- STEP 6: Revenue Distribution Summary
-- Objective: Quick statistical overview of transaction amounts.
-------------------------------------------------------------------------------

SELECT
    MIN(actual_amount_paid) AS min_amount_paid,
    MAX(actual_amount_paid) AS max_amount_paid,
    ROUND(AVG(actual_amount_paid), 2) AS avg_amount_paid,
    APPROX_QUANTILES(actual_amount_paid, 100)[OFFSET(50)] AS median_amount_paid,
    APPROX_QUANTILES(actual_amount_paid, 100)[OFFSET(95)] AS p95_amount_paid,
    APPROX_QUANTILES(actual_amount_paid, 100)[OFFSET(99)] AS p99_amount_paid
FROM `kkbox_raw.transactions_raw`;


-------------------------------------------------------------------------------
-- STEP 7: Customer Age Distribution Summary
-- Objective: Understand demographic spread and detect suspicious ranges.
-------------------------------------------------------------------------------

SELECT
    MIN(bd) AS min_age,
    MAX(bd) AS max_age,
    ROUND(AVG(bd), 2) AS avg_age,
    APPROX_QUANTILES(bd, 100)[OFFSET(50)] AS median_age,
    APPROX_QUANTILES(bd, 100)[OFFSET(95)] AS p95_age
FROM `kkbox_raw.members_raw`
WHERE bd IS NOT NULL;
