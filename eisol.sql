-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 10, 2017 at 11:45 AM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eisol`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `org_id` bigint(11) DEFAULT '0',
  `account_name` varchar(255) DEFAULT NULL,
  `first_amount` decimal(11,2) DEFAULT '0.00',
  `current_amount` decimal(11,2) DEFAULT '0.00',
  `is_cashier` int(1) DEFAULT '0',
  `is_card` int(1) DEFAULT '0',
  `is_swipe` int(2) DEFAULT '0',
  `bank_fee` float(7,4) DEFAULT '0.0000',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` int(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `account`
--
DELIMITER $$
CREATE TRIGGER `trigger_account_delete` BEFORE DELETE ON `account` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'account', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_account_insert` AFTER INSERT ON `account` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'account', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_account_insert_id` BEFORE INSERT ON `account` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM account WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_account_update` BEFORE UPDATE ON `account` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'account', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `account_transaction`
--

CREATE TABLE `account_transaction` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `from` bigint(20) DEFAULT '0',
  `to` bigint(20) DEFAULT '0',
  `amount` decimal(11,2) DEFAULT '0.00',
  `employee_id` bigint(20) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Triggers `account_transaction`
--
DELIMITER $$
CREATE TRIGGER `trigger_account_transaction_delete` BEFORE DELETE ON `account_transaction` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'account_transaction', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_account_transaction_insert` AFTER INSERT ON `account_transaction` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'account_transaction', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_account_transaction_insert_id` BEFORE INSERT ON `account_transaction` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM account_transaction WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_account_transaction_update` BEFORE UPDATE ON `account_transaction` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'account_transaction', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `addons`
--

CREATE TABLE `addons` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT '0.00',
  `image` varchar(255) DEFAULT NULL,
  `type` tinyint(4) DEFAULT '0' COMMENT '0 = Modifier, 1 = Option, 2= Side dish',
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `sector_type` tinyint(1) DEFAULT '0' COMMENT '0 = kitchen, 1 = bar',
  `description` varchar(255) DEFAULT NULL,
  `ortog` decimal(11,2) DEFAULT '0.00',
  `is_takeaway` tinyint(1) DEFAULT '0',
  `is_category` tinyint(1) DEFAULT '0',
  `color_hex` varchar(255) DEFAULT NULL,
  `label_letter` varchar(255) DEFAULT NULL,
  `addon_cat_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `addons`
--
DELIMITER $$
CREATE TRIGGER `trigger_addons_delete` BEFORE DELETE ON `addons` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'addons', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_addons_insert` AFTER INSERT ON `addons` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'addons', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_addons_insert_id` BEFORE INSERT ON `addons` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM addons WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_addons_update` BEFORE UPDATE ON `addons` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'addons', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `addon_category`
--

CREATE TABLE `addon_category` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `sector_type` tinyint(4) DEFAULT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `priority_index` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `addon_category`
--
DELIMITER $$
CREATE TRIGGER `trigger_addon_category_delete` BEFORE DELETE ON `addon_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'addon_category', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_addon_category_insert` AFTER INSERT ON `addon_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'addon_category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_addon_category_insert_id` BEFORE INSERT ON `addon_category` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM addon_category WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_addon_category_update` BEFORE UPDATE ON `addon_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'addon_category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `addon_to_category`
--

CREATE TABLE `addon_to_category` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `addon_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `addon_to_category`
--
DELIMITER $$
CREATE TRIGGER `trigger_addon_to_category_delete` BEFORE DELETE ON `addon_to_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'addon_to_category', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_addon_to_category_insert` AFTER INSERT ON `addon_to_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'addon_to_category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_addon_to_category_insert_id` BEFORE INSERT ON `addon_to_category` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM addon_to_category WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_addon_to_category_update` BEFORE UPDATE ON `addon_to_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'addon_to_category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `receipt_number` varchar(255) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT '0',
  `m_org_id` bigint(20) DEFAULT '0',
  `on_account` decimal(11,0) DEFAULT '0',
  `change` decimal(11,2) DEFAULT '0.00',
  `tax` decimal(11,2) DEFAULT '0.00',
  `service_charge` decimal(11,2) DEFAULT '0.00',
  `is_paid` bigint(20) DEFAULT '0',
  `discount` bigint(20) DEFAULT '0' COMMENT 'хувиар хөнгөлөх',
  `discount_by_amount` decimal(11,2) DEFAULT '0.00' COMMENT 'мөнгөн дүнгээр хөнгөлөх',
  `member_id` bigint(20) DEFAULT '0',
  `is_payment_done` int(32) DEFAULT '0' COMMENT 'зөвхөн тухайн биллийн тооцоог дуусгах',
  `tax_inside` int(2) DEFAULT '0',
  `foc` decimal(11,2) DEFAULT '0.00',
  `foc_id` bigint(20) DEFAULT '0',
  `reservation_id` bigint(20) DEFAULT '0',
  `reservation_amount` decimal(11,2) DEFAULT '0.00',
  `deposit_id` int(11) NOT NULL DEFAULT '0',
  `deposit_amount` decimal(11,2) DEFAULT '0.00',
  `corp_disc_id` bigint(20) DEFAULT '0',
  `corp_disc_name` varchar(255) DEFAULT NULL,
  `is_cancelled` tinyint(4) DEFAULT '0',
  `is_deleted` tinyint(1) DEFAULT '0',
  `manager_id` bigint(20) DEFAULT NULL,
  `disc_amount` decimal(11,2) DEFAULT '0.00',
  `voucher` decimal(11,2) DEFAULT '0.00',
  `rounding` decimal(2,2) DEFAULT '0.00',
  `description` varchar(100) DEFAULT NULL,
  `membership_amount` decimal(11,2) DEFAULT '0.00',
  `tips` decimal(11,2) DEFAULT '0.00',
  `is_recovery_discount` tinyint(4) DEFAULT '0',
  `recovery_disc_reason` varchar(100) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Triggers `bill`
--
DELIMITER $$
CREATE TRIGGER `trigger_bill_delete` BEFORE DELETE ON `bill` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'bill', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_bill_insert` AFTER INSERT ON `bill` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'bill', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_bill_insert_id` BEFORE INSERT ON `bill` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM bill WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_bill_update` BEFORE UPDATE ON `bill` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'bill', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bill_paidback`
--

CREATE TABLE `bill_paidback` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `bill_id` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `account_id` bigint(20) DEFAULT '0',
  `amount` decimal(11,2) DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Triggers `bill_paidback`
--
DELIMITER $$
CREATE TRIGGER `trigger_bill_paidback_delete` BEFORE DELETE ON `bill_paidback` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'bill_paidback', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_bill_paidback_insert` AFTER INSERT ON `bill_paidback` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'bill_paidback', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_bill_paidback_insert_id` BEFORE INSERT ON `bill_paidback` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM bill_paidback WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_bill_paidback_update` BEFORE UPDATE ON `bill_paidback` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'bill_paidback', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bill_to_account`
--

CREATE TABLE `bill_to_account` (
  `id` bigint(20) NOT NULL,
  `bill_id` bigint(20) DEFAULT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `bill_to_account`
--
DELIMITER $$
CREATE TRIGGER `trigger_bill_to_account_delete` BEFORE DELETE ON `bill_to_account` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'bill_to_account', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_bill_to_account_insert` AFTER INSERT ON `bill_to_account` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'bill_to_account', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_bill_to_account_insert_id` BEFORE INSERT ON `bill_to_account` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM bill_to_account WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_bill_to_account_update` BEFORE UPDATE ON `bill_to_account` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'bill_to_account', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

CREATE TABLE `brand` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` bigint(20) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `brand`
--
DELIMITER $$
CREATE TRIGGER `trigger_brand_delete` BEFORE DELETE ON `brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'brand', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_brand_insert` AFTER INSERT ON `brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_brand_insert_id` BEFORE INSERT ON `brand` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM brand WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_brand_update` BEFORE UPDATE ON `brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cash_in_out`
--

CREATE TABLE `cash_in_out` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `cash_in_out_type_id` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `is_cash_out` bigint(20) DEFAULT '0',
  `employee_id` bigint(20) DEFAULT '0',
  `cash` bigint(20) DEFAULT '0',
  `card` bigint(20) DEFAULT '0',
  `description` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `paid_date` date DEFAULT NULL,
  `cash_id` bigint(20) DEFAULT NULL,
  `card_id` varchar(120) DEFAULT NULL,
  `in_receiver_id` bigint(20) DEFAULT '0',
  `in_from_name` varchar(50) DEFAULT NULL,
  `receiver_name` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `cash_in_out`
--
DELIMITER $$
CREATE TRIGGER `trigger_cash_in_out_delete` BEFORE DELETE ON `cash_in_out` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'cash_in_out', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_cash_in_out_insert` AFTER INSERT ON `cash_in_out` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'cash_in_out', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_cash_in_out_insert_id` BEFORE INSERT ON `cash_in_out` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM cash_in_out WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_cash_in_out_update` BEFORE UPDATE ON `cash_in_out` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'cash_in_out', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cash_in_out_type`
--

CREATE TABLE `cash_in_out_type` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT '0',
  `is_deleted` bigint(20) DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `cash_in_out_type`
--
DELIMITER $$
CREATE TRIGGER `trigger_cash_in_out_type_delete` BEFORE DELETE ON `cash_in_out_type` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'cash_in_out_type', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_cash_in_out_type_insert` AFTER INSERT ON `cash_in_out_type` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'cash_in_out_type', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_cash_in_out_type_insert_id` BEFORE INSERT ON `cash_in_out_type` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM cash_in_out_type WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_cash_in_out_type_update` BEFORE UPDATE ON `cash_in_out_type` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'cash_in_out_type', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` int(1) DEFAULT '1',
  `priority_index` bigint(20) DEFAULT '1',
  `is_set` tinyint(1) DEFAULT '0',
  `set_price` decimal(11,2) DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `category`
--
DELIMITER $$
CREATE TRIGGER `trigger_category_delete` BEFORE DELETE ON `category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'category', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_insert` AFTER INSERT ON `category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_insert_id` BEFORE INSERT ON `category` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM category WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_update` BEFORE UPDATE ON `category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category_to_brand`
--

CREATE TABLE `category_to_brand` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `category_id` bigint(20) DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `category_to_brand`
--
DELIMITER $$
CREATE TRIGGER `trigger_category_to_brand_delete` BEFORE DELETE ON `category_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'category_to_brand', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_to_brand_insert` AFTER INSERT ON `category_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'category_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_to_brand_insert_id` BEFORE INSERT ON `category_to_brand` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM category_to_brand WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_to_brand_update` BEFORE UPDATE ON `category_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'category_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category_to_org`
--

CREATE TABLE `category_to_org` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `category_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `category_to_org`
--
DELIMITER $$
CREATE TRIGGER `trigger_category_to_org_delete` BEFORE DELETE ON `category_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'category_to_org', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_to_org_insert` AFTER INSERT ON `category_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'category_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_to_org_insert_id` BEFORE INSERT ON `category_to_org` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM category_to_org WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_to_org_update` BEFORE UPDATE ON `category_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'category_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category_to_sector`
--

CREATE TABLE `category_to_sector` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `category_id` bigint(20) DEFAULT NULL,
  `sector_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `category_to_sector`
--
DELIMITER $$
CREATE TRIGGER `trigger_category_to_sector_delete` BEFORE DELETE ON `category_to_sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'category_to_sector', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_to_sector_insert` AFTER INSERT ON `category_to_sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'category_to_sector', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_to_sector_insert_id` BEFORE INSERT ON `category_to_sector` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM category_to_sector WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_category_to_sector_update` BEFORE UPDATE ON `category_to_sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'category_to_sector', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE `ci_sessions` (
  `id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `ip_address` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timestamp` int(10) UNSIGNED DEFAULT '0',
  `data` blob
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `communication`
--

CREATE TABLE `communication` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `message` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `org_id` bigint(20) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `communication`
--
DELIMITER $$
CREATE TRIGGER `trigger_communication_delete` BEFORE DELETE ON `communication` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'communication', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_communication_insert` AFTER INSERT ON `communication` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'communication', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_communication_insert_id` BEFORE INSERT ON `communication` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM communication WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_communication_update` BEFORE UPDATE ON `communication` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'communication', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `control_users`
--

CREATE TABLE `control_users` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `firstname` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `control_users`
--
DELIMITER $$
CREATE TRIGGER `trigger_control_users_delete` BEFORE DELETE ON `control_users` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'control_users', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_control_users_insert` AFTER INSERT ON `control_users` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'control_users', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_control_users_insert_id` BEFORE INSERT ON `control_users` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM control_users WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_control_users_update` BEFORE UPDATE ON `control_users` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'control_users', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `corporate_discounts`
--

CREATE TABLE `corporate_discounts` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `percent` tinyint(4) DEFAULT '0',
  `amount` decimal(11,2) DEFAULT '0.00',
  `information` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `org_id` bigint(20) DEFAULT NULL,
  `start` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `end` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `corporate_discounts`
--
DELIMITER $$
CREATE TRIGGER `trigger_corporate_discounts_delete` BEFORE DELETE ON `corporate_discounts` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'corporate_discounts', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_corporate_discounts_insert` AFTER INSERT ON `corporate_discounts` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'corporate_discounts', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_corporate_discounts_insert_id` BEFORE INSERT ON `corporate_discounts` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM corporate_discounts WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_corporate_discounts_update` BEFORE UPDATE ON `corporate_discounts` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'corporate_discounts', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `deposit`
--

CREATE TABLE `deposit` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `member_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT '0.00',
  `account_id` bigint(20) DEFAULT '0',
  `is_active` int(1) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL,
  `expiring_date` date DEFAULT NULL,
  `void_description` varchar(250) DEFAULT NULL,
  `inactive_type` tinyint(4) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `deposit`
--
DELIMITER $$
CREATE TRIGGER `trigger_deposit_delete` BEFORE DELETE ON `deposit` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'deposit', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_deposit_insert` AFTER INSERT ON `deposit` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'deposit', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_deposit_insert_id` BEFORE INSERT ON `deposit` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM deposit WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_deposit_update` BEFORE UPDATE ON `deposit` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'deposit', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `deposit_payments`
--

CREATE TABLE `deposit_payments` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `deposit_id` bigint(20) DEFAULT '0',
  `amount` decimal(11,2) DEFAULT '0.00',
  `date` date DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `org_id` bigint(20) DEFAULT '0',
  `payment_method` bigint(20) DEFAULT '0',
  `shift_id` bigint(20) DEFAULT '0',
  `account_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `deposit_payments`
--
DELIMITER $$
CREATE TRIGGER `trigger_deposit_payments_delete` BEFORE DELETE ON `deposit_payments` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'deposit_payments', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_deposit_payments_insert` AFTER INSERT ON `deposit_payments` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'deposit_payments', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_deposit_payments_insert_id` BEFORE INSERT ON `deposit_payments` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM deposit_payments WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_deposit_payments_update` BEFORE UPDATE ON `deposit_payments` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'deposit_payments', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `diagnostic`
--

CREATE TABLE `diagnostic` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `device_name` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0-offline, 1-online',
  `status_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `device_type` tinyint(4) DEFAULT NULL COMMENT '0-ipad,1 - printer',
  `device_ip` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `org_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `diagnostic`
--
DELIMITER $$
CREATE TRIGGER `trigger_diagnostic_delete` BEFORE DELETE ON `diagnostic` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'diagnostic', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_diagnostic_insert` AFTER INSERT ON `diagnostic` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'diagnostic', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_diagnostic_insert_id` BEFORE INSERT ON `diagnostic` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM diagnostic WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_diagnostic_update` BEFORE UPDATE ON `diagnostic` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'diagnostic', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `discount_type` bigint(20) DEFAULT NULL,
  `duration_type` bigint(20) DEFAULT NULL,
  `percent` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `information` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `end` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sector_id` bigint(20) DEFAULT NULL,
  `cat_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `is_all_day` bigint(20) DEFAULT NULL,
  `is_active` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `discounts`
--
DELIMITER $$
CREATE TRIGGER `trigger_discounts_delete` BEFORE DELETE ON `discounts` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'discounts', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discounts_insert` AFTER INSERT ON `discounts` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'discounts', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discounts_insert_id` BEFORE INSERT ON `discounts` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM discounts WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discounts_update` BEFORE UPDATE ON `discounts` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'discounts', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `discount_time`
--

CREATE TABLE `discount_time` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `discount_id` bigint(20) DEFAULT NULL,
  `start` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `end` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `discount_time`
--
DELIMITER $$
CREATE TRIGGER `trigger_discount_time_delete` BEFORE DELETE ON `discount_time` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'discount_time', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_time_insert` AFTER INSERT ON `discount_time` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'discount_time', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_time_insert_id` BEFORE INSERT ON `discount_time` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM discount_time WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_time_update` BEFORE UPDATE ON `discount_time` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'discount_time', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `discount_to_brand`
--

CREATE TABLE `discount_to_brand` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `discount_id` bigint(20) NOT NULL DEFAULT '0',
  `brand_id` bigint(20) NOT NULL DEFAULT '0',
  `percent` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `discount_to_brand`
--
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_brand_delete` BEFORE DELETE ON `discount_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'discount_to_brand', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_brand_insert` AFTER INSERT ON `discount_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'discount_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_brand_insert_id` BEFORE INSERT ON `discount_to_brand` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM discount_to_brand WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_brand_update` BEFORE UPDATE ON `discount_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'discount_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `discount_to_org`
--

CREATE TABLE `discount_to_org` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `discount_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `percent` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `discount_to_org`
--
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_org_delete` BEFORE DELETE ON `discount_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'discount_to_org', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_org_insert` AFTER INSERT ON `discount_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'discount_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_org_insert_id` BEFORE INSERT ON `discount_to_org` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM discount_to_org WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_org_update` BEFORE UPDATE ON `discount_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'discount_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `discount_to_product`
--

CREATE TABLE `discount_to_product` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `discount_id` bigint(20) DEFAULT '0',
  `sector_id` bigint(20) DEFAULT '0',
  `cat_id` bigint(20) DEFAULT '0',
  `pro_id` int(20) DEFAULT '0',
  `percent` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `by_object` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `discount_to_product`
--
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_product_delete` BEFORE DELETE ON `discount_to_product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'discount_to_product', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_product_insert` AFTER INSERT ON `discount_to_product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'discount_to_product', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_product_insert_id` BEFORE INSERT ON `discount_to_product` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM discount_to_product WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_discount_to_product_update` BEFORE UPDATE ON `discount_to_product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'discount_to_product', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `group_id` bigint(20) DEFAULT '0',
  `user_service_id` bigint(20) DEFAULT '0',
  `is_demo` int(2) DEFAULT '0',
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `is_active` bigint(20) DEFAULT '1',
  `register` varchar(255) DEFAULT NULL,
  `passport` varchar(255) DEFAULT NULL,
  `pass_image` varchar(255) DEFAULT NULL,
  `ndn` varchar(255) DEFAULT NULL,
  `emd` varchar(255) DEFAULT NULL,
  `phone` text,
  `mobile` text,
  `address` longtext,
  `info` longtext,
  `email_verification_code` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NULL DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `login_id` varchar(100) DEFAULT NULL,
  `reopen_bill` tinyint(4) DEFAULT '0',
  `allow_avoid` tinyint(4) DEFAULT '0',
  `waiter_settle_bill` tinyint(4) DEFAULT '0',
  `edit_option` tinyint(4) DEFAULT '0',
  `edit_setMenu` tinyint(4) DEFAULT '0',
  `edit_menu_price` tinyint(1) DEFAULT '0',
  `allow_recovery_discount` tinyint(1) DEFAULT '0',
  `allow_standard_discount` tinyint(1) DEFAULT '0',
  `allow_promotional_discount` tinyint(1) DEFAULT '0',
  `allow_in_house_voucher_discount` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `employee`
--
DELIMITER $$
CREATE TRIGGER `trigger_employee_delete` BEFORE DELETE ON `employee` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'employee', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_employee_insert` AFTER INSERT ON `employee` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'employee', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_employee_insert_id` BEFORE INSERT ON `employee` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM employee WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_employee_update` BEFORE UPDATE ON `employee` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'employee', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_sessions`
--

CREATE TABLE `employee_sessions` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `employee_id` bigint(20) DEFAULT '0',
  `group_id` bigint(20) DEFAULT '0',
  `sector_id` varchar(255) DEFAULT '0',
  `access_token` varchar(255) DEFAULT NULL,
  `access_token_expires` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `employee_to_sector`
--

CREATE TABLE `employee_to_sector` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `employee_id` bigint(20) DEFAULT NULL,
  `sector_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `employee_to_sector`
--
DELIMITER $$
CREATE TRIGGER `trigger_employee_to_sector_delete` BEFORE DELETE ON `employee_to_sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'employee_to_sector', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_employee_to_sector_insert` AFTER INSERT ON `employee_to_sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'employee_to_sector', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_employee_to_sector_insert_id` BEFORE INSERT ON `employee_to_sector` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM employee_to_sector WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_employee_to_sector_update` BEFORE UPDATE ON `employee_to_sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'employee_to_sector', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hall`
--

CREATE TABLE `hall` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) DEFAULT 'Танхим',
  `org_id` bigint(20) DEFAULT '0',
  `image_name` text,
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `hall`
--
DELIMITER $$
CREATE TRIGGER `trigger_hall_delete` BEFORE DELETE ON `hall` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'hall', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_hall_insert` AFTER INSERT ON `hall` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'hall', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_hall_insert_id` BEFORE INSERT ON `hall` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM hall WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_hall_update` BEFORE UPDATE ON `hall` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'hall', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hq_user`
--

CREATE TABLE `hq_user` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `fullname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` bigint(20) DEFAULT NULL,
  `is_deleted` bigint(20) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `hq_user`
--

INSERT INTO `hq_user` (`id`, `hqCreated`, `group_id`, `fullname`, `email`, `phone`, `username`, `password`, `salt`, `is_active`, `is_deleted`, `created`) VALUES
(1, 0, 0, 'Tunglok', 'Tunglok@tunglok.com', '99999999', 'Tunglok', 'edc50f2e943c244679b93dbb33b965a10d16f361', '216e714b6e0aad49c5c4e4c95d2386f0', 1, 0, '2017-06-22 22:29:11');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `is_unique` bigint(20) DEFAULT '1',
  `major_unit_id` bigint(20) DEFAULT '0',
  `minor_unit_id` bigint(20) DEFAULT '1',
  `org_id` bigint(20) DEFAULT '0',
  `category_id` bigint(20) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` int(2) DEFAULT '1',
  `factor` bigint(20) DEFAULT '1000',
  `factor1` bigint(20) DEFAULT '0',
  `factor2` bigint(20) DEFAULT '0',
  `ortog` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `item`
--
DELIMITER $$
CREATE TRIGGER `trigger_item_delete` BEFORE DELETE ON `item` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'item', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_insert` AFTER INSERT ON `item` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'item', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_insert_id` BEFORE INSERT ON `item` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM item WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_update` BEFORE UPDATE ON `item` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'item', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item_category`
--

CREATE TABLE `item_category` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `name` varchar(255) DEFAULT '0',
  `type` int(1) DEFAULT '1' COMMENT '1=“Ø–Ω–¥—Å—ç–Ω, 2=–Ω—ç–º—ç–ª—Ç, 3=—É—É—Ö',
  `is_active` int(2) DEFAULT '1',
  `img_name` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `item_category`
--
DELIMITER $$
CREATE TRIGGER `trigger_item_category_delete` BEFORE DELETE ON `item_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'item_category', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_category_insert` AFTER INSERT ON `item_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'item_category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_category_insert_id` BEFORE INSERT ON `item_category` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM item_category WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_category_update` BEFORE UPDATE ON `item_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'item_category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item_order`
--

CREATE TABLE `item_order` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `employee_id` bigint(20) DEFAULT '0',
  `employee_name` varchar(255) DEFAULT NULL,
  `is_paid` bigint(20) DEFAULT '0',
  `supplier_id` bigint(20) DEFAULT '0',
  `cash_id` bigint(20) DEFAULT '0',
  `card_id` bigint(20) DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `receiver_name` varchar(255) DEFAULT NULL,
  `has_tax` int(2) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `item_order`
--
DELIMITER $$
CREATE TRIGGER `trigger_item_order_delete` BEFORE DELETE ON `item_order` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'item_order', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_order_insert` AFTER INSERT ON `item_order` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'item_order', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_order_insert_id` BEFORE INSERT ON `item_order` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM item_order WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_order_update` BEFORE UPDATE ON `item_order` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'item_order', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item_order_items`
--

CREATE TABLE `item_order_items` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `item_order_id` bigint(20) DEFAULT '0',
  `item_id` bigint(20) DEFAULT '0',
  `unit_price` bigint(20) DEFAULT '0',
  `quantity` varchar(255) DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `has_tax` int(2) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `item_order_items`
--
DELIMITER $$
CREATE TRIGGER `trigger_item_order_items_delete` BEFORE DELETE ON `item_order_items` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'item_order_items', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_order_items_insert` AFTER INSERT ON `item_order_items` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'item_order_items', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_order_items_insert_id` BEFORE INSERT ON `item_order_items` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM item_order_items WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_order_items_update` BEFORE UPDATE ON `item_order_items` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'item_order_items', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item_order_payment`
--

CREATE TABLE `item_order_payment` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `item_order_id` bigint(20) DEFAULT '0',
  `cash_id` bigint(20) DEFAULT '0',
  `card_id` bigint(20) DEFAULT '0',
  `cash` bigint(20) DEFAULT '0',
  `card` bigint(20) DEFAULT '0',
  `pay_later` decimal(11,0) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Triggers `item_order_payment`
--
DELIMITER $$
CREATE TRIGGER `trigger_item_order_payment_delete` BEFORE DELETE ON `item_order_payment` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'item_order_payment', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_order_payment_insert` AFTER INSERT ON `item_order_payment` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'item_order_payment', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_order_payment_insert_id` BEFORE INSERT ON `item_order_payment` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM item_order_payment WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_order_payment_update` BEFORE UPDATE ON `item_order_payment` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'item_order_payment', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item_to_item`
--

CREATE TABLE `item_to_item` (
  `sub_item_id` bigint(20) DEFAULT NULL,
  `abrasion` decimal(11,0) DEFAULT '0',
  `item_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `item_to_sector`
--

CREATE TABLE `item_to_sector` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `item_id` bigint(20) DEFAULT '0',
  `sector_id` bigint(20) DEFAULT '0',
  `employee_id_out` bigint(20) DEFAULT '0',
  `employee_id_in` bigint(20) DEFAULT '0',
  `amount` varchar(255) DEFAULT NULL,
  `item_order_id` bigint(20) DEFAULT '0',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `item_to_sector`
--
DELIMITER $$
CREATE TRIGGER `trigger_item_to_sector_delete` BEFORE DELETE ON `item_to_sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'item_to_sector', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_to_sector_insert` AFTER INSERT ON `item_to_sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'item_to_sector', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_to_sector_insert_id` BEFORE INSERT ON `item_to_sector` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM item_to_sector WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_item_to_sector_update` BEFORE UPDATE ON `item_to_sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'item_to_sector', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `discount` bigint(20) DEFAULT '0',
  `is_active` int(1) DEFAULT '0',
  `username` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `discount_by_amount` decimal(11,2) DEFAULT '0.00' COMMENT 'тодорхой хэмжээгээр хөнгөлөх (зөвхөн 1 удаа)',
  `status` int(1) DEFAULT '0' COMMENT 'status 0: engiin hongololttoi gishuun, status 1: reservation -tai, status 2:  daraa tolj boldog',
  `is_reservation` tinyint(1) DEFAULT '0',
  `is_foc` tinyint(4) DEFAULT '0',
  `is_deposit` tinyint(4) DEFAULT '0',
  `is_onAccount` tinyint(4) DEFAULT '0',
  `membership_balance` decimal(11,2) DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `member`
--
DELIMITER $$
CREATE TRIGGER `trigger_member_delete` BEFORE DELETE ON `member` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'member', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_member_insert` AFTER INSERT ON `member` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'member', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_member_insert_id` BEFORE INSERT ON `member` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM member WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_member_update` BEFORE UPDATE ON `member` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'member', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `membership`
--

CREATE TABLE `membership` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT '0.00',
  `balance` decimal(11,2) DEFAULT '0.00',
  `org_id` bigint(20) DEFAULT '0',
  `is_active` tinyint(4) DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `membership`
--
DELIMITER $$
CREATE TRIGGER `trigger_membership_delete` BEFORE DELETE ON `membership` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'membership', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_membership_insert` AFTER INSERT ON `membership` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'membership', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_membership_insert_id` BEFORE INSERT ON `membership` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM membership WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_membership_update` BEFORE UPDATE ON `membership` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'membership', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `member_to_membership`
--

CREATE TABLE `member_to_membership` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `member_id` bigint(20) DEFAULT '0',
  `membership_id` bigint(20) DEFAULT '0',
  `membership_name` varchar(255) DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT '0.00',
  `balance` decimal(11,2) DEFAULT '0.00',
  `org_id` bigint(20) DEFAULT '0',
  `account_id` bigint(20) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `member_to_membership`
--
DELIMITER $$
CREATE TRIGGER `trigger_member_to_membership_delete` BEFORE DELETE ON `member_to_membership` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'member_to_membership', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_member_to_membership_insert` AFTER INSERT ON `member_to_membership` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'member_to_membership', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_member_to_membership_insert_id` BEFORE INSERT ON `member_to_membership` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM member_to_membership WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_member_to_membership_update` BEFORE UPDATE ON `member_to_membership` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'member_to_membership', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `shift_id` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `employee_id` bigint(20) DEFAULT NULL,
  `employee_name` varchar(255) DEFAULT NULL,
  `order_num` bigint(20) DEFAULT '0',
  `table_name` varchar(255) DEFAULT NULL,
  `table_id` bigint(20) DEFAULT '0',
  `customers` bigint(20) DEFAULT '1',
  `member_id` bigint(20) DEFAULT NULL,
  `is_active` bigint(20) DEFAULT '1',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT NULL,
  `discount_by_amount` decimal(11,2) DEFAULT '0.00' COMMENT 'мөнгөн дүнгээр хөнгөлөх',
  `has_tax` bigint(20) DEFAULT '1',
  `has_service_charge` bigint(20) DEFAULT '1',
  `splitted_time` bigint(20) DEFAULT '0',
  `is_reservation` tinyint(4) DEFAULT '0',
  `hall_id` bigint(20) DEFAULT '0',
  `order_num_prefix` varchar(10) DEFAULT '',
  `is_deleted` bigint(20) DEFAULT '0',
  `is_vip` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `trigger_orders_delete` BEFORE DELETE ON `orders` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'orders', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_orders_insert` AFTER INSERT ON `orders` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'orders', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_orders_insert_id` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM orders WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_orders_update` BEFORE UPDATE ON `orders` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'orders', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_to_product`
--

CREATE TABLE `order_to_product` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `order_id` bigint(20) DEFAULT NULL,
  `bill_id` bigint(20) DEFAULT '0',
  `customer_tag` bigint(20) DEFAULT '0',
  `sector_id` bigint(20) DEFAULT '0',
  `product_id` bigint(20) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `note` longtext,
  `priority_num` bigint(20) DEFAULT '0',
  `ready` bigint(20) DEFAULT '0',
  `fire` bigint(20) DEFAULT '0',
  `is_served` bigint(20) DEFAULT '0',
  `is_rejected` bigint(20) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `original_price` decimal(11,2) DEFAULT '0.00' COMMENT 'бүтээгдэхүүн хөнгөлөгдөөгүй анхны үнэ',
  `discount_type` bigint(20) DEFAULT '0' COMMENT '1 - бол хувиар 2 - бол мөнгөн дүнгээр',
  `discount_value` decimal(11,2) DEFAULT '0.00',
  `is_hold` bigint(20) DEFAULT '0',
  `is_hold_clicked` tinyint(1) DEFAULT '0',
  `has_set_menu` tinyint(1) DEFAULT '0',
  `cat_id` bigint(20) DEFAULT '0',
  `corp_disc_id` bigint(20) DEFAULT NULL,
  `corp_disc_value` double(11,2) DEFAULT NULL,
  `is_takeaway` tinyint(1) DEFAULT '0',
  `corp_disc_type` tinyint(4) DEFAULT '0',
  `is_reservation` tinyint(1) DEFAULT '0',
  `set_menu_products` varchar(2000) DEFAULT NULL,
  `is_merchandise` tinyint(1) DEFAULT '0',
  `is_set` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `order_to_product`
--
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_delete` BEFORE DELETE ON `order_to_product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'order_to_product', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_insert` AFTER INSERT ON `order_to_product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'order_to_product', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_insert_id` BEFORE INSERT ON `order_to_product` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM order_to_product WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_update` BEFORE UPDATE ON `order_to_product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'order_to_product', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_to_product_choice`
--

CREATE TABLE `order_to_product_choice` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `order_to_product_id` bigint(20) DEFAULT NULL,
  `choice_tag_1` varchar(255) DEFAULT NULL,
  `choice_tag_2` varchar(255) DEFAULT NULL,
  `choice_main` varchar(255) DEFAULT NULL,
  `addon_name` varchar(255) DEFAULT NULL,
  `addon_qty` bigint(20) DEFAULT NULL,
  `addon_price` decimal(11,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `order_to_product_choice`
--
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_choice_delete` BEFORE DELETE ON `order_to_product_choice` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'order_to_product_choice', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_choice_insert` AFTER INSERT ON `order_to_product_choice` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'order_to_product_choice', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_choice_insert_id` BEFORE INSERT ON `order_to_product_choice` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM order_to_product_choice WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_choice_update` BEFORE UPDATE ON `order_to_product_choice` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'order_to_product_choice', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_to_product_reject`
--

CREATE TABLE `order_to_product_reject` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `product_id` bigint(20) DEFAULT '0',
  `order_id` bigint(20) DEFAULT '0',
  `quantity` bigint(20) DEFAULT '0',
  `note` text,
  `is_rejected` bigint(20) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_tag` bigint(20) DEFAULT '0',
  `is_set` tinyint(4) DEFAULT '0',
  `order_to_product_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `order_to_product_reject`
--
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_reject_delete` BEFORE DELETE ON `order_to_product_reject` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'order_to_product_reject', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_reject_insert` AFTER INSERT ON `order_to_product_reject` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'order_to_product_reject', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_reject_insert_id` BEFORE INSERT ON `order_to_product_reject` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM order_to_product_reject WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_order_to_product_reject_update` BEFORE UPDATE ON `order_to_product_reject` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'order_to_product_reject', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `outlet_server_ip` varchar(50) DEFAULT NULL,
  `org_type` bigint(20) DEFAULT '1',
  `main_org_id` bigint(20) DEFAULT NULL,
  `service_id` bigint(20) DEFAULT '0',
  `is_blocked` int(2) DEFAULT '0',
  `is_demo` int(2) DEFAULT '1',
  `title` varchar(255) DEFAULT NULL,
  `brand` bigint(20) DEFAULT NULL,
  `description` text,
  `permissible_outlet_item` bigint(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `login_screen_image` varchar(255) DEFAULT NULL,
  `shift_screen_image` varchar(255) DEFAULT NULL,
  `order_screen_image` varchar(255) DEFAULT NULL,
  `phone` text,
  `mobile` text,
  `email` varchar(255) DEFAULT NULL,
  `web` varchar(255) DEFAULT NULL,
  `status` bigint(20) DEFAULT '0' COMMENT 'status 0: ',
  `has_tax` bigint(20) DEFAULT '0',
  `has_service_charge` int(2) DEFAULT '0',
  `service_charge` bigint(20) DEFAULT '0',
  `available_on` datetime DEFAULT NULL,
  `shift_open_at` time DEFAULT NULL,
  `shift_close_at` time DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tax_inside` int(2) DEFAULT '0',
  `is_cashier_can_void` tinyint(1) DEFAULT '0',
  `is_accessreport_cashier` tinyint(1) DEFAULT '0',
  `waiter_table_lock` tinyint(4) DEFAULT '0',
  `order_num_prefix` varchar(10) DEFAULT '',
  `is_holdfire` tinyint(2) DEFAULT '0',
  `show_cash_in_out` tinyint(1) DEFAULT '1',
  `print_server_name` tinyint(4) DEFAULT '0',
  `footer_note` varchar(255) DEFAULT NULL,
  `is_print_cashier_name` tinyint(1) DEFAULT '1',
  `is_print_server_name` tinyint(1) DEFAULT '0',
  `is_print_order_number` tinyint(1) DEFAULT '1',
  `is_truncate_item_name` tinyint(1) DEFAULT '0',
  `logo_image` varchar(255) DEFAULT NULL,
  `is_print_order_no` tinyint(1) DEFAULT '1',
  `is_print_receipt_no` tinyint(1) DEFAULT '0',
  `is_print_kserver_name` tinyint(1) DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `organization`
--
DELIMITER $$
CREATE TRIGGER `trigger_organization_delete` BEFORE DELETE ON `organization` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'organization', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_organization_insert` AFTER INSERT ON `organization` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'organization', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_organization_insert_id` BEFORE INSERT ON `organization` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM organization WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_organization_update` BEFORE UPDATE ON `organization` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'organization', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `organization_to_employee`
--

CREATE TABLE `organization_to_employee` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `employee_id` bigint(20) DEFAULT '0',
  `organization_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Triggers `organization_to_employee`
--
DELIMITER $$
CREATE TRIGGER `trigger_organization_to_employee_delete` BEFORE DELETE ON `organization_to_employee` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'organization_to_employee', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_organization_to_employee_insert` AFTER INSERT ON `organization_to_employee` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'organization_to_employee', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_organization_to_employee_insert_id` BEFORE INSERT ON `organization_to_employee` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM organization_to_employee WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_organization_to_employee_update` BEFORE UPDATE ON `organization_to_employee` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'organization_to_employee', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `organization_type`
--

CREATE TABLE `organization_type` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `title` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `manager` bigint(20) DEFAULT NULL,
  `cashier` bigint(20) DEFAULT NULL,
  `chef` bigint(20) DEFAULT NULL,
  `waiter` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `organization_type`
--
DELIMITER $$
CREATE TRIGGER `trigger_organization_type_delete` BEFORE DELETE ON `organization_type` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'organization_type', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_organization_type_insert` AFTER INSERT ON `organization_type` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'organization_type', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_organization_type_insert_id` BEFORE INSERT ON `organization_type` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM organization_type WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_organization_type_update` BEFORE UPDATE ON `organization_type` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'organization_type', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `cat_id` int(1) DEFAULT '0',
  `brand_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT '',
  `code` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT '',
  `is_active` tinyint(1) DEFAULT '1',
  `is_deleted` bigint(20) DEFAULT '0',
  `hq_created` bigint(20) DEFAULT '0',
  `open_price` tinyint(1) DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `price` varchar(255) DEFAULT '0',
  `ortog` decimal(11,2) DEFAULT '0.00',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `choice_tag_1` text,
  `choice_tag_2` text,
  `choice_main` text,
  `is_set` tinyint(1) DEFAULT '0',
  `priority_index` bigint(20) DEFAULT '1',
  `addon_modifier` varchar(255) DEFAULT NULL,
  `addon_option` varchar(255) DEFAULT NULL,
  `addon_sidedish` varchar(255) DEFAULT NULL,
  `addon_takeaway` varchar(255) DEFAULT NULL,
  `choice_main_2` text,
  `is_open_item` tinyint(1) DEFAULT '0',
  `other_name` varchar(255) DEFAULT NULL,
  `kitchen_name` varchar(255) DEFAULT NULL,
  `label_letter` varchar(255) DEFAULT NULL,
  `color_hex` varchar(255) DEFAULT NULL,
  `is_merchandise` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `product`
--
DELIMITER $$
CREATE TRIGGER `trigger_product_delete` BEFORE DELETE ON `product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'product', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_insert` AFTER INSERT ON `product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'product', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_insert_id` BEFORE INSERT ON `product` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM product WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_update` BEFORE UPDATE ON `product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'product', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_to_brand`
--

CREATE TABLE `product_to_brand` (
  `id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT '0',
  `brand_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `product_to_brand`
--
DELIMITER $$
CREATE TRIGGER `trigger_product_to_brand_delete` BEFORE DELETE ON `product_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'product_to_brand', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_brand_insert` AFTER INSERT ON `product_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'product_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_brand_insert_id` BEFORE INSERT ON `product_to_brand` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM product_to_brand WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_brand_update` BEFORE UPDATE ON `product_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'product_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_to_item`
--

CREATE TABLE `product_to_item` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `product_id` bigint(20) DEFAULT '0',
  `item_id` bigint(20) DEFAULT '0',
  `abrasion` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Triggers `product_to_item`
--
DELIMITER $$
CREATE TRIGGER `trigger_product_to_item_delete` BEFORE DELETE ON `product_to_item` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'product_to_item', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_item_insert` AFTER INSERT ON `product_to_item` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'product_to_item', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_item_insert_id` BEFORE INSERT ON `product_to_item` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM product_to_item WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_item_update` BEFORE UPDATE ON `product_to_item` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'product_to_item', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_to_item_inventory`
--

CREATE TABLE `product_to_item_inventory` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `order_id` bigint(20) DEFAULT NULL,
  `sector_id` bigint(20) DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `abrasion` bigint(20) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Triggers `product_to_item_inventory`
--
DELIMITER $$
CREATE TRIGGER `trigger_product_to_item_inventory_delete` BEFORE DELETE ON `product_to_item_inventory` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'product_to_item_inventory', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_item_inventory_insert` AFTER INSERT ON `product_to_item_inventory` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'product_to_item_inventory', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_item_inventory_insert_id` BEFORE INSERT ON `product_to_item_inventory` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM product_to_item_inventory WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_item_inventory_update` BEFORE UPDATE ON `product_to_item_inventory` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'product_to_item_inventory', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_to_org`
--

CREATE TABLE `product_to_org` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `open_price` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `product_to_org`
--
DELIMITER $$
CREATE TRIGGER `trigger_product_to_org_delete` BEFORE DELETE ON `product_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'product_to_org', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_org_insert` AFTER INSERT ON `product_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'product_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_org_insert_id` BEFORE INSERT ON `product_to_org` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM product_to_org WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_product_to_org_update` BEFORE UPDATE ON `product_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'product_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reservation_category`
--

CREATE TABLE `reservation_category` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` bigint(20) DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `reservation_category`
--
DELIMITER $$
CREATE TRIGGER `trigger_reservation_category_delete` BEFORE DELETE ON `reservation_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'reservation_category', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_reservation_category_insert` AFTER INSERT ON `reservation_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'reservation_category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_reservation_category_insert_id` BEFORE INSERT ON `reservation_category` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM reservation_category WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_reservation_category_update` BEFORE UPDATE ON `reservation_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'reservation_category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reservation_to_order`
--

CREATE TABLE `reservation_to_order` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `order_id` bigint(20) DEFAULT '0',
  `member_id` bigint(20) DEFAULT '0',
  `account_id` bigint(20) DEFAULT '0',
  `shift_id` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `status` tinyint(4) DEFAULT '1' COMMENT '// 1-хүчинтэй                    2-хүчингүй цуцлагдсан - урьдчилгаа өгсөн бол буцаасан                     3- хүчингүй цуцлагдсан - урьдчилгаа өгсөн бол буцаагаагүй                    4- хүчингүй цуцлагдсан -урьдчилгаа өгөөгүй                    5- болж дууссан урьдчилгаа төлөлтрүү орж бодогдсон ',
  `amount` decimal(11,2) DEFAULT '0.00',
  `deposit` float DEFAULT '0',
  `indatetime` datetime DEFAULT NULL,
  `special_request` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL,
  `party_size` tinyint(4) DEFAULT '0',
  `reservation_category_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `reservation_to_order`
--
DELIMITER $$
CREATE TRIGGER `trigger_reservation_to_order_delete` BEFORE DELETE ON `reservation_to_order` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'reservation_to_order', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_reservation_to_order_insert` AFTER INSERT ON `reservation_to_order` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'reservation_to_order', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_reservation_to_order_insert_id` BEFORE INSERT ON `reservation_to_order` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM reservation_to_order WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_reservation_to_order_update` BEFORE UPDATE ON `reservation_to_order` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'reservation_to_order', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sector`
--

CREATE TABLE `sector` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `group_id` bigint(20) DEFAULT '3',
  `name` varchar(255) DEFAULT NULL,
  `is_deleted` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `sector`
--
DELIMITER $$
CREATE TRIGGER `trigger_sector_delete` BEFORE DELETE ON `sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'sector', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_insert` AFTER INSERT ON `sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'sector', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_insert_id` BEFORE INSERT ON `sector` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM sector WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_update` BEFORE UPDATE ON `sector` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'sector', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sector_item_expense`
--

CREATE TABLE `sector_item_expense` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `sector_id` bigint(20) DEFAULT '0',
  `item_id` bigint(20) DEFAULT '0',
  `expense` bigint(20) DEFAULT '0',
  `employee_id` bigint(20) DEFAULT '0',
  `date` datetime DEFAULT NULL,
  `note` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `sector_item_expense`
--
DELIMITER $$
CREATE TRIGGER `trigger_sector_item_expense_delete` BEFORE DELETE ON `sector_item_expense` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'sector_item_expense', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_item_expense_insert` AFTER INSERT ON `sector_item_expense` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'sector_item_expense', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_item_expense_insert_id` BEFORE INSERT ON `sector_item_expense` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM sector_item_expense WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_item_expense_update` BEFORE UPDATE ON `sector_item_expense` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'sector_item_expense', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sector_item_stock_balancing`
--

CREATE TABLE `sector_item_stock_balancing` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `item_id` bigint(20) DEFAULT '0',
  `sector_id` bigint(20) DEFAULT '0',
  `employee_id` bigint(20) DEFAULT '0',
  `stock_balancing` bigint(20) DEFAULT '0',
  `is_first_stock` int(2) DEFAULT '0',
  `note` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `sector_item_stock_balancing`
--
DELIMITER $$
CREATE TRIGGER `trigger_sector_item_stock_balancing_delete` BEFORE DELETE ON `sector_item_stock_balancing` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'sector_item_stock_balancing', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_item_stock_balancing_insert` AFTER INSERT ON `sector_item_stock_balancing` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'sector_item_stock_balancing', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_item_stock_balancing_insert_id` BEFORE INSERT ON `sector_item_stock_balancing` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM sector_item_stock_balancing WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_item_stock_balancing_update` BEFORE UPDATE ON `sector_item_stock_balancing` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'sector_item_stock_balancing', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sector_to_brand`
--

CREATE TABLE `sector_to_brand` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `sector_id` bigint(20) DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `sector_to_brand`
--
DELIMITER $$
CREATE TRIGGER `trigger_sector_to_brand_delete` BEFORE DELETE ON `sector_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'sector_to_brand', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_to_brand_insert` AFTER INSERT ON `sector_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'sector_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_to_brand_insert_id` BEFORE INSERT ON `sector_to_brand` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM sector_to_brand WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_to_brand_update` BEFORE UPDATE ON `sector_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'sector_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sector_to_org`
--

CREATE TABLE `sector_to_org` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `sector_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `printer_model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `printer_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `printer_copy_count` bigint(20) DEFAULT '0',
  `can_print_order` bigint(20) DEFAULT '1',
  `has_tax` bigint(20) DEFAULT '1',
  `has_service_charge` bigint(20) DEFAULT '1',
  `priority_index` bigint(20) DEFAULT '0',
  `third_printer_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `third_printer_model` bigint(20) DEFAULT NULL,
  `third_printer_copy_count` bigint(20) DEFAULT '0',
  `cat_id` bigint(20) DEFAULT '0',
  `second_printer_model` bigint(20) DEFAULT NULL,
  `second_printer_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `second_printer_copy_count` bigint(20) DEFAULT '0',
  `printer_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `sector_to_org`
--
DELIMITER $$
CREATE TRIGGER `trigger_sector_to_org_delete` BEFORE DELETE ON `sector_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'sector_to_org', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_to_org_insert` AFTER INSERT ON `sector_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'sector_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_to_org_insert_id` BEFORE INSERT ON `sector_to_org` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM sector_to_org WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_sector_to_org_update` BEFORE UPDATE ON `sector_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'sector_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `setmenu_category`
--

CREATE TABLE `setmenu_category` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sector_id` bigint(20) DEFAULT '0' COMMENT '1 drink 0 meal',
  `is_complex` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `language_id` bigint(20) DEFAULT '0',
  `is_active` int(1) DEFAULT '1',
  `priority_index` bigint(20) DEFAULT '1',
  `is_set` tinyint(1) DEFAULT '0',
  `set_price` decimal(11,2) DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `setmenu_category`
--
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_delete` BEFORE DELETE ON `setmenu_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'setmenu_category', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_insert` AFTER INSERT ON `setmenu_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'setmenu_category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_insert_id` BEFORE INSERT ON `setmenu_category` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM setmenu_category WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_update` BEFORE UPDATE ON `setmenu_category` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'setmenu_category', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `setmenu_category_to_brand`
--

CREATE TABLE `setmenu_category_to_brand` (
  `id` bigint(20) NOT NULL,
  `set_category_id` bigint(20) DEFAULT '0',
  `brand_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `setmenu_category_to_brand`
--
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_to_brand_delete` BEFORE DELETE ON `setmenu_category_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'setmenu_category_to_brand', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_to_brand_insert` AFTER INSERT ON `setmenu_category_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'setmenu_category_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_to_brand_insert_id` BEFORE INSERT ON `setmenu_category_to_brand` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM setmenu_category_to_brand WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_to_brand_update` BEFORE UPDATE ON `setmenu_category_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'setmenu_category_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `setmenu_category_to_org`
--

CREATE TABLE `setmenu_category_to_org` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `setmenu_category_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `setmenu_category_to_org`
--
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_to_org_delete` BEFORE DELETE ON `setmenu_category_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'setmenu_category_to_org', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_to_org_insert` AFTER INSERT ON `setmenu_category_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'setmenu_category_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_to_org_insert_id` BEFORE INSERT ON `setmenu_category_to_org` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM setmenu_category_to_org WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_category_to_org_update` BEFORE UPDATE ON `setmenu_category_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'setmenu_category_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `setmenu_to_brand`
--

CREATE TABLE `setmenu_to_brand` (
  `id` bigint(20) NOT NULL,
  `set_menu_id` bigint(20) DEFAULT '0',
  `brand_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `setmenu_to_brand`
--
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_brand_delete` BEFORE DELETE ON `setmenu_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'setmenu_to_brand', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_brand_insert` AFTER INSERT ON `setmenu_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'setmenu_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_brand_insert_id` BEFORE INSERT ON `setmenu_to_brand` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM setmenu_to_brand WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_brand_update` BEFORE UPDATE ON `setmenu_to_brand` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'setmenu_to_brand', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `setmenu_to_org`
--

CREATE TABLE `setmenu_to_org` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `setmenu_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT '0',
  `open_price` tinyint(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `setmenu_to_org`
--
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_org_delete` BEFORE DELETE ON `setmenu_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'setmenu_to_org', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_org_insert` AFTER INSERT ON `setmenu_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'setmenu_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_org_insert_id` BEFORE INSERT ON `setmenu_to_org` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM setmenu_to_org WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_org_update` BEFORE UPDATE ON `setmenu_to_org` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'setmenu_to_org', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `setmenu_to_product`
--

CREATE TABLE `setmenu_to_product` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `setmenu_id` bigint(20) DEFAULT '0',
  `category_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT '0',
  `choose_item_type` bigint(20) DEFAULT NULL,
  `sector_id` bigint(20) DEFAULT NULL,
  `open_item_name` varchar(255) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `setmenu_to_product`
--
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_product_delete` BEFORE DELETE ON `setmenu_to_product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'setmenu_to_product', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_product_insert` AFTER INSERT ON `setmenu_to_product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'setmenu_to_product', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_product_insert_id` BEFORE INSERT ON `setmenu_to_product` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM setmenu_to_product WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_setmenu_to_product_update` BEFORE UPDATE ON `setmenu_to_product` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'setmenu_to_product', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `set_menu`
--

CREATE TABLE `set_menu` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `set_name` varchar(255) DEFAULT NULL,
  `other_name` varchar(255) DEFAULT NULL,
  `kitchen_name` varchar(255) DEFAULT NULL,
  `cat_id` bigint(20) DEFAULT NULL,
  `plu_code` varchar(255) DEFAULT NULL,
  `information` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `multi_price_bool` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `hq_created` bigint(20) DEFAULT '0',
  `addon_takeaway` varchar(255) DEFAULT NULL,
  `addon_modifier` varchar(255) DEFAULT NULL,
  `addon_option` varchar(255) DEFAULT NULL,
  `addon_sidedish` varchar(255) DEFAULT NULL,
  `priority_index` bigint(20) DEFAULT '1',
  `label_letter` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `color_hex` varchar(255) DEFAULT NULL,
  `open_price` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `set_menu`
--
DELIMITER $$
CREATE TRIGGER `trigger_set_menu_delete` BEFORE DELETE ON `set_menu` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'set_menu', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_set_menu_insert` AFTER INSERT ON `set_menu` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'set_menu', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_set_menu_insert_id` BEFORE INSERT ON `set_menu` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM set_menu WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_set_menu_update` BEFORE UPDATE ON `set_menu` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'set_menu', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `shift`
--

CREATE TABLE `shift` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0',
  `started` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` bigint(20) DEFAULT '1',
  `closed` datetime DEFAULT NULL,
  `cash_first` decimal(11,2) DEFAULT '0.00',
  `cash_last` decimal(11,2) DEFAULT '0.00',
  `employee_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Triggers `shift`
--
DELIMITER $$
CREATE TRIGGER `trigger_shift_delete` BEFORE DELETE ON `shift` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'shift', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_shift_insert` AFTER INSERT ON `shift` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'shift', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_shift_insert_id` BEFORE INSERT ON `shift` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM shift WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_shift_update` BEFORE UPDATE ON `shift` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'shift', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `supplier`
--
DELIMITER $$
CREATE TRIGGER `trigger_supplier_delete` BEFORE DELETE ON `supplier` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'supplier', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_supplier_insert` AFTER INSERT ON `supplier` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'supplier', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_supplier_insert_id` BEFORE INSERT ON `supplier` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM supplier WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_supplier_update` BEFORE UPDATE ON `supplier` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'supplier', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_to_organization`
--

CREATE TABLE `supplier_to_organization` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `supplier_id` bigint(20) DEFAULT '0',
  `organization_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- Triggers `supplier_to_organization`
--
DELIMITER $$
CREATE TRIGGER `trigger_supplier_to_organization_delete` BEFORE DELETE ON `supplier_to_organization` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'supplier_to_organization', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_supplier_to_organization_insert` AFTER INSERT ON `supplier_to_organization` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'supplier_to_organization', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_supplier_to_organization_insert_id` BEFORE INSERT ON `supplier_to_organization` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM supplier_to_organization WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_supplier_to_organization_update` BEFORE UPDATE ON `supplier_to_organization` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'supplier_to_organization', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `capacity` bigint(20) DEFAULT '0',
  `hall_id` bigint(20) DEFAULT NULL,
  `posx` bigint(20) DEFAULT '100',
  `posy` bigint(20) DEFAULT '100',
  `state` bigint(20) DEFAULT '1' COMMENT '1 bol tsagaan engiin#default, 2 bol nogoon zahialgatai, 3 bol shar тооцоо дууссан цэвэрлээгүй байгаа, 4 bol budeg tsanher ',
  `img_name` varchar(255) DEFAULT NULL,
  `rotationState` tinyint(1) DEFAULT '0',
  `is_takeAway` tinyint(1) DEFAULT '0',
  `is_vip` tinyint(1) DEFAULT '0',
  `customersNumber` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `tables`
--
DELIMITER $$
CREATE TRIGGER `trigger_tables_delete` BEFORE DELETE ON `tables` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'tables', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_tables_insert` AFTER INSERT ON `tables` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'tables', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_tables_insert_id` BEFORE INSERT ON `tables` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM tables WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_tables_update` BEFORE UPDATE ON `tables` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'tables', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `table_logs`
--

CREATE TABLE `table_logs` (
  `id` bigint(20) NOT NULL,
  `action` varchar(50) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `table_id` bigint(20) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `table_log_error`
--

CREATE TABLE `table_log_error` (
  `id` bigint(20) NOT NULL,
  `text` text,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `table_log_sync`
--

CREATE TABLE `table_log_sync` (
  `id` bigint(20) NOT NULL,
  `log_id` bigint(20) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `unit`
--

CREATE TABLE `unit` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `factor` bigint(20) DEFAULT '0',
  `symbol_major` varchar(255) DEFAULT NULL,
  `symbol_minor` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `unit`
--

INSERT INTO `unit` (`id`, `hqCreated`, `factor`, `symbol_major`, `symbol_minor`) VALUES
(1, 0, 1000, 'kg\r\n', 'g'),
(3, 0, 1000, 'l', 'ml'),
(4, 0, 1, 'pcs', 'pcs'),
(5, 0, 1, 'box', 'box');

--
-- Triggers `unit`
--
DELIMITER $$
CREATE TRIGGER `trigger_unit_delete` BEFORE DELETE ON `unit` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'unit', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_unit_insert` AFTER INSERT ON `unit` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'unit', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_unit_insert_id` BEFORE INSERT ON `unit` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM unit WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_unit_update` BEFORE UPDATE ON `unit` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'unit', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`id`, `hqCreated`, `name`) VALUES
(1, 0, 'super_manager'),
(2, 0, 'manager'),
(3, 0, 'chef'),
(4, 0, 'cashier'),
(5, 0, 'waiter'),
(6, 0, 'demo_user'),
(7, 0, 'barman'),
(8, 0, 'bookkeeper'),
(9, 0, 'shareholder'),
(10, 0, 'super_chef');

--
-- Triggers `user_group`
--
DELIMITER $$
CREATE TRIGGER `trigger_user_group_delete` BEFORE DELETE ON `user_group` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'user_group', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_user_group_insert` AFTER INSERT ON `user_group` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'user_group', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_user_group_insert_id` BEFORE INSERT ON `user_group` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM user_group WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_user_group_update` BEFORE UPDATE ON `user_group` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'user_group', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voucher`
--

CREATE TABLE `voucher` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT NULL,
  `is_set` int(1) DEFAULT '0',
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` bigint(20) DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `voucher`
--
DELIMITER $$
CREATE TRIGGER `trigger_voucher_delete` BEFORE DELETE ON `voucher` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'voucher', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_voucher_insert` AFTER INSERT ON `voucher` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'voucher', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_voucher_insert_id` BEFORE INSERT ON `voucher` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM voucher WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_voucher_update` BEFORE UPDATE ON `voucher` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'voucher', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voucher_entity`
--

CREATE TABLE `voucher_entity` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `voucher_id` bigint(20) DEFAULT NULL,
  `serial_num` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `collected_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bill_id` bigint(20) DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `voucher_entity`
--
DELIMITER $$
CREATE TRIGGER `trigger_voucher_entity_delete` BEFORE DELETE ON `voucher_entity` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'voucher_entity', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_voucher_entity_insert` AFTER INSERT ON `voucher_entity` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'voucher_entity', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_voucher_entity_insert_id` BEFORE INSERT ON `voucher_entity` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM voucher_entity WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_voucher_entity_update` BEFORE UPDATE ON `voucher_entity` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'voucher_entity', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `voucher_to_brand`
--

CREATE TABLE `voucher_to_brand` (
  `id` bigint(20) NOT NULL,
  `voucher_id` bigint(20) DEFAULT '0',
  `brand_id` bigint(20) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `voucher_to_org`
--

CREATE TABLE `voucher_to_org` (
  `id` bigint(20) NOT NULL,
  `voucher_id` bigint(20) DEFAULT '0',
  `org_id` bigint(20) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `voucher_to_product`
--

CREATE TABLE `voucher_to_product` (
  `id` bigint(20) NOT NULL,
  `voucher_id` bigint(20) DEFAULT '0',
  `sector_id` bigint(20) DEFAULT '0',
  `cat_id` bigint(20) DEFAULT '0',
  `pro_id` bigint(20) DEFAULT '0',
  `by_object` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_stock_balancing`
--

CREATE TABLE `warehouse_stock_balancing` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `item_id` bigint(20) DEFAULT '0',
  `employee_id` bigint(20) DEFAULT '0',
  `stock_balancing` bigint(20) DEFAULT '0',
  `note` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Triggers `warehouse_stock_balancing`
--
DELIMITER $$
CREATE TRIGGER `trigger_warehouse_stock_balancing_delete` BEFORE DELETE ON `warehouse_stock_balancing` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'warehouse_stock_balancing', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_warehouse_stock_balancing_insert` AFTER INSERT ON `warehouse_stock_balancing` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'warehouse_stock_balancing', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_warehouse_stock_balancing_insert_id` BEFORE INSERT ON `warehouse_stock_balancing` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM warehouse_stock_balancing WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_warehouse_stock_balancing_update` BEFORE UPDATE ON `warehouse_stock_balancing` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'warehouse_stock_balancing', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `xreport`
--

CREATE TABLE `xreport` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `employee_id` bigint(20) DEFAULT '0',
  `shift_id` bigint(20) DEFAULT '0',
  `ended` datetime DEFAULT NULL,
  `cash_last` decimal(11,2) DEFAULT '0.00',
  `is_reset` tinyint(1) DEFAULT '0',
  `started` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cash_first` decimal(11,2) DEFAULT '0.00',
  `number` tinyint(4) DEFAULT '1',
  `org_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `xreport`
--
DELIMITER $$
CREATE TRIGGER `trigger_xreport_delete` BEFORE DELETE ON `xreport` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', 'xreport', OLD.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_xreport_insert` AFTER INSERT ON `xreport` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', 'xreport', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_xreport_insert_id` BEFORE INSERT ON `xreport` FOR EACH ROW BEGIN
	if(NEW.id is NULL) THEN
    SET NEW.id = (SELECT MAX(id) + 1 FROM xreport WHERE id <100000000000);
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_xreport_update` BEFORE UPDATE ON `xreport` FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', 'xreport', new.id, CURRENT_TIMESTAMP)
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `account_transaction`
--
ALTER TABLE `account_transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `addons`
--
ALTER TABLE `addons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `addon_category`
--
ALTER TABLE `addon_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `addon_to_category`
--
ALTER TABLE `addon_to_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addon_id` (`addon_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `m_org_id` (`m_org_id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `deposit_payment_id` (`deposit_id`);

--
-- Indexes for table `bill_paidback`
--
ALTER TABLE `bill_paidback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bill_id` (`bill_id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `bill_to_account`
--
ALTER TABLE `bill_to_account`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cash_in_out`
--
ALTER TABLE `cash_in_out`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cost_id` (`cash_in_out_type_id`),
  ADD KEY `org_id` (`org_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `cash_in_out_type`
--
ALTER TABLE `cash_in_out_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_to_brand`
--
ALTER TABLE `category_to_brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_to_org`
--
ALTER TABLE `category_to_org`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `category_to_sector`
--
ALTER TABLE `category_to_sector`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ci_sessions`
--
ALTER TABLE `ci_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Indexes for table `communication`
--
ALTER TABLE `communication`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `control_users`
--
ALTER TABLE `control_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `corporate_discounts`
--
ALTER TABLE `corporate_discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposit`
--
ALTER TABLE `deposit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `deposit_payments`
--
ALTER TABLE `deposit_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reservation_id` (`deposit_id`);

--
-- Indexes for table `diagnostic`
--
ALTER TABLE `diagnostic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cat_id` (`cat_id`),
  ADD KEY `sector_id` (`sector_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `discount_time`
--
ALTER TABLE `discount_time`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discount_id` (`discount_id`);

--
-- Indexes for table `discount_to_brand`
--
ALTER TABLE `discount_to_brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_to_org`
--
ALTER TABLE `discount_to_org`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discount_id` (`discount_id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `discount_to_product`
--
ALTER TABLE `discount_to_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `user_service_id` (`user_service_id`);

--
-- Indexes for table `employee_sessions`
--
ALTER TABLE `employee_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `user_id` (`employee_id`),
  ADD KEY `sector_id` (`sector_id`);

--
-- Indexes for table `employee_to_sector`
--
ALTER TABLE `employee_to_sector`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `hall`
--
ALTER TABLE `hall`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `hq_user`
--
ALTER TABLE `hq_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `item_category`
--
ALTER TABLE `item_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `item_order`
--
ALTER TABLE `item_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `cash_id` (`cash_id`),
  ADD KEY `card_id` (`card_id`);

--
-- Indexes for table `item_order_items`
--
ALTER TABLE `item_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_order_id` (`item_order_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `item_order_payment`
--
ALTER TABLE `item_order_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`item_order_id`),
  ADD KEY `cash_id` (`cash_id`),
  ADD KEY `card_id` (`card_id`);

--
-- Indexes for table `item_to_item`
--
ALTER TABLE `item_to_item`
  ADD KEY `item_id` (`item_id`),
  ADD KEY `sub_id` (`sub_item_id`);

--
-- Indexes for table `item_to_sector`
--
ALTER TABLE `item_to_sector`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `sector_id` (`sector_id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `membership`
--
ALTER TABLE `membership`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_to_membership`
--
ALTER TABLE `member_to_membership`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`),
  ADD KEY `table_id` (`table_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `member` (`member_id`);

--
-- Indexes for table `order_to_product`
--
ALTER TABLE `order_to_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `sector_id` (`sector_id`),
  ADD KEY `bill_id` (`bill_id`),
  ADD KEY `corp_disc_id` (`corp_disc_id`);

--
-- Indexes for table `order_to_product_choice`
--
ALTER TABLE `order_to_product_choice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_to_product_id` (`order_to_product_id`);

--
-- Indexes for table `order_to_product_reject`
--
ALTER TABLE `order_to_product_reject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `main_org_id` (`main_org_id`);

--
-- Indexes for table `organization_to_employee`
--
ALTER TABLE `organization_to_employee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- Indexes for table `organization_type`
--
ALTER TABLE `organization_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cat_id` (`cat_id`);

--
-- Indexes for table `product_to_brand`
--
ALTER TABLE `product_to_brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_to_item`
--
ALTER TABLE `product_to_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `product_to_item_inventory`
--
ALTER TABLE `product_to_item_inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `sector_id` (`sector_id`);

--
-- Indexes for table `product_to_org`
--
ALTER TABLE `product_to_org`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `reservation_category`
--
ALTER TABLE `reservation_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reservation_to_order`
--
ALTER TABLE `reservation_to_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sector`
--
ALTER TABLE `sector`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `sector_item_expense`
--
ALTER TABLE `sector_item_expense`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sector_id` (`sector_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `sector_item_stock_balancing`
--
ALTER TABLE `sector_item_stock_balancing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `sector_id` (`sector_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `sector_to_brand`
--
ALTER TABLE `sector_to_brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sector_to_org`
--
ALTER TABLE `sector_to_org`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sector_id` (`sector_id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `setmenu_category`
--
ALTER TABLE `setmenu_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sector_id` (`sector_id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `setmenu_category_to_brand`
--
ALTER TABLE `setmenu_category_to_brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `setmenu_category_to_org`
--
ALTER TABLE `setmenu_category_to_org`
  ADD PRIMARY KEY (`id`),
  ADD KEY `setmenu_category_id` (`setmenu_category_id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `setmenu_to_brand`
--
ALTER TABLE `setmenu_to_brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `setmenu_to_org`
--
ALTER TABLE `setmenu_to_org`
  ADD PRIMARY KEY (`id`),
  ADD KEY `set_menu_id` (`setmenu_id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `setmenu_to_product`
--
ALTER TABLE `setmenu_to_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `set_menu`
--
ALTER TABLE `set_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shift`
--
ALTER TABLE `shift`
  ADD PRIMARY KEY (`id`),
  ADD KEY `org_id` (`org_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_2` (`id`);

--
-- Indexes for table `supplier_to_organization`
--
ALTER TABLE `supplier_to_organization`
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hall_id` (`hall_id`);

--
-- Indexes for table `table_logs`
--
ALTER TABLE `table_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `table_log_error`
--
ALTER TABLE `table_log_error`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `table_log_sync`
--
ALTER TABLE `table_log_sync`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `unit`
--
ALTER TABLE `unit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `voucher_entity`
--
ALTER TABLE `voucher_entity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bill_id` (`bill_id`),
  ADD KEY `voucher_id` (`voucher_id`);

--
-- Indexes for table `voucher_to_brand`
--
ALTER TABLE `voucher_to_brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `voucher_to_org`
--
ALTER TABLE `voucher_to_org`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `voucher_to_product`
--
ALTER TABLE `voucher_to_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warehouse_stock_balancing`
--
ALTER TABLE `warehouse_stock_balancing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `xreport`
--
ALTER TABLE `xreport`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `shift_id` (`shift_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `account_transaction`
--
ALTER TABLE `account_transaction`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `addons`
--
ALTER TABLE `addons`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `addon_category`
--
ALTER TABLE `addon_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `addon_to_category`
--
ALTER TABLE `addon_to_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `bill_paidback`
--
ALTER TABLE `bill_paidback`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `bill_to_account`
--
ALTER TABLE `bill_to_account`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cash_in_out`
--
ALTER TABLE `cash_in_out`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cash_in_out_type`
--
ALTER TABLE `cash_in_out_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category_to_brand`
--
ALTER TABLE `category_to_brand`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category_to_org`
--
ALTER TABLE `category_to_org`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category_to_sector`
--
ALTER TABLE `category_to_sector`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `communication`
--
ALTER TABLE `communication`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `control_users`
--
ALTER TABLE `control_users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `corporate_discounts`
--
ALTER TABLE `corporate_discounts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `deposit`
--
ALTER TABLE `deposit`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `deposit_payments`
--
ALTER TABLE `deposit_payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `diagnostic`
--
ALTER TABLE `diagnostic`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `discount_time`
--
ALTER TABLE `discount_time`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `discount_to_brand`
--
ALTER TABLE `discount_to_brand`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `discount_to_org`
--
ALTER TABLE `discount_to_org`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `discount_to_product`
--
ALTER TABLE `discount_to_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `employee_sessions`
--
ALTER TABLE `employee_sessions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `employee_to_sector`
--
ALTER TABLE `employee_to_sector`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hall`
--
ALTER TABLE `hall`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hq_user`
--
ALTER TABLE `hq_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `item_category`
--
ALTER TABLE `item_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `item_order`
--
ALTER TABLE `item_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `item_order_items`
--
ALTER TABLE `item_order_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `item_order_payment`
--
ALTER TABLE `item_order_payment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `item_to_sector`
--
ALTER TABLE `item_to_sector`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `membership`
--
ALTER TABLE `membership`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `member_to_membership`
--
ALTER TABLE `member_to_membership`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `order_to_product`
--
ALTER TABLE `order_to_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `order_to_product_choice`
--
ALTER TABLE `order_to_product_choice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `order_to_product_reject`
--
ALTER TABLE `order_to_product_reject`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `organization`
--
ALTER TABLE `organization`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `organization_to_employee`
--
ALTER TABLE `organization_to_employee`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `organization_type`
--
ALTER TABLE `organization_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_to_brand`
--
ALTER TABLE `product_to_brand`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_to_item`
--
ALTER TABLE `product_to_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_to_item_inventory`
--
ALTER TABLE `product_to_item_inventory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_to_org`
--
ALTER TABLE `product_to_org`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `reservation_category`
--
ALTER TABLE `reservation_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `reservation_to_order`
--
ALTER TABLE `reservation_to_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sector`
--
ALTER TABLE `sector`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sector_item_expense`
--
ALTER TABLE `sector_item_expense`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sector_item_stock_balancing`
--
ALTER TABLE `sector_item_stock_balancing`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sector_to_brand`
--
ALTER TABLE `sector_to_brand`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sector_to_org`
--
ALTER TABLE `sector_to_org`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `setmenu_category`
--
ALTER TABLE `setmenu_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `setmenu_category_to_brand`
--
ALTER TABLE `setmenu_category_to_brand`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `setmenu_category_to_org`
--
ALTER TABLE `setmenu_category_to_org`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `setmenu_to_brand`
--
ALTER TABLE `setmenu_to_brand`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `setmenu_to_org`
--
ALTER TABLE `setmenu_to_org`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `setmenu_to_product`
--
ALTER TABLE `setmenu_to_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `set_menu`
--
ALTER TABLE `set_menu`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `shift`
--
ALTER TABLE `shift`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `supplier_to_organization`
--
ALTER TABLE `supplier_to_organization`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `table_logs`
--
ALTER TABLE `table_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `table_log_error`
--
ALTER TABLE `table_log_error`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `table_log_sync`
--
ALTER TABLE `table_log_sync`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `unit`
--
ALTER TABLE `unit`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `voucher`
--
ALTER TABLE `voucher`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `voucher_entity`
--
ALTER TABLE `voucher_entity`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `voucher_to_brand`
--
ALTER TABLE `voucher_to_brand`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `voucher_to_org`
--
ALTER TABLE `voucher_to_org`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `voucher_to_product`
--
ALTER TABLE `voucher_to_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `warehouse_stock_balancing`
--
ALTER TABLE `warehouse_stock_balancing`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `xreport`
--
ALTER TABLE `xreport`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
