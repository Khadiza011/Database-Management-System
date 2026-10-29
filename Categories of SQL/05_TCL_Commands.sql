
-- =====================================================
-- Topic: TCL Commands
-- File: 05_TCL_Commands.sql
-- Database: banking_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Create a new database
CREATE DATABASE IF NOT EXISTS banking_db;

-- 2. Select the database
USE banking_db;

-- 3. Create an accounts table using InnoDB
CREATE TABLE IF NOT EXISTS accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100) NOT NULL,
    balance DECIMAL(12, 2) NOT NULL
) ENGINE = InnoDB;

-- 4. Reset sample data for repeatable practice
DELETE FROM accounts
WHERE account_id IN (1001, 1002, 1003);

-- 5. Insert sample bank accounts
INSERT INTO accounts (account_id, account_holder, balance)
VALUES
    (1001, 'Rahim Ahmed', 10000.00),
    (1002, 'Karim Hasan', 8000.00),
    (1003, 'Nusrat Jahan', 5000.00);

-- 6. Display the initial balances
SELECT * FROM accounts;

-- =====================================================
-- Example 1: COMMIT
-- Permanently saves the current transaction
-- =====================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance + 1000.00
WHERE account_id = 1001;

COMMIT;

-- Verify the committed change
SELECT * FROM accounts
WHERE account_id = 1001;

-- =====================================================
-- Example 2: ROLLBACK
-- Undoes uncommitted changes
-- =====================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 2000.00
WHERE account_id = 1002;

-- Undo the update
ROLLBACK;

-- The balance remains unchanged
SELECT * FROM accounts
WHERE account_id = 1002;

-- =====================================================
-- Example 3: SAVEPOINT
-- Marks a point inside a transaction
-- =====================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000.00
WHERE account_id = 1001;

SAVEPOINT after_withdrawal;

UPDATE accounts
SET balance = balance + 1000.00
WHERE account_id = 1002;

-- Undo only the second update
ROLLBACK TO SAVEPOINT after_withdrawal;

-- Save the remaining transaction
COMMIT;

-- Verify both accounts
SELECT * FROM accounts
WHERE account_id IN (1001, 1002)
ORDER BY account_id;

-- =====================================================
-- Example 4: Full transaction rollback
-- =====================================================

START TRANSACTION;

DELETE FROM accounts
WHERE account_id = 1003;

-- Undo the deletion
ROLLBACK;

-- Account 1003 should still exist
SELECT * FROM accounts
WHERE account_id = 1003;

-- =====================================================
-- Final account balances
-- =====================================================

SELECT * FROM accounts
ORDER BY account_id;
