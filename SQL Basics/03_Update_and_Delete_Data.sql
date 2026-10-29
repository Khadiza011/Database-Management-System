
-- =====================================================
-- Topic: Updating and Deleting Data
-- File: 03_Update_and_Delete_Data.sql
-- Database: MySQL
-- =====================================================

-- Select the database
USE university_db;

-- 1. Display all student records
SELECT * FROM students;

-- 2. Update the age of a student
UPDATE students
SET age = 22
WHERE student_id = 1;

-- 3. Update a student's department
UPDATE students
SET department = 'EEE'
WHERE student_id = 3;

-- 4. Update multiple columns
UPDATE students
SET age = 24, department = 'CSE'
WHERE student_id = 4;

-- 5. Verify the updated records
SELECT * FROM students;

-- 6. Delete a specific student
DELETE FROM students
WHERE student_id = 5;

-- 7. Verify the deletion
SELECT * FROM students;

-- 8. Update all students in a specific department
UPDATE students
SET department = 'Computer Science'
WHERE department = 'CSE';

-- 9. Display the final records
SELECT * FROM students;
