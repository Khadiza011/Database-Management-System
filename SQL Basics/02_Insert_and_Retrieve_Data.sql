
-- =====================================================
-- Topic: Inserting and Retrieving Data
-- File: 02_Insert_and_Retrieve_Data.sql
-- Database: MySQL
-- =====================================================

-- Select the database
USE university_db;

-- 1. Insert a single record
INSERT INTO students (student_id, student_name, age, department)
VALUES (1, 'Rahim', 21, 'CSE');

-- 2. Insert multiple records
INSERT INTO students (student_id, student_name, age, department)
VALUES
(2, 'Karim', 22, 'EEE'),
(3, 'Nusrat', 20, 'CSE'),
(4, 'Sadia', 23, 'BBA'),
(5, 'Hasan', 21, 'CSE');

-- 3. Display all records
SELECT * FROM students;

-- 4. Display specific columns
SELECT student_name, department
FROM students;

-- 5. Retrieve students from the CSE department
SELECT *
FROM students
WHERE department = 'CSE';

-- 6. Retrieve students older than 20
SELECT *
FROM students
WHERE age > 20;

-- 7. Sort students by age in ascending order
SELECT *
FROM students
ORDER BY age ASC;

-- 8. Sort students by age in descending order
SELECT *
FROM students
ORDER BY age DESC;

-- 9. Display unique departments
SELECT DISTINCT department
FROM students;

-- 10. Display only the first three records
SELECT *
FROM students
LIMIT 3;
