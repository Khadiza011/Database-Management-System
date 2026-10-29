
-- =========================================================
-- Project: Child Vaccination Management System
-- File: 01_schema.sql
-- Database: child_vaccination_db
-- DBMS: MySQL / MariaDB
-- Purpose: Database Schema and Relational Integrity
-- =========================================================


-- =========================================================
-- 1. Create and select the database
-- =========================================================

CREATE DATABASE IF NOT EXISTS child_vaccination_db;

USE child_vaccination_db;


-- =========================================================
-- 2. Facilities
-- Stores vaccination centres and healthcare facilities.
-- =========================================================

CREATE TABLE facilities (
    facility_id INT AUTO_INCREMENT PRIMARY KEY,
    facility_name VARCHAR(150) NOT NULL,
    facility_type VARCHAR(40) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(30),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_facility_type
        CHECK (facility_type IN (
            'Hospital',
            'Clinic',
            'Health Center',
            'Vaccination Center'
        ))
) ENGINE = InnoDB;


-- =========================================================
-- 3. Children
-- Stores basic child information.
-- =========================================================

CREATE TABLE children (
    child_id INT AUTO_INCREMENT PRIMARY KEY,
    national_id VARCHAR(30) UNIQUE,
    full_name VARCHAR(120) NOT NULL,
    date_of_birth DATE NOT NULL,
    sex VARCHAR(20),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_child_sex
        CHECK (
            sex IS NULL
            OR sex IN ('Male', 'Female', 'Other', 'Unknown')
        )
) ENGINE = InnoDB;


-- =========================================================
-- 4. Guardians
-- Stores parents and other responsible guardians.
-- =========================================================

