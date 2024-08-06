-- -------------------------------------------------------------
-- TablePlus 6.1.2(568)
--
-- https://tableplus.com/
--
-- Database: warehouse-tracking
-- Generation Time: 2024-08-06 16:13:38.2930
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS `distributors`;
CREATE TABLE `distributors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `item_trackings`;
CREATE TABLE `item_trackings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint unsigned DEFAULT NULL,
  `stock` bigint DEFAULT NULL,
  `stock_before` bigint DEFAULT NULL,
  `stock_after` bigint DEFAULT NULL,
  `updated_by_id` bigint unsigned DEFAULT NULL,
  `updated_by_role` longtext,
  `remark` longtext,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `current_stock` bigint unsigned DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `distributors` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Inc Laptop', '2024-08-06 02:33:12.000', '2024-08-06 02:33:12.000'),
(2, 'Tech Geek Store', '2024-08-06 02:33:12.000', '2024-08-06 02:33:12.000');

INSERT INTO `item_trackings` (`id`, `item_id`, `stock`, `stock_before`, `stock_after`, `updated_by_id`, `updated_by_role`, `remark`, `created_at`, `updated_at`) VALUES
(1, 1, 10, 0, 10, 1, 'Supplier', 'Purchasement', '2024-07-06 11:01:42.775', '2024-08-06 11:01:42.775'),
(2, 1, 10, 10, 20, 1, 'Supplier', 'Purchasement', '2024-07-06 11:02:54.476', '2024-08-06 11:02:54.476'),
(3, 1, 10, 20, 30, 1, 'Supplier', 'Purchasement', '2024-07-06 11:03:07.104', '2024-08-06 11:03:07.104'),
(4, 1, -10, 30, 20, 1, 'Supplier', 'Return', '2024-07-06 11:03:17.419', '2024-08-06 11:03:17.419'),
(5, 1, -10, 20, 10, 1, 'Distributor', 'Sales', '2024-07-06 11:04:11.515', '2024-08-06 11:04:11.515'),
(6, 1, -10, 10, 0, 1, 'Distributor', 'Sales', '2024-07-06 11:04:19.902', '2024-08-06 11:04:19.902'),
(7, 1, 10, 0, 10, 1, 'Distributor', 'Return', '2024-07-06 11:04:35.122', '2024-08-06 11:04:35.122'),
(8, 1, 10, 10, 20, 1, 'Supplier', 'Purchasement', '2024-08-06 11:20:51.682', '2024-08-06 11:20:51.682'),
(9, 2, 10, 0, 10, 1, 'Supplier', 'Purchasement', '2024-08-06 13:57:21.597', '2024-08-06 13:57:21.597'),
(10, 2, 5, 10, 15, 1, 'Supplier', 'Purchasement', '2024-08-06 13:57:29.168', '2024-08-06 13:57:29.168'),
(11, 2, 18, 15, 33, 1, 'Supplier', 'Purchasement', '2024-08-06 13:57:46.211', '2024-08-06 13:57:46.211'),
(12, 1, -10, 20, 10, 1, 'Supplier', 'Return', '2024-08-06 13:57:53.398', '2024-08-06 13:57:53.398'),
(13, 2, -10, 33, 23, 1, 'Supplier', 'Return', '2024-08-06 13:57:59.526', '2024-08-06 13:57:59.526'),
(14, 2, 30, 23, 53, 1, 'Supplier', 'Purchasement', '2024-08-06 13:58:10.433', '2024-08-06 13:58:10.433'),
(15, 3, 30, 0, 30, 1, 'Supplier', 'Purchasement', '2024-08-06 13:58:23.799', '2024-08-06 13:58:23.799'),
(16, 3, -10, 30, 20, 1, 'Supplier', 'Return', '2024-08-06 13:58:45.488', '2024-08-06 13:58:45.488'),
(17, 3, 20, 20, 40, 1, 'Supplier', 'Purchasement', '2024-08-06 13:58:58.589', '2024-08-06 13:58:58.589');

INSERT INTO `items` (`id`, `name`, `current_stock`, `created_at`, `updated_at`) VALUES
(1, 'Laptop Asus MSI', 10, '2024-07-06 10:31:36.834', '2024-08-06 13:57:53.392'),
(2, 'Laptop Lenovo A83713', 53, '2024-08-06 10:34:13.856', '2024-08-06 13:58:10.426'),
(3, 'Laptop Asus M2321', 40, '2024-08-06 13:57:14.011', '2024-08-06 13:58:58.583');

INSERT INTO `suppliers` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'ASUS', '2024-08-06 02:32:21.000', '2024-08-06 02:32:21.000'),
(2, 'Lenovo', '2024-08-06 02:32:21.000', '2024-08-06 02:32:21.000');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;