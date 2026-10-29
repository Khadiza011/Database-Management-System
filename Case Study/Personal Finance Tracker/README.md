# Personal Income, Budget and Expense Tracking System

## Overview

This case study presents a complete database solution for managing personal income, expenses, budgets, accounts, transfers, and financial reporting.

The system demonstrates both **transactional database design** and **analytical database concepts**, including relational schema design, constraints, indexing, partitioning, star schema modeling, views, and summarized BI reporting.

## Objectives

The database is designed to:

- Manage multiple users and financial accounts
- Record income and expense transactions
- Organize transactions using categories
- Create monthly budgets for different expense categories
- Track transfers between accounts
- Maintain structured and consistent financial data
- Support analytical and BI-oriented financial reporting

## Core Database Structure

The operational database contains the following main entities:

- `users` — stores user information
- `accounts` — stores cash, bank, and mobile banking accounts
- `categories` — defines income and expense categories
- `transactions` — records financial transactions
- `budgets` — stores monthly budget information
- `budget_details` — stores category-wise budget allocations
- `transfers` — records transfers between accounts
- `transaction_history` — maintains partitioned historical transaction data

## Database Concepts Demonstrated

### 1. Relational Data Modeling

Relationships between users, accounts, categories, transactions, budgets, and transfers are implemented using primary and foreign keys.

### 2. Constraints

The schema uses:

- Primary Keys
- Foreign Keys
- Unique Constraints
- NOT NULL constraints
- Composite unique keys

These constraints help maintain data integrity and prevent duplicate or invalid records.

### 3. Indexing

Indexes are used on frequently searched and joined columns. A composite index on account and transaction date improves account-based transaction queries.

### 4. Partitioning

`transaction_history` uses **RANGE partitioning by year**, allowing historical financial records to be logically separated into yearly partitions.

### 5. Star Schema

A separate analytical model is implemented using:

**Fact Table**
- `fact_transactions`

**Dimension Tables**
- `dim_user`
- `dim_account`
- `dim_category`
- `dim_date`

This structure supports BI and analytical queries efficiently.

### 6. Views and Joins

`vw_transaction_details` combines transaction, user, account, and category information using multiple JOIN operations to provide a simplified reporting interface.

### 7. Materialized Summary

Since MariaDB does not provide native materialized views, `mv_monthly_finance_summary` is implemented as a physical summary table that stores precomputed monthly:

- Total Income
- Total Expense
- Savings

This demonstrates the materialized-view concept for faster BI reporting.

### 8. Transaction Management

Transaction control is demonstrated using `START TRANSACTION` and `COMMIT`, providing the foundation for atomic database operations.

## BI Reporting

The database can support reports such as:

- Monthly income and expenses
- Monthly savings
- Category-wise expenses
- Account-wise transactions
- User financial summaries
- Budget versus expense analysis

## Technologies

- MariaDB / MySQL
- SQL
- phpMyAdmin
- Relational Database Modeling
- Star Schema / Data Warehousing Concepts

## Files

`personal_finance_db.sql` contains the complete database schema, sample data, constraints, indexes, partitions, analytical schema, view, and reporting structures.

## Conclusion

This case study demonstrates how a personal finance system can be designed using both **OLTP and analytical database concepts**. It combines structured transaction management with star-schema-based reporting to provide a practical example of database design, optimization, and business intelligence.
