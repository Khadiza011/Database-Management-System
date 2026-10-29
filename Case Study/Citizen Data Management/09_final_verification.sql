
-- =========================================================
-- Project: Citizen Data Management
-- File: 09_final_verification.sql
-- Database: citizen_data_management
-- DBMS: MySQL / MariaDB
-- Purpose: Final Database and ACID Verification
-- =========================================================


-- =========================================================
-- 1. Verify the current citizen records
-- =========================================================

SELECT
    nid,
    name,
    dob,
    religion,
    pob
FROM citizen_data_management.citizen
ORDER BY nid;


-- =========================================================
-- 2. Verify the current citizen table structure
-- =========================================================

SHOW CREATE TABLE citizen_data_management.citizen;


-- =========================================================
-- 3. Inspect the current partition definitions
-- =========================================================

SELECT
    PARTITION_NAME,
    PARTITION_METHOD,
    PARTITION_EXPRESSION,
    PARTITION_DESCRIPTION,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = 'citizen_data_management'
  AND TABLE_NAME = 'citizen'
  AND PARTITION_NAME IS NOT NULL
ORDER BY PARTITION_ORDINAL_POSITION;


-- =========================================================
-- 4. Count citizens by place of birth
-- =========================================================

SELECT
    pob,
    COUNT(*) AS total_citizens
FROM citizen_data_management.citizen
GROUP BY pob
ORDER BY pob;


-- =========================================================
-- 5. Verify the total number of citizen records
-- =========================================================

SELECT
    COUNT(*) AS total_citizens
FROM citizen_data_management.citizen;


-- =========================================================
-- 6. Verify bank account records
-- =========================================================

SELECT
    account_id,
    customer_name,
    balance
FROM citizen_data_management.bank_account
ORDER BY account_id;


-- =========================================================
-- 7. Calculate the current total bank balance
-- =========================================================

SELECT
    SUM(balance) AS current_total_balance
FROM citizen_data_management.bank_account;


-- =========================================================
-- 8. Check the number of accounts
-- =========================================================

SELECT
    COUNT(*) AS total_accounts,
    COUNT(balance) AS accounts_with_balance
FROM citizen_data_management.bank_account;


-- =========================================================
-- 9. Inspect the bank account table definition
-- =========================================================

SHOW CREATE TABLE citizen_data_management.bank_account;


-- =========================================================
-- 10. Final verification summary
-- =========================================================

SELECT
    (
        SELECT COUNT(*)
        FROM citizen_data_management.citizen
    ) AS total_citizens,

    (
        SELECT COUNT(*)
        FROM citizen_data_management.bank_account
    ) AS total_accounts,

    (
        SELECT SUM(balance)
        FROM citizen_data_management.bank_account
    ) AS current_total_balance;


-- =========================================================
-- End of 09_final_verification.sql
-- =========================================================
