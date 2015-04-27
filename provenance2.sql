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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `copy_info`
--

LOCK TABLES `copy_info` WRITE;
/*!40000 ALTER TABLE `copy_info` DISABLE KEYS */;
INSERT INTO `copy_info` VALUES (1,1,'Returns the value generated for an AUTO_INCREMENT column by the previous INSERT or UPDATE statement. Use ','2015-04-24 08:40:12'),(2,2,'Returns the value generated for an AUTO_INCREMENT column by the previous INSERT or UPDATE statement. Use ','2015-04-24 08:40:21'),(3,3,'This browser window is used to keep your authentication ','2015-04-24 08:41:49'),(4,4,'This browser window is used to keep your authentication ','2015-04-24 08:42:05'),(5,5,'Returns the value generated for an AUTO_INCREMENT column by the previous INSERT or UPDATE statement. Use us INSERT or UPDATE statement. Use Returns the value generated for an AUTO_INCREMENT column b','2015-04-24 08:42:18'),(6,7,'turns the value generated for an AUTO_INCREMENT co','2015-04-24 08:42:35'),(7,2,'ser window is used to keep your authentica','2015-04-24 08:47:00'),(8,9,'printf(\"MYSQL ERROR: %s\", mysql_error(con));','2015-04-24 08:57:51'),(9,10,'INSERT-statement, the mysql_insert_id() function will return not the same ','2015-04-24 08:58:09'),(10,2,'nt, the mysql_insert_id() function will return not the same INSERT-statement, the mysql_insert_id() function will return not the same INSERT-statement, the mysql_insert_id() f','2015-04-24 08:58:19'),(11,2,'ment, the mysql_insert_id() function will return n','2015-04-24 09:00:47'),(12,11,'consider an employee_tbl table, which isnt, the mysql_insert_id() function will return not the same INSERT-statement, the my','2015-04-24 09:01:05'),(13,2,'ion will return not the same INSE','2015-04-24 09:01:36'),(14,9,'corrupted double-linked list','2015-04-24 09:08:26'),(15,2,'the value generated for an AUTO_INCREMENT cocorrupted double-linked list','2015-04-24 09:08:37'),(16,2,'the value generated for an AUTO_INCREMENT cocorrupted double-linked list','2015-04-24 09:08:40'),(17,12,'Now Athena is equipped with phpMyAdmin a web interface to MySQL Database','2015-04-24 09:53:00'),(18,12,'Open source interactive web development IDE Adode Brackets release 0.42 is now installed','2015-04-24 09:53:20'),(19,9,'Interactive Python IDE Spyder is now availabl','2015-04-24 09:53:51'),(20,12,'Interactive Python IDE Spyder is now availabl','2015-04-24 09:54:03'),(21,2,' DatabaseInteractive Python I','2015-04-24 09:54:12'),(22,13,'National Institute of Technology Calicut, Kerala','2015-04-24 10:43:15'),(23,7,' phpMyAdmin a web interface to MySQL DatabaseInteractive Python IDE Spyder is now availabl DatabaseInteractive Python I DatabaseInteractive Python INational Inst','2015-04-24 10:43:24'),(25,6,'w Athena is equipped with p phpMy','2015-04-24 11:04:44'),(26,9,'DatabaseInteractive Python ','2015-04-24 11:18:56'),(28,16,'When you insert any other value into a AUTO_INCREMENT column, the column ','2015-04-24 12:12:19'),(30,5,'ilabl DatabaseInteractive','2015-04-24 12:13:15'),(32,9,'if ( *target == XA_LIST_LENGTH(d)) {\n    target_string=\"XA_LIST_LENGTH\";\n}\nif ( *target == XA_LENGTH(d)) {\n    target_string=\"XA_LENGTH\";\n}\nif ( *target == XA_CHARACTER_POSITION(d)) {\n    target_string=\"XA_CHARACTER_POSITION\";\n}\nif ( *target == XA_STRING )\n    target_string=\"XA_STRING\";\n    addRequestor(currentClip, requestor, *win_info_list, requestor_supportWindow, *supportWindowName, target_string);\n}\nif ( *target == XA_TEXT(d)) {\n    target_string=\"XA_TEXT\";\n    addRequestor(currentClip, requestor, *win_info_list, requestor_supportWindow, *supportWindowName, target_string);\n}\nif ( *target == XA_UTF8_STRING(d)) {\n    target_string=\"XA_UTF8_STRING\";\n    addRequestor(currentClip, requestor, *win_info_list, requestor_supportWindow, *supportWindowName, target_string);\n}\nif ( *target == XA_COMPOUND_TEXT(d)) {\n    target_string=\"XA_COMPOUND_TEXT\";\n    addRequestor(currentClip, requestor, *win_info_list, requestor_supportWindow, *supportWindowName, target_string);\n}','2015-04-24 12:29:30'),(34,20,' addRequestor(currentClip, requestor, *win_info_list, requestor_supportWindow, *supportWindowName, target_string);','2015-04-24 12:29:50'),(35,21,'http://9gag.com/gag/aB34PB2?ref=fbp','2015-04-24 17:52:47'),(36,22,'In particular, trailing spaces are significant, which is not true for','2015-04-24 17:53:33'),(37,27,'deb http://192.168.40.97/ubuntu vivid-updates main multiverse restricted universe','2015-04-24 17:53:56'),(38,21,' which is not true fordeb http://192.168.40.97/','2015-04-24 17:54:31'),(39,31,' which is not true fordeb http://192.168.40.97/','2015-04-24 17:54:40'),(40,29,'aces are significant, which is not true fordeb http://192.168.40.97/ubuntu vivid-updates main multiverse restricted universe which is not true fordeb htt','2015-04-24 17:55:10'),(41,27,'deb http://192.168.40.97/ubuntu vivid-updates main multiverse restricted universe','2015-04-24 17:56:23');
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
-- Temporary table structure for view `flowmap`
--

