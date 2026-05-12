-- LAYER: RAW_LAYER (Validation Phase)
-- CHECK DUPLICATES IN RAW TABLES   
-- OBJECTIVE: Detect duplicate records and validate entity uniqueness
--            across raw source tables before cleaning and modeling.

-------------------------------------------------------------------------------
-- STEP 1: Duplicate Customer IDs — Members Table
-- Objective: Verify whether customer demographic profiles are unique.
-------------------------------------------------------------------------------

SELECT
    msno AS customer_id,
    COUNT(*) AS duplicate_count
FROM `kkbox_raw.members_raw`
GROUP BY msno
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-------------------------------------------------------------------------------
-- STEP 2: Duplicate Churn Labels — Train Table
-- Objective: Verify whether customers appear multiple times in the churn labels.
-------------------------------------------------------------------------------

SELECT
    msno AS customer_id,
    COUNT(*) AS duplicate_count
FROM `kkbox_raw.train_raw`
GROUP BY msno
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-------------------------------------------------------------------------------
-- STEP 3: Duplicate Transactions
-- Objective: Identify potentially duplicated financial transactions.
-- Logic: Same customer + same transaction date + same payment amount.
-------------------------------------------------------------------------------

SELECT
    msno AS customer_id,
    transaction_date,
    actual_amount_paid,
    COUNT(*) AS duplicate_count
FROM `kkbox_raw.transactions_raw`
GROUP BY
    msno,
    transaction_date,
    actual_amount_paid
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-------------------------------------------------------------------------------
-- STEP 4: Duplicate User Activity Logs
-- Objective: Detect duplicated listening activity records.
-- Logic: Same customer + same activity date.
-------------------------------------------------------------------------------

SELECT
    msno AS customer_id,
    date AS activity_date,
    COUNT(*) AS duplicate_count
FROM `kkbox_raw.user_logs_raw`
GROUP BY
    msno,
    date
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-------------------------------------------------------------------------------
-- STEP 5: Duplicate Summary by Table
-- Objective: High-level overview of duplicate exposure across datasets.
-------------------------------------------------------------------------------

SELECT
    'members_raw' AS table_name,
    COUNT(*) AS duplicated_records
FROM (
    SELECT msno
    FROM `kkbox_raw.members_raw`
    GROUP BY msno
    HAVING COUNT(*) > 1
)

UNION ALL

SELECT
    'train_raw',
    COUNT(*)
FROM (
    SELECT msno
    FROM `kkbox_raw.train_raw`
    GROUP BY msno
    HAVING COUNT(*) > 1
)

UNION ALL

SELECT
    'transactions_raw',
    COUNT(*)
FROM (
    SELECT
        msno,
        transaction_date,
        actual_amount_paid
    FROM `kkbox_raw.transactions_raw`
    GROUP BY
        msno,
        transaction_date,
        actual_amount_paid
    HAVING COUNT(*) > 1
)

UNION ALL

SELECT
    'user_logs_raw',
    COUNT(*)
FROM (
    SELECT
        msno,
        date
    FROM `kkbox_raw.user_logs_raw`
    GROUP BY
        msno,
        date
    HAVING COUNT(*) > 1
);

-- NOTE: Detail queries return rows only when duplicates are detected.
--       If no rows are returned, no duplicates were found for that check.
