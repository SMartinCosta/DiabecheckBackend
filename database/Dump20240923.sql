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
  KEY `FK_ConexionesMedicoPaciente_2_idx` (`IdPaciente`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conexionesmedicopaciente`
--

LOCK TABLES `conexionesmedicopaciente` WRITE;
/*!40000 ALTER TABLE `conexionesmedicopaciente` DISABLE KEYS */;
INSERT INTO `conexionesmedicopaciente` VALUES (1,3,2,1,'2024-08-22 20:56:09','2024-08-22 20:56:09','aceptada'),(2,3,4,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(3,3,6,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(4,3,7,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(5,5,8,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(6,5,2,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(7,9,6,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(8,9,4,1,'2024-09-03 21:35:05','2024-09-03 21:35:05','aceptada'),(9,3,1,1,'2024-09-23 17:12:13','2024-09-23 17:12:13','pendiente'),(10,9,2,1,'2024-09-23 17:39:52','2024-09-23 17:39:52','pendiente');
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
  `Glucosa` float DEFAULT NULL,
  `Insulina` float DEFAULT NULL,
  `Carbohidratos` float DEFAULT NULL,
  `Activo` int NOT NULL DEFAULT '1',
  `InsDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdMedicion`),
  KEY `FK_Mediciones_idx` (`IdPaciente`),
  CONSTRAINT `FK_Mediciones` FOREIGN KEY (`IdPaciente`) REFERENCES `pacientesinfoadicional` (`IdPacientesInfoAdicional`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mediciones`
--

LOCK TABLES `mediciones` WRITE;
/*!40000 ALTER TABLE `mediciones` DISABLE KEYS */;
INSERT INTO `mediciones` VALUES (1,1,'2024-08-27 00:00:00',120.5,30,50,1,'2024-08-27 15:11:43','2024-08-27 15:11:43'),(2,1,'2024-08-27 00:00:00',120.5,30,50,1,'2024-08-27 15:13:24','2024-08-27 15:13:24'),(3,1,'2024-08-27 00:00:00',120.5,30,50,1,'2024-08-27 15:15:45','2024-08-27 15:15:45'),(4,1,'2024-08-27 00:00:00',120.5,30,50,1,'2024-09-01 21:50:48','2024-09-01 21:50:48'),(5,2,'2024-09-02 00:49:17',120,6,120.1,1,'2024-09-01 21:53:21','2024-09-01 21:53:21'),(6,1,'2024-10-01 00:00:01',121,6,120,1,'2024-09-18 15:55:52','2024-09-18 15:55:52'),(7,1,'2024-08-13 12:00:00',117,5,123,1,'2024-09-18 19:14:18','2024-09-18 19:14:18'),(8,2,'2024-09-19 21:21:29',120,5,100,1,'2024-09-19 18:30:54','2024-09-19 18:30:54'),(9,2,'2024-09-19 23:21:00',100,NULL,NULL,1,'2024-09-19 18:33:17','2024-09-19 18:33:17'),(10,1,'2024-09-20 18:09:41',100,5,101,1,'2024-09-20 15:11:19','2024-09-20 15:11:19'),(11,1,'2024-09-20 18:09:41',100,7,122,1,'2024-09-20 15:13:49','2024-09-20 15:13:49'),(12,1,'2024-09-20 18:09:41',100,8,100,1,'2024-09-20 15:14:25','2024-09-20 15:14:25'),(13,1,'2024-09-20 18:17:23',111,5,111,1,'2024-09-20 15:18:21','2024-09-20 15:18:21'),(14,1,'2024-09-20 18:30:15',100,5,200,1,'2024-09-20 15:30:31','2024-09-20 15:30:31'),(15,1,'2024-09-23 18:02:45',100,5,123,1,'2024-09-23 15:02:56','2024-09-23 15:02:56');
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
  `RutaFoto` varchar(100) NOT NULL,
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
INSERT INTO `usuarios` VALUES (1,'Admin','Admin','00000000','admin@diabecheck.com','2001-09-27','ruta',1,1,'2024-08-22 20:39:38','2024-08-22 20:39:38'),(2,'Paciente','Uno','0000001','paciente01@gmail.com','1991-08-14','ruta',2,1,'2024-08-22 20:46:01','2024-08-22 20:46:01'),(3,'Medico','Uno','0000002','Medico01@gmail.com','1982-05-09','ruta',3,1,'2024-08-22 20:46:25','2024-08-22 20:46:25'),(4,'Paciente','Dos','0000003','Paciente02@gmail.com','1998-05-14','ruta',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(5,'Medico','Dos','0000004','Medico02@gmail.com','1993-04-28','ruta',3,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(6,'Paciente','Tres','0000005','Paciente03@gmail.com','1974-06-03','ruta',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(7,'Paciente ','Cuatro ','0000006','paciente04@gmail.com','2002-12-16','ruta',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(8,'Paciente','Cinco','0000007','paciente05@gmail.com','1986-10-15','ruta',2,1,'2024-09-03 21:24:49','2024-09-03 21:24:49'),(9,'Medico','Tres','0000008','medico03@gmail.com','1971-02-14','ruta',3,1,'2024-09-03 21:24:49','2024-09-03 21:24:49');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'diabecheckv2'
--
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
    INNER JOIN pacientesinfoadicional AS padd ON mediciones.IdPaciente = padd.IdPacientesInfoAdicional
    INNER JOIN usuarios AS u ON padd.IdUsuario = u.IdUsuario
    WHERE MONTH(Fecha) = month AND YEAR(Fecha) = year AND IdPaciente = pacienteId
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
	SELECT *
	FROM medicosinfoadicional M
	INNER JOIN matriculas Mat ON Mat.IdMatricula = M.IdMatricula
	WHERE Mat.NumeroMatricula = matricula;
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
	SELECT U.Apellido, U.Nombre, U.IdUsuario, M.IdMatricula
    FROM medicosinfoadicional M
	INNER JOIN usuarios U ON M.IdUsuario = U.IdUsuario
    INNER JOIN conexionesmedicopaciente C ON C.IdMedico = U.IdUsuario
    INNER JOIN pacientesinfoadicional P ON P.IdUsuario = C.IdPaciente
    WHERE P.IdPacientesInfoAdicional = pacienteId;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPacienteDetails`(IN pacienteId INT)
BEGIN
    SELECT u.*, cm.Descripcion AS coberturaMedica, d.Descripcion AS diagnostico, padd.Altura, padd.Peso, padd.IdPacientesInfoAdicional
    FROM conexionesmedicopaciente AS c
    INNER JOIN usuarios AS u ON c.IdPaciente = u.IdUsuario
    INNER JOIN pacientesinfoadicional AS padd ON padd.IdUsuario = u.IdUsuario
    INNER JOIN diagnosticos AS d ON padd.idDiagnostico = d.idDiagnostico
    INNER JOIN coberturamedica AS cm ON cm.IdCoberturaMedica = padd.IdCoberturaMedica
    WHERE u.IdUsuario = pacienteId;
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
    WHERE c.IdMedico = medicoId;
END ;;
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

-- Dump completed on 2024-09-23 19:48:54
