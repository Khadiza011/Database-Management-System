
-- =====================================================
-- Topic: SQL Date and Time Functions
-- File: 09_SQL_Date_and_Time_Functions.sql
-- Database: MySQL
-- =====================================================

USE university_db;

-- 1. Display the current date
SELECT CURDATE() AS Current_Date;

-- 2. Display the current date and time
SELECT NOW() AS Current_Date_Time;

-- 3. Display the current time
SELECT CURTIME() AS Current_Time;

-- 4. Extract the date from a datetime value
SELECT DATE('2026-10-29 14:30:00') AS Extracted_Date;

-- 5. Extract the year
SELECT YEAR('2026-10-29') AS Year_Value;

-- 6. Extract the month
SELECT MONTH('2026-10-29') AS Month_Value;

-- 7. Extract the day
SELECT DAY('2026-10-29') AS Day_Value;

-- 8. Display the month name
SELECT MONTHNAME('2026-10-29') AS Month_Name;

-- 9. Display the weekday name
SELECT DAYNAME('2026-10-29') AS Weekday_Name;

-- 10. Format a date
SELECT
    DATE_FORMAT('2026-10-29', '%d-%m-%Y') AS Formatted_Date;

-- 11. Add 10 days to a date
SELECT
    DATE_ADD('2026-10-29', INTERVAL 10 DAY) AS Future_Date;

-- 12. Subtract 2 months from a date
SELECT
    DATE_SUB('2026-10-29', INTERVAL 2 MONTH) AS Previous_Date;

-- 13. Calculate the difference between two dates in days
SELECT
    DATEDIFF('2026-11-10', '2026-10-29') AS Days_Difference;

-- 14. Calculate the difference in years
SELECT
    TIMESTAMPDIFF(
        YEAR,
        '2000-01-01',
        '2026-10-29'
    ) AS Years_Difference;

-- 15. Extract the hour, minute, and second
SELECT
    HOUR('14:35:42') AS Hour_Value,
    MINUTE('14:35:42') AS Minute_Value,
    SECOND('14:35:42') AS Second_Value;

-- 16. Find the last day of a month
SELECT LAST_DAY('2026-10-15') AS Month_End;

-- 17. Get the current year, month, and day
SELECT
    YEAR(CURDATE()) AS Current_Year,
    MONTH(CURDATE()) AS Current_Month,
    DAY(CURDATE()) AS Current_Day;
