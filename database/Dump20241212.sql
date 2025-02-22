-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (arm64)
--
-- Host: localhost    Database: diabecheckv2
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `File`
--

DROP TABLE IF EXISTS `File`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `File` (
  `IdFile` int NOT NULL AUTO_INCREMENT,
  `IdPatient` int NOT NULL,
  `FilePath` varchar(400) NOT NULL,
  `PublishDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IdUser` int NOT NULL,
  `Active` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FileType` int NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IdFile`),
  UNIQUE KEY `IdFile_UNIQUE` (`IdFile`),
  KEY `IdPatient_idx` (`IdPatient`),
  KEY `IdUser_idx` (`IdUser`),
  KEY `FK_IdFileType_IdFileType_idx` (`FileType`),
  CONSTRAINT `FK_IdPatient_IdUser` FOREIGN KEY (`IdPatient`) REFERENCES `User` (`IdUser`),
  CONSTRAINT `FK_IdFileType_IdFileType` FOREIGN KEY (`FileType`) REFERENCES `FileType` (`IdFileType`),
  CONSTRAINT `FK_IdUser_IdUser` FOREIGN KEY (`IdUser`) REFERENCES `User` (`IdUser`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File`
--

LOCK TABLES `File` WRITE;
/*!40000 ALTER TABLE `File` DISABLE KEYS */;
INSERT INTO `File` VALUES (1,2,'0.png','2024-10-12 15:46:43',3,0,'2024-10-12 15:46:43','2024-10-12 15:46:43',1,'Prueba'),(12,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-10-17T20%3A42%3A36.030Z?alt=media&token=dcdb7eb0-dbea-4c72-a60d-81dbf9096b4f','2024-10-17 20:42:39',3,0,'2024-10-17 17:42:39','2024-10-17 17:42:39',3,'test'),(13,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-10-17T22%3A12%3A57.617Z?alt=media&token=5cb702b0-52b3-44cc-bb2f-a0730826715a','2024-10-17 22:13:02',3,0,'2024-10-17 19:13:02','2024-10-17 19:13:02',1,'test'),(14,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-10-17T22%3A20%3A18.784Z?alt=media&token=2c01a9b0-1f41-4a17-8558-5fd57f6cbaf2','2024-10-17 22:20:21',3,0,'2024-10-17 19:20:21','2024-10-17 19:20:21',4,'test'),(15,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-10-17T22%3A33%3A13.047Z?alt=media&token=c4df61e2-ba91-49fe-b2c1-5120d1bf67f9','2024-10-17 22:33:15',3,0,'2024-10-17 19:33:15','2024-10-17 19:33:15',1,'Prueba'),(16,6,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F6%2F2024-10-17T22%3A57%3A24.862Z?alt=media&token=bbd7f61f-c913-4480-8edb-7dd3b50f601a','2024-10-17 22:57:29',3,1,'2024-10-17 19:57:28','2024-10-17 19:57:28',1,'Prueba 3'),(17,6,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F6%2F2024-10-17T23%3A12%3A36.103Z?alt=media&token=5022209d-b216-403a-90af-6cddb858a8f8','2024-10-17 23:12:39',3,1,'2024-10-17 20:13:15','2024-10-17 20:13:15',2,'Pruebas'),(18,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 17:50:59',2,0,'2024-10-24 14:51:03','2024-10-24 14:51:03',1,'File 1'),(19,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-10-24 15:14:54','2024-10-24 15:14:54',1,'File 2'),(20,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-29T17%3A57%3A12.942Z?alt=media&token=16f93222-baa3-442b-9651-ec002e708486','2024-10-29 17:57:14',5,0,'2024-10-29 14:57:16','2024-10-29 14:57:16',4,'File de prueba'),(21,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-10-29 15:50:24','2024-10-29 15:50:24',1,'File 2'),(22,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-10-29 15:50:24','2024-10-29 15:50:24',1,'File 2'),(23,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-10-29 15:50:24','2024-10-29 15:50:24',1,'File 2'),(24,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-10-29 15:50:24','2024-10-29 15:50:24',1,'File 2'),(25,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:09:54','2024-11-01 16:09:54',1,'File 2'),(26,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:09:54','2024-11-01 16:09:54',1,'File 2'),(27,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:09:54','2024-11-01 16:09:54',1,'File 2'),(28,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:09:55','2024-11-01 16:09:55',1,'File 2'),(29,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,1,'2024-11-01 16:20:32','2024-11-01 16:20:32',1,'File 3'),(30,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:20:32','2024-11-01 16:20:32',1,'File 4'),(31,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:20:32','2024-11-01 16:20:32',1,'File 2'),(32,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:20','2024-11-01 16:27:20',1,'File 2'),(33,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:20','2024-11-01 16:27:20',1,'File 2'),(34,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:20','2024-11-01 16:27:20',1,'File 2'),(35,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:57','2024-11-01 16:27:57',1,'File 2'),(36,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:57','2024-11-01 16:27:57',1,'File 2'),(37,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:57','2024-11-01 16:27:57',1,'File 2'),(38,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:29:34','2024-11-01 16:29:34',1,'File 2'),(39,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:29:35','2024-11-01 16:29:35',1,'File 2'),(40,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:29:35','2024-11-01 16:29:35',1,'File 2'),(41,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-11-05T23%3A25%3A02.023Z?alt=media&token=963a723a-55f3-4372-90f6-aa256df19bc6','2024-11-05 23:25:04',2,1,'2024-11-05 20:25:07','2024-11-05 20:25:07',2,'prueba 2'),(42,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-11-06T00%3A35%3A41.276Z?alt=media&token=6eb397e2-94e9-4757-822c-0b76e9143fe9','2024-11-06 00:35:43',2,0,'2024-11-05 21:35:42','2024-11-05 21:35:42',2,'prueba 2'),(43,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-02T23%3A02%3A13.242Z?alt=media&token=d2429df8-96eb-44b5-94c2-f4a215356d35','2024-12-02 23:02:15',3,0,'2024-12-02 20:02:15','2024-12-02 20:02:15',1,'pruebaaa'),(44,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-02T23%3A56%3A12.568Z?alt=media&token=81b2f538-81ff-4aac-b560-6bf8df362398','2024-12-02 23:56:13',3,0,'2024-12-02 20:56:14','2024-12-02 20:56:14',1,'aaa'),(45,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T13%3A55%3A31.460Z?alt=media&token=54a468bb-23a9-4bf1-a212-a59b43c2f36b','2024-12-03 13:55:34',3,1,'2024-12-03 10:55:36','2024-12-03 10:55:36',1,'aaaa'),(46,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T13%3A56%3A48.725Z?alt=media&token=e9ec6573-06d7-42ac-a885-c3827a8f4806','2024-12-03 13:56:54',3,1,'2024-12-03 10:56:57','2024-12-03 10:56:57',2,'aaaa'),(47,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T19%3A42%3A48.712Z?alt=media&token=2a916d48-ec9d-43fd-8865-52b180dfc35f','2024-12-03 19:42:51',3,1,'2024-12-03 16:42:54','2024-12-03 16:42:54',2,'a'),(48,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T19%3A46%3A52.333Z?alt=media&token=b5bc56ac-b630-431d-807b-e6a3fe726b6a','2024-12-03 19:46:53',3,1,'2024-12-03 16:46:56','2024-12-03 16:46:56',1,'aaaa'),(49,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T19%3A48%3A21.985Z?alt=media&token=ebfffa44-b3ea-474a-bddd-6bbf6572d290','2024-12-03 19:48:24',3,0,'2024-12-03 16:48:26','2024-12-03 16:48:26',3,'aaa'),(50,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T19%3A49%3A14.006Z?alt=media&token=efc1fc1f-12d6-44af-8d91-9f3d113a4285','2024-12-03 19:49:16',3,0,'2024-12-03 16:49:19','2024-12-03 16:49:19',1,'prueba'),(51,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T20%3A12%3A49.597Z?alt=media&token=fd16d24a-6be3-44a0-a72c-fe81e9d8ca5a','2024-12-03 20:12:52',3,0,'2024-12-03 17:12:52','2024-12-03 17:12:52',2,'aa'),(52,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T20%3A14%3A10.710Z?alt=media&token=4a814e4d-b8ac-430f-b2fd-d38cb0d58c9c','2024-12-03 20:14:13',3,0,'2024-12-03 17:14:12','2024-12-03 17:14:12',1,'aaaa'),(53,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-05T15%3A03%3A14.759Z?alt=media&token=76e2a356-86c2-44b8-8eba-c872b4718a94','2024-12-05 15:03:16',3,0,'2024-12-05 12:03:19','2024-12-05 12:03:19',1,'aaa'),(54,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-06T14%3A20%3A30.359Z?alt=media&token=cd81a57d-1069-44b3-80f2-9af67aea3052','2024-12-06 14:20:32',3,1,'2024-12-06 11:20:32','2024-12-06 11:20:32',4,'Prueba hoy'),(55,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-12-06T15%3A15%3A37.951Z?alt=media&token=d4b60c87-9e58-419a-b999-028dff5530bb','2024-12-06 15:15:43',3,0,'2024-12-06 12:15:43','2024-12-06 12:15:43',3,'test');
/*!40000 ALTER TABLE `File` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Healthcare`
--

DROP TABLE IF EXISTS `Healthcare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Healthcare` (
  `IdHealthcare` int NOT NULL AUTO_INCREMENT,
  `Description` varchar(100) NOT NULL,
  `Active` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdHealthcare`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Healthcare`
--

LOCK TABLES `Healthcare` WRITE;
/*!40000 ALTER TABLE `Healthcare` DISABLE KEYS */;
INSERT INTO `Healthcare` VALUES (1,'Osde',1,'2024-08-22 20:53:16','2024-08-22 20:53:16'),(2,'Medife',1,'2024-08-22 20:53:20','2024-08-22 20:53:20'),(3,'Swiss Medical',1,'2024-08-22 20:53:26','2024-08-22 20:53:26');
/*!40000 ALTER TABLE `Healthcare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DoctorPatientConnection`
--

DROP TABLE IF EXISTS `DoctorPatientConnection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DoctorPatientConnection` (
  `IdDoctorPatientConnection` int NOT NULL AUTO_INCREMENT,
  `IdDoctor` int NOT NULL,
  `IdPatient` int NOT NULL,
  `Active` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` varchar(45) NOT NULL,
  PRIMARY KEY (`IdDoctorPatientConnection`),
  KEY `FK_DoctorPatientConnection_idx` (`IdDoctor`),
  KEY `FK_DoctorPatientConnection_2_idx` (`IdPatient`),
  CONSTRAINT `FK_Doctor` FOREIGN KEY (`IdDoctor`) REFERENCES `User` (`IdUser`),
  CONSTRAINT `FK_Paciente` FOREIGN KEY (`IdPatient`) REFERENCES `User` (`IdUser`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DoctorPatientConnection`
--

LOCK TABLES `DoctorPatientConnection` WRITE;
/*!40000 ALTER TABLE `DoctorPatientConnection` DISABLE KEYS */;
INSERT INTO `DoctorPatientConnection` VALUES (1,3,2,1,'2024-08-22 20:56:09','2024-08-22 20:56:09','rechazada'),(2,3,4,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(3,3,6,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(4,3,7,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(5,5,8,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(6,5,2,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(7,9,6,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(8,9,4,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','rechazada'),(13,3,2,1,'2024-10-29 15:19:52','2024-10-29 15:19:52','aceptada'),(21,9,4,1,'2024-11-01 16:29:02','2024-11-01 16:29:02','rechazada'),(22,9,2,0,'2024-11-05 21:49:02','2024-11-05 21:49:02','aceptada'),(24,9,2,1,'2024-12-06 16:54:22','2024-12-06 16:54:22','aceptada');
/*!40000 ALTER TABLE `DoctorPatientConnection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Diagnosis`
--

DROP TABLE IF EXISTS `Diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Diagnosis` (
  `IdDiagnosis` int NOT NULL AUTO_INCREMENT,
  `Description` varchar(100) NOT NULL,
  `Active` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdDiagnosis`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Diagnosis`
--

LOCK TABLES `Diagnosis` WRITE;
/*!40000 ALTER TABLE `Diagnosis` DISABLE KEYS */;
INSERT INTO `Diagnosis` VALUES (1,'Tipo 1',1,'2024-08-22 20:51:12','2024-08-22 20:51:12'),(2,'Tipo 2',1,'2024-08-22 20:51:17','2024-08-22 20:51:17'),(3,'Pre Diabetes',1,'2024-08-22 20:51:29','2024-08-22 20:51:29'),(4,'Gestacional',1,'2024-08-22 20:51:35','2024-08-22 20:51:35');
/*!40000 ALTER TABLE `Diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DoctorLicense`
--

DROP TABLE IF EXISTS `DoctorLicense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DoctorLicense` (
  `IdDoctorLicense` int NOT NULL AUTO_INCREMENT,
  `DoctorLicense` varchar(100) NOT NULL,
  `DocumentNumber` varchar(15) NOT NULL,
  `Active` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdDoctorLicense`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DoctorLicense`
--

LOCK TABLES `DoctorLicense` WRITE;
/*!40000 ALTER TABLE `DoctorLicense` DISABLE KEYS */;
INSERT INTO `DoctorLicense` VALUES (1,'1','0000002',1,'2024-08-22 20:48:38','2024-08-22 20:48:38'),(2,'2','0000004',1,'2024-09-03 21:30:03','2024-09-03 21:30:03'),(3,'3','0000008',1,'2024-09-03 21:30:03','2024-09-03 21:30:03');
/*!40000 ALTER TABLE `DoctorLicense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PatientMeasure`
--

DROP TABLE IF EXISTS `PatientMeasure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PatientMeasure` (
  `IdPatientMeasure` int NOT NULL AUTO_INCREMENT,
  `IdPatient` int NOT NULL,
  `MeasureDate` datetime NOT NULL,
  `Glucose` float DEFAULT '0',
  `Insulin` float DEFAULT '0',
  `Carbohidrates` float DEFAULT '0',
  `Active` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdPatientMeasure`),
  KEY `FK_PatientMeasure_idx` (`IdPatient`),
  CONSTRAINT `FK_PatientMeasure` FOREIGN KEY (`IdPatient`) REFERENCES `AdditionalInfoPatient` (`IdAdditionalInfoPatient`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PatientMeasure`
--

LOCK TABLES `PatientMeasure` WRITE;
/*!40000 ALTER TABLE `PatientMeasure` DISABLE KEYS */;
INSERT INTO `PatientMeasure` VALUES (1,2,'2024-08-27 00:00:00',120.5,30,50,1,'2024-08-27 15:11:43','2024-08-27 15:11:43'),(2,2,'2024-08-27 00:00:00',120.5,30,50,1,'2024-08-27 15:13:24','2024-08-27 15:13:24'),(3,2,'2024-08-27 00:00:00',120.5,30,50,1,'2024-08-27 15:15:45','2024-08-27 15:15:45'),(4,2,'2024-08-27 00:00:00',120.5,30,50,1,'2024-09-01 21:50:48','2024-09-01 21:50:48'),(5,4,'2024-09-02 00:49:17',120,6,120.1,1,'2024-09-01 21:53:21','2024-09-01 21:53:21'),(6,2,'2024-10-01 00:00:01',121,6,120,1,'2024-09-18 15:55:52','2024-09-18 15:55:52'),(7,2,'2024-08-13 12:00:00',117,5,123,1,'2024-09-18 19:14:18','2024-09-18 19:14:18'),(8,4,'2024-09-19 21:21:29',120,5,100,1,'2024-09-19 18:30:54','2024-09-19 18:30:54'),(9,4,'2024-09-19 23:21:00',100,NULL,NULL,1,'2024-09-19 18:33:17','2024-09-19 18:33:17'),(10,2,'2024-09-20 18:09:41',100,5,101,1,'2024-09-20 15:11:19','2024-09-20 15:11:19'),(11,2,'2024-09-20 18:09:41',100,7,122,1,'2024-09-20 15:13:49','2024-09-20 15:13:49'),(12,2,'2024-09-20 18:09:41',100,8,100,1,'2024-09-20 15:14:25','2024-09-20 15:14:25'),(13,2,'2024-09-20 18:17:23',111,5,111,1,'2024-09-20 15:18:21','2024-09-20 15:18:21'),(14,2,'2024-09-20 18:30:15',100,5,200,1,'2024-09-20 15:30:31','2024-09-20 15:30:31'),(15,2,'2024-09-23 18:02:45',100,5,123,1,'2024-09-23 15:02:56','2024-09-23 15:02:56'),(16,2,'2024-10-12 20:09:48',90,3,60,1,'2024-10-12 17:12:53','2024-10-12 17:12:53'),(17,2,'2024-10-12 20:09:48',65,NULL,NULL,1,'2024-10-12 17:24:29','2024-10-12 17:24:29'),(18,2,'2024-10-12 20:09:48',92,NULL,NULL,1,'2024-10-12 17:26:29','2024-10-12 17:26:29'),(19,2,'2024-10-12 20:09:48',124,0,0,1,'2024-10-12 17:28:26','2024-10-12 17:28:26'),(25,2,'2024-10-29 17:59:50',100,2,120,1,'2024-10-29 15:00:06','2024-10-29 15:00:06'),(26,2,'2024-10-10 10:00:00',120,15,40,1,'2024-10-29 15:41:07','2024-10-29 15:41:07'),(27,2,'2024-10-10 10:00:00',120,15,40,1,'2024-10-29 15:41:07','2024-10-29 15:41:07'),(28,2,'2024-10-10 10:00:00',120,15,40,1,'2024-10-29 15:41:07','2024-10-29 15:41:07'),(29,2,'2024-10-10 10:00:00',120,15,40,1,'2024-10-29 15:41:07','2024-10-29 15:41:07'),(30,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:03:32','2024-11-01 16:03:32'),(31,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:03:32','2024-11-01 16:03:32'),(32,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:03:32','2024-11-01 16:03:32'),(33,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:03:32','2024-11-01 16:03:32'),(34,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:05:06','2024-11-01 16:05:06'),(35,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:05:07','2024-11-01 16:05:07'),(36,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:05:07','2024-11-01 16:05:07'),(37,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:05:07','2024-11-01 16:05:07'),(38,2,'2024-11-05 23:13:50',100,5,120,1,'2024-11-05 20:14:48','2024-11-05 20:14:48'),(39,2,'2024-11-06 00:07:51',120,4,0,1,'2024-11-05 21:17:58','2024-11-05 21:17:58'),(40,2,'2024-12-05 15:17:14',100,5,120,1,'2024-12-05 12:17:29','2024-12-05 12:17:29'),(41,2,'2024-12-05 15:20:55',120,0,0,1,'2024-12-05 12:21:02','2024-12-05 12:21:02');
/*!40000 ALTER TABLE `PatientMeasure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AdditionalInfoDoctor`
--

DROP TABLE IF EXISTS `AdditionalInfoDoctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AdditionalInfoDoctor` (
  `IdAdditionalInfoDoctor` int NOT NULL AUTO_INCREMENT,
  `IdUser` int NOT NULL,
  `Speciality` varchar(100) NOT NULL,
  `IdDoctorLicense` int NOT NULL,
  `Active` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdAdditionalInfoDoctor`),
  KEY `FK_AdditionalInfoDoctor_User` (`IdUser`),
  KEY `FK_DoctorsInfoAdicioanl_DoctorLicense` (`IdDoctorLicense`),
  CONSTRAINT `FK_AdditionalInfoDoctor` FOREIGN KEY (`IdUser`) REFERENCES `User` (`IdUser`),
  CONSTRAINT `FK_AdditionalInfoDoctor_2` FOREIGN KEY (`IdDoctorLicense`) REFERENCES `DoctorLicense` (`IdDoctorLicense`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdditionalInfoDoctor`
--

LOCK TABLES `AdditionalInfoDoctor` WRITE;
/*!40000 ALTER TABLE `AdditionalInfoDoctor` DISABLE KEYS */;
INSERT INTO `AdditionalInfoDoctor` VALUES (1,3,'Diabetologo',1,1,'2024-08-22 20:49:41','2024-08-22 20:49:41'),(3,5,'Diabetologo',2,1,'2024-09-03 21:30:57','2024-09-03 21:30:57'),(4,9,'Nutricionista',3,1,'2024-09-03 21:30:57','2024-09-03 21:30:57');
/*!40000 ALTER TABLE `AdditionalInfoDoctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AdditionalInfoPatient`
--

DROP TABLE IF EXISTS `AdditionalInfoPatient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AdditionalInfoPatient` (
  `IdAdditionalInfoPatient` int NOT NULL AUTO_INCREMENT,
  `IdUser` int NOT NULL,
  `IdHealthcare` int NOT NULL,
  `Weight` int NOT NULL,
  `Height` int NOT NULL,
  `IdDiagnosis` int NOT NULL,
  `DateLastCheckUp` date NOT NULL,
  `Active` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdAdditionalInfoPatient`),
  KEY `FK_AdditionalInfoPatient_User` (`IdUser`),
  KEY `FK_AdditionalInfoPatient_Healthcare` (`IdHealthcare`),
  KEY `FK_AdditionalInfoPatient_Diagnosis` (`IdDiagnosis`),
  CONSTRAINT `FK_AdditionalInfoPatient` FOREIGN KEY (`IdUser`) REFERENCES `User` (`IdUser`),
  CONSTRAINT `FK_AdditionalInfoPatient_2` FOREIGN KEY (`IdHealthcare`) REFERENCES `Healthcare` (`IdHealthcare`),
  CONSTRAINT `FK_AdditionalInfoPatient_3` FOREIGN KEY (`IdDiagnosis`) REFERENCES `Diagnosis` (`IdDiagnosis`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdditionalInfoPatient`
--

LOCK TABLES `AdditionalInfoPatient` WRITE;
/*!40000 ALTER TABLE `AdditionalInfoPatient` DISABLE KEYS */;
INSERT INTO `AdditionalInfoPatient` VALUES (1,2,1,80,190,1,'2024-08-22',1,'2024-08-22 20:54:56','2024-08-22 20:54:56'),(2,4,1,65,165,1,'2024-08-30',1,'2024-09-03 21:33:38','2024-09-03 21:33:38'),(3,6,2,93,175,2,'2024-07-22',1,'2024-09-03 21:33:38','2024-09-03 21:33:38'),(4,7,2,78,172,3,'2024-06-12',1,'2024-09-03 21:33:38','2024-09-03 21:33:38'),(5,8,3,51,162,4,'2024-09-01',1,'2024-09-03 21:33:38','2024-09-03 21:33:38');
/*!40000 ALTER TABLE `AdditionalInfoPatient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Role` (
  `IdRolee` int NOT NULL AUTO_INCREMENT,
  `Description` varchar(100) NOT NULL,
  `Active` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdRolee`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` VALUES (1,'Administrador',1,'2024-08-22 20:36:40','2024-08-22 20:36:40'),(2,'Paciente',1,'2024-08-22 20:36:48','2024-08-22 20:36:48'),(3,'Doctor',1,'2024-08-22 20:36:55','2024-08-22 20:36:55');
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FileType`
--

DROP TABLE IF EXISTS `FileType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FileType` (
  `IdFileType` int NOT NULL AUTO_INCREMENT,
  `Description` varchar(45) NOT NULL,
  `Active` varchar(45) NOT NULL DEFAULT '1',
  PRIMARY KEY (`IdFileType`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FileType`
--

LOCK TABLES `FileType` WRITE;
/*!40000 ALTER TABLE `FileType` DISABLE KEYS */;
INSERT INTO `FileType` VALUES (1,'Planilla','1'),(2,'Receta','1'),(3,'Estudio','1'),(4,'Extraccion de sangre','1');
/*!40000 ALTER TABLE `FileType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `IdUser` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `DocumentNumber` varchar(15) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `BirthDate` date NOT NULL,
  `PicturePath` varchar(100) NOT NULL DEFAULT '0.png',
  `IdRolee` int NOT NULL,
  `Active` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdUser`),
  KEY `FK_User_Role` (`IdRolee`),
  CONSTRAINT `FK_User` FOREIGN KEY (`IdRolee`) REFERENCES `Role` (`IdRolee`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'Admin','Admin','00000000','admin@diabecheck.com','2001-09-27','0.png',1,1,'2024-08-22 20:39:38','2024-08-22 20:39:38'),(2,'Paciente','Uno','0000001','paciente01@gmail.com','1991-08-14','0.png',2,1,'2024-08-22 20:46:01','2024-08-22 20:46:01'),(3,'Doctor','Uno','0000002','Doctor01@gmail.com','1982-05-09','0.png',3,1,'2024-08-22 20:46:25','2024-08-22 20:46:25'),(4,'Paciente','Dos','0000003','Paciente02@gmail.com','1998-05-14','2.png',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(5,'Doctor','Dos','0000004','Doctor02@gmail.com','1993-04-28','0.png',3,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(6,'Paciente','Tres','0000005','Paciente03@gmail.com','1974-06-03','0.png',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(7,'Paciente ','Cuatro','0000006','paciente04@gmail.com','2002-12-16','0.png',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(8,'Paciente','Cinco','0000007','paciente05@gmail.com','1986-10-15','0.png',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(9,'Doctor','Tres','0000008','Doctor03@gmail.com','1971-02-14','0.png',3,1,'2024-09-03 21:24:49','2024-09-03 21:24:49');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'diabecheckv2'
--
/*!50003 DROP PROCEDURE IF EXISTS `DelFile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DelFile`(IdFileDel INT)
BEGIN
	UPDATE File SET Active = 0 WHERE IdFile =IdFileDel;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPatientFiles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientFiles`(IdPatient INT)
SELECT a.IdFile, a.Name, a.FilePath, a.PublishDate, u.LastName CreatorLastName, u.Name CreatorName
	FROM File a
    INNER JOIN User u ON a.IdUser = u.IdUser
    WHERE IdPatient = IdPatient AND a.Active = 1
	ORDER BY PublishDate ASC ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPatientMeasure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientMeasures`(INT idPatient INT, month INT, year INT)
BEGIN
	SELECT m.*, u.Name, u.LastName
    FROM PatientMeasure AS m
    INNER JOIN User AS u ON m.IdPatient = u.IdUser
    WHERE MONTH(Fecha) = month AND YEAR(Fecha) = year AND IdPatient = idPatient AND m.Active = 1
    ORDER BY Fecha ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetDoctorByDoctorLicense` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDoctorByDoctorLicense`(DoctorLicense INT)
BEGIN
	SELECT M.*, u.Name, u.LastName, Lic.*
	FROM AdditionalInfoDoctor M
	INNER JOIN DoctorLicense Lic ON Lic.IdDoctorLicense = M.IdDoctorLicense
    INNER JOIN User u ON M.IdUser = u.IdUser
	WHERE Lic.DoctorLicense = DoctorLicense
    AND M.Active = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetDoctors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDoctors`(idPatient INT)
BEGIN
	SELECT U.LastName, U.Name, U.IdUser, M.IdDoctorLicense, U.PicturePath
	FROM User U 
    INNER JOIN AdditionalInfoDoctor M ON M.IdUser = U.IdUser
    INNER JOIN DoctorPatientConnection C ON C.IdDoctor = U.IdUser
    WHERE C.IdPatient = idPatient AND Status = 'aceptada' AND U.Active = 1 AND C.Active = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPatientDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientDetails`(idPatient INT)
BEGIN
    SELECT u.*, cm.Description AS Healthcare, d.Description AS Diagnosis, padd.Height, padd.Weight, padd.IdAdditionalInfoPatient, padd.DateLastCheckUp
    FROM User AS u 
    INNER JOIN AdditionalInfoPatient AS padd ON padd.IdUser = u.IdUser
    INNER JOIN Diagnosis AS d ON padd.IdDiagnosis = d.IdDiagnosis
    INNER JOIN Healthcare AS cm ON cm.IdHealthcare = padd.IdHealthcare
    WHERE u.IdUser = idPatient AND u.Active =1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPatientsByDoctor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientsByDoctor`(idDoctor INT)
BEGIN
	SELECT u.* , cm.Description AS Healthcare
    FROM DoctorPatientConnection AS c
    INNER JOIN User AS u ON c.IdPatient = u.IdUser
    INNER JOIN AdditionalInfoPatient AS padd on padd.IdUser = u.IdUser
    INNER JOIN Healthcare as cm ON cm.IdHealthcare = padd.IdHealthcare
    WHERE c.IdDoctor = idDoctor AND c.Status = "aceptada" AND c.Active = 1
    ORDER BY u.LastName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetConnectionRequestsByDoctor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetConnectionRequestsByDoctor`(Doctor_id INT)
SELECT C.IdDoctorPatientConnection, U.Name, U.LastName, CM.Description AS "Healthcare", U.BirthDate
	FROM DoctorPatientConnection C
    INNER JOIN AdditionalInfoPatient P ON C.IdPatient = P.IdUser
    INNER JOIN User U ON U.IdUser = P.IdUser
    INNER JOIN Healthcare CM ON CM.IdHealthcare = P.IdHealthcare
    WHERE C.IdDoctor = Doctor_id AND C.Status = "pendiente" AND C.Active =1 ;;
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

-- Dump completed on 2024-12-12 20:07:15
