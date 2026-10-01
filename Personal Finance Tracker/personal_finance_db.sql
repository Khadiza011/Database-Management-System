-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2026 at 08:04 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `personal_finance_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_name` varchar(100) NOT NULL,
  `account_type` varchar(30) NOT NULL,
  `balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`account_id`, `user_id`, `account_name`, `account_type`, `balance`, `created_at`) VALUES
(1, 1, 'Cash Wallet', 'CASH', 10000.00, '2026-09-28 15:36:09'),
(2, 1, 'Bank Account', 'BANK', 45000.00, '2026-09-28 15:36:09'),
(3, 1, 'Mobile Banking', 'MOBILE', 20000.00, '2026-09-28 15:36:09'),
(4, 2, 'Personal Bank', 'BANK', 30000.00, '2026-09-28 15:36:09');

-- --------------------------------------------------------

--
-- Table structure for table `budgets`
--

CREATE TABLE `budgets` (
  `budget_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `budget_month` tinyint(4) NOT NULL,
  `budget_year` smallint(6) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `budgets`
--

INSERT INTO `budgets` (`budget_id`, `user_id`, `budget_month`, `budget_year`, `created_at`) VALUES
(1, 1, 7, 2026, '2026-09-28 15:36:31'),
(2, 1, 8, 2026, '2026-09-28 15:36:31'),
(3, 2, 8, 2026, '2026-09-28 15:36:31');

-- --------------------------------------------------------

--
-- Table structure for table `budget_details`
--

