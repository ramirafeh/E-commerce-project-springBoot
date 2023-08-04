
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `springproject` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `springproject`;


<<<<<<< Updated upstream
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `categoryid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

TRUNCATE TABLE `categories`;

INSERT DELAYED IGNORE INTO `categories` (`categoryid`, `name`) VALUES
=======
DROP TABLE IF EXISTS categories;
CREATE TABLE IF NOT EXISTS categories (
  categoryid int(11) NOT NULL AUTO_INCREMENT,
  c_name varchar(255) NOT NULL,
  PRIMARY KEY (categoryid)
);

TRUNCATE TABLE categories;

INSERT INTO categories (categoryid, c_name) VALUES
>>>>>>> Stashed changes
(6, 'category6'),
(8, 'veggi'),
(11, 'fruit');

<<<<<<< Updated upstream
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
=======
DROP TABLE IF EXISTS products;
CREATE TABLE IF NOT EXISTS products (
  id int(11) NOT NULL AUTO_INCREMENT,
  p_name varchar(255) NOT NULL,
  image text NOT NULL,
  categoryid int(11) NOT NULL,
  quantity int(11) NOT NULL,
  price float(11,2) NOT NULL,
  weight int(11) NOT NULL,
  p_description text NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (categoryid) REFERENCES categories(categoryid)
);
TRUNCATE TABLE products;

INSERT INTO products (id, p_name, image, categoryid, quantity, price, weight, p_description) VALUES
>>>>>>> Stashed changes
(14, 'dfgdg', '1.jpg', 6, 72, 24, 27, ''),
(15, 'dfgdg', '2.jpg', 6, 7, 25, 27, ''),
(16, 'apple', '2.jpg', 11, 5, 30, 10, 'red python');

<<<<<<< Updated upstream
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


=======
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
  user_id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(20) NOT NULL,
  u_password varchar(20) NOT NULL,
  u_role varchar(250) NOT NULL DEFAULT 'ROLE_USERS',
  enabled tinyint(4) DEFAULT NULL,
  email varchar(110) NOT NULL,
  up_to_100_spending float(11,2),
  coupons int(11),
  address varchar(250),
  PRIMARY KEY (user_id)
);

TRUNCATE TABLE users;

INSERT INTO users (user_id, username, u_password, u_role, enabled, email, up_to_100_spending, coupons, address ) VALUES
(1, 'jay', '123', 'ROLE_USER', 1, 'gajerajay9@gmail.com', 80, 0, '1st Street'),
(2, 'admin', '123', 'ROLE_ADMIN', 1, '20ceuos042@ddu.ac.in', 0, 0, ' '),
(3, 'don', '123', 'ROLE_USER', 1, 'gajerajay@gmail.com', 0, 1, '1st Street'),
(4, 'lan', '123', 'ROLE_USER', 1, 'gajerajay@gmail.com', 99, 0, '1st Street');

DROP TABLE IF EXISTS purchases;
CREATE TABLE IF NOT EXISTS purchases (
  purchases_id int(11) NOT NULL AUTO_INCREMENT,
  purchases_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  basketid int(11) NOT NULL,
  user_id  int(11) NOT NULL,
  amount float(11,2) NOT NULL,
  PRIMARY KEY (purchases_id),
  FOREIGN KEY (basketid) REFERENCES basket(basketid),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
) ;

INSERT INTO purchases (purchases_id , purchases_date, basketid, user_id, amount) VALUES
(0011, 2023-01-01, 22, 4, 99);

 DROP TABLE IF EXISTS basket;
CREATE TABLE IF NOT EXISTS basket (
  basketid int(11) NOT NULL AUTO_INCREMENT,
  if_empty varchar(3) NOT NULL,
	user_id int(11) NOT NULL,
	product_id  int(11) ,
  product_quantity int(11) NOT NULL,
  PRIMARY KEY (basketid),
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (user_id) REFERENCES  users(user_id)
);
SELECT p1.product_id AS product1, p2.product_id AS product2, COUNT(*) AS frequency
FROM   basket p1
JOIN   basket p2 ON p1.user_id = p2.user_id AND p1.product_id < p2.product_id 
Where exists( select basketid from purchases)
GROUP BY p1.product_id, p2.product_id
HAVING frequency >= (SELECT COUNT(*) FROM purchases) * 0.8;

INSERT INTO basket ( basketid, if_empty, user_id,product_id, product_quantity ) VALUES
(0011,"no", 1, 14, 1),
(0012,"no",3, 15, 2),
(0013,"no",4, 16, 3),
(0014,"no",2, 14, 3);

 

 DROP TABLE IF EXISTS suggestions;
CREATE TABLE IF NOT EXISTS suggestions(
  id int(11) NOT NULL AUTO_INCREMENT,
  product_id  int(11) ,
  product_suggested_id  int(11) ,  
  PRIMARY KEY (id),
  FOREIGN KEY (product_id) REFERENCES products(id),
   FOREIGN KEY (product_suggested_id) REFERENCES products(id)
) ;

INSERT INTO suggestions ( id, product_id , product_suggested_id) VALUES
(01, 14, 15),
(02, 15, 16);

delimiter //
CREATE TRIGGER coupons AFTER UPDATE
ON Users
FOR EACH ROW
IF up_to_100_spending >100 THEN
SET  up_to_100_spending= (up_to_100_spending- 100) AND 
 coupons = coupons+1;
END IF;
delimiter ;
>>>>>>> Stashed changes

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
