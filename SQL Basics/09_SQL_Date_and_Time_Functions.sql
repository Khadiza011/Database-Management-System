
-- =====================================================
-- Topic: SQL Date and Time Functions
-- File: 09_SQL_Date_and_Time_Functions.sql
-- Database: MySQL / MariaDB
-- =====================================================

USE university_db;

-- 1. Display the current date
SELECT CURDATE() AS current_date_value;

-- 2. Display the current date and time
SELECT NOW() AS current_datetime_value;

-- 3. Display the current time
SELECT CURTIME() AS current_time_value;

-- 4. Extract the date from a datetime value
SELECT DATE('2026-10-29 14:30:00') AS extracted_date;

-- 5. Extract the year
SELECT YEAR('2026-10-29') AS year_value;

-- 6. Extract the month
SELECT MONTH('2026-10-29') AS month_value;

-- 7. Extract the day
SELECT DAY('2026-10-29') AS day_value;

-- 8. Display the month name
SELECT MONTHNAME('2026-10-29') AS month_name;

-- 9. Display the weekday name
SELECT DAYNAME('2026-10-29') AS weekday_name;

-- 10. Format a date
SELECT DATE_FORMAT(
    '2026-10-29', '%d-%m-%Y'
) AS formatted_date;

-- 11. Add 10 days to a date
SELECT DATE_ADD(
    '2026-10-29', INTERVAL 10 DAY
) AS future_date;

-- 12. Subtract 2 months from a date
SELECT DATE_SUB(
    '2026-10-29', INTERVAL 2 MONTH
) AS previous_date;

-- 13. Calculate the difference between two dates
SELECT DATEDIFF(
    '2026-11-10', '2026-10-29'
) AS days_difference;

-- 14. Calculate the difference in years
SELECT TIMESTAMPDIFF(
    YEAR, '2000-01-01', '2026-10-29'
) AS years_difference;

-- 15. Extract hour, minute, and second
SELECT
    HOUR('14:35:42') AS hour_value,
    MINUTE('14:35:42') AS minute_value,
    SECOND('14:35:42') AS second_value;

-- 16. Find the last day of a month
SELECT LAST_DAY(
    '2026-10-15'
) AS month_end;

-- 17. Get the current year, month, and day
SELECT
    YEAR(CURDATE()) AS current_year_value,
    MONTH(CURDATE()) AS current_month_value,
    DAY(CURDATE()) AS current_day_value;
