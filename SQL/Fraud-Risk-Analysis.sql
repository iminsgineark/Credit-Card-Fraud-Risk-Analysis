CREATE DATABASE FraudAnalytics;
USE FraudAnalytics;

show tables;
DESCRIBE transactions;

-- Adding a proper DATE column
ALTER TABLE transactions
ADD COLUMN txn_datetime DATETIME;

SET SQL_SAFE_UPDATES = 0;
-- Populate the DATE column
UPDATE transactions
SET txn_datetime = STR_TO_DATE(`Transaction Date`, '%Y-%m-%d %H:%i:%s');

-- Validate conversion
SELECT `Transaction Date`, txn_datetime
FROM transactions
LIMIT 10;

-- Total number of transactions
SELECT COUNT(*) AS total_transactions
FROM transactions;

-- Fraud vs Non-Fraud distribution , 1 --> Fraud,  0 --> not fraud
SELECT 
    IsFraud,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY IsFraud;


-- Remove invalid monetary records
DELETE FROM transactions
WHERE `Transaction Amount (INR)` IS NULL
   OR `Transaction Amount (INR)` <= 0;




-- Fraud trend by transaction amount bucket
SELECT 
    CASE 
        WHEN `Transaction Amount (INR)` < 1000 THEN 'Low Amount'
        WHEN `Transaction Amount (INR)` BETWEEN 1000 AND 5000 THEN 'Medium Amount'
        ELSE 'High Amount'
    END AS amount_bucket,
    COUNT(*) AS total_transactions,
    SUM(IsFraud) AS fraud_transactions,
    ROUND((SUM(IsFraud) / COUNT(*)) * 100, 2) AS fraud_percentage
FROM transactions
GROUP BY amount_bucket;



-- State-wise fraud hotspots

SELECT 
    State,
    COUNT(*) AS total_transactions,
    SUM(IsFraud) AS fraud_transactions,
    ROUND((SUM(IsFraud) / COUNT(*)) * 100, 2) AS fraud_rate
FROM transactions
GROUP BY State
HAVING COUNT(*) > 20
ORDER BY fraud_rate DESC;


-- Merchant-location fraud risk

SELECT 
    `Merchant Location`,
    COUNT(*) AS total_transactions,
    SUM(IsFraud) AS fraud_transactions,
    ROUND((SUM(IsFraud) / COUNT(*)) * 100, 2) AS fraud_rate
FROM transactions
GROUP BY `Merchant Location`
ORDER BY fraud_rate DESC;



-- Daily fraud trend

SELECT 
    DATE(txn_datetime) AS transaction_date,
    COUNT(*) AS total_transactions,
    SUM(IsFraud) AS fraud_transactions
FROM transactions
GROUP BY DATE(txn_datetime)
ORDER BY transaction_date;


-- Monthly fraud trend (EXECUTIVE-LEVEL)
SELECT 
    DATE_FORMAT(txn_datetime, '%Y-%m') AS month,
    COUNT(*) AS total_transactions,
    SUM(IsFraud) AS fraud_transactions,
    ROUND((SUM(IsFraud) / COUNT(*)) * 100, 2) AS fraud_rate
FROM transactions
GROUP BY month
ORDER BY month;


-- Fraud risk label vs fraud score validation
SELECT 
    `Fraud Risk`,
    ROUND(AVG(`Fraud Score`), 2) AS avg_fraud_score,
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY `Fraud Risk`
ORDER BY avg_fraud_score DESC;


-- Card-type risk exposure

SELECT 
    `Card Type`,
    COUNT(*) AS total_transactions,
    SUM(IsFraud) AS fraud_transactions,
    ROUND((SUM(IsFraud) / COUNT(*)) * 100, 2) AS fraud_rate
FROM transactions
GROUP BY `Card Type`
ORDER BY fraud_rate DESC;

-- Bank-wise fraud exposure
SELECT 
    Bank,
    COUNT(*) AS total_transactions,
    SUM(IsFraud) AS fraud_transactions
FROM transactions
GROUP BY Bank
ORDER BY fraud_transactions DESC;

-- High-risk fraud transactions

CREATE OR REPLACE VIEW high_risk_transactions AS
SELECT *
FROM transactions
WHERE IsFraud = 1
  AND `Fraud Score` >= 80;


-- Daily fraud summary (performance optimized)

CREATE OR REPLACE VIEW daily_fraud_summary AS
SELECT 
    DATE(txn_datetime) AS transaction_date,
    COUNT(*) AS total_transactions,
    SUM(IsFraud) AS fraud_transactions,
    ROUND((SUM(IsFraud) / COUNT(*)) * 100, 2) AS fraud_percentage
FROM transactions
GROUP BY DATE(txn_datetime);

-- State risk score view
CREATE OR REPLACE VIEW state_risk_score AS
SELECT 
    State,
    COUNT(*) AS total_transactions,
    SUM(IsFraud) AS fraud_transactions,
    ROUND((SUM(IsFraud) / COUNT(*)) * 100, 2) AS risk_score
FROM transactions
GROUP BY State;
