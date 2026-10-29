
-- =========================================================
-- Project: Jules Rimet Trophy Investigation
-- File: 01_schema.sql
-- Database: jules_rimet_investigation
-- DBMS: MySQL 8.x
-- Purpose: Create the investigation database and tables
-- =========================================================


-- =========================================================
-- 1. Create and select the database
-- =========================================================

CREATE DATABASE IF NOT EXISTS jules_rimet_investigation;

USE jules_rimet_investigation;


-- =========================================================
-- 2. Trophy Table
-- Stores information about the stolen trophy.
-- =========================================================

CREATE TABLE IF NOT EXISTS trophy (
    trophy_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    trophy_name VARCHAR(100) NOT NULL,
    trophy_type VARCHAR(100),
    official_value DECIMAL(12,2),
    insurance_value DECIMAL(12,2),
    status VARCHAR(30) NOT NULL
);


-- =========================================================
-- 3. Person Table
-- Stores people associated with the investigation.
-- A person is not necessarily a suspect.
-- =========================================================

CREATE TABLE IF NOT EXISTS person (
    person_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(120) NOT NULL,
    role VARCHAR(80) NOT NULL,
    notes TEXT
);


-- =========================================================
-- 4. Location Table
-- Stores locations associated with the investigation.
-- =========================================================

CREATE TABLE IF NOT EXISTS location (
    location_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    location_name VARCHAR(150) NOT NULL,
    city VARCHAR(100),
    description TEXT
);


-- =========================================================
-- 5. Investigation Event Table
-- Stores events, dates, times, locations, and descriptions.
-- location_id is nullable because some events may not have
-- a documented location.
-- =========================================================

CREATE TABLE IF NOT EXISTS investigation_event (
    event_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(150) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME,
    location_id BIGINT,
    description TEXT,

    CONSTRAINT fk_event_location
        FOREIGN KEY (location_id)
        REFERENCES location(location_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_event_date (event_date),
    INDEX idx_event_location (location_id)
);


-- =========================================================
-- 6. Witness Statement Table
-- Connects a person with a statement and, where applicable,
-- the event related to that statement.
-- =========================================================

CREATE TABLE IF NOT EXISTS witness_statement (
    statement_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    person_id BIGINT NOT NULL,
    event_id BIGINT,
    statement_date DATE,
    statement_text TEXT,

    CONSTRAINT fk_statement_person
        FOREIGN KEY (person_id)
        REFERENCES person(person_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_statement_event
        FOREIGN KEY (event_id)
        REFERENCES investigation_event(event_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    INDEX idx_statement_person (person_id),
    INDEX idx_statement_event (event_id)
);


-- =========================================================
-- 7. Verify the database structure
-- =========================================================

SHOW TABLES;

DESCRIBE trophy;
DESCRIBE person;
DESCRIBE location;
DESCRIBE investigation_event;
DESCRIBE witness_statement;


-- =========================================================
-- End of 01_schema.sql
-- =========================================================
