
-- =========================================================
-- Project: Citizen Data Management
-- File: 01_list_partitioning.sql
-- Database: citizen_data_management
-- DBMS: MySQL / MariaDB (compatible versions)
-- Objective: LIST Partitioning
-- Source: Lab 9 PDF, Pages 1-2
-- =========================================================


-- =========================================================
-- 1. Create and select the database
-- =========================================================

CREATE DATABASE IF NOT EXISTS citizen_data_management;

USE citizen_data_management;


-- =========================================================
-- 2. Create the citizen table using LIST COLUMNS
-- =========================================================

DROP TABLE IF EXISTS citizen;

CREATE TABLE citizen (
    nid INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    religion VARCHAR(50) NOT NULL,
    pob VARCHAR(100) NOT NULL
)
ENGINE = InnoDB
PARTITION BY LIST COLUMNS (religion) (
    PARTITION islam
        VALUES IN ('Islam'),

    PARTITION hinduism
        VALUES IN ('Hinduism'),

    PARTITION buddhism
        VALUES IN ('Buddhism'),

    PARTITION christianity
        VALUES IN ('Christianity'),

    PARTITION others
        VALUES IN ('Other')
);


-- =========================================================
-- 3. Insert the original PDF sample data
-- =========================================================

INSERT INTO citizen_data_management.citizen
    (nid, name, dob, religion, pob)
VALUES
    (1, 'Abdul Karim', '1938-05-12', 'Islam', 'Dhaka'),
    (2, 'Rahim Uddin', '1955-03-10', 'Islam', 'Dhaka'),
    (3, 'Rudra Sarkar', '1978-08-15', 'Hinduism', 'Khulna'),
    (4, 'Shormi Barua', '1992-05-20', 'Buddhism', 'Dhaka'),
    (5, 'Nabila Sultana', '2005-11-01', 'Islam', 'Rajshahi'),
    (6, 'Hasan Mahmud', '2018-07-12', 'Islam', 'Dhaka'),
    (7, 'Rahul Rema', '2026-01-15', 'Christianity', 'Chattogram');


-- =========================================================
-- 4. Display all citizen records
-- =========================================================

SELECT *
FROM citizen_data_management.citizen
ORDER BY nid;


-- =========================================================
-- 5. Inspect partition distribution
-- PDF: See Where Your Data Goes
-- TABLE_ROWS may be estimated for InnoDB.
-- =========================================================

SELECT
    PARTITION_NAME,
    PARTITION_ORDINAL_POSITION,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = 'citizen_data_management'
  AND TABLE_NAME = 'citizen'
  AND PARTITION_NAME IS NOT NULL
ORDER BY PARTITION_ORDINAL_POSITION;


-- =========================================================
-- 6. Verify actual records in each partition
-- =========================================================

SELECT
    'islam' AS partition_name,
    COUNT(*) AS total_records
FROM citizen_data_management.citizen PARTITION (islam)

UNION ALL

SELECT
    'hinduism',
    COUNT(*)
FROM citizen_data_management.citizen PARTITION (hinduism)

UNION ALL

SELECT
    'buddhism',
    COUNT(*)
FROM citizen_data_management.citizen PARTITION (buddhism)

UNION ALL

SELECT
    'christianity',
    COUNT(*)
FROM citizen_data_management.citizen PARTITION (christianity)

UNION ALL

SELECT
    'others',
    COUNT(*)
FROM citizen_data_management.citizen PARTITION (others);


-- =========================================================
-- 7. Verify total citizen records
-- =========================================================

SELECT
    COUNT(*) AS total_citizens
FROM citizen_data_management.citizen;


-- =========================================================
-- 8. Verify the partitioning definition
-- =========================================================

SHOW CREATE TABLE citizen_data_management.citizen;


-- =========================================================
-- End of 01_list_partitioning.sql
-- =========================================================
