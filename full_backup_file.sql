-- MariaDB dump 10.19  Distrib 10.8.3-MariaDB, for osx10.17 (x86_64)
--
-- Host: 127.0.0.1    Database: myride_api
-- ------------------------------------------------------
-- Server version	10.6.8-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `passenger_id` int(10) unsigned NOT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `is_completed` tinyint(1) NOT NULL DEFAULT 0,
  `ride_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `booking_FK_1` (`passenger_id`),
  KEY `booking_FK_2` (`ride_id`),
  CONSTRAINT `booking_FK_1` FOREIGN KEY (`passenger_id`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_FK_2` FOREIGN KEY (`ride_id`) REFERENCES `ride` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `email` varchar(300) COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `bio` varchar(300) COLLATE utf8mb4_bin DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `profile_image` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL,
  `salt` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_unique_email` (`email`),
  UNIQUE KEY `user_unique_phone` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES
(48,'sample','name','test@email.com','*F0299B0557D35873CE2840CD984E701A12666FE3',NULL,NULL,NULL,NULL,NULL,'ed3500d2a78b4aad9c7e213c9fbe2a82.jpg','4a123058d1c6461eafd40061c17a1c30',1),
(50,'simran','grewal','samgrewal25@gmail.com','*EA6F858FB05E86A525DF04B2FE802D22A668D5FE',NULL,NULL,NULL,NULL,NULL,NULL,'9655c4e129a84e0a83718c6edc16d537',1),
(51,'satinder','singh','satindersingh772@gmail.com','*CDB9063FF1888731DB4AE45B878468A30CA2AE9C',NULL,NULL,NULL,NULL,NULL,NULL,'f52cd94e91fc41e396e4e82d7e576eb8',0),
(52,'nitnem','grewal','nitsarabha@gmail.com','*42F0B379FEBE8766CD30728B06FC1B813C7153DA',NULL,NULL,NULL,'I am nitnem singh grewal',NULL,NULL,'f85941f885754b2f907f67c7077087e2',1);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_session`
--

DROP TABLE IF EXISTS `client_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_session_unique_token` (`token`),
  KEY `client_session_FK` (`client_id`),
  CONSTRAINT `client_session_FK` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_session`
--

LOCK TABLES `client_session` WRITE;
/*!40000 ALTER TABLE `client_session` DISABLE KEYS */;
INSERT INTO `client_session` VALUES
(187,'03991814452243f282724340c3ca6751',48,'2022-11-18 07:28:00'),
(188,'bb8e5edae827449eb151baad423bbcb2',48,'2022-11-18 13:28:47'),
(189,'311562b4cc114e9b8062cf11b03fde81',48,'2022-11-18 14:38:48'),
(192,'44ba52fa3d78413689b67358a798031a',50,'2022-11-19 02:52:47'),
(193,'dc36af5198e24d80991e4481fcdf0a5f',50,'2022-11-19 03:14:49'),
(195,'89606e8d32524d39b4a8b9137cc4d6ce',51,'2022-11-21 17:52:09'),
(196,'fd3df3e3d8184509a58d0bf093d67ba5',51,'2022-11-22 05:07:08'),
(197,'d42f04ab5fea4bdda199ec51015a9070',51,'2022-11-24 01:04:21'),
(200,'ccf39e02a820447db1dfd8b089eb9fe5',52,'2022-11-28 18:33:26');
/*!40000 ALTER TABLE `client_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ride`
--

DROP TABLE IF EXISTS `ride`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ride` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_city` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `to_city` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `travel_date` date NOT NULL,
  `leave_time` varchar(15) COLLATE utf8mb4_bin NOT NULL,
  `rider_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `from_prov` varchar(2) COLLATE utf8mb4_bin NOT NULL,
  `to_prov` varchar(2) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ride_FK` (`rider_id`),
  CONSTRAINT `ride_FK` FOREIGN KEY (`rider_id`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ride`
--

