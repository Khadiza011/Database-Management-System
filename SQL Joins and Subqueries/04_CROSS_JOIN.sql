
-- =====================================================
-- Topic: CROSS JOIN
-- File: 04_CROSS_JOIN.sql
-- Database: retail_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
USE retail_db;

-- 2. Create a table of product colors
CREATE TABLE IF NOT EXISTS product_colors (
    color_id INT PRIMARY KEY,
    color_name VARCHAR(30) NOT NULL
) ENGINE = InnoDB;

-- 3. Create a table of product sizes
CREATE TABLE IF NOT EXISTS product_sizes (
    size_id INT PRIMARY KEY,
    size_name VARCHAR(20) NOT NULL
) ENGINE = InnoDB;

-- 4. Insert sample colors
INSERT INTO product_colors (color_id, color_name)
VALUES
    (1, 'Red'),
    (2, 'Blue'),
    (3, 'Black')
ON DUPLICATE KEY UPDATE
    color_name = VALUES(color_name);

-- 5. Insert sample sizes
INSERT INTO product_sizes (size_id, size_name)
VALUES
    (1, 'Small'),
    (2, 'Medium'),
    (3, 'Large')
ON DUPLICATE KEY UPDATE
    size_name = VALUES(size_name);

-- 6. Display all colors
SELECT * FROM product_colors;

-- 7. Display all sizes
SELECT * FROM product_sizes;

-- 8. Perform CROSS JOIN
SELECT
    c.color_name,
    s.size_name
FROM product_colors AS c
CROSS JOIN product_sizes AS s;

-- 9. Count all possible combinations
SELECT COUNT(*) AS total_combinations
FROM product_colors AS c
CROSS JOIN product_sizes AS s;

-- 10. Display combinations in a specific order
SELECT
    c.color_name,
    s.size_name
FROM product_colors AS c
CROSS JOIN product_sizes AS s
ORDER BY c.color_id, s.size_id;
