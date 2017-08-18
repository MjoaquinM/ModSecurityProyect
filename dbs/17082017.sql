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
INSERT INTO `CONFIGURATION_FILES` VALUES (1,'MyNewFile','/home/joaquin/Escritorio/file','This is a test file - 1. nada',1),(4,'modsecurity.conf','/etc/modsecurity/modsecurity.conf','This file contain configuration parameters of modsecurity waf.',1),(5,'modsecurity.conf-recommended','/etc/modsecurity/modsecurity.conf-recommended','asdfas',1),(6,'crs-setup.conf','/usr/share/modsecurity-crs/crs-setup.conf','Core Rule Set Configuration file',1),(7,'RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf','/usr/share/modsecurity-crs/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf','The purpose of this file is to hold LOCAL exceptions for your site. The types of rules that would go into this file are one where you want to unconditionally disable rules or modify their actions during startup.',1);
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
INSERT INTO `CONFIGURATION_FILES_ATTRIBUTES` VALUES (38,'SecRuleEngine','On',NULL,2,2,17),(39,'SecRequestBodyAccess','On',NULL,2,2,18),(40,'SecRequestBodyLimit','13107200',NULL,4,1,18),(41,'SecRequestBodyNoFilesLimit','131072',NULL,4,2,18),(42,'SecRequestBodyInMemoryLimit','131072',NULL,4,2,18),(43,'SecRequestBodyLimitAction','Reject',NULL,3,2,18),(44,'SecPcreMatchLimit','1000',NULL,4,2,18),(45,'SecPcreMatchLimitRecursion','1000',NULL,4,2,18),(46,'SecResponseBodyAccess','On',NULL,2,2,19),(47,'SecResponseBodyMimeType','text/plain',NULL,3,2,19),(48,'SecResponseBodyLimit','524288',NULL,4,2,19),(49,'SecResponseBodyLimitAction','ProcessPartial',NULL,3,2,19),(51,'SecTmpDir','/tmp/',NULL,1,2,20),(52,'SecDataDir','/tmp/',NULL,1,2,20),(53,'SecUploadDir','/opt/modsecurity/var/upload/',NULL,1,2,21),(54,'SecUploadKeepFiles','RelevantOnly',NULL,2,2,21),(55,'SecUploadFileMode','0600',NULL,4,2,21),(56,'SecDebugLog','/opt/modsecurity/var/log/debug.log',NULL,1,1,22),(57,'SecDebugLogLevel','3',NULL,4,1,22),(58,'SecAuditEngine','RelevantOnly',NULL,2,2,23),(59,'SecAuditLogRelevantStatus','\"^(?:5|4(?!04))\"',NULL,1,2,23),(60,'SecAuditLogParts','ABIJDEFHZ',NULL,1,2,23),(61,'SecAuditLogType','Serial',NULL,2,2,23),(62,'SecAuditLog','/var/log/apache2/modsec_audit.log',NULL,1,2,23),(63,'SecAuditLogStorageDir','/opt/modsecurity/var/audit/',NULL,1,1,23),(64,'SecArgumentSeparator','&',NULL,1,2,24),(65,'SecCookieFormat','0',NULL,4,2,24),(66,'SecUnicodeMapFile','unicode.mapping 20127',NULL,1,2,24),(67,'SecStatusEngine','On',NULL,2,2,24),(68,'Test attribute 1','Opt 1 - Test attribute 1','Test attribute 1 - Description',5,2,25),(69,'SecRuleRemoveById','910000-910999,942000-942999',NULL,3,2,27);
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
INSERT INTO `CONFIGURATION_FILE_ATTRIBUTE_GROUPS` VALUES (17,'Rule engine initialization','Rule engine initialization - Description',4),(18,'Request body handling','Request body handling - Description',4),(19,'Response body handling','Response body handling - Desc',4),(20,'Filesystem configuration','Filesystem configuration - Description',4),(21,'File uploads handling configuration','File uploads handling configuration - Description',4),(22,'Debug log configuration','Debug log configuration - Description',4),(23,'Audit log configuration','Audit log configuration - Description',4),(24,'Miscellaneous','Miscellaneous - Description',4),(25,'Group test 1','Group test 1 - Description',1),(26,'Mode of Operation','The CRS can run in two modes:\r\n\r\n -- [[ Anomaly Scoring Mode (default) ]] --\r\n In CRS3, anomaly mode is the default and recommended mode, since it gives the\r\n most accurate log information and offers the most flexibility in setting your\r\n blocking policies. It is also called \"collaborative detection mode\".\r\n In this mode, each matching rule increases an \'anomaly score\'.\r\n At the conclusion of the inbound rules, and again at the conclusion of the\r\n outbound rules, the anomaly score is checked, and the blocking evaluation\r\n rules apply a disruptive action, by default returning an error 403.\r\n\r\n -- [[ Self-Contained Mode ]] --\r\n In this mode, rules apply an action instantly. This was the CRS2 default.\r\n It can lower resource usage, at the cost of less flexibility in blocking policy\r\n and less informative audit logs (only the first detected threat is logged).\r\n Rules inherit the disruptive action that you specify (i.e. deny, drop, etc).\r\n The first rule that matches will execute this action. In most cases this will\r\n cause evaluation to stop after the first rule has matched, similar to how many\r\n IDSs function.\r\n\r\n -- [[ Alert Logging Control ]] --\r\n In the mode configuration, you must also adjust the desired logging options.\r\n There are three common options for dealing with logging. By default CRS enables\r\n logging to the webserver error log (or Event viewer) plus detailed logging to\r\n the ModSecurity audit log (configured under SecAuditLog in modsecurity.conf).\r\n\r\n - To log to both error log and ModSecurity audit log file, use: \"log,auditlog\"\r\n - To log *only* to the ModSecurity audit log file, use: \"nolog,auditlog\"\r\n - To log *only* to the error log file, use: \"log,noauditlog\"',6),(27,'Exclusion Rules','Please see the file REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf.example for a description of the rule exclusions mechanism and the correct  use of this file',7);
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
  `group_option` int(11) DEFAULT NULL,
  `configuration_files_attributes_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuration_file_attribute_options_unq` (`name`,`configuration_files_attributes_id`),
  KEY `configuration_file_attribute_options_fk_cfa` (`configuration_files_attributes_id`),
  CONSTRAINT `configuration_file_attribute_options_fk_cfa` FOREIGN KEY (`configuration_files_attributes_id`) REFERENCES `CONFIGURATION_FILES_ATTRIBUTES` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS`
--

LOCK TABLES `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` WRITE;
/*!40000 ALTER TABLE `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` DISABLE KEYS */;
INSERT INTO `CONFIGURATION_FILE_ATTRIBUTE_OPTIONS` VALUES (1,'On',NULL,NULL,38),(2,'Off',NULL,NULL,38),(3,'DetectionOnly',NULL,NULL,38),(6,'Reject',NULL,NULL,43),(7,'ProcessPartial',NULL,NULL,43),(8,'On',NULL,NULL,46),(9,'Off',NULL,NULL,46),(10,'text/plain',NULL,NULL,47),(11,'text/html',NULL,NULL,47),(12,'text/xml',NULL,NULL,47),(15,'ProcessPartial',NULL,NULL,49),(16,'Rject',NULL,NULL,49),(17,'RelevantOnly',NULL,NULL,54),(18,'RelevantOnly',NULL,NULL,58),(19,'Serial',NULL,NULL,61),(20,'On',NULL,NULL,67),(21,'Off',NULL,NULL,67),(45,'On',NULL,NULL,39),(46,'Off',NULL,NULL,39),(53,'942100',NULL,NULL,69),(54,'941110',NULL,NULL,69),(55,'941160',NULL,NULL,69);
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
  `dateEvent` varchar(45) NOT NULL,
  `transactionId` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `clientIp` tinytext NOT NULL,
  `clientPort` tinytext NOT NULL,
  `serverIp` tinytext NOT NULL,
  `serverPort` tinytext NOT NULL,
  `method` tinytext,
  `destinationPage` mediumtext,
  `protocol` tinytext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactionId_UNIQUE` (`transactionId`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Event`
--

LOCK TABLES `Event` WRITE;
/*!40000 ALTER TABLE `Event` DISABLE KEYS */;
INSERT INTO `Event` VALUES (7,'--d3954674-A--\n[25/Jun/2017:13:38:55 --0300] WU-nH38AAQEAAAUAGLYAAAAE 192.168.1.100 48415 192.168.1.108 80\n','--d3954674-B--\nPOST /login.php HTTP/1.1\nHost: 192.168.1.108\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://192.168.1.108\nUpgrade-Insecure-Requests: 1\nUser-Agent: Mozilla/5.0 (Linux; Android 4.2.2; ME173X Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.92 Safari/537.36\nContent-Type: application/x-www-form-urlencoded\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://192.168.1.108/login.php\nAccept-Encoding: gzip, deflate\nAccept-Language: es-US,es-419;q=0.8,es;q=0.6\n','--d3954674-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--d3954674-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.10 (Debian) Server at 192.168.1.108 Port 80</address>\n</body></html>\n','--d3954674-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 297\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--d3954674-H--\nMessage: Warning. Pattern match \"^[\\\\d.:]+$\" at REQUEST_HEADERS:Host. [file \"/usr/share/modsecurity-crs/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf\"] [line \"793\"] [id \"920350\"] [rev \"2\"] [msg \"Host header is a numeric IP address\"] [data \"192.168.1.108\"] [severity \"WARNING\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"9\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-protocol\"] [tag \"OWASP_CRS/PROTOCOL_VIOLATION/IP_HOST\"] [tag \"WASCTC/WASC-21\"] [tag \"OWASP_TOP_10/A7\"] [tag \"PCI/6.5.10\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 13)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 13 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1498408735690258 4706 (- - -)\nStopwatch2: 1498408735690258 4706; combined=3765, p1=523, p2=3020, p3=0, p4=0, p5=222, sr=20, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.8.0 (http://www.modsecurity.org/); OWASP_CRS/3.0.0.\nServer: Apache/2.4.10 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--d3954674-Z--\n','25/Jun/2017:13:38:55 --0300','WU-nH38AAQEAAAUAGLYAAAAE','192.168.1.100','48415','192.168.1.108','80\n','HTTP/1.1',NULL,NULL),(8,'--172ce90e-A--\n[29/Jul/2017:21:31:30 --0300] WX0o4n8AAQEAABjPHcQAAAAA ::1 35214 ::1 80\n','--172ce90e-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36\nContent-Type: application/x-www-form-urlencoded\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--172ce90e-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--172ce90e-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.10 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--172ce90e-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--172ce90e-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0o4n8AAQEAABjPHcQAAAAA\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0o4n8AAQEAABjPHcQAAAAA\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0o4n8AAQEAABjPHcQAAAAA\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0o4n8AAQEAABjPHcQAAAAA\"]\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1501374690192239 5388 (- - -)\nStopwatch2: 1501374690192239 5388; combined=3897, p1=753, p2=2980, p3=0, p4=0, p5=164, sr=37, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.2 (http://www.modsecurity.org/); OWASP_CRS/3.0.2.\nServer: Apache/2.4.10 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--172ce90e-Z--\n','29/Jul/2017:21:31:30 --0300','WX0o4n8AAQEAABjPHcQAAAAA','::1','35214','::1','80\n','HTTP/1.1',NULL,NULL),(9,'--172ce90e-A--\n[29/Jul/2017:21:33:01 --0300] WX0pPX8AAQEAABjRH8YAAAAC ::1 35249 ::1 80\n','--172ce90e-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36\nContent-Type: application/x-www-form-urlencoded\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--172ce90e-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--172ce90e-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.10 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--172ce90e-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--172ce90e-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0pPX8AAQEAABjRH8YAAAAC\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0pPX8AAQEAABjRH8YAAAAC\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0pPX8AAQEAABjRH8YAAAAC\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0pPX8AAQEAABjRH8YAAAAC\"]\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1501374781197514 5947 (- - -)\nStopwatch2: 1501374781197514 5947; combined=4487, p1=706, p2=3614, p3=0, p4=0, p5=167, sr=37, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.2 (http://www.modsecurity.org/); OWASP_CRS/3.0.2.\nServer: Apache/2.4.10 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--172ce90e-Z--\n','29/Jul/2017:21:33:01 --0300','WX0pPX8AAQEAABjRH8YAAAAC','::1','35249','::1','80\n','HTTP/1.1',NULL,NULL),(10,'--2d0e717d-A--\n[29/Jul/2017:21:33:25 --0300] WX0pVX8AAQEAABkXRUUAAAAB ::1 35255 ::1 80\n','--2d0e717d-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36\nContent-Type: application/x-www-form-urlencoded\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--2d0e717d-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--2d0e717d-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.10 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--2d0e717d-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--2d0e717d-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0pVX8AAQEAABkXRUUAAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0pVX8AAQEAABkXRUUAAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0pVX8AAQEAABkXRUUAAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX0pVX8AAQEAABkXRUUAAAAB\"]\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1501374805611840 4516 (- - -)\nStopwatch2: 1501374805611840 4516; combined=3433, p1=520, p2=2334, p3=0, p4=0, p5=369, sr=18, sw=1, l=0, gc=209\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.2 (http://www.modsecurity.org/); OWASP_CRS/3.0.2.\nServer: Apache/2.4.10 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--2d0e717d-Z--\n','29/Jul/2017:21:33:25 --0300','WX0pVX8AAQEAABkXRUUAAAAB','::1','35255','::1','80\n','HTTP/1.1',NULL,NULL),(11,'--b1ae2544-A--\n[30/Jul/2017:19:27:37 --0300] WX5dWX8AAQEAAAkXHH4AAAAB ::1 58649 ::1 80\n','--b1ae2544-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36\nContent-Type: application/x-www-form-urlencoded\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--b1ae2544-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--b1ae2544-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.10 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--b1ae2544-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=99\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--b1ae2544-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dWX8AAQEAAAkXHH4AAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dWX8AAQEAAAkXHH4AAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dWX8AAQEAAAkXHH4AAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dWX8AAQEAAAkXHH4AAAAB\"]\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1501453657642722 5813 (- - -)\nStopwatch2: 1501453657642722 5813; combined=4685, p1=786, p2=3646, p3=0, p4=0, p5=253, sr=26, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.2 (http://www.modsecurity.org/); OWASP_CRS/3.0.2.\nServer: Apache/2.4.10 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--b1ae2544-Z--\n','30/Jul/2017:19:27:37 --0300','WX5dWX8AAQEAAAkXHH4AAAAB','::1','58649','::1','80\n','HTTP/1.1',NULL,NULL),(12,'--ea98617c-A--\n[30/Jul/2017:19:27:34 --0300] WX5dVn8AAQEAAAkXHH0AAAAB ::1 58649 ::1 80\n','--ea98617c-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36\nContent-Type: application/x-www-form-urlencoded\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--ea98617c-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--ea98617c-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.10 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--ea98617c-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--ea98617c-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dVn8AAQEAAAkXHH0AAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dVn8AAQEAAAkXHH0AAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dVn8AAQEAAAkXHH0AAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dVn8AAQEAAAkXHH0AAAAB\"]\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1501453654029767 2369 (- - -)\nStopwatch2: 1501453654029767 2369; combined=1642, p1=338, p2=1237, p3=0, p4=0, p5=67, sr=16, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.2 (http://www.modsecurity.org/); OWASP_CRS/3.0.2.\nServer: Apache/2.4.10 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--ea98617c-Z--\n','30/Jul/2017:19:27:34 --0300','WX5dVn8AAQEAAAkXHH0AAAAB','::1','58649','::1','80\n','HTTP/1.1',NULL,NULL),(13,'--ea98617c-A--\n[30/Jul/2017:19:28:31 --0300] WX5dj38AAQEAAAkZ4goAAAAD ::1 58701 ::1 80\n','--ea98617c-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36\nContent-Type: application/x-www-form-urlencoded\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--ea98617c-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--ea98617c-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.10 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--ea98617c-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=97\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--ea98617c-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dj38AAQEAAAkZ4goAAAAD\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dj38AAQEAAAkZ4goAAAAD\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dj38AAQEAAAkZ4goAAAAD\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WX5dj38AAQEAAAkZ4goAAAAD\"]\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1501453711948993 4123 (- - -)\nStopwatch2: 1501453711948993 4123; combined=3283, p1=529, p2=2624, p3=0, p4=0, p5=129, sr=16, sw=1, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.2 (http://www.modsecurity.org/); OWASP_CRS/3.0.2.\nServer: Apache/2.4.10 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--ea98617c-Z--\n','30/Jul/2017:19:28:31 --0300','WX5dj38AAQEAAAkZ4goAAAAD','::1','58701','::1','80\n','HTTP/1.1',NULL,NULL),(14,'--1718f43f-A--\n[07/Aug/2017:20:41:41 --0300] WYj6tX8AAQEAAAUHJvIAAAAB ::1 56483 ::1 80\n','--1718f43f-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36\nContent-Type: application/x-www-form-urlencoded\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--1718f43f-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--1718f43f-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.10 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--1718f43f-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=100\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--1718f43f-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WYj6tX8AAQEAAAUHJvIAAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WYj6tX8AAQEAAAUHJvIAAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WYj6tX8AAQEAAAUHJvIAAAAB\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WYj6tX8AAQEAAAUHJvIAAAAB\"]\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1502149301606710 2768 (- - -)\nStopwatch2: 1502149301606710 2768; combined=1888, p1=379, p2=1414, p3=0, p4=0, p5=95, sr=23, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.2 (http://www.modsecurity.org/); OWASP_CRS/3.0.2.\nServer: Apache/2.4.10 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--1718f43f-Z--\n','07/Aug/2017:20:41:41 --0300','WYj6tX8AAQEAAAUHJvIAAAAB','::1','56483','::1','80\n','HTTP/1.1',NULL,NULL),(15,'--4c356b6f-A--\n[07/Aug/2017:20:42:02 --0300] WYj6yn8AAQEAAAUIyhQAAAAC ::1 56504 ::1 80\n','--4c356b6f-B--\nPOST /login.php HTTP/1.1\nHost: localhost\nConnection: keep-alive\nContent-Length: 46\nCache-Control: max-age=0\nOrigin: http://localhost\nUpgrade-Insecure-Requests: 1\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36\nContent-Type: application/x-www-form-urlencoded\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\nReferer: http://localhost/login.php\nAccept-Encoding: gzip, deflate, br\nAccept-Language: en-US,en;q=0.8,es;q=0.6\n','--4c356b6f-C--\nusername=%27+or+true+--+&password=&login=Login\n',NULL,'--4c356b6f-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>403 Forbidden</title>\n</head><body>\n<h1>Forbidden</h1>\n<p>You don\'t have permission to access /login.php\non this server.<br />\n</p>\n<hr>\n<address>Apache/2.4.10 (Debian) Server at localhost Port 80</address>\n</body></html>\n','--4c356b6f-F--\nHTTP/1.1 403 Forbidden\nContent-Length: 293\nKeep-Alive: timeout=5, max=98\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--4c356b6f-H--\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"]\nMessage: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"]\nMessage: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1c\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1c found within ARGS:username: \' or true -- \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WYj6yn8AAQEAAAUIyhQAAAAC\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. detected SQLi using libinjection with fingerprint \'s&1\' [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf\"] [line \"68\"] [id \"942100\"] [rev \"1\"] [msg \"SQL Injection Attack Detected via libinjection\"] [data \"Matched Data: s&1 found within ARGS:username: \' or true \"] [severity \"CRITICAL\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"1\"] [accuracy \"8\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-sqli\"] [tag \"OWASP_CRS/WEB_ATTACK/SQL_INJECTION\"] [tag \"WASCTC/WASC-19\"] [tag \"OWASP_TOP_10/A1\"] [tag \"OWASP_AppSensor/CIE1\"] [tag \"PCI/6.5.2\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WYj6yn8AAQEAAAUIyhQAAAAC\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Access denied with code 403 (phase 2). Operator GE matched 5 at TX:anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf\"] [line \"57\"] [id \"949110\"] [msg \"Inbound Anomaly Score Exceeded (Total Score: 10)\"] [severity \"CRITICAL\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-generic\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WYj6yn8AAQEAAAUIyhQAAAAC\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client ::1] ModSecurity: Warning. Operator GE matched 5 at TX:inbound_anomaly_score. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf\"] [line \"73\"] [id \"980130\"] [msg \"Inbound Anomaly Score Exceeded (Total Inbound Score: 10 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection\"] [tag \"event-correlation\"] [hostname \"localhost\"] [uri \"/login.php\"] [unique_id \"WYj6yn8AAQEAAAUIyhQAAAAC\"]\nAction: Intercepted (phase 2)\nApache-Handler: application/x-httpd-php\nStopwatch: 1502149322607722 2305 (- - -)\nStopwatch2: 1502149322607722 2305; combined=1748, p1=249, p2=1371, p3=0, p4=0, p5=128, sr=10, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.2 (http://www.modsecurity.org/); OWASP_CRS/3.0.2.\nServer: Apache/2.4.10 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--4c356b6f-Z--\n','07/Aug/2017:20:42:02 --0300','WYj6yn8AAQEAAAUIyhQAAAAC','::1','56504','::1','80\n','HTTP/1.1',NULL,NULL),(18,'--4c356b6f-A--\n[07/Aug/2017:20:46:02 --0300] WYj7un8AAQEAAAUGmeMAAAAA 192.168.0.12 43613 192.168.0.11 80\n','--4c356b6f-B--\nGET /favicon.ico HTTP/1.1\nHost: 192.168.0.11\nConnection: keep-alive\nUser-Agent: Mozilla/5.0 (Linux; Android 5.1.1; SM-J500M Build/LMY48B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36\nAccept: image/webp,image/apng,image/*,*/*;q=0.8\nReferer: http://192.168.0.11/login.php\nAccept-Encoding: gzip, deflate\nAccept-Language: es-US,es;q=0.8,es-419;q=0.6,en;q=0.4\n',NULL,NULL,'--4c356b6f-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>404 Not Found</title>\n</head><body>\n<h1>Not Found</h1>\n<p>The requested URL /favicon.ico was not found on this server.</p>\n<hr>\n<address>Apache/2.4.10 (Debian) Server at 192.168.0.11 Port 80</address>\n</body></html>\n','--4c356b6f-F--\nHTTP/1.1 404 Not Found\nContent-Length: 287\nKeep-Alive: timeout=5, max=99\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--4c356b6f-H--\nMessage: Warning. Pattern match \"^[\\\\d.:]+$\" at REQUEST_HEADERS:Host. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf\"] [line \"810\"] [id \"920350\"] [rev \"2\"] [msg \"Host header is a numeric IP address\"] [data \"192.168.0.11\"] [severity \"WARNING\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"9\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-protocol\"] [tag \"OWASP_CRS/PROTOCOL_VIOLATION/IP_HOST\"] [tag \"WASCTC/WASC-21\"] [tag \"OWASP_TOP_10/A7\"] [tag \"PCI/6.5.10\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client 192.168.0.12] ModSecurity: Warning. Pattern match \"^[\\\\\\\\\\\\\\\\d.:]+$\" at REQUEST_HEADERS:Host. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf\"] [line \"810\"] [id \"920350\"] [rev \"2\"] [msg \"Host header is a numeric IP address\"] [data \"192.168.0.11\"] [severity \"WARNING\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"9\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-protocol\"] [tag \"OWASP_CRS/PROTOCOL_VIOLATION/IP_HOST\"] [tag \"WASCTC/WASC-21\"] [tag \"OWASP_TOP_10/A7\"] [tag \"PCI/6.5.10\"] [hostname \"192.168.0.11\"] [uri \"/favicon.ico\"] [unique_id \"WYj7un8AAQEAAAUGmeMAAAAA\"]\nStopwatch: 1502149562407002 3195 (- - -)\nStopwatch2: 1502149562407002 3195; combined=2340, p1=470, p2=1396, p3=68, p4=306, p5=99, sr=19, sw=1, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.2 (http://www.modsecurity.org/); OWASP_CRS/3.0.2.\nServer: Apache/2.4.10 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--4c356b6f-Z--\n','07/Aug/2017:20:46:02 --0300','WYj7un8AAQEAAAUGmeMAAAAA','192.168.0.12','43613','192.168.0.11','80\n','HTTP/1.1',NULL,NULL),(19,'--4c356b6f-A--\n[07/Aug/2017:20:47:09 --0300] WYj7-X8AAQEAABw1zkwAAAAI 192.168.0.20 57577 192.168.0.11 80\n','--4c356b6f-B--\nGET /favicon.ico HTTP/1.1\nHost: 192.168.0.11\nConnection: keep-alive\nUser-Agent: Mozilla/5.0 (Linux; Android 4.2.2; ME173X Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Safari/537.36\nAccept: image/webp,image/apng,image/*,*/*;q=0.8\nReferer: http://192.168.0.11/login.php\nAccept-Encoding: gzip, deflate\nAccept-Language: es-US,es-419;q=0.8,es;q=0.6\n',NULL,NULL,'--4c356b6f-E--\n<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">\n<html><head>\n<title>404 Not Found</title>\n</head><body>\n<h1>Not Found</h1>\n<p>The requested URL /favicon.ico was not found on this server.</p>\n<hr>\n<address>Apache/2.4.10 (Debian) Server at 192.168.0.11 Port 80</address>\n</body></html>\n','--4c356b6f-F--\nHTTP/1.1 404 Not Found\nContent-Length: 287\nKeep-Alive: timeout=5, max=99\nConnection: Keep-Alive\nContent-Type: text/html; charset=iso-8859-1\n',NULL,'--4c356b6f-H--\nMessage: Warning. Pattern match \"^[\\\\d.:]+$\" at REQUEST_HEADERS:Host. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf\"] [line \"810\"] [id \"920350\"] [rev \"2\"] [msg \"Host header is a numeric IP address\"] [data \"192.168.0.11\"] [severity \"WARNING\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"9\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-protocol\"] [tag \"OWASP_CRS/PROTOCOL_VIOLATION/IP_HOST\"] [tag \"WASCTC/WASC-21\"] [tag \"OWASP_TOP_10/A7\"] [tag \"PCI/6.5.10\"]\nApache-Error: [file \"apache2_util.c\"] [line 271] [level 3] [client 192.168.0.20] ModSecurity: Warning. Pattern match \"^[\\\\\\\\\\\\\\\\d.:]+$\" at REQUEST_HEADERS:Host. [file \"/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf\"] [line \"810\"] [id \"920350\"] [rev \"2\"] [msg \"Host header is a numeric IP address\"] [data \"192.168.0.11\"] [severity \"WARNING\"] [ver \"OWASP_CRS/3.0.0\"] [maturity \"9\"] [accuracy \"9\"] [tag \"application-multi\"] [tag \"language-multi\"] [tag \"platform-multi\"] [tag \"attack-protocol\"] [tag \"OWASP_CRS/PROTOCOL_VIOLATION/IP_HOST\"] [tag \"WASCTC/WASC-21\"] [tag \"OWASP_TOP_10/A7\"] [tag \"PCI/6.5.10\"] [hostname \"192.168.0.11\"] [uri \"/favicon.ico\"] [unique_id \"WYj7-X8AAQEAABw1zkwAAAAI\"]\nStopwatch: 1502149629637531 3068 (- - -)\nStopwatch2: 1502149629637531 3068; combined=2167, p1=517, p2=1200, p3=65, p4=317, p5=68, sr=22, sw=0, l=0, gc=0\nResponse-Body-Transformed: Dechunked\nProducer: ModSecurity for Apache/2.9.2 (http://www.modsecurity.org/); OWASP_CRS/3.0.2.\nServer: Apache/2.4.10 (Debian)\nEngine-Mode: \"ENABLED\"\n',NULL,NULL,NULL,'--4c356b6f-Z--\n','07/Aug/2017:20:47:09 --0300','WYj7-X8AAQEAABw1zkwAAAAI','192.168.0.20','57577','192.168.0.11','80\n','HTTP/1.1',NULL,NULL);
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
  `transactionId` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ruleId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_EventRule_Event1_idx` (`transactionId`),
  KEY `fk_EventRule_Rule1_idx` (`ruleId`),
  CONSTRAINT `fk_EventRule_Event1` FOREIGN KEY (`transactionId`) REFERENCES `Event` (`transactionId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EventRule_Rule1` FOREIGN KEY (`ruleId`) REFERENCES `Rule` (`ruleId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventRule`
--

LOCK TABLES `EventRule` WRITE;
/*!40000 ALTER TABLE `EventRule` DISABLE KEYS */;
INSERT INTO `EventRule` VALUES (64,'WU-nH38AAQEAAAUAGLYAAAAE','920350'),(65,'WU-nH38AAQEAAAUAGLYAAAAE','942100'),(66,'WU-nH38AAQEAAAUAGLYAAAAE','942100'),(67,'WU-nH38AAQEAAAUAGLYAAAAE','949110'),(68,'WU-nH38AAQEAAAUAGLYAAAAE','980130'),(69,'WX0o4n8AAQEAABjPHcQAAAAA','942100'),(70,'WX0o4n8AAQEAABjPHcQAAAAA','942100'),(71,'WX0o4n8AAQEAABjPHcQAAAAA','949110'),(72,'WX0o4n8AAQEAABjPHcQAAAAA','980130'),(73,'WX0pVX8AAQEAABkXRUUAAAAB','942100'),(74,'WX0pPX8AAQEAABjRH8YAAAAC','942100'),(75,'WX0pVX8AAQEAABkXRUUAAAAB','942100'),(76,'WX0pPX8AAQEAABjRH8YAAAAC','942100'),(77,'WX0pVX8AAQEAABkXRUUAAAAB','949110'),(78,'WX0pPX8AAQEAABjRH8YAAAAC','949110'),(79,'WX0pPX8AAQEAABjRH8YAAAAC','980130'),(80,'WX0pVX8AAQEAABkXRUUAAAAB','980130'),(81,'WX5dWX8AAQEAAAkXHH4AAAAB','942100'),(82,'WX5dVn8AAQEAAAkXHH0AAAAB','942100'),(83,'WX5dWX8AAQEAAAkXHH4AAAAB','942100'),(84,'WX5dVn8AAQEAAAkXHH0AAAAB','942100'),(85,'WX5dVn8AAQEAAAkXHH0AAAAB','949110'),(86,'WX5dWX8AAQEAAAkXHH4AAAAB','949110'),(87,'WX5dVn8AAQEAAAkXHH0AAAAB','980130'),(88,'WX5dWX8AAQEAAAkXHH4AAAAB','980130'),(89,'WX5dj38AAQEAAAkZ4goAAAAD','942100'),(90,'WX5dj38AAQEAAAkZ4goAAAAD','942100'),(91,'WX5dj38AAQEAAAkZ4goAAAAD','949110'),(92,'WX5dj38AAQEAAAkZ4goAAAAD','980130'),(93,'WYj6tX8AAQEAAAUHJvIAAAAB','942100'),(94,'WYj6tX8AAQEAAAUHJvIAAAAB','942100'),(95,'WYj6tX8AAQEAAAUHJvIAAAAB','949110'),(96,'WYj6tX8AAQEAAAUHJvIAAAAB','980130'),(97,'WYj6yn8AAQEAAAUIyhQAAAAC','942100'),(98,'WYj6yn8AAQEAAAUIyhQAAAAC','942100'),(99,'WYj6yn8AAQEAAAUIyhQAAAAC','949110'),(100,'WYj6yn8AAQEAAAUIyhQAAAAC','980130'),(101,'WYj7un8AAQEAAAUGmeMAAAAA','920350'),(102,'WYj7-X8AAQEAABw1zkwAAAAI','920350');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File`
--

LOCK TABLES `File` WRITE;
/*!40000 ALTER TABLE `File` DISABLE KEYS */;
INSERT INTO `File` VALUES (9,'REQUEST-920-PROTOCOL-ENFORCEMENT.conf','/usr/share/modsecurity-crs/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf'),(10,'REQUEST-942-APPLICATION-ATTACK-SQLI.conf','/usr/share/modsecurity-crs/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf'),(11,'REQUEST-949-BLOCKING-EVALUATION.conf','/usr/share/modsecurity-crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf'),(12,'RESPONSE-980-CORRELATION.conf','/usr/share/modsecurity-crs/rules/RESPONSE-980-CORRELATION.conf'),(13,'REQUEST-942-APPLICATION-ATTACK-SQLI.conf','/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf'),(14,'REQUEST-949-BLOCKING-EVALUATION.conf','/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-949-BLOCKING-EVALUATION.conf'),(15,'RESPONSE-980-CORRELATION.conf','/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/RESPONSE-980-CORRELATION.conf'),(16,'REQUEST-920-PROTOCOL-ENFORCEMENT.conf','/etc/modsecurity-2.9.2/owasp-modsecurity-crs-3.0.2/rules/REQUEST-920-PROTOCOL-ENFORCEMENT.conf');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rule`
--

LOCK TABLES `Rule` WRITE;
/*!40000 ALTER TABLE `Rule` DISABLE KEYS */;
INSERT INTO `Rule` VALUES (10,'920350','Host header is a numeric IP address','WARNING',9),(11,'942100','SQL Injection Attack Detected via libinjection','CRITICAL',10),(12,'949110','Inbound Anomaly Score Exceeded (Total Score: 13)','CRITICAL',11),(13,'980130','Inbound Anomaly Score Exceeded (Total Inbound Score: 13 - SQLI=10,XSS=0,RFI=0,LFI=0,RCE=0,PHPI=0,HTTP=0,SESS=0): SQL Injection Attack Detected via libinjection','',12);
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

-- Dump completed on 2017-08-17 22:57:20
