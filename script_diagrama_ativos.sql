-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
create database xp;
Use xp;
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`empresas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empresas` (
  `cnpj` BIGINT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pessoas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pessoas` (
  `nrConta` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `credito` DOUBLE NOT NULL,
  PRIMARY KEY (`nrConta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ativos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ativos` (
  `idativos` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `valor` DOUBLE NOT NULL,
  `empresas_cnpj` BIGINT NOT NULL,
  PRIMARY KEY (`idativos`, `empresas_cnpj`),
  INDEX `fk_ativos_empresas1_idx` (`empresas_cnpj` ASC),
  CONSTRAINT `fk_ativos_empresas1`
    FOREIGN KEY (`empresas_cnpj`)
    REFERENCES `mydb`.`empresas` (`cnpj`)
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`carteira`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carteira` (
  `ativos_idativos` INT NOT NULL,
  `pessoas_nrConta` INT NOT NULL,
  `quantia` FLOAT NOT NULL,
  `tipo` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ativos_idativos`, `pessoas_nrConta`),
  INDEX `fk_ativos_has_pessoas_pessoas1_idx` (`pessoas_nrConta` ASC) ,
  INDEX `fk_ativos_has_pessoas_ativos1_idx` (`ativos_idativos` ASC) ,
  CONSTRAINT `fk_ativos_has_pessoas_ativos1`
    FOREIGN KEY (`ativos_idativos`)
    REFERENCES `mydb`.`ativos` (`idativos`),
  CONSTRAINT `fk_ativos_has_pessoas_pessoas1`
    FOREIGN KEY (`pessoas_nrConta`)
    REFERENCES `mydb`.`pessoas` (`nrConta`)
    )
ENGINE = InnoDB;

Drop Database xp;

Insert into pessoas (

