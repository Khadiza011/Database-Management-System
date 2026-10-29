
-- =========================================================
-- Project: Citizen Data Management
-- File: 08_durability.sql
-- Database: citizen_data_management
-- DBMS: MySQL / MariaDB
-- Objective: Demonstrate Durability
-- Source: Lab 9 PDF, Page 8
--
-- IMPORTANT:
-- This file contains separate experimental stages.
-- Do not execute the entire file as one batch.
-- =========================================================


-- =========================================================
-- PART A: Record the current committed balances
-- Run this before starting the experiment.
-- =========================================================

USE citizen_data_management;

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
-- PART B: PDF EXPERIMENT
-- Start a transaction and make an uncommitted change.
--
-- Execute this section separately.
-- Keep the transaction open for the next step.
-- =========================================================

START TRANSACTION;

SELECT *
FROM citizen_data_management.bank_account
ORDER BY account_id;

UPDATE citizen_data_management.bank_account
SET balance = balance - 1000.00
WHERE account_id = 2;

-- Check the uncommitted balance in this session.
SELECT *
FROM citizen_data_management.bank_account
ORDER BY account_id;


-- =========================================================
-- PART C: PDF XAMPP RESTART EXPERIMENT
--
-- Do not execute this as SQL.
--
-- On your local XAMPP test environment:
-- 1. Stop the MySQL/MariaDB service.
-- 2. Restart the service.
-- 3. Reconnect to the database.
--
-- Restarting terminates the open connection. The
-- uncommitted transaction should be rolled back.
--
-- Do not perform this experiment on a production database.
-- =========================================================


-- =========================================================
-- PART D: Verify the uncommitted change was not persisted
-- Run after reconnecting to MySQL.
-- =========================================================

USE citizen_data_management;

SELECT
    account_id,
    customer_name,
    balance
FROM citizen_data_management.bank_account
ORDER BY account_id;

SELECT
    SUM(balance) AS total_balance
FROM citizen_data_management.bank_account;


-- Expected:
-- The uncommitted 1000.00 deduction should not persist.
-- Balances should match the last committed state.


-- =========================================================
-- PART E: Demonstrate DURABILITY with COMMIT
--
-- Execute this section after confirming the previous result.
-- =========================================================

START TRANSACTION;

UPDATE citizen_data_management.bank_account
SET balance = balance - 1000.00
WHERE account_id = 2;

COMMIT;


-- Verify the committed balance.

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
-- PART F: Optional final persistence test
--
-- Restart MySQL normally after COMMIT, reconnect, and
-- execute the following queries again.
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
-- End of 08_durability.sql
-- =========================================================