CREATE TABLE `budget_details` (
  `budget_detail_id` int(11) NOT NULL,
  `budget_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `allocated_amount` decimal(12,2) NOT NULL
) ;

--
-- Dumping data for table `budget_details`
--

INSERT INTO `budget_details` (`budget_detail_id`, `budget_id`, `category_id`, `allocated_amount`) VALUES
(1, 1, 3, 6000.00),
(2, 1, 4, 3000.00),
(3, 1, 5, 7000.00),
(4, 1, 6, 3000.00),
(5, 2, 3, 7000.00),
(6, 2, 4, 3500.00),
(7, 2, 7, 4000.00),
(8, 3, 9, 6000.00);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `category_type` varchar(10) NOT NULL
) ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `user_id`, `category_name`, `category_type`) VALUES
(5, 1, 'Education', 'EXPENSE'),
(7, 1, 'Entertainment', 'EXPENSE'),
(3, 1, 'Food', 'EXPENSE'),
(2, 1, 'Freelancing', 'INCOME'),
(1, 1, 'Salary', 'INCOME'),
(4, 1, 'Transportation', 'EXPENSE'),
(6, 1, 'Utilities', 'EXPENSE'),
(9, 2, 'Food', 'EXPENSE'),
(8, 2, 'Salary', 'INCOME');

-- --------------------------------------------------------

--
-- Table structure for table `dim_account`
--

CREATE TABLE `dim_account` (
  `account_key` int(11) NOT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `account_type` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dim_account`
--

INSERT INTO `dim_account` (`account_key`, `account_name`, `account_type`) VALUES
(1, 'Cash Wallet', 'CASH'),
(2, 'Bank Account', 'BANK'),
(3, 'Mobile Banking', 'MOBILE'),
(4, 'Personal Bank', 'BANK');

-- --------------------------------------------------------

--
-- Table structure for table `dim_category`
--

CREATE TABLE `dim_category` (
  `category_key` int(11) NOT NULL,
  `category_name` varchar(100) DEFAULT NULL,
  `category_type` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dim_category`
--

INSERT INTO `dim_category` (`category_key`, `category_name`, `category_type`) VALUES
(1, 'Salary', 'INCOME'),
(2, 'Freelancing', 'INCOME'),
(3, 'Food', 'EXPENSE'),
(4, 'Transportation', 'EXPENSE'),
(5, 'Education', 'EXPENSE'),
(6, 'Utilities', 'EXPENSE'),
(7, 'Entertainment', 'EXPENSE'),
(8, 'Salary', 'INCOME'),
(9, 'Food', 'EXPENSE');

-- --------------------------------------------------------

--
-- Table structure for table `dim_date`
--

CREATE TABLE `dim_date` (
  `date_key` int(11) NOT NULL,
  `full_date` date NOT NULL,
  `day_no` int(11) DEFAULT NULL,
  `month_no` int(11) DEFAULT NULL,
  `month_name` varchar(15) DEFAULT NULL,
  `year_no` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dim_date`
--

INSERT INTO `dim_date` (`date_key`, `full_date`, `day_no`, `month_no`, `month_name`, `year_no`) VALUES
(20260701, '2026-07-01', 1, 7, 'July', 2026),
(20260705, '2026-07-05', 5, 7, 'July', 2026),
(20260710, '2026-07-10', 10, 7, 'July', 2026),
(20260715, '2026-07-15', 15, 7, 'July', 2026),
(20260720, '2026-07-20', 20, 7, 'July', 2026),
(20260801, '2026-08-01', 1, 8, 'August', 2026),
(20260803, '2026-08-03', 3, 8, 'August', 2026),
(20260808, '2026-08-08', 8, 8, 'August', 2026),
(20260812, '2026-08-12', 12, 8, 'August', 2026),
(20260815, '2026-08-15', 15, 8, 'August', 2026);

-- --------------------------------------------------------

--
-- Table structure for table `dim_user`
--

CREATE TABLE `dim_user` (
  `user_key` int(11) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dim_user`
--

INSERT INTO `dim_user` (`user_key`, `full_name`) VALUES
(1, 'Khadiza Rehan'),
(2, 'Nusrat Jahan');

-- --------------------------------------------------------

--
-- Table structure for table `fact_transactions`
--

CREATE TABLE `fact_transactions` (
  `transaction_key` int(11) NOT NULL,
  `date_key` int(11) NOT NULL,
  `user_key` int(11) NOT NULL,
  `account_key` int(11) NOT NULL,
  `category_key` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fact_transactions`
--

INSERT INTO `fact_transactions` (`transaction_key`, `date_key`, `user_key`, `account_key`, `category_key`, `amount`) VALUES
(1, 20260701, 1, 2, 1, 50000.00),
(2, 20260705, 1, 2, 3, 4500.00),
(3, 20260710, 1, 1, 4, 2000.00),
(4, 20260715, 1, 2, 5, 6000.00),
(5, 20260720, 1, 3, 6, 2500.00),
(6, 20260803, 1, 2, 2, 12000.00),
(7, 20260808, 1, 1, 3, 5000.00),
(8, 20260815, 1, 3, 7, 3000.00),
(9, 20260801, 2, 4, 8, 40000.00),
(10, 20260812, 2, 4, 9, 4000.00);

-- --------------------------------------------------------

--
-- Table structure for table `mv_monthly_finance_summary`
--

CREATE TABLE `mv_monthly_finance_summary` (
  `user_id` int(11) NOT NULL,
  `year_no` int(11) NOT NULL,
  `month_no` int(11) NOT NULL,
  `total_income` decimal(12,2) DEFAULT NULL,
  `total_expense` decimal(12,2) DEFAULT NULL,
  `savings` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mv_monthly_finance_summary`
--

INSERT INTO `mv_monthly_finance_summary` (`user_id`, `year_no`, `month_no`, `total_income`, `total_expense`, `savings`) VALUES
(1, 2026, 7, 50000.00, 15000.00, 35000.00),
(1, 2026, 8, 12000.00, 8000.00, 4000.00),
(2, 2026, 8, 40000.00, 4000.00, 36000.00);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `transaction_date` date NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `account_id`, `category_id`, `amount`, `transaction_date`, `description`) VALUES
(1, 2, 1, 50000.00, '2026-07-01', 'Monthly salary'),
(2, 2, 3, 4500.00, '2026-07-05', 'Groceries'),
(3, 1, 4, 2000.00, '2026-07-10', 'Transportation'),
(4, 2, 5, 6000.00, '2026-07-15', 'Course fee'),
(5, 3, 6, 2500.00, '2026-07-20', 'Internet and utilities'),
(6, 2, 2, 12000.00, '2026-08-03', 'Freelance project'),
(7, 1, 3, 5000.00, '2026-08-08', 'Food expenses'),
(8, 3, 7, 3000.00, '2026-08-15', 'Entertainment'),
(9, 4, 8, 40000.00, '2026-08-01', 'Monthly salary'),
(10, 4, 9, 4000.00, '2026-08-12', 'Groceries');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_history`
--

CREATE TABLE `transaction_history` (
  `transaction_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `transaction_date` date NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
PARTITION BY RANGE (year(`transaction_date`))
(
PARTITION p2025 VALUES LESS THAN (2026) ENGINE=InnoDB,
PARTITION p2026 VALUES LESS THAN (2027) ENGINE=InnoDB,
PARTITION p2027 VALUES LESS THAN (2028) ENGINE=InnoDB,
PARTITION p_future VALUES LESS THAN MAXVALUE ENGINE=InnoDB
);

--
-- Dumping data for table `transaction_history`
--

INSERT INTO `transaction_history` (`transaction_id`, `account_id`, `category_id`, `amount`, `transaction_date`, `description`) VALUES
(1, 2, 1, 50000.00, '2026-07-01', 'Monthly salary'),
(2, 2, 3, 4500.00, '2026-07-05', 'Groceries'),
(3, 1, 4, 2000.00, '2026-07-10', 'Transportation'),
(4, 2, 5, 6000.00, '2026-07-15', 'Course fee'),
(5, 3, 6, 2500.00, '2026-07-20', 'Internet and utilities'),
(6, 2, 2, 12000.00, '2026-08-03', 'Freelance project'),
(7, 1, 3, 5000.00, '2026-08-08', 'Food expenses'),
(8, 3, 7, 3000.00, '2026-08-15', 'Entertainment'),
(9, 4, 8, 40000.00, '2026-08-01', 'Monthly salary'),
(10, 4, 9, 4000.00, '2026-08-12', 'Groceries');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `transfer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `source_account_id` int(11) NOT NULL,
  `destination_account_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `transfer_date` date NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ;

--
-- Dumping data for table `transfers`
--

INSERT INTO `transfers` (`transfer_id`, `user_id`, `source_account_id`, `destination_account_id`, `amount`, `transfer_date`, `description`) VALUES
(1, 1, 2, 3, 5000.00, '2026-08-05', 'Transfer from bank to mobile banking'),
(2, 1, 2, 3, 5000.00, '2026-08-20', 'Bank to mobile transfer');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `created_at`) VALUES
(1, 'Khadiza Rehan', 'khadiza@example.com', 'pass123', '2026-09-28 15:35:57'),
(2, 'Nusrat Jahan', 'nusrat@example.com', 'pass456', '2026-09-28 15:35:57');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_transaction_details`
-- (See below for the actual view)
--
CREATE TABLE `vw_transaction_details` (
`transaction_id` int(11)
,`full_name` varchar(100)
,`account_name` varchar(100)
,`category_name` varchar(100)
,`category_type` varchar(10)
,`amount` decimal(12,2)
,`transaction_date` date
);

-- --------------------------------------------------------

--
-- Structure for view `vw_transaction_details`
--
DROP TABLE IF EXISTS `vw_transaction_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_transaction_details`  AS SELECT `t`.`transaction_id` AS `transaction_id`, `u`.`full_name` AS `full_name`, `a`.`account_name` AS `account_name`, `c`.`category_name` AS `category_name`, `c`.`category_type` AS `category_type`, `t`.`amount` AS `amount`, `t`.`transaction_date` AS `transaction_date` FROM (((`transactions` `t` join `accounts` `a` on(`t`.`account_id` = `a`.`account_id`)) join `users` `u` on(`a`.`user_id` = `u`.`user_id`)) join `categories` `c` on(`t`.`category_id` = `c`.`category_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`account_id`),
  ADD UNIQUE KEY `uq_user_account` (`user_id`,`account_name`);

--
-- Indexes for table `budgets`
--
ALTER TABLE `budgets`
  ADD PRIMARY KEY (`budget_id`),
  ADD UNIQUE KEY `uq_user_budget_period` (`user_id`,`budget_month`,`budget_year`);

--
-- Indexes for table `budget_details`
--
ALTER TABLE `budget_details`
  ADD PRIMARY KEY (`budget_detail_id`),
  ADD UNIQUE KEY `uq_budget_category` (`budget_id`,`category_id`),
  ADD KEY `fk_budget_details_category` (`category_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `uq_user_category` (`user_id`,`category_name`,`category_type`);

--
-- Indexes for table `dim_account`
--
ALTER TABLE `dim_account`
  ADD PRIMARY KEY (`account_key`);

--
-- Indexes for table `dim_category`
--
ALTER TABLE `dim_category`
  ADD PRIMARY KEY (`category_key`);

--
-- Indexes for table `dim_date`
--
ALTER TABLE `dim_date`
  ADD PRIMARY KEY (`date_key`),
  ADD UNIQUE KEY `full_date` (`full_date`);

--
-- Indexes for table `dim_user`
--
ALTER TABLE `dim_user`
  ADD PRIMARY KEY (`user_key`);

--
-- Indexes for table `fact_transactions`
--
ALTER TABLE `fact_transactions`
  ADD PRIMARY KEY (`transaction_key`),
  ADD KEY `date_key` (`date_key`),
  ADD KEY `user_key` (`user_key`),
  ADD KEY `account_key` (`account_key`),
  ADD KEY `category_key` (`category_key`);

--
-- Indexes for table `mv_monthly_finance_summary`
--
ALTER TABLE `mv_monthly_finance_summary`
  ADD PRIMARY KEY (`user_id`,`year_no`,`month_no`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `fk_transactions_category` (`category_id`),
  ADD KEY `idx_account_date` (`account_id`,`transaction_date`);

--
-- Indexes for table `transaction_history`
--
ALTER TABLE `transaction_history`
  ADD PRIMARY KEY (`transaction_id`,`transaction_date`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`transfer_id`),
  ADD KEY `fk_transfers_user` (`user_id`),
  ADD KEY `fk_transfer_source` (`source_account_id`),
  ADD KEY `fk_transfer_destination` (`destination_account_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budgets`
--
ALTER TABLE `budgets`
  MODIFY `budget_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budget_details`
--
ALTER TABLE `budget_details`
  MODIFY `budget_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `transfer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `fk_accounts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `budgets`
--
ALTER TABLE `budgets`
  ADD CONSTRAINT `fk_budgets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `budget_details`
--
ALTER TABLE `budget_details`
  ADD CONSTRAINT `fk_budget_details_budget` FOREIGN KEY (`budget_id`) REFERENCES `budgets` (`budget_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_budget_details_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_categories_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `fact_transactions`
--
ALTER TABLE `fact_transactions`
  ADD CONSTRAINT `fact_transactions_ibfk_1` FOREIGN KEY (`date_key`) REFERENCES `dim_date` (`date_key`),
  ADD CONSTRAINT `fact_transactions_ibfk_2` FOREIGN KEY (`user_key`) REFERENCES `dim_user` (`user_key`),
  ADD CONSTRAINT `fact_transactions_ibfk_3` FOREIGN KEY (`account_key`) REFERENCES `dim_account` (`account_key`),
  ADD CONSTRAINT `fact_transactions_ibfk_4` FOREIGN KEY (`category_key`) REFERENCES `dim_category` (`category_key`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transactions_account` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`),
  ADD CONSTRAINT `fk_transactions_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `transfers`
--
ALTER TABLE `transfers`
  ADD CONSTRAINT `fk_transfer_destination` FOREIGN KEY (`destination_account_id`) REFERENCES `accounts` (`account_id`),
  ADD CONSTRAINT `fk_transfer_source` FOREIGN KEY (`source_account_id`) REFERENCES `accounts` (`account_id`),
  ADD CONSTRAINT `fk_transfers_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
