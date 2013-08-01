-- phpMyAdmin SQL Dump
-- version 2.8.2.4
-- http://www.phpmyadmin.net
-- 
-- Host: Elixhosting.com:3306
-- Generation Time: Dec 12, 2006 at 10:51 PM
-- Server version: 5.0.24
-- PHP Version: 5.1.6
-- 
-- Database: `amen`
-- 
DROP DATABASE `amen`;
CREATE DATABASE `amen` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `amen`;

-- --------------------------------------------------------

-- 
-- Table structure for table `address_book`
-- 

DROP TABLE IF EXISTS `address_book`;
CREATE TABLE IF NOT EXISTS `address_book` (
  `address_book_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `entry_gender` char(1) NOT NULL,
  `entry_company` varchar(32) default NULL,
  `entry_firstname` varchar(32) NOT NULL,
  `entry_lastname` varchar(32) NOT NULL,
  `entry_street_address` varchar(64) NOT NULL,
  `entry_suburb` varchar(32) default NULL,
  `entry_postcode` varchar(10) NOT NULL,
  `entry_city` varchar(32) NOT NULL,
  `entry_state` varchar(32) default NULL,
  `entry_country_id` int(11) NOT NULL default '0',
  `entry_zone_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`address_book_id`),
  KEY `idx_address_book_customers_id` (`customers_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

-- 
-- Dumping data for table `address_book`
-- 

INSERT INTO `address_book` (`address_book_id`, `customers_id`, `entry_gender`, `entry_company`, `entry_firstname`, `entry_lastname`, `entry_street_address`, `entry_suburb`, `entry_postcode`, `entry_city`, `entry_state`, `entry_country_id`, `entry_zone_id`) VALUES (1, 1, 'm', 'ACME Inc.', 'Jane', 'Waters', '1 Way Street', '', '12345', 'NeverNever', '', 223, 12),
(2, 2, '', NULL, 'Ben', 'Herila', '38 Old Coach Rd.', NULL, '07920', 'Basking Ridge', '', 223, 41),
(3, 3, '', NULL, 'Donna', 'Haiback', '17 Launcelot Lane', NULL, '07920', 'Basking Ridge', '', 223, 41),
(4, 4, '', NULL, 'CAREN', 'BUCHALTER', '4 DANIEL DRIVE', NULL, '07747', 'MATAWAN', '', 223, 41),
(5, 5, '', NULL, 'Sheila', 'Hitt', '2613 Horizon Blvd.', NULL, '72758', 'Rogers', '', 223, 5),
(9, 7, '', NULL, 'MR. PAUL', 'BAIRD', '285 EAST MAIN STREET #12', NULL, '02766', 'NORTON', '', 223, 32),
(8, 7, '', NULL, 'KIYOMI OTA', 'BAIRD', '1 CARRIAGE HILL DRIVE', NULL, '07931', 'FAR HILLS', '', 223, 41),
(10, 8, '', NULL, 'PAM', 'STEVENS', '131 DUDLEY STREET', NULL, '07302', 'JERSEY CITY', '', 223, 41),
(11, 8, '', NULL, 'WINNIE', 'STEIN', '1114 HUDSON ST. #4', NULL, '07030', 'HOBOKEN', '', 223, 41),
(12, 9, '', NULL, 'BETTY', 'PEACOCK', '11471 WASHINGTON PLAZA WEST', NULL, '20190', 'RESTON', '', 223, 61),
(13, 10, '', NULL, 'SUE', 'BETHKEY', '1308 Deep Run Lane', NULL, '20190', 'RESTON', '', 223, 61),
(14, 10, '', NULL, 'WINNIE & MATT', 'STEIN-PEACOCK', '1114 HUDSON ST. #4', NULL, '07030', 'HOBOKEN', '', 223, 41),
(16, 12, '', NULL, 'KATHY', 'PAGLIUCA', '2059 TENBROECK AVENUE', NULL, '10461', 'BRONX', '', 223, 43);

-- --------------------------------------------------------

-- 
-- Table structure for table `address_format`
-- 

DROP TABLE IF EXISTS `address_format`;
CREATE TABLE IF NOT EXISTS `address_format` (
  `address_format_id` int(11) NOT NULL auto_increment,
  `address_format` varchar(128) NOT NULL,
  `address_summary` varchar(48) NOT NULL,
  PRIMARY KEY  (`address_format_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- 
-- Dumping data for table `address_format`
-- 

INSERT INTO `address_format` (`address_format_id`, `address_format`, `address_summary`) VALUES (1, '$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country', '$city / $country'),
(2, '$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country', '$city, $state / $country'),
(3, '$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country', '$state / $country'),
(4, '$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', '$postcode / $country'),
(5, '$firstname $lastname$cr$streets$cr$postcode $city$cr$country', '$city / $country');

-- --------------------------------------------------------

-- 
-- Table structure for table `banners`
-- 

DROP TABLE IF EXISTS `banners`;
CREATE TABLE IF NOT EXISTS `banners` (
  `banners_id` int(11) NOT NULL auto_increment,
  `banners_title` varchar(64) NOT NULL,
  `banners_url` varchar(255) NOT NULL,
  `banners_image` varchar(64) NOT NULL,
  `banners_group` varchar(10) NOT NULL,
  `banners_html_text` text,
  `expires_impressions` int(7) default '0',
  `expires_date` datetime default NULL,
  `date_scheduled` datetime default NULL,
  `date_added` datetime NOT NULL,
  `date_status_change` datetime default NULL,
  `status` int(1) NOT NULL default '1',
  PRIMARY KEY  (`banners_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `banners`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `banners_history`
-- 

DROP TABLE IF EXISTS `banners_history`;
CREATE TABLE IF NOT EXISTS `banners_history` (
  `banners_history_id` int(11) NOT NULL auto_increment,
  `banners_id` int(11) NOT NULL,
  `banners_shown` int(5) NOT NULL default '0',
  `banners_clicked` int(5) NOT NULL default '0',
  `banners_history_date` datetime NOT NULL,
  PRIMARY KEY  (`banners_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `banners_history`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `categories`
-- 

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `categories_id` int(11) NOT NULL auto_increment,
  `categories_image` varchar(64) default NULL,
  `parent_id` int(11) NOT NULL default '0',
  `sort_order` int(3) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`categories_id`),
  KEY `idx_categories_parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

-- 
-- Dumping data for table `categories`
-- 

INSERT INTO `categories` (`categories_id`, `categories_image`, `parent_id`, `sort_order`, `date_added`, `last_modified`) VALUES (21, '', 0, 1, '2006-09-16 21:56:03', '2006-09-16 21:59:03'),
(22, '', 0, 2, '2006-09-16 21:58:26', '2006-09-29 21:17:14'),
(23, '', 0, 3, '2006-09-16 21:58:34', '2006-09-29 21:17:19'),
(24, '', 0, 4, '2006-09-16 21:58:49', '2006-09-29 21:17:28'),
(25, '', 0, 5, '2006-09-16 21:58:55', '2006-09-29 21:17:32'),
(28, 'OFR-021-NAPOLEON-APPLE.jpg', 24, 1, '2006-10-02 20:23:30', NULL),
(29, '', 24, 2, '2006-10-02 20:59:43', NULL),
(30, '', 0, 7, '2006-10-02 21:23:05', NULL),
(31, '', 0, 10, '2006-10-28 20:38:09', '2006-10-28 20:38:16');

-- --------------------------------------------------------

-- 
-- Table structure for table `categories_description`
-- 

DROP TABLE IF EXISTS `categories_description`;
CREATE TABLE IF NOT EXISTS `categories_description` (
  `categories_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `categories_name` varchar(32) NOT NULL,
  PRIMARY KEY  (`categories_id`,`language_id`),
  KEY `idx_categories_name` (`categories_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `categories_description`
-- 

INSERT INTO `categories_description` (`categories_id`, `language_id`, `categories_name`) VALUES (25, 1, 'Glass Art'),
(21, 1, 'Wood, Bone, and Horn'),
(22, 1, 'Pottery'),
(23, 1, 'Candles & Gifts'),
(24, 1, 'Home Accents'),
(28, 1, 'Decorative Apple'),
(29, 1, 'Balancing Models'),
(30, 1, 'Tabletop'),
(31, 1, 'Weather Vanes');

-- --------------------------------------------------------

-- 
-- Table structure for table `configuration`
-- 

DROP TABLE IF EXISTS `configuration`;
CREATE TABLE IF NOT EXISTS `configuration` (
  `configuration_id` int(11) NOT NULL auto_increment,
  `configuration_title` varchar(64) NOT NULL,
  `configuration_key` varchar(64) NOT NULL,
  `configuration_value` varchar(255) NOT NULL,
  `configuration_description` varchar(255) NOT NULL,
  `configuration_group_id` int(11) NOT NULL,
  `sort_order` int(5) default NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  `use_function` varchar(255) default NULL,
  `set_function` varchar(255) default NULL,
  PRIMARY KEY  (`configuration_id`)
) ENGINE=MyISAM AUTO_INCREMENT=217 DEFAULT CHARSET=latin1 AUTO_INCREMENT=217 ;

-- 
-- Dumping data for table `configuration`
-- 

INSERT INTO `configuration` (`configuration_id`, `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES (1, 'Store Name', 'STORE_NAME', 'Absolutely Fabulous Things AMEN', 'The name of my store', 1, 1, '2006-09-16 21:46:54', '2006-09-16 21:36:17', NULL, NULL),
(2, 'Store Owner', 'STORE_OWNER', 'Lyn Sattler', 'The name of my store owner', 1, 2, '2006-09-16 21:47:00', '2006-09-16 21:36:17', NULL, NULL),
(3, 'E-Mail Address', 'STORE_OWNER_EMAIL_ADDRESS', 'lyn@absolutelyfabulousthingsamen.com', 'The e-mail address of my store owner', 1, 3, '2006-11-21 03:01:49', '2006-09-16 21:36:17', NULL, NULL),
(4, 'E-Mail From', 'EMAIL_FROM', 'Absolutely Fabulous Things AMEN <lyn@absolutelyfabulousthingsamen.com>', 'The e-mail address used in (sent) e-mails', 1, 4, '2006-11-21 03:02:00', '2006-09-16 21:36:17', NULL, NULL),
(5, 'Country', 'STORE_COUNTRY', '223', 'The country my store is located in <br><br><b>Note: Please remember to update the store zone.</b>', 1, 6, NULL, '2006-09-16 21:36:17', 'tep_get_country_name', 'tep_cfg_pull_down_country_list('),
(6, 'Zone', 'STORE_ZONE', '41', 'The zone my store is located in', 1, 7, '2006-09-16 21:47:48', '2006-09-16 21:36:17', 'tep_cfg_get_zone_name', 'tep_cfg_pull_down_zone_list('),
(7, 'Expected Sort Order', 'EXPECTED_PRODUCTS_SORT', 'desc', 'This is the sort order used in the expected products box.', 1, 8, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''asc'', ''desc''), '),
(8, 'Expected Sort Field', 'EXPECTED_PRODUCTS_FIELD', 'date_expected', 'The column to sort by in the expected products box.', 1, 9, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''products_name'', ''date_expected''), '),
(9, 'Switch To Default Language Currency', 'USE_DEFAULT_LANGUAGE_CURRENCY', 'false', 'Automatically switch to the language''s currency when it is changed', 1, 10, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(10, 'Send Extra Order Emails To', 'SEND_EXTRA_ORDER_EMAILS_TO', '', 'Send extra order emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 1, 11, NULL, '2006-09-16 21:36:17', NULL, NULL),
(11, 'Use Search-Engine Safe URLs (still in development)', 'SEARCH_ENGINE_FRIENDLY_URLS', 'false', 'Use search-engine safe urls for all site links', 1, 12, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(12, 'Display Cart After Adding Product', 'DISPLAY_CART', 'true', 'Display the shopping cart after adding a product (or return back to their origin)', 1, 14, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(13, 'Allow Guest To Tell A Friend', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 'true', 'Allow guests to tell a friend about a product', 1, 15, '2006-09-16 21:47:55', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(14, 'Default Search Operator', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 'and', 'Default search operators', 1, 17, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''and'', ''or''), '),
(15, 'Store Address and Phone', 'STORE_NAME_ADDRESS', 'Absolutely Fabulous Things AMEN\r\n51 Crestview Dr.\r\nBernardsville, NJ 07924 USA\r\n\r\n(908) 204-8989', 'This is the Store Name, Address and Phone used on printable documents and displayed online', 1, 18, '2006-10-06 00:38:51', '2006-09-16 21:36:17', NULL, 'tep_cfg_textarea('),
(16, 'Show Category Counts', 'SHOW_COUNTS', 'false', 'Count recursively how many products are in each category', 1, 19, '2006-09-17 03:05:36', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(17, 'Tax Decimal Places', 'TAX_DECIMAL_PLACES', '2', 'Pad the tax value this amount of decimal places', 1, 20, '2006-09-16 21:49:41', '2006-09-16 21:36:17', NULL, NULL),
(18, 'Display Prices with Tax', 'DISPLAY_PRICE_WITH_TAX', 'false', 'Display prices with tax included (true) or add the tax at the end (false)', 1, 21, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(19, 'First Name', 'ENTRY_FIRST_NAME_MIN_LENGTH', '2', 'Minimum length of first name', 2, 1, NULL, '2006-09-16 21:36:17', NULL, NULL),
(20, 'Last Name', 'ENTRY_LAST_NAME_MIN_LENGTH', '2', 'Minimum length of last name', 2, 2, NULL, '2006-09-16 21:36:17', NULL, NULL),
(21, 'Date of Birth', 'ENTRY_DOB_MIN_LENGTH', '10', 'Minimum length of date of birth', 2, 3, NULL, '2006-09-16 21:36:17', NULL, NULL),
(22, 'E-Mail Address', 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', '6', 'Minimum length of e-mail address', 2, 4, NULL, '2006-09-16 21:36:17', NULL, NULL),
(23, 'Street Address', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', '5', 'Minimum length of street address', 2, 5, NULL, '2006-09-16 21:36:17', NULL, NULL),
(24, 'Company', 'ENTRY_COMPANY_MIN_LENGTH', '2', 'Minimum length of company name', 2, 6, NULL, '2006-09-16 21:36:17', NULL, NULL),
(25, 'Post Code', 'ENTRY_POSTCODE_MIN_LENGTH', '4', 'Minimum length of post code', 2, 7, NULL, '2006-09-16 21:36:17', NULL, NULL),
(26, 'City', 'ENTRY_CITY_MIN_LENGTH', '3', 'Minimum length of city', 2, 8, NULL, '2006-09-16 21:36:17', NULL, NULL),
(27, 'State', 'ENTRY_STATE_MIN_LENGTH', '2', 'Minimum length of state', 2, 9, NULL, '2006-09-16 21:36:17', NULL, NULL),
(28, 'Telephone Number', 'ENTRY_TELEPHONE_MIN_LENGTH', '3', 'Minimum length of telephone number', 2, 10, NULL, '2006-09-16 21:36:17', NULL, NULL),
(29, 'Password', 'ENTRY_PASSWORD_MIN_LENGTH', '5', 'Minimum length of password', 2, 11, NULL, '2006-09-16 21:36:17', NULL, NULL),
(30, 'Credit Card Owner Name', 'CC_OWNER_MIN_LENGTH', '3', 'Minimum length of credit card owner name', 2, 12, NULL, '2006-09-16 21:36:17', NULL, NULL),
(31, 'Credit Card Number', 'CC_NUMBER_MIN_LENGTH', '10', 'Minimum length of credit card number', 2, 13, NULL, '2006-09-16 21:36:17', NULL, NULL),
(32, 'Review Text', 'REVIEW_TEXT_MIN_LENGTH', '50', 'Minimum length of review text', 2, 14, NULL, '2006-09-16 21:36:17', NULL, NULL),
(33, 'Best Sellers', 'MIN_DISPLAY_BESTSELLERS', '1', 'Minimum number of best sellers to display', 2, 15, NULL, '2006-09-16 21:36:17', NULL, NULL),
(34, 'Also Purchased', 'MIN_DISPLAY_ALSO_PURCHASED', '1', 'Minimum number of products to display in the ''This Customer Also Purchased'' box', 2, 16, NULL, '2006-09-16 21:36:17', NULL, NULL),
(35, 'Address Book Entries', 'MAX_ADDRESS_BOOK_ENTRIES', '10', 'Maximum address book entries a customer is allowed to have', 3, 1, '2006-09-16 21:50:14', '2006-09-16 21:36:17', NULL, NULL),
(36, 'Search Results', 'MAX_DISPLAY_SEARCH_RESULTS', '10', 'Amount of products to list', 3, 2, '2006-09-29 21:41:10', '2006-09-16 21:36:17', NULL, NULL),
(37, 'Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Number of ''number'' links use for page-sets', 3, 3, NULL, '2006-09-16 21:36:17', NULL, NULL),
(38, 'Special Products', 'MAX_DISPLAY_SPECIAL_PRODUCTS', '9', 'Maximum number of products on special to display', 3, 4, NULL, '2006-09-16 21:36:17', NULL, NULL),
(39, 'New Products Module', 'MAX_DISPLAY_NEW_PRODUCTS', '9', 'Maximum number of new products to display in a category', 3, 5, NULL, '2006-09-16 21:36:17', NULL, NULL),
(40, 'Products Expected', 'MAX_DISPLAY_UPCOMING_PRODUCTS', '10', 'Maximum number of products expected to display', 3, 6, NULL, '2006-09-16 21:36:17', NULL, NULL),
(41, 'Manufacturers List', 'MAX_DISPLAY_MANUFACTURERS_IN_A_LIST', '0', 'Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list', 3, 7, NULL, '2006-09-16 21:36:17', NULL, NULL),
(42, 'Manufacturers Select Size', 'MAX_MANUFACTURERS_LIST', '1', 'Used in manufacturers box; when this value is ''1'' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.', 3, 7, NULL, '2006-09-16 21:36:17', NULL, NULL),
(43, 'Length of Manufacturers Name', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', '18', 'Used in manufacturers box; maximum length of manufacturers name to display', 3, 8, '2006-09-17 00:49:55', '2006-09-16 21:36:17', NULL, NULL),
(44, 'New Reviews', 'MAX_DISPLAY_NEW_REVIEWS', '6', 'Maximum number of new reviews to display', 3, 9, NULL, '2006-09-16 21:36:17', NULL, NULL),
(45, 'Selection of Random Reviews', 'MAX_RANDOM_SELECT_REVIEWS', '10', 'How many records to select from to choose one random product review', 3, 10, NULL, '2006-09-16 21:36:17', NULL, NULL),
(46, 'Selection of Random New Products', 'MAX_RANDOM_SELECT_NEW', '10', 'How many records to select from to choose one random new product to display', 3, 11, NULL, '2006-09-16 21:36:17', NULL, NULL),
(47, 'Selection of Products on Special', 'MAX_RANDOM_SELECT_SPECIALS', '10', 'How many records to select from to choose one random product special to display', 3, 12, NULL, '2006-09-16 21:36:17', NULL, NULL),
(48, 'Categories To List Per Row', 'MAX_DISPLAY_CATEGORIES_PER_ROW', '3', 'How many categories to list per row', 3, 13, NULL, '2006-09-16 21:36:17', NULL, NULL),
(49, 'New Products Listing', 'MAX_DISPLAY_PRODUCTS_NEW', '10', 'Maximum number of new products to display in new products page', 3, 14, NULL, '2006-09-16 21:36:17', NULL, NULL),
(50, 'Best Sellers', 'MAX_DISPLAY_BESTSELLERS', '10', 'Maximum number of best sellers to display', 3, 15, NULL, '2006-09-16 21:36:17', NULL, NULL),
(51, 'Also Purchased', 'MAX_DISPLAY_ALSO_PURCHASED', '6', 'Maximum number of products to display in the ''This Customer Also Purchased'' box', 3, 16, NULL, '2006-09-16 21:36:17', NULL, NULL),
(52, 'Customer Order History Box', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', '6', 'Maximum number of products to display in the customer order history box', 3, 17, NULL, '2006-09-16 21:36:17', NULL, NULL),
(53, 'Order History', 'MAX_DISPLAY_ORDER_HISTORY', '10', 'Maximum number of orders to display in the order history page', 3, 18, NULL, '2006-09-16 21:36:17', NULL, NULL),
(54, 'Small Image Width', 'SMALL_IMAGE_WIDTH', '100', 'The pixel width of small images', 4, 1, NULL, '2006-09-16 21:36:17', NULL, NULL),
(55, 'Small Image Height', 'SMALL_IMAGE_HEIGHT', '80', 'The pixel height of small images', 4, 2, NULL, '2006-09-16 21:36:17', NULL, NULL),
(56, 'Heading Image Width', 'HEADING_IMAGE_WIDTH', '57', 'The pixel width of heading images', 4, 3, NULL, '2006-09-16 21:36:17', NULL, NULL),
(57, 'Heading Image Height', 'HEADING_IMAGE_HEIGHT', '40', 'The pixel height of heading images', 4, 4, NULL, '2006-09-16 21:36:17', NULL, NULL),
(58, 'Subcategory Image Width', 'SUBCATEGORY_IMAGE_WIDTH', '100', 'The pixel width of subcategory images', 4, 5, NULL, '2006-09-16 21:36:17', NULL, NULL),
(59, 'Subcategory Image Height', 'SUBCATEGORY_IMAGE_HEIGHT', '57', 'The pixel height of subcategory images', 4, 6, NULL, '2006-09-16 21:36:17', NULL, NULL),
(60, 'Calculate Image Size', 'CONFIG_CALCULATE_IMAGE_SIZE', 'true', 'Calculate the size of images?', 4, 7, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(61, 'Image Required', 'IMAGE_REQUIRED', 'false', 'Enable to display broken images. Good for development.', 4, 8, '2006-09-17 01:31:25', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(62, 'Gender', 'ACCOUNT_GENDER', 'false', 'Display gender in the customers account', 5, 1, '2006-09-17 00:39:02', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(63, 'Date of Birth', 'ACCOUNT_DOB', 'false', 'Display date of birth in the customers account', 5, 2, '2006-10-28 19:12:38', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(64, 'Company', 'ACCOUNT_COMPANY', 'false', 'Display company in the customers account', 5, 3, '2006-09-17 00:38:53', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(65, 'Suburb', 'ACCOUNT_SUBURB', 'false', 'Display suburb in the customers account', 5, 4, '2006-09-17 00:38:40', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(66, 'State', 'ACCOUNT_STATE', 'true', 'Display state in the customers account', 5, 5, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(67, 'Installed Modules', 'MODULE_PAYMENT_INSTALLED', 'paypal.php;moneyorder.php;cod.php', 'List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cc.php;cod.php;paypal.php)', 6, 0, '2006-09-16 22:36:03', '2006-09-16 21:36:17', NULL, NULL),
(68, 'Installed Modules', 'MODULE_ORDER_TOTAL_INSTALLED', 'ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php', 'List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', 6, 0, NULL, '2006-09-16 21:36:17', NULL, NULL),
(69, 'Installed Modules', 'MODULE_SHIPPING_INSTALLED', 'flat.php;table.php', 'List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)', 6, 0, '2006-11-12 17:48:04', '2006-09-16 21:36:17', NULL, NULL),
(70, 'Enable Cash On Delivery Module', 'MODULE_PAYMENT_COD_STATUS', 'True', 'Do you want to accept Cash On Delevery payments?', 6, 1, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''True'', ''False''), '),
(71, 'Payment Zone', 'MODULE_PAYMENT_COD_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', 6, 2, NULL, '2006-09-16 21:36:17', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes('),
(72, 'Sort order of display.', 'MODULE_PAYMENT_COD_SORT_ORDER', '3', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2006-09-16 21:36:17', NULL, NULL),
(73, 'Set Order Status', 'MODULE_PAYMENT_COD_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', 6, 0, NULL, '2006-09-16 21:36:17', 'tep_get_order_status_name', 'tep_cfg_pull_down_order_statuses('),
(146, 'Payment Zone', 'MODULE_PAYMENT_MONEYORDER_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', 6, 2, NULL, '2006-09-16 22:34:32', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes('),
(147, 'Set Order Status', 'MODULE_PAYMENT_MONEYORDER_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', 6, 0, NULL, '2006-09-16 22:34:32', 'tep_get_order_status_name', 'tep_cfg_pull_down_order_statuses('),
(144, 'Make Payable to:', 'MODULE_PAYMENT_MONEYORDER_PAYTO', 'AMEN, LLC.', 'Who should payments be made payable to?', 6, 1, NULL, '2006-09-16 22:34:32', NULL, NULL),
(145, 'Sort order of display.', 'MODULE_PAYMENT_MONEYORDER_SORT_ORDER', '2', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2006-09-16 22:34:32', NULL, NULL),
(143, 'Enable Check/Money Order Module', 'MODULE_PAYMENT_MONEYORDER_STATUS', 'True', 'Do you want to accept Check/Money Order payments?', 6, 1, NULL, '2006-09-16 22:34:32', NULL, 'tep_cfg_select_option(array(''True'', ''False''), '),
(212, 'Table Method', 'MODULE_SHIPPING_TABLE_MODE', 'weight', 'The shipping cost is based on the order total or the total weight of the items ordered.', 6, 0, NULL, '2006-11-12 17:48:04', NULL, 'tep_cfg_select_option(array(''weight'', ''price''), '),
(213, 'Handling Fee', 'MODULE_SHIPPING_TABLE_HANDLING', '2.50', 'Handling fee for this shipping method.', 6, 0, NULL, '2006-11-12 17:48:04', NULL, NULL),
(214, 'Tax Class', 'MODULE_SHIPPING_TABLE_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', 6, 0, NULL, '2006-11-12 17:48:04', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes('),
(84, 'Default Currency', 'DEFAULT_CURRENCY', 'USD', 'Default Currency', 6, 0, NULL, '2006-09-16 21:36:17', NULL, NULL),
(85, 'Default Language', 'DEFAULT_LANGUAGE', 'en', 'Default Language', 6, 0, NULL, '2006-09-16 21:36:17', NULL, NULL),
(86, 'Default Order Status For New Orders', 'DEFAULT_ORDERS_STATUS_ID', '1', 'When a new order is created, this order status will be assigned to it.', 6, 0, NULL, '2006-09-16 21:36:17', NULL, NULL),
(87, 'Display Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 'true', 'Do you want to display the order shipping cost?', 6, 1, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(88, 'Sort Order', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', '2', 'Sort order of display.', 6, 2, NULL, '2006-09-16 21:36:17', NULL, NULL),
(89, 'Allow Free Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', 'Do you want to allow free shipping?', 6, 3, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(90, 'Free Shipping For Orders Over', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '50', 'Provide free shipping for orders over the set amount.', 6, 4, NULL, '2006-09-16 21:36:17', 'currencies->format', NULL),
(91, 'Provide Free Shipping For Orders Made', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', 'Provide free shipping for orders sent to the set destination.', 6, 5, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''national'', ''international'', ''both''), '),
(92, 'Display Sub-Total', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 'true', 'Do you want to display the order sub-total cost?', 6, 1, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(93, 'Sort Order', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', '1', 'Sort order of display.', 6, 2, NULL, '2006-09-16 21:36:17', NULL, NULL),
(94, 'Display Tax', 'MODULE_ORDER_TOTAL_TAX_STATUS', 'true', 'Do you want to display the order tax value?', 6, 1, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(95, 'Sort Order', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', '3', 'Sort order of display.', 6, 2, NULL, '2006-09-16 21:36:17', NULL, NULL),
(96, 'Display Total', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 'true', 'Do you want to display the total order value?', 6, 1, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(97, 'Sort Order', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', '4', 'Sort order of display.', 6, 2, NULL, '2006-09-16 21:36:17', NULL, NULL),
(98, 'Country of Origin', 'SHIPPING_ORIGIN_COUNTRY', '223', 'Select the country of origin to be used in shipping quotes.', 7, 1, NULL, '2006-09-16 21:36:17', 'tep_get_country_name', 'tep_cfg_pull_down_country_list('),
(99, 'Postal Code', 'SHIPPING_ORIGIN_ZIP', 'NONE', 'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.', 7, 2, NULL, '2006-09-16 21:36:17', NULL, NULL),
(100, 'Enter the Maximum Package Weight you will ship', 'SHIPPING_MAX_WEIGHT', '50', 'Carriers have a max weight limit for a single package. This is a common one for all.', 7, 3, NULL, '2006-09-16 21:36:17', NULL, NULL),
(101, 'Package Tare weight.', 'SHIPPING_BOX_WEIGHT', '3', 'What is the weight of typical packaging of small to medium packages?', 7, 4, NULL, '2006-09-16 21:36:17', NULL, NULL),
(102, 'Larger packages - percentage increase.', 'SHIPPING_BOX_PADDING', '10', 'For 10% enter 10', 7, 5, NULL, '2006-09-16 21:36:17', NULL, NULL),
(103, 'Display Product Image', 'PRODUCT_LIST_IMAGE', '1', 'Do you want to display the Product Image?', 8, 1, NULL, '2006-09-16 21:36:17', NULL, NULL),
(104, 'Display Product Manufaturer Name', 'PRODUCT_LIST_MANUFACTURER', '3', 'Do you want to display the Product Manufacturer Name?', 8, 2, '2006-09-29 21:23:24', '2006-09-16 21:36:17', NULL, NULL),
(105, 'Display Product Model', 'PRODUCT_LIST_MODEL', '0', 'Do you want to display the Product Model?', 8, 3, NULL, '2006-09-16 21:36:17', NULL, NULL),
(106, 'Display Product Name', 'PRODUCT_LIST_NAME', '2', 'Do you want to display the Product Name?', 8, 4, NULL, '2006-09-16 21:36:17', NULL, NULL),
(107, 'Display Product Price', 'PRODUCT_LIST_PRICE', '4', 'Do you want to display the Product Price', 8, 5, '2006-10-01 01:25:36', '2006-09-16 21:36:17', NULL, NULL),
(108, 'Display Product Quantity', 'PRODUCT_LIST_QUANTITY', '0', 'Do you want to display the Product Quantity?', 8, 6, NULL, '2006-09-16 21:36:17', NULL, NULL),
(109, 'Display Product Weight', 'PRODUCT_LIST_WEIGHT', '0', 'Do you want to display the Product Weight?', 8, 7, NULL, '2006-09-16 21:36:17', NULL, NULL),
(110, 'Display Buy Now column', 'PRODUCT_LIST_BUY_NOW', '0', 'Do you want to display the Buy Now column?', 8, 8, '2006-09-29 21:22:58', '2006-09-16 21:36:17', NULL, NULL),
(111, 'Display Category/Manufacturer Filter (0=disable; 1=enable)', 'PRODUCT_LIST_FILTER', '1', 'Do you want to display the Category/Manufacturer Filter?', 8, 9, NULL, '2006-09-16 21:36:17', NULL, NULL),
(112, 'Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 'PREV_NEXT_BAR_LOCATION', '2', 'Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 8, 10, '2006-09-29 21:16:16', '2006-09-16 21:36:17', NULL, NULL),
(113, 'Check stock level', 'STOCK_CHECK', 'false', 'Check to see if sufficent stock is available', 9, 1, '2006-09-17 03:02:02', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(114, 'Subtract stock', 'STOCK_LIMITED', 'false', 'Subtract product in stock by product orders', 9, 2, '2006-09-29 21:29:28', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(115, 'Allow Checkout', 'STOCK_ALLOW_CHECKOUT', 'true', 'Allow customer to checkout even if there is insufficient stock', 9, 3, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(116, 'Mark product out of stock', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '', 'Display something on screen so customer can see which product has insufficient stock', 9, 4, '2006-09-16 21:51:06', '2006-09-16 21:36:17', NULL, NULL),
(117, 'Stock Re-order level', 'STOCK_REORDER_LEVEL', '0', 'Define when stock needs to be re-ordered', 9, 5, '2006-09-16 21:50:58', '2006-09-16 21:36:17', NULL, NULL),
(118, 'Store Page Parse Time', 'STORE_PAGE_PARSE_TIME', 'false', 'Store the time it takes to parse a page', 10, 1, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(119, 'Log Destination', 'STORE_PAGE_PARSE_TIME_LOG', '/var/log/www/tep/page_parse_time.log', 'Directory and filename of the page parse time log', 10, 2, NULL, '2006-09-16 21:36:17', NULL, NULL),
(120, 'Log Date Format', 'STORE_PARSE_DATE_TIME_FORMAT', '%d/%m/%Y %H:%M:%S', 'The date format', 10, 3, NULL, '2006-09-16 21:36:17', NULL, NULL),
(121, 'Display The Page Parse Time', 'DISPLAY_PAGE_PARSE_TIME', 'true', 'Display the page parse time (store page parse time must be enabled)', 10, 4, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(122, 'Store Database Queries', 'STORE_DB_TRANSACTIONS', 'false', 'Store the database queries in the page parse time log (PHP4 only)', 10, 5, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(123, 'Use Cache', 'USE_CACHE', 'false', 'Use caching features', 11, 1, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(124, 'Cache Directory', 'DIR_FS_CACHE', '/tmp/', 'The directory where the cached files are saved', 11, 2, NULL, '2006-09-16 21:36:17', NULL, NULL),
(125, 'E-Mail Transport Method', 'EMAIL_TRANSPORT', 'smtp', 'Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.', 12, 1, '2006-11-21 02:54:24', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''sendmail'', ''smtp''),'),
(126, 'E-Mail Linefeeds', 'EMAIL_LINEFEED', 'LF', 'Defines the character sequence used to separate mail headers.', 12, 2, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''LF'', ''CRLF''),'),
(127, 'Use MIME HTML When Sending Emails', 'EMAIL_USE_HTML', 'false', 'Send e-mails in HTML format', 12, 3, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''),'),
(128, 'Verify E-Mail Addresses Through DNS', 'ENTRY_EMAIL_ADDRESS_CHECK', 'false', 'Verify e-mail address through a DNS server', 12, 4, '2006-09-17 00:39:21', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(129, 'Send E-Mails', 'SEND_EMAILS', 'true', 'Send out e-mails', 12, 5, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(130, 'Enable download', 'DOWNLOAD_ENABLED', 'false', 'Enable the products download functions.', 13, 1, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(131, 'Download by redirect', 'DOWNLOAD_BY_REDIRECT', 'false', 'Use browser redirection for download. Disable on non-Unix systems.', 13, 2, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(132, 'Expiry delay (days)', 'DOWNLOAD_MAX_DAYS', '7', 'Set number of days before the download link expires. 0 means no limit.', 13, 3, NULL, '2006-09-16 21:36:17', NULL, ''),
(133, 'Maximum number of downloads', 'DOWNLOAD_MAX_COUNT', '5', 'Set the maximum number of downloads. 0 means no download authorized.', 13, 4, NULL, '2006-09-16 21:36:17', NULL, ''),
(134, 'Enable GZip Compression', 'GZIP_COMPRESSION', 'true', 'Enable HTTP GZip compression.', 14, 1, '2006-09-17 03:57:23', '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(135, 'Compression Level', 'GZIP_LEVEL', '8', 'Use this compression level 0-9 (0 = minimum, 9 = maximum).', 14, 2, '2006-09-17 03:57:28', '2006-09-16 21:36:17', NULL, NULL),
(136, 'Session Directory', 'SESSION_WRITE_DIRECTORY', '/tmp', 'If sessions are file based, store them in this directory.', 15, 1, NULL, '2006-09-16 21:36:17', NULL, NULL),
(137, 'Force Cookie Use', 'SESSION_FORCE_COOKIE_USE', 'False', 'Force the use of sessions when cookies are only enabled.', 15, 2, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''True'', ''False''), '),
(138, 'Check SSL Session ID', 'SESSION_CHECK_SSL_SESSION_ID', 'False', 'Validate the SSL_SESSION_ID on every secure HTTPS page request.', 15, 3, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''True'', ''False''), '),
(139, 'Check User Agent', 'SESSION_CHECK_USER_AGENT', 'False', 'Validate the clients browser user agent on every page request.', 15, 4, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''True'', ''False''), '),
(140, 'Check IP Address', 'SESSION_CHECK_IP_ADDRESS', 'False', 'Validate the clients IP address on every page request.', 15, 5, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''True'', ''False''), '),
(141, 'Prevent Spider Sessions', 'SESSION_BLOCK_SPIDERS', 'False', 'Prevent known spiders from starting a session.', 15, 6, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''True'', ''False''), '),
(142, 'Recreate Session', 'SESSION_RECREATE', 'False', 'Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).', 15, 7, NULL, '2006-09-16 21:36:17', NULL, 'tep_cfg_select_option(array(''True'', ''False''), '),
(148, 'Enable PayPal Module', 'MODULE_PAYMENT_PAYPAL_STATUS', 'True', 'Do you want to accept PayPal payments?', 6, 3, NULL, '2006-09-16 22:34:42', NULL, 'tep_cfg_select_option(array(''True'', ''False''), '),
(149, 'E-Mail Address', 'MODULE_PAYMENT_PAYPAL_ID', 'lyn@allfabulousthings.com', 'The e-mail address to use for the PayPal service', 6, 4, NULL, '2006-09-16 22:34:42', NULL, NULL),
(150, 'Transaction Currency', 'MODULE_PAYMENT_PAYPAL_CURRENCY', 'Selected Currency', 'The currency to use for credit card transactions', 6, 6, NULL, '2006-09-16 22:34:42', NULL, 'tep_cfg_select_option(array(''Selected Currency'',''Only USD'',''Only CAD'',''Only EUR'',''Only GBP'',''Only JPY''), '),
(151, 'Sort order of display.', 'MODULE_PAYMENT_PAYPAL_SORT_ORDER', '1', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2006-09-16 22:34:42', NULL, NULL),
(152, 'Payment Zone', 'MODULE_PAYMENT_PAYPAL_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', 6, 2, NULL, '2006-09-16 22:34:42', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes('),
(153, 'Set Order Status', 'MODULE_PAYMENT_PAYPAL_ORDER_STATUS_ID', '1', 'Set the status of orders made with this payment module to this value', 6, 0, NULL, '2006-09-16 22:34:42', 'tep_get_order_status_name', 'tep_cfg_pull_down_order_statuses('),
(154, 'Display Slave Product Name', 'MASTER_LIST_NAME', '5', 'Do you wish to display the products name?', 16, 1, '2003-11-17 20:22:53', '2003-11-04 23:28:38', NULL, NULL),
(155, 'Display Slave Product Price', 'MASTER_LIST_PRICE', '75', 'Do you want to display the Product Price?', 16, 3, '2006-10-16 21:31:13', '2003-11-04 23:28:38', NULL, NULL),
(156, 'Display Slave Product Manufacturer Name', 'MASTER_LIST_MANUFACTURER', '0', 'Do you want to display the Product Manufacturer Name?', 16, 4, NULL, '2003-11-04 23:28:38', NULL, NULL),
(157, 'Display Slave Product Image', 'MASTER_LIST_IMAGE', '0', 'Do you want to display the Product Image?', 16, 8, '2003-11-10 21:38:06', '2003-11-04 23:28:38', NULL, NULL),
(158, 'Display Slave Product Model', 'MASTER_LIST_MODEL', '0', 'Do you want to display the Product Model?', 16, 2, '2006-09-17 03:02:42', '2003-11-04 23:28:38', NULL, NULL),
(159, 'Display Slave Product Quantity', 'MASTER_LIST_QUANTITY', '0', 'Do you want to display the Product Quantity?', 16, 6, '2003-11-09 22:49:47', '2003-11-04 23:28:38', NULL, NULL),
(160, 'Display Slave Product Weight', 'MASTER_LIST_WEIGHT', '0', 'Do you want to display the Product Weight?', 16, 5, NULL, '2003-11-04 23:28:38', NULL, NULL),
(161, 'Display Slave Product Options', 'MASTER_LIST_OPTIONS', '80', 'Set to 0 to disable, set to 8 to enable.', 16, 12, '2006-10-16 21:30:54', '0000-00-00 00:00:00', NULL, NULL),
(162, 'Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 'MASTER_PREV_NEXT_BAR_LOCATION', '2', ' Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 16, 12, '2003-11-10 01:02:58', '2003-11-04 23:28:38', NULL, NULL),
(163, 'Display the Buy Now Column', 'MASTER_LIST_BUY_NOW', '200', 'Do you want to display the Buy Now column?', 16, 9, '2006-10-16 21:31:35', '2003-11-09 20:38:04', NULL, NULL),
(164, 'Display Slave Product Description', 'MASTER_LIST_DESCRIPTION', '50', 'Set to 0 to disable, set to 99 to enable.', 16, 10, '2006-10-16 21:29:41', '0000-00-00 00:00:00', NULL, NULL),
(165, 'Length of Truncated Product Description', 'MASTER_LIST_DESCRIPTION_LENGTH', '100', 'How many characters would you like to display?', 16, 11, '2003-11-10 23:36:52', '2003-11-10 18:51:26', NULL, NULL),
(166, 'Entries in Accessories Infobox', 'MASTER_LIST_NUM_ACCESSORIES', '5', 'Maximum number of entries in the suggested accessories infobox', 3, 12, '2006-09-17 02:05:34', '2006-09-17 02:05:34', NULL, NULL),
(216, 'Sort Order', 'MODULE_SHIPPING_TABLE_SORT_ORDER', '0', 'Sort order of display.', 6, 0, NULL, '2006-11-12 17:48:04', NULL, NULL),
(173, 'Enable Flat Shipping', 'MODULE_SHIPPING_FLAT_STATUS', 'True', 'Do you want to offer flat rate shipping?', 6, 0, NULL, '2006-09-17 03:59:35', NULL, 'tep_cfg_select_option(array(''True'', ''False''), '),
(174, 'Shipping Cost', 'MODULE_SHIPPING_FLAT_COST', '0.00', 'The shipping cost for all orders using this shipping method.', 6, 0, NULL, '2006-09-17 03:59:35', NULL, NULL),
(175, 'Tax Class', 'MODULE_SHIPPING_FLAT_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', 6, 0, NULL, '2006-09-17 03:59:35', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes('),
(176, 'Shipping Zone', 'MODULE_SHIPPING_FLAT_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', 6, 0, NULL, '2006-09-17 03:59:35', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes('),
(177, 'Sort Order', 'MODULE_SHIPPING_FLAT_SORT_ORDER', '0', 'Sort order of display.', 6, 0, NULL, '2006-09-17 03:59:35', NULL, NULL),
(178, 'Display Registry After Adding Product', 'DISPLAY_REGISTRY', 'true', 'Display the registry after adding a product (or return back to their origin)', 1, 14, NULL, '2006-09-29 04:10:00', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(179, 'Remove product from registry, once added to the cart', 'REMOVE_REGISTRY_PRODUCT', 'true', 'If set to true, the product is removed from the registry when you add it to the cart. It is ignored, if you turn the registry functionality on.', 1, 14, NULL, '2006-09-29 04:10:00', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(180, 'Activate registry functionality (if deactivated, we have a wish ', 'ACTIVATE_REGISTRY', 'true', 'Activate registry functionality (if deactivated, we have a wish list functionality).', 1, 14, NULL, '2006-09-29 04:10:00', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(181, 'Allow higher quantity or additional items to be purchased than i', 'CHECK_REGISTRY_ITEMS', 'false', 'Allow higher quantity or additional items to be purchased than in registry.', 1, 14, NULL, '2006-09-29 04:10:00', NULL, 'tep_cfg_select_option(array(''true'', ''false''), '),
(182, 'Registry Entries', 'MAX_REGISTRY_ENTRIES', '5', 'Maximum registry entries a customer is allowed to have', 3, 1, NULL, '2006-09-29 04:10:00', NULL, NULL),
(215, 'Shipping Zone', 'MODULE_SHIPPING_TABLE_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', 6, 0, NULL, '2006-11-12 17:48:04', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes('),
(210, 'Enable Table Method', 'MODULE_SHIPPING_TABLE_STATUS', 'True', 'Do you want to offer table rate shipping?', 6, 0, NULL, '2006-11-12 17:48:04', NULL, 'tep_cfg_select_option(array(''True'', ''False''), '),
(211, 'Shipping Table', 'MODULE_SHIPPING_TABLE_COST', '8:15,15:20,30:25,40:35,50:45,60:60', 'The shipping cost is based on the total cost or weight of items. Example: 25:8.50,50:5.50,etc.. Up to 25 charge 8.50, from there to 50 charge 5.50, etc', 6, 0, NULL, '2006-11-12 17:48:04', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `configuration_group`
-- 

DROP TABLE IF EXISTS `configuration_group`;
CREATE TABLE IF NOT EXISTS `configuration_group` (
  `configuration_group_id` int(11) NOT NULL auto_increment,
  `configuration_group_title` varchar(64) NOT NULL,
  `configuration_group_description` varchar(255) NOT NULL,
  `sort_order` int(5) default NULL,
  `visible` int(1) default '1',
  PRIMARY KEY  (`configuration_group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

-- 
-- Dumping data for table `configuration_group`
-- 

INSERT INTO `configuration_group` (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES (1, 'My Store', 'General information about my store', 1, 1),
(2, 'Minimum Values', 'The minimum values for functions / data', 2, 1),
(3, 'Maximum Values', 'The maximum values for functions / data', 3, 1),
(4, 'Images', 'Image parameters', 4, 1),
(5, 'Customer Details', 'Customer account configuration', 5, 1),
(6, 'Module Options', 'Hidden from configuration', 6, 0),
(7, 'Shipping/Packaging', 'Shipping options available at my store', 7, 1),
(8, 'Product Listing', 'Product Listing    configuration options', 8, 1),
(9, 'Stock', 'Stock configuration options', 9, 1),
(10, 'Logging', 'Logging configuration options', 10, 1),
(11, 'Cache', 'Caching configuration options', 11, 1),
(12, 'E-Mail Options', 'General setting for E-Mail transport and HTML E-Mails', 12, 1),
(13, 'Download', 'Downloadable products options', 13, 1),
(14, 'GZip Compression', 'GZip compression options', 14, 1),
(15, 'Sessions', 'Session options', 15, 1),
(16, 'Slave Products', 'Slave Product Listing - configuration options', 16, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `counter`
-- 

DROP TABLE IF EXISTS `counter`;
CREATE TABLE IF NOT EXISTS `counter` (
  `startdate` char(8) default NULL,
  `counter` int(12) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `counter`
-- 

INSERT INTO `counter` (`startdate`, `counter`) VALUES ('20060916', 8809);

-- --------------------------------------------------------

-- 
-- Table structure for table `counter_history`
-- 

DROP TABLE IF EXISTS `counter_history`;
CREATE TABLE IF NOT EXISTS `counter_history` (
  `month` char(8) default NULL,
  `counter` int(12) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `counter_history`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `countries`
-- 

DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `countries_id` int(11) NOT NULL auto_increment,
  `countries_name` varchar(64) NOT NULL,
  `countries_iso_code_2` char(2) NOT NULL,
  `countries_iso_code_3` char(3) NOT NULL,
  `address_format_id` int(11) NOT NULL,
  PRIMARY KEY  (`countries_id`),
  KEY `IDX_COUNTRIES_NAME` (`countries_name`)
) ENGINE=MyISAM AUTO_INCREMENT=240 DEFAULT CHARSET=latin1 AUTO_INCREMENT=240 ;

-- 
-- Dumping data for table `countries`
-- 

INSERT INTO `countries` (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES (1, 'Afghanistan', 'AF', 'AFG', 1),
(2, 'Albania', 'AL', 'ALB', 1),
(3, 'Algeria', 'DZ', 'DZA', 1),
(4, 'American Samoa', 'AS', 'ASM', 1),
(5, 'Andorra', 'AD', 'AND', 1),
(6, 'Angola', 'AO', 'AGO', 1),
(7, 'Anguilla', 'AI', 'AIA', 1),
(8, 'Antarctica', 'AQ', 'ATA', 1),
(9, 'Antigua and Barbuda', 'AG', 'ATG', 1),
(10, 'Argentina', 'AR', 'ARG', 1),
(11, 'Armenia', 'AM', 'ARM', 1),
(12, 'Aruba', 'AW', 'ABW', 1),
(13, 'Australia', 'AU', 'AUS', 1),
(14, 'Austria', 'AT', 'AUT', 5),
(15, 'Azerbaijan', 'AZ', 'AZE', 1),
(16, 'Bahamas', 'BS', 'BHS', 1),
(17, 'Bahrain', 'BH', 'BHR', 1),
(18, 'Bangladesh', 'BD', 'BGD', 1),
(19, 'Barbados', 'BB', 'BRB', 1),
(20, 'Belarus', 'BY', 'BLR', 1),
(21, 'Belgium', 'BE', 'BEL', 1),
(22, 'Belize', 'BZ', 'BLZ', 1),
(23, 'Benin', 'BJ', 'BEN', 1),
(24, 'Bermuda', 'BM', 'BMU', 1),
(25, 'Bhutan', 'BT', 'BTN', 1),
(26, 'Bolivia', 'BO', 'BOL', 1),
(27, 'Bosnia and Herzegowina', 'BA', 'BIH', 1),
(28, 'Botswana', 'BW', 'BWA', 1),
(29, 'Bouvet Island', 'BV', 'BVT', 1),
(30, 'Brazil', 'BR', 'BRA', 1),
(31, 'British Indian Ocean Territory', 'IO', 'IOT', 1),
(32, 'Brunei Darussalam', 'BN', 'BRN', 1),
(33, 'Bulgaria', 'BG', 'BGR', 1),
(34, 'Burkina Faso', 'BF', 'BFA', 1),
(35, 'Burundi', 'BI', 'BDI', 1),
(36, 'Cambodia', 'KH', 'KHM', 1),
(37, 'Cameroon', 'CM', 'CMR', 1),
(38, 'Canada', 'CA', 'CAN', 1),
(39, 'Cape Verde', 'CV', 'CPV', 1),
(40, 'Cayman Islands', 'KY', 'CYM', 1),
(41, 'Central African Republic', 'CF', 'CAF', 1),
(42, 'Chad', 'TD', 'TCD', 1),
(43, 'Chile', 'CL', 'CHL', 1),
(44, 'China', 'CN', 'CHN', 1),
(45, 'Christmas Island', 'CX', 'CXR', 1),
(46, 'Cocos (Keeling) Islands', 'CC', 'CCK', 1),
(47, 'Colombia', 'CO', 'COL', 1),
(48, 'Comoros', 'KM', 'COM', 1),
(49, 'Congo', 'CG', 'COG', 1),
(50, 'Cook Islands', 'CK', 'COK', 1),
(51, 'Costa Rica', 'CR', 'CRI', 1),
(52, 'Cote D''Ivoire', 'CI', 'CIV', 1),
(53, 'Croatia', 'HR', 'HRV', 1),
(54, 'Cuba', 'CU', 'CUB', 1),
(55, 'Cyprus', 'CY', 'CYP', 1),
(56, 'Czech Republic', 'CZ', 'CZE', 1),
(57, 'Denmark', 'DK', 'DNK', 1),
(58, 'Djibouti', 'DJ', 'DJI', 1),
(59, 'Dominica', 'DM', 'DMA', 1),
(60, 'Dominican Republic', 'DO', 'DOM', 1),
(61, 'East Timor', 'TP', 'TMP', 1),
(62, 'Ecuador', 'EC', 'ECU', 1),
(63, 'Egypt', 'EG', 'EGY', 1),
(64, 'El Salvador', 'SV', 'SLV', 1),
(65, 'Equatorial Guinea', 'GQ', 'GNQ', 1),
(66, 'Eritrea', 'ER', 'ERI', 1),
(67, 'Estonia', 'EE', 'EST', 1),
(68, 'Ethiopia', 'ET', 'ETH', 1),
(69, 'Falkland Islands (Malvinas)', 'FK', 'FLK', 1),
(70, 'Faroe Islands', 'FO', 'FRO', 1),
(71, 'Fiji', 'FJ', 'FJI', 1),
(72, 'Finland', 'FI', 'FIN', 1),
(73, 'France', 'FR', 'FRA', 1),
(74, 'France, Metropolitan', 'FX', 'FXX', 1),
(75, 'French Guiana', 'GF', 'GUF', 1),
(76, 'French Polynesia', 'PF', 'PYF', 1),
(77, 'French Southern Territories', 'TF', 'ATF', 1),
(78, 'Gabon', 'GA', 'GAB', 1),
(79, 'Gambia', 'GM', 'GMB', 1),
(80, 'Georgia', 'GE', 'GEO', 1),
(81, 'Germany', 'DE', 'DEU', 5),
(82, 'Ghana', 'GH', 'GHA', 1),
(83, 'Gibraltar', 'GI', 'GIB', 1),
(84, 'Greece', 'GR', 'GRC', 1),
(85, 'Greenland', 'GL', 'GRL', 1),
(86, 'Grenada', 'GD', 'GRD', 1),
(87, 'Guadeloupe', 'GP', 'GLP', 1),
(88, 'Guam', 'GU', 'GUM', 1),
(89, 'Guatemala', 'GT', 'GTM', 1),
(90, 'Guinea', 'GN', 'GIN', 1),
(91, 'Guinea-bissau', 'GW', 'GNB', 1),
(92, 'Guyana', 'GY', 'GUY', 1),
(93, 'Haiti', 'HT', 'HTI', 1),
(94, 'Heard and Mc Donald Islands', 'HM', 'HMD', 1),
(95, 'Honduras', 'HN', 'HND', 1),
(96, 'Hong Kong', 'HK', 'HKG', 1),
(97, 'Hungary', 'HU', 'HUN', 1),
(98, 'Iceland', 'IS', 'ISL', 1),
(99, 'India', 'IN', 'IND', 1),
(100, 'Indonesia', 'ID', 'IDN', 1),
(101, 'Iran (Islamic Republic of)', 'IR', 'IRN', 1),
(102, 'Iraq', 'IQ', 'IRQ', 1),
(103, 'Ireland', 'IE', 'IRL', 1),
(104, 'Israel', 'IL', 'ISR', 1),
(105, 'Italy', 'IT', 'ITA', 1),
(106, 'Jamaica', 'JM', 'JAM', 1),
(107, 'Japan', 'JP', 'JPN', 1),
(108, 'Jordan', 'JO', 'JOR', 1),
(109, 'Kazakhstan', 'KZ', 'KAZ', 1),
(110, 'Kenya', 'KE', 'KEN', 1),
(111, 'Kiribati', 'KI', 'KIR', 1),
(112, 'Korea, Democratic People''s Republic of', 'KP', 'PRK', 1),
(113, 'Korea, Republic of', 'KR', 'KOR', 1),
(114, 'Kuwait', 'KW', 'KWT', 1),
(115, 'Kyrgyzstan', 'KG', 'KGZ', 1),
(116, 'Lao People''s Democratic Republic', 'LA', 'LAO', 1),
(117, 'Latvia', 'LV', 'LVA', 1),
(118, 'Lebanon', 'LB', 'LBN', 1),
(119, 'Lesotho', 'LS', 'LSO', 1),
(120, 'Liberia', 'LR', 'LBR', 1),
(121, 'Libyan Arab Jamahiriya', 'LY', 'LBY', 1),
(122, 'Liechtenstein', 'LI', 'LIE', 1),
(123, 'Lithuania', 'LT', 'LTU', 1),
(124, 'Luxembourg', 'LU', 'LUX', 1),
(125, 'Macau', 'MO', 'MAC', 1),
(126, 'Macedonia, The Former Yugoslav Republic of', 'MK', 'MKD', 1),
(127, 'Madagascar', 'MG', 'MDG', 1),
(128, 'Malawi', 'MW', 'MWI', 1),
(129, 'Malaysia', 'MY', 'MYS', 1),
(130, 'Maldives', 'MV', 'MDV', 1),
(131, 'Mali', 'ML', 'MLI', 1),
(132, 'Malta', 'MT', 'MLT', 1),
(133, 'Marshall Islands', 'MH', 'MHL', 1),
(134, 'Martinique', 'MQ', 'MTQ', 1),
(135, 'Mauritania', 'MR', 'MRT', 1),
(136, 'Mauritius', 'MU', 'MUS', 1),
(137, 'Mayotte', 'YT', 'MYT', 1),
(138, 'Mexico', 'MX', 'MEX', 1),
(139, 'Micronesia, Federated States of', 'FM', 'FSM', 1),
(140, 'Moldova, Republic of', 'MD', 'MDA', 1),
(141, 'Monaco', 'MC', 'MCO', 1),
(142, 'Mongolia', 'MN', 'MNG', 1),
(143, 'Montserrat', 'MS', 'MSR', 1),
(144, 'Morocco', 'MA', 'MAR', 1),
(145, 'Mozambique', 'MZ', 'MOZ', 1),
(146, 'Myanmar', 'MM', 'MMR', 1),
(147, 'Namibia', 'NA', 'NAM', 1),
(148, 'Nauru', 'NR', 'NRU', 1),
(149, 'Nepal', 'NP', 'NPL', 1),
(150, 'Netherlands', 'NL', 'NLD', 1),
(151, 'Netherlands Antilles', 'AN', 'ANT', 1),
(152, 'New Caledonia', 'NC', 'NCL', 1),
(153, 'New Zealand', 'NZ', 'NZL', 1),
(154, 'Nicaragua', 'NI', 'NIC', 1),
(155, 'Niger', 'NE', 'NER', 1),
(156, 'Nigeria', 'NG', 'NGA', 1),
(157, 'Niue', 'NU', 'NIU', 1),
(158, 'Norfolk Island', 'NF', 'NFK', 1),
(159, 'Northern Mariana Islands', 'MP', 'MNP', 1),
(160, 'Norway', 'NO', 'NOR', 1),
(161, 'Oman', 'OM', 'OMN', 1),
(162, 'Pakistan', 'PK', 'PAK', 1),
(163, 'Palau', 'PW', 'PLW', 1),
(164, 'Panama', 'PA', 'PAN', 1),
(165, 'Papua New Guinea', 'PG', 'PNG', 1),
(166, 'Paraguay', 'PY', 'PRY', 1),
(167, 'Peru', 'PE', 'PER', 1),
(168, 'Philippines', 'PH', 'PHL', 1),
(169, 'Pitcairn', 'PN', 'PCN', 1),
(170, 'Poland', 'PL', 'POL', 1),
(171, 'Portugal', 'PT', 'PRT', 1),
(172, 'Puerto Rico', 'PR', 'PRI', 1),
(173, 'Qatar', 'QA', 'QAT', 1),
(174, 'Reunion', 'RE', 'REU', 1),
(175, 'Romania', 'RO', 'ROM', 1),
(176, 'Russian Federation', 'RU', 'RUS', 1),
(177, 'Rwanda', 'RW', 'RWA', 1),
(178, 'Saint Kitts and Nevis', 'KN', 'KNA', 1),
(179, 'Saint Lucia', 'LC', 'LCA', 1),
(180, 'Saint Vincent and the Grenadines', 'VC', 'VCT', 1),
(181, 'Samoa', 'WS', 'WSM', 1),
(182, 'San Marino', 'SM', 'SMR', 1),
(183, 'Sao Tome and Principe', 'ST', 'STP', 1),
(184, 'Saudi Arabia', 'SA', 'SAU', 1),
(185, 'Senegal', 'SN', 'SEN', 1),
(186, 'Seychelles', 'SC', 'SYC', 1),
(187, 'Sierra Leone', 'SL', 'SLE', 1),
(188, 'Singapore', 'SG', 'SGP', 4),
(189, 'Slovakia (Slovak Republic)', 'SK', 'SVK', 1),
(190, 'Slovenia', 'SI', 'SVN', 1),
(191, 'Solomon Islands', 'SB', 'SLB', 1),
(192, 'Somalia', 'SO', 'SOM', 1),
(193, 'South Africa', 'ZA', 'ZAF', 1),
(194, 'South Georgia and the South Sandwich Islands', 'GS', 'SGS', 1),
(195, 'Spain', 'ES', 'ESP', 3),
(196, 'Sri Lanka', 'LK', 'LKA', 1),
(197, 'St. Helena', 'SH', 'SHN', 1),
(198, 'St. Pierre and Miquelon', 'PM', 'SPM', 1),
(199, 'Sudan', 'SD', 'SDN', 1),
(200, 'Suriname', 'SR', 'SUR', 1),
(201, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM', 1),
(202, 'Swaziland', 'SZ', 'SWZ', 1),
(203, 'Sweden', 'SE', 'SWE', 1),
(204, 'Switzerland', 'CH', 'CHE', 1),
(205, 'Syrian Arab Republic', 'SY', 'SYR', 1),
(206, 'Taiwan', 'TW', 'TWN', 1),
(207, 'Tajikistan', 'TJ', 'TJK', 1),
(208, 'Tanzania, United Republic of', 'TZ', 'TZA', 1),
(209, 'Thailand', 'TH', 'THA', 1),
(210, 'Togo', 'TG', 'TGO', 1),
(211, 'Tokelau', 'TK', 'TKL', 1),
(212, 'Tonga', 'TO', 'TON', 1),
(213, 'Trinidad and Tobago', 'TT', 'TTO', 1),
(214, 'Tunisia', 'TN', 'TUN', 1),
(215, 'Turkey', 'TR', 'TUR', 1),
(216, 'Turkmenistan', 'TM', 'TKM', 1),
(217, 'Turks and Caicos Islands', 'TC', 'TCA', 1),
(218, 'Tuvalu', 'TV', 'TUV', 1),
(219, 'Uganda', 'UG', 'UGA', 1),
(220, 'Ukraine', 'UA', 'UKR', 1),
(221, 'United Arab Emirates', 'AE', 'ARE', 1),
(222, 'United Kingdom', 'GB', 'GBR', 1),
(223, 'United States', 'US', 'USA', 2),
(224, 'United States Minor Outlying Islands', 'UM', 'UMI', 1),
(225, 'Uruguay', 'UY', 'URY', 1),
(226, 'Uzbekistan', 'UZ', 'UZB', 1),
(227, 'Vanuatu', 'VU', 'VUT', 1),
(228, 'Vatican City State (Holy See)', 'VA', 'VAT', 1),
(229, 'Venezuela', 'VE', 'VEN', 1),
(230, 'Viet Nam', 'VN', 'VNM', 1),
(231, 'Virgin Islands (British)', 'VG', 'VGB', 1),
(232, 'Virgin Islands (U.S.)', 'VI', 'VIR', 1),
(233, 'Wallis and Futuna Islands', 'WF', 'WLF', 1),
(234, 'Western Sahara', 'EH', 'ESH', 1),
(235, 'Yemen', 'YE', 'YEM', 1),
(236, 'Yugoslavia', 'YU', 'YUG', 1),
(237, 'Zaire', 'ZR', 'ZAR', 1),
(238, 'Zambia', 'ZM', 'ZMB', 1),
(239, 'Zimbabwe', 'ZW', 'ZWE', 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `currencies`
-- 

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE IF NOT EXISTS `currencies` (
  `currencies_id` int(11) NOT NULL auto_increment,
  `title` varchar(32) NOT NULL,
  `code` char(3) NOT NULL,
  `symbol_left` varchar(12) default NULL,
  `symbol_right` varchar(12) default NULL,
  `decimal_point` char(1) default NULL,
  `thousands_point` char(1) default NULL,
  `decimal_places` char(1) default NULL,
  `value` float(13,8) default NULL,
  `last_updated` datetime default NULL,
  PRIMARY KEY  (`currencies_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `currencies`
-- 

INSERT INTO `currencies` (`currencies_id`, `title`, `code`, `symbol_left`, `symbol_right`, `decimal_point`, `thousands_point`, `decimal_places`, `value`, `last_updated`) VALUES (1, 'US Dollar', 'USD', '$', '', '.', ',', '2', 1.00000000, '2006-09-16 21:36:17');

-- --------------------------------------------------------

-- 
-- Table structure for table `customers`
-- 

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `customers_id` int(11) NOT NULL auto_increment,
  `customers_gender` char(1) NOT NULL,
  `customers_firstname` varchar(32) NOT NULL,
  `customers_lastname` varchar(32) NOT NULL,
  `customers_dob` datetime NOT NULL default '0000-00-00 00:00:00',
  `customers_email_address` varchar(96) NOT NULL,
  `customers_default_address_id` int(11) default NULL,
  `customers_telephone` varchar(32) NOT NULL,
  `customers_fax` varchar(32) default NULL,
  `customers_password` varchar(40) NOT NULL,
  `customers_newsletter` char(1) default NULL,
  PRIMARY KEY  (`customers_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

-- 
-- Dumping data for table `customers`
-- 

INSERT INTO `customers` (`customers_id`, `customers_gender`, `customers_firstname`, `customers_lastname`, `customers_dob`, `customers_email_address`, `customers_default_address_id`, `customers_telephone`, `customers_fax`, `customers_password`, `customers_newsletter`) VALUES (1, 'm', 'Jane', 'Waters', '2001-01-01 00:00:00', 'amengifts@aol.com', 1, '12345', '', 'd95e8fa7f20a009372eb3477473fcd34:1c', '0'),
(2, '', 'Ben', 'Herila', '1989-09-14 00:00:00', 'bherila@bherila.net', 2, '908-604-2379', '', '60bfe6f52af2399a2bff733e563e3aa5:5c', ''),
(3, '', 'Donna', 'Haiback', '1967-02-24 00:00:00', 'dhaiback@aol.com', 3, '908-630-9530', '908-766-3366', 'c83774bec1eaa0f03ed89f71056ddb87:72', '1'),
(4, '', 'CAREN', 'BUCHALTER', '1970-12-05 00:00:00', 'carenDBI@optonline.net', 4, '732-547-4003', '', '09f2f1733b3d3ddd0ca7c9f6ad0dc1ea:db', ''),
(5, '', 'Sheila', 'Hitt', '1952-10-16 00:00:00', 'sheilahitt@cox.net', 5, '479-936-8310', '', 'b5ca4b212fdd3d3099b007408b477375:6c', '0'),
(8, '', 'PAM', 'STEVENS', '1960-09-09 00:00:00', 'YESEMAIL@AOL.COM', 10, '404-915-6159', '', '826eafc81d1ec507b6a7dcef7ba54e45:92', '0'),
(7, '', 'KIYOMI OTA', 'BAIRD', '1970-05-21 00:00:00', 'NOEMAIL@AOL.COM', 8, '908-719-8825', '', '85e10cef5ed7b2c9c9091ec834dd546f:8b', ''),
(9, '', 'BETTY', 'PEACOCK', '0000-00-00 00:00:00', 'NONE4ME@AOL.COM', 12, '703-437-6090', '', 'ad1849bb59297910d388fe5ca72f89c2:e9', ''),
(10, '', 'SUE', 'BETHKEY', '0000-00-00 00:00:00', 'suebethkey@comcast.net', 13, '703-437-5582', '', '4d75eabe2478fe60515f1b9eab901244:81', '1'),
(12, '', 'KATHY', 'PAGLIUCA', '0000-00-00 00:00:00', 'kkelly@ucpnyc.org', 16, '917-816-3572', '', 'aba9be9eeccee585e3e41e6ca72fb443:a9', '1');

-- --------------------------------------------------------

-- 
-- Table structure for table `customers_basket`
-- 

DROP TABLE IF EXISTS `customers_basket`;
CREATE TABLE IF NOT EXISTS `customers_basket` (
  `customers_basket_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `products_id` tinytext NOT NULL,
  `customers_basket_quantity` int(2) NOT NULL,
  `final_price` decimal(15,4) default NULL,
  `customers_basket_date_added` char(8) default NULL,
  PRIMARY KEY  (`customers_basket_id`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=latin1 AUTO_INCREMENT=100 ;

-- 
-- Dumping data for table `customers_basket`
-- 

INSERT INTO `customers_basket` (`customers_basket_id`, `customers_id`, `products_id`, `customers_basket_quantity`, `final_price`, `customers_basket_date_added`) VALUES (31, 4, '65{1}20', 1, NULL, '20061006'),
(42, 7, '98', 1, NULL, '20061011'),
(60, 9, '71{1}21', 2, NULL, '20061102'),
(53, 9, '65{1}20', 1, NULL, '20061102');

-- --------------------------------------------------------

-- 
-- Table structure for table `customers_basket_attributes`
-- 

DROP TABLE IF EXISTS `customers_basket_attributes`;
CREATE TABLE IF NOT EXISTS `customers_basket_attributes` (
  `customers_basket_attributes_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `products_id` tinytext NOT NULL,
  `products_options_id` int(11) NOT NULL,
  `products_options_value_id` int(11) NOT NULL,
  PRIMARY KEY  (`customers_basket_attributes_id`)
) ENGINE=MyISAM AUTO_INCREMENT=89 DEFAULT CHARSET=latin1 AUTO_INCREMENT=89 ;

-- 
-- Dumping data for table `customers_basket_attributes`
-- 

INSERT INTO `customers_basket_attributes` (`customers_basket_attributes_id`, `customers_id`, `products_id`, `products_options_id`, `products_options_value_id`) VALUES (27, 4, '65{1}20', 1, 20),
(54, 9, '71{1}21', 1, 21),
(47, 9, '65{1}20', 1, 20);

-- --------------------------------------------------------

-- 
-- Table structure for table `customers_info`
-- 

DROP TABLE IF EXISTS `customers_info`;
CREATE TABLE IF NOT EXISTS `customers_info` (
  `customers_info_id` int(11) NOT NULL,
  `customers_info_date_of_last_logon` datetime default NULL,
  `customers_info_number_of_logons` int(5) default NULL,
  `customers_info_date_account_created` datetime default NULL,
  `customers_info_date_account_last_modified` datetime default NULL,
  `global_product_notifications` int(1) default '0',
  PRIMARY KEY  (`customers_info_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `customers_info`
-- 

INSERT INTO `customers_info` (`customers_info_id`, `customers_info_date_of_last_logon`, `customers_info_number_of_logons`, `customers_info_date_account_created`, `customers_info_date_account_last_modified`, `global_product_notifications`) VALUES (1, NULL, 0, '2006-09-16 21:36:17', '2006-10-11 22:22:15', 0),
(2, '2006-11-12 18:21:21', 5, '2006-09-17 00:39:38', NULL, 0),
(3, NULL, 0, '2006-10-05 15:06:48', '2006-10-11 22:22:37', 0),
(4, NULL, 0, '2006-10-06 15:19:38', NULL, 0),
(5, NULL, 0, '2006-10-07 19:00:22', '2006-10-11 22:21:52', 0),
(7, NULL, 0, '2006-10-11 22:47:36', NULL, 0),
(8, '2006-10-18 16:58:31', 1, '2006-10-16 14:59:54', '2006-10-18 16:56:42', 0),
(9, '2006-11-13 17:13:12', 2, '2006-11-02 17:19:14', NULL, 0),
(10, NULL, 0, '2006-11-20 20:18:04', NULL, 0),
(12, '2006-12-09 00:15:07', 1, '2006-12-06 14:29:32', '2006-12-06 14:52:08', 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `geo_zones`
-- 

DROP TABLE IF EXISTS `geo_zones`;
CREATE TABLE IF NOT EXISTS `geo_zones` (
  `geo_zone_id` int(11) NOT NULL auto_increment,
  `geo_zone_name` varchar(32) NOT NULL,
  `geo_zone_description` varchar(255) NOT NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`geo_zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table `geo_zones`
-- 

INSERT INTO `geo_zones` (`geo_zone_id`, `geo_zone_name`, `geo_zone_description`, `last_modified`, `date_added`) VALUES (2, 'New Jersey', 'NJ Local Sales Tax', NULL, '2006-09-16 22:03:53');

-- --------------------------------------------------------

-- 
-- Table structure for table `languages`
-- 

DROP TABLE IF EXISTS `languages`;
CREATE TABLE IF NOT EXISTS `languages` (
  `languages_id` int(11) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `code` char(2) NOT NULL,
  `image` varchar(64) default NULL,
  `directory` varchar(32) default NULL,
  `sort_order` int(3) default NULL,
  PRIMARY KEY  (`languages_id`),
  KEY `IDX_LANGUAGES_NAME` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `languages`
-- 

INSERT INTO `languages` (`languages_id`, `name`, `code`, `image`, `directory`, `sort_order`) VALUES (1, 'English', 'en', 'icon.gif', 'english', 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `manufacturers`
-- 

DROP TABLE IF EXISTS `manufacturers`;
CREATE TABLE IF NOT EXISTS `manufacturers` (
  `manufacturers_id` int(11) NOT NULL auto_increment,
  `manufacturers_name` varchar(32) NOT NULL,
  `manufacturers_image` varchar(64) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`manufacturers_id`),
  KEY `IDX_MANUFACTURERS_NAME` (`manufacturers_name`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

-- 
-- Dumping data for table `manufacturers`
-- 

INSERT INTO `manufacturers` (`manufacturers_id`, `manufacturers_name`, `manufacturers_image`, `date_added`, `last_modified`) VALUES (10, 'Match', '', '2006-09-16 22:28:09', NULL),
(11, 'Authentic Models', 'AM.jpg', '2006-09-16 23:38:30', '2006-09-16 23:39:08'),
(12, 'Carrol Boyes', 'boyes.gif', '2006-09-17 00:32:45', '2006-09-17 00:33:45'),
(13, 'Casafina', 'casafina.jpg', '2006-09-17 01:06:16', NULL),
(14, 'Robert Gordon', '', '2006-09-17 03:36:13', NULL),
(15, 'AMEN Exclusive', '', '2006-09-29 21:58:49', '2006-09-29 21:58:54'),
(16, 'Arte Italica', '', '2006-10-02 21:25:54', NULL),
(17, 'Vietri', '', '2006-10-02 21:40:36', NULL),
(18, 'Intrada', '', '2006-10-28 20:10:57', NULL),
(19, 'Urban Tin', '', '2006-10-28 20:16:53', '2006-10-28 20:17:05');

-- --------------------------------------------------------

-- 
-- Table structure for table `manufacturers_info`
-- 

DROP TABLE IF EXISTS `manufacturers_info`;
CREATE TABLE IF NOT EXISTS `manufacturers_info` (
  `manufacturers_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `manufacturers_url` varchar(255) NOT NULL,
  `url_clicked` int(5) NOT NULL default '0',
  `date_last_click` datetime default NULL,
  PRIMARY KEY  (`manufacturers_id`,`languages_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `manufacturers_info`
-- 

INSERT INTO `manufacturers_info` (`manufacturers_id`, `languages_id`, `manufacturers_url`, `url_clicked`, `date_last_click`) VALUES (10, 1, '', 0, NULL),
(11, 1, '', 0, NULL),
(12, 1, '', 0, NULL),
(13, 1, '', 0, NULL),
(14, 1, '', 0, NULL),
(15, 1, '', 0, NULL),
(16, 1, '', 0, NULL),
(17, 1, '', 0, NULL),
(18, 1, '', 0, NULL),
(19, 1, '', 0, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `newsletters`
-- 

DROP TABLE IF EXISTS `newsletters`;
CREATE TABLE IF NOT EXISTS `newsletters` (
  `newsletters_id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `module` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_sent` datetime default NULL,
  `status` int(1) default NULL,
  `locked` int(1) default '0',
  PRIMARY KEY  (`newsletters_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `newsletters`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `orders`
-- 

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `orders_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `customers_name` varchar(64) NOT NULL,
  `customers_company` varchar(32) default NULL,
  `customers_street_address` varchar(64) NOT NULL,
  `customers_suburb` varchar(32) default NULL,
  `customers_city` varchar(32) NOT NULL,
  `customers_postcode` varchar(10) NOT NULL,
  `customers_state` varchar(32) default NULL,
  `customers_country` varchar(32) NOT NULL,
  `customers_telephone` varchar(32) NOT NULL,
  `customers_email_address` varchar(96) NOT NULL,
  `customers_address_format_id` int(5) NOT NULL,
  `delivery_name` varchar(64) NOT NULL,
  `delivery_company` varchar(32) default NULL,
  `delivery_street_address` varchar(64) NOT NULL,
  `delivery_suburb` varchar(32) default NULL,
  `delivery_city` varchar(32) NOT NULL,
  `delivery_postcode` varchar(10) NOT NULL,
  `delivery_state` varchar(32) default NULL,
  `delivery_country` varchar(32) NOT NULL,
  `delivery_address_format_id` int(5) NOT NULL,
  `billing_name` varchar(64) NOT NULL,
  `billing_company` varchar(32) default NULL,
  `billing_street_address` varchar(64) NOT NULL,
  `billing_suburb` varchar(32) default NULL,
  `billing_city` varchar(32) NOT NULL,
  `billing_postcode` varchar(10) NOT NULL,
  `billing_state` varchar(32) default NULL,
  `billing_country` varchar(32) NOT NULL,
  `billing_address_format_id` int(5) NOT NULL,
  `payment_method` varchar(32) NOT NULL,
  `cc_type` varchar(20) default NULL,
  `cc_owner` varchar(64) default NULL,
  `cc_number` varchar(32) default NULL,
  `cc_expires` varchar(4) default NULL,
  `last_modified` datetime default NULL,
  `date_purchased` datetime default NULL,
  `orders_status` int(5) NOT NULL,
  `orders_date_finished` datetime default NULL,
  `currency` char(3) default NULL,
  `currency_value` decimal(14,6) default NULL,
  `ip_address` varchar(50) NOT NULL,
  PRIMARY KEY  (`orders_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- 
-- Dumping data for table `orders`
-- 

INSERT INTO `orders` (`orders_id`, `customers_id`, `customers_name`, `customers_company`, `customers_street_address`, `customers_suburb`, `customers_city`, `customers_postcode`, `customers_state`, `customers_country`, `customers_telephone`, `customers_email_address`, `customers_address_format_id`, `delivery_name`, `delivery_company`, `delivery_street_address`, `delivery_suburb`, `delivery_city`, `delivery_postcode`, `delivery_state`, `delivery_country`, `delivery_address_format_id`, `billing_name`, `billing_company`, `billing_street_address`, `billing_suburb`, `billing_city`, `billing_postcode`, `billing_state`, `billing_country`, `billing_address_format_id`, `payment_method`, `cc_type`, `cc_owner`, `cc_number`, `cc_expires`, `last_modified`, `date_purchased`, `orders_status`, `orders_date_finished`, `currency`, `currency_value`, `ip_address`) VALUES (2, 8, 'PAM STEVENS', '', '131 DUDLEY STREET', '', 'JERSEY CITY', '07302', 'New Jersey', 'United States', '404-915-6159', 'YESEMAIL@AOL.COM', 2, 'WINNIE STEIN', '', '1114 HUDSON ST. #4', '', 'HOBOKEN', '07030', 'New Jersey', 'United States', 2, 'PAM STEVENS', '', '131 DUDLEY STREET', '', 'JERSEY CITY', '07302', 'New Jersey', 'United States', 2, 'PayPal', '', '', '', '', NULL, '2006-10-18 17:15:30', 1, NULL, 'USD', '1.000000', ''),
(3, 2, 'Ben Herila', '', '38 Old Coach Rd.', '', 'Basking Ridge', '07920', 'New Jersey', 'United States', '908-604-2379', 'bherila@bherila.net', 2, 'Ben Herila', '', '38 Old Coach Rd.', '', 'Basking Ridge', '07920', 'New Jersey', 'United States', 2, 'Ben Herila', '', '38 Old Coach Rd.', '', 'Basking Ridge', '07920', 'New Jersey', 'United States', 2, 'Check/Money Order', '', '', '', '', NULL, '2006-11-12 18:22:08', 1, NULL, 'USD', '1.000000', ''),
(4, 10, 'SUE BETHKEY', '', '1308 Deep Run Lane', '', 'RESTON', '20190', 'Virginia', 'United States', '703-437-5582', 'suebethkey@comcast.net', 2, 'WINNIE & MATT STEIN-PEACOCK', '', '1114 HUDSON ST. #4', '', 'HOBOKEN', '07030', 'New Jersey', 'United States', 2, 'SUE BETHKEY', '', '1308 Deep Run Lane', '', 'RESTON', '20190', 'Virginia', 'United States', 2, 'PayPal', '', '', '', '', NULL, '2006-11-20 20:41:22', 1, NULL, 'USD', '1.000000', ''),
(5, 12, 'KATHY PAGLIUCA', '', '2059 TENBROECK AVENUE', '', 'BRONX', '10461', 'New York', 'United States', '917-816-3572', 'kkelly@ucpnyc.org', 2, 'KATHY PAGLIUCA', '', '2059 TENBROECK AVENUE', '', 'BRONX', '10461', 'New York', 'United States', 2, 'KATHY PAGLIUCA', '', '2059 TENBROECK AVENUE', '', 'BRONX', '10461', 'New York', 'United States', 2, 'PayPal', '', '', '', '', NULL, '2006-12-09 00:17:52', 1, NULL, 'USD', '1.000000', '');

-- --------------------------------------------------------

-- 
-- Table structure for table `orders_products`
-- 

DROP TABLE IF EXISTS `orders_products`;
CREATE TABLE IF NOT EXISTS `orders_products` (
  `orders_products_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(12) default NULL,
  `products_name` varchar(64) NOT NULL,
  `products_price` decimal(15,4) NOT NULL,
  `final_price` decimal(15,4) NOT NULL,
  `products_tax` decimal(7,4) NOT NULL,
  `products_quantity` int(2) NOT NULL,
  `registry_products_id` int(11) default NULL,
  `registry_products_customers_id` int(13) default NULL,
  PRIMARY KEY  (`orders_products_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- 
-- Dumping data for table `orders_products`
-- 

INSERT INTO `orders_products` (`orders_products_id`, `orders_id`, `products_id`, `products_model`, `products_name`, `products_price`, `final_price`, `products_tax`, `products_quantity`, `registry_products_id`, `registry_products_customers_id`) VALUES (2, 2, 67, 'MH003', 'Madeira Harvest 7" Soup & Cereal Bowl', '95.0000', '95.0000', '7.0000', 1, NULL, NULL),
(3, 2, 120, '', 'Madiera Harvest Rectangular Tray', '70.0000', '70.0000', '7.0000', 1, NULL, NULL),
(4, 2, 121, '', 'Madiera Harvest Oval Platter [16x12½"]', '50.0000', '50.0000', '7.0000', 1, NULL, NULL),
(5, 3, 28, '', 'Glass Vessel', '995.0000', '995.0000', '7.0000', 1, NULL, NULL),
(6, 3, 144, 'V-EAGLE', 'The American Eagle', '395.0000', '395.0000', '7.0000', 1, NULL, NULL),
(7, 4, 72, 'MH009', 'Madeira Harvest Pitcher', '45.0000', '45.0000', '7.0000', 1, NULL, NULL),
(8, 5, 148, '', 'TERRE DI CHIANTI', '330.0000', '330.0000', '7.0000', 1, NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `orders_products_attributes`
-- 

DROP TABLE IF EXISTS `orders_products_attributes`;
CREATE TABLE IF NOT EXISTS `orders_products_attributes` (
  `orders_products_attributes_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `orders_products_id` int(11) NOT NULL,
  `products_options` varchar(32) NOT NULL,
  `products_options_values` varchar(32) NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) NOT NULL,
  PRIMARY KEY  (`orders_products_attributes_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- 
-- Dumping data for table `orders_products_attributes`
-- 

INSERT INTO `orders_products_attributes` (`orders_products_attributes_id`, `orders_id`, `orders_products_id`, `products_options`, `products_options_values`, `options_values_price`, `price_prefix`) VALUES (1, 2, 2, 'Color', 'Dijon Gold', '0.0000', '+'),
(2, 2, 3, 'Color', 'Robin''s Egg Blue', '0.0000', '+'),
(3, 2, 4, 'Color', 'Robin''s Egg Blue', '0.0000', '+'),
(4, 4, 7, 'Color', 'Dijon Gold', '0.0000', '+');

-- --------------------------------------------------------

-- 
-- Table structure for table `orders_products_download`
-- 

DROP TABLE IF EXISTS `orders_products_download`;
CREATE TABLE IF NOT EXISTS `orders_products_download` (
  `orders_products_download_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL default '0',
  `orders_products_id` int(11) NOT NULL default '0',
  `orders_products_filename` varchar(255) NOT NULL,
  `download_maxdays` int(2) NOT NULL default '0',
  `download_count` int(2) NOT NULL default '0',
  PRIMARY KEY  (`orders_products_download_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `orders_products_download`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `orders_status`
-- 

DROP TABLE IF EXISTS `orders_status`;
CREATE TABLE IF NOT EXISTS `orders_status` (
  `orders_status_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `orders_status_name` varchar(32) NOT NULL,
  PRIMARY KEY  (`orders_status_id`,`language_id`),
  KEY `idx_orders_status_name` (`orders_status_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `orders_status`
-- 

INSERT INTO `orders_status` (`orders_status_id`, `language_id`, `orders_status_name`) VALUES (1, 1, 'Pending'),
(2, 1, 'Processing'),
(3, 1, 'Delivered');

-- --------------------------------------------------------

-- 
-- Table structure for table `orders_status_history`
-- 

DROP TABLE IF EXISTS `orders_status_history`;
CREATE TABLE IF NOT EXISTS `orders_status_history` (
  `orders_status_history_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `orders_status_id` int(5) NOT NULL,
  `date_added` datetime NOT NULL,
  `customer_notified` int(1) default '0',
  `comments` text,
  PRIMARY KEY  (`orders_status_history_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

-- 
-- Dumping data for table `orders_status_history`
-- 

INSERT INTO `orders_status_history` (`orders_status_history_id`, `orders_id`, `orders_status_id`, `date_added`, `customer_notified`, `comments`) VALUES (4, 2, 1, '2006-10-18 17:15:30', 1, 'WRAP AS WEDDING GIFTS\r\n CARD :WITH LOVE & BEST WISHES,PAM'),
(5, 3, 1, '2006-11-12 18:22:08', 1, 'This is a TEST ORDER!!!'),
(6, 4, 1, '2006-11-20 20:41:22', 1, 'CONGRATULATIONS AND BEST WISHES!!!!!\r\n\r\n FROM SUE AND CHET BETHKEY'),
(7, 5, 1, '2006-12-09 00:17:52', 1, '');

-- --------------------------------------------------------

-- 
-- Table structure for table `orders_total`
-- 

DROP TABLE IF EXISTS `orders_total`;
CREATE TABLE IF NOT EXISTS `orders_total` (
  `orders_total_id` int(10) unsigned NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  `value` decimal(15,4) NOT NULL,
  `class` varchar(32) NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY  (`orders_total_id`),
  KEY `idx_orders_total_orders_id` (`orders_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

-- 
-- Dumping data for table `orders_total`
-- 

INSERT INTO `orders_total` (`orders_total_id`, `orders_id`, `title`, `text`, `value`, `class`, `sort_order`) VALUES (7, 2, 'Per Item (Best Way):', '$59.00', '59.0000', 'ot_shipping', 2),
(6, 2, 'NJ TAX 7.0%:', '$15.05', '15.0500', 'ot_tax', 3),
(5, 2, 'Sub-Total:', '$215.00', '215.0000', 'ot_subtotal', 1),
(8, 2, 'Total:', '<b>$293.18</b>', '293.1800', 'ot_total', 4),
(9, 3, 'Sub-Total:', '$1,390.00', '1390.0000', 'ot_subtotal', 1),
(10, 3, 'NJ TAX 7.0%:', '$97.30', '97.3000', 'ot_tax', 3),
(11, 3, 'Local Pick-Up (Bernardsville, NJ):', '$0.00', '0.0000', 'ot_shipping', 2),
(12, 3, 'Total:', '<b>$1,487.30</b>', '1487.3000', 'ot_total', 4),
(13, 4, 'Sub-Total:', '$45.00', '45.0000', 'ot_subtotal', 1),
(14, 4, 'NJ TAX 7.0%:', '$3.15', '3.1500', 'ot_tax', 3),
(15, 4, 'Table Rate (Best Way):', '$17.50', '17.5000', 'ot_shipping', 2),
(16, 4, 'Total:', '<b>$65.65</b>', '65.6500', 'ot_total', 4),
(17, 5, 'Sub-Total:', '$330.00', '330.0000', 'ot_subtotal', 1),
(18, 5, 'NJ TAX 7.0%:', '$23.10', '23.1000', 'ot_tax', 3),
(19, 5, 'Local Pick-Up (Bernardsville, NJ):', '$0.00', '0.0000', 'ot_shipping', 2),
(20, 5, 'Total:', '<b>$353.10</b>', '353.1000', 'ot_total', 4);

-- --------------------------------------------------------

-- 
-- Table structure for table `products`
-- 

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `products_id` int(11) NOT NULL auto_increment,
  `products_quantity` int(4) NOT NULL,
  `products_model` varchar(12) default NULL,
  `products_image` varchar(64) default NULL,
  `products_price` decimal(15,4) NOT NULL,
  `products_date_added` datetime NOT NULL,
  `products_last_modified` datetime default NULL,
  `products_date_available` datetime default NULL,
  `products_weight` decimal(5,2) NOT NULL,
  `products_status` tinyint(1) NOT NULL,
  `products_tax_class_id` int(11) NOT NULL,
  `manufacturers_id` int(11) default NULL,
  `products_ordered` int(11) NOT NULL default '0',
  `products_master` varchar(50) NOT NULL default '0',
  `products_master_status` tinyint(2) NOT NULL default '0',
  `products_listing_status` tinyint(2) NOT NULL default '1',
  PRIMARY KEY  (`products_id`),
  KEY `idx_products_date_added` (`products_date_added`)
) ENGINE=MyISAM AUTO_INCREMENT=149 DEFAULT CHARSET=latin1 AUTO_INCREMENT=149 ;

-- 
-- Dumping data for table `products`
-- 

INSERT INTO `products` (`products_id`, `products_quantity`, `products_model`, `products_image`, `products_price`, `products_date_added`, `products_last_modified`, `products_date_available`, `products_weight`, `products_status`, `products_tax_class_id`, `manufacturers_id`, `products_ordered`, `products_master`, `products_master_status`, `products_listing_status`) VALUES (58, 9999, '', 'cheeseknife.jpg', '45.0000', '2006-09-17 00:37:26', NULL, NULL, '0.00', 1, 1, 12, 0, '0', 0, 1),
(57, 9999, '', 'nutcracker.jpg', '72.0000', '2006-09-17 00:35:33', '2006-09-17 00:53:28', NULL, '0.00', 1, 1, 12, 0, '0', 0, 1),
(56, 9999, '', 'candles.jpg', '210.0000', '2006-09-17 00:28:41', '2006-09-29 20:54:48', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(55, 9999, 'HHWB001', 'CIMG0936.jpg', '345.0000', '2006-09-17 00:27:37', '2006-09-29 22:02:54', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(45, 9999, 'TM103', 'baseball.jpg', '92.0000', '2006-09-16 23:41:09', '2006-09-16 23:41:22', NULL, '0.00', 1, 1, 11, 0, '0', 0, 1),
(46, 9999, 'TM112', 'magician.jpg', '99.0000', '2006-09-16 23:42:34', NULL, NULL, '0.00', 1, 1, 11, 0, '0', 0, 1),
(47, 9999, 'TM053', 'santa.jpg', '92.0000', '2006-09-17 00:01:25', NULL, NULL, '0.00', 1, 1, 11, 0, '0', 0, 1),
(48, 9999, '', 'fisherman.jpg', '92.0000', '2006-09-17 00:02:12', '2006-10-02 21:21:22', NULL, '0.00', 1, 1, 11, 0, '0', 0, 1),
(49, 9999, '', '1.jpg', '265.0000', '2006-09-17 00:05:02', '2006-10-12 17:33:41', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(50, 9999, '', 'CIMG0706.jpg', '210.0000', '2006-09-17 00:09:07', '2006-10-16 15:31:33', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(52, 9999, '', 'CIMG0738.jpg', '85.0000', '2006-09-17 00:19:54', NULL, NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(53, 9999, 'SHERF', 'CIMG0457.jpg', '225.0000', '2006-09-17 00:21:49', '2006-11-12 17:52:30', NULL, '4.00', 1, 1, 0, 0, '0', 0, 1),
(88, 9999, '', 'CIMG0865.JPG', '92.0000', '2006-10-02 21:14:14', NULL, NULL, '6.00', 1, 1, 11, 0, '', 0, 1),
(28, 9999, '', '3.jpg', '995.0000', '2006-09-16 22:01:40', '2006-09-16 22:09:20', NULL, '10.00', 1, 1, 0, 1, '0', 0, 1),
(29, 9999, '', 'leaf.jpg', '1500.0000', '2006-09-16 22:05:06', '2006-09-16 22:09:36', NULL, '10.00', 1, 1, 0, 0, '0', 0, 1),
(30, 9999, '', 'CIMG0926.JPG', '1100.0000', '2006-09-16 22:08:17', '2006-10-28 19:55:59', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(31, 9999, '', '2.jpg', '295.0000', '2006-09-16 22:14:07', '2006-09-16 22:15:12', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(32, 9999, '', '4.jpg', '295.0000', '2006-09-16 22:16:16', '2006-09-16 22:23:57', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(33, 9999, '', 'AMEN 4-15-06 008.jpg', '325.0000', '2006-09-16 22:21:13', '2006-10-02 22:25:06', NULL, '0.00', 1, 1, 0, 0, '118', 0, 1),
(34, 9999, '', 'aosubd.jpg', '265.0000', '2006-09-16 22:23:44', NULL, NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(35, 9999, '', 'plate.jpg', '65.0000', '2006-09-16 22:25:35', NULL, NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(37, 9999, '', 'cookies.jpg', '195.0000', '2006-09-16 22:29:16', NULL, NULL, '0.00', 1, 1, 10, 0, '0', 0, 1),
(38, 9999, '', 'horses.jpg', '225.0000', '2006-09-16 22:30:32', '2006-09-16 22:30:47', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(39, 9999, '', 'tureen.jpg', '285.0000', '2006-09-16 22:33:21', NULL, NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(40, 9999, '', 'tdc504.jpg', '525.0000', '2006-09-16 22:39:37', NULL, NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(41, 9999, '', 'spaltedboards.jpg', '75.0000', '2006-09-16 22:44:08', '2006-09-29 22:02:37', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(42, 9999, '', 'fruit.jpg', '79.0000', '2006-09-16 22:50:59', '2006-09-29 22:03:19', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(43, 9999, '', 'tape.jpg', '115.0000', '2006-09-16 23:36:15', NULL, NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(44, 9999, '', 'angel_fame.jpg', '250.0000', '2006-09-16 23:39:49', NULL, NULL, '0.00', 1, 1, 11, 0, '0', 0, 1),
(59, 9999, '', 'tissuebox.jpg', '79.0000', '2006-09-17 00:46:27', '2006-09-29 22:02:44', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(60, 9999, '', 'papertowelholder.jpg', '245.0000', '2006-09-17 00:47:31', NULL, NULL, '0.00', 1, 1, 12, 0, '0', 0, 1),
(61, 9999, '', 'pieserver.jpg', '75.0000', '2006-09-17 00:51:54', NULL, NULL, '0.00', 1, 1, 12, 0, '0', 0, 1),
(62, 9999, '', 'saladservers.jpg', '125.0000', '2006-09-17 00:53:08', '2006-10-01 02:09:25', NULL, '0.00', 1, 1, 12, 0, '0', 0, 1),
(63, 9999, '2034TA', 'CIMG0650.jpg', '785.0000', '2006-09-17 00:55:02', '2006-09-17 00:55:45', NULL, '0.00', 1, 1, 0, 0, '0', 0, 1),
(64, 9999, '', 'COVER-lo.jpg', '0.0000', '2006-09-17 01:10:32', '2006-09-17 03:07:33', NULL, '0.00', 1, 1, 13, 0, '0', 1, 1),
(65, 9999, 'MH001', NULL, '99.0000', '2006-09-17 02:18:16', '2006-09-17 03:09:14', NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(66, 9999, 'MH002', NULL, '78.0000', '2006-09-17 02:24:37', '2006-09-17 03:09:25', NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(67, 9999, 'MH003', NULL, '95.0000', '2006-09-17 02:26:53', '2006-09-17 03:09:38', NULL, '0.00', 1, 1, 0, 1, '64', 0, 0),
(68, 9999, 'MH004', NULL, '42.0000', '2006-09-17 02:28:06', '2006-09-17 03:10:01', NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(69, 9999, 'MH005', NULL, '69.0000', '2006-09-17 02:28:47', '2006-09-17 02:29:41', NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(70, 9999, 'MH006', NULL, '155.0000', '2006-09-17 02:38:44', NULL, NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(71, 9999, 'MH008', NULL, '30.0000', '2006-09-17 03:13:22', NULL, NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(72, 9999, 'MH009', NULL, '45.0000', '2006-09-17 03:14:22', NULL, NULL, '0.00', 1, 1, 0, 1, '64', 0, 0),
(73, 9999, 'MH007', NULL, '49.0000', '2006-09-17 03:14:52', NULL, NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(74, 9999, 'MH010', NULL, '35.0000', '2006-09-17 03:15:48', NULL, NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(75, 9999, '', 'roostercollage.jpg', '0.0000', '2006-09-17 03:38:07', NULL, NULL, '0.00', 1, 1, 14, 0, '0', 1, 1),
(76, 9999, 'RG001', NULL, '95.0000', '2006-09-17 03:39:20', NULL, NULL, '0.00', 1, 1, 0, 0, '75', 0, 0),
(77, 9999, 'RG002', NULL, '25.0000', '2006-09-17 03:40:22', NULL, NULL, '0.00', 1, 1, 0, 0, '75', 0, 0),
(78, 9999, 'RG003', NULL, '125.0000', '2006-09-17 03:41:13', NULL, NULL, '0.00', 1, 1, 0, 0, '75', 0, 0),
(79, 9999, 'RG004', NULL, '120.0000', '2006-09-17 03:41:59', NULL, NULL, '0.00', 1, 1, 0, 0, '75', 0, 0),
(80, 9999, 'RG005', NULL, '90.0000', '2006-09-17 03:42:34', NULL, NULL, '0.00', 1, 1, 0, 0, '75', 0, 0),
(81, 9999, 'RG006', NULL, '95.0000', '2006-09-17 03:43:07', '2006-10-02 20:17:19', NULL, '0.00', 1, 1, 0, 0, '75', 0, 0),
(82, 9999, 'RG007', NULL, '45.0000', '2006-09-17 03:44:08', NULL, NULL, '0.00', 1, 1, 0, 0, '75', 0, 0),
(83, 9999, 'RG008', NULL, '45.0000', '2006-09-17 03:44:46', NULL, NULL, '0.00', 1, 1, 0, 0, '75', 0, 0),
(84, 9999, 'RG009', NULL, '120.0000', '2006-09-17 03:45:24', NULL, NULL, '0.00', 1, 1, 0, 0, '75', 0, 0),
(86, 9999, '', 'magholder.gif', '325.0000', '2006-10-02 20:56:36', NULL, NULL, '12.00', 1, 1, 12, 0, '', 0, 1),
(89, 9999, '', 'CIMG0867.JPG', '99.0000', '2006-10-02 21:15:10', NULL, NULL, '6.00', 1, 1, 11, 0, '', 0, 1),
(90, 9999, '', 'flyfisherman.jpg', '99.0000', '2006-10-02 21:20:18', NULL, NULL, '6.00', 1, 1, 11, 0, '', 0, 1),
(91, 9999, '', 'CIMG0825.JPG', '195.0000', '2006-10-02 21:27:27', NULL, NULL, '8.00', 1, 1, 16, 0, '', 0, 1),
(92, 9999, '', 'CIMG0830.JPG', '106.0000', '2006-10-02 21:29:03', NULL, NULL, '0.00', 1, 1, 16, 0, '', 0, 1),
(93, 9999, '', 'CIMG0832.JPG', '130.0000', '2006-10-02 21:30:29', '2006-10-08 17:22:05', NULL, '8.00', 1, 1, 16, 0, '', 1, 1),
(94, 9999, '', 'CIMG0861.JPG', '0.0000', '2006-10-02 21:34:32', NULL, NULL, '0.00', 1, 0, 15, 0, '0', 1, 1),
(95, 9999, '', NULL, '49.0000', '2006-10-02 21:35:46', '2006-10-02 21:38:13', NULL, '3.00', 1, 1, 0, 0, '94', 0, 0),
(96, 9999, '', NULL, '49.0000', '2006-10-02 21:36:36', '2006-10-02 21:38:03', NULL, '3.00', 1, 1, 0, 1, '94', 0, 0),
(97, 9999, '', NULL, '49.0000', '2006-10-02 21:37:50', '2006-10-02 21:38:37', NULL, '0.00', 1, 1, 0, 0, '94', 0, 0),
(98, 9999, '', NULL, '75.0000', '2006-10-02 21:39:08', '2006-10-06 15:27:40', NULL, '4.00', 1, 1, 0, 0, '94', 0, 0),
(99, 9999, '', NULL, '75.0000', '2006-10-02 21:39:36', '2006-10-06 15:27:04', NULL, '4.00', 1, 1, 0, 0, '94', 0, 0),
(100, 9999, '', 'IMG_4619_web.jpg', '0.0000', '2006-10-02 21:42:56', '2006-10-02 22:07:10', NULL, '0.00', 1, 0, 17, 0, '0', 1, 1),
(101, 9999, '', NULL, '210.0000', '2006-10-02 21:44:27', NULL, NULL, '10.00', 1, 1, 0, 0, '100', 0, 0),
(102, 9999, '', NULL, '117.0000', '2006-10-02 21:45:33', NULL, NULL, '10.00', 1, 1, 0, 0, '100', 0, 0),
(103, 9999, '', NULL, '61.0000', '2006-10-02 21:46:07', NULL, NULL, '5.00', 1, 1, 0, 0, '100', 0, 0),
(104, 9999, '', NULL, '97.0000', '2006-10-02 21:46:36', '2006-10-02 21:46:58', NULL, '6.00', 1, 1, 0, 0, '100', 0, 0),
(105, 9999, '', NULL, '61.0000', '2006-10-02 21:48:35', NULL, NULL, '8.00', 1, 1, 0, 0, '100', 0, 0),
(106, 9999, '', NULL, '108.0000', '2006-10-02 21:49:05', NULL, NULL, '7.00', 1, 1, 0, 0, '100', 0, 0),
(107, 9999, '', 'CRM_GLTH.JPG', '0.0000', '2006-10-02 21:49:41', '2006-10-02 22:09:01', NULL, '0.00', 1, 0, 17, 0, '0', 1, 1),
(108, 9999, '', NULL, '210.0000', '2006-10-02 21:50:22', NULL, NULL, '10.00', 1, 1, 0, 0, '107', 0, 0),
(109, 9999, '', NULL, '70.0000', '2006-10-02 21:50:56', NULL, NULL, '6.00', 1, 1, 0, 0, '107', 0, 0),
(110, 9999, '', NULL, '92.0000', '2006-10-02 21:51:28', NULL, NULL, '5.00', 1, 1, 0, 0, '107', 0, 0),
(111, 9999, '', NULL, '36.0000', '2006-10-02 21:52:29', NULL, NULL, '5.00', 1, 1, 0, 0, '107', 0, 0),
(112, 9999, '', 'FDB_GLTH.JPG', '0.0000', '2006-10-02 21:52:59', '2006-10-02 22:09:36', NULL, '0.00', 1, 0, 17, 0, '0', 1, 1),
(113, 9999, '', NULL, '210.0000', '2006-10-02 21:53:36', NULL, NULL, '10.00', 1, 1, 0, 0, '112', 0, 0),
(114, 9999, '', NULL, '192.0000', '2006-10-02 21:54:03', NULL, NULL, '10.00', 1, 1, 0, 0, '112', 0, 0),
(115, 9999, '', NULL, '204.0000', '2006-10-02 21:54:38', NULL, NULL, '10.00', 1, 1, 0, 0, '112', 0, 0),
(116, 9999, '', NULL, '88.0000', '2006-10-02 21:55:12', NULL, NULL, '6.00', 1, 1, 0, 0, '112', 0, 0),
(117, 9999, '', 'IMG_4629_web.jpg', '0.0000', '2006-10-02 22:20:35', NULL, NULL, '0.00', 1, 0, 15, 0, '0', 1, 1),
(118, 9999, '', 'Pottery.jpg', '0.0000', '2006-10-02 22:24:14', '2006-10-09 17:35:11', NULL, '0.00', 1, 0, 15, 0, '0', 1, 1),
(119, 9999, '', 'IMG_4627_web.jpg', '112.0000', '2006-10-02 22:48:29', NULL, NULL, '7.00', 1, 1, 16, 0, '', 0, 1),
(120, 9999, '', NULL, '70.0000', '2006-10-16 21:17:49', NULL, NULL, '0.00', 1, 1, 0, 1, '64', 0, 0),
(121, 9999, '', NULL, '50.0000', '2006-10-16 21:19:21', NULL, NULL, '0.00', 1, 1, 0, 1, '64', 0, 0),
(122, 9999, '', NULL, '36.0000', '2006-10-16 21:23:01', '2006-10-16 21:24:35', NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(123, 9999, '', NULL, '36.0000', '2006-10-16 21:25:18', NULL, NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(124, 9999, '', NULL, '35.0000', '2006-10-16 21:26:27', NULL, NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(125, 9999, '', NULL, '56.0000', '2006-10-16 21:27:31', NULL, NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(126, 9999, '', NULL, '49.0000', '2006-10-16 21:28:38', NULL, NULL, '0.00', 1, 1, 0, 0, '64', 0, 0),
(127, 9999, 'MOD-FLAT', 'CIMG0882.JPG', '0.0000', '2006-10-28 19:47:31', NULL, NULL, '0.00', 1, 0, 15, 0, '0', 1, 1),
(128, 999, 'MODC-Pasta', NULL, '45.0000', '2006-10-28 19:48:44', NULL, NULL, '0.00', 1, 1, 0, 0, '127', 0, 0),
(129, 9999, 'MODC-Cheese', NULL, '19.0000', '2006-10-28 19:50:00', NULL, NULL, '0.00', 1, 1, 15, 0, '127', 0, 0),
(130, 9999, 'MODC-Serving', NULL, '36.0000', '2006-10-28 19:50:51', NULL, NULL, '0.00', 1, 1, 15, 0, '127', 0, 0),
(131, 9999, 'BURNHORN-BOW', 'CIMG0894.JPG', '92.0000', '2006-10-28 19:59:45', '2006-10-28 20:03:09', NULL, '10.00', 1, 1, 15, 0, '', 0, 1),
(132, 9999, 'VARGHORN-DIS', 'CIMG0897.JPG', '89.0000', '2006-10-28 20:02:51', '2006-10-28 20:03:00', NULL, '4.00', 1, 1, 15, 0, '', 0, 1),
(133, 9999, 'WIRECANDLE', 'CIMG0888.JPG', '69.0000', '2006-10-28 20:06:54', '2006-11-04 20:52:19', NULL, '10.00', 1, 1, 15, 0, '', 1, 1),
(134, 9999, 'TurkeyTureen', 'CIMG0868.JPG', '275.0000', '2006-10-28 20:13:25', NULL, NULL, '0.00', 1, 1, 18, 0, '', 0, 1),
(135, 9999, '', 'CIMG0934.JPG', '995.0000', '2006-10-28 20:19:22', '2006-10-28 20:19:40', NULL, '0.00', 1, 1, 19, 0, '', 0, 1),
(136, 9999, 'AM-SNOWMAN', 'CIMG0911.JPG', '99.0000', '2006-10-28 20:21:06', NULL, NULL, '0.00', 1, 1, 11, 0, '', 0, 1),
(137, 9999, 'MODI-CondFla', 'CIMG0879.JPG', '98.0000', '2006-10-28 20:24:00', NULL, NULL, '4.00', 1, 1, 15, 0, '', 0, 1),
(138, 9999, 'V-RH-LG', 'IMG_5037.JPG', '1485.0000', '2006-10-28 20:55:25', NULL, NULL, '50.00', 1, 1, 15, 0, '', 0, 1),
(139, 9999, 'V-RH-SM', 'IMG_5037.JPG', '495.0000', '2006-10-28 20:56:45', NULL, NULL, '25.00', 1, 1, 15, 0, '', 0, 1),
(140, 999, 'V-RS-JB', 'IMG_5038.JPG', '745.0000', '2006-10-28 20:57:33', NULL, NULL, '30.00', 1, 1, 15, 0, '', 0, 1),
(141, 999, 'V-RS-LG', 'IMG_5038.JPG', '395.0000', '2006-10-28 20:58:21', '2006-10-28 20:58:49', NULL, '20.00', 1, 1, 15, 0, '', 0, 1),
(142, 999, 'V-RS-SM', 'IMG_5038.JPG', '320.0000', '2006-10-28 20:59:26', '2006-10-28 20:59:40', NULL, '15.00', 1, 1, 15, 0, '', 0, 1),
(143, 999, 'V-LTDG', 'IMG_5040.JPG', '545.0000', '2006-10-28 21:00:39', NULL, NULL, '25.00', 1, 1, 15, 0, '', 0, 1),
(144, 999, 'V-EAGLE', 'IMG_5041.JPG', '395.0000', '2006-10-28 21:01:28', NULL, NULL, '18.00', 1, 1, 15, 1, '', 0, 1),
(145, 999, 'V-DUCK', 'IMG_5042.JPG', '239.0000', '2006-10-28 21:02:49', NULL, NULL, '10.00', 1, 1, 15, 0, '', 0, 1),
(146, 999, 'V-HERON', 'IMG_5044.JPG', '235.0000', '2006-10-28 21:03:31', NULL, NULL, '8.00', 1, 1, 15, 0, '', 0, 1),
(147, 999, 'V-FLYFISHER', 'IMG_5045.JPG', '375.0000', '2006-10-28 21:04:55', NULL, NULL, '18.00', 1, 1, 15, 0, '', 0, 1),
(148, 1, '', NULL, '330.0000', '2006-12-04 17:45:19', NULL, NULL, '10.00', 1, 1, 15, 1, '117', 1, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `products_attributes`
-- 

DROP TABLE IF EXISTS `products_attributes`;
CREATE TABLE IF NOT EXISTS `products_attributes` (
  `products_attributes_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL,
  `options_id` int(11) NOT NULL,
  `options_values_id` int(11) NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) NOT NULL,
  PRIMARY KEY  (`products_attributes_id`)
) ENGINE=MyISAM AUTO_INCREMENT=497 DEFAULT CHARSET=latin1 AUTO_INCREMENT=497 ;

-- 
-- Dumping data for table `products_attributes`
-- 

INSERT INTO `products_attributes` (`products_attributes_id`, `products_id`, `options_id`, `options_values_id`, `options_values_price`, `price_prefix`) VALUES (28, 41, 2, 1, '0.0000', '+'),
(29, 41, 2, 2, '20.0000', '+'),
(31, 41, 2, 5, '45.0000', '+'),
(32, 41, 2, 3, '85.0000', '+'),
(33, 41, 2, 4, '235.0000', '+'),
(34, 49, 2, 2, '0.0000', '+'),
(35, 49, 2, 5, '90.0000', '+'),
(36, 49, 2, 3, '320.0000', '+'),
(45, 53, 4, 13, '0.0000', '+'),
(46, 53, 4, 15, '0.0000', '+'),
(47, 53, 4, 16, '0.0000', '+'),
(48, 53, 4, 17, '0.0000', '+'),
(49, 53, 4, 18, '0.0000', '+'),
(50, 53, 4, 19, '0.0000', '+'),
(51, 65, 1, 20, '0.0000', '+'),
(52, 65, 1, 21, '0.0000', '+'),
(53, 65, 1, 22, '0.0000', '+'),
(54, 65, 1, 23, '0.0000', '+'),
(55, 65, 1, 24, '0.0000', '+'),
(113, 66, 1, 20, '0.0000', '+'),
(114, 66, 1, 21, '0.0000', '+'),
(115, 66, 1, 22, '0.0000', '+'),
(116, 66, 1, 23, '0.0000', '+'),
(117, 66, 1, 24, '0.0000', '+'),
(118, 67, 1, 20, '0.0000', '+'),
(119, 67, 1, 21, '0.0000', '+'),
(120, 67, 1, 22, '0.0000', '+'),
(121, 67, 1, 23, '0.0000', '+'),
(122, 67, 1, 24, '0.0000', '+'),
(123, 68, 1, 20, '0.0000', '+'),
(124, 68, 1, 21, '0.0000', '+'),
(125, 68, 1, 22, '0.0000', '+'),
(126, 68, 1, 23, '0.0000', '+'),
(127, 68, 1, 24, '0.0000', '+'),
(128, 69, 1, 20, '0.0000', '+'),
(129, 69, 1, 21, '0.0000', '+'),
(130, 69, 1, 22, '0.0000', '+'),
(131, 69, 1, 23, '0.0000', '+'),
(132, 69, 1, 24, '0.0000', '+'),
(133, 70, 1, 20, '0.0000', '+'),
(134, 70, 1, 21, '0.0000', '+'),
(135, 70, 1, 22, '0.0000', '+'),
(136, 70, 1, 23, '0.0000', '+'),
(137, 70, 1, 24, '0.0000', '+'),
(138, 71, 1, 20, '0.0000', '+'),
(139, 71, 1, 21, '0.0000', '+'),
(140, 71, 1, 22, '0.0000', '+'),
(141, 71, 1, 23, '0.0000', '+'),
(142, 71, 1, 24, '0.0000', '+'),
(143, 72, 1, 20, '0.0000', '+'),
(144, 72, 1, 21, '0.0000', '+'),
(145, 72, 1, 22, '0.0000', '+'),
(146, 72, 1, 23, '0.0000', '+'),
(147, 72, 1, 24, '0.0000', '+'),
(148, 73, 1, 20, '0.0000', '+'),
(149, 73, 1, 21, '0.0000', '+'),
(150, 73, 1, 22, '0.0000', '+'),
(151, 73, 1, 23, '0.0000', '+'),
(152, 73, 1, 24, '0.0000', '+'),
(153, 74, 1, 20, '0.0000', '+'),
(154, 74, 1, 21, '0.0000', '+'),
(155, 74, 1, 22, '0.0000', '+'),
(156, 74, 1, 23, '0.0000', '+'),
(157, 74, 1, 24, '0.0000', '+'),
(158, 62, 4, 31, '0.0000', '+'),
(164, 86, 1, 32, '0.0000', '+'),
(165, 86, 1, 33, '0.0000', '+'),
(161, 62, 4, 28, '0.0000', '+'),
(162, 62, 4, 29, '0.0000', '+'),
(163, 62, 4, 30, '0.0000', '+'),
(166, 86, 1, 34, '0.0000', '+'),
(167, 101, 1, 35, '0.0000', '+'),
(168, 101, 1, 36, '0.0000', '+'),
(169, 101, 1, 37, '0.0000', '+'),
(170, 102, 1, 35, '0.0000', '+'),
(171, 103, 1, 38, '0.0000', '+'),
(172, 104, 1, 35, '0.0000', '+'),
(173, 105, 1, 39, '0.0000', '+'),
(174, 105, 1, 40, '0.0000', '+'),
(175, 106, 1, 38, '0.0000', '+'),
(496, 133, 3, 49, '0.0000', '+'),
(495, 133, 3, 50, '0.0000', '+'),
(494, 133, 5, 47, '0.0000', '+'),
(493, 133, 5, 48, '0.0000', '+'),
(492, 129, 1, 46, '0.0000', '+'),
(491, 129, 1, 44, '0.0000', '+'),
(490, 129, 1, 43, '0.0000', '+'),
(489, 129, 1, 42, '0.0000', '+'),
(488, 129, 1, 41, '0.0000', '+'),
(487, 126, 1, 20, '0.0000', '+'),
(486, 126, 1, 21, '0.0000', '+'),
(485, 126, 1, 22, '0.0000', '+'),
(484, 126, 1, 23, '0.0000', '+'),
(483, 126, 1, 24, '0.0000', '+'),
(482, 125, 1, 20, '0.0000', '+'),
(481, 125, 1, 21, '0.0000', '+'),
(480, 125, 1, 22, '0.0000', '+'),
(479, 125, 1, 23, '0.0000', '+'),
(478, 125, 1, 24, '0.0000', '+'),
(477, 124, 1, 20, '0.0000', '+'),
(476, 124, 1, 21, '0.0000', '+'),
(475, 124, 1, 22, '0.0000', '+'),
(474, 124, 1, 23, '0.0000', '+'),
(473, 124, 1, 24, '0.0000', '+'),
(472, 123, 1, 20, '0.0000', '+'),
(471, 123, 1, 21, '0.0000', '+'),
(470, 123, 1, 22, '0.0000', '+'),
(469, 123, 1, 23, '0.0000', '+'),
(468, 123, 1, 24, '0.0000', '+'),
(467, 122, 1, 20, '0.0000', '+'),
(466, 122, 1, 21, '0.0000', '+'),
(465, 122, 1, 22, '0.0000', '+'),
(464, 122, 1, 23, '0.0000', '+'),
(463, 122, 1, 24, '0.0000', '+'),
(462, 121, 1, 20, '0.0000', '+'),
(461, 121, 1, 21, '0.0000', '+'),
(460, 121, 1, 22, '0.0000', '+'),
(459, 121, 1, 23, '0.0000', '+'),
(458, 121, 1, 24, '0.0000', '+'),
(457, 120, 1, 20, '0.0000', '+'),
(456, 120, 1, 21, '0.0000', '+'),
(455, 120, 1, 22, '0.0000', '+'),
(454, 120, 1, 23, '0.0000', '+'),
(453, 120, 1, 24, '0.0000', '+');

-- --------------------------------------------------------

-- 
-- Table structure for table `products_attributes_download`
-- 

DROP TABLE IF EXISTS `products_attributes_download`;
CREATE TABLE IF NOT EXISTS `products_attributes_download` (
  `products_attributes_id` int(11) NOT NULL,
  `products_attributes_filename` varchar(255) NOT NULL,
  `products_attributes_maxdays` int(2) default '0',
  `products_attributes_maxcount` int(2) default '0',
  PRIMARY KEY  (`products_attributes_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `products_attributes_download`
-- 

INSERT INTO `products_attributes_download` (`products_attributes_id`, `products_attributes_filename`, `products_attributes_maxdays`, `products_attributes_maxcount`) VALUES (26, 'unreal.zip', 7, 3);

-- --------------------------------------------------------

-- 
-- Table structure for table `products_description`
-- 

DROP TABLE IF EXISTS `products_description`;
CREATE TABLE IF NOT EXISTS `products_description` (
  `products_id` int(11) NOT NULL auto_increment,
  `language_id` int(11) NOT NULL default '1',
  `products_name` varchar(64) NOT NULL,
  `products_description` text,
  `products_url` varchar(255) default NULL,
  `products_viewed` int(5) default '0',
  PRIMARY KEY  (`products_id`,`language_id`),
  KEY `products_name` (`products_name`)
) ENGINE=MyISAM AUTO_INCREMENT=149 DEFAULT CHARSET=latin1 AUTO_INCREMENT=149 ;

-- 
-- Dumping data for table `products_description`
-- 

INSERT INTO `products_description` (`products_id`, `language_id`, `products_name`, `products_description`, `products_url`, `products_viewed`) VALUES (67, 1, 'Madeira Harvest 7" Soup & Cereal Bowl', 'Set of four', '', 0),
(68, 1, 'Madeira Harvest Bread & Butter Plate', 'Set of four', '', 0),
(69, 1, 'Madeira Harvest Small 6" Fruit Bowl', 'Set of four', '', 0),
(70, 1, 'Madeira Harvest 13" Charger Plate', 'Set of four', '', 0),
(71, 1, 'Madeira Harvest Ramekin', 'Set of four', '', 0),
(72, 1, 'Madeira Harvest Pitcher', 'Individual', '', 0),
(73, 1, 'Madeira Harvest 12oz. Coffee Mug', 'Set of four', '', 0),
(74, 1, 'Madeira Harvest Salt & Pepper Shakers', 'One set', '', 0),
(75, 1, 'Country Life Dishware', 'Freezer to oven safe, dishwasher safe, and microwave safe, these Robert Gordon handcrafted and handpainted ceramics are created in Australia. They make a perfect addition to any country kitchen.', '', 140),
(76, 1, 'Country Life Pheasant Plates', 'Set of four', '', 0),
(77, 1, 'Country Life Individual Pheasant Plate', 'Individual', '', 0),
(78, 1, 'Country Life Large Oval Platter with Handles', 'Individual', '', 1),
(79, 1, 'Country Life Large Rooster Au Gratin', 'Individual', '', 0),
(80, 1, 'Country Life Trout Rectangular Dish', 'Individual', '', 0),
(81, 1, 'Country Life Pheasant Serving Bowl', 'Individual', '', 0),
(82, 1, 'Country Life Trout Wine Bottle Holder', 'Individual', '', 0),
(83, 1, 'Country Life Trout Utensil Holder', 'Individual', '', 3),
(84, 1, 'Country Life Pheasant Casserole Dish', 'Individual', '', 3),
(28, 1, 'Glass Vessel', 'This Fabulous free-form glass vessel bowl, can be made to your exact color and size.(pictured is cobalt blue color and 15"in size).Made in England and signed by the artist. $995.', '', 45),
(29, 1, 'The Leaf', 'Blue,green and silver leaf sculpture; custom colors  or as pictured. Signed by the artist in England.', '', 20),
(30, 1, 'The Fish', 'This sand glass art fish is firey orange, sea green, and deep blue. It is a curved shape,resting on its fins so it appears to be swimming on your table.Perfect centerpiece for any sea-loving home. Signed by the artist in England,who has done many pieces for Her Majesty and other european royalty.', '', 32),
(31, 1, 'Handmade Taormina Canisters (Set of 3)', '"Taormina",a three-piece canister set with airtight tops. Handmade in Italy. 3 canisters for $295.', '', 26),
(32, 1, 'Handpainted Brazillian Clay Pot', 'Handmade clay pot from Brazil, handpainted with a floral pattern. Other colors and patterns are available upon request.', '', 20),
(33, 1, 'Frutta Laccata Canisters (set of 3)', 'Set of 3 canisters.', '', 6),
(119, 1, 'Festivo Cappuccino Mug (Set of Four)', '<b>Set of four.</b> Dishwasher safe.', '', 31),
(34, 1, 'Grand Gourmet Tureen', 'This handmade tureen is crafted in Tuscany and specially fired for ovenproof use.', '', 24),
(35, 1, 'Toscano Plate', 'This 12" x 9" ceramic plate is dishwasher and microwave safe. Depicted are scenes of Tuscany, where the plate is handcrafted and handpainted.', '', 30),
(37, 1, 'Pewter & Ceramic Biscotti Jar by Match', 'Handmade pewter and ceramic, made in Italy by Match.', '', 31),
(38, 1, '"Horses Drinking" Wastebasket', 'This handmade American wastebasket is handpainted with a unique equestrian image and finished in an authentic thirteen layer decoupage style, characteristic of Ancient Chinese works.', '', 26),
(39, 1, 'Large Soup Tureen', 'Handcrafted in Tuscany and handpainted in the Terre di Chianti pattern, this fabulous piece fits perfectly in any collection.', '', 19),
(40, 1, 'Planter/Centerpiece with Handles', 'This handcrafted piece is handpainted in a Terri di Chianti pattern. Perfect for a kitchen island, greenhouse, porch, or any Tuscan country home.', '', 16),
(41, 1, 'Spaulted Maple Cutting Boards', 'These individualy handmade cutting boards from solid pieces of Spaulted Maple, are available in many sizes.', '', 38),
(42, 1, 'Hand Hewn Fruit Bowl', 'Primitive hand hewn decorative wooden bowl, made from Washington''s Northwood White Birch. Distressed with an authentic look, this bowl features a notched end rim, a metal patch with traditional tacks, and a dark lustrous patina and hand-buffed treewax finish. The bowl''s uses are endless - potpourri, candles, fruit, holiday nuts, knitting, and more. \r\n\r\nDimensions: 13"(W) x 10"(L) x 4"(D)', '', 36),
(43, 1, 'Cast Stainless Tape Dispenser', 'This artistic tape dispenser by Carrol Boyes is hand cast into a relaxed female form.', '', 18),
(44, 1, 'Angel Fame', 'Gold-leaf angel balancing art, perfect for your patio or fireplace mantle.', '', 29),
(45, 1, 'Strike Out! Baseball Figure Balancing Model', 'Preparing for another ball, this baseball player is planning to strike a home run in your yard!', '', 27),
(46, 1, 'The Wizard', 'Enchant your collection with this one of a kind wizard balancing model. An excellent value!', '', 26),
(47, 1, 'Santa and his Sleigh', 'Vintage sculpture of St. Nicholas and his sleigh, complete with reindeer and reins. As Santa rocks, his reindeer gallop and his hand waves a Merry Christmas!', '', 32),
(48, 1, 'The Fisherman', 'Bright, yellow, and cheerful, this adorable fisherman is reeling one - or three - fish in. A bestseller since 2001!', '', 23),
(49, 1, 'Spaulted Maple Bowl', 'Oval shaped wood bowl, handcrafted from Spaulted Maple  Includes serving utensils as pictured. Available in 15-inch, 18-inch, and 21-inch sizes. Food safe and salad friendly!', '', 34),
(50, 1, 'Distressed Candle Holder', 'This wooden candle holder is completed with a distressed finish and includes twelve candles and glass or tin inserts. Perfect for fireplace or tabletop display.The candle burn time is 20+ hours.Refills are available in sets of six for $19.00.', '', 19),
(148, 1, 'TERRE DI CHIANTI', 'SET OF SIX DINNER PLATES, MICROWAVE & DISHEWASHER SAFE.', '', 0),
(52, 1, 'Glass Spikot Jar with Stand', 'This is a 204 oz. Italian hexagonal Spikot Jar with stand. Great for iced tea, sangria, lemonade, or anything else!', '', 17),
(53, 1, 'Handpainted 15-inch Salad Bowls', 'These Handpainted, food-safe bowls in assorted patterns come with servers: The Wedding Bowl (pictured left), Apples (pictured center), Friendship, Pears, Tuscan Olives, Sunflowers and more.', '', 29),
(88, 1, 'Santa on Skis', '', '', 19),
(86, 1, 'Man Magazine Holder', '48 x 28 x 40 cm\r\nHandcrafted in South Africa', '', 42),
(89, 1, 'Christmas Angel', '', '', 16),
(55, 1, 'Decorative Hand Hewn Wooden Bowl', 'Hand hewn from white canoe birchwood in Washington state and distressed with an authentic look, this bowl features a notched end rim, a metal patch with traditional tacks, and a dark lustrous patina and hand-buffed treewax finish. The bowl''s uses are endless - potpourri, candles, fruit, holiday nuts, knitting, and more. This beautiful bowl is available in many sizes, and is perfect for any display. (15"w x 34"l x 5½"h shown).', '', 43),
(56, 1, 'Stained 2-Tier Candle Holder', 'This solid wood candle holder includes twelve candles and glass or tin inserts. Perfect for fireplace or tabletop display.', '', 23),
(57, 1, '"Man & Woman" Hand Sculpted Pewter Nutcracker', 'This beautiful hand-sculpted pewter nutcracker is created by Carrol Boyes in South Africa. It makes a fabulous gift for any nut lover!', '', 57),
(58, 1, 'Carrol Boyes Cheese Knife', 'Cast in a blend of pewter and stainless steel, this beautiful cheese knife makes a perfect addition to any kitchen.', '', 34),
(59, 1, 'Mango Bark Botique Tissue Box', 'Handmade in South America from the bark of a mango tree, these boxes are all unique. Perfect for any den or powder room.', '', 19),
(60, 1, 'Functional Art Paper Towel Holder', 'A member of the Carrol Boyes Functional Art collection, this unique paper towel holder makes an excellent compliment to any stylish kitchen. This handcrafted piece has irregularities that add to its unique charm.', '', 50),
(61, 1, 'Mermaid Pie Server', 'Mermaid pie slicer and server. Perfect for pies, quiche, and more.', '', 25),
(62, 1, 'Salad Serving Set', 'This set includes a man and woman serving spoon & fork which makes a perfect gift for a newlywed couple, engagement gift, or anyone else who loves unusual but functional art.', '', 31),
(63, 1, 'Large Seven-Piece Hostess Set', 'Taormina handmade in Tuscany: an extremely versatile seven piece antipasta/hostess set. Use it as pictured, or place flowers in the middle for an authentically Italian experience. Dishwasher and microwave safe.\r\n<br><br>\r\n<b>Larger than it looks in the picture! Actual size assembled as shown is 32½" x 26".</b><br>\r\n7-piece set.', '', 21),
(64, 1, 'Madiera Harvest Dinnerware', '', '', 423),
(65, 1, 'Madeira Harvest 11" Dinner Plate', 'Set of four', '', 0),
(66, 1, 'Madeira Harvest 8.25" Salad Plate', 'Set of four', '', 0),
(90, 1, 'Flyfisherman', '', '', 23),
(91, 1, 'Tavola Gravy Boat, Tray, and Ladle', 'The exquisite tuscan pewter is lead-free, food safe, and never needs to be polished to maintin the illustrious, hand-applied patina finish. Hand wash.', '', 27),
(92, 1, 'Festivo "Dolce" Canister', 'Italian white ceramic with hand-finished pewter trim. It''s classic simplicity lends itself to contemporary, traditional, or casual tables. Perfect for sweets or sugar. 6" tall.', '', 35),
(93, 1, 'Set Of Two,Caffe Expresso Cup, Saucer, and Spoon', 'Three piece set of white ceramic with hand-finished pewter trim. Dishwasher safe.Comes As A Set Of Two.', '', 28),
(94, 1, 'Botanical Candles', 'A beeswax paraffin blend filled with real fruit, spices, and flowers. Fabulously fragrant, and long-lasting - Large candles burn for 300 hours, small candles for 200.', '', 181),
(95, 1, 'Round Spiced Cranberry', '200 hrs', '', 0),
(96, 1, 'Round Spicy Apple', '200 hrs', '', 0),
(97, 1, 'Flower Pot Cherries and Chestnuts', '200 hrs', '', 0),
(98, 1, 'Big Mama Spicy Apple', '300 hrs', '', 0),
(99, 1, 'Big Mama Orange Vanilla', '300 hrs', '', 0),
(100, 1, 'Cucina Fresca', '', '', 112),
(101, 1, 'Cucina Fresca Dinner Plate', 'Set of 6', '', 0),
(102, 1, 'Cucina Fresca Large Oval Platter', 'Individual', '', 0),
(103, 1, 'Cucina Fresca Small Oval Platter', 'Individual', '', 0),
(104, 1, 'Cucina Fresca Square Oven Casserole', 'Individual', '', 0),
(105, 1, 'Cucina Fresca Oval Handled Platter', 'Individual', '', 0),
(106, 1, 'Cucina Fresca Large Serving Bowl', 'Individual', '', 0),
(107, 1, 'Crema', '', '', 94),
(108, 1, 'Crema Dinner Plate', 'Set of 6', '', 0),
(109, 1, 'Crema Sectional Server', 'Individual', '', 0),
(110, 1, 'Crema Medium Serving Bowl', 'Individual', '', 0),
(111, 1, 'Crema Rectangular Serving Plate', 'Individual', '', 0),
(112, 1, 'Fiori Di Bosco', '', '', 82),
(113, 1, 'Fiori Di Bosco Dinner Plate', 'Set of 6', '', 0),
(114, 1, 'Fiori Di Bosco Pasta Bowl', 'Set of 6', '', 0),
(115, 1, 'Fiori Di Bosco Footed Mug', 'Set of 6', '', 0),
(116, 1, 'Fiori Di Bosco Antipasti Server', 'Individual', '', 0),
(117, 1, 'Terre di Chianti', 'From plates to platters to bowls and beyond, AMEN''s exclusive Terre di Chianti collection is handmade in Tuscany. If you are interested in any items in this set, please contact us using the link at the left side of the page, or call (908) 204-8989.', '', 82),
(118, 1, 'Frutta Laccata Collection', 'Fruits of the trees on terra cotta. Vibrant colors of handmade & handpainted plates, bowls, tureens, Biscotti jars, olive oil bottles, coffee mugs, and pitchers are only some of the items available in this incredible collection. Everything is dishwasher, microwave safe!\r\n\r\nPlease contact us by clicking the link at the left side of the page, or call (908) 204-8989 for more details.', '', 99),
(120, 1, 'Madiera Harvest Rectangular Tray', 'Set of 2', '', 0),
(121, 1, 'Madiera Harvest Oval Platter [16x12½"]', 'Individual', '', 0),
(122, 1, 'Madiera Harvest Paté Pan [10 oz. 7½"x3½"]', 'Set of 2', '', 0),
(123, 1, 'Madiera Harvest Square Tray [8¼"]', 'Set of 2', '', 0),
(124, 1, 'Madiera Harvest Pasta Server [1.5qt/12½" square]', 'Individual', '', 0),
(125, 1, 'Madiera Harvest Oval Covered Casserole [1¾qt]', 'Individual', '', 0),
(126, 1, 'Madiera Harvest Large Rectangular Baker [2½ qt:14"x10¾"]', 'Individual', '', 0),
(127, 1, 'Condotti 18/10 Stainless Steel Flatware', 'Acrylic handles. Dishwasher safe.', '', 71),
(128, 1, 'Condotti Pasta Server', 'Ind.', '', 0),
(129, 1, 'Condotti Cheese Knife', 'Ind.', '', 0),
(130, 1, 'Condotti Serving Spoon', 'Ind.', '', 0),
(131, 1, 'Burnished Horn Bowl', 'Artisans from the south seas select the highest quality horn, capturing nature''s beauty in its most rare and precious form, while maintaining the highest levels of function and practicality.<br><br>\r\n9½ x 11"', '', 25),
(132, 1, 'Varigated Horn 6" Oval Soap Dish', 'Natural varigated horn, sold as a set as pictured.', '', 13),
(133, 1, 'Barbed Wire Candle 7x7"', '<b>Straight from the west!</b><br><br>Vanilla scented candle wrapped in barbed wire on a rustic tin tray.<br><br>Candles \r\nare available with and without horseshoes, in larger sizes.', '', 25),
(134, 1, 'Turkey Tureen', 'Handmade in Italy, this ceramic turkey tureen includes a ladle. Perfect as a centerpiece for any autumnal occasion!', '', 27),
(135, 1, '"Over the Mantel" Tin Mirror', 'Crafted in the midwest of distressed finished wood and reclaimed tin, this beveled edge mirror comes in an Olde White finish. <br><br>45" wide x 32" high.', '', 27),
(136, 1, 'Snowman Balancing Model', '', '', 15),
(137, 1, 'Five Piece Condotti Flatware Set', '18/10 stainless steel flatware. Guaranteed dishwasher safe. Acrylic handles. <br><b>Pictured finish: Wood.</b>\r\n<br><br>Includes:\r\n<ul>\r\n<li>Serrated knife</li>\r\n<li>Dinner fork</li>\r\n<li>Salad fork</li>\r\n<li>Soup/Pasta spoon</li>\r\n<li>Dessert spoon</li>\r\n</ul>', '', 17),
(138, 1, 'The Large Race Horse', '26" high<br>\r\n48" long<br>\r\n5" wide<br>\r\n42 lbs.', '', 13),
(139, 1, 'The Race Horse', '20" high. 32" long. 22 lbs.', '', 12),
(140, 1, 'The Jumbo Rooster', '39" high. 35" long. 30 lbs.', '', 9),
(141, 1, 'The Big Rooster', '25" high. 28" long. 17 lbs.', '', 12),
(142, 1, 'The Small Rooster', '18.5" high. 26" long. 13 lbs.', '', 13),
(143, 1, 'Lighthouse with Dragon', '24" high. 32" long. 22 lbs.', '', 25),
(144, 1, 'The American Eagle', '16" high. 23" long. 15 lbs.', '', 25),
(145, 1, 'The Landing Duck', '13" high. 12" long. 22" wide. 8 lbs.', '', 9),
(146, 1, 'The Heron', '12" high. 16" long. 19" wide. 8 lbs.', '', 10),
(147, 1, 'The Flyfisherman', '30" high. 38" long. 15 lbs.', '', 11);

-- --------------------------------------------------------

-- 
-- Table structure for table `products_notifications`
-- 

DROP TABLE IF EXISTS `products_notifications`;
CREATE TABLE IF NOT EXISTS `products_notifications` (
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`products_id`,`customers_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `products_notifications`
-- 

INSERT INTO `products_notifications` (`products_id`, `customers_id`, `date_added`) VALUES (96, 3, '2006-10-05 15:08:54'),
(0, 8, '2006-10-18 17:17:56'),
(0, 12, '2006-12-09 00:17:58');

-- --------------------------------------------------------

-- 
-- Table structure for table `products_options`
-- 

DROP TABLE IF EXISTS `products_options`;
CREATE TABLE IF NOT EXISTS `products_options` (
  `products_options_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `products_options_name` varchar(32) NOT NULL,
  PRIMARY KEY  (`products_options_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `products_options`
-- 

INSERT INTO `products_options` (`products_options_id`, `language_id`, `products_options_name`) VALUES (1, 1, 'Color'),
(2, 1, 'Size'),
(4, 1, 'Design'),
(3, 1, 'Finish'),
(5, 1, 'Shape');

-- --------------------------------------------------------

-- 
-- Table structure for table `products_options_values`
-- 

DROP TABLE IF EXISTS `products_options_values`;
CREATE TABLE IF NOT EXISTS `products_options_values` (
  `products_options_values_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `products_options_values_name` varchar(64) NOT NULL,
  PRIMARY KEY  (`products_options_values_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `products_options_values`
-- 

INSERT INTO `products_options_values` (`products_options_values_id`, `language_id`, `products_options_values_name`) VALUES (1, 1, '12"'),
(2, 1, '15"'),
(3, 1, '21"'),
(4, 1, '24"'),
(5, 1, '18"'),
(6, 1, 'Cream Wash'),
(7, 1, 'Dark Cream Wash'),
(8, 1, 'Tusk Gray'),
(9, 1, 'Green'),
(10, 1, 'Brick'),
(11, 1, 'Rusted Copper'),
(12, 1, 'Olde Ivory'),
(13, 1, 'Surprise Me!'),
(14, 1, 'The Wedding Bowl'),
(15, 1, 'Apples'),
(16, 1, 'Friendship'),
(17, 1, 'Pears'),
(18, 1, 'Tuscan Olives'),
(19, 1, 'Sunflowers'),
(20, 1, 'Dijon Gold'),
(21, 1, 'Robin''s Egg Blue'),
(22, 1, 'Sage Green'),
(23, 1, 'Vanilla Creme'),
(24, 1, 'Smoked Salmon'),
(25, 1, 'Woman'),
(26, 1, 'Fish'),
(27, 1, 'Soviet'),
(28, 1, 'Wave'),
(29, 1, 'Aries'),
(30, 1, 'Single Coil'),
(31, 1, 'Man & Woman'),
(32, 1, 'Black Leather'),
(33, 1, 'Brown Leather'),
(34, 1, 'Red Leather'),
(35, 1, 'Cream/Saffron'),
(36, 1, 'Saffron/Sage'),
(37, 1, 'Sage/Cream'),
(38, 1, 'Saffron/Cream'),
(39, 1, 'Cream/Cream'),
(40, 1, 'Saffron/Saffron'),
(41, 1, 'Blue'),
(42, 1, 'Burgundy'),
(43, 1, 'Cream'),
(44, 1, 'Black'),
(45, 1, 'Honey'),
(46, 1, 'Wood'),
(47, 1, 'Round [cannot have horseshoes]'),
(48, 1, 'Rectangular'),
(49, 1, 'with Horseshoes'),
(50, 1, 'without Horseshoes');

-- --------------------------------------------------------

-- 
-- Table structure for table `products_options_values_to_products_options`
-- 

DROP TABLE IF EXISTS `products_options_values_to_products_options`;
CREATE TABLE IF NOT EXISTS `products_options_values_to_products_options` (
  `products_options_values_to_products_options_id` int(11) NOT NULL auto_increment,
  `products_options_id` int(11) NOT NULL,
  `products_options_values_id` int(11) NOT NULL,
  PRIMARY KEY  (`products_options_values_to_products_options_id`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=latin1 AUTO_INCREMENT=67 ;

-- 
-- Dumping data for table `products_options_values_to_products_options`
-- 

INSERT INTO `products_options_values_to_products_options` (`products_options_values_to_products_options_id`, `products_options_id`, `products_options_values_id`) VALUES (15, 2, 2),
(14, 2, 1),
(22, 3, 6),
(19, 2, 4),
(21, 2, 5),
(6, 3, 6),
(7, 3, 7),
(8, 3, 8),
(9, 3, 9),
(10, 5, 10),
(13, 5, 13),
(17, 2, 3),
(23, 3, 7),
(24, 3, 8),
(25, 3, 9),
(26, 3, 10),
(27, 3, 11),
(28, 3, 12),
(29, 4, 13),
(30, 4, 14),
(31, 4, 15),
(32, 4, 16),
(33, 4, 17),
(34, 4, 18),
(35, 4, 19),
(36, 1, 20),
(37, 1, 21),
(38, 1, 22),
(39, 1, 23),
(40, 1, 24),
(41, 4, 25),
(42, 4, 26),
(43, 4, 27),
(44, 4, 28),
(45, 4, 29),
(46, 4, 30),
(47, 4, 31),
(48, 1, 32),
(49, 1, 33),
(50, 1, 34),
(51, 1, 35),
(52, 1, 36),
(53, 1, 37),
(54, 1, 38),
(55, 1, 39),
(56, 1, 40),
(57, 1, 41),
(58, 1, 42),
(59, 1, 43),
(60, 1, 44),
(61, 1, 45),
(62, 1, 46),
(63, 5, 47),
(64, 5, 48),
(65, 3, 49),
(66, 3, 50);

-- --------------------------------------------------------

-- 
-- Table structure for table `products_to_categories`
-- 

DROP TABLE IF EXISTS `products_to_categories`;
CREATE TABLE IF NOT EXISTS `products_to_categories` (
  `products_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL,
  PRIMARY KEY  (`products_id`,`categories_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `products_to_categories`
-- 

INSERT INTO `products_to_categories` (`products_id`, `categories_id`) VALUES (28, 25),
(29, 25),
(30, 25),
(31, 22),
(32, 24),
(33, 22),
(34, 22),
(35, 22),
(37, 30),
(38, 24),
(39, 22),
(40, 22),
(41, 21),
(42, 21),
(43, 24),
(44, 29),
(45, 29),
(46, 29),
(47, 29),
(48, 29),
(49, 21),
(50, 23),
(52, 24),
(53, 21),
(55, 21),
(56, 23),
(57, 30),
(58, 30),
(59, 21),
(60, 24),
(61, 30),
(62, 30),
(63, 22),
(64, 30),
(65, 30),
(66, 30),
(67, 30),
(68, 30),
(69, 30),
(70, 30),
(71, 30),
(72, 30),
(73, 30),
(74, 30),
(75, 30),
(76, 30),
(77, 30),
(78, 30),
(79, 30),
(80, 30),
(81, 30),
(82, 30),
(83, 30),
(84, 30),
(86, 24),
(88, 29),
(89, 29),
(90, 29),
(91, 30),
(92, 30),
(93, 30),
(94, 23),
(95, 23),
(96, 23),
(97, 23),
(98, 23),
(99, 23),
(100, 30),
(101, 30),
(102, 30),
(103, 30),
(104, 30),
(105, 30),
(106, 30),
(107, 30),
(108, 30),
(109, 30),
(110, 30),
(111, 30),
(112, 30),
(113, 30),
(114, 30),
(115, 30),
(116, 30),
(117, 22),
(118, 22),
(119, 30),
(120, 30),
(121, 30),
(122, 30),
(123, 30),
(124, 30),
(125, 30),
(126, 30),
(127, 30),
(128, 30),
(129, 30),
(130, 30),
(131, 21),
(132, 21),
(133, 23),
(134, 22),
(134, 30),
(135, 24),
(136, 29),
(137, 30),
(138, 31),
(139, 31),
(140, 31),
(141, 31),
(142, 31),
(143, 31),
(144, 31),
(145, 31),
(146, 31),
(147, 31),
(148, 22);

-- --------------------------------------------------------

-- 
-- Table structure for table `registry`
-- 

DROP TABLE IF EXISTS `registry`;
CREATE TABLE IF NOT EXISTS `registry` (
  `registry_id` int(11) NOT NULL auto_increment,
  `customers_id` int(13) NOT NULL default '0',
  `registry_occasion_id` int(13) NOT NULL default '0',
  `registry_occasion_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `co_registrant_first_name` varchar(32) NOT NULL default '',
  `co_registrant_last_name` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`registry_id`)
) ENGINE=MyISAM AUTO_INCREMENT=100002 DEFAULT CHARSET=latin1 AUTO_INCREMENT=100002 ;

-- 
-- Dumping data for table `registry`
-- 

INSERT INTO `registry` (`registry_id`, `customers_id`, `registry_occasion_id`, `registry_occasion_date`, `co_registrant_first_name`, `co_registrant_last_name`) VALUES (100000, 0, 0, '0000-00-00 00:00:00', 'Stub', 'Stub'),
(100001, 2, 3, '2007-05-21 00:00:00', 'Ben', 'Herila');

-- --------------------------------------------------------

-- 
-- Table structure for table `registry_occasion`
-- 

DROP TABLE IF EXISTS `registry_occasion`;
CREATE TABLE IF NOT EXISTS `registry_occasion` (
  `registry_occasion_id` int(11) NOT NULL auto_increment,
  `language_id` int(11) NOT NULL default '1',
  `registry_occasion_name` varchar(64) NOT NULL,
  PRIMARY KEY  (`registry_occasion_id`,`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- 
-- Dumping data for table `registry_occasion`
-- 

INSERT INTO `registry_occasion` (`registry_occasion_id`, `language_id`, `registry_occasion_name`) VALUES (1, 1, 'Wedding'),
(1, 2, 'Hochzeit'),
(1, 3, 'Wedding'),
(2, 1, 'Baby'),
(2, 2, 'Kind'),
(2, 3, 'Baby'),
(3, 1, 'Anniversary'),
(3, 2, 'Jubiläum'),
(3, 3, 'Anniversary'),
(4, 1, 'Special Occasions'),
(4, 2, 'Besonderer Anlass'),
(4, 3, 'Special Occasions');

-- --------------------------------------------------------

-- 
-- Table structure for table `registry_products`
-- 

DROP TABLE IF EXISTS `registry_products`;
CREATE TABLE IF NOT EXISTS `registry_products` (
  `registry_products_id` int(11) NOT NULL auto_increment,
  `customers_id` int(13) NOT NULL default '0',
  `products_id` tinytext NOT NULL,
  `registry_products_quantity` int(2) NOT NULL default '0',
  `registry_products_quantity_received` int(2) NOT NULL default '0',
  `final_price` decimal(15,4) NOT NULL default '0.0000',
  `registry_products_date_added` varchar(8) default NULL,
  `registry_id` int(11) NOT NULL,
  PRIMARY KEY  (`registry_products_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `registry_products`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `registry_products_attributes`
-- 

DROP TABLE IF EXISTS `registry_products_attributes`;
CREATE TABLE IF NOT EXISTS `registry_products_attributes` (
  `registry_products_attributes_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL default '0',
  `products_id` tinytext NOT NULL,
  `products_options_id` int(11) NOT NULL default '0',
  `products_options_value_id` int(11) NOT NULL default '0',
  `registry_id` int(11) NOT NULL,
  PRIMARY KEY  (`registry_products_attributes_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `registry_products_attributes`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `reviews`
-- 

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `reviews_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) default NULL,
  `customers_name` varchar(64) NOT NULL,
  `reviews_rating` int(1) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  `reviews_read` int(5) NOT NULL default '0',
  PRIMARY KEY  (`reviews_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `reviews`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `reviews_description`
-- 

DROP TABLE IF EXISTS `reviews_description`;
CREATE TABLE IF NOT EXISTS `reviews_description` (
  `reviews_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `reviews_text` text NOT NULL,
  PRIMARY KEY  (`reviews_id`,`languages_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `reviews_description`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `sessions`
-- 

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `sesskey` varchar(32) NOT NULL,
  `expiry` int(11) unsigned NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY  (`sesskey`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `sessions`
-- 

INSERT INTO `sessions` (`sesskey`, `expiry`, `value`) VALUES ('vfnqln8na5jc838os86o503bu5', 1165952278, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:11:"account.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"osCsid";s:26:"vfnqln8na5jc838os86o503bu5";}s:4:"post";a:0:{}}}s:8:"snapshot";a:4:{s:4:"page";s:11:"account.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"osCsid";s:26:"vfnqln8na5jc838os86o503bu5";}s:4:"post";a:0:{}}}'),
('p3scd045auouj1iatnttkvaf35', 1165939591, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('9jgecgt30utooh2lqidv3naiv2', 1165957148, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:2:{s:16:"manufacturers_id";s:2:"18";s:6:"osCsid";s:26:"9jgecgt30utooh2lqidv3naiv2";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('biusonq6tvupu3s09mb4iglco6', 1165930401, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('kvmq9oue6rnvgkadbaakd7tda7', 1165869678, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('32mclnoophq6o1mg0ktuturq12', 1165869424, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('parsth3ipfcp14p4s147sfk1j6', 1165849410, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:3:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:16:"manufacturers_id";s:2:"18";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:2:"25";}s:4:"post";a:0:{}}i:2;a:4:{s:4:"page";s:16:"product_info.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:2:{s:5:"cPath";s:2:"25";s:11:"products_id";s:2:"30";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('4q3f54mmiv4210q1atmlou7at1', 1165849278, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('f2mi54cqk831ifbdc34qacm430', 1165845779, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('6ojcfr7iuledm1v9b4u82jfad4', 1165845825, 'language|s:7:"english";languages_id|s:1:"1";selected_box|s:7:"reports";'),
('jm83r45cqq1k27gciqaalo6ir0', 1165805910, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:2:"31";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:16:"product_info.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:2:{s:5:"cPath";s:2:"31";s:11:"products_id";s:3:"146";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('u9ao6r3ujvogu9ne74fcr3t3t0', 1165844637, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('tabvbs2k7jun8oojfshk5ir8c6', 1165793238, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:2:"31";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('jcpfubf239jm558l3j5keqdql4', 1165803900, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:2:"31";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('tsdbvtqq7dlb7tghp7hch98av1', 1165777161, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:2:"31";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('5e6kdsljdfo7luug8ljf4ch2k2', 1165787320, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('60pl2hmu7fm020ruuf800tm8f2', 1165775958, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:2:"31";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('7u3ahdv5cajkofqg0ueo4k3fr6', 1165857587, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:2:{s:5:"cPath";s:2:"21";s:6:"osCsid";s:26:"7u3ahdv5cajkofqg0ueo4k3fr6";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('t5ohh5sagrg58rsv9lv0lrekv3', 1165728323, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('eu80bjc66iladrm02f72sqo723', 1165730052, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('d5vs0b9iub1aqq6sujbvbglt57', 1165727564, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('94d03s4l5kdh1pkqt505u12921', 1165728307, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:16:"manufacturers_id";s:2:"13";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:2:"22";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('spdvesjs8uq2o2rva52efv5es2', 1165725922, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('s5n3cblgjh12i7ia7a8q300m54', 1165725846, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:2:"21";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('bi2hjmeteqlop274esan2r3n25', 1165930303, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:9:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"osCsid";s:26:"bi2hjmeteqlop274esan2r3n25";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:11:"account.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"osCsid";s:26:"bi2hjmeteqlop274esan2r3n25";}s:4:"post";a:0:{}}i:2;a:4:{s:4:"page";s:14:"Conditions.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}i:3;a:4:{s:4:"page";s:11:"privacy.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"osCsid";s:26:"bi2hjmeteqlop274esan2r3n25";}s:4:"post";a:0:{}}i:4;a:4:{s:4:"page";s:14:"contact_us.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"osCsid";s:26:"bi2hjmeteqlop274esan2r3n25";}s:4:"post";a:0:{}}i:5;a:4:{s:4:"page";s:9:"login.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}i:6;a:4:{s:4:"page";s:16:"product_info.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:11:"products_id";s:2:"28";}s:4:"post";a:0:{}}i:7;a:4:{s:4:"page";s:22:"password_forgotten.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}i:8;a:4:{s:4:"page";s:18:"create_account.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:4:{s:4:"page";s:11:"account.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"osCsid";s:26:"bi2hjmeteqlop274esan2r3n25";}s:4:"post";a:0:{}}}'),
('b280624fr8jpm44g8n6saenf73', 1165758819, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('hmk7ulhfiknqpmqpojge5eaap3', 1165682822, 'language|s:7:"english";languages_id|s:1:"1";selected_box|s:7:"reports";'),
('dggtsvtgt0u3rrb0lpeugclkh5', 1165864278, 'language|s:7:"english";languages_id|s:1:"1";selected_box|s:9:"customers";'),
('29u8mvsttb7iqvp37n0ps0akc4', 1165948786, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:2:{s:16:"manufacturers_id";s:2:"11";s:6:"osCsid";s:26:"29u8mvsttb7iqvp37n0ps0akc4";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:16:"product_info.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:3:{s:16:"manufacturers_id";s:2:"11";s:11:"products_id";s:2:"47";s:6:"osCsid";s:26:"29u8mvsttb7iqvp37n0ps0akc4";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('cgah6smq9qv5udpnu1hkocmko3', 1165602368, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:22:"password_forgotten.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"osCsid";s:26:"cgah6smq9qv5udpnu1hkocmko3";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('fk142m0abeq7lhi5ui3ffv2fp5', 1165880952, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"login.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"osCsid";s:26:"fk142m0abeq7lhi5ui3ffv2fp5";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('32vb96qh9op1nnn05tr06m44i2', 1165619628, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('64oe6c758n4bb16d032jtt03c2', 1165624918, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}customer_id|s:2:"12";customer_default_address_id|s:2:"16";customer_first_name|s:5:"KATHY";customer_country_id|s:3:"223";customer_zone_id|s:2:"43";'),
('g5ct4pvnsg17e6gvofquagss76', 1165595418, 'language|s:7:"english";languages_id|s:1:"1";selected_box|s:9:"customers";'),
('74m0btiqutjs09s7552culqk36', 1165596783, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('pa8ncn8ehjhml1emuk1v5r3br0', 1165597447, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:12:"shipping.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"osCsid";s:26:"pa8ncn8ehjhml1emuk1v5r3br0";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('b9kd5bflqlbg5730umj7o50vl4', 1165599144, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:2:"31";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('dqu6i5n0vueak4eme17v3sslp7', 1165625721, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:25:"checkout_confirmation.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:9:"login.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"osCsid";s:26:"dqu6i5n0vueak4eme17v3sslp7";}s:4:"post";a:0:{}}}s:8:"snapshot";a:4:{s:4:"page";s:20:"checkout_payment.php";s:4:"mode";s:3:"SSL";s:3:"get";N;s:4:"post";N;}}'),
('7he22ivbl1mlt455uq3h9774a1', 1165585680, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:16:"manufacturers_id";s:2:"11";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('tlb1h4m2hnvd7fmsg28qmnr634', 1165646015, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('d5e65at8hfnqp7fh75s24qepo5', 1165624723, 'language|s:7:"english";languages_id|s:1:"1";selected_box|s:9:"customers";'),
('7t9a1ds0j2eqnkg25294rnbo60', 1165856844, 'cart|O:12:"shoppingCart":5:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:16:"product_info.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:3:{s:16:"manufacturers_id";s:2:"11";s:11:"products_id";s:2:"88";s:6:"osCsid";s:26:"7t9a1ds0j2eqnkg25294rnbo60";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('2rj6m07cpf1k4mu737o3aohfq0', 1165725852, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('3a2cnv7qaq2ne9qthoap6o5k54', 1165682767, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:0:{}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}'),
('irn1e09s8pahulmiceb7836pv0', 1165638953, 'cart|O:12:"shoppingCart":4:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;}language|s:7:"english";languages_id|s:1:"1";currency|s:3:"USD";navigation|O:17:"navigationHistory":2:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:9:"index.php";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:5:"cPath";s:2:"31";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}}');

-- --------------------------------------------------------

-- 
-- Table structure for table `specials`
-- 

DROP TABLE IF EXISTS `specials`;
CREATE TABLE IF NOT EXISTS `specials` (
  `specials_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL,
  `specials_new_products_price` decimal(15,4) NOT NULL,
  `specials_date_added` datetime default NULL,
  `specials_last_modified` datetime default NULL,
  `expires_date` datetime default NULL,
  `date_status_change` datetime default NULL,
  `status` int(1) NOT NULL default '1',
  PRIMARY KEY  (`specials_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `specials`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `tax_class`
-- 

DROP TABLE IF EXISTS `tax_class`;
CREATE TABLE IF NOT EXISTS `tax_class` (
  `tax_class_id` int(11) NOT NULL auto_increment,
  `tax_class_title` varchar(32) NOT NULL,
  `tax_class_description` varchar(255) NOT NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`tax_class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `tax_class`
-- 

INSERT INTO `tax_class` (`tax_class_id`, `tax_class_title`, `tax_class_description`, `last_modified`, `date_added`) VALUES (1, 'Taxable Goods', 'The following types of products are included non-food, services, etc', '2006-09-16 21:36:18', '2006-09-16 21:36:18');

-- --------------------------------------------------------

-- 
-- Table structure for table `tax_rates`
-- 

DROP TABLE IF EXISTS `tax_rates`;
CREATE TABLE IF NOT EXISTS `tax_rates` (
  `tax_rates_id` int(11) NOT NULL auto_increment,
  `tax_zone_id` int(11) NOT NULL,
  `tax_class_id` int(11) NOT NULL,
  `tax_priority` int(5) default '1',
  `tax_rate` decimal(7,4) NOT NULL,
  `tax_description` varchar(255) NOT NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`tax_rates_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `tax_rates`
-- 

INSERT INTO `tax_rates` (`tax_rates_id`, `tax_zone_id`, `tax_class_id`, `tax_priority`, `tax_rate`, `tax_description`, `last_modified`, `date_added`) VALUES (1, 2, 1, 1, '7.0000', 'NJ TAX 7.0%', '2006-09-16 22:04:09', '2006-09-16 21:36:18');

-- --------------------------------------------------------

-- 
-- Table structure for table `whos_online`
-- 

DROP TABLE IF EXISTS `whos_online`;
CREATE TABLE IF NOT EXISTS `whos_online` (
  `customer_id` int(11) default NULL,
  `full_name` varchar(64) NOT NULL,
  `session_id` varchar(128) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `time_entry` varchar(14) NOT NULL,
  `time_last_click` varchar(14) NOT NULL,
  `last_page_url` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `whos_online`
-- 

INSERT INTO `whos_online` (`customer_id`, `full_name`, `session_id`, `ip_address`, `time_entry`, `time_last_click`, `last_page_url`) VALUES (0, 'Guest', '9jgecgt30utooh2lqidv3naiv2', '', '1165955708', '1165955708', '');

-- --------------------------------------------------------

-- 
-- Table structure for table `zones`
-- 

DROP TABLE IF EXISTS `zones`;
CREATE TABLE IF NOT EXISTS `zones` (
  `zone_id` int(11) NOT NULL auto_increment,
  `zone_country_id` int(11) NOT NULL,
  `zone_code` varchar(32) NOT NULL,
  `zone_name` varchar(32) NOT NULL,
  PRIMARY KEY  (`zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=182 DEFAULT CHARSET=latin1 AUTO_INCREMENT=182 ;

-- 
-- Dumping data for table `zones`
-- 

INSERT INTO `zones` (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES (1, 223, 'AL', 'Alabama'),
(2, 223, 'AK', 'Alaska'),
(3, 223, 'AS', 'American Samoa'),
(4, 223, 'AZ', 'Arizona'),
(5, 223, 'AR', 'Arkansas'),
(6, 223, 'AF', 'Armed Forces Africa'),
(7, 223, 'AA', 'Armed Forces Americas'),
(8, 223, 'AC', 'Armed Forces Canada'),
(9, 223, 'AE', 'Armed Forces Europe'),
(10, 223, 'AM', 'Armed Forces Middle East'),
(11, 223, 'AP', 'Armed Forces Pacific'),
(12, 223, 'CA', 'California'),
(13, 223, 'CO', 'Colorado'),
(14, 223, 'CT', 'Connecticut'),
(15, 223, 'DE', 'Delaware'),
(16, 223, 'DC', 'District of Columbia'),
(17, 223, 'FM', 'Federated States Of Micronesia'),
(18, 223, 'FL', 'Florida'),
(19, 223, 'GA', 'Georgia'),
(20, 223, 'GU', 'Guam'),
(21, 223, 'HI', 'Hawaii'),
(22, 223, 'ID', 'Idaho'),
(23, 223, 'IL', 'Illinois'),
(24, 223, 'IN', 'Indiana'),
(25, 223, 'IA', 'Iowa'),
(26, 223, 'KS', 'Kansas'),
(27, 223, 'KY', 'Kentucky'),
(28, 223, 'LA', 'Louisiana'),
(29, 223, 'ME', 'Maine'),
(30, 223, 'MH', 'Marshall Islands'),
(31, 223, 'MD', 'Maryland'),
(32, 223, 'MA', 'Massachusetts'),
(33, 223, 'MI', 'Michigan'),
(34, 223, 'MN', 'Minnesota'),
(35, 223, 'MS', 'Mississippi'),
(36, 223, 'MO', 'Missouri'),
(37, 223, 'MT', 'Montana'),
(38, 223, 'NE', 'Nebraska'),
(39, 223, 'NV', 'Nevada'),
(40, 223, 'NH', 'New Hampshire'),
(41, 223, 'NJ', 'New Jersey'),
(42, 223, 'NM', 'New Mexico'),
(43, 223, 'NY', 'New York'),
(44, 223, 'NC', 'North Carolina'),
(45, 223, 'ND', 'North Dakota'),
(46, 223, 'MP', 'Northern Mariana Islands'),
(47, 223, 'OH', 'Ohio'),
(48, 223, 'OK', 'Oklahoma'),
(49, 223, 'OR', 'Oregon'),
(50, 223, 'PW', 'Palau'),
(51, 223, 'PA', 'Pennsylvania'),
(52, 223, 'PR', 'Puerto Rico'),
(53, 223, 'RI', 'Rhode Island'),
(54, 223, 'SC', 'South Carolina'),
(55, 223, 'SD', 'South Dakota'),
(56, 223, 'TN', 'Tennessee'),
(57, 223, 'TX', 'Texas'),
(58, 223, 'UT', 'Utah'),
(59, 223, 'VT', 'Vermont'),
(60, 223, 'VI', 'Virgin Islands'),
(61, 223, 'VA', 'Virginia'),
(62, 223, 'WA', 'Washington'),
(63, 223, 'WV', 'West Virginia'),
(64, 223, 'WI', 'Wisconsin'),
(65, 223, 'WY', 'Wyoming'),
(66, 38, 'AB', 'Alberta'),
(67, 38, 'BC', 'British Columbia'),
(68, 38, 'MB', 'Manitoba'),
(69, 38, 'NF', 'Newfoundland'),
(70, 38, 'NB', 'New Brunswick'),
(71, 38, 'NS', 'Nova Scotia'),
(72, 38, 'NT', 'Northwest Territories'),
(73, 38, 'NU', 'Nunavut'),
(74, 38, 'ON', 'Ontario'),
(75, 38, 'PE', 'Prince Edward Island'),
(76, 38, 'QC', 'Quebec'),
(77, 38, 'SK', 'Saskatchewan'),
(78, 38, 'YT', 'Yukon Territory'),
(79, 81, 'NDS', 'Niedersachsen'),
(80, 81, 'BAW', 'Baden-W?rttemberg'),
(81, 81, 'BAY', 'Bayern'),
(82, 81, 'BER', 'Berlin'),
(83, 81, 'BRG', 'Brandenburg'),
(84, 81, 'BRE', 'Bremen'),
(85, 81, 'HAM', 'Hamburg'),
(86, 81, 'HES', 'Hessen'),
(87, 81, 'MEC', 'Mecklenburg-Vorpommern'),
(88, 81, 'NRW', 'Nordrhein-Westfalen'),
(89, 81, 'RHE', 'Rheinland-Pfalz'),
(90, 81, 'SAR', 'Saarland'),
(91, 81, 'SAS', 'Sachsen'),
(92, 81, 'SAC', 'Sachsen-Anhalt'),
(93, 81, 'SCN', 'Schleswig-Holstein'),
(94, 81, 'THE', 'Th?ringen'),
(95, 14, 'WI', 'Wien'),
(96, 14, 'NO', 'Nieder?sterreich'),
(97, 14, 'OO', 'Ober?sterreich'),
(98, 14, 'SB', 'Salzburg'),
(99, 14, 'KN', 'K?rnten'),
(100, 14, 'ST', 'Steiermark'),
(101, 14, 'TI', 'Tirol'),
(102, 14, 'BL', 'Burgenland'),
(103, 14, 'VB', 'Voralberg'),
(104, 204, 'AG', 'Aargau'),
(105, 204, 'AI', 'Appenzell Innerrhoden'),
(106, 204, 'AR', 'Appenzell Ausserrhoden'),
(107, 204, 'BE', 'Bern'),
(108, 204, 'BL', 'Basel-Landschaft'),
(109, 204, 'BS', 'Basel-Stadt'),
(110, 204, 'FR', 'Freiburg'),
(111, 204, 'GE', 'Genf'),
(112, 204, 'GL', 'Glarus'),
(113, 204, 'JU', 'Graub?nden'),
(114, 204, 'JU', 'Jura'),
(115, 204, 'LU', 'Luzern'),
(116, 204, 'NE', 'Neuenburg'),
(117, 204, 'NW', 'Nidwalden'),
(118, 204, 'OW', 'Obwalden'),
(119, 204, 'SG', 'St. Gallen'),
(120, 204, 'SH', 'Schaffhausen'),
(121, 204, 'SO', 'Solothurn'),
(122, 204, 'SZ', 'Schwyz'),
(123, 204, 'TG', 'Thurgau'),
(124, 204, 'TI', 'Tessin'),
(125, 204, 'UR', 'Uri'),
(126, 204, 'VD', 'Waadt'),
(127, 204, 'VS', 'Wallis'),
(128, 204, 'ZG', 'Zug'),
(129, 204, 'ZH', 'Z?rich'),
(130, 195, 'A Coru?a', 'A Coru?a'),
(131, 195, 'Alava', 'Alava'),
(132, 195, 'Albacete', 'Albacete'),
(133, 195, 'Alicante', 'Alicante'),
(134, 195, 'Almeria', 'Almeria'),
(135, 195, 'Asturias', 'Asturias'),
(136, 195, 'Avila', 'Avila'),
(137, 195, 'Badajoz', 'Badajoz'),
(138, 195, 'Baleares', 'Baleares'),
(139, 195, 'Barcelona', 'Barcelona'),
(140, 195, 'Burgos', 'Burgos'),
(141, 195, 'Caceres', 'Caceres'),
(142, 195, 'Cadiz', 'Cadiz'),
(143, 195, 'Cantabria', 'Cantabria'),
(144, 195, 'Castellon', 'Castellon'),
(145, 195, 'Ceuta', 'Ceuta'),
(146, 195, 'Ciudad Real', 'Ciudad Real'),
(147, 195, 'Cordoba', 'Cordoba'),
(148, 195, 'Cuenca', 'Cuenca'),
(149, 195, 'Girona', 'Girona'),
(150, 195, 'Granada', 'Granada'),
(151, 195, 'Guadalajara', 'Guadalajara'),
(152, 195, 'Guipuzcoa', 'Guipuzcoa'),
(153, 195, 'Huelva', 'Huelva'),
(154, 195, 'Huesca', 'Huesca'),
(155, 195, 'Jaen', 'Jaen'),
(156, 195, 'La Rioja', 'La Rioja'),
(157, 195, 'Las Palmas', 'Las Palmas'),
(158, 195, 'Leon', 'Leon'),
(159, 195, 'Lleida', 'Lleida'),
(160, 195, 'Lugo', 'Lugo'),
(161, 195, 'Madrid', 'Madrid'),
(162, 195, 'Malaga', 'Malaga'),
(163, 195, 'Melilla', 'Melilla'),
(164, 195, 'Murcia', 'Murcia'),
(165, 195, 'Navarra', 'Navarra'),
(166, 195, 'Ourense', 'Ourense'),
(167, 195, 'Palencia', 'Palencia'),
(168, 195, 'Pontevedra', 'Pontevedra'),
(169, 195, 'Salamanca', 'Salamanca'),
(170, 195, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife'),
(171, 195, 'Segovia', 'Segovia'),
(172, 195, 'Sevilla', 'Sevilla'),
(173, 195, 'Soria', 'Soria'),
(174, 195, 'Tarragona', 'Tarragona'),
(175, 195, 'Teruel', 'Teruel'),
(176, 195, 'Toledo', 'Toledo'),
(177, 195, 'Valencia', 'Valencia'),
(178, 195, 'Valladolid', 'Valladolid'),
(179, 195, 'Vizcaya', 'Vizcaya'),
(180, 195, 'Zamora', 'Zamora'),
(181, 195, 'Zaragoza', 'Zaragoza');

-- --------------------------------------------------------

-- 
-- Table structure for table `zones_to_geo_zones`
-- 

DROP TABLE IF EXISTS `zones_to_geo_zones`;
CREATE TABLE IF NOT EXISTS `zones_to_geo_zones` (
  `association_id` int(11) NOT NULL auto_increment,
  `zone_country_id` int(11) NOT NULL,
  `zone_id` int(11) default NULL,
  `geo_zone_id` int(11) default NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`association_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `zones_to_geo_zones`
-- 

