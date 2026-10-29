
-- =========================================================
-- Project: Student Management System
-- File: 08_security.sql
-- DBMS: MySQL / MariaDB
-- Purpose: DCL, GRANT, REVOKE and Access Control
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 101: Inspect current database user
-- =========================================================

SELECT
    USER() AS connected_user,
    CURRENT_USER() AS authenticated_account;


-- =========================================================
-- Problem 102: Inspect privileges of the current user
-- =========================================================

SHOW GRANTS;


-- =========================================================
-- Problem 103: Create a read-only reporting account
--
-- Run this section only if you have permission to create users.
-- Replace the password placeholder before execution.
-- =========================================================

-- CREATE USER 'sms_reporter'@'localhost'
-- IDENTIFIED BY 'REPLACE_WITH_A_STRONG_PASSWORD';


-- =========================================================
-- Problem 104: Grant read-only access to reporting views
--
-- Requires the views to have been created first.
-- =========================================================

-- GRANT SELECT
-- ON student_management_db.vw_student_details
-- TO 'sms_reporter'@'localhost';

-- GRANT SELECT
-- ON student_management_db.vw_enrollment_details
-- TO 'sms_reporter'@'localhost';

-- GRANT SELECT
-- ON student_management_db.vw_student_academic_summary
-- TO 'sms_reporter'@'localhost';

-- GRANT SELECT
-- ON student_management_db.vw_course_performance
-- TO 'sms_reporter'@'localhost';


-- =========================================================
-- Problem 105: Create a student records viewer
-- =========================================================

-- CREATE USER 'sms_student_viewer'@'localhost'
-- IDENTIFIED BY 'REPLACE_WITH_ANOTHER_STRONG_PASSWORD';

-- GRANT SELECT
-- ON student_management_db.students
-- TO 'sms_student_viewer'@'localhost';


-- =========================================================
-- Problem 106: Create a student management staff account
-- Staff can view, insert and update student records.
-- DELETE permission is not granted.
-- =========================================================

-- CREATE USER 'sms_student_staff'@'localhost'
-- IDENTIFIED BY 'REPLACE_WITH_A_DIFFERENT_STRONG_PASSWORD';

-- GRANT SELECT, INSERT, UPDATE
-- ON student_management_db.students
-- TO 'sms_student_staff'@'localhost';


-- =========================================================
-- Problem 107: Verify account privileges
-- =========================================================

-- SHOW GRANTS FOR 'sms_reporter'@'localhost';
-- SHOW GRANTS FOR 'sms_student_viewer'@'localhost';
-- SHOW GRANTS FOR 'sms_student_staff'@'localhost';


-- =========================================================
-- Problem 108: Revoke UPDATE permission from staff
-- =========================================================

-- REVOKE UPDATE
-- ON student_management_db.students
-- FROM 'sms_student_staff'@'localhost';

-- Verify the updated privileges.
-- SHOW GRANTS FOR 'sms_student_staff'@'localhost';


-- =========================================================
-- Problem 109: Restore UPDATE permission when authorized
-- =========================================================

-- GRANT UPDATE
-- ON student_management_db.students
-- TO 'sms_student_staff'@'localhost';


-- =========================================================
-- Problem 110: Remove an account when no longer required
-- =========================================================

-- DROP USER 'sms_student_viewer'@'localhost';


-- =========================================================
-- End of 08_security.sql
-- =========================================================
