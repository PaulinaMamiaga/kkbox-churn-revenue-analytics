# Data Upload & Cloud Storage Guide
------------

## 1. Storage Architecture
Before ingesting data into BigQuery, a "Landing Zone" was created using **Google Cloud Storage (GCS)**. This serves as the immutable repository for the project's source files.

- **Service:** Google Cloud Storage (GCS)
- **Bucket Name:** `kkbox-analytics-raw-storage`
- **Storage Class:** Standard (Optimized for high-frequency analytical processing)
- **Region:** `europe-west3 (Frankfurt)`

-----------

## 2. File Organization
To maintain a clean Data Lake structure, a dedicated directory was created:
- `gs://kkbox-analytics-raw-storage/raw/`: Contains the original compressed and uncompressed CSV files from the KKBox Churn Challenge (Kaggle).

-----------

## 3. Upload Workflow
The following process was used to move datasets from the local development environment to the cloud:

1. **Bucket Provisioning:** Created the bucket via the GCP Console with **Uniform access control** and **Public access prevention** enabled for data security.
2. **Directory Creation:** Created the `/raw` folder to separate source data from future potential outputs.
3. **Data Transfer:**
   - Small files were uploaded via the GCP Web Console.
   - Large files (specifically `user_logs_v2.csv`, ~1.4GB) were uploaded ensuring a stable connection to prevent packet loss.

------------

## 4. Security & Compliance
- **Access Control:** IAM permissions are restricted to the project owner.
- **Data Residency:** All data remains within the German jurisdiction (`europe-west3`) to align with best practices for regional data handling.

