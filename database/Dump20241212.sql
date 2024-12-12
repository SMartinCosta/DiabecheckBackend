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
-- Table structure for table `archivos`
--

DROP TABLE IF EXISTS `archivos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `archivos` (
  `IdArchivo` int NOT NULL AUTO_INCREMENT,
  `IdPaciente` int NOT NULL,
  `RutaArchivo` varchar(400) NOT NULL,
  `FechaPublicacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IdUsuario` int NOT NULL,
  `Activo` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipoArchivo` int NOT NULL,
  `Nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IdArchivo`),
  UNIQUE KEY `IdArchivo_UNIQUE` (`IdArchivo`),
  KEY `IdPaciente_idx` (`IdPaciente`),
  KEY `IdUsuario_idx` (`IdUsuario`),
  KEY `FK_IdTipoArchivo_IdTipoArchivo_idx` (`tipoArchivo`),
  CONSTRAINT `FK_IdPaciente_IdUsuario` FOREIGN KEY (`IdPaciente`) REFERENCES `usuarios` (`IdUsuario`),
  CONSTRAINT `FK_IdTipoArchivo_IdTipoArchivo` FOREIGN KEY (`tipoArchivo`) REFERENCES `tipoarchivo` (`idtipoArchivo`),
  CONSTRAINT `FK_IdUsuario_IdUsuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archivos`
--

