
-- =====================================================
-- Topic: FULLTEXT Index
-- File: 05_Full_Text_Index.sql
-- Database: indexing_db
-- DBMS: MySQL
-- Tool: MySQL Workbench
-- =====================================================

-- 1. Select the database
CREATE DATABASE IF NOT EXISTS indexing_db;
USE indexing_db;

-- =====================================================
-- PART 1: CREATE ARTICLES TABLE
-- =====================================================

-- 2. Create an articles table
CREATE TABLE IF NOT EXISTS articles (
    article_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    author VARCHAR(100) NOT NULL
) ENGINE = InnoDB;

-- 3. Insert sample articles
INSERT INTO articles
    (article_id, title, content, author)
VALUES
    (1, 'Introduction to MySQL',
     'MySQL is a relational database management system used to store and manage data.',
     'Rahim Ahmed'),

    (2, 'Database Indexing',
     'Database indexing improves query performance and makes data retrieval faster.',
     'Karim Hasan'),

    (3, 'SQL Query Optimization',
     'SQL query optimization helps improve database performance using indexes and efficient queries.',
     'Nusrat Jahan'),

    (4, 'Learning Database Design',
     'Database design involves tables, relationships, primary keys and foreign keys.',
     'Sadia Islam'),

    (5, 'Introduction to Programming',
     'Programming involves writing instructions to solve computational problems.',
     'Hasan Mahmud'),

    (6, 'MySQL Fulltext Search',
     'Fulltext search allows users to find relevant articles using keywords and natural language.',
     'Mim Akter')

ON DUPLICATE KEY UPDATE
    title = VALUES(title),
    content = VALUES(content),
    author = VALUES(author);

-- 4. Display all articles
SELECT * FROM articles;

-- =====================================================
-- PART 2: CREATE FULLTEXT INDEX
-- =====================================================

-- 5. Create a FULLTEXT index on title and content
-- Run only once.
CREATE FULLTEXT INDEX idx_articles_fulltext
ON articles(title, content);

-- 6. Display index information
SHOW INDEX FROM articles;

-- =====================================================
-- PART 3: NATURAL LANGUAGE SEARCH
-- =====================================================

-- 7. Search articles containing the word database
SELECT
    article_id,
    title,
    author
FROM articles
WHERE MATCH(title, content)
AGAINST('database' IN NATURAL LANGUAGE MODE);

-- 8. Search articles containing MySQL
SELECT
    article_id,
    title,
    author
FROM articles
WHERE MATCH(title, content)
AGAINST('MySQL' IN NATURAL LANGUAGE MODE);

-- =====================================================
-- PART 4: BOOLEAN MODE SEARCH
-- =====================================================

-- 9. Search articles containing both MySQL and database
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
AGAINST('+MySQL +database' IN BOOLEAN MODE);

-- 10. Search articles containing MySQL
-- but excluding programming
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
AGAINST('+MySQL -programming' IN BOOLEAN MODE);

-- 11. Search articles containing either MySQL or SQL
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
AGAINST('MySQL SQL' IN BOOLEAN MODE);

-- =====================================================
-- PART 5: RELEVANCE SCORE
-- =====================================================

-- 12. Display search results with relevance score
SELECT
    article_id,
    title,
    MATCH(title, content)
    AGAINST('database indexing' IN NATURAL LANGUAGE MODE)
    AS relevance_score
FROM articles
WHERE MATCH(title, content)
AGAINST('database indexing' IN NATURAL LANGUAGE MODE)
ORDER BY relevance_score DESC;

-- =====================================================
-- PART 6: PHRASE SEARCH
-- =====================================================

-- 13. Search for an exact phrase
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
AGAINST('"database management system"' IN BOOLEAN MODE);

-- =====================================================
-- PART 7: VERIFY FULLTEXT INDEX
-- =====================================================

-- 14. Display all indexes
SHOW INDEX FROM articles;

-- 15. Display complete table definition
SHOW CREATE TABLE articles;
