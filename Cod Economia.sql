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
CREATE SCHEMA IF NOT EXISTS mydb DEFAULT CHARACTER SET utf8 ;
USE mydb ;

-- -----------------------------------------------------
-- Table mydb.Nomes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Nomes (
  idNomes INT NOT NULL,
  Nome VARCHAR(45) NULL,
  PRIMARY KEY (idNomes))
ENGINE = InnoDB;
Insert into Nomes
(idNomes, Nome)
Values
(1, 'XP'),(2, 'Binance'),(3, 'NuInv'),(4, 'TSDR'),(5, 'Vitreo'),
(6, 'VALE3'),(7, ),(8, 'NUBR33'),(9, 'BTC'),(10, 'ETH');




-- -----------------------------------------------------
-- Table mydb.Valor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Valor (
  idValor INT NOT NULL,
  Valor_Atual DOUBLE NOT NULL,
  Valor_comprado DOUBLE NOT NULL,
  Nomes_idNomes INT NOT NULL,
  PRIMARY KEY (idValor),
  INDEX fk_Valor_Nomes1_idx (Nomes_idNomes ASC) VISIBLE,
  CONSTRAINT fk_Valor_Nomes1
    FOREIGN KEY (Nomes_idNomes)
    REFERENCES mydb.Nomes (idNomes)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
Insert into Valor
(idValor, Valor_Atual, Valor_comprado)
Values
(1, 5.19, 5.00),(2, 294.70, 250.60),(3, 93305.82, 113678.95),(4, 294.70, 300.13),(5, 88678.95, 96782.63)
,(6, 0.55, 0.40),(7, 17.51, 15.45),(8, 132.85, 123.50),(9, 6723.96, 5984.34),(10, 85.71, 90.80);

-- -----------------------------------------------------
-- Table mydb.Ativos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Ativos (
  idAtivos INT NOT NULL,
  Nomes_idNomes INT NOT NULL,
  Valor_idValor INT NOT NULL,
  PRIMARY KEY (idAtivos),
  INDEX fk_Ativos_Nomes1_idx (Nomes_idNomes ASC) VISIBLE,
  INDEX fk_Ativos_Valor1_idx (Valor_idValor ASC) VISIBLE,
  CONSTRAINT fk_Ativos_Nomes1
    FOREIGN KEY (Nomes_idNomes)
    REFERENCES mydb.Nomes (idNomes)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Ativos_Valor1
    FOREIGN KEY (Valor_idValor)
    REFERENCES mydb.Valor (idValor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
Insert into Ativos
(idAtivos)
Values
(1),(2),(3),(4),(5),
(6),(7),(8),(9),(10);


-- -----------------------------------------------------
-- Table mydb.Tipo_ATV
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Tipo_ATV (
  idTipo_ATV INT NOT NULL,
  Tesouro_Dir VARCHAR(45) NOT NULL,
  Cripto VARCHAR(45) NOT NULL,
  Imobiliario VARCHAR(45) NOT NULL,
  Ativos_idAtivos INT NOT NULL,
  PRIMARY KEY (idTipo_ATV, Ativos_idAtivos),
  INDEX fk_Tipo_ATV_Ativos1_idx (Ativos_idAtivos ASC) VISIBLE,
  CONSTRAINT fk_Tipo_ATV_Ativos1
    FOREIGN KEY (Ativos_idAtivos)
    REFERENCES mydb.Ativos (idAtivos)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
Insert into Tipo_ATV
(idTipo_ATV, Tesouro_Dir, Cripto, Imobiliario)
Values
(1, ),(2),(3),(4),(5),
(6),(7),(8),(9),(10);


-- -----------------------------------------------------
-- Table mydb.Date
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Date (
  idDate INT NOT NULL,
  Data VARCHAR(45) NOT NULL,
  Transacao INT NOT NULL,
  PRIMARY KEY (idDate))
ENGINE = InnoDB;
Insert into Date
(idDate, Data, Transacao)
Values
(1, ),(2),(3),(4),(5),
(6),(7),(8),(9),(10);


-- -----------------------------------------------------
-- Table mydb.Compras
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Compras (
  Ativos_idAtivos INT NOT NULL,
  Date_idDate INT NOT NULL,
  PRIMARY KEY (Ativos_idAtivos, Date_idDate),
  INDEX fk_Ativos_has_Date_Date1_idx (Date_idDate ASC) VISIBLE,
  INDEX fk_Ativos_has_Date_Ativos1_idx (Ativos_idAtivos ASC) VISIBLE,
  CONSTRAINT fk_Ativos_has_Date_Ativos1
    FOREIGN KEY (Ativos_idAtivos)
    REFERENCES mydb.Ativos (idAtivos)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Ativos_has_Date_Date1
    FOREIGN KEY (Date_idDate)
    REFERENCES mydb.Date (idDate)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table mydb.Corretora
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Corretora (
  idCorretora INT NOT NULL,
  Nomes_idNomes INT NOT NULL,
  PRIMARY KEY (idCorretora),
  INDEX fk_Corretora_Nomes1_idx (Nomes_idNomes ASC) VISIBLE,
  CONSTRAINT fk_Corretora_Nomes1
    FOREIGN KEY (Nomes_idNomes)
    REFERENCES mydb.Nomes (idNomes)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
Insert into Corretora
(idCorretora)
Values
(1),(2),(3),(4),(5),
(6),(7),(8),(9),(10);


-- -----------------------------------------------------
-- Table mydb.Investimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Investimento (
  Ativos_idAtivos INT NOT NULL,
  Corretora_idCorretora INT NOT NULL,
  PRIMARY KEY (Ativos_idAtivos, Corretora_idCorretora),
  INDEX fk_Ativos_has_Corretora_Corretora1_idx (Corretora_idCorretora ASC) VISIBLE,
  INDEX fk_Ativos_has_Corretora_Ativos2_idx (Ativos_idAtivos ASC) VISIBLE,
  CONSTRAINT fk_Ativos_has_Corretora_Ativos2
    FOREIGN KEY (Ativos_idAtivos)
    REFERENCES mydb.Ativos (idAtivos)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Ativos_has_Corretora_Corretora1
    FOREIGN KEY (Corretora_idCorretora)
    REFERENCES mydb.Corretora (idCorretora)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table mydb.Opcoes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Opcoes (
  Corretora_idCorretora INT NOT NULL,
  Tipo_ATV_idTipo_ATV INT NOT NULL,
  Nomes_idNomes INT NOT NULL,
  PRIMARY KEY (Corretora_idCorretora, Tipo_ATV_idTipo_ATV, Nomes_idNomes),
  INDEX fk_Corretora_has_Tipo_ATV_Tipo_ATV1_idx (Tipo_ATV_idTipo_ATV ASC) VISIBLE,
  INDEX fk_Corretora_has_Tipo_ATV_Corretora1_idx (Corretora_idCorretora ASC) VISIBLE,
  INDEX fk_Opcoes_Nomes1_idx (Nomes_idNomes ASC) VISIBLE,
  CONSTRAINT fk_Corretora_has_Tipo_ATV_Corretora1
    FOREIGN KEY (Corretora_idCorretora)
    REFERENCES mydb.Corretora (idCorretora)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Corretora_has_Tipo_ATV_Tipo_ATV1
    FOREIGN KEY (Tipo_ATV_idTipo_ATV)
    REFERENCES mydb.Tipo_ATV (idTipo_ATV)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Opcoes_Nomes1
    FOREIGN KEY (Nomes_idNomes)
    REFERENCES mydb.Nomes (idNomes)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
