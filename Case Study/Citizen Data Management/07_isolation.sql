
-- =========================================================
-- Project: Citizen Data Management
-- File: 07_isolation.sql
-- Database: citizen_data_management
-- DBMS: MySQL / MariaDB
-- Objective: Demonstrate Transaction Isolation
-- Source: Lab 9 PDF, Page 8
--
-- IMPORTANT:
-- Execute SESSION 1 and SESSION 2 in separate connections.
-- Do not run the entire file as one SQL batch.
-- =========================================================


-- =========================================================
-- SESSION 1 (TXN-1)
-- Open MySQL Connection 1
-- =========================================================

USE citizen_data_management;

START TRANSACTION;

-- Step 1: Read both account balances.
SELECT *
FROM citizen_data_management.bank_account
ORDER BY account_id;

-- Step 2: Deduct 1000 from account 2.
UPDATE citizen_data_management.bank_account
SET balance = balance - 1000.00
WHERE account_id = 2;

-- Step 3: Read the balances again.
-- Session 1 sees its own uncommitted update.
SELECT *
FROM citizen_data_management.bank_account
ORDER BY account_id;

-- Step 4: Add 1000 to account 1.
-- Run this after Session 2 has performed its first update.
-- This statement may block or encounter a deadlock.
UPDATE citizen_data_management.bank_account
SET balance = balance + 1000.00
WHERE account_id = 1;

-- Step 5: Inspect balances if the transaction is still active.
SELECT *
FROM citizen_data_management.bank_account
ORDER BY account_id;

-- Step 6: Commit only if all intended updates succeeded.
COMMIT;


-- =========================================================
-- SESSION 2 (TXN-2)
-- Open a separate MySQL Connection 2
-- Run these statements in the specified order.
-- =========================================================

USE citizen_data_management;

START TRANSACTION;

-- Step 1: Read both account balances.
SELECT *
FROM citizen_data_management.bank_account
ORDER BY account_id;

-- Step 2: Deduct 2000 from account 1.
UPDATE citizen_data_management.bank_account
SET balance = balance - 2000.00
WHERE account_id = 1;

-- Step 3: Read the balances again.
SELECT *
FROM citizen_data_management.bank_account
ORDER BY account_id;

-- Step 4: Add 2000 to account 2.
-- Run this after Session 1 has performed its first update.
-- This statement may block or encounter a deadlock.
UPDATE citizen_data_management.bank_account
SET balance = balance + 2000.00
WHERE account_id = 2;

-- Step 5: Inspect balances if the transaction is still active.
SELECT *
FROM citizen_data_management.bank_account
ORDER BY account_id;

-- Step 6: Commit only if all intended updates succeeded.
COMMIT;


-- =========================================================
-- FINAL VERIFICATION
-- Run in a connection after both transactions have ended.
-- =========================================================

SELECT
    account_id,
    customer_name,
    balance
FROM citizen_data_management.bank_account
ORDER BY account_id;

SELECT
    SUM(balance) AS total_balance
FROM citizen_data_management.bank_account;


-- =========================================================
-- End of 07_isolation.sql
-- =========================================================
