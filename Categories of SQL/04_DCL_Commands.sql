
-- =====================================================
-- Topic: DCL Commands
-- File: 04_DCL_Commands.sql
-- Database: company_db
-- DBMS: MariaDB / MySQL
-- =====================================================

-- 1. Select the database
USE company_db;

-- 2. Create a read-only database user
-- Change the sample password before using this account
CREATE USER IF NOT EXISTS
    'company_reader'@'localhost'
IDENTIFIED BY 'ChangeThis_StrongPassword123!';

-- 3. Grant SELECT permission on company_db
GRANT SELECT
ON company_db.*
TO 'company_reader'@'localhost';

-- 4. Display the user's permissions
SHOW GRANTS FOR 'company_reader'@'localhost';

-- 5. Grant INSERT permission on the employee table
GRANT INSERT
ON company_db.company_employees
TO 'company_reader'@'localhost';

-- 6. Check the updated permissions
SHOW GRANTS FOR 'company_reader'@'localhost';

-- 7. Grant UPDATE permission on the employee table
GRANT UPDATE
ON company_db.company_employees
TO 'company_reader'@'localhost';

-- 8. Check the permissions again
SHOW GRANTS FOR 'company_reader'@'localhost';

-- 9. Revoke UPDATE permission
REVOKE UPDATE
ON company_db.company_employees
FROM 'company_reader'@'localhost';

-- 10. Verify the final permissions
SHOW GRANTS FOR 'company_reader'@'localhost';
