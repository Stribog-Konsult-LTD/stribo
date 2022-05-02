/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.5.4-MariaDB : Database - stribodemo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`stribodemo` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `stribodemo`;

/*Table structure for table `doctor` */

DROP TABLE IF EXISTS `doctor`;

CREATE TABLE `doctor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `uin_code` varchar(255) NOT NULL,
  `work_place` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_lqgyttf5b1riqpd2ncxslybd2` (`uin_code`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `doctor` */

insert  into `doctor`(`id`,`email`,`image_url`,`job_title`,`name`,`phone`,`uin_code`,`work_place`) values 
(2,'az@abv.bg','https://i.pravatar.cc/150?img=63','Терапевт','Иван Иванов','718573','123','клиника света Анна'),
(3,'stamat@fmail.com','https://i.pravatar.cc/150?img=68','Хирург','Стамат Пандурев','5464536345','11144534','Пирогов'),
(4,'maria@gmail.com','https://i.pravatar.cc/150?img=44','MD','Мария Маврудиева','4325432523','5435231','Света София');

/*Table structure for table `patients` */

DROP TABLE IF EXISTS `patients`;

CREATE TABLE `patients` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `doctor_id` bigint(20) DEFAULT NULL,
  `egn` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_hjfd0ljhcshoky6kyru1rc9hp` (`egn`),
  KEY `FKp3sio8ndn1g081mdebo8ta3m9` (`doctor_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `patients` */

insert  into `patients`(`id`,`doctor_id`,`egn`,`email`,`name`) values 
(2,2,'7402016677','pe6o@abv.bg','Петър Петров'),
(3,2,'7801034567','ivan@abv.bg','Иван Иванов'),
(4,3,'8903117624','jel@abv.bg','Желязко Славчев'),
(5,4,'5503048996','penka@abv.bg','Пенка Петкова'),
(6,4,'8803058975','ivan.v@abv.bg','Иван Василев');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
