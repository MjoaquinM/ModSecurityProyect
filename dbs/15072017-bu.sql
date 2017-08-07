-- MySQL dump 10.13  Distrib 5.7.18, for Linux (x86_64)
--
-- Host: localhost    Database: waf_project
-- ------------------------------------------------------
-- Server version	5.7.18-0ubuntu0.16.04.1

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
-- Table structure for table `CONFIGURATION_FILES`
--

DROP TABLE IF EXISTS `CONFIGURATION_FILES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONFIGURATION_FILES` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `path_name` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILES`
--

LOCK TABLES `CONFIGURATION_FILES` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILES` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILES` VALUES (1,'Mi Archivo','/home/r3ng0/Desktop/miArchivo','Este es un archivo de prueba',0),(4,'modsecurity.conf','/etc/modsecurity/','modsecurity configuration',1),(7,'archivo de prueba 4','/por/ahi/nomas4','este es el archivo de pruebas 4',0);
/*!40000 ALTER TABLE `CONFIGURATION_FILES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONFIGURATION_FILES_ATTRIBUTES`
--

DROP TABLE IF EXISTS `CONFIGURATION_FILES_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONFIGURATION_FILES_ATTRIBUTES` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `element_type` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `configuration_file_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CONFIGURATION_FILES` (`configuration_file_id`),
  CONSTRAINT `FK_CONFIGURATION_FILES` FOREIGN KEY (`configuration_file_id`) REFERENCES `CONFIGURATION_FILES` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILES_ATTRIBUTES`
--

LOCK TABLES `CONFIGURATION_FILES_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILES_ATTRIBUTES` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONFIGURATION_FILES_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS`
--

DROP TABLE IF EXISTS `USERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USERS` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sso_id` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `state` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
INSERT INTO `USERS` VALUES (31,'mazass','$2a$10$SKcLJ8zaQ5TpQmxEIwIGIOS9XChmuwrULp3dmg7A7xL3zSH1zXB3q','joaquin','mazas','maza.joaquin@gmail.com','Active'),(32,'admin','$2a$10$FLtLroc86VEk8P42KjHw5uknE.SYEJ9.Koi5NeiLcGHrYuPg7v2mi','admin','admin','admin@admin.com','Active'),(34,'joaquin','notengoidea','fulanito','cosme','maza.joaquin@gmail.com','Active');
/*!40000 ALTER TABLE `USERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS_USER_PROFILES`
--

DROP TABLE IF EXISTS `USERS_USER_PROFILES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USERS_USER_PROFILES` (
  `user_id` bigint(20) NOT NULL,
  `user_profile_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS_USER_PROFILES`
--

LOCK TABLES `USERS_USER_PROFILES` WRITE;
/*!40000 ALTER TABLE `USERS_USER_PROFILES` DISABLE KEYS */;
INSERT INTO `USERS_USER_PROFILES` VALUES (34,2);
/*!40000 ALTER TABLE `USERS_USER_PROFILES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_PROFILES`
--

DROP TABLE IF EXISTS `USER_PROFILES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_PROFILES` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_PROFILES`
--

LOCK TABLES `USER_PROFILES` WRITE;
/*!40000 ALTER TABLE `USER_PROFILES` DISABLE KEYS */;
INSERT INTO `USER_PROFILES` VALUES (2,'ADMIN'),(3,'DBA'),(1,'USER');
/*!40000 ALTER TABLE `USER_PROFILES` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-15 15:55:16
