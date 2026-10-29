
-- =========================================================
-- Project: Student Management System
-- File: 11_partitioning.sql
-- DBMS: MySQL / MariaDB
-- Purpose: Table Partitioning and Performance Analysis
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 132: Create a partitioned enrollment demo table
--
-- Important:
-- This is a separate demonstration table.
-- MySQL partitioned InnoDB tables have foreign-key
-- limitations, so we do not partition the original
-- enrollments table.
-- =========================================================

CREATE TABLE IF NOT EXISTS enrollments_partition_demo (
    enrollment_id INT NOT NULL AUTO_INCREMENT,
    enrollment_date DATE NOT NULL,
    student_id INT NOT NULL,
    section_id INT NOT NULL,
    marks DECIMAL(5,2) DEFAULT NULL,

    PRIMARY KEY (enrollment_id, enrollment_date)
)
ENGINE = InnoDB
PARTITION BY RANGE (YEAR(enrollment_date)) (
    PARTITION p_before_2024 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);


-- =========================================================
-- Problem 133: Insert sample data from existing enrollments
-- =========================================================

INSERT IGNORE INTO enrollments_partition_demo (
    enrollment_id,
    enrollment_date,
    student_id,
    section_id,
    marks
)
SELECT
    enrollment_id,
    enrollment_date,
    student_id,
    section_id,
    marks
FROM enrollments;


-- =========================================================
-- Problem 134: Display all partitioned enrollment records
-- =========================================================

SELECT
    enrollment_id,
    enrollment_date,
    student_id,
    section_id,
    marks
FROM enrollments_partition_demo
ORDER BY enrollment_date, enrollment_id;


-- =========================================================
-- Problem 135: Find enrollments from 2025
-- =========================================================

SELECT
    enrollment_id,
    enrollment_date,
    student_id,
    section_id,
    marks
FROM enrollments_partition_demo
WHERE enrollment_date >= '2025-01-01'
  AND enrollment_date < '2026-01-01'
ORDER BY enrollment_date;



-- =========================================================
-- Problem 136: Inspect partition definitions
-- =========================================================

SHOW CREATE TABLE enrollments_partition_demo;


-- =========================================================
-- Problem 137: Inspect table status and storage information
-- =========================================================

SHOW TABLE STATUS LIKE 'enrollments_partition_demo';

-- =========================================================
-- Problem 138: Examine the query execution plan
-- =========================================================

EXPLAIN
SELECT
    enrollment_id,
    enrollment_date,
    student_id,
    marks
FROM enrollments_partition_demo
WHERE enrollment_date >= '2025-01-01'
  AND enrollment_date < '2026-01-01';


-- =========================================================
-- Problem 139: Check which partitions a query can access
-- Supported by MySQL and MariaDB versions that support
-- EXPLAIN PARTITIONS.
-- =========================================================

EXPLAIN PARTITIONS
SELECT
    enrollment_id,
    enrollment_date,
    student_id,
    marks
FROM enrollments_partition_demo
WHERE enrollment_date >= '2025-01-01'
  AND enrollment_date < '2026-01-01';


-- =========================================================
-- Problem 140: Count records by enrollment year
-- =========================================================

SELECT
    YEAR(enrollment_date) AS enrollment_year,
    COUNT(*) AS total_enrollments,
    COUNT(marks) AS graded_enrollments,
    ROUND(AVG(marks), 2) AS average_marks
FROM enrollments_partition_demo
GROUP BY YEAR(enrollment_date)
ORDER BY enrollment_year;


-- =========================================================
-- Problem 141: Verify the table's partitioning definition
-- =========================================================

SHOW CREATE TABLE enrollments_partition_demo;


-- =========================================================
-- End of 11_partitioning.sql
-- =========================================================
