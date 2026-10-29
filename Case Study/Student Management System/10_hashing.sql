
-- =========================================================
-- Project: Student Management System
-- File: 10_hashing.sql
-- DBMS: MySQL / MariaDB
-- Purpose: Hashing Concepts and SQL Demonstrations
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 123: Generate a SHA-256 hash
-- Demonstration only; not a password-storage solution.
-- =========================================================

SELECT
    SHA2('StudentManagementSystem', 256) AS sha256_hash;


-- =========================================================
-- Problem 124: Demonstrate deterministic hashing
-- The same input produces the same hash.
-- =========================================================

SELECT
    SHA2('CSE101', 256) AS first_hash,
    SHA2('CSE101', 256) AS second_hash;


-- =========================================================
-- Problem 125: Demonstrate different input values
-- =========================================================

SELECT
    SHA2('CSE101', 256) AS first_hash,
    SHA2('CSE102', 256) AS second_hash;


-- =========================================================
-- Problem 126: Generate hashes for course codes
-- =========================================================

SELECT
    course_id,
    course_code,
    SHA2(course_code, 256) AS course_code_hash
FROM courses
ORDER BY course_id;


-- =========================================================
-- Problem 127: Generate a hash for a sample email
-- Do not treat an ordinary hash as anonymization.
-- =========================================================

SELECT
    student_id,
    SHA2(LOWER(TRIM(email)), 256) AS email_hash
FROM students
ORDER BY student_id;


-- =========================================================
-- Problem 128: Demonstrate hash-based equality checking
-- =========================================================

SELECT
    course_id,
    course_code,
    course_title
FROM courses
WHERE SHA2(course_code, 256) = SHA2('CSE101', 256);


-- =========================================================
-- Problem 129: Compare direct lookup with hash lookup
-- Direct lookup is normally preferable for course codes.
-- =========================================================

-- Direct lookup
SELECT
    course_id,
    course_code,
    course_title
FROM courses
WHERE course_code = 'CSE101';

-- Hash comparison demonstration
SELECT
    course_id,
    course_code,
    course_title
FROM courses
WHERE SHA2(course_code, 256) = SHA2('CSE101', 256);


-- =========================================================
-- Problem 130: Inspect the existing unique course-code index
-- =========================================================

SHOW INDEX FROM courses;


-- =========================================================
-- Problem 131: Demonstrate a hash of a sample value
-- Never store real passwords using plain SHA2().
-- =========================================================

SELECT
    SHA2('ExampleValue123', 256) AS example_hash;


-- =========================================================
-- End of 10_hashing.sql
-- =========================================================
