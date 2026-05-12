-- LAYER: RAW_LAYER (Validation Phase)
-- CHECK ROW COUNTS AND CUSTOMER COVERAGE IN RAW TABLES
-- OBJECTIVE: Validate raw data volume, customer-level granularity, and coverage
--            across the source tables before business validation and modeling.

-------------------------------------------------------------------------------
-- STEP 1: Baseline Volume Check
-- Objective: Quick audit of raw ingestion totals.
-------------------------------------------------------------------------------

SELECT 'members' AS table_name, COUNT(*) AS total_rows
FROM `kkbox_raw.members_raw`

UNION ALL

SELECT 'transactions', COUNT(*)
FROM `kkbox_raw.transactions_raw`

UNION ALL

SELECT 'train_labels', COUNT(*)
FROM `kkbox_raw.train_raw`

UNION ALL

SELECT 'user_logs', COUNT(*)
FROM `kkbox_raw.user_logs_raw`;


-------------------------------------------------------------------------------
-- STEP 2: Unique Customer Counts
-- Objective: Understand customer-level granularity across raw source tables.
-------------------------------------------------------------------------------

SELECT 'members' AS table_name, COUNT(DISTINCT msno) AS unique_customers
FROM `kkbox_raw.members_raw`

UNION ALL

SELECT 'transactions', COUNT(DISTINCT msno)
FROM `kkbox_raw.transactions_raw`

UNION ALL

SELECT 'train_labels', COUNT(DISTINCT msno)
FROM `kkbox_raw.train_raw`

UNION ALL

SELECT 'user_logs', COUNT(DISTINCT msno)
FROM `kkbox_raw.user_logs_raw`;


-------------------------------------------------------------------------------
-- STEP 3: Identity Integrity — Train vs Members
-- Objective: Verify whether customers targeted for churn analysis exist
--            in the member/demographic table.
-------------------------------------------------------------------------------

SELECT 
    COUNT(DISTINCT t.msno) AS unique_train_customers,
    COUNT(DISTINCT m.msno) AS train_customers_found_in_members,
    COUNT(DISTINCT t.msno) - COUNT(DISTINCT m.msno) AS train_customers_missing_in_members,
    ROUND(COUNT(DISTINCT m.msno) / COUNT(DISTINCT t.msno) * 100, 2) AS demographic_coverage_pct
FROM `kkbox_raw.train_raw` t
LEFT JOIN `kkbox_raw.members_raw` m
    ON t.msno = m.msno;


-------------------------------------------------------------------------------
-- STEP 4: Behavioral Coverage — Train vs User Logs
-- Objective: Verify whether customers in the churn analysis population have
--            listening/activity records available.
-------------------------------------------------------------------------------

SELECT 
    COUNT(DISTINCT t.msno) AS total_customers_to_analyze,
    COUNT(DISTINCT l.msno) AS customers_with_activity_logs,
    COUNT(DISTINCT t.msno) - COUNT(DISTINCT l.msno) AS customers_missing_activity_logs,
    ROUND(COUNT(DISTINCT l.msno) / COUNT(DISTINCT t.msno) * 100, 2) AS activity_coverage_pct
FROM `kkbox_raw.train_raw` t
LEFT JOIN `kkbox_raw.user_logs_raw` l
    ON t.msno = l.msno;


-------------------------------------------------------------------------------
-- STEP 5: Financial Coverage — Train vs Transactions
-- Objective: Verify whether customers in the churn analysis population have
--            transaction records available for revenue impact analysis.
-------------------------------------------------------------------------------

SELECT
    COUNT(DISTINCT t.msno) AS total_customers_to_analyze,
    COUNT(DISTINCT tx.msno) AS customers_with_transactions,
    COUNT(DISTINCT t.msno) - COUNT(DISTINCT tx.msno) AS customers_missing_transactions,
    ROUND(COUNT(DISTINCT tx.msno) / COUNT(DISTINCT t.msno) * 100, 2) AS transaction_coverage_pct
FROM `kkbox_raw.train_raw` t
LEFT JOIN `kkbox_raw.transactions_raw` tx
    ON t.msno = tx.msno;


-------------------------------------------------------------------------------
-- STEP 6: General Financial Coverage — Members vs Transactions
-- Objective: Understand how many registered members have at least one
--            transaction record in the raw transaction table.
-------------------------------------------------------------------------------

SELECT 
    COUNT(DISTINCT m.msno) AS total_registered_members,
    COUNT(DISTINCT tx.msno) AS registered_members_with_transactions,
    COUNT(DISTINCT m.msno) - COUNT(DISTINCT tx.msno) AS registered_members_without_transactions,
    ROUND(COUNT(DISTINCT tx.msno) / COUNT(DISTINCT m.msno) * 100, 2) AS transaction_coverage_pct
FROM `kkbox_raw.members_raw` m
LEFT JOIN `kkbox_raw.transactions_raw` tx
    ON m.msno = tx.msno;