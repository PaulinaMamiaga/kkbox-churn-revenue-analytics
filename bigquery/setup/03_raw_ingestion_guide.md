# Raw Data Ingestion Process
-----------

## 1. Overview
This step handles the ingestion of the original KKBox datasets from Google Cloud Storage (GCS) into the `kkbox_raw` dataset in BigQuery. We utilize a "Schema-on-Load" strategy with auto-detection to ensure all original data points are captured without loss.

-----------

## 2. Technical Method: BigQuery CLI (`bq load`)
For high-volume datasets (the `user_logs` file exceeds 1.4GB), we use the **BigQuery Command Line Tool**. This is the enterprise-standard method for bulk loading as it is more stable and faster than browser-based uploads.

------------

## 3. Execution Workflow
The following commands were executed in **Google Cloud Shell** to populate the raw layer. We used the `--autodetect` flag to allow BigQuery to infer the schema directly from the CSV headers.

```bash
# 1. Loading Members Data
bq load --autodetect --source_format=CSV kkbox_raw.members_raw gs://kkbox-analytics-raw-storage/raw/members_v3.csv

# 2. Loading Transactions Data
bq load --autodetect --source_format=CSV kkbox_raw.transactions_raw gs://kkbox-analytics-raw-storage/raw/transactions_v2.csv

# 3. Loading Training Labels (Churn target)
bq load --autodetect --source_format=CSV kkbox_raw.train_raw gs://kkbox-analytics-raw-storage/raw/train_v2.csv

# 4. Loading User Logs (Big Data - 18M+ rows)
bq load --autodetect --source_format=CSV kkbox_raw.user_logs_raw gs://kkbox-analytics-raw-storage/raw/user_logs_v2.csv
```
-------------

## 4. Configuration Details
- **Source Format:** CSV
- **Source URI:** Google Cloud Storage Buckets (`gs://...`)
- **Write Disposition:** `WRITE_TRUNCATE` (Ensures a clean load if re-run)
- **Schema Strategy:** Autodetect enabled for initial exploration.


