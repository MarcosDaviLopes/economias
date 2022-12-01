-- -----------------------------------------------------
-- Schema xp
-- -----------------------------------------------------

CREATE DATABASE xp;

USE xp;

-- -----------------------------------------------------
-- Table mydb.Nomes
-- -----------------------------------------------------

CREATE TABLE Nomes (idNomes INT NOT NULL,
                                Nome VARCHAR(45) NULL,
                                                 PRIMARY KEY (idNomes));

-- -----------------------------------------------------
-- Table mydb.Valor
-- -----------------------------------------------------

CREATE TABLE Valor (idValor INT NOT NULL,
                                Valor_Atual DOUBLE NOT NULL,
                                                   Valor_comprado DOUBLE NOT NULL,
                                                                         Nomes_idNomes INT NOT NULL,
                                                                                           PRIMARY KEY (idValor),
                    FOREIGN KEY (Nomes_idNomes) REFERENCES mydb.Nomes (idNomes));

-- -----------------------------------------------------
-- Table mydb.tipo_ATV
-- -----------------------------------------------------

CREATE TABLE tipo_ATV (idtipo_ATV INT NOT NULL,
                                      Tesouro_Dir VARCHAR(45) NOT NULL,
                                                              Cripto VARCHAR(45) NOT NULL,
                                                                                 tipo_ATVcol VARCHAR(45) NOT NULL,
                                                                                                         Imobiliario VARCHAR(45) NOT NULL,
                                                                                                                                 Ativos_idAtivos INT NOT NULL,
                                                                                                                                                     PRIMARY KEY (idtipo_ATV,
                                                                                                                                                                  Ativos_idAtivos),
                       FOREIGN KEY (Ativos_idAtivos) REFERENCES mydb.investimentos (idAtivos));

-- -----------------------------------------------------
-- Table mydb.Data
-- -----------------------------------------------------

CREATE TABLE DATA (idData INT NOT NULL,
                              DATA VARCHAR(45) NOT NULL,
                                               Transacao INT NOT NULL,
                                                             PRIMARY KEY (idData));

-- -----------------------------------------------------
-- Table mydb.Compras
-- -----------------------------------------------------

CREATE TABLE Compras (Ativos_idAtivos INT NOT NULL,
                                          Data_idData INT NOT NULL,
                                                          PRIMARY KEY (Ativos_idAtivos,
                                                                       Data_idData),
                      FOREIGN KEY (Ativos_idAtivos) REFERENCES mydb.investimentos (idAtivos) ,
                      FOREIGN KEY (Data_idData) REFERENCES mydb.Data (idData));

-- -----------------------------------------------------
-- Table mydb.empresas
-- -----------------------------------------------------

CREATE TABLE empresas (cnpj BIGINT NOT NULL,
                                   nome VARCHAR(45) NOT NULL,
                                                    PRIMARY KEY (cnpj));

-- -----------------------------------------------------
-- Table mydb.investimentos
-- -----------------------------------------------------

CREATE TABLE investimentos (Ativos_idAtivos INT NOT NULL,
                                                Corretora_idCorretora INT NOT NULL,
                                                                          PRIMARY KEY (Ativos_idAtivos,
                                                                                       Corretora_idCorretora),
                            FOREIGN KEY (Ativos_idAtivos) REFERENCES mydb.investimentos (idAtivos) ,
                            FOREIGN KEY (Corretora_idCorretora) REFERENCES mydb.empresas (cnpj));

-- -----------------------------------------------------
-- Table mydb.Opcoes
-- -----------------------------------------------------

CREATE TABLE Opcoes (Corretora_idCorretora INT NOT NULL,
                                               tipo_ATV_idtipo_ATV INT NOT NULL,
                                                                       Nomes_idNomes INT NOT NULL,
                                                                                         PRIMARY KEY (Corretora_idCorretora,
                                                                                                      tipo_ATV_idtipo_ATV,
                                                                                                      Nomes_idNomes),
                     FOREIGN KEY (Corretora_idCorretora) REFERENCES mydb.empresas (cnpj) ,
                     FOREIGN KEY (tipo_ATV_idtipo_ATV) REFERENCES mydb.tipo_ATV (idtipo_ATV) ,
                     FOREIGN KEY (Nomes_idNomes) REFERENCES mydb.Nomes (idNomes));

-- -----------------------------------------------------
-- Table mydb.Pessoa_Invest
-- -----------------------------------------------------

CREATE TABLE Pessoa_Invest (idPessoa_Invest INT NOT NULL,
                                                VARCHAR(45) NOT NULL,
                                                            PRIMARY KEY (idPessoa_Invest));

-- -----------------------------------------------------
-- Table mydb.pessoas
-- -----------------------------------------------------

CREATE TABLE pessoas (nrConta INT NOT NULL,
                                  nome VARCHAR(45) NOT NULL,
                                                   credito DOUBLE NOT NULL,
                                                                  PRIMARY KEY (nrConta));

-- -----------------------------------------------------
-- Table mydb.table1
-- -----------------------------------------------------

CREATE TABLE table1 ();

-- -----------------------------------------------------
-- Table mydb.corretoras_has_pessoas
-- -----------------------------------------------------

CREATE TABLE corretoras_has_pessoas (corretoras_idCorretora INT NOT NULL,
                                                                pessoas_idpessoas INT NOT NULL,
                                                                                      PRIMARY KEY (corretoras_idCorretora,
                                                                                                   pessoas_idpessoas),
                                     FOREIGN KEY (corretoras_idCorretora) REFERENCES mydb.empresas (cnpj) ,
                                     FOREIGN KEY (pessoas_idpessoas) REFERENCES mydb.pessoas (nrConta));

-- -----------------------------------------------------
-- Table mydb.ativos
-- -----------------------------------------------------

CREATE TABLE ativos (idativos INT NOT NULL,
                                  Nome VARCHAR(45) NOT NULL,
                                                   valor DOUBLE NOT NULL,
                                                                empresas_cnpj BIGINT NOT NULL,
                                                                                     PRIMARY KEY (idativos,
                                                                                                  empresas_cnpj),
                     FOREIGN KEY (empresas_cnpj) REFERENCES mydb.empresas (cnpj));

-- -----------------------------------------------------
-- Table mydb.carteira
-- -----------------------------------------------------

CREATE TABLE carteira (ativos_idativos INT NOT NULL,
                                           pessoas_nrConta INT NOT NULL,
                                                               quantia FLOAT NOT NULL,
                                                                             tipo VARCHAR(255) NOT NULL,
                                                                                               PRIMARY KEY (ativos_idativos,
                                                                                                            pessoas_nrConta),
                       FOREIGN KEY (ativos_idativos) REFERENCES mydb.ativos (idativos) ,
                       FOREIGN KEY (pessoas_nrConta) REFERENCES mydb.pessoas (nrConta));

DROP DATABASE xp;