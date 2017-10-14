CREATE DATABASE  IF NOT EXISTS `waf_project` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `waf_project`;
-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: waf_project
-- ------------------------------------------------------
-- Server version	5.7.19

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
  `name` varchar(300) NOT NULL,
  `path_name` varchar(200) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `configuration_file_states_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuration_file_unq` (`name`,`path_name`),
  KEY `configuration_files_fk_configuration_file_states` (`configuration_file_states_id`),
  CONSTRAINT `configuration_files_fk_configuration_file_states` FOREIGN KEY (`configuration_file_states_id`) REFERENCES `CONFIGURATION_FILE_STATES` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILES`
--

LOCK TABLES `CONFIGURATION_FILES` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILES` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILES` VALUES (1,'MyNewFile','/home/joaquin/Escritorio/file','This is a test file - 1. NARANJEADO',1),(4,'modsecurity.conf','/etc/modsecurity/modsecurity.conf','This file contain configuration parameters of modsecurity waf',1),(5,'modsecurity.conf-recommended','/etc/modsecurity/modsecurity.conf-recommended','Hola te estoy editando la descripcion',1),(7,'RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf','/usr/share/modsecurity-crs/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf','The purpose of this file is to hold LOCAL exceptions for your site. The types of rules that would go into this file are one where you want to unconditionally disable rules or modify their actions during startup.',1);
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
  `description` varchar(2000) DEFAULT 'Not Available',
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
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILES_ATTRIBUTES`
--

LOCK TABLES `CONFIGURATION_FILES_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILES_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILES_ATTRIBUTES` VALUES (38,'SecRuleEngine','Off','Off',2,2,17),(39,'SecRequestBodyAccess','On','Configures whether request bodies will be buffered and processed by ModSecurity. This directive is required if you want to inspect the data transported request bodies (e.g., POST parameters). Request buffering is also required in order to make reliable blocking possible.',2,2,18),(40,'SecRequestBodyLimit','1073741824','Configures the maximum request body size ModSecurity will accept for buffering. Anything over the limit will be rejected with status code 413 (Request Entity Too Large). There is a hard limit of 1 GB. ',4,1,18),(41,'SecRequestBodyNoFilesLimit','1048576','Configures the maximum request body size ModSecurity will accept for buffering, excluding the size of any files being transported in the request. This directive is useful to reduce susceptibility to DoS attacks when someone is sending request bodies of very large sizes. Web applications that require file uploads must configure SecRequestBodyLimit to a high value, but because large files are streamed to disk, file uploads will not increase memory consumption. However, it?s still possible for someone to take advantage of a large request body limit and send non-upload requests with large body sizes. This directive eliminates that loophole. Generally speaking, the default value is not small enough. For most applications, you should be able to reduce it down to 128 KB or lower. Anything over the limit will be rejected with status code 413 (Request Entity Too Large). There is a hard limit of 1 GB. ',4,2,18),(42,'SecRequestBodyInMemoryLimit','131072','Configures the maximum request body size that ModSecurity will store in memory. Configures the maximum request body size that ModSecurity will store in memory.',4,2,18),(43,'SecRequestBodyLimitAction','Reject','Controls what happens once a request body limit, configured with SecRequestBodyLimit, is encountered.\r\nBy default, ModSecurity will reject a request body that is longer than specified. This is problematic especially when ModSecurity is being run in DetectionOnly mode and the intent is to be totally passive and not take any disruptive actions against the transaction. With the ability to choose what happens once a limit is reached, site administrators can choose to inspect only the first part of the request, the part that can fit into the desired limit, and let the rest through. This is not ideal from a possible evasion issue perspective, however it may be acceptable under certain circumstances. ',3,2,18),(44,'SecPcreMatchLimit','1000','',4,2,18),(45,'SecPcreMatchLimitRecursion','1000','',4,2,18),(46,'SecResponseBodyAccess','On','',2,2,19),(47,'SecResponseBodyMimeType','text/plain','',3,2,19),(48,'SecResponseBodyLimit','524288','',4,2,19),(49,'SecResponseBodyLimitAction','ProcessPartial','',3,2,19),(51,'SecTmpDir','/tmp/','',1,2,20),(52,'SecDataDir','/tmp/','',1,2,20),(53,'SecUploadDir','/opt/modsecurity/var/upload/','',1,2,21),(54,'SecUploadKeepFiles','RelevantOnly','',2,2,21),(55,'SecUploadFileMode','0600','',4,2,21),(56,'SecDebugLog','/opt/modsecurity/var/log/debug.log','',1,1,22),(57,'SecDebugLogLevel','3','',4,1,22),(58,'SecAuditEngine','RelevantOnly','',2,2,23),(59,'SecAuditLogRelevantStatus','^(?:5|4(?!04))','^(?:5|4(?!04))',1,2,23),(60,'SecAuditLogParts','ABIJDEFHZ','',1,2,23),(61,'SecAuditLogType','Concurrent','Concurrent',2,2,23),(62,'SecAuditLog','|/etc/modsecurity-2.9.2/mlogc/mlogc /etc/modsecurity-2.9.2/mlogc/mlogc.conf','|/etc/modsecurity-2.9.2/mlogc/mlogc /etc/modsecurity-2.9.2/mlogc/mlogc.conf',1,2,23),(63,'SecAuditLogStorageDir','/tmp/mlogc/','/tmp/mlogc/',1,2,23),(64,'SecArgumentSeparator','&','',1,2,24),(65,'SecCookieFormat','0','',4,2,24),(66,'SecUnicodeMapFile','unicode.mapping 20127','',1,2,24),(67,'SecStatusEngine','On','',2,2,24),(68,'Test attribute 1','Opt 1 - Test attribute 1','Test attribute 1 - Description',5,2,25),(69,'SecRuleRemoveById','910000,920350',NULL,1,2,27);
/*!40000 ALTER TABLE `CONFIGURATION_FILES_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONFIGURATION_FILES_ATTRIBUTE_OPTION_GROUPS`
--

DROP TABLE IF EXISTS `CONFIGURATION_FILES_ATTRIBUTE_OPTION_GROUPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONFIGURATION_FILES_ATTRIBUTE_OPTION_GROUPS` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `cfa_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cfa_id` (`cfa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILES_ATTRIBUTE_OPTION_GROUPS`
--

LOCK TABLES `CONFIGURATION_FILES_ATTRIBUTE_OPTION_GROUPS` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILES_ATTRIBUTE_OPTION_GROUPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONFIGURATION_FILES_ATTRIBUTE_OPTION_GROUPS` ENABLE KEYS */;
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
  `description` varchar(2000) DEFAULT NULL,
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
INSERT INTO `CONFIGURATION_FILE_ATTRIBUTE_GROUPS` VALUES (17,'Rule engine initialization','Enable ModSecurity, attaching it to every transaction. Use detection\r\nonly to start with, because that minimises the chances of post-installation\r\ndisruption.',4),(18,'Request body handling','Request body handling - Description',4),(19,'Response body handling','Response body handling - Desc',4),(20,'Filesystem configuration','Filesystem configuration - Description',4),(21,'File uploads handling configuration','File uploads handling configuration - Description',4),(22,'Debug log configuration','Debug log configuration - Description',4),(23,'Audit log configuration','Audit log configuration - Description',4),(24,'Miscellaneous','Miscellaneous - Description',4),(25,'Group test 1','Group test 1 - Description',1),(27,'Exclusion Rules','Please see the file REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf.example for a description of the rule exclusions mechanism and the correct  use of this file',7);
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
  `description` varchar(1000) DEFAULT NULL,
  `group_option` int(11) DEFAULT NULL,
  `configuration_files_attributes_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuration_file_attribute_options_unq` (`name`,`configuration_files_attributes_id`),
  KEY `configuration_file_attribute_options_fk_cfa` (`configuration_files_attributes_id`),
  CONSTRAINT `configuration_file_attribute_options_fk_cfa` FOREIGN KEY (`configuration_files_attributes_id`) REFERENCES `CONFIGURATION_FILES_ATTRIBUTES` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS`
--

LOCK TABLES `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` VALUES (8,'On',NULL,NULL,46),(9,'Off',NULL,NULL,46),(10,'text/plain',NULL,NULL,47),(11,'text/html',NULL,NULL,47),(12,'text/xml',NULL,NULL,47),(15,'ProcessPartial',NULL,NULL,49),(16,'Rject',NULL,NULL,49),(17,'RelevantOnly',NULL,NULL,54),(18,'RelevantOnly',NULL,NULL,58),(20,'On',NULL,NULL,67),(21,'Off',NULL,NULL,67),(62,'On','buffer request bodies',NULL,39),(63,'Off','do not buffer request bodies',NULL,39),(64,'On','process rules',NULL,38),(65,'Off','do not process rules ',NULL,38),(66,'DetectionOnly','process rules but never executes any disruptive actions (block, deny, drop, allow, proxy and redirect) ',NULL,38),(67,'Reject','',NULL,43),(68,'ProcessPartial','',NULL,43),(69,'Serial','',NULL,61),(70,'Concurrent','',NULL,61);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_ATTRIBUTE_TYPE`
--

