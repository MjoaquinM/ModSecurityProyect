-- MySQL dump 10.13  Distrib 5.5.55, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: waf_project
-- ------------------------------------------------------
-- Server version	5.5.55-0ubuntu0.14.04.1

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
  `configuration_file_states_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuration_file_unq` (`name`,`path_name`),
  KEY `configuration_files_fk_configuration_file_states` (`configuration_file_states_id`),
  CONSTRAINT `configuration_files_fk_configuration_file_states` FOREIGN KEY (`configuration_file_states_id`) REFERENCES `CONFIGURATION_FILE_STATES` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILES`
--

LOCK TABLES `CONFIGURATION_FILES` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILES` DISABLE KEYS */;
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
  `description` varchar(100) DEFAULT NULL,
  `configuration_file_attribute_type_id` bigint(20) NOT NULL,
  `configuration_file_attribute_states_id` bigint(20) NOT NULL,
  `configuration_file_attribute_groups_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuration_files_attributes_unq` (`name`,`configuration_file_attribute_groups_id`),
  KEY `configuration_files_attributes_fk_cfag` (`configuration_file_attribute_groups_id`),
  KEY `configuration_files_attributes_fk_cfas` (`configuration_file_attribute_states_id`),
  CONSTRAINT `configuration_files_attributes_fk_cfag` FOREIGN KEY (`configuration_file_attribute_groups_id`) REFERENCES `CONFIGURATION_FILE_ATTRIBUTE_GROUPS` (`id`),
  CONSTRAINT `configuration_files_attributes_fk_cfas` FOREIGN KEY (`configuration_file_attribute_states_id`) REFERENCES `CONFIGURATION_FILE_ATTRIBUTE_STATES` (`id`)
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
-- Table structure for table `CONFIGURATION_FILE_ATTRIBUTE_GROUPS`
--

DROP TABLE IF EXISTS `CONFIGURATION_FILE_ATTRIBUTE_GROUPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONFIGURATION_FILE_ATTRIBUTE_GROUPS` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `configuration_files_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuration_file_attribute_groups_unq` (`name`,`configuration_files_id`),
  KEY `configuration_file_attribute_groups_fk_configuration_files` (`configuration_files_id`),
  CONSTRAINT `configuration_file_attribute_groups_fk_configuration_files` FOREIGN KEY (`configuration_files_id`) REFERENCES `CONFIGURATION_FILES` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_ATTRIBUTE_GROUPS`
--

LOCK TABLES `CONFIGURATION_FILE_ATTRIBUTE_GROUPS` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_GROUPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_GROUPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS`
--

DROP TABLE IF EXISTS `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `configuration_files_attributes_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuration_file_attribute_options_unq` (`name`,`configuration_files_attributes_id`),
  KEY `configuration_file_attribute_options_fk_cfa` (`configuration_files_attributes_id`),
  CONSTRAINT `configuration_file_attribute_options_fk_cfa` FOREIGN KEY (`configuration_files_attributes_id`) REFERENCES `CONFIGURATION_FILES_ATTRIBUTES` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS`
--

LOCK TABLES `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONFIGURATION_FILE_ATTRIBUTE_STATES`
--

DROP TABLE IF EXISTS `CONFIGURATION_FILE_ATTRIBUTE_STATES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONFIGURATION_FILE_ATTRIBUTE_STATES` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_ATTRIBUTE_STATES`
--

LOCK TABLES `CONFIGURATION_FILE_ATTRIBUTE_STATES` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_STATES` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_STATES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONFIGURATION_FILE_ATTRIBUTE_TYPE`
--

DROP TABLE IF EXISTS `CONFIGURATION_FILE_ATTRIBUTE_TYPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONFIGURATION_FILE_ATTRIBUTE_TYPE` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_ATTRIBUTE_TYPE`
--

LOCK TABLES `CONFIGURATION_FILE_ATTRIBUTE_TYPE` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_TYPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_TYPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONFIGURATION_FILE_STATES`
--

DROP TABLE IF EXISTS `CONFIGURATION_FILE_STATES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONFIGURATION_FILE_STATES` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_STATES`
--

LOCK TABLES `CONFIGURATION_FILE_STATES` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_STATES` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_STATES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS`
--

DROP TABLE IF EXISTS `USERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USERS` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `user_states_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `email` (`email`),
  KEY `users_fk_user_states` (`user_states_id`),
  CONSTRAINT `users_fk_user_states` FOREIGN KEY (`user_states_id`) REFERENCES `USER_STATES` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
INSERT INTO `USERS` VALUES (1,'joaquin','Cambialo921','joaquin','maza','maza.joaquin@gmail.com',1);
/*!40000 ALTER TABLE `USERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS_USER_PROFILES`
--

DROP TABLE IF EXISTS `USERS_USER_PROFILES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USERS_USER_PROFILES` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `user_profile_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_profiles_unq` (`user_id`,`user_profile_id`),
  KEY `users_user_profiles_fk_user_profiles` (`user_profile_id`),
  CONSTRAINT `users_user_profiles_fk_users` FOREIGN KEY (`user_id`) REFERENCES `USERS` (`id`),
  CONSTRAINT `users_user_profiles_fk_user_profiles` FOREIGN KEY (`user_profile_id`) REFERENCES `USER_PROFILES` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS_USER_PROFILES`
--

LOCK TABLES `USERS_USER_PROFILES` WRITE;
/*!40000 ALTER TABLE `USERS_USER_PROFILES` DISABLE KEYS */;
INSERT INTO `USERS_USER_PROFILES` VALUES (1,1,1);
/*!40000 ALTER TABLE `USERS_USER_PROFILES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_PROFILES`
--

DROP TABLE IF EXISTS `USER_PROFILES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_PROFILES` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_PROFILES`
--

LOCK TABLES `USER_PROFILES` WRITE;
/*!40000 ALTER TABLE `USER_PROFILES` DISABLE KEYS */;
INSERT INTO `USER_PROFILES` VALUES (1,'ADMIN'),(2,'USER'),(3,'DBA');
/*!40000 ALTER TABLE `USER_PROFILES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_STATES`
--

DROP TABLE IF EXISTS `USER_STATES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_STATES` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_STATES`
--

LOCK TABLES `USER_STATES` WRITE;
/*!40000 ALTER TABLE `USER_STATES` DISABLE KEYS */;
INSERT INTO `USER_STATES` VALUES (1,'ACTIVE','Active users can use the system freely');
/*!40000 ALTER TABLE `USER_STATES` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-15 14:19:41
