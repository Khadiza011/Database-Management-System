
-- =========================================================
-- Project: Citizen Data Management
-- File: 06_consistency.sql
-- Database: citizen_data_management
-- DBMS: MySQL / MariaDB
-- Objective: Check Consistency using Transactions
-- Source: Lab 9 PDF, Page 8
-- =========================================================

USE citizen_data_management;


-- =========================================================
-- 1. Check the total balance before the experiment
-- PDF: SELECT SUM(balance) AS total_balance
-- =========================================================

SELECT
    SUM(balance) AS total_balance
FROM bank_account;


-- =========================================================
-- 2. Check individual account balances
-- Expected after TXN-1 COMMIT:
-- Account 1 = 5000.00
-- Account 2 = 13000.00
-- =========================================================

SELECT
    account_id,
    customer_name,
    balance
FROM bank_account
ORDER BY account_id;


-- =========================================================
-- 3. Execute a valid transfer
-- Transfer 1000 from account 2 to account 1.
-- =========================================================

START TRANSACTION;

UPDATE bank_account
SET balance = balance - 1000.00
WHERE account_id = 2;

UPDATE bank_account
SET balance = balance + 1000.00
WHERE account_id = 1;


-- =========================================================
-- 4. Check total balance before COMMIT
-- The total should remain unchanged.
-- =========================================================

SELECT
    SUM(balance) AS total_balance_before_commit
FROM bank_account;


-- Check individual balances inside the transaction.

SELECT
    account_id,
    customer_name,
    balance
FROM bank_account
ORDER BY account_id;


-- =========================================================
-- 5. Commit the valid transfer
-- =========================================================

COMMIT;


-- =========================================================
-- 6. Verify balances after COMMIT
-- =========================================================

SELECT
    account_id,
    customer_name,
    balance
FROM bank_account
ORDER BY account_id;


-- =========================================================
-- 7. Verify the final total balance
-- Expected total = 18000.00
-- =========================================================

SELECT
    SUM(balance) AS total_balance_after_commit
FROM bank_account;


-- =========================================================
-- 8. Compare expected and actual total balance
-- =========================================================

SELECT
    18000.00 AS expected_total_balance,
    SUM(balance) AS actual_total_balance,
    CASE
        WHEN SUM(balance) = 18000.00 THEN 'CONSISTENT'
        ELSE 'INCONSISTENT'
    END AS consistency_status
FROM bank_account;


-- =========================================================
-- End of 06_consistency.sql
-- =========================================================
