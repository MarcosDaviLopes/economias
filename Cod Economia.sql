-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Nomes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Nomes` (
  `idNomes` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idNomes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Valor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Valor` (
  `idValor` INT NOT NULL,
  `Valor_Atual` DOUBLE NOT NULL,
  `Valor_comprado` DOUBLE NOT NULL,
  `Nomes_idNomes` INT NOT NULL,
  PRIMARY KEY (`idValor`),
  INDEX `fk_Valor_Nomes1_idx` (`Nomes_idNomes` ASC) VISIBLE,
  CONSTRAINT `fk_Valor_Nomes1`
    FOREIGN KEY (`Nomes_idNomes`)
    REFERENCES `mydb`.`Nomes` (`idNomes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ativos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ativos` (
  `idAtivos` INT NOT NULL,
  `Valor_Atual` DOUBLE NOT NULL,
  `Nomes_idNomes` INT NOT NULL,
  `Valor_idValor` INT NOT NULL,
  PRIMARY KEY (`idAtivos`),
  INDEX `fk_Ativos_Nomes1_idx` (`Nomes_idNomes` ASC) VISIBLE,
  INDEX `fk_Ativos_Valor1_idx` (`Valor_idValor` ASC) VISIBLE,
  CONSTRAINT `fk_Ativos_Nomes1`
    FOREIGN KEY (`Nomes_idNomes`)
    REFERENCES `mydb`.`Nomes` (`idNomes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ativos_Valor1`
    FOREIGN KEY (`Valor_idValor`)
    REFERENCES `mydb`.`Valor` (`idValor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_ATV`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_ATV` (
  `idtipo_ATV` INT NOT NULL,
  `Tesouro_Dir` VARCHAR(45) NOT NULL,
  `Cripto` VARCHAR(45) NOT NULL,
  `tipo_ATVcol` VARCHAR(45) NOT NULL,
  `Imobiliario` VARCHAR(45) NOT NULL,
  `Ativos_idAtivos` INT NOT NULL,
  PRIMARY KEY (`idtipo_ATV`, `Ativos_idAtivos`),
  INDEX `fk_tipo_ATV_Ativos1_idx` (`Ativos_idAtivos` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_ATV_Ativos1`
    FOREIGN KEY (`Ativos_idAtivos`)
    REFERENCES `mydb`.`Ativos` (`idAtivos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Data` (
  `idData` INT NOT NULL,
  `Data` VARCHAR(45) NOT NULL,
  `Transacao` INT NOT NULL,
  PRIMARY KEY (`idData`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Compras` (
  `Ativos_idAtivos` INT NOT NULL,
  `Data_idData` INT NOT NULL,
  PRIMARY KEY (`Ativos_idAtivos`, `Data_idData`),
  INDEX `fk_Ativos_has_Data_Data1_idx` (`Data_idData` ASC) VISIBLE,
  INDEX `fk_Ativos_has_Data_Ativos1_idx` (`Ativos_idAtivos` ASC) VISIBLE,
  CONSTRAINT `fk_Ativos_has_Data_Ativos1`
    FOREIGN KEY (`Ativos_idAtivos`)
    REFERENCES `mydb`.`Ativos` (`idAtivos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ativos_has_Data_Data1`
    FOREIGN KEY (`Data_idData`)
    REFERENCES `mydb`.`Data` (`idData`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Corretora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Corretora` (
  `idCorretora` INT NOT NULL,
  `Nomes_idNomes` INT NOT NULL,
  PRIMARY KEY (`idCorretora`),
  INDEX `fk_Corretora_Nomes1_idx` (`Nomes_idNomes` ASC) VISIBLE,
  CONSTRAINT `fk_Corretora_Nomes1`
    FOREIGN KEY (`Nomes_idNomes`)
    REFERENCES `mydb`.`Nomes` (`idNomes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Investimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Investimento` (
  `Ativos_idAtivos` INT NOT NULL,
  `Corretora_idCorretora` INT NOT NULL,
  PRIMARY KEY (`Ativos_idAtivos`, `Corretora_idCorretora`),
  INDEX `fk_Ativos_has_Corretora_Corretora1_idx` (`Corretora_idCorretora` ASC) VISIBLE,
  INDEX `fk_Ativos_has_Corretora_Ativos2_idx` (`Ativos_idAtivos` ASC) VISIBLE,
  CONSTRAINT `fk_Ativos_has_Corretora_Ativos2`
    FOREIGN KEY (`Ativos_idAtivos`)
    REFERENCES `mydb`.`Ativos` (`idAtivos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ativos_has_Corretora_Corretora1`
    FOREIGN KEY (`Corretora_idCorretora`)
    REFERENCES `mydb`.`Corretora` (`idCorretora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Opcoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Opcoes` (
  `Corretora_idCorretora` INT NOT NULL,
  `tipo_ATV_idtipo_ATV` INT NOT NULL,
  `Nomes_idNomes` INT NOT NULL,
  PRIMARY KEY (`Corretora_idCorretora`, `tipo_ATV_idtipo_ATV`, `Nomes_idNomes`),
  INDEX `fk_Corretora_has_tipo_ATV_tipo_ATV1_idx` (`tipo_ATV_idtipo_ATV` ASC) VISIBLE,
  INDEX `fk_Corretora_has_tipo_ATV_Corretora1_idx` (`Corretora_idCorretora` ASC) VISIBLE,
  INDEX `fk_Opcoes_Nomes1_idx` (`Nomes_idNomes` ASC) VISIBLE,
  CONSTRAINT `fk_Corretora_has_tipo_ATV_Corretora1`
    FOREIGN KEY (`Corretora_idCorretora`)
    REFERENCES `mydb`.`Corretora` (`idCorretora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Corretora_has_tipo_ATV_tipo_ATV1`
    FOREIGN KEY (`tipo_ATV_idtipo_ATV`)
    REFERENCES `mydb`.`tipo_ATV` (`idtipo_ATV`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Opcoes_Nomes1`
    FOREIGN KEY (`Nomes_idNomes`)
    REFERENCES `mydb`.`Nomes` (`idNomes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
