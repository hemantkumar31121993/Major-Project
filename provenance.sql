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
-- Current Database: `provenance`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `provenance` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `provenance`;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `copy_info`
--

LOCK TABLES `copy_info` WRITE;
/*!40000 ALTER TABLE `copy_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `copy_info` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `window_info`
--

LOCK TABLES `window_info` WRITE;
/*!40000 ALTER TABLE `window_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `window_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-13 22:49:35
