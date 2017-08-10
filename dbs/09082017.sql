-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: waf_project
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

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
  `path_name` varchar(200) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `configuration_file_states_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuration_file_unq` (`name`,`path_name`),
  KEY `configuration_files_fk_configuration_file_states` (`configuration_file_states_id`),
  CONSTRAINT `configuration_files_fk_configuration_file_states` FOREIGN KEY (`configuration_file_states_id`) REFERENCES `CONFIGURATION_FILE_STATES` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILES`
--

LOCK TABLES `CONFIGURATION_FILES` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILES` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILES` VALUES (1,'MyNewFile','/home/joaquin/Escritorio/file','This is a test file - 1. nada',1),(4,'modsecurity.conf','/etc/modsecurity/modsecurity.conf','This file contain configuration parameters of modsecurity waf.',1),(5,'modsecurity.conf-recommended','/etc/modsecurity/modsecurity.conf-recommended','pone algo serio che',1);
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
  `value` varchar(1000) NOT NULL,
  `description` varchar(600) DEFAULT NULL,
  `configuration_file_attribute_type_id` bigint(20) NOT NULL,
  `configuration_file_attribute_states_id` bigint(20) NOT NULL,
  `configuration_file_attribute_groups_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuration_files_attributes_unq` (`name`,`configuration_file_attribute_groups_id`),
  KEY `configuration_files_attributes_fk_cfag` (`configuration_file_attribute_groups_id`),
  KEY `configuration_files_attributes_fk_cfas` (`configuration_file_attribute_states_id`),
  KEY `conf_files_attr_fk_conf_files_attr_type` (`configuration_file_attribute_type_id`),
  CONSTRAINT `conf_files_attr_fk_conf_files_attr_type` FOREIGN KEY (`configuration_file_attribute_type_id`) REFERENCES `CONFIGURATION_FILE_ATTRIBUTE_TYPE` (`id`),
  CONSTRAINT `configuration_files_attributes_fk_cfag` FOREIGN KEY (`configuration_file_attribute_groups_id`) REFERENCES `CONFIGURATION_FILE_ATTRIBUTE_GROUPS` (`id`),
  CONSTRAINT `configuration_files_attributes_fk_cfas` FOREIGN KEY (`configuration_file_attribute_states_id`) REFERENCES `CONFIGURATION_FILE_ATTRIBUTE_STATES` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILES_ATTRIBUTES`
--

LOCK TABLES `CONFIGURATION_FILES_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILES_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILES_ATTRIBUTES` VALUES (38,'SecRuleEngine','Off',NULL,2,1,17),(39,'SecRequestBodyAccess','On',NULL,2,2,18),(40,'SecRequestBodyLimit','13107200',NULL,4,2,18),(41,'SecRequestBodyNoFilesLimit','131072',NULL,4,2,18),(42,'SecRequestBodyInMemoryLimit','131072',NULL,4,2,18),(43,'SecRequestBodyLimitAction','ProcessPartial',NULL,3,2,18),(44,'SecPcreMatchLimit','1000',NULL,4,2,18),(45,'SecPcreMatchLimitRecursion','1000',NULL,4,2,18),(46,'SecResponseBodyAccess','On',NULL,2,2,19),(47,'SecResponseBodyMimeType','text/plain',NULL,3,2,19),(48,'SecResponseBodyLimit','524288',NULL,4,2,19),(49,'SecResponseBodyLimitAction','ProcessPartial',NULL,3,2,19),(51,'SecTmpDir','/tmp/',NULL,1,2,20),(52,'SecDataDir','/tmp/',NULL,1,2,20),(53,'SecUploadDir','/opt/modsecurity/var/upload/',NULL,1,2,21),(54,'SecUploadKeepFiles','RelevantOnly',NULL,2,2,21),(55,'SecUploadFileMode','0600',NULL,4,2,21),(56,'SecDebugLog','/opt/modsecurity/var/log/debug.log',NULL,1,1,22),(57,'SecDebugLogLevel','3',NULL,4,1,22),(58,'SecAuditEngine','RelevantOnly',NULL,2,2,23),(59,'SecAuditLogRelevantStatus','\"^(?:5|4(?!04))\"',NULL,1,2,23),(60,'SecAuditLogParts','ABIJDEFHZ',NULL,1,2,23),(61,'SecAuditLogType','Serial',NULL,2,2,23),(62,'SecAuditLog','/var/log/apache2/modsec_audit.log',NULL,1,2,23),(63,'SecAuditLogStorageDir','/opt/modsecurity/var/audit/',NULL,1,1,23),(64,'SecArgumentSeparator','&',NULL,1,2,24),(65,'SecCookieFormat','0',NULL,4,2,24),(66,'SecUnicodeMapFile','unicode.mapping 20127',NULL,1,2,24),(67,'SecStatusEngine','On',NULL,2,2,24),(76,'attr 1','opt 1','This is option 1',3,2,27),(77,'attr 2','83787324','This is option 2',4,2,27);
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
  `name` varchar(100) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `configuration_files_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuration_file_attribute_groups_unq` (`name`,`configuration_files_id`),
  KEY `configuration_file_attribute_groups_fk_configuration_files` (`configuration_files_id`),
  CONSTRAINT `configuration_file_attribute_groups_fk_configuration_files` FOREIGN KEY (`configuration_files_id`) REFERENCES `CONFIGURATION_FILES` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_ATTRIBUTE_GROUPS`
--

LOCK TABLES `CONFIGURATION_FILE_ATTRIBUTE_GROUPS` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_GROUPS` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILE_ATTRIBUTE_GROUPS` VALUES (17,'Rule engine initialization','Rule engine initialization - Description',4),(18,'Request body handling','Request body handling - Description',4),(19,'Response body handling','Response body handling - Desc',4),(20,'Filesystem configuration','Filesystem configuration - Description',4),(21,'File uploads handling configuration','File uploads handling configuration - Description',4),(22,'Debug log configuration','Debug log configuration - Description',4),(23,'Audit log configuration','Audit log configuration - Description',4),(24,'Miscellaneous','Miscellaneous - Description',4),(27,'Group 1','This is the first group',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS`
--

