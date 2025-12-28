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



