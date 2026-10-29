
-- =====================================================
-- Topic: SQL Operators
-- File: 04_SQL_Operators.sql
-- Database: MySQL
-- =====================================================

USE university_db;

-- Insert sample data if the table is empty
INSERT INTO students (student_id, student_name, age, department)
SELECT 1, 'Rahim', 21, 'CSE'
WHERE NOT EXISTS (
    SELECT 1 FROM students WHERE student_id = 1
);

INSERT INTO students (student_id, student_name, age, department)
SELECT 2, 'Karim', 22, 'EEE'
WHERE NOT EXISTS (
    SELECT 1 FROM students WHERE student_id = 2
);

INSERT INTO students (student_id, student_name, age, department)
SELECT 3, 'Nusrat', 20, 'CSE'
WHERE NOT EXISTS (
    SELECT 1 FROM students WHERE student_id = 3
);

INSERT INTO students (student_id, student_name, age, department)
SELECT 4, 'Sadia', 23, 'BBA'
WHERE NOT EXISTS (
    SELECT 1 FROM students WHERE student_id = 4
);

INSERT INTO students (student_id, student_name, age, department)
SELECT 5, 'Hasan', 21, 'CSE'
WHERE NOT EXISTS (
    SELECT 1 FROM students WHERE student_id = 5
);

-- 1. Arithmetic Operators
SELECT 10 + 5 AS addition;
SELECT 10 - 5 AS subtraction;
SELECT 10 * 5 AS multiplication;
SELECT 10 / 5 AS division;
SELECT 10 % 3 AS remainder;

-- 2. Comparison Operators
SELECT * FROM students WHERE age = 21;
SELECT * FROM students WHERE age != 21;
SELECT * FROM students WHERE age > 21;
SELECT * FROM students WHERE age < 22;
SELECT * FROM students WHERE age >= 21;
SELECT * FROM students WHERE age <= 21;

-- 3. AND Operator
SELECT *
FROM students
WHERE age >= 21 AND department = 'CSE';

-- 4. OR Operator
SELECT *
FROM students
WHERE department = 'CSE' OR department = 'EEE';

-- 5. NOT Operator
SELECT *
FROM students
WHERE NOT department = 'CSE';

-- 6. BETWEEN Operator
SELECT *
FROM students
WHERE age BETWEEN 20 AND 22;

-- 7. IN Operator
SELECT *
FROM students
WHERE department IN ('CSE', 'EEE');

-- 8. NOT IN Operator
SELECT *
FROM students
WHERE department NOT IN ('CSE', 'EEE');

-- 9. LIKE Operator: Names starting with 'S'
SELECT *
FROM students
WHERE student_name LIKE 'S%';

-- 10. LIKE Operator: Names ending with 'm'
SELECT *
FROM students
WHERE student_name LIKE '%m';

-- 11. LIKE Operator: Names containing 'sa'
SELECT *
FROM students
WHERE student_name LIKE '%sa%';

-- 12. IS NULL Operator
SELECT *
FROM students
WHERE department IS NULL;

-- 13. IS NOT NULL Operator
SELECT *
FROM students
WHERE department IS NOT NULL;
