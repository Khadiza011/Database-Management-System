
-- =====================================================
-- Topic: Introduction to SQL Indexing
-- File: 01_Introduction_to_Indexing.sql
-- Database: indexing_db
-- DBMS: MySQL
-- Tool: MySQL Workbench
-- =====================================================

-- 1. Create and select database
CREATE DATABASE IF NOT EXISTS indexing_db;
USE indexing_db;

-- =====================================================
-- PART 1: CREATE SAMPLE TABLE
-- =====================================================

-- 2. Create a products table
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
) ENGINE = InnoDB;

-- 3. Insert sample records
INSERT INTO products
    (product_id, product_name, category, price, stock)
VALUES
    (101, 'Laptop', 'Electronics', 75000.00, 10),
    (102, 'Mouse', 'Accessories', 800.00, 50),
    (103, 'Keyboard', 'Accessories', 1500.00, 30),
    (104, 'Monitor', 'Electronics', 18000.00, 15),
    (105, 'Chair', 'Furniture', 8500.00, 20),
    (106, 'Desk', 'Furniture', 12000.00, 12),
    (107, 'Headphone', 'Accessories', 2500.00, 25),
    (108, 'Printer', 'Electronics', 22000.00, 8),
    (109, 'Bookshelf', 'Furniture', 9500.00, 14),
    (110, 'Webcam', 'Electronics', 4500.00, 18)
ON DUPLICATE KEY UPDATE
    product_name = VALUES(product_name),
    category = VALUES(category),
    price = VALUES(price),
    stock = VALUES(stock);

-- 4. Display all products
SELECT * FROM products;

-- =====================================================
-- PART 2: UNDERSTANDING INDEXING
-- =====================================================

-- 5. Display existing indexes
SHOW INDEX FROM products;

-- 6. Search products without a secondary index
SELECT *
FROM products
WHERE category = 'Electronics';

-- 7. Analyze query execution plan
EXPLAIN
SELECT *
FROM products
WHERE category = 'Electronics';

-- =====================================================
-- PART 3: CREATE AN INDEX
-- =====================================================

-- 8. Create an index on the category column
-- Run this statement only once.
CREATE INDEX idx_products_category
ON products(category);

-- 9. Display indexes after creation
SHOW INDEX FROM products;

-- =====================================================
-- PART 4: SEARCH USING INDEX
-- =====================================================

-- 10. Search products using the indexed column
SELECT *
FROM products
WHERE category = 'Electronics';

-- 11. Analyze the query execution plan
EXPLAIN
SELECT *
FROM products
WHERE category = 'Electronics';

-- 12. Force MySQL to consider the created index
-- Useful for demonstrating index selection
EXPLAIN
SELECT *
FROM products FORCE INDEX (idx_products_category)
WHERE category = 'Electronics';

-- =====================================================
-- PART 5: SEARCH USING PRIMARY KEY
-- =====================================================

-- 13. Search a product using its primary key
SELECT *
FROM products
WHERE product_id = 101;

-- 14. Analyze primary key lookup
EXPLAIN
SELECT *
FROM products
WHERE product_id = 101;

-- =====================================================
-- PART 6: INDEX INFORMATION
-- =====================================================

-- 15. Display table structure
DESCRIBE products;

-- 16. Display complete table definition
SHOW CREATE TABLE products;