LOCK TABLES `archivos` WRITE;
/*!40000 ALTER TABLE `archivos` DISABLE KEYS */;
INSERT INTO `archivos` VALUES (1,2,'0.png','2024-10-12 15:46:43',3,0,'2024-10-12 15:46:43','2024-10-12 15:46:43',1,'Prueba'),(12,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-10-17T20%3A42%3A36.030Z?alt=media&token=dcdb7eb0-dbea-4c72-a60d-81dbf9096b4f','2024-10-17 20:42:39',3,0,'2024-10-17 17:42:39','2024-10-17 17:42:39',3,'test'),(13,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-10-17T22%3A12%3A57.617Z?alt=media&token=5cb702b0-52b3-44cc-bb2f-a0730826715a','2024-10-17 22:13:02',3,0,'2024-10-17 19:13:02','2024-10-17 19:13:02',1,'test'),(14,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-10-17T22%3A20%3A18.784Z?alt=media&token=2c01a9b0-1f41-4a17-8558-5fd57f6cbaf2','2024-10-17 22:20:21',3,0,'2024-10-17 19:20:21','2024-10-17 19:20:21',4,'test'),(15,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-10-17T22%3A33%3A13.047Z?alt=media&token=c4df61e2-ba91-49fe-b2c1-5120d1bf67f9','2024-10-17 22:33:15',3,0,'2024-10-17 19:33:15','2024-10-17 19:33:15',1,'Prueba'),(16,6,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F6%2F2024-10-17T22%3A57%3A24.862Z?alt=media&token=bbd7f61f-c913-4480-8edb-7dd3b50f601a','2024-10-17 22:57:29',3,1,'2024-10-17 19:57:28','2024-10-17 19:57:28',1,'Prueba 3'),(17,6,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F6%2F2024-10-17T23%3A12%3A36.103Z?alt=media&token=5022209d-b216-403a-90af-6cddb858a8f8','2024-10-17 23:12:39',3,1,'2024-10-17 20:13:15','2024-10-17 20:13:15',2,'Pruebas'),(18,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 17:50:59',2,0,'2024-10-24 14:51:03','2024-10-24 14:51:03',1,'Archivo 1'),(19,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-10-24 15:14:54','2024-10-24 15:14:54',1,'Archivo 2'),(20,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-29T17%3A57%3A12.942Z?alt=media&token=16f93222-baa3-442b-9651-ec002e708486','2024-10-29 17:57:14',5,0,'2024-10-29 14:57:16','2024-10-29 14:57:16',4,'archivo de prueba'),(21,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-10-29 15:50:24','2024-10-29 15:50:24',1,'Archivo 2'),(22,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-10-29 15:50:24','2024-10-29 15:50:24',1,'Archivo 2'),(23,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-10-29 15:50:24','2024-10-29 15:50:24',1,'Archivo 2'),(24,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-10-29 15:50:24','2024-10-29 15:50:24',1,'Archivo 2'),(25,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:09:54','2024-11-01 16:09:54',1,'Archivo 2'),(26,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:09:54','2024-11-01 16:09:54',1,'Archivo 2'),(27,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:09:54','2024-11-01 16:09:54',1,'Archivo 2'),(28,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:09:55','2024-11-01 16:09:55',1,'Archivo 2'),(29,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,1,'2024-11-01 16:20:32','2024-11-01 16:20:32',1,'Archivo 3'),(30,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:20:32','2024-11-01 16:20:32',1,'Archivo 4'),(31,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:20:32','2024-11-01 16:20:32',1,'Archivo 2'),(32,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:20','2024-11-01 16:27:20',1,'Archivo 2'),(33,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:20','2024-11-01 16:27:20',1,'Archivo 2'),(34,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:20','2024-11-01 16:27:20',1,'Archivo 2'),(35,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:57','2024-11-01 16:27:57',1,'Archivo 2'),(36,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:57','2024-11-01 16:27:57',1,'Archivo 2'),(37,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:27:57','2024-11-01 16:27:57',1,'Archivo 2'),(38,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:29:34','2024-11-01 16:29:34',1,'Archivo 2'),(39,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:29:35','2024-11-01 16:29:35',1,'Archivo 2'),(40,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-10-24T17%3A50%3A58.088Z?alt=media&token=5277e43d-fd92-483a-b720-de0b3519d81b','2024-10-24 18:50:59',2,0,'2024-11-01 16:29:35','2024-11-01 16:29:35',1,'Archivo 2'),(41,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-11-05T23%3A25%3A02.023Z?alt=media&token=963a723a-55f3-4372-90f6-aa256df19bc6','2024-11-05 23:25:04',2,1,'2024-11-05 20:25:07','2024-11-05 20:25:07',2,'prueba 2'),(42,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-11-06T00%3A35%3A41.276Z?alt=media&token=6eb397e2-94e9-4757-822c-0b76e9143fe9','2024-11-06 00:35:43',2,0,'2024-11-05 21:35:42','2024-11-05 21:35:42',2,'prueba 2'),(43,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-02T23%3A02%3A13.242Z?alt=media&token=d2429df8-96eb-44b5-94c2-f4a215356d35','2024-12-02 23:02:15',3,0,'2024-12-02 20:02:15','2024-12-02 20:02:15',1,'pruebaaa'),(44,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-02T23%3A56%3A12.568Z?alt=media&token=81b2f538-81ff-4aac-b560-6bf8df362398','2024-12-02 23:56:13',3,0,'2024-12-02 20:56:14','2024-12-02 20:56:14',1,'aaa'),(45,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T13%3A55%3A31.460Z?alt=media&token=54a468bb-23a9-4bf1-a212-a59b43c2f36b','2024-12-03 13:55:34',3,1,'2024-12-03 10:55:36','2024-12-03 10:55:36',1,'aaaa'),(46,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T13%3A56%3A48.725Z?alt=media&token=e9ec6573-06d7-42ac-a885-c3827a8f4806','2024-12-03 13:56:54',3,1,'2024-12-03 10:56:57','2024-12-03 10:56:57',2,'aaaa'),(47,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T19%3A42%3A48.712Z?alt=media&token=2a916d48-ec9d-43fd-8865-52b180dfc35f','2024-12-03 19:42:51',3,1,'2024-12-03 16:42:54','2024-12-03 16:42:54',2,'a'),(48,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T19%3A46%3A52.333Z?alt=media&token=b5bc56ac-b630-431d-807b-e6a3fe726b6a','2024-12-03 19:46:53',3,1,'2024-12-03 16:46:56','2024-12-03 16:46:56',1,'aaaa'),(49,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T19%3A48%3A21.985Z?alt=media&token=ebfffa44-b3ea-474a-bddd-6bbf6572d290','2024-12-03 19:48:24',3,0,'2024-12-03 16:48:26','2024-12-03 16:48:26',3,'aaa'),(50,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T19%3A49%3A14.006Z?alt=media&token=efc1fc1f-12d6-44af-8d91-9f3d113a4285','2024-12-03 19:49:16',3,0,'2024-12-03 16:49:19','2024-12-03 16:49:19',1,'prueba'),(51,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T20%3A12%3A49.597Z?alt=media&token=fd16d24a-6be3-44a0-a72c-fe81e9d8ca5a','2024-12-03 20:12:52',3,0,'2024-12-03 17:12:52','2024-12-03 17:12:52',2,'aa'),(52,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-03T20%3A14%3A10.710Z?alt=media&token=4a814e4d-b8ac-430f-b2fd-d38cb0d58c9c','2024-12-03 20:14:13',3,0,'2024-12-03 17:14:12','2024-12-03 17:14:12',1,'aaaa'),(53,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-05T15%3A03%3A14.759Z?alt=media&token=76e2a356-86c2-44b8-8eba-c872b4718a94','2024-12-05 15:03:16',3,0,'2024-12-05 12:03:19','2024-12-05 12:03:19',1,'aaa'),(54,7,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F7%2F2024-12-06T14%3A20%3A30.359Z?alt=media&token=cd81a57d-1069-44b3-80f2-9af67aea3052','2024-12-06 14:20:32',3,1,'2024-12-06 11:20:32','2024-12-06 11:20:32',4,'Prueba hoy'),(55,2,'https://firebasestorage.googleapis.com/v0/b/diabecheck-c8563.appspot.com/o/documentos%2F2%2F2024-12-06T15%3A15%3A37.951Z?alt=media&token=d4b60c87-9e58-419a-b999-028dff5530bb','2024-12-06 15:15:43',3,0,'2024-12-06 12:15:43','2024-12-06 12:15:43',3,'test');
/*!40000 ALTER TABLE `archivos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coberturamedica`
--

DROP TABLE IF EXISTS `coberturamedica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coberturamedica` (
  `IdCoberturaMedica` int NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(100) NOT NULL,
  `Activo` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdCoberturaMedica`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coberturamedica`
--

LOCK TABLES `coberturamedica` WRITE;
/*!40000 ALTER TABLE `coberturamedica` DISABLE KEYS */;
INSERT INTO `coberturamedica` VALUES (1,'Osde',1,'2024-08-22 20:53:16','2024-08-22 20:53:16'),(2,'Medife',1,'2024-08-22 20:53:20','2024-08-22 20:53:20'),(3,'Swiss Medical',1,'2024-08-22 20:53:26','2024-08-22 20:53:26');
/*!40000 ALTER TABLE `coberturamedica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conexionesmedicopaciente`
--

DROP TABLE IF EXISTS `conexionesmedicopaciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conexionesmedicopaciente` (
  `IdConexionMedicoPaciente` int NOT NULL AUTO_INCREMENT,
  `IdMedico` int NOT NULL,
  `IdPaciente` int NOT NULL,
  `Activo` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`IdConexionMedicoPaciente`),
  KEY `FK_ConexionesMedicoPaciente_idx` (`IdMedico`),
  KEY `FK_ConexionesMedicoPaciente_2_idx` (`IdPaciente`),
  CONSTRAINT `FK_Medico` FOREIGN KEY (`IdMedico`) REFERENCES `usuarios` (`IdUsuario`),
  CONSTRAINT `FK_Paciente` FOREIGN KEY (`IdPaciente`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conexionesmedicopaciente`
--

LOCK TABLES `conexionesmedicopaciente` WRITE;
/*!40000 ALTER TABLE `conexionesmedicopaciente` DISABLE KEYS */;
INSERT INTO `conexionesmedicopaciente` VALUES (1,3,2,1,'2024-08-22 20:56:09','2024-08-22 20:56:09','rechazada'),(2,3,4,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(3,3,6,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(4,3,7,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(5,5,8,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(6,5,2,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(7,9,6,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(8,9,4,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','rechazada'),(13,3,2,1,'2024-10-29 15:19:52','2024-10-29 15:19:52','aceptada'),(21,9,4,1,'2024-11-01 16:29:02','2024-11-01 16:29:02','rechazada'),(22,9,2,0,'2024-11-05 21:49:02','2024-11-05 21:49:02','aceptada'),(24,9,2,1,'2024-12-06 16:54:22','2024-12-06 16:54:22','aceptada');
/*!40000 ALTER TABLE `conexionesmedicopaciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnosticos`
--

DROP TABLE IF EXISTS `diagnosticos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnosticos` (
  `IdDiagnostico` int NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(100) NOT NULL,
  `Activo` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdDiagnostico`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnosticos`
--

LOCK TABLES `diagnosticos` WRITE;
/*!40000 ALTER TABLE `diagnosticos` DISABLE KEYS */;
INSERT INTO `diagnosticos` VALUES (1,'Tipo 1',1,'2024-08-22 20:51:12','2024-08-22 20:51:12'),(2,'Tipo 2',1,'2024-08-22 20:51:17','2024-08-22 20:51:17'),(3,'Pre Diabetes',1,'2024-08-22 20:51:29','2024-08-22 20:51:29'),(4,'Gestacional',1,'2024-08-22 20:51:35','2024-08-22 20:51:35');
/*!40000 ALTER TABLE `diagnosticos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matriculas`
--

DROP TABLE IF EXISTS `matriculas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matriculas` (
  `IdMatricula` int NOT NULL AUTO_INCREMENT,
  `NumeroMatricula` varchar(100) NOT NULL,
  `NroDocumento` varchar(15) NOT NULL,
  `Activo` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdMatricula`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matriculas`
--

LOCK TABLES `matriculas` WRITE;
/*!40000 ALTER TABLE `matriculas` DISABLE KEYS */;
INSERT INTO `matriculas` VALUES (1,'1','0000002',1,'2024-08-22 20:48:38','2024-08-22 20:48:38'),(2,'2','0000004',1,'2024-09-03 21:30:03','2024-09-03 21:30:03'),(3,'3','0000008',1,'2024-09-03 21:30:03','2024-09-03 21:30:03');
/*!40000 ALTER TABLE `matriculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mediciones`
--

DROP TABLE IF EXISTS `mediciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mediciones` (
  `IdMedicion` int NOT NULL AUTO_INCREMENT,
  `IdPaciente` int NOT NULL,
  `Fecha` datetime NOT NULL,
  `Glucosa` float DEFAULT '0',
  `Insulina` float DEFAULT '0',
  `Carbohidratos` float DEFAULT '0',
  `Activo` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdMedicion`),
  KEY `FK_Mediciones_idx` (`IdPaciente`),
  CONSTRAINT `FK_Mediciones` FOREIGN KEY (`IdPaciente`) REFERENCES `pacientesinfoadicional` (`IdPacientesInfoAdicional`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mediciones`
--

LOCK TABLES `mediciones` WRITE;
/*!40000 ALTER TABLE `mediciones` DISABLE KEYS */;
INSERT INTO `mediciones` VALUES (1,2,'2024-08-27 00:00:00',120.5,30,50,1,'2024-08-27 15:11:43','2024-08-27 15:11:43'),(2,2,'2024-08-27 00:00:00',120.5,30,50,1,'2024-08-27 15:13:24','2024-08-27 15:13:24'),(3,2,'2024-08-27 00:00:00',120.5,30,50,1,'2024-08-27 15:15:45','2024-08-27 15:15:45'),(4,2,'2024-08-27 00:00:00',120.5,30,50,1,'2024-09-01 21:50:48','2024-09-01 21:50:48'),(5,4,'2024-09-02 00:49:17',120,6,120.1,1,'2024-09-01 21:53:21','2024-09-01 21:53:21'),(6,2,'2024-10-01 00:00:01',121,6,120,1,'2024-09-18 15:55:52','2024-09-18 15:55:52'),(7,2,'2024-08-13 12:00:00',117,5,123,1,'2024-09-18 19:14:18','2024-09-18 19:14:18'),(8,4,'2024-09-19 21:21:29',120,5,100,1,'2024-09-19 18:30:54','2024-09-19 18:30:54'),(9,4,'2024-09-19 23:21:00',100,NULL,NULL,1,'2024-09-19 18:33:17','2024-09-19 18:33:17'),(10,2,'2024-09-20 18:09:41',100,5,101,1,'2024-09-20 15:11:19','2024-09-20 15:11:19'),(11,2,'2024-09-20 18:09:41',100,7,122,1,'2024-09-20 15:13:49','2024-09-20 15:13:49'),(12,2,'2024-09-20 18:09:41',100,8,100,1,'2024-09-20 15:14:25','2024-09-20 15:14:25'),(13,2,'2024-09-20 18:17:23',111,5,111,1,'2024-09-20 15:18:21','2024-09-20 15:18:21'),(14,2,'2024-09-20 18:30:15',100,5,200,1,'2024-09-20 15:30:31','2024-09-20 15:30:31'),(15,2,'2024-09-23 18:02:45',100,5,123,1,'2024-09-23 15:02:56','2024-09-23 15:02:56'),(16,2,'2024-10-12 20:09:48',90,3,60,1,'2024-10-12 17:12:53','2024-10-12 17:12:53'),(17,2,'2024-10-12 20:09:48',65,NULL,NULL,1,'2024-10-12 17:24:29','2024-10-12 17:24:29'),(18,2,'2024-10-12 20:09:48',92,NULL,NULL,1,'2024-10-12 17:26:29','2024-10-12 17:26:29'),(19,2,'2024-10-12 20:09:48',124,0,0,1,'2024-10-12 17:28:26','2024-10-12 17:28:26'),(25,2,'2024-10-29 17:59:50',100,2,120,1,'2024-10-29 15:00:06','2024-10-29 15:00:06'),(26,2,'2024-10-10 10:00:00',120,15,40,1,'2024-10-29 15:41:07','2024-10-29 15:41:07'),(27,2,'2024-10-10 10:00:00',120,15,40,1,'2024-10-29 15:41:07','2024-10-29 15:41:07'),(28,2,'2024-10-10 10:00:00',120,15,40,1,'2024-10-29 15:41:07','2024-10-29 15:41:07'),(29,2,'2024-10-10 10:00:00',120,15,40,1,'2024-10-29 15:41:07','2024-10-29 15:41:07'),(30,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:03:32','2024-11-01 16:03:32'),(31,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:03:32','2024-11-01 16:03:32'),(32,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:03:32','2024-11-01 16:03:32'),(33,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:03:32','2024-11-01 16:03:32'),(34,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:05:06','2024-11-01 16:05:06'),(35,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:05:07','2024-11-01 16:05:07'),(36,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:05:07','2024-11-01 16:05:07'),(37,2,'2024-10-10 10:00:00',120,15,40,1,'2024-11-01 16:05:07','2024-11-01 16:05:07'),(38,2,'2024-11-05 23:13:50',100,5,120,1,'2024-11-05 20:14:48','2024-11-05 20:14:48'),(39,2,'2024-11-06 00:07:51',120,4,0,1,'2024-11-05 21:17:58','2024-11-05 21:17:58'),(40,2,'2024-12-05 15:17:14',100,5,120,1,'2024-12-05 12:17:29','2024-12-05 12:17:29'),(41,2,'2024-12-05 15:20:55',120,0,0,1,'2024-12-05 12:21:02','2024-12-05 12:21:02');
/*!40000 ALTER TABLE `mediciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicosinfoadicional`
--

DROP TABLE IF EXISTS `medicosinfoadicional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicosinfoadicional` (
  `IdMedicoInfoAdicional` int NOT NULL AUTO_INCREMENT,
  `IdUsuario` int NOT NULL,
  `Especialidad` varchar(100) NOT NULL,
  `IdMatricula` int NOT NULL,
  `Activo` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdMedicoInfoAdicional`),
  KEY `FK_MedicosInfoAdicional_Usuario` (`IdUsuario`),
  KEY `FK_MedicosInfoAdicioanl_Matricula` (`IdMatricula`),
  CONSTRAINT `FK_MedicosInfoAdicional` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  CONSTRAINT `FK_MedicosInfoAdicional_2` FOREIGN KEY (`IdMatricula`) REFERENCES `matriculas` (`IdMatricula`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicosinfoadicional`
--

LOCK TABLES `medicosinfoadicional` WRITE;
/*!40000 ALTER TABLE `medicosinfoadicional` DISABLE KEYS */;
INSERT INTO `medicosinfoadicional` VALUES (1,3,'Diabetologo',1,1,'2024-08-22 20:49:41','2024-08-22 20:49:41'),(3,5,'Diabetologo',2,1,'2024-09-03 21:30:57','2024-09-03 21:30:57'),(4,9,'Nutricionista',3,1,'2024-09-03 21:30:57','2024-09-03 21:30:57');
/*!40000 ALTER TABLE `medicosinfoadicional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pacientesinfoadicional`
--

DROP TABLE IF EXISTS `pacientesinfoadicional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pacientesinfoadicional` (
  `IdPacientesInfoAdicional` int NOT NULL AUTO_INCREMENT,
  `IdUsuario` int NOT NULL,
  `IdCoberturaMedica` int NOT NULL,
  `Peso` int NOT NULL,
  `Altura` int NOT NULL,
  `IdDiagnostico` int NOT NULL,
  `FechaUltimaConsulta` date NOT NULL,
  `Activo` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdPacientesInfoAdicional`),
  KEY `FK_PacientesInfoAdicional_Usuario` (`IdUsuario`),
  KEY `FK_PacientesInfoAdicional_Cobertura` (`IdCoberturaMedica`),
  KEY `FK_PacientesInfoAdicional_Diagnostico` (`IdDiagnostico`),
  CONSTRAINT `FK_PacientesInfoAdicional` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  CONSTRAINT `FK_PacientesInfoAdicional_2` FOREIGN KEY (`IdCoberturaMedica`) REFERENCES `coberturamedica` (`IdCoberturaMedica`),
  CONSTRAINT `FK_PacientesInfoAdicional_3` FOREIGN KEY (`IdDiagnostico`) REFERENCES `diagnosticos` (`IdDiagnostico`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pacientesinfoadicional`
--

LOCK TABLES `pacientesinfoadicional` WRITE;
/*!40000 ALTER TABLE `pacientesinfoadicional` DISABLE KEYS */;
INSERT INTO `pacientesinfoadicional` VALUES (1,2,1,80,190,1,'2024-08-22',1,'2024-08-22 20:54:56','2024-08-22 20:54:56'),(2,4,1,65,165,1,'2024-08-30',1,'2024-09-03 21:33:38','2024-09-03 21:33:38'),(3,6,2,93,175,2,'2024-07-22',1,'2024-09-03 21:33:38','2024-09-03 21:33:38'),(4,7,2,78,172,3,'2024-06-12',1,'2024-09-03 21:33:38','2024-09-03 21:33:38'),(5,8,3,51,162,4,'2024-09-01',1,'2024-09-03 21:33:38','2024-09-03 21:33:38');
/*!40000 ALTER TABLE `pacientesinfoadicional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `IdRol` int NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(100) NOT NULL,
  `Activo` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdRol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador',1,'2024-08-22 20:36:40','2024-08-22 20:36:40'),(2,'Paciente',1,'2024-08-22 20:36:48','2024-08-22 20:36:48'),(3,'Medico',1,'2024-08-22 20:36:55','2024-08-22 20:36:55');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoarchivo`
--

DROP TABLE IF EXISTS `tipoarchivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipoarchivo` (
  `idtipoArchivo` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `Activo` varchar(45) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idtipoArchivo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoarchivo`
--

LOCK TABLES `tipoarchivo` WRITE;
/*!40000 ALTER TABLE `tipoarchivo` DISABLE KEYS */;
INSERT INTO `tipoarchivo` VALUES (1,'Planilla','1'),(2,'Receta','1'),(3,'Estudio','1'),(4,'Extraccion de sangre','1');
/*!40000 ALTER TABLE `tipoarchivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `IdUsuario` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Apellido` varchar(100) NOT NULL,
  `NroDocumento` varchar(15) NOT NULL,
  `email` varchar(45) NOT NULL,
  `FechaNacimiento` date NOT NULL,
  `RutaFoto` varchar(100) NOT NULL DEFAULT '0.png',
  `IdRol` int NOT NULL,
  `Activo` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdUsuario`),
  KEY `FK_Usuarios_Roles` (`IdRol`),
  CONSTRAINT `FK_Usuarios` FOREIGN KEY (`IdRol`) REFERENCES `roles` (`IdRol`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Admin','Admin','00000000','admin@diabecheck.com','2001-09-27','0.png',1,1,'2024-08-22 20:39:38','2024-08-22 20:39:38'),(2,'Paciente','Uno','0000001','paciente01@gmail.com','1991-08-14','0.png',2,1,'2024-08-22 20:46:01','2024-08-22 20:46:01'),(3,'Medico','Uno','0000002','Medico01@gmail.com','1982-05-09','0.png',3,1,'2024-08-22 20:46:25','2024-08-22 20:46:25'),(4,'Paciente','Dos','0000003','Paciente02@gmail.com','1998-05-14','2.png',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(5,'Medico','Dos','0000004','Medico02@gmail.com','1993-04-28','0.png',3,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(6,'Paciente','Tres','0000005','Paciente03@gmail.com','1974-06-03','0.png',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(7,'Paciente ','Cuatro','0000006','paciente04@gmail.com','2002-12-16','0.png',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(8,'Paciente','Cinco','0000007','paciente05@gmail.com','1986-10-15','0.png',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(9,'Medico','Tres','0000008','medico03@gmail.com','1971-02-14','0.png',3,1,'2024-09-03 21:24:49','2024-09-03 21:24:49');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'diabecheckv2'
--
/*!50003 DROP PROCEDURE IF EXISTS `DelArchivo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DelArchivo`(idArchivoDel INT)
BEGIN
	UPDATE archivos SET Activo = 0 WHERE idArchivo =idArchivoDel;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetArchivosPaciente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetArchivosPaciente`(paciente_id INT)
SELECT a.IdArchivo, a.Nombre, a.RutaArchivo, a.FechaPublicacion, u.Apellido ApellidoCreador, u.Nombre NombreCreador
	FROM archivos a
    INNER JOIN usuarios u ON a.IdUsuario = u.IdUsuario
    WHERE idPaciente = paciente_id AND a.Activo = 1
	ORDER BY FechaPublicacion ASC ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMediciones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMediciones`(IN pacienteId INT, month INT, year INT)
BEGIN
	SELECT m.*, u.Nombre, u.Apellido
    FROM mediciones AS m
    INNER JOIN usuarios AS u ON m.IdPaciente = u.IdUsuario
    WHERE MONTH(Fecha) = month AND YEAR(Fecha) = year AND IdPaciente = pacienteId AND m.Activo = 1
    ORDER BY Fecha ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMedicoByMatricula` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMedicoByMatricula`(matricula INT)
BEGIN
	SELECT M.*, u.Nombre, u.Apellido, Mat.*
	FROM medicosinfoadicional M
	INNER JOIN matriculas Mat ON Mat.IdMatricula = M.IdMatricula
    INNER JOIN usuarios u ON M.IdUsuario = u.IdUsuario
	WHERE Mat.NumeroMatricula = matricula
    AND M.Activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMedicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMedicos`(pacienteId INT)
BEGIN
	SELECT U.Apellido, U.Nombre, U.IdUsuario, M.IdMatricula, U.RutaFoto
	FROM usuarios U 
    INNER JOIN medicosinfoadicional M ON M.idUsuario = U.idUsuario
    INNER JOIN conexionesmedicopaciente C ON C.IdMedico = U.IdUsuario
    WHERE C.IdPaciente = pacienteId AND estado = 'aceptada' AND U.Activo = 1 AND C.Activo = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPacienteDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPacienteDetails`(pacienteId INT)
BEGIN
    SELECT u.*, cm.Descripcion AS coberturaMedica, d.Descripcion AS diagnostico, padd.Altura, padd.Peso, padd.IdPacientesInfoAdicional, padd.FechaUltimaConsulta
    FROM usuarios AS u 
    INNER JOIN pacientesinfoadicional AS padd ON padd.IdUsuario = u.IdUsuario
    INNER JOIN diagnosticos AS d ON padd.idDiagnostico = d.idDiagnostico
    INNER JOIN coberturamedica AS cm ON cm.IdCoberturaMedica = padd.IdCoberturaMedica
    WHERE u.IdUsuario = pacienteId AND u.Activo =1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPacientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPacientes`(medicoId INT)
BEGIN
	SELECT u.* , cm.Descripcion AS coberturaMedica
    FROM conexionesmedicopaciente AS c
    INNER JOIN usuarios AS u ON c.IdPaciente = u.IdUsuario
    INNER JOIN pacientesinfoadicional AS padd on padd.IdUsuario = u.IdUsuario
    INNER JOIN coberturamedica as cm ON cm.IdCoberturaMedica = padd.IdCoberturaMedica
    WHERE c.IdMedico = medicoId AND c.estado = "aceptada" AND c.Activo = 1
    ORDER BY u.Apellido;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSolicitudesByMedico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSolicitudesByMedico`(medico_id INT)
SELECT C.IdConexionMedicoPaciente, U.Nombre, U.Apellido, CM.descripcion AS "coberturaMedica", U.FechaNacimiento
	FROM conexionesmedicopaciente C
    INNER JOIN pacientesinfoadicional P ON C.IdPaciente = P.IdUsuario
    INNER JOIN usuarios U ON U.IdUsuario = P.IdUsuario
    INNER JOIN coberturamedica CM ON CM.IdCoberturaMedica = P.IdCoberturaMedica
    WHERE C.IdMedico = medico_id AND C.estado = "pendiente" AND C.Activo =1 ;;
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