LOCK TABLES `CONFIGURATION_FILE_ATTRIBUTE_TYPE` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_TYPE` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILE_ATTRIBUTE_TYPE` VALUES (1,'input-text','This is a text input attribute'),(2,'single-select','This is a single-select attribute'),(3,'multiple-select','This is a multiple-select attribute'),(4,'numeric-input','This is a numeric imput.'),(5,'groups-selects-input','Multiple values comma separated. Each value has multiple possible values.');
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
-- Table structure for table `Event`
--

DROP TABLE IF EXISTS `Event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `PartA` longtext NOT NULL,
  `PartB` longtext,
  `PartC` longtext,
  `PartD` longtext,
  `PartE` longtext,
  `PartF` longtext,
  `PartG` longtext,
  `PartH` longtext,
  `PartI` longtext,
  `PartJ` longtext,
  `PartK` longtext,
  `PartZ` longtext NOT NULL,
  `dateEvent` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `transactionId` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `clientIp` tinytext NOT NULL,
  `clientPort` tinytext NOT NULL,
  `serverIp` tinytext NOT NULL,
  `serverPort` tinytext NOT NULL,
  `method` tinytext,
  `destinationPage` mediumtext,
  `protocol` tinytext,
  `is_new` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionId_UNIQUE` (`transactionId`)
) ENGINE=InnoDB AUTO_INCREMENT=1433 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Event`
--

LOCK TABLES `Event` WRITE;
/*!40000 ALTER TABLE `Event` DISABLE KEYS */;
INSERT INTO `Event` VALUES (1093,'--6780641a-A--\n[30/Sep/2017:12:11:20 --0300] Wc@0GH8AAQEAAB4DEm4AAAAC 127.0.0.1 42940 127.0.0.1 80\n','--6780641a-B--\nPOST / HTTP/1.1\nHost: localhost\nUser-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:55.0) Gecko/20100101 Firefox/55.0\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\nAccept-Language: es-ES,es;q=0.8,en-US;q=0.5,en;q=0.3\nAccept-Encoding: gzip, deflate\nReferer: http://localhost/\nContent-Type: application/x-www-form-urlencoded\nContent-Length: 46\nConnection: keep-alive\nUpgrade-Insecure-Requests: 1\n','--6780641a-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--6780641a-E--\n','--6780641a-F--\nHTTP/1.1 200 OK\nVary: Accept-Encoding\nContent-Encoding: gzip\nContent-Length: 82\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=UTF-8\n',NULL,'--6780641a-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. Operator GE matched 5 at TX:anomaly_score. [file \"/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Handler: application/x-httpd-php\nStopwatch: 1506784280375870 278911 (- - -)\nStopwatch2: 1506784280375870 278911; combined=94526, p1=34902, p2=57227, p3=428, p4=1823, p5=146, sr=703, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.0 (http://www.modsecurity.org/); OWASP_CRS/3.0.2.\nServer: Apache/2.4.18 (Ubuntu)\nEngine-Mode: \"DETECTION_ONLY\"\n',NULL,NULL,NULL,'--6780641a-Z--\n','2017-09-30 12:11:20','Wc@0GH8AAQEAAB4DEm4AAAAC','127.0.0.1','42940','127.0.0.1','80\n','POST','/','HTTP/1.1',0),(1308,'--a0369a43-A--\n[29/Sep/2017:18:24:42 --0300] Wc66Gn8AAQEAAAje@f8AAAAA ::1 46928 ::1 80\n','--a0369a43-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nContent-Type: application/x-www-form-urlencoded\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--a0369a43-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--a0369a43-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.25 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--a0369a43-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=98\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--a0369a43-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1506720282531930 4687 (- - -)\nStopwatch2: 1506720282531930 4687; combined=3375, p1=613, p2=2535, p3=0, p4=0, p5=227, sr=20, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.1 (http://www.modsecurity.org/); OWASP_CRS/3.0.0.\nServer: Apache/2.4.25 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--a0369a43-Z--\n','2017-09-29 18:24:42','Wc66Gn8AAQEAAAje@f8AAAAA','::1','46928','::1','80\n','POST','/login.php','HTTP/1.1',0),(1325,'--c2d60050-A--\n[30/Sep/2017:18:57:16 --0300] WdATPH8AAQEAAANHjDcAAAAB ::1 60892 ::1 80\n','--c2d60050-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nContent-Type: application/x-www-form-urlencoded\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--c2d60050-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--c2d60050-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.25 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--c2d60050-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--c2d60050-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1506808636133244 3885 (- - -)\nStopwatch2: 1506808636133244 3885; combined=2491, p1=520, p2=1834, p3=0, p4=0, p5=137, sr=26, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.1 (http://www.modsecurity.org/); OWASP_CRS/3.0.0.\nServer: Apache/2.4.25 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--c2d60050-Z--\n','2017-09-30 18:57:16','WdATPH8AAQEAAANHjDcAAAAB','::1','60892','::1','80\n','POST','/login.php','HTTP/1.1',0),(1326,'--c2d60050-A--\n[30/Sep/2017:18:58:19 --0300] WdATe38AAQEAAANIu48AAAAC ::1 60918 ::1 80\n','--c2d60050-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 69\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nContent-Type: application/x-www-form-urlencoded\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--c2d60050-C--\nusername=%3Cscript%3Ealert%28%29%3C%2Fscript%3E&password=&login=Login\n',NULL,'--c2d60050-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.25 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--c2d60050-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--c2d60050-H--\nMessage: Warning. detected XSS using libinjection. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"56\"] [id \"941100\"] [rev \"2\"] [msg \"XSS Attack Detected via libinjection\"] [data \"Matched Data: accept-language found within ARGS:username: <script>alert()</script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Warning. Pattern match \"(?i)([<\\xef\\xbc\\x9c]script[^>\\xef\\xbc\\x9e]*[>\\xef\\xbc\\x9e][\\\\s\\\\S]*?)\" at ARGS:username. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"91\"] [id \"941110\"] [rev \"2\"] [msg \"XSS Filter - Category 1: Script Tag Vector\"] [data \"Matched Data: <script> found within ARGS:username: <script>alert()</script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"4\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Warning. Pattern match \"(?i)<[^\\\\w<>]*(?:[^<>\\\"\'\\\\s]*:)?[^\\\\w<>]*(?:\\\\W*?s\\\\W*?c\\\\W*?r\\\\W*?i\\\\W*?p\\\\W*?t|\\\\W*?f\\\\W*?o\\\\W*?r\\\\W*?m|\\\\W*?s\\\\W*?t\\\\W*?y\\\\W*?l\\\\W*?e|\\\\W*?s\\\\W*?v\\\\W*?g|\\\\W*?m\\\\W*?a\\\\W*?r\\\\W*?q\\\\W*?u\\\\W*?e\\\\W*?e|(?:\\\\W*?l\\\\W*?i\\\\W*?n\\\\W*?k|\\\\W*?o\\\\W*?b\\\\W*?j\\\\W*?e\\ ...\" at ARGS:username. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"267\"] [id \"941160\"] [rev \"2\"] [msg \"NoScript XSS InjectionChecker: HTML Injection\"] [data \"Matched Data: <script found within ARGS:username: <script>alert()</script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 15)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 15 - SQLI=0,XSS=15,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): NoScript XSS InjectionChecker: HTML Injection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1506808699516010 5098 (- - -)\nStopwatch2: 1506808699516010 5098; combined=3951, p1=824, p2=3002, p3=0, p4=0, p5=125, sr=22, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.1 (http://www.modsecurity.org/); OWASP_CRS/3.0.0.\nServer: Apache/2.4.25 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--c2d60050-Z--\n','2017-09-30 18:58:19','WdATe38AAQEAAANIu48AAAAC','::1','60918','::1','80\n','POST','/login.php','HTTP/1.1',0),(1327,'--08f0565c-A--\n[03/Oct/2017:18:18:05 --0300] WdP@jX8AAQEAAAbFbQcAAAAD ::1 38028 ::1 80\n','--08f0565c-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 42\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nContent-Type: application/x-www-form-urlencoded\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--08f0565c-C--\nusername=%27+or+true&password=&login=Login\n',NULL,'--08f0565c-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.25 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--08f0565c-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--08f0565c-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 5)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 5 - SQLI=5,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1507065485895135 4698 (- - -)\nStopwatch2: 1507065485895135 4698; combined=3333, p1=760, p2=2424, p3=0, p4=0, p5=149, sr=29, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.1 (http://www.modsecurity.org/); OWASP_CRS/3.0.0.\nServer: Apache/2.4.25 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--08f0565c-Z--\n','2017-10-03 18:18:05','WdP@jX8AAQEAAAbFbQcAAAAD','::1','38028','::1','80\n','POST','/login.php','HTTP/1.1',0),(1342,'--4b3cbc1a-A--\n[05/Oct/2017:17:30:41 --0300] WdaWcX8AAQEAAAivRUcAAAAA ::1 50746 ::1 80\n','--4b3cbc1a-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 69\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nContent-Type: application/x-www-form-urlencoded\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--4b3cbc1a-C--\nusername=%3Cscript%3Ealert%28%29%3C%2Fscript%3E&password=&login=Login\n',NULL,'--4b3cbc1a-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.25 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--4b3cbc1a-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=97\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--4b3cbc1a-H--\nMessage: Warning. detected XSS using libinjection. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"56\"] [id \"941100\"] [rev \"2\"] [msg \"XSS Attack Detected via libinjection\"] [data \"Matched Data: accept-language found within ARGS:username: <script>alert()</script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Warning. Pattern match \"(?i)([<\\xef\\xbc\\x9c]script[^>\\xef\\xbc\\x9e]*[>\\xef\\xbc\\x9e][\\\\s\\\\S]*?)\" at ARGS:username. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"91\"] [id \"941110\"] [rev \"2\"] [msg \"XSS Filter - Category 1: Script Tag Vector\"] [data \"Matched Data: <script> found within ARGS:username: <script>alert()</script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"4\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Warning. Pattern match \"(?i)<[^\\\\w<>]*(?:[^<>\\\"\'\\\\s]*:)?[^\\\\w<>]*(?:\\\\W*?s\\\\W*?c\\\\W*?r\\\\W*?i\\\\W*?p\\\\W*?t|\\\\W*?f\\\\W*?o\\\\W*?r\\\\W*?m|\\\\W*?s\\\\W*?t\\\\W*?y\\\\W*?l\\\\W*?e|\\\\W*?s\\\\W*?v\\\\W*?g|\\\\W*?m\\\\W*?a\\\\W*?r\\\\W*?q\\\\W*?u\\\\W*?e\\\\W*?e|(?:\\\\W*?l\\\\W*?i\\\\W*?n\\\\W*?k|\\\\W*?o\\\\W*?b\\\\W*?j\\\\W*?e\\ ...\" at ARGS:username. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"267\"] [id \"941160\"] [rev \"2\"] [msg \"NoScript XSS InjectionChecker: HTML Injection\"] [data \"Matched Data: <script found within ARGS:username: <script>alert()</script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 15)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 15 - SQLI=0,XSS=15,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): NoScript XSS InjectionChecker: HTML Injection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1507235441282306 2878 (- - -)\nStopwatch2: 1507235441282306 2878; combined=2369, p1=326, p2=1926, p3=0, p4=0, p5=116, sr=12, sw=1, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.1 (http://www.modsecurity.org/); OWASP_CRS/3.0.0.\nServer: Apache/2.4.25 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--4b3cbc1a-Z--\n','2017-10-05 17:30:41','WdaWcX8AAQEAAAivRUcAAAAA','::1','50746','::1','80\n','POST','/login.php','HTTP/1.1',0),(1343,'--3c19ad6e-A--\n[09/Oct/2017:20:18:55 --0300] WdwD338AAQEAAAOPR6UAAAAB ::1 42768 ::1 80\n','--3c19ad6e-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 43\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nContent-Type: application/x-www-form-urlencoded\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--3c19ad6e-C--\nusername=%3Cscript%3E&password=&login=Login\n',NULL,'--3c19ad6e-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.25 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--3c19ad6e-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--3c19ad6e-H--\nMessage: Warning. detected XSS using libinjection. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"56\"] [id \"941100\"] [rev \"2\"] [msg \"XSS Attack Detected via libinjection\"] [data \"Matched Data: accept-language found within ARGS:username: <script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Warning. Pattern match \"(?i)([<\\xef\\xbc\\x9c]script[^>\\xef\\xbc\\x9e]*[>\\xef\\xbc\\x9e][\\\\s\\\\S]*?)\" at ARGS:username. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"91\"] [id \"941110\"] [rev \"2\"] [msg \"XSS Filter - Category 1: Script Tag Vector\"] [data \"Matched Data: <script> found within ARGS:username: <script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"4\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Warning. Pattern match \"(?i)<[^\\\\w<>]*(?:[^<>\\\"\'\\\\s]*:)?[^\\\\w<>]*(?:\\\\W*?s\\\\W*?c\\\\W*?r\\\\W*?i\\\\W*?p\\\\W*?t|\\\\W*?f\\\\W*?o\\\\W*?r\\\\W*?m|\\\\W*?s\\\\W*?t\\\\W*?y\\\\W*?l\\\\W*?e|\\\\W*?s\\\\W*?v\\\\W*?g|\\\\W*?m\\\\W*?a\\\\W*?r\\\\W*?q\\\\W*?u\\\\W*?e\\\\W*?e|(?:\\\\W*?l\\\\W*?i\\\\W*?n\\\\W*?k|\\\\W*?o\\\\W*?b\\\\W*?j\\\\W*?e\\ ...\" at ARGS:username. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"267\"] [id \"941160\"] [rev \"2\"] [msg \"NoScript XSS InjectionChecker: HTML Injection\"] [data \"Matched Data: <script found within ARGS:username: <script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 15)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 15 - SQLI=0,XSS=15,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): NoScript XSS InjectionChecker: HTML Injection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1507591135421512 4095 (- - -)\nStopwatch2: 1507591135421512 4095; combined=3091, p1=656, p2=2327, p3=0, p4=0, p5=108, sr=36, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.1 (http://www.modsecurity.org/); OWASP_CRS/3.0.0.\nServer: Apache/2.4.25 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--3c19ad6e-Z--\n','2017-10-09 20:18:55','WdwD338AAQEAAAOPR6UAAAAB','::1','42768','::1','80\n','POST','/login.php','HTTP/1.1',0),(1356,'--ca098b6c-A--\n[09/Oct/2017:20:27:03 --0300] WdwFx38AAQEAAAuO0nEAAAAA ::1 43100 ::1 80\n','--ca098b6c-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 43\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nContent-Type: application/x-www-form-urlencoded\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--ca098b6c-C--\nusername=%3Cscript%3E&password=&login=Login\n',NULL,'--ca098b6c-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.25 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--ca098b6c-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--ca098b6c-H--\nMessage: Warning. detected XSS using libinjection. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"56\"] [id \"941100\"] [rev \"2\"] [msg \"XSS Attack Detected via libinjection\"] [data \"Matched Data: accept-language found within ARGS:username: <script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Warning. Pattern match \"(?i)([<\\xef\\xbc\\x9c]script[^>\\xef\\xbc\\x9e]*[>\\xef\\xbc\\x9e][\\\\s\\\\S]*?)\" at ARGS:username. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"91\"] [id \"941110\"] [rev \"2\"] [msg \"XSS Filter - Category 1: Script Tag Vector\"] [data \"Matched Data: <script> found within ARGS:username: <script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"4\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Warning. Pattern match \"(?i)<[^\\\\w<>]*(?:[^<>\\\"\'\\\\s]*:)?[^\\\\w<>]*(?:\\\\W*?s\\\\W*?c\\\\W*?r\\\\W*?i\\\\W*?p\\\\W*?t|\\\\W*?f\\\\W*?o\\\\W*?r\\\\W*?m|\\\\W*?s\\\\W*?t\\\\W*?y\\\\W*?l\\\\W*?e|\\\\W*?s\\\\W*?v\\\\W*?g|\\\\W*?m\\\\W*?a\\\\W*?r\\\\W*?q\\\\W*?u\\\\W*?e\\\\W*?e|(?:\\\\W*?l\\\\W*?i\\\\W*?n\\\\W*?k|\\\\W*?o\\\\W*?b\\\\W*?j\\\\W*?e\\ ...\" at ARGS:username. [file \"/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf\"] [line \"267\"] [id \"941160\"] [rev \"2\"] [msg \"NoScript XSS InjectionChecker: HTML Injection\"] [data \"Matched Data: <script found within ARGS:username: <script>\"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-xss\"] [tag \"OWASP_CRS/WEB_ATTACK/XSS\"] [tag \"WASCTC/WASC-8\"] [tag \"WASCTC/WASC-22\"] [tag \"OWASP_TOP_10/A3\"] [tag \"OWASP_AppSensor/IE1\"] [tag \"CAPEC-242\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 15)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 15 - SQLI=0,XSS=15,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): NoScript XSS InjectionChecker: HTML Injection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1507591623277876 3673 (- - -)\nStopwatch2: 1507591623277876 3673; combined=2712, p1=457, p2=2098, p3=0, p4=0, p5=157, sr=21, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.1 (http://www.modsecurity.org/); OWASP_CRS/3.0.0.\nServer: Apache/2.4.25 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--ca098b6c-Z--\n','2017-10-09 20:27:03','WdwFx38AAQEAAAuO0nEAAAAA','::1','43100','::1','80\n','POST','/login.php','HTTP/1.1',0),(1361,'--74937f54-A--\n[10/Oct/2017:17:25:59 --0300] Wd0s138AAQEAAAU0@S4AAAAA ::1 43364 ::1 80\n','--74937f54-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nContent-Type: application/x-www-form-urlencoded\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--74937f54-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--74937f54-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.25 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--74937f54-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=98\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--74937f54-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1507667159448791 2764 (- - -)\nStopwatch2: 1507667159448791 2764; combined=1784, p1=268, p2=1424, p3=0, p4=0, p5=92, sr=10, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.1 (http://www.modsecurity.org/); OWASP_CRS/3.0.0.\nServer: Apache/2.4.25 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--74937f54-Z--\n','2017-10-10 17:25:59','Wd0s138AAQEAAAU0@S4AAAAA','::1','43364','::1','80\n','POST','/login.php','HTTP/1.1',0),(1370,'--74937f54-A--\n[10/Oct/2017:17:32:02 --0300] Wd0uQn8AAQEAAAU2y0wAAAAC 192.168.0.23 54893 192.168.0.14 80\n','--74937f54-B--\nGET /favicon.ico HTTP/1.1\nHost: 192.168.0.14\nConnection: keep-alive\nUser-Agent: Mozilla/5.0 (Linux; Android 4.2.2; ME173X Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.98 Safari/537.36\nAccept: image/webp,image/apng,image/*,*/*;q=0.8\nReferer: http://192.168.0.14/login.php\nAccept-Encoding: gzip, deflate\nAccept-Language: es-US,es-419;q=0.8,es;q=0.6\n',NULL,NULL,'--74937f54-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>404 Not Found</title>\n</head><body>\n<h1>Not Found</h1>\n<p>The requested URL /favicon.ico was not found on this server.</p>\n<hr>\n<address>Apache/2.4.25 (Debian) Server at 192.168.0.14 Port 80</address>\n</body></html>\n','--74937f54-F--\nHTTP/1.1 404 Not Found\nContent-Length: 287\nKeep-Alive: timeout=5, max=99\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--74937f54-H--\nMessage: Warning. Pattern match \"^[\\\\d.:]+$\" at REQUEST_HEADERS:Host. [file \"/usr/share/modsecurity-crs/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf\"] [line \"793\"] [id \"920350\"] [rev \"2\"] [msg \"Host header is a numeric IP address\"] [data \"192.168.0.14\"] [severity \"WARNING\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"9\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-protocol\"] [tag \"OWASP_CRS/PROTOCOL_VIOLATION/IP_HOST\"] [tag \"WASCTC/WASC-21\"] [tag \"OWASP_TOP_10/A7\"] [tag \"PCI/6.5.10\"]\nApache-Error: [file \"apache2_util.c\"] [line 273] [level 3] [client %s] ModSecurity: %s%s [uri \"%s\"]%s\nStopwatch: 1507667522698728 2180 (- - -)\nStopwatch2: 1507667522698728 2180; combined=1655, p1=371, p2=923, p3=48, p4=241, p5=72, sr=12, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.1 (http://www.modsecurity.org/); OWASP_CRS/3.0.0.\nServer: Apache/2.4.25 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--74937f54-Z--\n','2017-10-10 17:32:02','Wd0uQn8AAQEAAAU2y0wAAAAC','192.168.0.23','54893','192.168.0.14','80\n','GET','/favicon.ico','HTTP/1.1',0);
/*!40000 ALTER TABLE `Event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventRule`
--

DROP TABLE IF EXISTS `EventRule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventRule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eventId` int(11) NOT NULL,
  `ruleId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_EventRule_Event1_idx` (`eventId`),
  KEY `fk_EventRule_Rule1_idx` (`ruleId`),
  CONSTRAINT `eventrule_fk_event` FOREIGN KEY (`eventId`) REFERENCES `Event` (`id`),
  CONSTRAINT `eventrule_fk_rule` FOREIGN KEY (`ruleId`) REFERENCES `Rule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventRule`
--

LOCK TABLES `EventRule` WRITE;
/*!40000 ALTER TABLE `EventRule` DISABLE KEYS */;
INSERT INTO `EventRule` VALUES (129,1093,36),(130,1093,36),(131,1093,37),(132,1093,38),(133,1308,36),(134,1308,36),(135,1308,37),(136,1308,38),(137,1325,36),(138,1325,36),(139,1325,37),(140,1325,38),(141,1326,39),(142,1326,40),(143,1326,41),(144,1326,37),(145,1326,38),(146,1327,36),(147,1327,37),(148,1327,38),(149,1342,39),(150,1342,40),(151,1342,41),(152,1342,37),(153,1342,38),(154,1343,39),(155,1343,40),(156,1343,41),(157,1343,37),(158,1343,38),(159,1356,39),(160,1356,40),(161,1356,41),(162,1356,37),(163,1356,38),(164,1361,36),(165,1361,36),(166,1361,37),(167,1361,38),(168,1370,42);
/*!40000 ALTER TABLE `EventRule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `File`
--

