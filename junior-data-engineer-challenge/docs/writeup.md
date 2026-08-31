# Writeup

## Project Overview

This project implements an end-to-end ETL pipeline using Python and PostgreSQL.

The pipeline extracts order data from the provided API, loads it into PostgreSQL, applies data cleaning transformations, loads foreign exchange rates, and generates reporting tables in EUR.

Pipeline flow:

orders_raw API  
→ orders_raw  
→ orders_clean  
→ fx_rates  
→ customer_spend_eur  
→ country_category_breakdown

---

## Data Quality Issues Found

During the profiling and analysis phase, several data quality issues were identified.

### Duplicate Records

183 fully duplicated rows were found in the source dataset.

Action:
- Removed during the creation of the `orders_clean` table.

### Missing customer_id

103 records contained a NULL customer_id.

Observation:
- customer_email was always populated.
- Every email was consistently associated with a single customer_id.

Potential solution:
- customer_id values could be reconstructed using the customer_email field.

### Missing Category

79 records contained a NULL category.

Observation:
- SKU values and product names were consistently mapped to a single category.

Potential solution:
- Category values could be reconstructed using SKU or product_name.

### Test Orders

101 records contained:

```text
status = 'test'
```

Action:
- Removed from reporting datasets because they do not represent real business activity.

### Negative Quantities

167 records contained negative quantities.

Observation:
- All negative quantities were associated with completed orders.

Action:
- Treated as invalid records and excluded from the cleaned dataset.

### Invalid SKU Formats

Several malformed SKU values were identified:

- SKU-FA-O03
- SKU HK 003
- SKUEL001

Action:
- Identified as data quality issues.
- Standardization logic was considered as part of the cleaning process.

### Extreme Price Outliers

13 records contained a unit price equal to:

```text
999999
```

Observation:
- This value is unrealistic when compared to the normal product price distribution.

Action:
- Removed from the cleaned dataset.

### Zero Price Records

24 records contained:

```text
unit_price = 0
```

Observation:
- These records may represent promotional items or free products.

Action:
- Kept in the dataset because there was not enough evidence to classify them as invalid.

---

## Cleaning Decisions

The following transformations were applied when creating `orders_clean`:

- Removed duplicate records.
- Removed test orders.
- Removed records with negative quantities.
- Removed records containing extreme price outliers.
- Preserved valid historical order data.
- Prepared the dataset for reporting and aggregation.

---

## Database Design

The solution uses PostgreSQL as the main storage layer.

### orders_raw

Stores the raw dataset loaded directly from the provided API.

### orders_clean

Stores the cleaned dataset used for analytical processing.

### fx_rates

Stores daily exchange rates used for currency conversion.

### customer_spend_eur

Stores customer-level spending converted into EUR.

### country_category_breakdown

Stores country-level revenue for Books and Electronics categories.

---

## ETL Pipeline

The implementation consists of the following scripts:

### inspect_orders.py

Used for data profiling, anomaly detection and data quality assessment.

### ingest_orders.py

Loads source data from the API into PostgreSQL.

### load_fx_rates.py

Retrieves exchange rates and stores them in the `fx_rates` table.

### refresh_reports.py

Refreshes reporting tables used for business reporting.

---

## FX Rates

Foreign exchange rates were retrieved through an external API.

The `fx_rates` table stores:

- rate_date
- base_currency
- target_currency
- rate

Daily RON to EUR exchange rates were loaded for all dates used by the dataset.

Reporting tables use these exchange rates to convert transactions into EUR using the corresponding `fx_reference_date`.

---

## Reporting Tables

### customer_spend_eur

This table calculates the total amount spent by each customer in EUR.

Features:

- Aggregated at customer level.
- Converts RON orders into EUR.
- Uses exchange rates from the `fx_rates` table.

### country_category_breakdown

This table calculates revenue by country in EUR.

Filters:

- Books
- Electronics

Business Rules:

- Revenue converted to EUR.
- Countries with revenue lower than €40,000 are excluded.
- Results are ranked by revenue.

---

## Automation

A refresh process was implemented through:

```text
refresh_reports.py
```

The script automatically executes:

- customer_spend_eur.sql
- country_category_breakdown.sql

and refreshes all reporting tables.

A GitHub Actions workflow (`daily_refresh.yml`) was also prepared to support scheduled execution.

Since this project uses a local PostgreSQL database running on localhost, the GitHub Actions workflow cannot be executed successfully in its current form because GitHub-hosted runners do not have access to the local database instance.

In a production environment:

- Database credentials would be stored securely using GitHub Secrets.
- A shared PostgreSQL database hosted in the cloud would be used instead of a local database.
- Exchange rates and reporting tables would be refreshed automatically on a daily schedule.

The scheduled workflow would:

1. Load the latest FX rates.
2. Refresh the customer_spend_eur table.
3. Refresh the country_category_breakdown table.

For local development and testing, report refreshes can be executed manually using:

```text
python data_pipeline/refresh_reports.py
```

---

## Monitoring Strategy

If this solution were deployed to production, monitoring would include:

### Pipeline Execution Monitoring

- Scheduled job execution tracking.
- Success and failure logging.
- Automated alerting for failed executions.

### Data Quality Monitoring

- Row count validation checks.
- Missing value monitoring.
- Outlier detection.
- FX rate freshness validation.

### Notifications

Potential notification channels:

- Email alerts
- Slack notifications
- GitHub Actions notifications

These mechanisms would ensure that silent failures are detected quickly.

---

## AI Usage

AI tools were used for brainstorming, project structure suggestions and documentation support.

All code and documentation were reviewed and validated before being included in the final solution.

---

## Future Improvements

Potential future enhancements include:

- Automatic reconstruction of missing customer_id values.
- Automatic reconstruction of missing category values.
- SKU normalization during ingestion.
- Improved anomaly detection techniques.
- Historical FX rate storage strategy.
- Full cloud deployment.
- Additional monitoring and observability capabilities.

---

## Conclusion

The project successfully implements an end-to-end ETL pipeline capable of:

- Extracting data from an external API.
- Loading data into PostgreSQL.
- Identifying and handling data quality issues.
- Loading and managing FX rates.
- Converting transactions into EUR.
- Generating analytical reporting tables.
- Supporting automated report refreshes through a reusable refresh process.

The final solution provides a solid foundation that could be extended for a production-grade data engineering workflow.