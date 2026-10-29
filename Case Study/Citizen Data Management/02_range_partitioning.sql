
-- =========================================================
-- Project: Citizen Data Management
-- File: 02_range_partitioning.sql
-- Database: citizen_data_management
-- DBMS: MySQL / MariaDB (version-dependent compatibility)
-- Objective: RANGE Partitioning
-- Source: Lab 9 PDF, Pages 3-5
-- =========================================================


-- =========================================================
-- 1. Create and select the database
-- =========================================================

CREATE DATABASE IF NOT EXISTS citizen_data_management;

USE citizen_data_management;


-- =========================================================
-- 2. Recreate the citizen table using RANGE partitioning
--
-- Partitioning column: YEAR(dob)
--
-- 1. Silent Generation: before 1946
-- 2. Baby Boomers:      1946-1964
-- 3. Generation X:      1965-1980
-- 4. Millennials:       1981-1996
-- 5. Generation Z:      1997-2012
-- 6. Generation Alpha:  2013-2024
-- 7. Generation Beta:   2025 onwards
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
PARTITION BY RANGE (YEAR(dob)) (
    PARTITION silent_gen
        VALUES LESS THAN (1946),

    PARTITION baby_boomers
        VALUES LESS THAN (1965),

    PARTITION gen_x
        VALUES LESS THAN (1981),

    PARTITION millennials
        VALUES LESS THAN (1997),

    PARTITION gen_z
        VALUES LESS THAN (2013),

    PARTITION gen_alpha
        VALUES LESS THAN (2025),

    PARTITION gen_beta
        VALUES LESS THAN MAXVALUE
);


-- =========================================================
-- 3. Insert the sample data
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
ORDER BY dob;


-- =========================================================
-- 5. Inspect partition definitions and row estimates
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
-- 6. Count actual records in each partition
-- =========================================================

SELECT
    'silent_gen' AS partition_name,
    COUNT(*) AS total_records
FROM citizen_data_management.citizen
    PARTITION (silent_gen)

UNION ALL

SELECT
    'baby_boomers',
    COUNT(*)
FROM citizen_data_management.citizen
    PARTITION (baby_boomers)

UNION ALL

SELECT
    'gen_x',
    COUNT(*)
FROM citizen_data_management.citizen
    PARTITION (gen_x)

UNION ALL

SELECT
    'millennials',
    COUNT(*)
FROM citizen_data_management.citizen
    PARTITION (millennials)

UNION ALL

SELECT
    'gen_z',
    COUNT(*)
FROM citizen_data_management.citizen
    PARTITION (gen_z)

UNION ALL

SELECT
    'gen_alpha',
    COUNT(*)
FROM citizen_data_management.citizen
    PARTITION (gen_alpha)

UNION ALL

SELECT
    'gen_beta',
    COUNT(*)
FROM citizen_data_management.citizen
    PARTITION (gen_beta);


-- =========================================================
-- 7. Count Generation Z citizens
-- =========================================================

SELECT
    COUNT(*) AS total_gen_z_citizens
FROM citizen_data_management.citizen
    PARTITION (gen_z);


-- =========================================================
-- 8. Examine the execution plan for the DOB query
-- =========================================================

EXPLAIN
SELECT *
FROM citizen_data_management.citizen
WHERE dob BETWEEN '1999-01-01' AND '2010-12-31';


-- =========================================================
-- 9. Inspect the partition-aware execution plan
-- Use only if supported by your MySQL / MariaDB version.
-- =========================================================

EXPLAIN PARTITIONS
SELECT *
FROM citizen_data_management.citizen
WHERE dob BETWEEN '1999-01-01' AND '2010-12-31';


-- =========================================================
-- 10. Verify the table definition
-- =========================================================

SHOW CREATE TABLE citizen_data_management.citizen;


-- =========================================================
-- 11. Verify the total number of records
-- =========================================================

SELECT
    COUNT(*) AS total_citizens
FROM citizen_data_management.citizen;


-- =========================================================
-- End of 02_range_partitioning.sql
-- =========================================================
