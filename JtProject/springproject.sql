
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `springproject` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `springproject`;


DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `categoryid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

TRUNCATE TABLE `categories`;

INSERT DELAYED IGNORE INTO `categories` (`categoryid`, `name`) VALUES
(6, 'category6'),
(8, 'veggi'),
(11, 'fruit');

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image` text NOT NULL,
  `categoryid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` float(11,2) NOT NULL,
  `weight` int(11) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`categoryid`) REFERENCES `categories`(`categoryid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
TRUNCATE TABLE `products`;

INSERT DELAYED IGNORE INTO `products` (`id`, `name`, `image`, `categoryid`, `quantity`, `price`, `weight`, `description`) VALUES
(14, 'dfgdg', '1.jpg', 6, 72, 24, 27, ''),
(15, 'dfgdg', '2.jpg', 6, 7, 25, 27, ''),
(16, 'apple', '2.jpg', 11, 5, 30, 10, 'red python');

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `role` varchar(250) NOT NULL DEFAULT 'ROLE_USERS',
  `enabled` tinyint(4) DEFAULT NULL,
  `email` varchar(110) NOT NULL,
  `up to 100 spending` float(11,2),
  `Nr of Coupons` int(11),
  `address` varchar(250) ,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

TRUNCATE TABLE `users`;

INSERT DELAYED IGNORE INTO `users` (`user_id`, `username`, `password`, `role`, `enabled`, `email`, `up to 100 spending`, `Nr of Coupons`, `address` ) VALUES
(1, 'jay', '123', 'ROLE_USER', 1, 'gajerajay9@gmail.com', 80, 0, '1st Street'),
(2, 'admin', '123', 'ROLE_ADMIN', 1, '20ceuos042@ddu.ac.in', 0, 0, ' '),
(3, 'don', '123', 'ROLE_USER', 1, 'gajerajay@gmail.com', 0, 1, '1st Street'),
(4, 'lan', '123', 'ROLE_USER', 1, 'gajerajay@gmail.com', 99, 0, '1st Street');

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_date` date NOT NULL,
  `basketid` int(11) NOT NULL,
  `user_id`  int(11) NOT NULL,
  `amount` float(11,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  FOREIGN KEY (`basketid`) REFERENCES `basket`(`basketid`),
  FOREIGN KEY (`user_id`) REFERENCES  `users`(`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT DELAYED IGNORE INTO `orders` (`order_id`, `order_date`, `basketid`, `user_id`, `amount`) VALUES
(0011, 2023-01-01, 22, 4, 99);
 
 DROP TABLE IF EXISTS `basket`;
CREATE TABLE IF NOT EXISTS `basket` (
  `basketid` int(11) NOT NULL AUTO_INCREMENT,
  `if empty` varchar(3) NOT NULL,
  `product_id`  int(11) ,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`basketid`),
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
  FOREIGN KEY (`user_id`) REFERENCES  `users`(`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT DELAYED IGNORE INTO `basket` ( `basketid`, `if empty`, `id`, `user_id` ) VALUES
(0011, 2023-01-01, '', 1);
 

 DROP TABLE IF EXISTS `suggestions`;
CREATE TABLE IF NOT EXISTS `suggestions`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id`  int(11) ,
  `product_suggested_id`  int(11) ,  
  PRIMARY KEY (`id`),
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
   FOREIGN KEY (`product_suggested_id`) REFERENCES `products`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT DELAYED IGNORE INTO `suggestions` ( `id`, `product_id` , `product_suggested_id`) VALUES
(01, 14, 15),
(02, 15, 16);



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
