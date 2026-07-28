# Financial Forecasting Automation (FP&A)

A lightweight, production-style financial forecasting automation pipeline built with **Python, SQL, SQLite, and Excel**.

This project demonstrates how monthly financial actuals can be automatically ingested, transformed, forecasted, and converted into variance reports, replacing manual Excel-based FP&A workflows with a scalable and repeatable process.

---

## Overview

The pipeline simulates a typical FP&A forecasting workflow used in corporate finance teams.

It automatically:

- Loads monthly actuals from a data source
- Stores data in a relational database
- Uses SQL for financial data preparation
- Generates rolling forecasts
- Calculates forecast vs. actual variances
- Produces automated Excel management reports

The project demonstrates how **Python + SQL** can automate recurring financial reporting while improving scalability, consistency, and auditability.

---

## Business Problem

Finance teams regularly need to:

- Load monthly actuals from a data warehouse
- Produce rolling forecasts
- Compare forecast vs. actual results
- Identify financial variances
- Deliver recurring management reports

Traditional spreadsheet workflows are:

- Time consuming
- Error-prone
- Difficult to audit
- Hard to scale

This project demonstrates a simplified but realistic automation pipeline commonly found in FP&A and Finance Technology organizations.

---

# Solution Architecture

```text
CSV Source Data
        │
        ▼
    SQLite Database
        │
        ▼
      SQL Layer
        │
        ▼
   Python Forecast Engine
        │
        ▼
 Forecast + Variance Analysis
        │
        ▼
 Excel Management Report
```

---

## Data Model

### Input Table: `actuals`

| Column | Type | Description |
|---------|------|-------------|
| month | DATE | Month of financial activity |
| account | TEXT | Cost or revenue category |
| amount | FLOAT | Actual financial amount |

The dataset represents monthly actuals similar to data exported from ERP systems such as:

- SAP
- Oracle
- NetSuite

---

## SQL Layer

The SQL layer simulates enterprise finance reporting logic.

Responsibilities include:

- Monthly aggregation
- Standardized date ordering
- Lag calculations
- Rolling averages
- Baseline forecast preparation

Multiple CTEs separate:

- Data preparation
- Aggregation
- Analytics

This mirrors SQL patterns commonly used in enterprise finance data warehouses.

---

## Forecasting Methodology

### Baseline Model

**Seasonal Naive Forecast**

Forecast for each future month:

```text
Forecast = Actual from the same month last year
```

### Why Seasonal Naive?

- Widely used FP&A baseline
- Easy for finance stakeholders to understand
- Strong benchmark before advanced forecasting models
- Requires minimal configuration

If insufficient historical data exists, the model automatically falls back to the most recent observed value.

---

## Forecast Horizon

- 6-month rolling forecast
- Monthly frequency
- Future periods generated automatically

---

## Variance Analysis

After forecasts are generated, the pipeline automatically calculates:

### Variance

```text
Variance = Actual − Forecast
```

### Variance %

```text
Variance % = (Actual − Forecast) / Forecast
```

Variance values populate automatically once actuals become available.

This reflects real FP&A workflows where:

- Forecasts are locked
- Actuals arrive monthly
- Variance analysis updates automatically

---

# Output

## 1. Forecast CSV

`outputs/forecast_output.csv`

Contains:

- month
- account
- actual_amount
- forecast_amount
- variance
- variance_pct

Typical use cases:

- Data validation
- Downstream analytics
- Additional modeling

---

## 2. Excel Variance Report

`outputs/variance_report.xlsx`

### Sheet: Forecast+Variance

Includes:

- Historical actuals
- Future forecasts
- Variance calculations

### Sheet: Summary

Provides a management-friendly view:

- Last 3 historical months
- Next 6 forecast months
- Grouped by account

This layout resembles recurring FP&A management review packages.

---

# Features

- SQL-based financial data extraction
- Automated monthly aggregation
- Time-series forecasting
- Rolling forecast generation
- Forecast vs. actual variance analysis
- Automated Excel reporting
- Modular Python architecture
- Clear separation between data, business logic, and outputs

---

# Technologies

### Programming

- Python
- pandas
- NumPy

### Database

- SQLite
- SQL

### Reporting

- Excel (openpyxl)

---

# Project Structure

```text
fpa-forecast-automation/
│
├── data/
│   ├── actuals.csv
│   └── fpa.db
│
├── sql/
│   ├── monthly_actuals.sql
│   ├── monthly_actuals_enriched.sql
│   └── forecast_baseline.sql
│
├── src/
│   ├── 01_load_to_sqlite.py
│   └── 02_forecast_and_variance.py
│
├── outputs/
│   ├── forecast_output.csv
│   └── variance_report.xlsx
│
├── run.py
├── requirements.txt
└── README.md
```

> **Note:** If your folder is currently named `scr`, consider renaming it to `src`, which is the conventional name for source code directories in Python projects.

---

# Getting Started

## Prerequisites

- Python 3.8+
- pip

---

## Installation

Install dependencies:

```bash
pip install -r requirements.txt
```

Required packages:

- pandas >= 2.0
- numpy >= 1.24
- openpyxl >= 3.1

---

# Usage

## Run the Complete Pipeline (Recommended)

```bash
python run.py
```

This will:

1. Load CSV data into SQLite
2. Generate forecasts
3. Calculate variances
4. Export CSV and Excel reports

---

## Run Individual Steps

### Step 1 — Load Data

```bash
python src/01_load_to_sqlite.py
```

### Step 2 — Generate Forecasts

```bash
python src/02_forecast_and_variance.py
```

---

# Generated Outputs

After execution, the `outputs/` directory will contain:

| File | Description |
|------|-------------|
| `forecast_output.csv` | Forecast data with variance calculations |
| `variance_report.xlsx` | Excel report containing Forecast+Variance and Summary sheets |

---

# Future Improvements

Potential enhancements include:

- Prophet forecasting
- ARIMA forecasting
- Machine learning forecasting models
- Power BI dashboard integration
- Automated scheduling with Airflow
- Database connectivity (SQL Server, Snowflake, PostgreSQL)
- Scenario and sensitivity analysis
- Email report automation
