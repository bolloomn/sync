-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 09, 2017 at 07:13 AM
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
  `deposit_payment_id` bigint(20) DEFAULT '0',
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
  `recovery_disc_reason` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

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

-- --------------------------------------------------------

--
-- Table structure for table `discount_to_org`
--

CREATE TABLE `discount_to_org` (
  `id` bigint(20) NOT NULL,
  `hqCreated` bigint(20) DEFAULT '0',
  `discount_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `logo_image` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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

-- --------------------------------------------------------

--
-- Table structure for table `product_to_brand`
--

CREATE TABLE `product_to_brand` (
  `id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT '0',
  `brand_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `setmenu_category_to_brand`
--

CREATE TABLE `setmenu_category_to_brand` (
  `id` bigint(20) NOT NULL,
  `set_category_id` bigint(20) DEFAULT '0',
  `brand_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `setmenu_to_brand`
--

CREATE TABLE `setmenu_to_brand` (
  `id` bigint(20) NOT NULL,
  `set_menu_id` bigint(20) DEFAULT '0',
  `brand_id` bigint(20) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  ADD KEY `deposit_payment_id` (`deposit_payment_id`);

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
  ADD UNIQUE KEY `id` (`id`) USING BTREE;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
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
