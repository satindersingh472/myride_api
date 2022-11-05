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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (18,'satinder','singh','satindersingh772@gmail.com','*46FEE28425D9980C9BF75945CB4181CE69CF1D8F',NULL,NULL,NULL,NULL,NULL,NULL,'222b5af561294ae2b1e58fcc630b2393',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_session`
--

LOCK TABLES `client_session` WRITE;
/*!40000 ALTER TABLE `client_session` DISABLE KEYS */;
INSERT INTO `client_session` VALUES (74,'3a8f37d790be414fb523188b189086ef',18,'2022-11-05 08:32:46'),(75,'new_token',18,'2022-11-05 08:34:07'),(85,'djldjfldsjfldsajfjdalfj',18,'2022-11-05 08:38:20'),(86,'djldjfldsjfldsajfjda',18,'2022-11-05 08:38:30');
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
  `from` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `to` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `rider` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ride_FK` (`rider`),
  CONSTRAINT `ride_FK` FOREIGN KEY (`rider`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ride`
--

LOCK TABLES `ride` WRITE;
/*!40000 ALTER TABLE `ride` DISABLE KEYS */;
/*!40000 ALTER TABLE `ride` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'myride_api'
--
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-05  8:42:19
