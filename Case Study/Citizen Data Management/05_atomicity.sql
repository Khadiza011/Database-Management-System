
-- =========================================================
-- Project: Citizen Data Management
-- File: 05_atomicity.sql
-- Database: citizen_data_management
-- DBMS: MySQL / MariaDB
-- Objective: Demonstrate Atomicity using Transactions
-- Source: Lab 9 PDF, Page 7
-- =========================================================


-- =========================================================
-- TXN-1: Transfer 5000 from account 1 to account 2
-- Execute this section in MySQL Session 1.
-- =========================================================

USE citizen_data_management;

START TRANSACTION;

-- Debit account 1.
UPDATE bank_account
SET balance = balance - 5000.00
WHERE account_id = 1;

-- Credit account 2.
UPDATE bank_account
SET balance = balance + 5000.00
WHERE account_id = 2;

-- Check the balances before committing.
SELECT
    account_id,
    customer_name,
    balance
FROM bank_account
ORDER BY account_id;

-- Make both updates permanent.
COMMIT;


-- Verify the committed balances.
SELECT
    account_id,
    customer_name,
    balance
FROM bank_account
ORDER BY account_id;


-- =========================================================
-- TXN-2: Attempt another debit, then roll it back.
-- Execute this section in MySQL Session 2.
-- =========================================================

-- IMPORTANT:
-- Open a separate MySQL connection/session before running
-- this section. Do not execute it as part of Session 1.

USE citizen_data_management;

START TRANSACTION;

-- Attempt to debit account 1.
UPDATE bank_account
SET balance = balance - 5000.00
WHERE account_id = 1;

-- Check the uncommitted change in Session 2.
SELECT
    account_id,
    customer_name,
    balance
FROM bank_account
ORDER BY account_id;

-- Cancel the transaction.
ROLLBACK;

-- Verify that the debit was cancelled.
SELECT
    account_id,
    customer_name,
    balance
FROM bank_account
ORDER BY account_id;


-- =========================================================
-- Final balance verification
-- =========================================================

SELECT
    SUM(balance) AS total_balance
FROM bank_account;


-- =========================================================
-- End of 05_atomicity.sql
-- =========================================================
