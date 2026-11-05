
-- =====================================================
-- Topic: EXPLAIN and Query Optimization
-- File: 07_EXPLAIN_and_Query_Optimization.sql
-- Database: indexing_db
-- DBMS: MySQL
-- Tool: MySQL Workbench
-- =====================================================

-- 1. Select the database
CREATE DATABASE IF NOT EXISTS indexing_db;
USE indexing_db;

-- =====================================================
-- PART 1: CREATE SAMPLE TABLE
-- =====================================================

-- 2. Create an orders table
CREATE TABLE IF NOT EXISTS optimization_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL
) ENGINE = InnoDB;

-- 3. Insert sample records
INSERT INTO optimization_orders
    (order_id, customer_id, order_date, status, total_amount)
VALUES
    (1001, 101, '2026-01-05', 'Completed', 2500.00),
    (1002, 102, '2026-01-08', 'Pending', 1800.00),
    (1003, 101, '2026-02-10', 'Completed', 3200.00),
    (1004, 103, '2026-02-15', 'Cancelled', 1500.00),
    (1005, 104, '2026-03-01', 'Completed', 4500.00),
    (1006, 102, '2026-03-12', 'Pending', 2200.00),
    (1007, 105, '2026-04-05', 'Completed', 5500.00),
    (1008, 101, '2026-04-15', 'Pending', 2800.00),
    (1009, 103, '2026-05-20', 'Completed', 3800.00),
    (1010, 104, '2026-05-25', 'Cancelled', 1200.00)
ON DUPLICATE KEY UPDATE
    customer_id = VALUES(customer_id),
    order_date = VALUES(order_date),
    status = VALUES(status),
    total_amount = VALUES(total_amount);

-- 4. Display all orders
SELECT * FROM optimization_orders;

-- =====================================================
-- PART 2: UNDERSTANDING FULL TABLE SCAN
-- =====================================================

-- 5. Search orders by status
SELECT *
FROM optimization_orders
WHERE status = 'Completed';

-- 6. Analyze execution plan
EXPLAIN
SELECT *
FROM optimization_orders
WHERE status = 'Completed';

-- =====================================================
-- PART 3: CREATE AN INDEX
-- =====================================================

-- 7. Create an index on status
CREATE INDEX idx_orders_status
ON optimization_orders(status);

-- 8. Display indexes
SHOW INDEX FROM optimization_orders;

-- 9. Analyze the query again
EXPLAIN
SELECT *
FROM optimization_orders
WHERE status = 'Completed';

-- =====================================================
-- PART 4: UNDERSTANDING INDEX SELECTION
-- =====================================================

-- 10. Force MySQL to consider the status index
EXPLAIN
SELECT *
FROM optimization_orders FORCE INDEX (idx_orders_status)
WHERE status = 'Completed';

-- 11. Search orders using Primary Key
EXPLAIN
SELECT *
FROM optimization_orders
WHERE order_id = 1003;

-- =====================================================
-- PART 5: COMPOSITE INDEX OPTIMIZATION
-- =====================================================

-- 12. Create a composite index
CREATE INDEX idx_customer_status
ON optimization_orders(customer_id, status);

-- 13. Search using both indexed columns
EXPLAIN
SELECT *
FROM optimization_orders
WHERE customer_id = 101
AND status = 'Completed';

-- 14. Search using only the first indexed column
EXPLAIN
SELECT *
FROM optimization_orders
WHERE customer_id = 101;

-- 15. Search using only the second indexed column
EXPLAIN
SELECT *
FROM optimization_orders
WHERE status = 'Pending';

-- =====================================================
-- PART 6: DATE RANGE OPTIMIZATION
-- =====================================================

-- 16. Create an index on order_date
CREATE INDEX idx_orders_date
ON optimization_orders(order_date);

-- 17. Search using a date range
EXPLAIN
SELECT *
FROM optimization_orders
WHERE order_date >= '2026-02-01'
AND order_date < '2026-05-01';

-- =====================================================
-- PART 7: AVOID UNNECESSARY FUNCTIONS
-- =====================================================

-- 18. Non-SARGable query example
-- Applying a function to an indexed column can
-- prevent efficient index range access.
EXPLAIN
SELECT *
FROM optimization_orders
WHERE YEAR(order_date) = 2026;

-- 19. SARGable alternative
EXPLAIN
SELECT *
FROM optimization_orders
WHERE order_date >= '2026-01-01'
AND order_date < '2027-01-01';

-- =====================================================
-- PART 8: EXPLAIN ANALYZE
-- =====================================================

-- 20. Analyze actual query execution
-- Requires MySQL 8.0.18 or later.
EXPLAIN ANALYZE
SELECT *
FROM optimization_orders
WHERE customer_id = 101
AND status = 'Completed';

-- =====================================================
-- PART 9: OPTIMIZER STATISTICS
-- =====================================================

-- 21. Update table statistics
ANALYZE TABLE optimization_orders;

-- 22. Display all indexes
SHOW INDEX FROM optimization_orders;

-- 23. Display complete table definition
SHOW CREATE TABLE optimization_orders;
