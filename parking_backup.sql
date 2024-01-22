-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: parking
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `parking`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `parking` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `parking`;

--
-- Table structure for table `GlobalConfiguration`
--

DROP TABLE IF EXISTS `GlobalConfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GlobalConfiguration` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(36) NOT NULL,
  `value` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GlobalConfiguration`
--

LOCK TABLES `GlobalConfiguration` WRITE;
/*!40000 ALTER TABLE `GlobalConfiguration` DISABLE KEYS */;
INSERT INTO `GlobalConfiguration` VALUES (1,'email_host','http://10.1.10.154:8000/');
/*!40000 ALTER TABLE `GlobalConfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ParkingPlaza`
--

DROP TABLE IF EXISTS `ParkingPlaza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ParkingPlaza` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(512) DEFAULT NULL,
  `area` double DEFAULT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `register_date` date NOT NULL,
  `register_time` time(6) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `register_by_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Parking_Plaza_register_by_id_54b74048_fk_Users_id` (`register_by_id`),
  CONSTRAINT `Parking_Plaza_register_by_id_54b74048_fk_Users_id` FOREIGN KEY (`register_by_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ParkingPlaza`
--

LOCK TABLES `ParkingPlaza` WRITE;
/*!40000 ALTER TABLE `ParkingPlaza` DISABLE KEYS */;
INSERT INTO `ParkingPlaza` VALUES (1,'Sadar plaza 2','Sadar,Karachi',NULL,5462.5,54.65,'2024-01-18','08:18:35.239675',0,1),(2,'testig plaza','clifton',NULL,0,0,'2024-01-19','05:06:23.005673',0,1),(3,'testing','113 A, Block A Sindhi Muslim CHS (SMCHS), Karachi, Karachi City, Sindh, Pakistan',NULL,24.8602899,67.0558485,'2024-01-19','11:36:28.725762',0,1),(4,'plaza1','113 A, Block A Sindhi Muslim CHS (SMCHS), Karachi, Karachi City, Sindh, Pakistan',NULL,24.8602899,67.0558485,'2024-01-19','11:39:36.685288',0,1),(5,'plaza2','113 A, Block A Sindhi Muslim CHS (SMCHS), Karachi, Karachi City, Sindh, Pakistan',NULL,24.8603272,67.0558364,'2024-01-19','11:40:40.161672',0,1),(6,'plaza3','113 A, Block A Sindhi Muslim CHS (SMCHS), Karachi, Karachi City, Sindh, Pakistan',NULL,24.8602976,67.0558425,'2024-01-19','11:42:39.568332',0,1),(7,'ajcl plaza','113 A, Block A Sindhi Muslim CHS (SMCHS), Karachi, Karachi City, Sindh, Pakistan',NULL,24.8603434,67.0558658,'2024-01-19','12:12:05.528828',0,1);
/*!40000 ALTER TABLE `ParkingPlaza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ParkingPlazaLog`
--

DROP TABLE IF EXISTS `ParkingPlazaLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ParkingPlazaLog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `area` double NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `register_date` date NOT NULL,
  `register_time` time(6) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `log_timestamp` datetime(6) NOT NULL,
  `register_by_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Parking_Plaza_Log_register_by_id_d09897b5_fk_Users_id` (`register_by_id`),
  CONSTRAINT `Parking_Plaza_Log_register_by_id_d09897b5_fk_Users_id` FOREIGN KEY (`register_by_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ParkingPlazaLog`
--

LOCK TABLES `ParkingPlazaLog` WRITE;
/*!40000 ALTER TABLE `ParkingPlazaLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `ParkingPlazaLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ParkingVehicle`
--

DROP TABLE IF EXISTS `ParkingVehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ParkingVehicle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `registration_number` varchar(256) NOT NULL,
  `vehicle_type` varchar(155) NOT NULL,
  `vehicle_model` varchar(155) NOT NULL,
  `check_in_date` date NOT NULL,
  `check_in_time` time(6) NOT NULL,
  `check_out_date` date DEFAULT NULL,
  `check_out_time` time(6) DEFAULT NULL,
  `check_in_by_id` bigint NOT NULL,
  `check_in_plaza_id` bigint NOT NULL,
  `check_out_by_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Parking_Vehicle_check_in_by_id_0d4913ee_fk_Users_id` (`check_in_by_id`),
  KEY `Parking_Vehicle_check_out_by_id_9cd4170e_fk_Users_id` (`check_out_by_id`),
  KEY `Parking_Vehicle_check_in_plaza_id_7ccc8f19_fk_Parking_Plaza_id` (`check_in_plaza_id`),
  CONSTRAINT `Parking_Vehicle_check_in_by_id_0d4913ee_fk_Users_id` FOREIGN KEY (`check_in_by_id`) REFERENCES `Users` (`id`),
  CONSTRAINT `Parking_Vehicle_check_in_plaza_id_7ccc8f19_fk_Parking_Plaza_id` FOREIGN KEY (`check_in_plaza_id`) REFERENCES `ParkingPlaza` (`id`),
  CONSTRAINT `Parking_Vehicle_check_out_by_id_9cd4170e_fk_Users_id` FOREIGN KEY (`check_out_by_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ParkingVehicle`
--

LOCK TABLES `ParkingVehicle` WRITE;
/*!40000 ALTER TABLE `ParkingVehicle` DISABLE KEYS */;
INSERT INTO `ParkingVehicle` VALUES (8,'kpgn82','4-wheel','Car','2024-01-19','12:10:43.415137','2024-01-19','12:10:53.033893',28,1,28);
/*!40000 ALTER TABLE `ParkingVehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `access_ids` longtext NOT NULL,
  `created_on` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` VALUES (1,'user','','2024-01-15 12:35:48.322000',1),(2,'admin','','2024-01-15 12:35:52.665000',1);
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserAllocation`
--

DROP TABLE IF EXISTS `UserAllocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserAllocation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assign_date` date NOT NULL,
  `assign_time` time(6) NOT NULL,
  `upload_date` date NOT NULL,
  `upload_time` time(6) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `assigned_by_id` bigint NOT NULL,
  `parking_plaza_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `User_Allocation_assigned_by_id_ce390a27_fk_Users_id` (`assigned_by_id`),
  KEY `User_Allocation_user_id_3127dd6e_fk_Users_id` (`user_id`),
  KEY `User_Allocation_parking_plaza_id_c39bfabf_fk_Parking_Plaza_id` (`parking_plaza_id`),
  CONSTRAINT `User_Allocation_assigned_by_id_ce390a27_fk_Users_id` FOREIGN KEY (`assigned_by_id`) REFERENCES `Users` (`id`),
  CONSTRAINT `User_Allocation_parking_plaza_id_c39bfabf_fk_Parking_Plaza_id` FOREIGN KEY (`parking_plaza_id`) REFERENCES `ParkingPlaza` (`id`),
  CONSTRAINT `User_Allocation_user_id_3127dd6e_fk_Users_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserAllocation`
--

LOCK TABLES `UserAllocation` WRITE;
/*!40000 ALTER TABLE `UserAllocation` DISABLE KEYS */;
INSERT INTO `UserAllocation` VALUES (7,'2024-01-19','12:09:26.777580','2024-01-19','12:09:26.777621',0,1,1,28),(8,'2024-01-19','13:34:26.013679','2024-01-19','13:34:26.013719',0,1,1,29);
/*!40000 ALTER TABLE `UserAllocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserAttendance`
--

DROP TABLE IF EXISTS `UserAttendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserAttendance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `status` varchar(20) NOT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `address` varchar(155) DEFAULT NULL,
  `updated_by_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `User_Attendance_updated_by_id_2bcb6af2_fk_Users_id` (`updated_by_id`),
  KEY `User_Attendance_user_id_4b9da845_fk_Users_id` (`user_id`),
  CONSTRAINT `User_Attendance_updated_by_id_2bcb6af2_fk_Users_id` FOREIGN KEY (`updated_by_id`) REFERENCES `Users` (`id`),
  CONSTRAINT `User_Attendance_user_id_4b9da845_fk_Users_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserAttendance`
--

LOCK TABLES `UserAttendance` WRITE;
/*!40000 ALTER TABLE `UserAttendance` DISABLE KEYS */;
INSERT INTO `UserAttendance` VALUES (1,'2024-01-19','on_leave',NULL,NULL,NULL,1,29),(2,'2024-01-19','absent',NULL,NULL,NULL,1,28);
/*!40000 ALTER TABLE `UserAttendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_Access`
--

DROP TABLE IF EXISTS `User_Access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Access` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Access`
--

LOCK TABLES `User_Access` WRITE;
/*!40000 ALTER TABLE `User_Access` DISABLE KEYS */;
/*!40000 ALTER TABLE `User_Access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(254) NOT NULL,
  `cnic` varchar(17) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `gender` varchar(100) DEFAULT NULL,
  `hired_date` date NOT NULL,
  `hired_time` time(6) NOT NULL,
  `auth_key` varchar(512) DEFAULT NULL,
  `profile_image` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `register_by_id` bigint DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `register_date` date NOT NULL,
  `register_time` time(6) NOT NULL,
  `first_name` varchar(125) DEFAULT NULL,
  `last_name` varchar(125) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_register_by_id_858154ce_fk_users_id` (`register_by_id`),
  KEY `users_role_id_1900a745_fk_role_id` (`role_id`),
  CONSTRAINT `users_register_by_id_858154ce_fk_users_id` FOREIGN KEY (`register_by_id`) REFERENCES `Users` (`id`),
  CONSTRAINT `users_role_id_1900a745_fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `Role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'pbkdf2_sha256$600000$iVLm2rwcbVyFHNksEkpCIr$TFXsYpOZ0+fA9rgzjVurmsag2eAeyoegtDLWiAM2jB0=','2024-01-19 09:56:43.309321',1,'admin@gmail.com',NULL,NULL,NULL,'2024-01-15','11:55:38.773000',NULL,'',NULL,1,1,'2024-01-15 11:55:38.000000',NULL,2,'2024-01-16','10:39:53.059107',NULL,NULL),(28,'pbkdf2_sha256$600000$wOFp4YacgjN4JqDEGChjPr$z1SJKUJPJVAjruMDR8UYWkkipfh8zhluW9QUwf/37f0=',NULL,0,'danish.saleem@ajcl.net','12435-3535353-3',18,'male','2024-01-19','05:08:00.000000',NULL,'','Unverified',1,0,'2024-01-19 12:09:18.092356',1,1,'2024-01-19','12:09:18.208251','Danish','Saleem'),(29,'pbkdf2_sha256$600000$LlNYNkFlwoBAIglikRCAwJ$+miNzACoFwiAo0jPHIYmlktHC9eeOXQ/cZ/4vT2yLfc=',NULL,0,'hanzala.kashif@ajcl.net','4210105932841',19,'Male','2024-05-11','12:20:00.000000',NULL,'','Unverified',1,0,'2024-01-19 13:34:16.392526',1,1,'2024-01-19','13:34:16.522225','hanzala','kashif');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users_groups`
--

DROP TABLE IF EXISTS `Users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `users_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_users_id_group_id_83a49e68_uniq` (`users_id`,`group_id`),
  KEY `users_groups_group_id_2f3517aa_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_groups_group_id_2f3517aa_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `users_groups_users_id_1e682706_fk_users_id` FOREIGN KEY (`users_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users_groups`
--

LOCK TABLES `Users_groups` WRITE;
/*!40000 ALTER TABLE `Users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users_user_permissions`
--

DROP TABLE IF EXISTS `Users_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `users_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_permissions_users_id_permission_id_d7a00931_uniq` (`users_id`,`permission_id`),
  KEY `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_user_permissions_users_id_e1ed60a2_fk_users_id` FOREIGN KEY (`users_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users_user_permissions`
--

LOCK TABLES `Users_user_permissions` WRITE;
/*!40000 ALTER TABLE `Users_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vehicle`
--

DROP TABLE IF EXISTS `Vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vehicle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `vehicle_type` varchar(155) NOT NULL,
  `vehicle_model` varchar(155) NOT NULL,
  `register_date` date NOT NULL,
  `register_time` time(6) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `charges` double NOT NULL,
  `register_by_id` bigint NOT NULL,
  `vehicle_image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicle_register_by_id_1bc7e150_fk_Users_id` (`register_by_id`),
  CONSTRAINT `vehicle_register_by_id_1bc7e150_fk_Users_id` FOREIGN KEY (`register_by_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vehicle`
--

LOCK TABLES `Vehicle` WRITE;
/*!40000 ALTER TABLE `Vehicle` DISABLE KEYS */;
INSERT INTO `Vehicle` VALUES (10,'2-Wheel','Motor Bike','2024-01-19','05:38:59.693894',1,30,1,'profile_images/10/20240119093832.png'),(11,'4-wheel','Car','2024-01-19','05:39:40.969873',1,100,1,'profile_images/11/20240119093847.png'),(12,'Above','Heavy','2024-01-19','05:40:05.933864',1,200,1,'profile_images/12/20240119093904.png');
/*!40000 ALTER TABLE `Vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add Token',6,'add_token'),(22,'Can change Token',6,'change_token'),(23,'Can delete Token',6,'delete_token'),(24,'Can view Token',6,'view_token'),(25,'Can add token',7,'add_tokenproxy'),(26,'Can change token',7,'change_tokenproxy'),(27,'Can delete token',7,'delete_tokenproxy'),(28,'Can view token',7,'view_tokenproxy'),(29,'Can add blacklisted token',8,'add_blacklistedtoken'),(30,'Can change blacklisted token',8,'change_blacklistedtoken'),(31,'Can delete blacklisted token',8,'delete_blacklistedtoken'),(32,'Can view blacklisted token',8,'view_blacklistedtoken'),(33,'Can add outstanding token',9,'add_outstandingtoken'),(34,'Can change outstanding token',9,'change_outstandingtoken'),(35,'Can delete outstanding token',9,'delete_outstandingtoken'),(36,'Can view outstanding token',9,'view_outstandingtoken'),(37,'Can add Password Reset Token',10,'add_resetpasswordtoken'),(38,'Can change Password Reset Token',10,'change_resetpasswordtoken'),(39,'Can delete Password Reset Token',10,'delete_resetpasswordtoken'),(40,'Can view Password Reset Token',10,'view_resetpasswordtoken'),(41,'Can add access',11,'add_access'),(42,'Can change access',11,'change_access'),(43,'Can delete access',11,'delete_access'),(44,'Can view access',11,'view_access'),(45,'Can add role',12,'add_role'),(46,'Can change role',12,'change_role'),(47,'Can delete role',12,'delete_role'),(48,'Can view role',12,'view_role'),(49,'Can add users',13,'add_users'),(50,'Can change users',13,'change_users'),(51,'Can delete users',13,'delete_users'),(52,'Can view users',13,'view_users'),(53,'Can add user_ attendance',14,'add_user_attendance'),(54,'Can change user_ attendance',14,'change_user_attendance'),(55,'Can delete user_ attendance',14,'delete_user_attendance'),(56,'Can view user_ attendance',14,'view_user_attendance'),(57,'Can add parking_ plaza',15,'add_parking_plaza'),(58,'Can change parking_ plaza',15,'change_parking_plaza'),(59,'Can delete parking_ plaza',15,'delete_parking_plaza'),(60,'Can view parking_ plaza',15,'view_parking_plaza'),(61,'Can add vehicle',16,'add_vehicle'),(62,'Can change vehicle',16,'change_vehicle'),(63,'Can delete vehicle',16,'delete_vehicle'),(64,'Can view vehicle',16,'view_vehicle'),(65,'Can add user_ allocation',17,'add_user_allocation'),(66,'Can change user_ allocation',17,'change_user_allocation'),(67,'Can delete user_ allocation',17,'delete_user_allocation'),(68,'Can view user_ allocation',17,'view_user_allocation'),(69,'Can add parking_ vehicle',18,'add_parking_vehicle'),(70,'Can change parking_ vehicle',18,'change_parking_vehicle'),(71,'Can delete parking_ vehicle',18,'delete_parking_vehicle'),(72,'Can view parking_ vehicle',18,'view_parking_vehicle'),(73,'Can add parking_ plaza_ log',19,'add_parking_plaza_log'),(74,'Can change parking_ plaza_ log',19,'change_parking_plaza_log'),(75,'Can delete parking_ plaza_ log',19,'delete_parking_plaza_log'),(76,'Can view parking_ plaza_ log',19,'view_parking_plaza_log'),(77,'Can add user attendance',14,'add_userattendance'),(78,'Can change user attendance',14,'change_userattendance'),(79,'Can delete user attendance',14,'delete_userattendance'),(80,'Can view user attendance',14,'view_userattendance'),(81,'Can add parking plaza',15,'add_parkingplaza'),(82,'Can change parking plaza',15,'change_parkingplaza'),(83,'Can delete parking plaza',15,'delete_parkingplaza'),(84,'Can view parking plaza',15,'view_parkingplaza'),(85,'Can add parking vehicle',18,'add_parkingvehicle'),(86,'Can change parking vehicle',18,'change_parkingvehicle'),(87,'Can delete parking vehicle',18,'delete_parkingvehicle'),(88,'Can view parking vehicle',18,'view_parkingvehicle'),(89,'Can add user allocation',17,'add_userallocation'),(90,'Can change user allocation',17,'change_userallocation'),(91,'Can delete user allocation',17,'delete_userallocation'),(92,'Can view user allocation',17,'view_userallocation'),(93,'Can add global configuration',20,'add_globalconfiguration'),(94,'Can change global configuration',20,'change_globalconfiguration'),(95,'Can delete global configuration',20,'delete_globalconfiguration'),(96,'Can view global configuration',20,'view_globalconfiguration'),(97,'Can add parking plaza log',19,'add_parkingplazalog'),(98,'Can change parking plaza log',19,'change_parkingplazalog'),(99,'Can delete parking plaza log',19,'delete_parkingplazalog'),(100,'Can view parking plaza log',19,'view_parkingplazalog');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-01-15 12:35:48.324233','1','user',1,'[{\"added\": {}}]',12,1),(2,'2024-01-15 12:35:52.667246','2','admin',1,'[{\"added\": {}}]',12,1),(3,'2024-01-15 12:35:57.382644','2','admin',2,'[{\"changed\": {\"fields\": [\"Active\"]}}]',12,1),(4,'2024-01-16 05:41:12.115170','1','admin@gmail.com',2,'[{\"changed\": {\"fields\": [\"Role\"]}}]',13,1),(5,'2024-01-16 06:14:20.736886','2','hanzala.kashif@ajcl.net',1,'[{\"added\": {}}]',13,1),(6,'2024-01-16 06:15:19.186898','2','hanzala.kashif@ajcl.net',2,'[]',13,1),(7,'2024-01-16 06:16:29.752710','2','hanzala.kashif@ajcl.net',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',13,1),(8,'2024-01-16 06:17:00.806739','2','hanzala.kashif@ajcl.net',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',13,1),(9,'2024-01-16 06:20:32.554423','2','hanzala.kashif@ajcl.net',2,'[]',13,1),(10,'2024-01-16 06:21:00.517365','2','hanzala.kashif@ajcl.net',2,'[]',13,1),(11,'2024-01-16 06:36:12.267915','3','test@gmail.com',1,'[{\"added\": {}}]',13,1),(12,'2024-01-16 06:36:23.698570','2','hanzala.kashif@ajcl.net',3,'',13,1),(13,'2024-01-18 05:29:29.065662','11','hanzala.kashif@ajcl.net',3,'',13,1),(14,'2024-01-18 06:04:10.165041','12','hanzala.kashif@ajcl.net',3,'',13,1),(15,'2024-01-18 06:15:18.131081','13','hanzala.kashif@ajcl.net',3,'',13,1),(16,'2024-01-18 06:16:33.530173','14','hanzala.kashif@ajcl.net',3,'',13,1),(17,'2024-01-18 06:50:06.710366','1','vehicle_model Honda is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(18,'2024-01-18 06:50:18.246083','1','vehicle_model Honda is registered by admin@gmail.com',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',16,1),(19,'2024-01-18 06:50:38.877353','2','vehicle_model Unique is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(20,'2024-01-18 06:51:11.695392','3','vehicle_model Super Start is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(21,'2024-01-18 06:51:36.638929','4','vehicle_model Super Power is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(22,'2024-01-18 06:51:57.196180','5','vehicle_model Mehran is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(23,'2024-01-18 06:52:15.785522','6','vehicle_model Khyber is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(24,'2024-01-18 06:52:31.591999','7','vehicle_model Cultus is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(25,'2024-01-18 06:52:40.959978','7','vehicle_model Cultus is registered by admin@gmail.com',2,'[{\"changed\": {\"fields\": [\"Charges\"]}}]',16,1),(26,'2024-01-18 06:53:03.597173','8','vehicle_model City is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(27,'2024-01-18 10:08:50.079062','6','consthanzalakashif2003@gmail.com',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',13,1),(28,'2024-01-18 10:09:00.253005','6','consthanzalakashif2003@gmail.com',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',13,1),(29,'2024-01-18 10:09:12.245740','6','consthanzalakashif2003@gmail.com',3,'',13,1),(30,'2024-01-18 10:20:22.938653','3','test@gmail.com',2,'[{\"changed\": {\"fields\": [\"Profile image\"]}}]',13,1),(31,'2024-01-18 10:26:38.193774','3','test@gmail.com',2,'[{\"changed\": {\"fields\": [\"Profile image\"]}}]',13,1),(32,'2024-01-18 10:26:46.137198','15','hanzala.kashif@ajcl.net',2,'[{\"changed\": {\"fields\": [\"Profile image\"]}}]',13,1),(33,'2024-01-18 12:32:01.927894','1','email_host',1,'[{\"added\": {}}]',20,1),(34,'2024-01-19 05:32:24.460763','7','vehicle_model Cultus is registered by admin@gmail.com',3,'',16,1),(35,'2024-01-19 05:32:24.465513','6','vehicle_model Khyber is registered by admin@gmail.com',3,'',16,1),(36,'2024-01-19 05:32:24.468495','4','vehicle_model Super Power is registered by admin@gmail.com',3,'',16,1),(37,'2024-01-19 05:32:24.471757','3','vehicle_model Super Start is registered by admin@gmail.com',3,'',16,1),(38,'2024-01-19 05:32:24.475214','1','vehicle_model Honda is registered by admin@gmail.com',3,'',16,1),(39,'2024-01-19 05:32:34.911929','8','vehicle_model City is registered by admin@gmail.com',3,'',16,1),(40,'2024-01-19 05:37:51.876089','9','vehicle_model Car is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(41,'2024-01-19 05:38:07.371806','9','vehicle_model Car is registered by admin@gmail.com',3,'',16,1),(42,'2024-01-19 05:38:07.375948','5','vehicle_model Mehran is registered by admin@gmail.com',3,'',16,1),(43,'2024-01-19 05:38:07.379062','2','vehicle_model Unique is registered by admin@gmail.com',3,'',16,1),(44,'2024-01-19 05:38:59.695128','10','vehicle_model Motor Bike is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(45,'2024-01-19 05:39:40.971035','11','vehicle_model Car is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(46,'2024-01-19 05:40:05.934994','12','vehicle_model Heavy is registered by admin@gmail.com',1,'[{\"added\": {}}]',16,1),(47,'2024-01-19 06:04:05.602249','1','email_host',2,'[{\"changed\": {\"fields\": [\"Value\"]}}]',20,1),(48,'2024-01-19 09:37:54.194614','1','email_host',2,'[{\"changed\": {\"fields\": [\"Value\"]}}]',20,1),(49,'2024-01-19 09:38:32.828619','10','vehicle_model Motor Bike is registered by admin@gmail.com',2,'[{\"changed\": {\"fields\": [\"Vehicle image\"]}}]',16,1),(50,'2024-01-19 09:38:47.153305','11','vehicle_model Car is registered by admin@gmail.com',2,'[{\"changed\": {\"fields\": [\"Vehicle image\"]}}]',16,1),(51,'2024-01-19 09:39:04.627901','12','vehicle_model Heavy is registered by admin@gmail.com',2,'[{\"changed\": {\"fields\": [\"Vehicle image\"]}}]',16,1),(52,'2024-01-19 12:03:55.286708','26','danish@gmail.com',3,'',13,1),(53,'2024-01-19 12:03:55.298623','25','testing00@gmail.com',3,'',13,1),(54,'2024-01-19 12:03:55.300932','24','testin@gmail.com',3,'',13,1),(55,'2024-01-19 12:03:55.303577','20','testing3@gmail.com',3,'',13,1),(56,'2024-01-19 12:03:55.305895','17','testing2@gmail.com',3,'',13,1),(57,'2024-01-19 12:03:55.307533','16','testing@gmail.com',3,'',13,1),(58,'2024-01-19 12:03:55.309700','15','hanzala.kashif@ajcl.net',3,'',13,1),(59,'2024-01-19 12:03:55.311779','3','test@gmail.com',3,'',13,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(11,'authentication','access'),(12,'authentication','role'),(14,'authentication','userattendance'),(13,'authentication','users'),(6,'authtoken','token'),(7,'authtoken','tokenproxy'),(4,'contenttypes','contenttype'),(10,'django_rest_passwordreset','resetpasswordtoken'),(20,'parking','globalconfiguration'),(15,'parking','parkingplaza'),(19,'parking','parkingplazalog'),(18,'parking','parkingvehicle'),(17,'parking','userallocation'),(16,'parking','vehicle'),(5,'sessions','session'),(8,'token_blacklist','blacklistedtoken'),(9,'token_blacklist','outstandingtoken');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-01-15 11:54:07.102942'),(2,'contenttypes','0002_remove_content_type_name','2024-01-15 11:54:07.166096'),(3,'auth','0001_initial','2024-01-15 11:54:07.372154'),(4,'auth','0002_alter_permission_name_max_length','2024-01-15 11:54:07.412346'),(5,'auth','0003_alter_user_email_max_length','2024-01-15 11:54:07.423202'),(6,'auth','0004_alter_user_username_opts','2024-01-15 11:54:07.435084'),(7,'auth','0005_alter_user_last_login_null','2024-01-15 11:54:07.446851'),(8,'auth','0006_require_contenttypes_0002','2024-01-15 11:54:07.452599'),(9,'auth','0007_alter_validators_add_error_messages','2024-01-15 11:54:07.458625'),(10,'auth','0008_alter_user_username_max_length','2024-01-15 11:54:07.465684'),(11,'auth','0009_alter_user_last_name_max_length','2024-01-15 11:54:07.474896'),(12,'auth','0010_alter_group_name_max_length','2024-01-15 11:54:07.489189'),(13,'auth','0011_update_proxy_permissions','2024-01-15 11:54:07.497399'),(14,'auth','0012_alter_user_first_name_max_length','2024-01-15 11:54:07.508986'),(15,'authentication','0001_initial','2024-01-15 11:54:07.869055'),(16,'admin','0001_initial','2024-01-15 11:54:07.970177'),(17,'admin','0002_logentry_remove_auto_add','2024-01-15 11:54:07.983086'),(18,'admin','0003_logentry_add_action_flag_choices','2024-01-15 11:54:07.997159'),(19,'authtoken','0001_initial','2024-01-15 11:54:08.065077'),(20,'authtoken','0002_auto_20160226_1747','2024-01-15 11:54:08.096291'),(21,'authtoken','0003_tokenproxy','2024-01-15 11:54:08.100312'),(22,'django_rest_passwordreset','0001_initial','2024-01-15 11:54:08.160596'),(23,'django_rest_passwordreset','0002_pk_migration','2024-01-15 11:54:08.267018'),(24,'django_rest_passwordreset','0003_allow_blank_and_null_fields','2024-01-15 11:54:08.339599'),(25,'sessions','0001_initial','2024-01-15 11:54:08.375827'),(26,'token_blacklist','0001_initial','2024-01-15 11:54:08.517190'),(27,'token_blacklist','0002_outstandingtoken_jti_hex','2024-01-15 11:54:08.551446'),(28,'token_blacklist','0003_auto_20171017_2007','2024-01-15 11:54:08.575133'),(29,'token_blacklist','0004_auto_20171017_2013','2024-01-15 11:54:08.655674'),(30,'token_blacklist','0005_remove_outstandingtoken_jti','2024-01-15 11:54:08.705204'),(31,'token_blacklist','0006_auto_20171017_2113','2024-01-15 11:54:08.739942'),(32,'token_blacklist','0007_auto_20171017_2214','2024-01-15 11:54:08.890427'),(33,'token_blacklist','0008_migrate_to_bigautofield','2024-01-15 11:54:09.088468'),(34,'token_blacklist','0010_fix_migrate_to_bigautofield','2024-01-15 11:54:09.109579'),(35,'token_blacklist','0011_linearizes_history','2024-01-15 11:54:09.114181'),(36,'token_blacklist','0012_alter_outstandingtoken_user','2024-01-15 11:54:09.127677'),(37,'authentication','0002_alter_users_role','2024-01-15 11:55:26.243814'),(38,'authentication','0003_alter_users_auth_key_alter_access_table_and_more','2024-01-16 05:40:37.631567'),(39,'parking','0001_initial','2024-01-16 05:40:38.212991'),(40,'authentication','0004_alter_users_profile_image','2024-01-16 05:49:18.442503'),(41,'authentication','0005_alter_role_table','2024-01-16 06:01:06.024783'),(42,'authentication','0006_rename_user_attendance_userattendance_and_more','2024-01-16 10:39:53.135404'),(43,'parking','0002_rename_parking_plaza_parkingplaza_and_more','2024-01-16 10:39:53.407626'),(44,'authentication','0007_users_first_name_users_last_name','2024-01-16 15:48:17.170954'),(45,'parking','0003_globalconfiguration','2024-01-18 05:54:49.845494'),(46,'parking','0004_rename_parking_plaza_log_parkingplazalog_and_more','2024-01-18 06:28:40.512129'),(47,'parking','0005_alter_globalconfiguration_table_alter_vehicle_table','2024-01-18 06:29:47.717600'),(48,'parking','0006_alter_parkingplaza_area','2024-01-18 06:39:16.104841'),(49,'parking','0007_alter_parkingvehicle_check_out_date_and_more','2024-01-18 09:32:03.807417'),(50,'parking','0008_alter_parkingvehicle_check_out_date_and_more','2024-01-18 09:56:35.256677'),(51,'authentication','0008_alter_userattendance_status','2024-01-18 13:32:44.686228'),(52,'authentication','0009_alter_userattendance_status','2024-01-19 04:54:56.287070'),(53,'authentication','0010_alter_users_cnic','2024-01-19 06:23:03.407597'),(54,'parking','0009_vehicle_vehicle_image','2024-01-19 07:39:05.350697'),(55,'parking','0010_alter_parkingplaza_address','2024-01-19 11:36:21.246780'),(56,'parking','0011_alter_parkingplaza_address','2024-01-19 11:36:44.933943'),(57,'authentication','0011_alter_userattendance_user','2024-01-19 13:27:23.337131'),(58,'authentication','0012_alter_userattendance_latitude_and_more','2024-01-19 13:47:35.168743');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_rest_passwordreset_resetpasswordtoken`
--

DROP TABLE IF EXISTS `django_rest_passwordreset_resetpasswordtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_rest_passwordreset_resetpasswordtoken` (
  `created_at` datetime(6) NOT NULL,
  `key` varchar(64) NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `user_agent` varchar(256) NOT NULL,
  `user_id` bigint NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_rest_passwordreset_resetpasswordtoken_key_f1b65873_uniq` (`key`),
  KEY `django_rest_passwordr_user_id_e8015b11_fk_users_id` (`user_id`),
  CONSTRAINT `django_rest_passwordr_user_id_e8015b11_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_rest_passwordreset_resetpasswordtoken`
--

LOCK TABLES `django_rest_passwordreset_resetpasswordtoken` WRITE;
/*!40000 ALTER TABLE `django_rest_passwordreset_resetpasswordtoken` DISABLE KEYS */;
INSERT INTO `django_rest_passwordreset_resetpasswordtoken` VALUES ('2024-01-19 12:09:18.337796','e0fb6755fa254a4b6b50df3c0131cfa1bba04ad92bc3','192.168.8.102','okhttp/4.9.2',28,17),('2024-01-19 13:34:16.654508','7d2742a6dbed35b6d','192.168.8.101','PostmanRuntime/7.36.1',29,18);
/*!40000 ALTER TABLE `django_rest_passwordreset_resetpasswordtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0v2t97igncu48mty3mwnyo5ntvdcnq99','.eJxVjMsOwiAQRf-FtSFQ3i7d-w0EmBmpGkhKuzL-uzbpQrf3nHNfLKZtrXEbuMQZ2JlJdvrdcioPbDuAe2q3zktv6zJnviv8oINfO-Dzcrh_BzWN-q2FRbKKnNWYgytTBh8g-Zy0s8JoRDLkhQGagqDiUcriPCkrQy5WgWfvD_e-OFU:1rPLZJ:xqYWTGr3ZL5v7ChKA8zO2V4c7GB8DgXD-ZTDSUgZOSc','2024-01-29 11:55:53.898889'),('31c45uyglhxzfyiaw3yfk9puamitu14c','.eJxVjMsOwiAQRf-FtSFQ3i7d-w0EmBmpGkhKuzL-uzbpQrf3nHNfLKZtrXEbuMQZ2JlJdvrdcioPbDuAe2q3zktv6zJnviv8oINfO-Dzcrh_BzWN-q2FRbKKnNWYgytTBh8g-Zy0s8JoRDLkhQGagqDiUcriPCkrQy5WgWfvD_e-OFU:1rQRYK:Zt76T_3VTRpSmMrUy7J4KWa9TaR9zpuOZBVMfIZ7Y3w','2024-02-01 12:31:24.687512'),('4lp59apbc5pjdt06bx4tm07yu47bwv2o','.eJxVjMsOwiAQRf-FtSFQ3i7d-w0EmBmpGkhKuzL-uzbpQrf3nHNfLKZtrXEbuMQZ2JlJdvrdcioPbDuAe2q3zktv6zJnviv8oINfO-Dzcrh_BzWN-q2FRbKKnNWYgytTBh8g-Zy0s8JoRDLkhQGagqDiUcriPCkrQy5WgWfvD_e-OFU:1rQlJS:7au35Spkv9b6BhTQMTqJtkAKOObAYv3GA3Un9NKTm40','2024-02-02 09:37:22.478847'),('761iok6jdepz1puv5j8gxox4i1el7r95','.eJxVjMsOwiAQRf-FtSFQ3i7d-w0EmBmpGkhKuzL-uzbpQrf3nHNfLKZtrXEbuMQZ2JlJdvrdcioPbDuAe2q3zktv6zJnviv8oINfO-Dzcrh_BzWN-q2FRbKKnNWYgytTBh8g-Zy0s8JoRDLkhQGagqDiUcriPCkrQy5WgWfvD_e-OFU:1rQlcB:SYMc580Ct5bseY04VAuB-cj3_egezZtl8xPnWr23vuI','2024-02-02 09:56:43.312762'),('pislusq5m92r1kshs0j0y3wp0uci7ij8','.eJxVjMsOwiAQRf-FtSFQ3i7d-w0EmBmpGkhKuzL-uzbpQrf3nHNfLKZtrXEbuMQZ2JlJdvrdcioPbDuAe2q3zktv6zJnviv8oINfO-Dzcrh_BzWN-q2FRbKKnNWYgytTBh8g-Zy0s8JoRDLkhQGagqDiUcriPCkrQy5WgWfvD_e-OFU:1rQhyY:T5WY5PgwnGlAOyHarG37qQBP4x3LXAC1iLPvRSZwkxQ','2024-02-02 06:03:34.494710');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_blacklistedtoken`
--

DROP TABLE IF EXISTS `token_blacklist_blacklistedtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_blacklistedtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blacklisted_at` datetime(6) NOT NULL,
  `token_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_id` (`token_id`),
  CONSTRAINT `token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk` FOREIGN KEY (`token_id`) REFERENCES `token_blacklist_outstandingtoken` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_blacklistedtoken`
--

LOCK TABLES `token_blacklist_blacklistedtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_outstandingtoken`
--

DROP TABLE IF EXISTS `token_blacklist_outstandingtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_outstandingtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `jti` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq` (`jti`),
  KEY `token_blacklist_outstandingtoken_user_id_83bc629a_fk_users_id` (`user_id`),
  CONSTRAINT `token_blacklist_outstandingtoken_user_id_83bc629a_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_outstandingtoken`
--

LOCK TABLES `token_blacklist_outstandingtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_outstandingtoken` VALUES (1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTQ3MDA3NiwiaWF0IjoxNzA1MzgzNjc2LCJqdGkiOiIyMDEzYzBlMTM4NjM0OTY1YmU4MjBjMDA2ZGM2MzQyYSIsInVzZXJfaWQiOjF9.YzRkVQmMLJ5oadsopszVwHEHq4R9efSMHOHGfnDFEJA','2024-01-16 05:41:16.534631','2024-01-17 05:41:16.000000',1,'2013c0e138634965be820c006dc6342a'),(2,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTQ3MzQxMiwiaWF0IjoxNzA1Mzg3MDEyLCJqdGkiOiJkZWZlNjUwMTE0NzY0YjAwOWRkMzQ3NTI5NWMzZWZmMSIsInVzZXJfaWQiOjN9.VUZCRGuA5dLEGqAsV7loIgeZebf2-JcWHCVLkPM0I_E','2024-01-16 06:36:52.174571','2024-01-17 06:36:52.000000',NULL,'defe650114764b009dd3475295c3eff1'),(3,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTQ3MzgyOSwiaWF0IjoxNzA1Mzg3NDI5LCJqdGkiOiIwMmIxYmU0YmI5MGI0MmY3OTRmODdlZDM4OTAwYmFmZiIsInVzZXJfaWQiOjN9.BFyZDrfTtwyKLtp2g3kU9TADOtPJCsvR99UYiuj0QGA','2024-01-16 06:43:49.772725','2024-01-17 06:43:49.000000',NULL,'02b1be4bb90b42f794f87ed38900baff'),(4,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTQ3Mzg1NiwiaWF0IjoxNzA1Mzg3NDU2LCJqdGkiOiI0MjBmMDQzZjBlMGQ0NDkwYmMyMjY2ZWM1MGMxMmMyNyIsInVzZXJfaWQiOjF9.mnqbzv2D5hy6ouMXqW5Ld368uUbFk2mIqkRWqrNXnEw','2024-01-16 06:44:16.484110','2024-01-17 06:44:16.000000',1,'420f043f0e0d4490bc2266ec50c12c27'),(5,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTQ4Njk0MSwiaWF0IjoxNzA1NDAwNTQxLCJqdGkiOiIxOGI2ZjNjNWU4MzY0OWE1OWQyNGY0ZThiODJhMjM0ZiIsInVzZXJfaWQiOjF9.PDjv9E1W2ygJ1lrF2R7tYZLCffV90rZ468oJK0z-Uy0','2024-01-16 10:22:21.861149','2024-01-17 10:22:21.000000',1,'18b6f3c5e83649a59d24f4e8b82a234f'),(6,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTQ5NTE4NiwiaWF0IjoxNzA1NDA4Nzg2LCJqdGkiOiI3NmU5ZWJhNGJhOWU0ZWI2YjZiZTFkMjUyNjdmMmYzYSIsInVzZXJfaWQiOjF9.8cX-QeZqKIOxQeSI58-uS1MSv1Ip3FTkFzdeDNck1oA','2024-01-16 12:39:46.489102','2024-01-17 12:39:46.000000',1,'76e9eba4ba9e4eb6b6be1d25267f2f3a'),(7,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY0MTA3NSwiaWF0IjoxNzA1NTU0Njc1LCJqdGkiOiIyMmU2ZTA3NDZlYjQ0NTRjYWU3YzA0OGExZTEwMzA0NyIsInVzZXJfaWQiOjF9.5LEtsQuxGLHFhjCD-mK7MdABg3bHKcPIl_PlsB_a7oI','2024-01-18 05:11:15.414174','2024-01-19 05:11:15.000000',1,'22e6e0746eb4454cae7c048a1e103047'),(8,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY1OTAyOCwiaWF0IjoxNzA1NTcyNjI4LCJqdGkiOiIyZTFkZWUxNjFiZmM0OTM0OWIyZDgzNWRmOWE2NjMwNCIsInVzZXJfaWQiOjE1fQ.lpypmvczavSfoMaZWlMHaTHVdoiERp71Z5dQ2kKtaQk','2024-01-18 10:10:28.507285','2024-01-19 10:10:28.000000',NULL,'2e1dee161bfc49349b2d835df9a66304'),(9,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY2MTE2MSwiaWF0IjoxNzA1NTc0NzYxLCJqdGkiOiIzYmYyN2VkNDMxMWU0YzM2ODVhYWI4YjFiZmI1NmY5MyIsInVzZXJfaWQiOjE1fQ.w_tRsEPjJHvRj9fQPWkksfI1wGdopYhgZaDIGCRubzQ','2024-01-18 10:46:01.691601','2024-01-19 10:46:01.000000',NULL,'3bf27ed4311e4c3685aab8b1bfb56f93'),(10,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY2ODY2NiwiaWF0IjoxNzA1NTgyMjY2LCJqdGkiOiJhNTBjMmZlY2I0YzI0NmViYWFmZDlkZGU1YmY4ZmI1NiIsInVzZXJfaWQiOjF9.tdRnyS835ycUbwNL1noP6uz7vRFjvGlFUuvFRWOyNuU','2024-01-18 12:51:06.942060','2024-01-19 12:51:06.000000',1,'a50c2fecb4c246ebaafd9dde5bf8fb56'),(11,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY2ODgzNiwiaWF0IjoxNzA1NTgyNDM2LCJqdGkiOiI5NmE2NzNjN2JhNmU0NTRjOTBhNjg3OGZmMTgxNjgzMyIsInVzZXJfaWQiOjF9.8wVStH0R_yJWeS08az8zV0d4EGsSeiRotpt0kgTkYK8','2024-01-18 12:53:56.823470','2024-01-19 12:53:56.000000',1,'96a673c7ba6e454c90a6878ff1816833'),(12,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY2OTE3MSwiaWF0IjoxNzA1NTgyNzcxLCJqdGkiOiIwMzhjYzI0YTI5Yjg0MzMyOWI2MDA2MzkxYWUyYTJiZSIsInVzZXJfaWQiOjF9.LezdUXYCg-RQK057P14hANMGzOQQ2odVrY_6YF4j3qE','2024-01-18 12:59:31.156043','2024-01-19 12:59:31.000000',1,'038cc24a29b843329b6006391ae2a2be'),(13,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY2OTIxNCwiaWF0IjoxNzA1NTgyODE0LCJqdGkiOiI3YWY0OGQ0MjU0YjU0MDExOWRiZmZkYWQyNjBhZTNmZSIsInVzZXJfaWQiOjF9.TwEa8gj1hw_9cmCsWO5BCS0ztkjNvoMDJrh8yh3RMN8','2024-01-18 13:00:14.346498','2024-01-19 13:00:14.000000',1,'7af48d4254b540119dbffdad260ae3fe'),(14,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY2OTY0NCwiaWF0IjoxNzA1NTgzMjQ0LCJqdGkiOiJlYmU2ZmU0NjdhZjg0NmI5OTI5NTA5MWViM2RiMTI5MyIsInVzZXJfaWQiOjF9.cq2QIrRm9UTW7d-sWC7nj9895VQUSorAhj6AuPrlSwE','2024-01-18 13:07:24.533032','2024-01-19 13:07:24.000000',1,'ebe6fe467af846b99295091eb3db1293'),(15,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY3MDUyMiwiaWF0IjoxNzA1NTg0MTIyLCJqdGkiOiIyNTUxNjMzYWJhNDM0Mzc1ODNiYjBmNmJjNGY4ODk0YSIsInVzZXJfaWQiOjF9.VD2Dxcei97DD-H6klynT8t3_OzfIkYoXfgaALIBFo0Y','2024-01-18 13:22:02.590116','2024-01-19 13:22:02.000000',1,'2551633aba43437583bb0f6bc4f8894a'),(16,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY3MDY2OCwiaWF0IjoxNzA1NTg0MjY4LCJqdGkiOiIyMTNhZTQ1ZmZjMDA0NGEwYWJlMWNiYTk2Yzk1OWViYSIsInVzZXJfaWQiOjF9.bZUtM2vt3fhBbr4ZNYbKO1fU8gClUnv4xS5naFe-GoA','2024-01-18 13:24:28.184149','2024-01-19 13:24:28.000000',1,'213ae45ffc0044a0abe1cba96c959eba'),(17,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY3MDc3NiwiaWF0IjoxNzA1NTg0Mzc2LCJqdGkiOiJjMGIwOGMzOWYzZTk0OWVjOGZlMjJlMzVlODA1NmI3NiIsInVzZXJfaWQiOjF9.4gdxggcgawWmKVXJnB3x_KzqrvlMGpgKWeXxiVwq_9I','2024-01-18 13:26:16.653176','2024-01-19 13:26:16.000000',1,'c0b08c39f3e949ec8fe22e35e8056b76'),(18,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY3MDgwMSwiaWF0IjoxNzA1NTg0NDAxLCJqdGkiOiI5MmNkNWIzYWYyM2E0NTczYmRhOGU4NTExNmNmODMwNSIsInVzZXJfaWQiOjF9.eEqGJ-5bx2OxPb8_XH8nitaXeBylrp1me3xOoe9P9xA','2024-01-18 13:26:41.852298','2024-01-19 13:26:41.000000',1,'92cd5b3af23a4573bda8e85116cf8305'),(19,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY3MDgyMywiaWF0IjoxNzA1NTg0NDIzLCJqdGkiOiIxNWZiMGY0ZjkxNjc0NzJkOTdjMTk3ZGFhMDVlNTM4YSIsInVzZXJfaWQiOjF9.W43rdsdcMWQyGIIbBCcEKq54p4nuAHskNY11sn7MzBE','2024-01-18 13:27:03.317852','2024-01-19 13:27:03.000000',1,'15fb0f4f9167472d97c197daa05e538a'),(20,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY3MDkxMiwiaWF0IjoxNzA1NTg0NTEyLCJqdGkiOiI3OWNjNzA1N2FiODc0ZGQ3OTU3ODljYTE2ZGI2MDM1YyIsInVzZXJfaWQiOjF9.o0VAKBsCQI12tJ0zMbjAEJqQIOFkArhm__HhuCZzfFc','2024-01-18 13:28:32.828050','2024-01-19 13:28:32.000000',1,'79cc7057ab874dd795789ca16db6035c'),(21,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY3MTEzNSwiaWF0IjoxNzA1NTg0NzM1LCJqdGkiOiJjMTE4MGQ3MTYyYTM0YjIwODUwY2ViYzA2M2U5M2QzZCIsInVzZXJfaWQiOjF9.Z36VF74TeEWsID1jjYB-GZjtWx41CdR9jvZOWX2d2dw','2024-01-18 13:32:15.860893','2024-01-19 13:32:15.000000',1,'c1180d7162a34b20850cebc063e93d3d'),(22,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY3MTE3MCwiaWF0IjoxNzA1NTg0NzcwLCJqdGkiOiIyZTljYjQ0Njk2NTU0M2RkOThkNjgxYWZlYTJkZTY4MiIsInVzZXJfaWQiOjF9.DFqtzDqSEHOSo1p4mJ5gsdv1xxcHV8B8GMrjt-ifh3c','2024-01-18 13:32:50.581193','2024-01-19 13:32:50.000000',1,'2e9cb446965543dd98d681afea2de682'),(23,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY3MTE3MywiaWF0IjoxNzA1NTg0NzczLCJqdGkiOiJjMGUwNjBiNzcwYmU0NWVkOTZkZWM0Mjc3OWNlYjdjNiIsInVzZXJfaWQiOjF9.5SZ6EzBMLxcy6MuHGHN7EhNu06cQI27oq2re2oHKqBs','2024-01-18 13:32:53.965232','2024-01-19 13:32:53.000000',1,'c0e060b770be45ed96dec42779ceb7c6'),(24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY3MTIwMiwiaWF0IjoxNzA1NTg0ODAyLCJqdGkiOiIxMjliYjI5NDg1OTg0ZjQ1YjI2MDQxNjVhMGRlYjNmOCIsInVzZXJfaWQiOjF9.zANkxuisSW_0h4K7cwuMwvl-lICehRksG4eh3l2fkV0','2024-01-18 13:33:22.245189','2024-01-19 13:33:22.000000',1,'129bb29485984f45b2604165a0deb3f8'),(25,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTY3MTIxMiwiaWF0IjoxNzA1NTg0ODEyLCJqdGkiOiIxNWM5ZDQxMTgyMDQ0NDc2OTU3MjhhMzA3YzNmYzJmMyIsInVzZXJfaWQiOjF9.rV2sYfF0aCibIDKm9FBdsdmBhBYTiP0tOzaKPYTlA3g','2024-01-18 13:33:32.469363','2024-01-19 13:33:32.000000',1,'15c9d4118204447695728a307c3fc2f3'),(26,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTcyNzEwMSwiaWF0IjoxNzA1NjQwNzAxLCJqdGkiOiI3MTMwZTJkNTg2ZDk0ODQ3YjY1M2Q3ZmM2ZDNkNWM5MiIsInVzZXJfaWQiOjF9.4rpTMa5M874R95n8QMhfXwpAxzb_UG4O170Y6O393wk','2024-01-19 05:05:01.217821','2024-01-20 05:05:01.000000',1,'7130e2d586d94847b653d7fc6d3d5c92'),(27,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTcyNzExMiwiaWF0IjoxNzA1NjQwNzEyLCJqdGkiOiIwMWQzYzZkMDUwZmY0NTA4YjE3MGViZmViYWM4ZGU4YiIsInVzZXJfaWQiOjF9.s8qAH_-KIfdb8tI7A8htdqmBVLwSUU22wiMaBcNVAq0','2024-01-19 05:05:12.343141','2024-01-20 05:05:12.000000',1,'01d3c6d050ff4508b170ebfebac8de8b'),(28,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTcyOTMwMiwiaWF0IjoxNzA1NjQyOTAyLCJqdGkiOiI0MDZkMjljNmYzM2Y0MDY5YTQwYWU4NTMxMzc0NDVhMiIsInVzZXJfaWQiOjF9.NG1l_hRjNzavoIjcvUjGwu2-2Hpl8CUut12hUDEbobg','2024-01-19 05:41:42.768555','2024-01-20 05:41:42.000000',1,'406d29c6f33f4069a40ae853137445a2'),(29,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTcyOTMyMCwiaWF0IjoxNzA1NjQyOTIwLCJqdGkiOiJhNDgyOTVlODM0YTA0ZDZhODQzOWI1NTRlYThkNDkyMCIsInVzZXJfaWQiOjF9._SLDGfHSG4h63EPEVFB4AKo-oU8iPMpw_4OASBSHr3E','2024-01-19 05:42:00.915461','2024-01-20 05:42:00.000000',1,'a48295e834a04d6a8439b554ea8d4920'),(30,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTcyOTQxMywiaWF0IjoxNzA1NjQzMDEzLCJqdGkiOiJhMWQyODA4MDRiODk0NTliOTY3NmNjZWEzM2QxN2YzMSIsInVzZXJfaWQiOjF9.H-2EIuAxQDWaZ059gYc-1DWY-vsrxjWzAVhvovx2h1Q','2024-01-19 05:43:33.401561','2024-01-20 05:43:33.000000',1,'a1d280804b89459b9676ccea33d17f31'),(31,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTcyOTU1OSwiaWF0IjoxNzA1NjQzMTU5LCJqdGkiOiIyNDI4MGFmZjUzN2Y0MjkzOTE2Y2FmYjkxN2E3MzI2ZCIsInVzZXJfaWQiOjF9.HkLhfIzGS_37U1Nzus-dqVCjEFtCGAI4tvmo76ikdmo','2024-01-19 05:45:59.474776','2024-01-20 05:45:59.000000',1,'24280aff537f4293916cafb917a7326d'),(32,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTczMjE2NywiaWF0IjoxNzA1NjQ1NzY3LCJqdGkiOiJmYTE2YWEzNDBkYmU0MzUyYTI3NmNjOWYwZjQ5YjMzMyIsInVzZXJfaWQiOjF9.dMafuUBSZAwvfLSA1Dyy926vo4XDOz-tJr-LnlUsRvA','2024-01-19 06:29:27.752243','2024-01-20 06:29:27.000000',1,'fa16aa340dbe4352a276cc9f0f49b333'),(33,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTczNDAxMSwiaWF0IjoxNzA1NjQ3NjExLCJqdGkiOiJhNjBlYTU4NDk1MTQ0ZDM2YmEyZTEyMWZkZWYwMWUzNyIsInVzZXJfaWQiOjF9.ktmVAIt8lM5rJMDPMJ7TaZ2Nm2OZo8hG1Zv_CYi7l4I','2024-01-19 07:00:11.947945','2024-01-20 07:00:11.000000',1,'a60ea58495144d36ba2e121fdef01e37'),(34,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTczNDAyNiwiaWF0IjoxNzA1NjQ3NjI2LCJqdGkiOiI1Yjg0NzVmNGI4ODE0ODA3OGJlYTA5ODEyMzM5N2I0MiIsInVzZXJfaWQiOjF9.4gRW83vi-7Dh_Y1eLJDk_AaAH9kCAi6epkkd8qF3Yo8','2024-01-19 07:00:26.653216','2024-01-20 07:00:26.000000',1,'5b8475f4b88148078bea098123397b42'),(35,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTczNDIxMiwiaWF0IjoxNzA1NjQ3ODEyLCJqdGkiOiI1MjdjYWE1YWNlYjI0YTZiODk1NWIyMzFkMTFmYTA0NSIsInVzZXJfaWQiOjF9.-UPp6CrEDrtSQQlEw0qID0Xj1w_AjzH7pRhyVdhGCzo','2024-01-19 07:03:32.952684','2024-01-20 07:03:32.000000',1,'527caa5aceb24a6b8955b231d11fa045'),(36,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTczNTQxOSwiaWF0IjoxNzA1NjQ5MDE5LCJqdGkiOiI1ODIxMzk3NDMyY2E0YWM3YmI1MjUxOGM0YmFhMzhlYiIsInVzZXJfaWQiOjF9.yGxCg6DhJycRtnQSlHLP8EyUr7VU4Z4-zp6ZwjSLkck','2024-01-19 07:23:39.915226','2024-01-20 07:23:39.000000',1,'5821397432ca4ac7bb52518c4baa38eb'),(37,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc0NTI4OSwiaWF0IjoxNzA1NjU4ODg5LCJqdGkiOiJjYzE4NmU2YWEwMjY0YWVmYWNiYTBlZTI1N2FmYTYyYiIsInVzZXJfaWQiOjF9.LxJgPSx90OdCZ65GkqYyua3Zh4BPn6JkD3YfrwM3-0g','2024-01-19 10:08:09.339815','2024-01-20 10:08:09.000000',1,'cc186e6aa0264aefacba0ee257afa62b'),(38,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc0NTMxMywiaWF0IjoxNzA1NjU4OTEzLCJqdGkiOiJjMjk3Y2FiMTE1NDg0MTI2YjQxODExNTNjMWMwODkxOCIsInVzZXJfaWQiOjE1fQ.nnM4Z8fuAIMYmor1QUbT5W_uMg0Tkpm5sCKdyJ4R9u4','2024-01-19 10:08:33.947067','2024-01-20 10:08:33.000000',NULL,'c297cab115484126b4181153c1c08918'),(39,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc0NTQ0MiwiaWF0IjoxNzA1NjU5MDQyLCJqdGkiOiIwMjVkMTg0NWYwMzc0ZTM3ODhlNGMzMjc0NWIyNmE4ZiIsInVzZXJfaWQiOjE2fQ.BQ7QA6RZOJTepYjI2-mSC6rQDulXwbru8GQDGH9rYjI','2024-01-19 10:10:42.399729','2024-01-20 10:10:42.000000',NULL,'025d1845f0374e3788e4c32745b26a8f'),(40,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc0NjA1MywiaWF0IjoxNzA1NjU5NjUzLCJqdGkiOiI5Y2FiNjY2ZWYwOGE0MTAxYjYwODljOWUzNzE0M2MyNCIsInVzZXJfaWQiOjE2fQ.039ko7MeP_fomVAJxxIhiMm7QGs0shKG-6GtXipdWow','2024-01-19 10:20:53.606302','2024-01-20 10:20:53.000000',NULL,'9cab666ef08a4101b6089c9e37143c24'),(41,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc0NjI0NSwiaWF0IjoxNzA1NjU5ODQ1LCJqdGkiOiIxMmFjODZkZjExMzU0MGVlYWQzMmU0Y2IzZWYwZjQ3NyIsInVzZXJfaWQiOjE2fQ.sQKGp5tFntBnhwO_ZyGSyEqOeAW22u_E_A9jx7j_Ch0','2024-01-19 10:24:05.883505','2024-01-20 10:24:05.000000',NULL,'12ac86df113540eead32e4cb3ef0f477'),(42,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc1MDUxOCwiaWF0IjoxNzA1NjY0MTE4LCJqdGkiOiIzZTU1ZGFjNGE2OGU0OTQ4OWVjYmUwMGE2NDU1ZDJiNSIsInVzZXJfaWQiOjF9.uaiTEE0DyjYnajEjcKv39yyqncMMvMFwMyeb_5DZxtA','2024-01-19 11:35:18.565978','2024-01-20 11:35:18.000000',1,'3e55dac4a68e49489ecbe00a6455d2b5'),(43,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc1MTQwNSwiaWF0IjoxNzA1NjY1MDA1LCJqdGkiOiIzNTBjYmUzOWI2NDQ0N2U1YjZmNzE1YTFkYjYwZjg2NSIsInVzZXJfaWQiOjE2fQ.48dwoXhzaokX7z9nPjZPzTsTf3-NKexazhC6wkBAhtE','2024-01-19 11:50:05.843848','2024-01-20 11:50:05.000000',NULL,'350cbe39b64447e5b6f715a1db60f865'),(44,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc1MTc4NSwiaWF0IjoxNzA1NjY1Mzg1LCJqdGkiOiI1OTMzMGIwYWZhMzQ0YTJlOGRmMjgyM2VlMTg3NWEwOSIsInVzZXJfaWQiOjF9.VHl8rYPSByRxfnDvkVSwfHqjSmK9bTUQCXQSJlpyg2U','2024-01-19 11:56:25.783934','2024-01-20 11:56:25.000000',1,'59330b0afa344a2e8df2823ee1875a09'),(45,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc1MTk1NywiaWF0IjoxNzA1NjY1NTU3LCJqdGkiOiIzYmQzZmY4ZDY1ODU0MDUyODc2ZWMzYzhiMTQxZjk3OCIsInVzZXJfaWQiOjF9.RE7VGMPfOXwIHn-ugqe6J55Fk-siS2cNJIns0JpXdgM','2024-01-19 11:59:17.651778','2024-01-20 11:59:17.000000',1,'3bd3ff8d65854052876ec3c8b141f978'),(46,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc1MjI1MSwiaWF0IjoxNzA1NjY1ODUxLCJqdGkiOiJjNmYwZTk2NjlmNmM0YzJhOTc4Yjc1NTgyMmQyZDhmZCIsInVzZXJfaWQiOjF9.gG3aw-_2E7jRwIT1B5DtQ3M7hp9Clf66rPiHO75xETI','2024-01-19 12:04:11.109504','2024-01-20 12:04:11.000000',1,'c6f0e9669f6c4c2a978b755822d2d8fd'),(47,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc1MjI3NiwiaWF0IjoxNzA1NjY1ODc2LCJqdGkiOiJjNWY5YmYyYzgyYmQ0MzFmYmM5NmQ0ZjFlOGY2OGY2MiIsInVzZXJfaWQiOjF9.c9CNQE2Be5NPPB5zB-MmevIsOFC4CcouaIhs8ZDVROE','2024-01-19 12:04:36.198914','2024-01-20 12:04:36.000000',1,'c5f9bf2c82bd431fbc96d4f1e8f68f62'),(48,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc1MjMwMCwiaWF0IjoxNzA1NjY1OTAwLCJqdGkiOiJlZTNlNTAwZTY3ZDM0OWMwODQ5ZDNlMzUxZjM5NDZlMiIsInVzZXJfaWQiOjF9.G8z9jRmVcEjP8yUMihgTUdf6VTV2t2DUSjqndeSzOwc','2024-01-19 12:05:00.064280','2024-01-20 12:05:00.000000',1,'ee3e500e67d349c0849d3e351f3946e2'),(49,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc1MjMxNiwiaWF0IjoxNzA1NjY1OTE2LCJqdGkiOiJmMzc3YzE4NGI0YzY0ZjUyOTQxNWY2NzNiOGZlNWMxNSIsInVzZXJfaWQiOjF9.2iHWQRvLPU27uLXLMRZHolvf_4Xdj7HOSDhz4p0RZbE','2024-01-19 12:05:16.244857','2024-01-20 12:05:16.000000',1,'f377c184b4c64f529415f673b8fe5c15'),(50,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc1MjYxMiwiaWF0IjoxNzA1NjY2MjEyLCJqdGkiOiI5MDExYjNiZDg5MDc0NGNlOTVkOGIwOWIwZTY3MWY3YSIsInVzZXJfaWQiOjI4fQ.1G25anzBasq6i2I42Yz8cZuaFrgtWfwT0VlPIMgcsrU','2024-01-19 12:10:12.578722','2024-01-20 12:10:12.000000',28,'9011b3bd890744ce95d8b09b0e671f7a'),(51,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc1MjY3NiwiaWF0IjoxNzA1NjY2Mjc2LCJqdGkiOiIyM2VkZTBlMzFlNTk0ZGM1YjNkZDdjOGQxNjk2NTA5NyIsInVzZXJfaWQiOjF9.OiV2BX_UYty_zEkEFYcvwoN0u7cZckjdZSDw2MzVUtI','2024-01-19 12:11:16.312095','2024-01-20 12:11:16.000000',1,'23ede0e31e594dc5b3dd7c8d16965097'),(52,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTc1NjkyNiwiaWF0IjoxNzA1NjcwNTI2LCJqdGkiOiI5YWZmMjE2YTIzMjk0MmJjODI3NGJjMGU0ZGM4NTQ1YyIsInVzZXJfaWQiOjF9.sUWpXd-8ubqyZ4Ai5vxaNOMHrSSIjH7l91_O-ssVyWQ','2024-01-19 13:22:06.615599','2024-01-20 13:22:06.000000',1,'9aff216a232942bc8274bc0e4dc8545c');
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-20 16:50:22
