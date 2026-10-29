
-- =====================================================
-- Topic: Combined SQL Constraints
-- File: 06_Combined_Constraints.sql
-- Database: sales_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
USE sales_db;

-- 2. Create a table for product categories
CREATE TABLE IF NOT EXISTS product_categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE = InnoDB;

-- 3. Create a products table with combined constraints
CREATE TABLE IF NOT EXISTS combined_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_code VARCHAR(30) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    status VARCHAR(20) NOT NULL DEFAULT 'Available',
    category_id INT,
    CONSTRAINT chk_combined_price
        CHECK (price > 0),
    CONSTRAINT chk_combined_stock
        CHECK (stock >= 0),
    CONSTRAINT fk_combined_category
        FOREIGN KEY (category_id)
        REFERENCES product_categories(category_id)
) ENGINE = InnoDB;

-- 4. Insert product categories
INSERT INTO product_categories (category_id, category_name)
VALUES
    (1, 'Electronics'),
    (2, 'Accessories'),
    (3, 'Office Supplies');

-- 5. Insert valid products
INSERT INTO combined_products (
    product_id,
    product_name,
    product_code,
    price,
    stock,
    category_id
)
VALUES
    (101, 'Keyboard', 'KB101', 1200.00, 10, 1),
    (102, 'Mouse', 'MS102', 600.00, 15, 1),
    (103, 'USB Cable', 'USB103', 250.00, 20, 2);

-- 6. Insert a product using default values
INSERT INTO combined_products (
    product_id,
    product_name,
    product_code,
    price,
    category_id
)
VALUES
    (104, 'Notebook', 'NB104', 100.00, 3);

-- 7. Display all categories
SELECT * FROM product_categories;

-- 8. Display all products
SELECT * FROM combined_products;

-- 9. Display the table definition
SHOW CREATE TABLE combined_products;

-- 10. Verify default values
SELECT
    product_name,
    stock,
    status
FROM combined_products
WHERE product_id = 104;
