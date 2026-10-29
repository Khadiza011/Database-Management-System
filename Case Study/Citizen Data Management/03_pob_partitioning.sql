
-- =========================================================
-- Project: Citizen Data Management
-- File: 03_pob_partitioning.sql
-- Database: citizen_data_management
-- DBMS: MySQL
-- Objective: Partitioning by Place of Birth (POB)
-- Source: Lab 9 PDF, Page 6 - Your Turn
-- =========================================================


-- =========================================================
-- 1. Select the database
-- =========================================================

CREATE DATABASE IF NOT EXISTS citizen_data_management;

USE citizen_data_management;


-- =========================================================
-- 2. Recreate the citizen table using LIST COLUMNS
--    with pob as the partitioning column
--
-- Note:
-- The PDF requires partitioning by POB but does not
-- prescribe exact partition names or a partition method.
-- LIST COLUMNS is used here as a practical implementation.
-- =========================================================

DROP TABLE IF EXISTS citizen_data_management.citizen;

CREATE TABLE citizen_data_management.citizen (
    nid INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    religion VARCHAR(50) NOT NULL,
    pob VARCHAR(100) NOT NULL
)
ENGINE = InnoDB
PARTITION BY LIST COLUMNS (pob) (
    PARTITION dhaka
        VALUES IN ('Dhaka'),

    PARTITION khulna
        VALUES IN ('Khulna'),

    PARTITION rajshahi
        VALUES IN ('Rajshahi'),

    PARTITION chattogram
        VALUES IN ('Chattogram')
);


-- =========================================================
-- 3. Insert the same sample records
-- =========================================================

INSERT INTO citizen_data_management.citizen
    (nid, name, dob, religion, pob)
VALUES
    (1, 'Abdul Karim', '1938-05-12', 'Islam', 'Dhaka'),
    (2, 'Rahim Uddin', '1955-03-10', 'Islam', 'Dhaka'),
    (3, 'Rudra Sarkar', '1978-08-15', 'Hindu', 'Khulna'),
    (4, 'Ayesha Akter', '1992-05-20', 'Islam', 'Dhaka'),
    (5, 'Nabila Sultana', '2005-11-01', 'Islam', 'Rajshahi'),
    (6, 'Hasan Mahmud', '2018-07-12', 'Islam', 'Dhaka'),
    (7, 'Rahul Rema', '2026-01-15', 'Chirstian', 'Chattogram');


-- =========================================================
-- 4. Display all citizen records
-- =========================================================

SELECT *
FROM citizen_data_management.citizen
ORDER BY pob, nid;


-- =========================================================
-- 5. Inspect the partition definitions
-- =========================================================

SELECT
    PARTITION_NAME,
    PARTITION_ORDINAL_POSITION,
    PARTITION_DESCRIPTION,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = 'citizen_data_management'
  AND TABLE_NAME = 'citizen'
  AND PARTITION_NAME IS NOT NULL
ORDER BY PARTITION_ORDINAL_POSITION;


-- =========================================================
-- 6. Verify actual record distribution
-- =========================================================

SELECT
    'dhaka' AS partition_name,
    COUNT(*) AS total_records
FROM citizen_data_management.citizen
    PARTITION (dhaka)

UNION ALL

SELECT
    'khulna',
    COUNT(*)
FROM citizen_data_management.citizen
    PARTITION (khulna)

UNION ALL

SELECT
    'rajshahi',
    COUNT(*)
FROM citizen_data_management.citizen
    PARTITION (rajshahi)

UNION ALL

SELECT
    'chattogram',
    COUNT(*)
FROM citizen_data_management.citizen
    PARTITION (chattogram);


-- =========================================================
-- 7. Count citizens by place of birth
-- =========================================================

SELECT
    pob,
    COUNT(*) AS total_citizens
FROM citizen_data_management.citizen
GROUP BY pob
ORDER BY total_citizens DESC, pob;


-- =========================================================
-- 8. Retrieve citizens born in Dhaka
-- =========================================================

SELECT
    nid,
    name,
    dob,
    religion,
    pob
FROM citizen_data_management.citizen
    PARTITION (dhaka)
ORDER BY dob;


-- =========================================================
-- 9. Examine the query execution plan
-- =========================================================

EXPLAIN
SELECT *
FROM citizen_data_management.citizen
WHERE pob = 'Dhaka';


-- =========================================================
-- 10. Verify the table definition
-- =========================================================

SHOW CREATE TABLE citizen_data_management.citizen;


-- =========================================================
-- End of 03_pob_partitioning.sql
-- =========================================================
