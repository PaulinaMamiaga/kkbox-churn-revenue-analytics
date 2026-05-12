-- LAYER: SETUP / VALIDATION
-- OBJECTIVE: Confirm successful ingestion from GCS to BigQuery kkbox_raw dataset.

-- 1. Global Row Count Verification
SELECT 'members_raw' as table_name, COUNT(*) as total_rows FROM `kkbox_raw.members_raw`
UNION ALL
SELECT 'transactions_raw', COUNT(*) FROM `kkbox_raw.transactions_raw`
UNION ALL
SELECT 'train_raw', COUNT(*) FROM `kkbox_raw.train_raw`
UNION ALL
SELECT 'user_logs_raw', COUNT(*) FROM `kkbox_raw.user_logs_raw`;

-- 2. Sample Check (Ensuring data isn't corrupted)
SELECT * FROM `kkbox_raw.members_raw` LIMIT 5;
