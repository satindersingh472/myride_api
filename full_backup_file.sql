-- MariaDB dump 10.19  Distrib 10.6.7-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: myride_api
-- ------------------------------------------------------
-- Server version	10.6.7-MariaDB-2ubuntu1.1

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,21,0,0,26,'2022-11-06 18:45:46'),(2,21,0,0,27,'2022-11-06 18:56:47'),(3,21,0,0,28,'2022-11-06 18:56:54'),(4,21,0,0,29,'2022-11-06 18:57:44'),(5,24,0,0,35,'2022-11-06 19:06:40'),(6,25,0,0,37,'2022-11-06 19:06:47'),(7,26,0,0,39,'2022-11-06 19:06:52'),(8,27,0,0,27,'2022-11-06 20:14:48'),(10,21,0,0,42,'2022-11-06 20:15:35'),(11,21,0,0,45,'2022-11-06 20:40:53'),(12,24,0,0,45,'2022-11-06 20:43:59'),(13,24,0,0,45,'2022-11-06 20:57:53'),(14,24,0,0,45,'2022-11-06 20:57:55'),(15,27,0,0,36,'2022-11-06 21:19:32'),(16,27,0,0,40,'2022-11-07 10:00:31'),(17,27,0,0,40,'2022-11-07 10:41:37'),(18,27,0,0,40,'2022-11-07 10:46:25'),(19,27,0,0,40,'2022-11-07 10:46:26'),(21,27,0,0,44,'2022-11-07 10:47:05');
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (21,'satinder','singh','satindersingh772@gmail.com','*DBA628DA0790B6320396FD364F7047245CC71429',NULL,NULL,NULL,NULL,NULL,'8666b6759e1041d89ef5fc9dadaa9ace.jpeg','c8e99f041b2f49e9bdca443b25aef2a9',1),(24,'sati','singh','satindersingh472@gmail.com','*B59177F379C99E6E315B17FBF197C0D3A0B8245E',NULL,NULL,NULL,NULL,NULL,NULL,'e5cf0abe3b344eedb5fdc259c1ef68d2',1),(25,'sam','grewal','samgrewal25@gmail.com','*415F74E3B47DB39B1B23D251EB6C976ECE6C6C4F',NULL,NULL,NULL,NULL,NULL,NULL,'7dc65414184f494a83946332faaaa54a',1),(26,'simranpreet','kaur','simranpreetgrewal@gmail.com','*6501D3B67278257D55C2C4B0F5FB7ED924B5B2DA',NULL,NULL,NULL,NULL,NULL,NULL,'ed60f41647344014b19c9b8d4d744faa',1),(27,'simranpreet','kaur','simranpreetgrewal24@gmail.com','*1DCC6D01A50D2BA30EAE460CD89FEB0FD7E93CF9',NULL,NULL,NULL,NULL,NULL,NULL,'e7e99784a7db487683db6eb6eba8de4d',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_session`
--

LOCK TABLES `client_session` WRITE;
/*!40000 ALTER TABLE `client_session` DISABLE KEYS */;
INSERT INTO `client_session` VALUES (90,'58234d2f4d6e4f09b1791de4e62ffbc2',21,'2022-11-05 10:46:42'),(91,'46a51e878b7449749b4cbdfdca6cb951',24,'2022-11-06 19:00:08'),(92,'3908a81d5ec143ce8de06984ce65b0e0',25,'2022-11-06 19:00:38'),(93,'9e50116f4a9d4dd4a98ae1b2eb4bb03e',26,'2022-11-06 19:01:05'),(94,'e3f334b6721b456bbf40eaee7e04777f',27,'2022-11-06 19:01:19');
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
  `leave_time` time NOT NULL,
  `rider_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ride_FK` (`rider_id`),
  CONSTRAINT `ride_FK` FOREIGN KEY (`rider_id`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ride`
--

LOCK TABLES `ride` WRITE;
/*!40000 ALTER TABLE `ride` DISABLE KEYS */;
INSERT INTO `ride` VALUES (23,'montreal','edmonton','2022-12-04','09:00:00',21,'2022-11-05 13:48:20'),(25,'montreal','edmonton','2022-12-04','05:00:00',21,'2022-11-05 13:48:21'),(26,'montreal','calgary','2022-11-15','05:00:00',21,'2022-11-05 13:56:38'),(27,'toronto','edmonton','2022-11-15','05:00:00',21,'2022-11-05 13:56:38'),(28,'toronto','edmonton','2022-11-15','05:00:00',21,'2022-11-05 13:57:10'),(29,'toronto','edmonton','2022-11-15','05:00:00',21,'2022-11-05 13:57:10'),(30,'saskatoon','edmonton','2022-11-15','05:00:00',21,'2022-11-05 13:57:54'),(31,'toronto','calgary','2022-11-15','05:00:00',21,'2022-11-05 13:57:55'),(32,'toronto','edmonton','2022-11-15','05:00:00',21,'2022-11-05 14:00:38'),(33,'toronto','edmonton','2022-11-15','05:00:00',21,'2022-11-05 14:00:39'),(34,'regina','edmonton','2022-11-04','05:00:00',21,'2022-11-05 14:00:40'),(35,'toronto','calgary','2022-11-15','05:00:00',21,'2022-11-05 14:00:41'),(36,'red deer','edmonton','2022-11-15','05:00:00',21,'2022-11-05 14:01:01'),(37,'toronto','edmonton','2022-11-01','05:00:00',21,'2022-11-05 14:01:08'),(38,'edson','edmonton','2022-11-15','05:00:00',21,'2022-11-05 14:01:14'),(39,'toronto','edmonton','2022-11-15','05:00:00',21,'2022-11-05 14:01:25'),(40,'toronto','vancouver','2022-11-15','05:00:00',21,'2022-11-05 14:01:53'),(41,'lethbridge','edmonton','2022-11-01','05:00:00',21,'2022-11-05 14:05:33'),(42,'vancouver','edmonton','2022-11-15','05:00:00',21,'2022-11-05 14:05:41'),(44,'edson','calgary','2022-11-06','19:09:29',26,'2022-11-06 19:09:29'),(45,'red deer','lethbridge','2022-11-10','09:00:00',26,'2022-11-06 19:10:28');
/*!40000 ALTER TABLE `ride` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'myride_api'
--
/*!50003 DROP PROCEDURE IF EXISTS `booking_passenger_get` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
	r.rider_id as rider_id ,
	r.id as ride_id ,
	convert(c.first_name using utf8) as rider_first_name,
	convert(c.last_name using utf8) as rider_last_name,
	convert(c.phone_number using utf8) as phone_number 
	from client_session cs inner join booking b on cs.client_id = b.passenger_id inner join ride r on b.ride_id = r.id
	inner join client c on r.rider_id = c.id
	
	where cs.token = token_input and b.passenger_id = id_input;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `booking_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `client_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `client_get` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_get`(id_input int unsigned, token_input varchar(100))
BEGIN
	select 
	convert (c.first_name using utf8) as first_name,
	convert (c.last_name using utf8) as last_name,
	convert (c.email using utf8) as email,
	convert (c.address using utf8) as address,
	convert (c.city using utf8) as city,
	convert (c.phone_number using utf8) as phone_number,
	convert (c.bio using utf8) as bio,
	convert (c.dob using utf8) as dob,
	convert (c.profile_image using utf8) as profile_image
	from client c inner join client_session cs on cs.client_id = c.id 
	where cs.client_id = id_input and cs.token = token_input and c.verified = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_get_with_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `client_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_login`(email_input varchar(300), password_input varchar(200),token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	insert into client_session(client_id,token)
	select c.id,token_input
	from client c 
	where c.email = email_input and password = password(concat(password_input, (select salt where c.email = email_input)));
	
	select cs.client_id as client_id, convert(cs.token using utf8) as token
	from client_session cs where cs.token = token_input;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_logout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `client_old_image` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `client_patch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_patch`(first_name_input varchar(100),last_name_input varchar(100),email_input varchar(300),
address_input varchar(100),city_input varchar(100),phone_number_input varchar(20),bio_input varchar(300),dob_input date,
token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	update client c inner join client_session cs on cs.client_id = c.id  
	set first_name = first_name_input,last_name = last_name_input,email = email_input, address = address_input,city =  city_input,
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
/*!50003 DROP PROCEDURE IF EXISTS `client_patch_image` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_patch_image`(profile_image_input varchar(200),token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	update client c inner join client_session cs on cs.client_id = c.id 
	set c.profile_image = profile_image_input where cs.token = token_input and c.verified = 1;
	
	select row_count() as row_count;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_patch_with_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_patch_with_password`(password_input varchar(200),token_input varchar(100),salt_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	update client c inner join client_session cs on cs.client_id = c.id  
	set password = password(concat(password_input,salt_input)),salt = salt_input
	where cs.token = token_input and c.verified = 1;
	
	select row_count() as row_count;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_post`(first_name_input varchar(100),last_name_input varchar(100),
email_input varchar(300),password_input varchar(200),token_input varchar(100), salt_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	insert into client(first_name,last_name,email,password,salt)
	values(first_name_input, last_name_input,email_input ,password(concat(password_input,salt_input)),salt_input);
	
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
/*!50003 DROP PROCEDURE IF EXISTS `client_verified` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `client_verify` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `rides_filter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rides_filter`(from_input varchar(100),to_input varchar(100))
BEGIN
		select r.id,r.from_city ,r.to_city,r.travel_date ,r.leave_time 
		from ride r 
		where r.from_city like concat("%",from_input,"%") 
		and r.to_city like concat("%",to_input,"%");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rides_get_all` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
	convert (c.first_name using utf8) as rider_first_name
	from ride r inner join client c on c.id = r.rider_id
	where r.travel_date >= now();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ride_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `ride_get` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ride_get`(id_input int unsigned, token_input varchar(100))
BEGIN
	SELECT 
	r.id as ride_id,
	convert (r.from_city using utf8) as from_city,
	convert (r.to_city using utf8) as to_city,
	convert (r.travel_date using utf8) as travel_date,
	convert (r.leave_time using utf8) as leave_time
	from client c inner join client_session cs on cs.client_id = c.id inner join ride r on r.rider_id = c.id 
	where c.id = id_input and c.verified =1 and cs.token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ride_get_for_patch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ride_get_for_patch`(id_input int unsigned, token_input varchar(100))
BEGIN
	SELECT 
	convert (r.from_city using utf8) as from_city,
	convert (r.to_city using utf8) as  to_city,
	convert (r.travel_date using utf8) as travel_date,
	convert (r.leave_time using utf8) as leave_time
	from ride r  inner join client c on c.id = r.rider_id  inner join client_session cs on cs.client_id = c.id 
	where cs.token = token_input and r.id = id_input;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ride_patch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ride_patch`(from_input varchar(100),to_input varchar(100),date_input date,time_input time,id_input int unsigned, token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	update ride r  inner join client c on c.id = r.rider_id inner join client_session cs on cs.client_id = c.id
	set r.from_city = from_input, r.to_city = to_input, r.travel_date = date_input, r.leave_time = time_input
	where cs.token = token_input and r.id = id_input and c.verified = 1;
	SELECT row_count() as row_count;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ride_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ride_post`(from_input varchar(100),to_input varchar(100),date_input date, time_input time,token_input varchar(100))
    MODIFIES SQL DATA
BEGIN
	insert into ride(from_city,to_city,travel_date,leave_time,rider_id)
	select from_input, to_input, date_input, time_input,cs.client_id
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
/*!50003 DROP PROCEDURE IF EXISTS `user_post_all` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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

-- Dump completed on 2022-11-07 10:47:23