LOCK TABLES `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` VALUES (4,'On',NULL,39),(5,'Off',NULL,39),(6,'Reject',NULL,43),(7,'ProcessPartial',NULL,43),(8,'On',NULL,46),(9,'Off',NULL,46),(10,'text/plain',NULL,47),(11,'text/html',NULL,47),(12,'text/xml',NULL,47),(15,'ProcessPartial',NULL,49),(16,'Rject',NULL,49),(17,'RelevantOnly',NULL,54),(18,'RelevantOnly',NULL,58),(19,'Serial',NULL,61),(20,'On',NULL,67),(21,'Off',NULL,67),(32,'On',NULL,38),(33,'Off',NULL,38),(34,'DetectionOnly',NULL,38),(37,'opt 1',NULL,76),(38,'opt 2',NULL,76);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_ATTRIBUTE_STATES`
--

LOCK TABLES `CONFIGURATION_FILE_ATTRIBUTE_STATES` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_STATES` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILE_ATTRIBUTE_STATES` VALUES (1,'LOCKED','This attribute can not be modified.'),(2,'FULL-AVAILABLE','This attribute can be arbitrary modified and deleted.');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_ATTRIBUTE_TYPE`
--

LOCK TABLES `CONFIGURATION_FILE_ATTRIBUTE_TYPE` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_TYPE` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILE_ATTRIBUTE_TYPE` VALUES (1,'input-text','This is a text input attribute'),(2,'single-select','This is a single-select attribute'),(3,'multiple-select','This is a multiple-select attribute'),(4,'numeric-input','This is a numeric imput.');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_STATES`
--

LOCK TABLES `CONFIGURATION_FILE_STATES` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_STATES` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILE_STATES` VALUES (1,'CONFIGURABLE','Files with this states are able to be configured.'),(2,'NO-CONFIGURABLE','Files with this states can\'t be configured.');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
INSERT INTO `USERS` VALUES (13,'admin','$2a$10$jg6s2fFqrPrQ20Luz.vUzOmISsHgz55ieJ26pCBpKiOFHQ65GBPlq','admin','admin','admin@admin.com',1);
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
  CONSTRAINT `users_user_profiles_fk_user_profiles` FOREIGN KEY (`user_profile_id`) REFERENCES `USER_PROFILES` (`id`),
  CONSTRAINT `users_user_profiles_fk_users` FOREIGN KEY (`user_id`) REFERENCES `USERS` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS_USER_PROFILES`
--

LOCK TABLES `USERS_USER_PROFILES` WRITE;
/*!40000 ALTER TABLE `USERS_USER_PROFILES` DISABLE KEYS */;
INSERT INTO `USERS_USER_PROFILES` VALUES (13,13,1),(15,13,2),(14,13,3);
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
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_STATES`
--

LOCK TABLES `USER_STATES` WRITE;
/*!40000 ALTER TABLE `USER_STATES` DISABLE KEYS */;
INSERT INTO `USER_STATES` VALUES (1,'ACTIVE','Active users can use the system freely'),(3,'DISABLE','This user is unable to use the system.');
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

-- Dump completed on 2017-08-09 21:13:55
