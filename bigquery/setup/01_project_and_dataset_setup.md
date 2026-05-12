# Project and Data Warehouse Setup
-------------

## 1. Project Overview
- **Project Name:** `kkbox-churn-revenue-analytics`
- **Cloud Provider:** Google Cloud Platform (GCP)
- **Region:** `europe-west3 (Frankfurt)`
- **Billing Management:** 90-day Free Trial with a €1.00 budget alert to ensure cost-efficiency.

-------------

## 2. Infrastructure Setup Steps
To initialize the analytical environment, the following administrative tasks were completed:

1. **Project Provisioning:** Created the project `kkbox-churn-revenue-analytics` via the GCP Console.
2. **Billing Safety Net:** Established a budget alert at €1.00 to prevent unexpected credit consumption.
3. **API Activation:** Enabled the **BigQuery API** and **Cloud Storage API** for data processing and hosting.
4. **Environment Provisioning:** Executed the following commands in **Google Cloud Shell** to create the 4-layer architecture:

```bash
bq mk --location=europe-west3 kkbox_raw
bq mk --location=europe-west3 kkbox_business_validation
bq mk --location=europe-west3 kkbox_clean
bq mk --location=europe-west3 kkbox_analytics
```

-------------

## 3. Data Layering Strategy (Medallion Architecture)
To ensure data integrity and traceability, the warehouse is organized into logical layers:
- **`kkbox_raw`**: Immutable storage for original source files (Bronze).
- **`kkbox_business_validation`**: A dedicated environment for initial data profiling and business sanity checks was added between bronze and silver.
- **`kkbox_clean`**: Silver layer for standardized, deduplicated, and type-casted data.
- **`kkbox_analytics`**: Gold layer for final business KPIs and dashboard-ready tables.