CREATE TABLE guardians (
    guardian_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    email VARCHAR(150),
    address VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;


-- =========================================================
-- 5. Child-Guardian Relationships
-- Supports multiple guardians per child and vice versa.
-- =========================================================

CREATE TABLE child_guardians (
    child_id INT NOT NULL,
    guardian_id INT NOT NULL,
    relationship_type VARCHAR(40) NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,

    PRIMARY KEY (child_id, guardian_id),

    CONSTRAINT fk_child_guardians_child
        FOREIGN KEY (child_id)
        REFERENCES children(child_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_child_guardians_guardian
        FOREIGN KEY (guardian_id)
        REFERENCES guardians(guardian_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;


-- =========================================================
-- 6. Roles
-- Defines application-level database user roles.
-- =========================================================

CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
) ENGINE = InnoDB;


-- =========================================================
-- 7. Health Workers
-- Each worker belongs to a healthcare facility.
-- =========================================================

CREATE TABLE health_workers (
    worker_id INT AUTO_INCREMENT PRIMARY KEY,
    facility_id INT NOT NULL,
    full_name VARCHAR(120) NOT NULL,
    license_no VARCHAR(80) NOT NULL UNIQUE,
    job_title VARCHAR(60) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_health_workers_facility
        FOREIGN KEY (facility_id)
        REFERENCES facilities(facility_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;


-- =========================================================
-- 8. Application Users
-- Stores authentication-related account information.
-- password_hash must contain a password hash, never plaintext.
-- =========================================================

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    worker_id INT UNIQUE,
    username VARCHAR(80) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_users_role
        FOREIGN KEY (role_id)
        REFERENCES roles(role_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_users_worker
        FOREIGN KEY (worker_id)
        REFERENCES health_workers(worker_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE = InnoDB;


-- =========================================================
-- 9. Vaccines
-- Stores vaccine catalogue information.
-- =========================================================

CREATE TABLE vaccines (
    vaccine_id INT AUTO_INCREMENT PRIMARY KEY,
    vaccine_name VARCHAR(120) NOT NULL UNIQUE,
    disease_target VARCHAR(150) NOT NULL,
    manufacturer VARCHAR(120),
    description VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;


-- =========================================================
-- 10. Vaccine Doses
-- Defines the configured dose schedule for each vaccine.
-- Ages and intervals are expressed in days.
-- These values must be verified against an approved schedule.
-- =========================================================

CREATE TABLE vaccine_doses (
    dose_id INT AUTO_INCREMENT PRIMARY KEY,
    vaccine_id INT NOT NULL,
    dose_number INT NOT NULL,
    recommended_age_days INT NOT NULL,
    min_interval_days INT NOT NULL DEFAULT 0,

    CONSTRAINT uq_vaccine_dose
        UNIQUE (vaccine_id, dose_number),

    CONSTRAINT chk_dose_number
        CHECK (dose_number > 0),

    CONSTRAINT chk_recommended_age
        CHECK (recommended_age_days >= 0),

    CONSTRAINT chk_min_interval
        CHECK (min_interval_days >= 0),

    CONSTRAINT fk_vaccine_doses_vaccine
        FOREIGN KEY (vaccine_id)
        REFERENCES vaccines(vaccine_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;


-- =========================================================
-- 11. Appointments
-- Stores scheduled vaccination visits.
-- =========================================================

CREATE TABLE appointments (
    appointment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    child_id INT NOT NULL,
    facility_id INT NOT NULL,
    scheduled_at DATETIME NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Scheduled',
    notes VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_appointment_status
        CHECK (status IN (
            'Scheduled',
            'Completed',
            'Cancelled',
            'Missed'
        )),

    CONSTRAINT fk_appointments_child
        FOREIGN KEY (child_id)
        REFERENCES children(child_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_appointments_facility
        FOREIGN KEY (facility_id)
        REFERENCES facilities(facility_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;


-- =========================================================
-- 12. Vaccine Batches
-- Tracks batch numbers, expiry dates, and available stock.
-- =========================================================

CREATE TABLE vaccine_batches (
    batch_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    vaccine_id INT NOT NULL,
    facility_id INT NOT NULL,
    batch_number VARCHAR(80) NOT NULL,
    expiry_date DATE NOT NULL,
    quantity_available INT NOT NULL DEFAULT 0,
    received_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_facility_batch
        UNIQUE (facility_id, batch_number),

    CONSTRAINT chk_batch_quantity
        CHECK (quantity_available >= 0),

    CONSTRAINT fk_batches_vaccine
        FOREIGN KEY (vaccine_id)
        REFERENCES vaccines(vaccine_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_batches_facility
        FOREIGN KEY (facility_id)
        REFERENCES facilities(facility_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;


-- =========================================================
-- 13. Vaccination Records
-- Records administered vaccine doses.
-- =========================================================

CREATE TABLE vaccination_records (
    record_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    child_id INT NOT NULL,
    dose_id INT NOT NULL,
    appointment_id BIGINT,
    worker_id INT NOT NULL,
    batch_id BIGINT NOT NULL,
    administered_at DATETIME NOT NULL,
    outcome VARCHAR(40) NOT NULL DEFAULT 'Administered',
    notes VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_vaccination_outcome
        CHECK (outcome IN (
            'Administered',
            'Administration Error'
        )),

    CONSTRAINT fk_vaccination_child
        FOREIGN KEY (child_id)
        REFERENCES children(child_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_vaccination_dose
        FOREIGN KEY (dose_id)
        REFERENCES vaccine_doses(dose_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_vaccination_appointment
        FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT fk_vaccination_worker
        FOREIGN KEY (worker_id)
        REFERENCES health_workers(worker_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_vaccination_batch
        FOREIGN KEY (batch_id)
        REFERENCES vaccine_batches(batch_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;


-- =========================================================
-- 14. Adverse Events
-- Stores reports of possible events after vaccination.
-- A report does not by itself establish causation.
-- =========================================================

CREATE TABLE adverse_events (
    event_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    record_id BIGINT NOT NULL,
    reported_by INT,
    severity VARCHAR(30) NOT NULL,
    description TEXT NOT NULL,
    reported_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) NOT NULL DEFAULT 'Reported',

    CONSTRAINT chk_adverse_severity
        CHECK (severity IN (
            'Mild',
            'Moderate',
            'Severe',
            'Unknown'
        )),

    CONSTRAINT chk_adverse_status
        CHECK (status IN (
            'Reported',
            'Under Review',
            'Closed'
        )),

    CONSTRAINT fk_adverse_record
        FOREIGN KEY (record_id)
        REFERENCES vaccination_records(record_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_adverse_reporter
        FOREIGN KEY (reported_by)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE = InnoDB;


-- =========================================================
-- 15. Stock Movements
-- Records vaccine inventory additions and deductions.
-- Quantity is always stored as a positive number.
-- =========================================================

CREATE TABLE stock_movements (
    movement_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    batch_id BIGINT NOT NULL,
    user_id INT,
    movement_type VARCHAR(30) NOT NULL,
    quantity INT NOT NULL,
    movement_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reference_note VARCHAR(255),

    CONSTRAINT chk_stock_movement_type
        CHECK (movement_type IN (
            'Receipt',
            'Administration',
            'Adjustment',
            'Transfer In',
            'Transfer Out',
            'Expired',
            'Damaged'
        )),

    CONSTRAINT chk_stock_movement_quantity
        CHECK (quantity > 0),

    CONSTRAINT fk_stock_batch
        FOREIGN KEY (batch_id)
        REFERENCES vaccine_batches(batch_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_stock_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE = InnoDB;


-- =========================================================
-- 16. Audit Logs
-- Records important database/application actions.
-- =========================================================

CREATE TABLE audit_logs (
    audit_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(80) NOT NULL,
    entity_name VARCHAR(80) NOT NULL,
    entity_id BIGINT,
    details TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_audit_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE = InnoDB;


-- =========================================================
-- 17. Verify created tables
-- =========================================================

SHOW TABLES;


-- =========================================================
-- 18. Inspect important table definitions
-- =========================================================

SHOW CREATE TABLE children;

SHOW CREATE TABLE child_guardians;

SHOW CREATE TABLE vaccination_records;

SHOW CREATE TABLE vaccine_batches;

SHOW CREATE TABLE stock_movements;


-- =========================================================
-- End of 01_schema.sql
-- =========================================================
