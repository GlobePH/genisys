/*
SQLyog Community Edition- MySQL GUI v6.55
MySQL - 5.6.13 : Database - app_paluwagan
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`app_paluwagan` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `app_paluwagan`;

/*Table structure for table `_empty` */

DROP TABLE IF EXISTS `_empty`;

CREATE TABLE `_empty` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `_empty` */

/*Table structure for table `crowd` */

DROP TABLE IF EXISTS `crowd`;

CREATE TABLE `crowd` (
  `crowdID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `crowdName` char(255) NOT NULL DEFAULT '',
  `createBy` bigint(11) NOT NULL DEFAULT '0',
  `createDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `joinFee` float NOT NULL DEFAULT '0',
  `walletID` int(11) NOT NULL DEFAULT '0',
  `avatarURL` char(255) NOT NULL DEFAULT '',
  `shareImage` char(255) NOT NULL DEFAULT '',
  `shareWidth` int(11) NOT NULL DEFAULT '0',
  `shareHeight` int(11) NOT NULL DEFAULT '0',
  `shareTitle` char(255) NOT NULL DEFAULT '',
  `shareDescription` char(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`crowdID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `crowd` */

insert  into `crowd`(`crowdID`,`crowdName`,`createBy`,`createDate`,`joinFee`,`walletID`,`avatarURL`,`shareImage`,`shareWidth`,`shareHeight`,`shareTitle`,`shareDescription`) values (1,'Ultimate Pinoy Paluwagan 100',0,'2017-07-22 16:00:04',100,2,'paluwagan-100.png','',0,0,'',''),(2,'Ultimate Pinoy Paluwagan 10',0,'2017-07-22 16:00:18',10,4,'paluwagan-10.png','',0,0,'',''),(3,'Ultimate Pinoy Paluwagan 1000',0,'2017-07-22 16:00:19',1000,5,'paluwagan-1000.png','',0,0,'','');

/*Table structure for table `crowd_nodes` */

DROP TABLE IF EXISTS `crowd_nodes`;

CREATE TABLE `crowd_nodes` (
  `nodeID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parentID` int(11) NOT NULL DEFAULT '0',
  `crowdID` int(11) NOT NULL DEFAULT '0',
  `createDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userID` bigint(11) NOT NULL DEFAULT '0',
  `userParent` bigint(11) NOT NULL DEFAULT '0',
  `status` char(10) NOT NULL DEFAULT '',
  `amount` float NOT NULL DEFAULT '0',
  `transID` int(11) NOT NULL DEFAULT '0',
  `payoutOK` int(11) NOT NULL DEFAULT '0',
  `payoutID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`nodeID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `crowd_nodes` */

insert  into `crowd_nodes`(`nodeID`,`parentID`,`crowdID`,`createDate`,`confirmDate`,`userID`,`userParent`,`status`,`amount`,`transID`,`payoutOK`,`payoutID`) values (1,0,1,'2017-07-23 00:36:12','2017-07-23 00:36:12',0,0,'success',0,0,0,0),(2,1,1,'2017-07-23 00:10:49','2017-07-23 00:10:49',260855927736184,0,'success',100,12345678,0,0),(3,2,1,'2017-07-23 00:13:13','2017-07-23 00:13:13',10159068829775188,260855927736184,'success',100,4235345,0,0),(4,2,1,'2017-07-23 00:14:55','2017-07-23 00:14:55',1572817366070110,260855927736184,'success',100,43524534,0,0),(5,0,2,'2017-07-23 00:46:16','2017-07-23 00:46:16',0,0,'success',0,0,0,0),(6,5,2,'2017-07-23 00:46:18','2017-07-23 00:46:18',46546456546456,260855927736184,'success',10,567575,1,0),(7,6,2,'2017-07-23 00:53:12','2017-07-23 00:53:12',260855927736184,1572817366070110,'success',10,4432242,0,0),(8,0,3,'2017-07-23 10:32:58','2017-07-23 10:32:58',0,0,'success',1000,0,0,0);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `facebookID` bigint(10) NOT NULL DEFAULT '0',
  `firstName` char(255) NOT NULL DEFAULT '',
  `lastName` char(255) NOT NULL DEFAULT '',
  `emailAddr` char(255) NOT NULL DEFAULT '',
  `avatarURL` char(255) NOT NULL DEFAULT '',
  `createDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifyDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `loginDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`facebookID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`facebookID`,`firstName`,`lastName`,`emailAddr`,`avatarURL`,`createDate`,`modifyDate`,`loginDate`) values (260855927736184,'Zorex','Salvo','zorexsalvo.developer@gmail.com','https://scontent.xx.fbcdn.net/v/t1.0-1/c91.10.239.239/s50x50/15171155_105566673265111_8189515953604007102_n.jpg?oh=621f3f6867b09114a91563c17e67512d&oe=59F13197','2017-07-22 23:47:25','2017-07-22 23:47:25','2017-07-23 12:37:59'),(1126434634167427,'Kristine','Costo','jscosto@yahoo.com','https://scontent.xx.fbcdn.net/v/t1.0-1/c81.29.363.363/s50x50/488048_107051952772372_1262193861_n.jpg?oh=7f512f7ddac8cd6310743c6cdc890519&oe=5A0D4E19','2017-07-23 10:49:50','2017-07-23 10:49:50','2017-07-23 11:47:26'),(1572817366070110,'Zorex','Rivera Salvo','zorexsalvo@gmail.com','https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/19149341_1534584563226724_3102119751899017142_n.jpg?oh=eaafe4736531b95915ec91cdbed16d95&oe=5A10C852','2017-07-22 23:55:38','2017-07-22 23:55:38','2017-07-22 23:55:38'),(10159068829775188,'Raymond','Morfe','raymondmorfe@yahoo.com','https://scontent.xx.fbcdn.net/v/t1.0-1/c77.9.434.434/s50x50/8664_10152904927810188_20182015_n.jpg?oh=a808be7646d6aadfd251a9cb5a31dff5&oe=59EB0661','2017-07-23 00:04:33','2017-07-23 00:04:33','2017-07-23 00:04:33');

/*Table structure for table `users_activities` */

DROP TABLE IF EXISTS `users_activities`;

CREATE TABLE `users_activities` (
  `activityID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userID` bigint(11) NOT NULL DEFAULT '0',
  `activity` char(10) NOT NULL DEFAULT '',
  `activityType` char(10) NOT NULL DEFAULT '',
  `activityParam` char(100) NOT NULL DEFAULT '',
  `activityDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`activityID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `users_activities` */

insert  into `users_activities`(`activityID`,`userID`,`activity`,`activityType`,`activityParam`,`activityDate`) values (1,3,'click','','','2017-07-22 17:54:53'),(2,3,'share','','','2017-07-22 17:55:35');

/*Table structure for table `users_facebook` */

DROP TABLE IF EXISTS `users_facebook`;

CREATE TABLE `users_facebook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_provider` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `oauth_uid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `picture_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `profile_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `users_facebook` */

/*Table structure for table `wallets` */

DROP TABLE IF EXISTS `wallets`;

CREATE TABLE `wallets` (
  `walletID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `walletType` char(10) NOT NULL DEFAULT '',
  `walletTypeID` bigint(11) NOT NULL DEFAULT '0',
  `balanceAmount` float NOT NULL DEFAULT '0',
  `availAmount` float NOT NULL DEFAULT '0',
  `createDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`walletID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `wallets` */

insert  into `wallets`(`walletID`,`walletType`,`walletTypeID`,`balanceAmount`,`availAmount`,`createDate`) values (1,'master',0,-3000,-3000,'2017-07-22 15:20:08'),(2,'crowd',1,0,0,'2017-07-22 15:20:19'),(4,'crowd',2,0,0,'2017-07-22 16:01:39'),(5,'crowd',3,0,0,'2017-07-22 16:01:41'),(15,'user',1572817366070110,1000,1000,'2017-07-22 23:55:38'),(16,'user',260855927736184,1000,1000,'2017-07-22 23:56:42'),(17,'user',10159068829775188,1000,1000,'2017-07-23 00:04:33'),(18,'user',1126434634167427,47250,47250,'2017-07-23 10:49:51');

/*Table structure for table `wallets_transactions` */

DROP TABLE IF EXISTS `wallets_transactions`;

CREATE TABLE `wallets_transactions` (
  `transID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transType` char(10) NOT NULL DEFAULT '',
  `transDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sourceWallet` int(11) NOT NULL DEFAULT '0',
  `targetWallet` int(11) NOT NULL DEFAULT '0',
  `amount` float NOT NULL DEFAULT '0',
  `crowdID` int(11) NOT NULL DEFAULT '0',
  `nodeID` int(11) NOT NULL DEFAULT '0',
  `resultCode` int(11) NOT NULL DEFAULT '0',
  `external` char(10) NOT NULL DEFAULT '',
  `externalID` char(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`transID`)
) ENGINE=InnoDB AUTO_INCREMENT=123457 DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `wallets_transactions` */

insert  into `wallets_transactions`(`transID`,`transType`,`transDateTime`,`sourceWallet`,`targetWallet`,`amount`,`crowdID`,`nodeID`,`resultCode`,`external`,`externalID`) values (123451,'deposit','2017-07-22 15:29:16',1,3,500,0,0,0,'gcash','1234567890'),(123452,'withdraw','2017-07-22 15:29:20',3,1,2500,0,0,0,'gcash','1234567891'),(123453,'join','2017-07-22 15:28:09',3,2,100,1,0,0,'',''),(123454,'balance','2017-07-22 15:28:18',0,0,500,0,0,0,'',''),(123455,'unjoin','2017-07-22 15:50:59',2,3,2000,1,0,0,'',''),(123456,'dividend','2017-07-22 16:57:37',1,3,50,0,0,0,'','');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
