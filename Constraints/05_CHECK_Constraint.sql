
-- =====================================================
-- Topic: CHECK Constraint
-- File: 05_CHECK_Constraint.sql
-- Database: sales_db
-- DBMS: MariaDB / MySQL
-- =====================================================

-- 1. Select the database
USE sales_db;

-- 2. Create a products table with CHECK constraints
CREATE TABLE IF NOT EXISTS checked_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    CONSTRAINT chk_product_price CHECK (price > 0),
    CONSTRAINT chk_product_stock CHECK (stock >= 0)
) ENGINE = InnoDB;

-- 3. Insert valid product records
INSERT INTO checked_products
    (product_id, product_name, price, stock)
VALUES
    (1, 'Keyboard', 1200.00, 10),
    (2, 'Mouse', 600.00, 15),
    (3, 'Monitor', 15000.00, 5);

-- 4. Display all products
SELECT * FROM checked_products;

-- 5. Insert a product with a valid price and stock
INSERT INTO checked_products
    (product_id, product_name, price, stock)
VALUES
    (4, 'USB Cable', 250.00, 20);

-- 6. Verify the records
SELECT * FROM checked_products;

-- 7. Check the table structure and constraints
SHOW CREATE TABLE checked_products;
