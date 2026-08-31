# Junior Data Engineer Challenge

## Overview

This project implements an end-to-end ETL pipeline using Python and PostgreSQL.

The solution extracts order data from the provided API, loads it into PostgreSQL, applies data cleaning rules, loads foreign exchange rates, and generates analytical reporting tables in EUR.

---

## Architecture

```text
Orders API
    |
    v
orders_raw
    |
    v
orders_clean
    |
    +-----------------------------+
    |                             |
    v                             v
customer_spend_eur    country_category_breakdown
    ^
    |
fx_rates
```

---

## Technologies

- Python
- PostgreSQL
- Pandas
- SQLAlchemy
- Requests
- python-dotenv
- GitHub Actions

---

## Project Structure

```text
data_pipeline/
├── inspect_orders.py
├── ingest_orders.py
├── load_fx_rates.py
└── refresh_reports.py

sql/
├── create_tables.sql
├── create_fx_rates.sql
├── orders_clean.sql
├── customer_spend_eur.sql
└── country_category_breakdown.sql

docs/
└── writeup.md
```

---

## Database Tables

### orders_raw

Raw dataset loaded directly from the provided API.

### orders_clean

Cleaned dataset after applying data quality rules.

### fx_rates

Daily exchange rates used for currency conversion.

### customer_spend_eur

Customer-level spending aggregated and converted into EUR.

### country_category_breakdown

Country-level revenue report for Books and Electronics categories.

---

## Main Data Quality Issues Found

- Duplicate records
- Missing customer_id values
- Missing category values
- Test orders
- Negative quantities
- Invalid SKU formats
- Extreme price outliers

Detailed analysis is available in:

```text
docs/writeup.md
```

---

## How to Run

### 1. Load Raw Orders

```bash
python data_pipeline/ingest_orders.py
```

### 2. Load FX Rates

```bash
python data_pipeline/load_fx_rates.py
```

### 3. Create Reporting Tables

```bash
python data_pipeline/refresh_reports.py
```

### 4. Execute SQL Scripts

Run the SQL files located in:

```text
sql/
```

using PostgreSQL / pgAdmin.

---

## Automation

The project includes:

```text
.github/workflows/daily_refresh.yml
```

and

```text
data_pipeline/refresh_reports.py
```

to support automated report refreshes.

Because the project uses a local PostgreSQL instance, the workflow serves as a reference implementation. In a production environment, the workflow would connect to a cloud-hosted PostgreSQL database using secure credentials.

---

## Author

Andrei-Cătălin Faur