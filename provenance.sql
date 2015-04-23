-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: provenance
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `copy_info`
--

DROP TABLE IF EXISTS `copy_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copy_info` (
  `data_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  `data` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`data_id`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `copy_info_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `window_info` (`window_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `copy_info`
--

LOCK TABLES `copy_info` WRITE;
/*!40000 ALTER TABLE `copy_info` DISABLE KEYS */;
INSERT INTO `copy_info` VALUES (10,15,'IBM\'s Watson learning computer system isn\'t just content with making the occasional meal -- it has a whole slew of recipes lined up. The tech company is launching Cognitive Cooking with Chef Watson, a cookbook based on Watson\'s knack for combining food in a way that ','2015-04-23 04:13:06'),(11,17,'This browser window is used to keep your authentication ','2015-04-23 04:13:23'),(12,15,'This is a test data','2015-04-23 10:29:56');
/*!40000 ALTER TABLE `copy_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `data_flow`
--

DROP TABLE IF EXISTS `data_flow`;
/*!50001 DROP VIEW IF EXISTS `data_flow`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `data_flow` (
  `Owner` tinyint NOT NULL,
  `Requestor` tinyint NOT NULL,
  `Data_ID` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `just_flow`
--

DROP TABLE IF EXISTS `just_flow`;
/*!50001 DROP VIEW IF EXISTS `just_flow`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `just_flow` (
  `owner` tinyint NOT NULL,
  `requestor` tinyint NOT NULL,
  `blueprint` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `paste_info`
--

DROP TABLE IF EXISTS `paste_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paste_info` (
  `requestor_id` int(11) NOT NULL,
  `data_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `requestor_id` (`requestor_id`),
  KEY `data_id` (`data_id`),
  CONSTRAINT `paste_info_ibfk_1` FOREIGN KEY (`requestor_id`) REFERENCES `window_info` (`window_id`) ON DELETE CASCADE,
  CONSTRAINT `paste_info_ibfk_2` FOREIGN KEY (`data_id`) REFERENCES `copy_info` (`data_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paste_info`
--

LOCK TABLES `paste_info` WRITE;
/*!40000 ALTER TABLE `paste_info` DISABLE KEYS */;
INSERT INTO `paste_info` VALUES (16,10,'2015-04-23 04:13:12'),(18,11,'2015-04-23 04:13:51'),(16,12,'2015-04-23 10:31:47'),(16,12,'2015-04-23 11:09:16');
/*!40000 ALTER TABLE `paste_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `window_info`
--

DROP TABLE IF EXISTS `window_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `window_info` (
  `window_id` int(11) NOT NULL AUTO_INCREMENT,
  `window` int(11) NOT NULL,
  `window_title` varchar(50) NOT NULL,
  PRIMARY KEY (`window_id`),
  UNIQUE KEY `window` (`window`,`window_title`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `window_info`
--

LOCK TABLES `window_info` WRITE;
/*!40000 ALTER TABLE `window_info` DISABLE KEYS */;
INSERT INTO `window_info` VALUES (17,56623105,'Firewall Authentication Keepalive Window - Google '),(15,56623105,'IBM\'s Watson cognitive computer has whipped up a c'),(16,67108997,'*Untitled Document 1 - gedit'),(18,69206049,'Document1 - Writer');
/*!40000 ALTER TABLE `window_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `data_flow`
--

/*!50001 DROP TABLE IF EXISTS `data_flow`*/;
/*!50001 DROP VIEW IF EXISTS `data_flow`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`provenance`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `data_flow` AS select `C`.`owner_id` AS `Owner`,`P`.`requestor_id` AS `Requestor`,`P`.`data_id` AS `Data_ID` from (`copy_info` `C` join `paste_info` `P`) where (`C`.`data_id` = `P`.`data_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `just_flow`
--

/*!50001 DROP TABLE IF EXISTS `just_flow`*/;
/*!50001 DROP VIEW IF EXISTS `just_flow`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`provenance`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `just_flow` AS select `data_flow`.`Owner` AS `owner`,`data_flow`.`Requestor` AS `requestor`,concat(`data_flow`.`Owner`,'+',`data_flow`.`Requestor`) AS `blueprint` from `data_flow` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-23 23:15:09
