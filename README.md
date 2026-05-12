# kkbox-churn-revenue-analytics
Churn and revenue impact analysis for a subscription-based business, focused on identifying at-risk customers, quantifying revenue exposure, and prioritizing retention efforts by business impact to maximize ROI and reduce retention costs.












-----------
````
kkbox-churn-revenue-analytics/
│
├── README.md
├── requirements.txt
├── .gitignore
├── LICENSE
│
├── business_understanding/
│   ├── kkbox_business_problem.md
│   ├── stakeholder_questions.md
│   ├── business_objectives.md
│   ├── metric_definitions.md
│   │
│   └── entity_relationship_diagram/
│       ├── kkbox_erd.png
│       └── erd_explanation.md
│
├── data/
│   ├── raw/
│   │   ├── kkbox_train.csv
│   │   ├── kkbox_members.csv
│   │   ├── kkbox_transactions.csv
│   │   └── kkbox_user_logs.csv
│   │
│   ├── interim/
│   │   ├── customer_transactions_cleaned.csv
│   │   ├── customer_activity_features.csv
│   │   ├── customer_subscription_behavior.csv
│   │   ├── customer_monthly_activity.csv
│   │   ├── customer_revenue_metrics.csv
│   │   └── customer_churn_behavior_timeline.csv
│   │
│   ├── processed/
│   │   ├── customer_analytics_table.csv
│   │   ├── customer_risk_segmentation.csv
│   │   ├── customer_revenue_at_risk.csv
│   │   ├── retention_priority_customers.csv
│   │   ├── churn_driver_analysis.csv
│   │   └── retention_strategy_recommendations.csv
│   │
│   └── dashboard_inputs/
│       ├── executive_kpis.csv
│       ├── business_impact_metrics.csv
│       ├── risk_segmentation.csv
│       ├── churn_timing_analysis.csv
│       ├── customer_behavior_before_churn.csv
│       ├── churn_driver_analysis.csv
│       ├── feature_importance.csv
│       ├── pareto_analysis.csv
│       ├── retention_actions.csv
│       └── tracking_template.csv
│
├── bigquery/
│   ├── setup/
│   │   ├── 01_project_and_dataset_setup.md
│   │   ├── 02_create_raw_tables.sql
│   │   ├── 03_data_upload_guide.md
│   │   └── 04_validate_raw_tables.sql
│   │
│   ├── raw_layer/
│   │   ├── 01_check_row_counts.sql
│   │   ├── 02_check_missing_values.sql
│   │   ├── 03_check_duplicates.sql
│   │   ├── 04_inspect_outliers.sql
│   │   └── 05_validate_date_ranges.sql
│   │
│   ├── business_validation/
│   │   ├── 01_churn_rate_analysis.sql
│   │   ├── 02_revenue_loss_analysis.sql
│   │   ├── 03_arpu_analysis.sql
│   │   ├── 04_ltv_analysis.sql
│   │   ├── 05_revenue_at_risk_analysis.sql
│   │   └── 06_initial_business_summary.sql
│   │
│   ├── clean_layer/
│   │   ├── 01_clean_transactions.sql
│   │   ├── 02_clean_members.sql
│   │   ├── 03_clean_user_logs.sql
│   │   └── 04_prepare_train_labels.sql
│   │
│   └── analytics_layer/
│       ├── 01_customer_revenue_metrics.sql
│       ├── 02_customer_activity_metrics.sql
│       ├── 03_customer_lifecycle_metrics.sql
│       ├── 04_customer_analytics_base_table.sql
│       └── 05_customer_monthly_behavior_table.sql
│
├── notebooks/
│   ├── 01_business_understanding_and_initial_eda.ipynb
│   ├── 02_data_cleaning_and_preparation.ipynb
│   ├── 03_customer_behavior_analysis.ipynb
│   ├── 04_churn_timing_analysis.ipynb
│   ├── 05_churn_driver_analysis.ipynb
│   ├── 06_model_evaluation.ipynb
│   ├── 07_customer_risk_segmentation.ipynb
│   ├── 08_revenue_impact_analysis.ipynb
│   ├── 09_retention_prioritization_analysis.ipynb
│   ├── 10_dashboard_data_preparation.ipynb
│   └── 11_business_recommendations.ipynb
│
├── python_scripts/
│   ├── bigquery_connection.py
│   ├── feature_engineering.py
│   ├── churn_scoring.py
│   ├── revenue_impact_calculation.py
│   ├── dashboard_export_pipeline.py
│   └── utils.py
│
├── executive_dashboard/
│   ├── tableau/
│   │   ├── kkbox_executive_dashboard.twbx
│   │   └── tableau_public_link.md
│   │
│   ├── design/
│   │   ├── executive_dashboard_mockup.png
│   │   └── dashboard_color_grammar.md
│   │
│   └── preview/
│       └── executive_dashboard_preview.png
│
├── operational_dashboard/
│   ├── streamlit_app/
│   │   ├── app.py
│   │   ├── config.py
│   │   ├── utils.py
│   │   ├── styles.css
│   │   └── pages/
│   │       ├── 01_executive_summary.py
│   │       ├── 02_business_impact.py
│   │       ├── 03_risk_segmentation.py
│   │       ├── 04_churn_timing.py
│   │       ├── 05_churn_drivers.py
│   │       ├── 06_customer_behavior.py
│   │       ├── 07_prioritization.py
│   │       ├── 08_retention_actions.py
│   │       └── 09_performance_tracking.py
│   │
│   └── preview/
│       └── operational_dashboard_preview.png
│
├── model/
│   ├── churn_prediction_model.pkl
│   ├── model_features.json
│   └── model_performance_summary.csv
│
├── outputs/
│   ├── executive_summary_report.pdf
│   ├── churn_insights_summary.md
│   ├── retention_strategy_summary.md
│   ├── revenue_risk_summary.md
│   └── methodology_and_assumptions.md
│
└── images/
    ├── project_cover.png
    ├── workflow_overview.png
    ├── executive_dashboard_architecture.png
    └── operational_dashboard_architecture.png


````