DROP TABLE IF EXISTS `flowmap`;
/*!50001 DROP VIEW IF EXISTS `flowmap`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `flowmap` (
  `owner` tinyint NOT NULL,
  `requestor` tinyint NOT NULL,
  `COUNT(*)` tinyint NOT NULL,
  `blueprint` tinyint NOT NULL,
  `GROUP_CONCAT(data_id SEPARATOR ',')` tinyint NOT NULL
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
-- Temporary table structure for view `just_flow1`
--

DROP TABLE IF EXISTS `just_flow1`;
/*!50001 DROP VIEW IF EXISTS `just_flow1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `just_flow1` (
  `owner` tinyint NOT NULL,
  `requestor` tinyint NOT NULL,
  `blueprint` tinyint NOT NULL,
  `Data_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `just_flow2`
--

DROP TABLE IF EXISTS `just_flow2`;
/*!50001 DROP VIEW IF EXISTS `just_flow2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `just_flow2` (
  `owner` tinyint NOT NULL,
  `requestor` tinyint NOT NULL,
  `data_id` tinyint NOT NULL,
  `COUNT(*)` tinyint NOT NULL,
  `GROUP_CONCAT(data_id SEPARATOR ',')` tinyint NOT NULL
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
INSERT INTO `paste_info` VALUES (2,1,'2015-04-24 08:40:16'),(2,1,'2015-04-24 08:40:16'),(2,4,'2015-04-24 08:42:12'),(2,4,'2015-04-24 08:42:12'),(6,7,'2015-04-24 08:47:02'),(6,7,'2015-04-24 08:47:02'),(6,7,'2015-04-24 08:47:03'),(6,7,'2015-04-24 08:47:03'),(5,9,'2015-04-24 08:58:10'),(5,9,'2015-04-24 08:58:10'),(6,9,'2015-04-24 08:58:11'),(6,9,'2015-04-24 08:58:11'),(7,9,'2015-04-24 08:58:13'),(7,9,'2015-04-24 08:58:13'),(2,9,'2015-04-24 08:58:14'),(2,9,'2015-04-24 08:58:14'),(2,9,'2015-04-24 08:58:14'),(2,9,'2015-04-24 08:58:14'),(2,9,'2015-04-24 08:58:14'),(2,9,'2015-04-24 08:58:14'),(2,9,'2015-04-24 08:58:14'),(2,9,'2015-04-24 08:58:14'),(7,11,'2015-04-24 09:00:51'),(7,11,'2015-04-24 09:00:51'),(7,16,'2015-04-24 09:08:46'),(7,16,'2015-04-24 09:08:46'),(5,16,'2015-04-24 09:09:08'),(5,16,'2015-04-24 09:09:08'),(6,16,'2015-04-24 09:09:28'),(6,16,'2015-04-24 09:09:28'),(2,16,'2015-04-24 09:09:37'),(2,16,'2015-04-24 09:09:37'),(6,16,'2015-04-24 09:09:49'),(6,16,'2015-04-24 09:09:49'),(5,16,'2015-04-24 09:09:50'),(5,16,'2015-04-24 09:09:50'),(7,16,'2015-04-24 09:09:52'),(7,16,'2015-04-24 09:09:52'),(2,16,'2015-04-24 09:09:53'),(2,16,'2015-04-24 09:09:53'),(6,17,'2015-04-24 09:53:03'),(6,17,'2015-04-24 09:53:03'),(5,17,'2015-04-24 09:53:04'),(5,17,'2015-04-24 09:53:04'),(7,17,'2015-04-24 09:53:05'),(7,17,'2015-04-24 09:53:05'),(2,17,'2015-04-24 09:53:07'),(2,17,'2015-04-24 09:53:08'),(2,20,'2015-04-24 09:54:06'),(2,20,'2015-04-24 09:54:06'),(5,20,'2015-04-24 09:54:07'),(5,20,'2015-04-24 09:54:07'),(7,20,'2015-04-24 09:54:08'),(7,20,'2015-04-24 09:54:08'),(2,20,'2015-04-24 09:54:09'),(2,20,'2015-04-24 09:54:09'),(6,22,'2015-04-24 10:43:17'),(6,22,'2015-04-24 10:43:17'),(5,22,'2015-04-24 10:43:19'),(5,22,'2015-04-24 10:43:19'),(7,22,'2015-04-24 10:43:21'),(7,22,'2015-04-24 10:43:21'),(5,28,'2015-04-24 12:12:20'),(5,28,'2015-04-24 12:12:20'),(5,28,'2015-04-24 12:12:20'),(5,28,'2015-04-24 12:12:20'),(7,28,'2015-04-24 12:12:22'),(7,28,'2015-04-24 12:12:22'),(23,36,'2015-04-24 17:53:37'),(24,36,'2015-04-24 17:53:39'),(25,36,'2015-04-24 17:53:40'),(26,36,'2015-04-24 17:53:41'),(31,39,'2015-04-24 17:54:43'),(28,39,'2015-04-24 17:54:55'),(29,39,'2015-04-24 17:54:56'),(30,39,'2015-04-24 17:54:58'),(31,39,'2015-04-24 17:54:59'),(30,41,'2015-04-24 17:56:25'),(30,41,'2015-04-24 17:56:26'),(29,41,'2015-04-24 17:56:27'),(29,41,'2015-04-24 17:56:28');
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `window_info`
--

LOCK TABLES `window_info` WRITE;
/*!40000 ALTER TABLE `window_info` DISABLE KEYS */;
INSERT INTO `window_info` VALUES (9,29360139,'Terminal'),(22,54525953,'MySQL :: MySQL 5.0 Reference Manual :: 12.5.1 Stri'),(27,54525953,'Ubuntu Mirror | NIT Calicut - Google Chrome'),(3,56623132,'xclipboard'),(4,62914561,'Firewall Authentication Keepalive Window - Google '),(1,62914561,'MySQL :: MySQL 5.0 Reference Manual :: 20.6.7.37 m'),(10,62914561,'mysql_insert_id - Google Search - Google Chrome'),(8,62914561,'New Tab - Google Chrome'),(13,62914561,'Test Mail - hemantkumar31121993@gmail.com - Gmail '),(21,62914571,'Terminal'),(16,62914663,'auto increment only when insertion occurs - Google'),(12,62914663,'Software Systems Laboratory - Google Chrome'),(11,62914663,'Test Document - Google Docs - Google Chrome'),(28,65011845,'*another_test_document (~/test) - gedit'),(29,65011845,'*false docuemnt (~/test) - gedit'),(30,65011845,'*test_file2.cpp (~/test) - gedit'),(31,65011845,'*test_text_file1.txt (~/test) - gedit'),(23,65011845,'another_test_document (~/test) - gedit'),(24,65011845,'false docuemnt (~/test) - gedit'),(25,65011845,'test_file2.cpp (~/test) - gedit'),(26,65011845,'test_text_file1.txt (~/test) - gedit'),(6,67108997,'*another_test_document (~/test) - gedit'),(5,67108997,'*false docuemnt (~/test) - gedit'),(7,67108997,'*test_file2.cpp (~/test) - gedit'),(2,67108997,'*test_text_file1.txt (~/test) - gedit'),(20,67108997,'*Untitled Document 1 - gedit');
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
-- Final view structure for view `flowmap`
--

