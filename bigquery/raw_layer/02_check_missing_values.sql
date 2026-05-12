-- LAYER: RAW_LAYER (Validation Phase)
-- CHECK MISSING VALUES IN RAW TABLES
-- OBJECTIVE: Identify missing values in critical business and analytical fields
--            across the raw source tables before cleaning and feature engineering.

-------------------------------------------------------------------------------
-- STEP 1: Missing Values — Train Labels Table
-- Objective: Validate target integrity for churn analysis.
-------------------------------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,
    
    COUNTIF(msno IS NULL) AS missing_customer_id,
    
    COUNTIF(is_churn IS NULL) AS missing_churn_label,

    ROUND(COUNTIF(msno IS NULL) / COUNT(*) * 100, 2) AS missing_customer_id_pct,
    
    ROUND(COUNTIF(is_churn IS NULL) / COUNT(*) * 100, 2) AS missing_churn_label_pct

FROM `kkbox_raw.train_raw`;


-------------------------------------------------------------------------------
-- STEP 2: Missing Values — Members Table
-- Objective: Validate demographic and subscription metadata completeness.
-------------------------------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,

    COUNTIF(msno IS NULL) AS missing_customer_id,
    
    COUNTIF(city IS NULL) AS missing_city,
    
    COUNTIF(bd IS NULL) AS missing_age,
    
    COUNTIF(gender IS NULL) AS missing_gender,
    
    COUNTIF(registered_via IS NULL) AS missing_registration_channel,
    
    COUNTIF(registration_init_time IS NULL) AS missing_registration_date,

    ROUND(COUNTIF(city IS NULL) / COUNT(*) * 100, 2) AS missing_city_pct,
    
    ROUND(COUNTIF(gender IS NULL) / COUNT(*) * 100, 2) AS missing_gender_pct

FROM `kkbox_raw.members_raw`;


-------------------------------------------------------------------------------
-- STEP 3: Missing Values — Transactions Table
-- Objective: Validate financial and subscription transaction completeness.
-------------------------------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,

    COUNTIF(msno IS NULL) AS missing_customer_id,
    
    COUNTIF(payment_method_id IS NULL) AS missing_payment_method,
    
    COUNTIF(payment_plan_days IS NULL) AS missing_plan_days,
    
    COUNTIF(plan_list_price IS NULL) AS missing_plan_price,
    
    COUNTIF(actual_amount_paid IS NULL) AS missing_amount_paid,
    
    COUNTIF(transaction_date IS NULL) AS missing_transaction_date,
    
    COUNTIF(membership_expire_date IS NULL) AS missing_expiration_date,
    
    COUNTIF(is_cancel IS NULL) AS missing_cancel_flag,

    ROUND(COUNTIF(actual_amount_paid IS NULL) / COUNT(*) * 100, 2) AS missing_amount_paid_pct

FROM `kkbox_raw.transactions_raw`;


-------------------------------------------------------------------------------
-- STEP 4: Missing Values — User Logs Table
-- Objective: Validate listening activity completeness for behavioral analysis.
-------------------------------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,

    COUNTIF(msno IS NULL) AS missing_customer_id,
    
    COUNTIF(date IS NULL) AS missing_activity_date,
    
    COUNTIF(num_25 IS NULL) AS missing_num_25,
    
    COUNTIF(num_50 IS NULL) AS missing_num_50,
    
    COUNTIF(num_75 IS NULL) AS missing_num_75,
    
    COUNTIF(num_985 IS NULL) AS missing_num_985,
    
    COUNTIF(num_100 IS NULL) AS missing_num_100,
    
    COUNTIF(total_secs IS NULL) AS missing_total_seconds,

    ROUND(COUNTIF(total_secs IS NULL) / COUNT(*) * 100, 2) AS missing_total_seconds_pct

FROM `kkbox_raw.user_logs_raw`;