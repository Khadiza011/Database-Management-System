
-- =====================================================
-- Topic: DEFAULT Constraint
-- File: 04_DEFAULT_Constraint.sql
-- Database: sales_db
-- DBMS: MariaDB / MySQL
-- =====================================================

-- 1. Select the database
USE sales_db;

-- 2. Create a products table with default values
CREATE TABLE IF NOT EXISTS default_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) DEFAULT 0.00,
    stock INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'Available'
) ENGINE = InnoDB;

-- 3. Insert a product with all values
INSERT INTO default_products
    (product_id, product_name, price, stock, status)
VALUES
    (1, 'Keyboard', 1200.00, 10, 'Available');

-- 4. Insert a product without optional columns
-- Default values will be applied
INSERT INTO default_products
    (product_id, product_name)
VALUES
    (2, 'Mouse');

-- 5. Insert another product with only price specified
INSERT INTO default_products
    (product_id, product_name, price)
VALUES
    (3, 'USB Cable', 250.00);

-- 6. Display all products
SELECT * FROM default_products;

-- 7. Check the table structure
DESCRIBE default_products;

-- 8. Check the default definitions
SHOW CREATE TABLE default_products;

-- 9. Explicitly insert a value different from the default
INSERT INTO default_products
    (product_id, product_name, stock)
VALUES
    (4, 'Webcam', 5);

-- 10. Display the final records
SELECT * FROM default_products
ORDER BY product_id;
