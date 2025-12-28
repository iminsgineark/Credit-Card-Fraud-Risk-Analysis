# 🛡️ Credit Card Fraud Detection – SQL Analytics Project

## 📌 Project Overview

This project focuses on **fraud detection trend analysis** using **SQL-based analytics** on financial transaction data.
The objective is to identify **fraud-prone patterns** across transaction amount, geography, time, and payment instruments, and to prepare **analytics-ready datasets** for dashboards and decision-making.

The project simulates a **real-world banking / fintech fraud analytics workflow**, emphasizing **data cleaning, risk segmentation, trend analysis, and performance-optimized reporting**.

---

## 🎯 Business Objectives

* Detect fraud-prone trends in financial transactions
* Identify high-risk transactions and regions
* Enable fraud monitoring and investigation workflows
* Support AML (Anti-Money Laundering) and risk reporting
* Prepare structured data outputs for **Power BI dashboards**

---

## 🗂️ Dataset Description

The dataset contains transactional-level credit card data with attributes such as:

* Transaction ID
* Customer & Merchant details
* Transaction Date & Amount (INR)
* Fraud flag (`IsFraud`)
* Fraud Risk label & Fraud Score
* Location (State, Merchant Location)
* Card Type & Bank
* Transaction Category

The data is imported into **MySQL** using the **Data Import Wizard** from a CSV file.

---

## 🛠️ Tech Stack

* **Database:** MySQL
* **Analytics:** SQL
* **Visualization:** Power BI
* **Data Source:** CSV (Credit Card Transaction Dataset)

---

## 🧱 Project Architecture (High Level)

```text
CSV File
   ↓
MySQL (Data Import Wizard)
   ↓
Data Cleaning & Datetime Engineering
   ↓
SQL Analytics & Aggregations
   ↓
Reusable SQL Views
   ↓
Power BI Dashboards & Reports
```

---

## 🔄 End-to-End Workflow

### 1️⃣ Database & Schema Setup

* Created a dedicated database for fraud analytics
* Verified table structure and column data types
* Ensured accurate column referencing for analytics

---

### 2️⃣ Datetime Engineering

* Added a new `DATETIME` column (`txn_datetime`)
* Converted string-based transaction dates into proper datetime format
* Enabled time-series analysis (daily & monthly trends)

---

### 3️⃣ Data Quality Cleaning

* Removed invalid records:

  * NULL transaction amounts
  * Zero or negative transaction values
* Ensured clean and reliable metrics for analysis

---

### 4️⃣ Baseline Fraud Analysis

* Computed total transaction volume
* Analyzed fraud vs non-fraud distribution
* Validated fraud labels (`IsFraud`)

---

### 5️⃣ Risk Segmentation & Trend Analysis

#### 🔹 Transaction Amount Analysis

* Bucketed transactions into:

  * Low Amount
  * Medium Amount
  * High Amount
* Calculated fraud rate per amount bucket

#### 🔹 Geographic Risk Analysis

* State-wise fraud rate analysis
* Merchant location (city-level) fraud hotspots
* Applied minimum transaction thresholds to avoid noise

#### 🔹 Temporal Fraud Trends

* Daily fraud trends for monitoring spikes
* Monthly fraud trends for executive-level reporting

---

### 6️⃣ Fraud Risk Score Validation

* Compared fraud risk labels with average fraud scores
* Validated alignment between risk categories and numeric scores
* Ensured explainable and auditable risk metrics

---

### 7️⃣ Channel & Instrument Risk Analysis

* Fraud exposure analysis by:

  * Card Type (Visa, Rupay, Amex, etc.)
  * Bank
* Identified vulnerable payment instruments

---

### 8️⃣ High-Risk Transaction Identification

* Created a dedicated SQL view for:

  * Confirmed fraud transactions
  * High fraud scores (≥ 80)
* Enables faster investigation and prioritization

---

### 9️⃣ Performance-Optimized SQL Views

Reusable SQL views created for BI and reporting:

* `high_risk_transactions`
* `daily_fraud_summary`
* `state_risk_score`

These views reduce query complexity and improve dashboard performance.

---

## 📊 Power BI Integration

The SQL outputs are designed to be **directly consumed by Power BI**, enabling:

* Fraud trend dashboards
* Geographic fraud heatmaps
* High-risk transaction tables
* Executive fraud summaries

This supports **fraud investigation, risk reporting, and operational decision-making**.

---

## 📈 Key Outcomes

* Identified fraud-prone trends based on:

  * Transaction amount
  * Location
  * Time patterns
* Built an end-to-end **SQL analytics pipeline**
* Reduced fraud analysis turnaround time through:

  * Structured SQL views
  * Dashboard-driven reporting
* Supported AML and regulatory monitoring using explainable metrics

---

## 🔐 Compliance & Best Practices

* Followed analytics-level AML monitoring principles
* Ensured explainability and audit-friendly metrics
* Avoided hard deletes beyond data quality rules
* Designed queries suitable for production reporting systems

---

## 🧪 How to Run the Project

1. Create database in MySQL

   ```sql
   CREATE DATABASE FraudAnalytics;
   USE FraudAnalytics;
   ```

2. Import the CSV file into MySQL using **Data Import Wizard**

3. Run the SQL script in sequence:

   * Schema validation
   * Datetime conversion
   * Data cleaning
   * Analytics queries
   * View creation

4. Connect Power BI to MySQL and use the created views for dashboards

---

## 📌 Future Enhancements

* Indexing for performance optimization
* Stored procedures for automation
* Integration with alerting systems
* ML-based fraud scoring models
* Real-time streaming data support

---

## 👤 Author

**Utkrist Ark**
Fraud Analytics | SQL | Power BI | Data Science
