
-- =====================================================
-- Topic: PRIMARY KEY Constraint
-- File: 02_PRIMARY_KEY.sql
-- Database: sales_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
USE sales_db;

-- 2. Create a products table with a primary key
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2)
);

-- 3. Insert products without creating duplicate IDs
INSERT INTO products (product_id, product_name, price)
VALUES
    (101, 'Keyboard', 1200.00),
    (102, 'Mouse', 600.00),
    (103, 'Monitor', 15000.00)
ON DUPLICATE KEY UPDATE
    product_name = VALUES(product_name),
    price = VALUES(price);

-- 4. Display all products
SELECT * FROM products;

-- 5. Check the table structure
DESCRIBE products;

-- 6. Check the primary key definition
SHOW CREATE TABLE products;

-- 7. Create a table with a composite primary key
CREATE TABLE IF NOT EXISTS order_items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

-- 8. Insert order items without creating duplicate combinations
INSERT INTO order_items (order_id, product_id, quantity)
VALUES
    (1, 101, 2),
    (1, 102, 1),
    (2, 101, 3)
ON DUPLICATE KEY UPDATE
    quantity = VALUES(quantity);

-- 9. Display all order items
SELECT * FROM order_items;

-- 10. Check the composite primary key
SHOW CREATE TABLE order_items;
