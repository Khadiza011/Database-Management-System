
-- =========================================================
-- Project: Citizen Data Management
-- File: 04_bank_account_setup.sql
-- Database: citizen_data_management
-- DBMS: MySQL / MariaDB
-- Objective: Create Bank Account Data for ACID Experiments
-- Source: Lab 9 PDF, Page 7
-- =========================================================


-- =========================================================
-- 1. Create and select the database
-- =========================================================

CREATE DATABASE IF NOT EXISTS citizen_data_management;

USE citizen_data_management;


-- =========================================================
-- 2. Create the bank_account table
-- PDF: Environment Creation
-- =========================================================

CREATE TABLE IF NOT EXISTS bank_account (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    balance DECIMAL(10,2)
) ENGINE = InnoDB;


-- =========================================================
-- 3. Insert the original PDF sample accounts
--
-- Account 1: Md. Golam Hossain - 10000.00
-- Account 2: Md. Golam Rabbani - 8000.00
--
-- INSERT IGNORE prevents duplicate primary-key errors
-- when this setup script is executed more than once.
-- =========================================================

INSERT IGNORE INTO bank_account (
    account_id,
    customer_name,
    balance
)
VALUES
    (1, 'Md. Golam Hossain', 10000.00),
    (2, 'Md. Golam Rabbani', 8000.00);


-- =========================================================
-- 4. Display all bank accounts
-- =========================================================

SELECT
    account_id,
    customer_name,
    balance
FROM citizen_data_management.bank_account
ORDER BY account_id;


-- =========================================================
-- 5. Calculate the initial total balance
-- PDF: Consistency experiment baseline
-- =========================================================

SELECT
    SUM(balance) AS total_balance
FROM citizen_data_management.bank_account;


-- =========================================================
-- 6. Verify the table definition
-- =========================================================

SHOW CREATE TABLE citizen_data_management.bank_account;


-- =========================================================
-- End of 04_bank_account_setup.sql
-- =========================================================