DROP TABLE IF EXISTS `File`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `File` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileName` tinytext NOT NULL,
  `filePath` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filePath_UNIQUE` (`filePath`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File`
--

LOCK TABLES `File` WRITE;
/*!40000 ALTER TABLE `File` DISABLE KEYS */;
INSERT INTO `File` VALUES (33,'REQUEST-942-APPLICATION-ATTACK-SQLI','/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf'),(34,'REQUEST-949-BLOCKING-EVALUATION','/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf'),(35,'RESPONSE-980-CORRELATION','/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf'),(36,'REQUEST-941-APPLICATION-ATTACK-XSS','/usr/share/modsecurity-crs/rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf'),(37,'REQUEST-920-PROTOCOL-ENFORCEMENT','/usr/share/modsecurity-crs/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf');
/*!40000 ALTER TABLE `File` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rule`
--

DROP TABLE IF EXISTS `Rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ruleId` varchar(10) NOT NULL,
  `message` tinytext,
  `severity` varchar(45) DEFAULT NULL,
  `fileId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ruleId_UNIQUE` (`ruleId`),
  KEY `fk_Rule_File1_idx` (`fileId`),
  CONSTRAINT `fk_Rule_File1` FOREIGN KEY (`fileId`) REFERENCES `File` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rule`
--

LOCK TABLES `Rule` WRITE;
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
INSERT INTO `Rule` VALUES (36,'942100','SQL Injection Attack Detected via libinjection','CRITICAL',33),(37,'949110','Inbound Anomaly Score Exceeded (Total Score: 10)','CRITICAL',34),(38,'980130','Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection','',35),(39,'941100','XSS Attack Detected via libinjection','CRITICAL',36),(40,'941110','XSS Filter - Category 1: Script Tag Vector','CRITICAL',36),(41,'941160','NoScript XSS InjectionChecker: HTML Injection','CRITICAL',36),(42,'920350','Host header is a numeric IP address','WARNING',37);
/*!40000 ALTER TABLE `Rule` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
INSERT INTO `USERS` VALUES (13,'admin','admin','admin','admin','admin@admin.com',1),(14,'Joaquin','$2a$10$xxp7iOJ/lwbMVHB13Y1mJutIjJKqlMz5CWda3FgQrbfOv4y2w5Nbe','Joaquin','Maza','maza.joaquin@gmail.com',1);
/*!40000 ALTER TABLE `USERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS_HISTORY`
--

DROP TABLE IF EXISTS `USERS_HISTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USERS_HISTORY` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(3000) DEFAULT NULL,
  `date_event` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cnstrain_users_fk_users_history` FOREIGN KEY (`user_id`) REFERENCES `USERS` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS_HISTORY`
--

LOCK TABLES `USERS_HISTORY` WRITE;
/*!40000 ALTER TABLE `USERS_HISTORY` DISABLE KEYS */;
INSERT INTO `USERS_HISTORY` VALUES (1,'User Loggin','2017-08-28 18:53:16',13),(2,'User Loggin','2017-08-28 20:02:54',13),(3,'User Loggin','2017-08-28 20:13:01',13),(4,'User Loggin','2017-08-28 21:01:19',13),(5,'User Loggin','2017-08-28 21:07:46',14),(6,'User Loggin','2017-08-29 09:38:44',13),(7,'User Loggin','2017-08-29 12:57:45',13),(8,'User Loggin','2017-08-29 19:10:56',13),(9,'Rule Block','2017-08-29 19:14:20',13),(10,'User Loggin','2017-08-30 10:09:01',13),(11,'Rule Block - Current Values : 910000,980130,949110,920350 - Rules: 910000,980130','2017-08-30 10:09:48',13),(12,'User Loggin','2017-08-30 12:17:13',13),(13,'ModSecurity.conf setup - Setup SecRuleEngine Attribute: Off to DetectionOnly\n - Setup SecRequestBodyAccess Attribute: On to On\n - SecRequestBodyLimit was blocked \n - Setup SecRequestBodyNoFilesLimit Attribute: 1048576 to 1048576\n - Setup SecRequestBodyInMemoryLimit Attribute: 131072 to 131072\n - Setup SecRuleEngine Attribute: Off to DetectionOnly\n - SecRequestBodyLimit was blocked \n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecResponseBodyAccess Attribute: On to On\n - Setup SecResponseBodyMimeType Attribute: text/plain to text/plain\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecTmpDir Attribute: /tmp/ to /tmp/\n - Setup SecDataDir Attribute: /tmp/ to /tmp/\n - Setup SecUploadDir Attribute: /opt/modsecurity/var/upload/ to /opt/modsecurity/var/upload/\n - Setup SecUploadKeepFiles Attribute: RelevantOnly to RelevantOnly\n - Setup SecUploadFileMode Attribute: 0600 to 0600\n - SecDebugLog was blocked \n - SecDebugLog was blocked \n - SecDebugLogLevel was blocked \n - Setup SecAuditEngine Attribute: RelevantOnly to RelevantOnly\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecArgumentSeparator Attribute: & to &\n - Setup SecCookieFormat Attribute: 0 to 0\n - Setup SecUnicodeMapFile Attribute: unicode.mapping 20127 to unicode.mapping 20127\n - Setup SecStatusEngine Attribute: On to On\n','2017-08-30 12:17:43',13),(14,'User Loggin','2017-08-30 17:46:37',13),(15,'User Loggin','2017-08-30 19:28:19',13),(16,'User Loggin','2017-08-30 19:58:36',13),(17,'User Loggin','2017-08-31 00:12:05',13),(18,'User Loggin','2017-08-31 00:36:17',13),(19,'User Loggin','2017-08-31 09:58:49',13),(20,'User Loggin','2017-08-31 10:33:45',13),(21,'User Loggin','2017-08-31 11:07:03',13),(22,'User Loggin','2017-08-31 11:45:37',13),(23,'User Loggin','2017-08-31 12:42:07',13),(24,'User Loggin','2017-08-31 14:03:21',13),(25,'User Loggin','2017-08-31 16:14:14',13),(26,'User Loggin','2017-08-31 16:21:18',13),(27,'User Loggin','2017-09-04 11:08:42',13),(28,'User Loggin','2017-09-04 12:07:02',13),(29,'User Loggin','2017-09-04 13:52:48',13),(30,'User Loggin','2017-09-04 19:01:33',13),(31,'User Loggin','2017-09-05 09:42:23',13),(32,'User Loggin','2017-09-05 11:28:46',13),(33,'User Loggin','2017-09-05 11:35:24',13),(34,'User Loggin','2017-09-05 18:19:36',13),(35,'User Loggin','2017-09-05 18:45:57',13),(36,'User Loggin','2017-09-05 19:00:22',14),(37,'User Loggin','2017-09-05 19:47:16',14),(38,'User Loggin','2017-09-06 09:54:57',13),(39,'User Loggin','2017-09-06 11:09:20',13),(40,'User Loggin','2017-09-06 11:45:18',13),(41,'ModSecurity.conf setup - Setup SecRuleEngine Attribute: DetectionOnly to On\n - Setup SecRequestBodyAccess Attribute: On to On\n - SecRequestBodyLimit was blocked \n - Setup SecRequestBodyNoFilesLimit Attribute: 1048576 to 1048576\n - Setup SecRequestBodyInMemoryLimit Attribute: 131072 to 131072\n - Setup SecRuleEngine Attribute: DetectionOnly to On\n - SecRequestBodyLimit was blocked \n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecResponseBodyAccess Attribute: On to On\n - Setup SecResponseBodyMimeType Attribute: text/plain to text/plain\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecTmpDir Attribute: /tmp/ to /tmp/\n - Setup SecDataDir Attribute: /tmp/ to /tmp/\n - Setup SecUploadDir Attribute: /opt/modsecurity/var/upload/ to /opt/modsecurity/var/upload/\n - Setup SecUploadKeepFiles Attribute: RelevantOnly to RelevantOnly\n - Setup SecUploadFileMode Attribute: 0600 to 0600\n - SecDebugLog was blocked \n - SecDebugLog was blocked \n - SecDebugLogLevel was blocked \n - Setup SecAuditEngine Attribute: RelevantOnly to RelevantOnly\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecArgumentSeparator Attribute: & to &\n - Setup SecCookieFormat Attribute: 0 to 0\n - Setup SecUnicodeMapFile Attribute: unicode.mapping 20127 to unicode.mapping 20127\n - Setup SecStatusEngine Attribute: On to On\n','2017-09-06 11:45:58',13),(42,'User Loggin','2017-09-07 19:44:27',13),(43,'ModSecurity.conf setup - Setup SecRuleEngine Attribute: On to DetectionOnly\n - Setup SecRequestBodyAccess Attribute: On to On\n - SecRequestBodyLimit was blocked \n - Setup SecRequestBodyNoFilesLimit Attribute: 1048576 to 1048576\n - Setup SecRequestBodyInMemoryLimit Attribute: 131072 to 131072\n - Setup SecRuleEngine Attribute: On to DetectionOnly\n - SecRequestBodyLimit was blocked \n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecResponseBodyAccess Attribute: On to On\n - Setup SecResponseBodyMimeType Attribute: text/plain to text/plain\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecTmpDir Attribute: /tmp/ to /tmp/\n - Setup SecDataDir Attribute: /tmp/ to /tmp/\n - Setup SecUploadDir Attribute: /opt/modsecurity/var/upload/ to /opt/modsecurity/var/upload/\n - Setup SecUploadKeepFiles Attribute: RelevantOnly to RelevantOnly\n - Setup SecUploadFileMode Attribute: 0600 to 0600\n - SecDebugLog was blocked \n - SecDebugLog was blocked \n - SecDebugLogLevel was blocked \n - Setup SecAuditEngine Attribute: RelevantOnly to RelevantOnly\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecArgumentSeparator Attribute: & to &\n - Setup SecCookieFormat Attribute: 0 to 0\n - Setup SecUnicodeMapFile Attribute: unicode.mapping 20127 to unicode.mapping 20127\n - Setup SecStatusEngine Attribute: On to On\n','2017-09-07 19:45:00',13),(44,'User Loggin','2017-09-08 09:50:02',13),(45,'User Loggin','2017-09-08 11:43:06',13),(46,'User Loggin','2017-09-08 12:18:01',13),(47,'User Loggin','2017-09-08 12:21:57',13),(48,'User Loggin','2017-09-08 17:22:53',13),(49,'User Loggin','2017-09-08 17:37:10',13),(50,'User Loggin','2017-09-08 18:58:39',13),(51,'User Loggin','2017-09-08 19:35:16',13),(52,'User Loggin','2017-09-08 19:41:43',13),(53,'User Loggin','2017-09-08 21:18:06',13),(54,'User Loggin','2017-09-11 09:21:06',13),(55,'User Loggin','2017-09-11 09:37:46',13),(56,'User Loggin','2017-09-12 08:13:31',13),(57,'User Loggin','2017-09-12 12:22:14',13),(58,'ModSecurity.conf setup - Setup SecRuleEngine Attribute: DetectionOnly to On\n - Setup SecRequestBodyAccess Attribute: On to On\n - SecRequestBodyLimit was blocked \n - Setup SecRequestBodyNoFilesLimit Attribute: 1048576 to 1048576\n - Setup SecRequestBodyInMemoryLimit Attribute: 131072 to 131072\n - Setup SecRuleEngine Attribute: DetectionOnly to On\n - SecRequestBodyLimit was blocked \n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecResponseBodyAccess Attribute: On to On\n - Setup SecResponseBodyMimeType Attribute: text/plain to text/plain\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecTmpDir Attribute: /tmp/ to /tmp/\n - Setup SecDataDir Attribute: /tmp/ to /tmp/\n - Setup SecUploadDir Attribute: /opt/modsecurity/var/upload/ to /opt/modsecurity/var/upload/\n - Setup SecUploadKeepFiles Attribute: RelevantOnly to RelevantOnly\n - Setup SecUploadFileMode Attribute: 0600 to 0600\n - SecDebugLog was blocked \n - SecDebugLog was blocked \n - SecDebugLogLevel was blocked \n - Setup SecAuditEngine Attribute: RelevantOnly to RelevantOnly\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to /var/log/apache2/modsec_audit.log\n - Setup SecArgumentSeparator Attribute: & to &\n - Setup SecCookieFormat Attribute: 0 to 0\n - Setup SecUnicodeMapFile Attribute: unicode.mapping 20127 to unicode.mapping 20127\n - Setup SecStatusEngine Attribute: On to On\n','2017-09-12 12:57:51',13),(59,'User Loggin','2017-09-12 17:01:56',13),(60,'User Loggin','2017-09-12 17:09:48',14),(61,'User Loggin','2017-09-12 17:26:19',13),(62,'ModSecurity.conf setup - Setup SecRuleEngine Attribute: DetectionOnly to On\n - Setup SecRequestBodyAccess Attribute: On to On\n - SecRequestBodyLimit was blocked \n - Setup SecRequestBodyNoFilesLimit Attribute: 131072 to 1048576\n - Setup SecRequestBodyInMemoryLimit Attribute: 131072 to 131072\n - Setup SecRuleEngine Attribute: when  is set to DetectionOnly mode in order to minimize to On\n - Setup SecRequestBodyLimitAction Attribute: Reject to Reject\n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecPcreMatchLimitRecursion Attribute: 1000 to 1000\n - Setup SecResponseBodyAccess Attribute: On to On\n - Setup SecResponseBodyMimeType Attribute: text/plain text/html text/xml to text/plain\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecResponseBodyLimitAction Attribute: ProcessPartial to ProcessPartial\n - Setup SecTmpDir Attribute: /tmp/ to /tmp/\n - Setup SecDataDir Attribute: /tmp/ to /tmp/\n - Setup SecUploadDir Attribute: /opt/modsecurity/var/upload/ to /opt/modsecurity/var/upload/\n - Setup SecUploadKeepFiles Attribute: RelevantOnly to RelevantOnly\n - Setup SecUploadFileMode Attribute: 0600 to 0600\n - SecDebugLog was blocked \n - SecDebugLogLevel was blocked \n - Setup SecAuditEngine Attribute: RelevantOnly to RelevantOnly\n - Setup SecAuditLogRelevantStatus Attribute: \"^(?:5|4(?!04))\" to ^(?:5|4(?!04))\n - Setup SecAuditLogParts Attribute: ABIJDEFHZ to ABIJDEFHZ\n - Setup SecAuditLogType Attribute: Serial to Concurrent\n - Setup SecAuditLog Attribute: /var/log/apache2/modsec_audit.log to \"|/etc/modsecurity-2.9.2/mlogc/mlogc /etc/modsecurity-2.9.2/mlogc/mlogc.conf\"\n - SecAuditLogStorageDir was blocked \n - Setup SecArgumentSeparator Attribute: & to &\n - Setup SecCookieFormat Attribute: 0 to 0\n - Setup SecUnicodeMapFile Attribute: unicode.mapping 20127 to unicode.mapping 20127\n - Setup SecStatusEngine Attribute: On to On\n','2017-09-12 17:39:00',13),(63,'ModSecurity.conf setup - Setup SecRuleEngine Attribute: On to On\n - Setup SecRequestBodyAccess Attribute: On to On\n - SecRequestBodyLimit was blocked \n - Setup SecRequestBodyNoFilesLimit Attribute: 1048576 to 1048576\n - Setup SecRequestBodyInMemoryLimit Attribute: 131072 to 131072\n - Setup SecRuleEngine Attribute: On to On\n - Setup SecRequestBodyLimitAction Attribute: Reject to Reject\n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecPcreMatchLimitRecursion Attribute: 1000 to 1000\n - Setup SecResponseBodyAccess Attribute: On to On\n - Setup SecResponseBodyMimeType Attribute: text/plain to text/plain\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecResponseBodyLimitAction Attribute: ProcessPartial to ProcessPartial\n - Setup SecTmpDir Attribute: /tmp/ to /tmp/\n - Setup SecDataDir Attribute: /tmp/ to /tmp/\n - Setup SecUploadDir Attribute: /opt/modsecurity/var/upload/ to /opt/modsecurity/var/upload/\n - Setup SecUploadKeepFiles Attribute: RelevantOnly to RelevantOnly\n - Setup SecUploadFileMode Attribute: 0600 to 0600\n - SecDebugLog was blocked \n - SecDebugLogLevel was blocked \n - Setup SecAuditEngine Attribute: RelevantOnly to RelevantOnly\n - Setup SecAuditLogRelevantStatus Attribute: \"^(?:5|4(?!04))\" to ^(?:5|4(?!04))\n - Setup SecAuditLogParts Attribute: ABIJDEFHZ to ABIJDEFHZ\n - Setup SecAuditLogType Attribute: Concurrent to Concurrent\n - Setup SecAuditLog Attribute: \"|/etc/modsecurity-2.9.2/mlogc/mlogc /etc/modsecurity-2.9.2/mlogc/mlogc.conf\" to |/etc/modsecurity-2.9.2/mlogc/mlogc /etc/modsecurity-2.9.2/mlogc/mlogc.conf\n - Setup SecAuditLogStorageDir Attribute: /opt/modsecurity/var/audit/ to /tmp/mlogc/\n - Setup SecArgumentSeparator Attribute: & to &\n - Setup SecCookieFormat Attribute: 0 to 0\n - Setup SecUnicodeMapFile Attribute: unicode.mapping 20127 to unicode.mapping 20127\n - Setup SecStatusEngine Attribute: On to On\n','2017-09-12 17:42:23',13),(64,'User Loggin','2017-09-12 18:24:11',13),(65,'User Loggin','2017-09-12 18:30:35',13),(66,'User Loggin','2017-09-13 09:09:08',14),(67,'User Loggin','2017-09-13 11:59:08',14),(68,'User Loggin','2017-09-13 13:20:44',13),(69,'User Loggin','2017-09-13 21:33:44',13),(70,'User Loggin','2017-09-14 09:29:44',13),(71,'User Loggin','2017-09-14 15:32:19',13),(72,'User Loggin','2017-09-14 18:38:17',13),(73,'User Loggin','2017-09-14 19:24:19',14),(74,'User Loggin','2017-09-14 20:45:29',14),(75,'ModSecurity.conf setup - Setup SecRuleEngine Attribute: On to DetectionOnly\n - Setup SecRequestBodyAccess Attribute: On to On\n - SecRequestBodyLimit was blocked \n - Setup SecRequestBodyNoFilesLimit Attribute: 1048576 to 1048576\n - Setup SecRequestBodyInMemoryLimit Attribute: 131072 to 131072\n - Setup SecRuleEngine Attribute: On to DetectionOnly\n - Setup SecRequestBodyLimitAction Attribute: Reject to Reject\n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecPcreMatchLimitRecursion Attribute: 1000 to 1000\n - Setup SecResponseBodyAccess Attribute: On to On\n - Setup SecResponseBodyMimeType Attribute: text/plain to text/plain\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecResponseBodyLimitAction Attribute: ProcessPartial to ProcessPartial\n - Setup SecTmpDir Attribute: /tmp/ to /tmp/\n - Setup SecDataDir Attribute: /tmp/ to /tmp/\n - Setup SecUploadDir Attribute: /opt/modsecurity/var/upload/ to /opt/modsecurity/var/upload/\n - Setup SecUploadKeepFiles Attribute: RelevantOnly to RelevantOnly\n - Setup SecUploadFileMode Attribute: 0600 to 0600\n - SecDebugLog was blocked \n - SecDebugLogLevel was blocked \n - Setup SecAuditEngine Attribute: RelevantOnly to RelevantOnly\n - Setup SecAuditLogRelevantStatus Attribute: \"^(?:5|4(?!04))\" to ^(?:5|4(?!04))\n - Setup SecAuditLogParts Attribute: ABIJDEFHZ to ABIJDEFHZ\n - Setup SecAuditLogType Attribute: Concurrent to Concurrent\n - Setup SecAuditLog Attribute: \"|/usr/bin/mlogc /etc/mlogc.conf\" to |/etc/modsecurity-2.9.2/mlogc/mlogc /etc/modsecurity-2.9.2/mlogc/mlogc.conf\n - Setup SecAuditLogStorageDir Attribute: /tmp/mlogc/data to /tmp/mlogc/\n - Setup SecArgumentSeparator Attribute: & to &\n - Setup SecCookieFormat Attribute: 0 to 0\n - Setup SecUnicodeMapFile Attribute: unicode.mapping 20127 to unicode.mapping 20127\n - Setup SecStatusEngine Attribute: On to On\n','2017-09-14 20:50:27',14),(76,'ModSecurity.conf setup - Setup SecRuleEngine Attribute: DetectionOnly to Off\n - Setup SecRequestBodyAccess Attribute: On to On\n - SecRequestBodyLimit was blocked \n - Setup SecRequestBodyNoFilesLimit Attribute: 1048576 to 1048576\n - Setup SecRequestBodyInMemoryLimit Attribute: 131072 to 131072\n - Setup SecRuleEngine Attribute: DetectionOnly to Off\n - Setup SecRequestBodyLimitAction Attribute: Reject to Reject\n - Setup SecPcreMatchLimit Attribute: 1000 to 1000\n - Setup SecPcreMatchLimitRecursion Attribute: 1000 to 1000\n - Setup SecResponseBodyAccess Attribute: On to On\n - Setup SecResponseBodyMimeType Attribute: text/plain to text/plain\n - Setup SecResponseBodyLimit Attribute: 524288 to 524288\n - Setup SecResponseBodyLimitAction Attribute: ProcessPartial to ProcessPartial\n - Setup SecTmpDir Attribute: /tmp/ to /tmp/\n - Setup SecDataDir Attribute: /tmp/ to /tmp/\n - Setup SecUploadDir Attribute: /opt/modsecurity/var/upload/ to /opt/modsecurity/var/upload/\n - Setup SecUploadKeepFiles Attribute: RelevantOnly to RelevantOnly\n - Setup SecUploadFileMode Attribute: 0600 to 0600\n - SecDebugLog was blocked \n - SecDebugLogLevel was blocked \n - Setup SecAuditEngine Attribute: RelevantOnly to RelevantOnly\n - Setup SecAuditLogRelevantStatus Attribute: ^(?:5|4(?!04)) to ^(?:5|4(?!04))\n - Setup SecAuditLogParts Attribute: ABIJDEFHZ to ABIJDEFHZ\n - Setup SecAuditLogType Attribute: Concurrent to Concurrent\n - Setup SecAuditLog Attribute: |/etc/modsecurity-2.9.2/mlogc/mlogc /etc/modsecurity-2.9.2/mlogc/mlogc.conf to |/etc/modsecurity-2.9.2/mlogc/mlogc /etc/modsecurity-2.9.2/mlogc/mlogc.conf\n - Setup SecAuditLogStorageDir Attribute: /tmp/mlogc/ to /tmp/mlogc/\n - Setup SecArgumentSeparator Attribute: & to &\n - Setup SecCookieFormat Attribute: 0 to 0\n - Setup SecUnicodeMapFile Attribute: unicode.mapping 20127 to unicode.mapping 20127\n - Setup SecStatusEngine Attribute: On to On\n','2017-09-14 20:51:06',14),(77,'User Loggin','2017-09-15 17:55:31',14),(78,'User Loggin','2017-09-15 18:45:45',14),(79,'User Loggin','2017-09-19 11:11:35',14),(80,'User Loggin','2017-09-20 15:23:47',14),(81,'User Loggin','2017-09-20 18:33:52',14),(82,'User Loggin','2017-09-20 18:55:21',14),(83,'User Loggin','2017-09-20 22:00:59',14),(84,'User Loggin','2017-09-20 22:18:18',14),(85,'User Loggin','2017-09-20 22:54:33',14),(86,'User Loggin','2017-09-20 23:04:26',14),(87,'User Loggin','2017-09-20 23:11:12',14),(88,'User Loggin','2017-09-20 23:15:53',14),(89,'User Loggin','2017-09-21 15:21:55',14),(90,'User Loggin','2017-09-22 17:53:28',14),(91,'User Loggin','2017-09-23 01:30:12',14),(92,'User Loggin','2017-09-23 11:10:26',14),(93,'User Loggin','2017-09-25 11:54:39',14),(94,'User Loggin','2017-09-25 11:58:56',14),(95,'User Loggin','2017-09-25 16:23:48',14),(96,'User Loggin','2017-09-25 16:50:30',14),(97,'User Loggin','2017-09-25 17:25:03',14),(98,'User Loggin','2017-09-25 17:53:11',14),(99,'User Loggin','2017-09-25 18:01:27',14),(100,'User Loggin','2017-09-25 18:37:37',14),(101,'User Loggin','2017-09-25 18:54:16',14),(102,'User Loggin','2017-09-25 21:32:21',14),(103,'User Loggin','2017-09-25 21:44:16',14),(104,'User Loggin','2017-09-26 10:05:10',14),(105,'User Loggin','2017-09-26 11:35:52',14),(106,'User Loggin','2017-09-26 11:47:20',14),(107,'User Loggin','2017-09-26 12:45:40',14),(108,'User Loggin','2017-09-26 12:51:01',14),(109,'User Loggin','2017-09-26 13:00:11',14),(110,'User Loggin','2017-09-26 13:02:07',14),(111,'User Loggin','2017-09-26 13:04:15',14),(112,'User Loggin','2017-09-26 13:29:51',14),(113,'User Loggin','2017-09-26 13:45:59',14),(114,'User Loggin','2017-09-26 17:52:09',14),(115,'User Loggin','2017-09-26 18:06:36',14),(116,'User Loggin','2017-09-26 18:21:30',14),(117,'User Loggin','2017-09-26 18:43:56',14),(118,'Rule Block - Current Values : 910000,980130 - New Values: 910000,920350','2017-09-26 18:44:15',14),(119,'User Loggin','2017-09-26 19:56:51',14),(120,'User Loggin','2017-09-26 20:16:56',14),(121,'User Loggin','2017-09-27 11:37:16',14),(122,'User Loggin','2017-09-27 11:52:02',14),(123,'User Loggin','2017-09-27 12:40:48',14),(124,'User Loggin','2017-09-27 19:22:51',14),(125,'User Loggin','2017-09-27 20:22:51',14),(126,'User Loggin','2017-09-27 20:41:55',14),(127,'User Loggin','2017-09-27 20:57:08',14),(128,'User Loggin','2017-09-28 10:47:18',14),(129,'User Loggin','2017-09-28 11:07:50',14),(130,'User Loggin','2017-09-28 11:34:24',14),(131,'User Loggin','2017-09-28 12:08:16',14),(132,'User Loggin','2017-09-28 12:11:49',14),(133,'User Loggin','2017-09-28 12:17:06',14),(134,'User Loggin','2017-09-28 12:46:34',14),(135,'User Loggin','2017-09-28 12:57:13',14),(136,'User Loggin','2017-09-28 13:16:59',14),(137,'User Loggin','2017-09-28 14:00:50',14),(138,'User Loggin','2017-09-28 14:31:36',14),(139,'User Loggin','2017-09-28 19:34:20',14),(140,'User Loggin','2017-09-28 19:55:58',14),(141,'User Loggin','2017-09-28 20:28:01',14),(142,'User Loggin','2017-09-28 20:34:27',14),(143,'User Loggin','2017-09-28 20:41:39',14),(144,'User Loggin','2017-09-28 20:59:17',14),(145,'User Loggin','2017-09-29 18:32:52',14),(146,'User Loggin','2017-09-29 19:13:13',14),(147,'User Loggin','2017-09-29 19:23:46',14),(148,'User Loggin','2017-09-29 19:30:28',14),(149,'User Loggin','2017-09-29 20:08:40',14),(150,'User Loggin','2017-09-29 20:26:09',13),(151,'User Loggin','2017-09-30 08:57:20',14),(152,'User Loggin','2017-09-30 10:12:39',14),(153,'User Loggin','2017-09-30 10:37:20',13),(154,'User Loggin','2017-09-30 10:47:00',13),(155,'User Loggin','2017-09-30 12:05:40',14),(156,'User Loggin','2017-09-30 18:48:54',13),(157,'User Loggin','2017-10-02 20:16:25',13),(158,'User Loggin','2017-10-03 18:19:36',13),(159,'User Loggin','2017-10-03 18:47:16',13),(160,'User Loggin','2017-10-03 19:52:54',13),(161,'User Loggin','2017-10-04 20:06:08',13),(162,'User Loggin','2017-10-05 17:22:48',13),(163,'User Loggin','2017-10-05 17:50:24',13),(164,'User Loggin','2017-10-05 18:41:02',13),(165,'User Loggin','2017-10-05 19:36:51',13),(166,'User Loggin','2017-10-05 22:50:22',13),(167,'User Loggin','2017-10-07 12:27:38',13),(168,'User Loggin','2017-10-07 12:37:59',13),(169,'User Loggin','2017-10-08 16:31:28',13),(170,'User Loggin','2017-10-08 20:14:09',13),(171,'User Loggin','2017-10-08 22:26:14',13),(172,'User Loggin','2017-10-09 20:34:54',13),(173,'User Loggin','2017-10-10 17:24:59',13);
/*!40000 ALTER TABLE `USERS_HISTORY` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS_USER_PROFILES`
--

LOCK TABLES `USERS_USER_PROFILES` WRITE;
/*!40000 ALTER TABLE `USERS_USER_PROFILES` DISABLE KEYS */;
INSERT INTO `USERS_USER_PROFILES` VALUES (20,13,1),(21,13,3),(16,14,1);
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

-- Dump completed on 2017-10-10 18:06:36