/*!50001 DROP TABLE IF EXISTS `flowmap`*/;
/*!50001 DROP VIEW IF EXISTS `flowmap`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`provenance`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `flowmap` AS select `data_flow`.`Owner` AS `owner`,`data_flow`.`Requestor` AS `requestor`,count(0) AS `COUNT(*)`,concat(`data_flow`.`Owner`,'+',`data_flow`.`Requestor`) AS `blueprint`,group_concat(`data_flow`.`Data_ID` separator ',') AS `GROUP_CONCAT(data_id SEPARATOR ',')` from `data_flow` group by concat(`data_flow`.`Owner`,'+',`data_flow`.`Requestor`) */;
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

--
-- Final view structure for view `just_flow1`
--

/*!50001 DROP TABLE IF EXISTS `just_flow1`*/;
/*!50001 DROP VIEW IF EXISTS `just_flow1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`provenance`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `just_flow1` AS select `data_flow`.`Owner` AS `owner`,`data_flow`.`Requestor` AS `requestor`,concat(`data_flow`.`Owner`,'+',`data_flow`.`Requestor`) AS `blueprint`,`data_flow`.`Data_ID` AS `Data_id` from `data_flow` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `just_flow2`
--

/*!50001 DROP TABLE IF EXISTS `just_flow2`*/;
/*!50001 DROP VIEW IF EXISTS `just_flow2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`provenance`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `just_flow2` AS select `just_flow1`.`owner` AS `owner`,`just_flow1`.`requestor` AS `requestor`,`just_flow1`.`Data_id` AS `data_id`,count(0) AS `COUNT(*)`,group_concat(`just_flow1`.`Data_id` separator ',') AS `GROUP_CONCAT(data_id SEPARATOR ',')` from `just_flow1` group by `just_flow1`.`blueprint` */;
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

-- Dump completed on 2015-04-27  9:48:42
