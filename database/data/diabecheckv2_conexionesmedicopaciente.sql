-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: diabecheckv2
-- ------------------------------------------------------
-- Server version	8.0.39

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
  PRIMARY KEY (`IdConexionMedicoPaciente`),
  KEY `FK_ConexionMedicoPaciente_Medico` (`IdMedico`),
  KEY `FK_ConexionMedicoPaciente_Paciente` (`IdPaciente`),
  CONSTRAINT `FK_ConexionesMedicoPaciente` FOREIGN KEY (`IdMedico`) REFERENCES `usuarios` (`IdUsuario`),
  CONSTRAINT `FK_ConexionesMedicoPaciente_2` FOREIGN KEY (`IdPaciente`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conexionesmedicopaciente`
--

LOCK TABLES `conexionesmedicopaciente` WRITE;
/*!40000 ALTER TABLE `conexionesmedicopaciente` DISABLE KEYS */;
INSERT INTO `conexionesmedicopaciente` (`IdConexionMedicoPaciente`, `IdMedico`, `IdPaciente`, `Activo`, `InsDate`, `UpdDate`) VALUES (1,3,2,1,'2024-08-22 20:56:09','2024-08-22 20:56:09'),(2,3,4,1,'2024-09-03 21:35:05','2024-09-03 21:35:05'),(3,3,6,1,'2024-09-03 21:35:05','2024-09-03 21:35:05'),(4,3,7,1,'2024-09-03 21:35:05','2024-09-03 21:35:05'),(5,5,8,1,'2024-09-03 21:35:05','2024-09-03 21:35:05'),(6,5,2,1,'2024-09-03 21:35:05','2024-09-03 21:35:05'),(7,9,6,1,'2024-09-03 21:35:05','2024-09-03 21:35:05'),(8,9,4,1,'2024-09-03 21:35:05','2024-09-03 21:35:05');
/*!40000 ALTER TABLE `conexionesmedicopaciente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-03 21:50:09