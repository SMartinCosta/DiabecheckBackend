-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema diabecheckv2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema diabecheckv2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `diabecheckv2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `diabecheckv2` ;

-- -----------------------------------------------------
-- Table `diabecheckv2`.`coberturamedica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diabecheckv2`.`coberturamedica` (
  `IdCoberturaMedica` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(100) NOT NULL,
  `Activo` INT NOT NULL DEFAULT '1',
  `InsDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdCoberturaMedica`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `diabecheckv2`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diabecheckv2`.`roles` (
  `IdRol` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(100) NOT NULL,
  `Activo` INT NOT NULL DEFAULT '1',
  `InsDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdRol`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `diabecheckv2`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diabecheckv2`.`usuarios` (
  `IdUsuario` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  `Apellido` VARCHAR(100) NOT NULL,
  `NroDocumento` VARCHAR(15) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `FechaNacimiento` DATE NOT NULL,
  `RutaFoto` VARCHAR(100) NOT NULL,
  `IdRol` INT NOT NULL,
  `Activo` INT NOT NULL DEFAULT '1',
  `InsDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdUsuario`),
  INDEX `FK_Usuarios_Roles` (`IdRol` ASC) VISIBLE,
  CONSTRAINT `FK_Usuarios`
    FOREIGN KEY (`IdRol`)
    REFERENCES `diabecheckv2`.`roles` (`IdRol`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `diabecheckv2`.`conexionesmedicopaciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diabecheckv2`.`conexionesmedicopaciente` (
  `IdConexionMedicoPaciente` INT NOT NULL AUTO_INCREMENT,
  `IdMedico` INT NOT NULL,
  `IdPaciente` INT NOT NULL,
  `Activo` INT NOT NULL DEFAULT '1',
  `InsDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdConexionMedicoPaciente`),
  INDEX `FK_ConexionMedicoPaciente_Medico` (`IdMedico` ASC) VISIBLE,
  INDEX `FK_ConexionMedicoPaciente_Paciente` (`IdPaciente` ASC) VISIBLE,
  CONSTRAINT `FK_ConexionesMedicoPaciente`
    FOREIGN KEY (`IdMedico`)
    REFERENCES `diabecheckv2`.`usuarios` (`IdUsuario`),
  CONSTRAINT `FK_ConexionesMedicoPaciente_2`
    FOREIGN KEY (`IdPaciente`)
    REFERENCES `diabecheckv2`.`usuarios` (`IdUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `diabecheckv2`.`diagnosticos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diabecheckv2`.`diagnosticos` (
  `IdDiagnostico` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(100) NOT NULL,
  `Activo` INT NOT NULL DEFAULT '1',
  `InsDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdDiagnostico`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `diabecheckv2`.`matriculas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diabecheckv2`.`matriculas` (
  `IdMatricula` INT NOT NULL AUTO_INCREMENT,
  `NumeroMatricula` VARCHAR(100) NOT NULL,
  `NroDocumento` VARCHAR(15) NOT NULL,
  `Activo` INT NOT NULL DEFAULT '1',
  `InsDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdMatricula`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `diabecheckv2`.`mediciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diabecheckv2`.`mediciones` (
  `IdMedicion` INT NOT NULL AUTO_INCREMENT,
  `IdPaciente` INT NOT NULL,
  `Fecha` DATETIME NOT NULL,
  `Glucosa` FLOAT NULL DEFAULT NULL,
  `Insulina` FLOAT NULL DEFAULT NULL,
  `Carbohidratos` FLOAT NULL DEFAULT NULL,
  `Activo` INT NOT NULL DEFAULT '1',
  `InsDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdMedicion`),
  INDEX `fk_paciente` (`IdPaciente` ASC) VISIBLE,
  CONSTRAINT `FK_Mediciones`
    FOREIGN KEY (`IdPaciente`)
    REFERENCES `diabecheckv2`.`usuarios` (`IdUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `diabecheckv2`.`medicosinfoadicional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diabecheckv2`.`medicosinfoadicional` (
  `IdMedicoInfoAdicional` INT NOT NULL AUTO_INCREMENT,
  `IdUsuario` INT NOT NULL,
  `Especialidad` VARCHAR(100) NOT NULL,
  `IdMatricula` INT NOT NULL,
  `Activo` INT NOT NULL DEFAULT '1',
  `InsDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdMedicoInfoAdicional`),
  INDEX `FK_MedicosInfoAdicional_Usuario` (`IdUsuario` ASC) VISIBLE,
  INDEX `FK_MedicosInfoAdicioanl_Matricula` (`IdMatricula` ASC) VISIBLE,
  CONSTRAINT `FK_MedicosInfoAdicional`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `diabecheckv2`.`usuarios` (`IdUsuario`),
  CONSTRAINT `FK_MedicosInfoAdicional_2`
    FOREIGN KEY (`IdMatricula`)
    REFERENCES `diabecheckv2`.`matriculas` (`IdMatricula`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `diabecheckv2`.`pacientesinfoadicional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diabecheckv2`.`pacientesinfoadicional` (
  `IdPacientesInfoAdicional` INT NOT NULL AUTO_INCREMENT,
  `IdUsuario` INT NOT NULL,
  `IdCoberturaMedica` INT NOT NULL,
  `Peso` INT NOT NULL,
  `Altura` INT NOT NULL,
  `IdDiagnostico` INT NOT NULL,
  `FechaUltimaConsulta` DATE NOT NULL,
  `Activo` INT NOT NULL DEFAULT '1',
  `InsDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdPacientesInfoAdicional`),
  INDEX `FK_PacientesInfoAdicional_Usuario` (`IdUsuario` ASC) VISIBLE,
  INDEX `FK_PacientesInfoAdicional_Cobertura` (`IdCoberturaMedica` ASC) VISIBLE,
  INDEX `FK_PacientesInfoAdicional_Diagnostico` (`IdDiagnostico` ASC) VISIBLE,
  CONSTRAINT `FK_PacientesInfoAdicional`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `diabecheckv2`.`usuarios` (`IdUsuario`),
  CONSTRAINT `FK_PacientesInfoAdicional_2`
    FOREIGN KEY (`IdCoberturaMedica`)
    REFERENCES `diabecheckv2`.`coberturamedica` (`IdCoberturaMedica`),
  CONSTRAINT `FK_PacientesInfoAdicional_3`
    FOREIGN KEY (`IdDiagnostico`)
    REFERENCES `diabecheckv2`.`diagnosticos` (`IdDiagnostico`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `diabecheckv2` ;

-- -----------------------------------------------------
-- procedure GetMedicos
-- -----------------------------------------------------

DELIMITER $$
USE `diabecheckv2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMedicos`()
BEGIN
	SELECT U.IdUsuario, U.Nombre, U.Apellido, U.NroDocumento, U.FechaNacimiento, U.RutaFoto,
    M.IdMedicoInfoAdicional, M.IdMatricula, M.Especialidad
    FROM usuarios U
    INNER JOIN medicosinfoadicional M ON U.IdUsuario = M.IdUsuario
    WHERE U.IdRol = 1 AND U.Activo = 1;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetPacientes
-- -----------------------------------------------------

DELIMITER $$
USE `diabecheckv2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPacientes`(medicoId INT)
BEGIN
	SELECT u.* 
    FROM conexionesmedicopaciente AS c
    INNER JOIN usuarios AS u ON c.IdPaciente = u.IdUsuario
    WHERE c.IdMedico = medicoId;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
