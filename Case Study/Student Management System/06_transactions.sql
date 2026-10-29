
-- =========================================================
-- Project: Student Management System
-- File: transactions.sql
-- Database: student_management_db
-- DBMS: MySQL / MariaDB
-- Purpose: Transactions, COMMIT, ROLLBACK and SAVEPOINT
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 94: Demonstrate ROLLBACK
-- Purpose: Cancel an uncommitted result update.
-- Final database state remains unchanged.
-- =========================================================

START TRANSACTION;

UPDATE enrollments
SET marks = 95.00
WHERE enrollment_id = 1;

-- Check the temporary change inside this transaction.
SELECT enrollment_id, marks
FROM enrollments
WHERE enrollment_id = 1;

-- Cancel the change.
ROLLBACK;

-- Verify that the original marks have been restored.
SELECT enrollment_id, marks
FROM enrollments
WHERE enrollment_id = 1;


-- =========================================================
-- Problem 95: Demonstrate SAVEPOINT
-- Purpose: Undo part of a transaction while retaining
-- earlier changes temporarily.
-- =========================================================

START TRANSACTION;

-- First change.
UPDATE enrollments
SET marks = 89.00
WHERE enrollment_id = 1;

SAVEPOINT before_second_update;

-- Second change.
UPDATE enrollments
SET marks = 98.00
WHERE enrollment_id = 1;

-- Undo only the second change.
ROLLBACK TO SAVEPOINT before_second_update;

-- The marks should now be 89.00 inside this transaction.
SELECT enrollment_id, marks
FROM enrollments
WHERE enrollment_id = 1;

-- Cancel all changes made in this demonstration.
ROLLBACK;


-- =========================================================
-- Problem 96: Demonstrate COMMIT
-- Purpose: Permanently store an intentional result update.
-- The example sets marks to the existing value, so sample
-- data and expected results remain unchanged.
-- =========================================================

START TRANSACTION;

UPDATE enrollments
SET marks = 88.00
WHERE enrollment_id = 1;

COMMIT;

-- Verify the committed value.
SELECT enrollment_id, marks
FROM enrollments
WHERE enrollment_id = 1;


-- =========================================================
-- Problem 97: Enroll a student safely
-- Student 1004 enrolls in section 501.
--
-- Conditions:
-- 1. Section exists.
-- 2. Capacity is available.
-- 3. Student is not already enrolled.
--
-- The section row is locked before checking capacity.
-- All enrollment workflows must follow the same locking
-- protocol to coordinate concurrent enrollments.
-- =========================================================

START TRANSACTION;

-- Lock the target section until the transaction ends.
SELECT
    section_id,
    capacity
FROM course_sections
WHERE section_id = 501
FOR UPDATE;

-- Insert only if the section exists, capacity is available,
-- and this student has not already enrolled in the section.
INSERT INTO enrollments (
    student_id,
    section_id,
    enrollment_date,
    marks,
    grade
)
SELECT
    1004,
    cs.section_id,
    CURDATE(),
    NULL,
    NULL
FROM course_sections AS cs
WHERE cs.section_id = 501
  AND (
      SELECT COUNT(*)
      FROM enrollments AS e
      WHERE e.section_id = cs.section_id
  ) < cs.capacity
  AND NOT EXISTS (
      SELECT 1
      FROM enrollments AS existing
      WHERE existing.student_id = 1004
        AND existing.section_id = cs.section_id
  );

-- Verify the current section enrollment count.
SELECT
    cs.section_id,
    cs.capacity,
    COUNT(e.enrollment_id) AS enrolled_students,
    cs.capacity - COUNT(e.enrollment_id) AS available_seats
FROM course_sections AS cs
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
WHERE cs.section_id = 501
GROUP BY cs.section_id, cs.capacity;

-- Make the enrollment permanent.
COMMIT;


-- =========================================================
-- Problem 98: Demonstrate a conditional result update
-- Purpose: Update marks only for an existing enrollment
-- whose result is still pending.
-- =========================================================

START TRANSACTION;

UPDATE enrollments
SET marks = 84.00,
    grade = 'A'
WHERE enrollment_id = 13
  AND marks IS NULL
  AND grade IS NULL;

-- Inspect the result before committing.
SELECT
    enrollment_id,
    student_id,
    section_id,
    marks,
    grade
FROM enrollments
WHERE enrollment_id = 13;

-- Commit the result update if it is intended.
-- Use ROLLBACK instead if the result is incorrect.
COMMIT;


-- =========================================================
-- Problem 99: Verify transaction-related records
-- =========================================================

SELECT
    enrollment_id,
    student_id,
    section_id,
    enrollment_date,
    marks,
    grade
FROM enrollments
ORDER BY enrollment_id;


-- =========================================================
-- Problem 100: Verify section capacity
-- =========================================================

SELECT
    cs.section_id,
    c.course_code,
    cs.capacity,
    COUNT(e.enrollment_id) AS enrolled_students,
    cs.capacity - COUNT(e.enrollment_id) AS available_seats
FROM course_sections AS cs
JOIN courses AS c
    ON cs.course_id = c.course_id
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    cs.section_id,
    c.course_code,
    cs.capacity
ORDER BY cs.section_id;