LOCK TABLES `ride` WRITE;
/*!40000 ALTER TABLE `ride` DISABLE KEYS */;
INSERT INTO `ride` VALUES
(74,'saskatoon','toronto','2022-11-23','06:30 PM',48,'2022-11-18 06:56:46','SK','ON'),
(76,'edmonton','calgary ','2022-11-18','03:15 PM',50,'2022-11-19 02:54:39','NB','BC'),
(77,'edmonton','calgary','2022-11-30','04:30 PM',52,'2022-11-28 18:39:37','AB','AB');
/*!40000 ALTER TABLE `ride` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'myride_api'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `booking_passenger_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `booking_passenger_delete`(booking_id_input int unsigned, token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	delete b
	from booking b inner join client_session cs on cs.client_id = b.passenger_id
	where b.id = booking_id_input and cs.token = token_input;
	
	select row_count() as row_count;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `booking_passenger_get` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `booking_passenger_get`(id_input int unsigned, token_input varchar(100))
BEGIN
	select 
	b.id  as booking_id,
	b.is_confirmed as is_confirmed,
	b.is_completed as is_completed,
	convert (r.from_city using utf8) as from_city ,
	convert(r.to_city using utf8) as to_city,
	convert(r.travel_date using utf8) as travel_date,
	convert (r.leave_time using utf8) as leave_time ,
	convert (r.to_prov using utf8) as to_prov,
	convert (r.from_prov using utf8) as from_prov,
	r.rider_id as rider_id ,
	r.id as ride_id ,
	convert(c.first_name using utf8) as rider_first_name,
	convert(c.last_name using utf8) as rider_last_name,
	convert(c.phone_number using utf8) as rider_phone_number,
	convert (c.email using utf8) as rider_email
	
	from client_session cs inner join booking b on cs.client_id = b.passenger_id inner join ride r on b.ride_id = r.id
	inner join client c on r.rider_id = c.id
	
	where cs.token = token_input and b.passenger_id = id_input;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `booking_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `booking_post`(ride_id_input int unsigned,token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	insert into booking (passenger_id,ride_id)
	select c.id , ride_id_input
	from client_session cs inner join client c on c.id = cs.client_id 
	where cs.token = token_input and c.verified = 1;
	select LAST_INSERT_ID() as booking_id; 
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `booking_rider_get` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `booking_rider_get`(ride_id_input int unsigned, token_input varchar(100))
BEGIN
	select
	r.id as ride_id,
	b.id as booking_id,
	b.is_confirmed as is_confirmed,
	b.is_completed  as is_completed,
	convert (c.first_name using utf8) as passenger_first_name,
	convert (c.last_name using utf8) as passenger_last_name,
	convert(c.phone_number using utf8) as phone_number, 
	convert (c.email using utf8) as email
	
	from client_session cs inner join ride r on cs.client_id = r.rider_id inner join booking b on r.id = b.ride_id inner join client c on c.id = b.passenger_id 
	where cs.token = token_input and r.id = ride_id_input ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `booking_rider_patch_complete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `booking_rider_patch_complete`(booking_id_input int unsigned,token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	update booking b inner join ride r on r.id = b.ride_id inner join client_session cs on cs.client_id = r.rider_id  
	set b.is_confirmed = 1, b.is_completed = 1
	where b.id = booking_id_input AND  cs.token = token_input;
	commit;
	select
	b.is_completed as is_completed
	from booking b inner join ride r on r.id  = b.ride_id inner join client_session cs on r.rider_id = cs.client_id
	where b.id = booking_id_input and cs.token = token_input;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `booking_rider_patch_confirm` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `booking_rider_patch_confirm`(booking_id_input int unsigned ,token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	 
	update booking b inner join ride r on r.id = b.ride_id inner join client_session cs on cs.client_id = r.rider_id  
	set b.is_confirmed = 1
	where b.id = booking_id_input AND  cs.token = token_input;
	commit;
	select 
	b.is_confirmed as is_confirmed 
	from booking b inner join ride r on r.id = b.ride_id inner join client_session cs on cs.client_id = r.rider_id 
	where b.id = booking_id_input and cs.token = token_input ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_delete`(password_input varchar(100), token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	delete c
	from client c inner join client_session cs on cs.client_id = c.id 
	where cs.token = token_input and c.verified = 1 and password = password(concat(password_input ,(select salt where cs.token = token_input)));
	select row_count() as row_count;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_get` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_get`(id_input int unsigned)
BEGIN
	select 
	convert (c.first_name using utf8) as first_name,
	convert (c.last_name using utf8) as last_name,
	convert (c.email using utf8) as email,
	convert (c.address using utf8) as address,
	convert (c.city using utf8) as city,
	convert (c.phone_number using utf8) as phone_number,
	convert (c.bio using utf8) as bio,
	convert (c.dob using utf8) as dob
	from client c  
	where c.id = id_input and c.verified = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_get_image` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_get_image`( id_input int unsigned)
BEGIN
	
	select 
	convert(c.profile_image using utf8) as profile_image
	from client c where c.id = id_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_get_with_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_get_with_token`(token_input varchar(100))
BEGIN
	SELECT 
	convert (c.first_name using utf8) as first_name,
	convert (c.last_name using utf8) as last_name,
	convert (c.email using utf8) as email,
	convert (c.address using utf8) as address,
	convert (c.city using utf8) as city,
	convert (c.phone_number using utf8) as phone_number,
	convert (c.bio using utf8) as bio,
	convert (c.dob using utf8) as dob
	FROM client c inner join client_session cs on cs.client_id = c.id
	where cs.token = token_input and c.verified = 1;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_login`(email_input varchar(300), password_input varchar(200),token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	insert into client_session(client_id,token)
	select c.id,token_input
	from client c 
	where c.email = lower(email_input) and password = password(concat(password_input, (select salt where c.email = lower(email_input))));
	
	select cs.client_id as client_id, convert(cs.token using utf8) as token
	from client_session cs where cs.token = token_input;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_logout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_logout`(token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	delete from client_session where token = token_input;
	select row_count() as row_count;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_old_image` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_old_image`(token_input varchar(100))
BEGIN
	SELECT convert (c.profile_image using utf8) as profile_image
	from client c inner join client_session cs on cs.client_id = c.id 
	where cs.token = token_input and c.verified = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_patch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_patch`(first_name_input varchar(100),last_name_input varchar(100),email_input varchar(300),
address_input varchar(100),city_input varchar(100),phone_number_input varchar(20),bio_input varchar(300),dob_input date,
token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	update client c inner join client_session cs on cs.client_id = c.id  
	set first_name = lower(first_name_input),last_name = lower(last_name_input),email = lower(email_input), address = lower(address_input),city =  lower(city_input),
	phone_number = phone_number_input, bio = bio_input, dob =  dob_input
	where cs.token = token_input and c.verified = 1;
	
	select row_count() as row_count;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_patch_image` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_patch_image`(profile_image_input varchar(200),token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	update client c inner join client_session cs on cs.client_id = c.id 
	set c.profile_image = profile_image_input where cs.token = token_input and c.verified = 1;
	commit;
	select 
	convert (c.profile_image using utf8) as profile_image
	FROM  client c inner join client_session cs on cs.client_id = c.id 
	where cs.token = token_input and c.verified = 1;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_patch_with_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_patch_with_password`(new_password_input varchar(200), old_password_input varchar(200),
token_input varchar(100),salt_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	update client c inner join client_session cs on cs.client_id = c.id  
	set password = password(concat(new_password_input,salt_input)),salt = salt_input
	where cs.token = token_input and c.verified = 1 and c.password = password (concat(old_password_input,(select salt where cs.token = token_input))) ;
	
	select row_count() as row_count;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_post`(first_name_input varchar(100),last_name_input varchar(100),
email_input varchar(300),password_input varchar(200),token_input varchar(100), salt_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	insert into client(first_name,last_name,email,password,salt)
	values(lower(first_name_input), lower(last_name_input),lower(email_input) ,password(concat(password_input,salt_input)),salt_input);
	
	insert into client_session (client_id,token)
	values (last_insert_id(),token_input);

    select cs.client_id as client_id ,convert(cs.token using utf8) as token
	FROM client_session cs 
	where token = token_input;
	commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_verified` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_verified`(token_input varchar(100))
BEGIN
	SELECT c.verified as verified
	from client c inner join client_session cs on cs.client_id = c.id 
	where cs.token = token_input;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_verify` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_verify`(verified_input bool,token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	update client c  inner join client_session cs on cs.client_id = c.id 
	set c.verified = verified_input
	where cs.token = token_input;
	
	select row_count() as row_count;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rides_filter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rides_filter`(from_input varchar(100),to_input varchar(100))
BEGIN
		select 
		r.id as ride_id,
		convert (r.from_city using utf8) as from_city,
		convert (r.from_prov using utf8) as from_prov,
		convert (r.to_prov using utf8) as to_prov,
		convert (r.to_city using utf8) as to_city,
		convert (r.travel_date using utf8) as travel_date ,
		convert (r.leave_time using utf8) as leave_time,
		r.rider_id as rider_id,
		convert (c.first_name using utf8) as rider_first_name, 
		convert (c.email using utf8) as rider_email
		
		from ride r inner join client c on c.id = r.rider_id 
		where r.from_city like concat("%",lower(from_input),"%") 
		and r.to_city like concat("%",lower(to_input),"%")
		and r.travel_date >= now();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rides_get_all` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rides_get_all`()
BEGIN
	select
	r.id as ride_id,
	convert (r.from_city using utf8) as from_city,
	convert (r.to_city using utf8) as to_city,
	convert (r.travel_date using utf8) as travel_date ,
	convert (r.leave_time using utf8) as leave_time,
	r.rider_id as rider_id,
	convert (c.email using utf8) as rider_email,
	convert (c.first_name using utf8) as rider_first_name,
	convert (r.from_prov using utf8) as from_prov,
	convert (r.to_prov using utf8) as to_prov
	from ride r inner join client c on c.id = r.rider_id
	where r.travel_date >= now();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ride_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ride_delete`(id_input int unsigned,token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	delete r
	from ride r inner join client c on c.id = r.rider_id inner join client_session cs on cs.client_id = c.id 
	where cs.token = token_input and r.id = id_input;
	
	select row_count() as row_count;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ride_get` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ride_get`(id_input int unsigned, token_input varchar(100))
BEGIN
	SELECT 
	r.id as ride_id,
	convert (r.from_city using utf8) as from_city,
	convert (r.to_city using utf8) as to_city,
	convert (r.travel_date using utf8) as travel_date,
	convert (r.leave_time using utf8) as leave_time,
	convert (r.from_prov using utf8) as from_prov,
	convert (r.to_prov using utf8) as to_prov,
	convert (c.first_name using utf8) as rider_first_name,
	convert (c.last_name using utf8) as rider_last_name
	
	
	from client c inner join client_session cs on cs.client_id = c.id inner join ride r on r.rider_id = c.id 
	where c.id = id_input and c.verified =1 and cs.token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ride_get_for_patch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ride_get_for_patch`(id_input int unsigned, token_input varchar(100))
BEGIN
	SELECT 
	r.id as ride_id,
	convert (r.from_city using utf8) as from_city,
	convert (r.to_city using utf8) as  to_city,
	convert (r.travel_date using utf8) as travel_date,
	convert (r.leave_time using utf8) as leave_time,
	convert (r.from_prov using utf8)  as from_prov,
	convert (r.to_prov using utf8) as to_prov,
	convert (c.first_name using utf8) as rider_first_name,
	convert (c.last_name using utf8) as rider_last_name
	
	from ride r  inner join client c on c.id = r.rider_id  inner join client_session cs on cs.client_id = c.id 
	where cs.token = token_input and r.id = id_input and c.verified =1 ;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ride_patch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ride_patch`(from_city_input varchar(100),from_prov_input varchar(2),to_city_input varchar(100),to_prov_input varchar(100),
date_input date,time_input varchar(15),id_input int unsigned, token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	update ride r  inner join client c on c.id = r.rider_id inner join client_session cs on cs.client_id = c.id
	set r.from_city = lower(from_city_input), r.to_city = lower(to_city_input), r.travel_date = date_input, r.leave_time = time_input,
	r.from_prov = from_prov_input, r.to_prov = to_prov_input
	where cs.token = token_input and r.id = id_input and c.verified = 1;
	SELECT row_count() as row_count;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ride_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ride_post`(from_input varchar(100),from_prov_input varchar(2),
to_input varchar(100),to_prov_input varchar(2),date_input date, time_input varchar(15),token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	insert into ride(from_city,to_city,travel_date,leave_time,rider_id,from_prov,to_prov)
	select lower(from_input), lower(to_input), date_input, time_input,cs.client_id,from_prov_input,to_prov_input
	from client_session cs inner join client c on c.id = cs.client_id 
	where cs.token = token_input and c.verified = 1;
		
	select LAST_INSERT_ID() as ride_id , row_count() as rides_posted_count; 

	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_post_all` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_post_all`(first_name_input varchar(100),last_name_input varchar(100),email_input varchar(300),
address_input varchar(100),city_input varchar(100),phone_number_input varchar(20),bio_input varchar(300),dob_input date,
profile_image_input varchar(200), token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	update client c inner join client_session cs on cs.client_id = c.id  
	set first_name = first_name_input,last_name = last_name_input,email = email_input, address = address_input,city =  city_input,
	phone_number = phone_number_input, bio = bio_input, dob =  dob_input, profile_image = profile_image_input
	where cs.token = token_input;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-28 13:37:35
