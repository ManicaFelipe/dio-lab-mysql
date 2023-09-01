-- Criação do banco de dados para o cenário de Oficinas
create database oficinadb;
use oficinadb;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`PEÇA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PEÇA` (
  `ID` INT NOT NULL,
  `CATEGORIA` VARCHAR(45) NULL,
  `DESCRICAO` VARCHAR(45) NULL,
  `PRECO` INT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PESSOA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PESSOA` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `SOBRENOME` VARCHAR(100) NOT NULL,
  `E-MAIL` VARCHAR(100) NOT NULL,
  `TIPO` CHAR(1) NOT NULL COMMENT '[ F ] Pessoa Física\n[ J ] Pessoa Juridica',
  `FORNECEDOR` TINYINT NULL,
  `CLIENTE` TINYINT NULL,
  `VENDEDOR_TERCEIRO` TINYINT NULL,
  `COLABORADOR` TINYINT NULL,
  `TRANSPORTADORA` TINYINT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
COMMENT = '\n								';


-- -----------------------------------------------------
-- Table `mydb`.`FORNECEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`FORNECEDOR` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PESSOA` INT NOT NULL,
  `DATA_CADASTRO` DATE NULL,
  `OBSERVACAO` VARCHAR(250) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Fornecedor_Pessoa1_idx` (`ID_PESSOA` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_Pessoa1`
    FOREIGN KEY (`ID_PESSOA`)
    REFERENCES `mydb`.`PESSOA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ESTOQUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ESTOQUE` (
  `ID` INT NOT NULL,
  `LOCAL` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ST_ORÇAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ST_ORÇAMENTO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CARGO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CARGO` (
  `ID` INT NOT NULL,
  `NOME` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
COMMENT = '\n';


-- -----------------------------------------------------
-- Table `mydb`.`DEPARTAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DEPARTAMENTO` (
  `ID` INT NOT NULL,
  `NOME` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COLABORADOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COLABORADOR` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PESSOA` INT NOT NULL,
  `ID_DEPARTAMENTO` INT NOT NULL,
  `ID_CARGO` INT NOT NULL,
  `DATA_ADMISSAO` DATE NOT NULL,
  `DATA_DEMISSAO` DATE NULL,
  `CTPS` VARCHAR(15) NOT NULL,
  `OBSERVACAO` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_COLABORADOR_PESSOA1_idx` (`ID_PESSOA` ASC) VISIBLE,
  INDEX `fk_COLABORADOR_CARGO1_idx` (`ID_CARGO` ASC) VISIBLE,
  INDEX `fk_COLABORADOR_DEPARTAMENTO1_idx` (`ID_DEPARTAMENTO` ASC) VISIBLE,
  CONSTRAINT `fk_COLABORADOR_PESSOA1`
    FOREIGN KEY (`ID_PESSOA`)
    REFERENCES `mydb`.`PESSOA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COLABORADOR_CARGO1`
    FOREIGN KEY (`ID_CARGO`)
    REFERENCES `mydb`.`CARGO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COLABORADOR_DEPARTAMENTO1`
    FOREIGN KEY (`ID_DEPARTAMENTO`)
    REFERENCES `mydb`.`DEPARTAMENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`VENDEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VENDEDOR` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_COLABORADOR` INT NOT NULL,
  `OBSERVACAO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_VENDEDOR_COLABORADOR1_idx` (`ID_COLABORADOR` ASC) VISIBLE,
  CONSTRAINT `fk_VENDEDOR_COLABORADOR1`
    FOREIGN KEY (`ID_COLABORADOR`)
    REFERENCES `mydb`.`COLABORADOR` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CLIENTE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PESSOA` INT NOT NULL,
  `DATA_CADASTRO` DATE NULL,
  `OBSERVACAO` VARCHAR(250) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_CLIENTE_PESSOA1_idx` (`ID_PESSOA` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENTE_PESSOA1`
    FOREIGN KEY (`ID_PESSOA`)
    REFERENCES `mydb`.`PESSOA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`VEICULO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VEICULO` (
  `ID` INT NOT NULL,
  `ID_CLIENTE` INT NOT NULL,
  `PLACA` VARCHAR(45) NULL,
  `MARCA` VARCHAR(45) NULL,
  `MODELO` VARCHAR(45) NULL,
  `COR` VARCHAR(45) NULL,
  `KM` INT NULL,
  `VEICULOcol` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_VEICULO_CLIENTE1_idx` (`ID_CLIENTE` ASC) VISIBLE,
  CONSTRAINT `fk_VEICULO_CLIENTE1`
    FOREIGN KEY (`ID_CLIENTE`)
    REFERENCES `mydb`.`CLIENTE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MECANICO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MECANICO` (
  `ID` INT NOT NULL,
  `ID_COLABORADOR` INT NOT NULL,
  `OBSERVACAO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_MECANICO_COLABORADOR1_idx` (`ID_COLABORADOR` ASC) VISIBLE,
  CONSTRAINT `fk_MECANICO_COLABORADOR1`
    FOREIGN KEY (`ID_COLABORADOR`)
    REFERENCES `mydb`.`COLABORADOR` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ORÇAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ORÇAMENTO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `VENDEDOR_ID` INT NOT NULL,
  `VEICULO_ID` INT NOT NULL,
  `ST_ORÇAMENTO_ID` INT NOT NULL,
  `ID_MECANICO` INT NOT NULL,
  `OBSERVACAO` VARCHAR(250) NULL,
  `TOTAL` DECIMAL(9,2) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_ORÇAMENTO_ST_ORÇAMENTO1_idx` (`ST_ORÇAMENTO_ID` ASC) VISIBLE,
  INDEX `fk_ORÇAMENTO_VENDEDOR1_idx` (`VENDEDOR_ID` ASC) VISIBLE,
  INDEX `fk_ORÇAMENTO_VEICULO1_idx` (`VEICULO_ID` ASC) VISIBLE,
  INDEX `fk_ORÇAMENTO_MECANICO1_idx` (`ID_MECANICO` ASC) VISIBLE,
  CONSTRAINT `fk_ORÇAMENTO_ST_ORÇAMENTO1`
    FOREIGN KEY (`ST_ORÇAMENTO_ID`)
    REFERENCES `mydb`.`ST_ORÇAMENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORÇAMENTO_VENDEDOR1`
    FOREIGN KEY (`VENDEDOR_ID`)
    REFERENCES `mydb`.`VENDEDOR` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORÇAMENTO_VEICULO1`
    FOREIGN KEY (`VEICULO_ID`)
    REFERENCES `mydb`.`VEICULO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORÇAMENTO_MECANICO1`
    FOREIGN KEY (`ID_MECANICO`)
    REFERENCES `mydb`.`MECANICO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PEÇAS_POR_VENDEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PEÇAS_POR_VENDEDOR` (
  `ID_VENDEDOR` INT NOT NULL,
  `ID_PRODUTO` INT NOT NULL,
  `PRODUTO_VENDEDOR` VARCHAR(45) NULL,
  `QUANTIDADE` INT NULL,
  PRIMARY KEY (`ID_VENDEDOR`, `ID_PRODUTO`),
  INDEX `fk_Terceiro_Vendedor_has_Produto_Produto1_idx` (`ID_PRODUTO` ASC) VISIBLE,
  INDEX `fk_Terceiro_Vendedor_has_Produto_Terceiro_Vendedor1_idx` (`ID_VENDEDOR` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Terceiro_Vendedor1`
    FOREIGN KEY (`ID_VENDEDOR`)
    REFERENCES `mydb`.`VENDEDOR` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Produto1`
    FOREIGN KEY (`ID_PRODUTO`)
    REFERENCES `mydb`.`PEÇA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PESSOA_FISICA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PESSOA_FISICA` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PESSOA` INT NOT NULL,
  `CPF` VARCHAR(11) NULL,
  `DATA_NASCIMENTO` DATE NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_PESSOA_FISICA_PESSOA1_idx` (`ID_PESSOA` ASC) VISIBLE,
  CONSTRAINT `fk_PESSOA_FISICA_PESSOA1`
    FOREIGN KEY (`ID_PESSOA`)
    REFERENCES `mydb`.`PESSOA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PESSOA_JURIDICA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PESSOA_JURIDICA` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PESSOA` INT NOT NULL,
  `NOME_FANTASIA` VARCHAR(45) NULL,
  `RAZAO_SOCIAL` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  `DATA_CONSTITUICAO` DATE NULL,
  `DATA_CADASTRO` DATE NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Pesssoa_Jurídica_Pessoa1_idx` (`ID_PESSOA` ASC) VISIBLE,
  CONSTRAINT `fk_Pesssoa_Jurídica_Pessoa1`
    FOREIGN KEY (`ID_PESSOA`)
    REFERENCES `mydb`.`PESSOA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PESSOA_ENDERECO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PESSOA_ENDERECO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PESSOA` INT NOT NULL,
  `LOGRADOURO` VARCHAR(100) NULL,
  `NUMERO` VARCHAR(100) NULL,
  `COMPLEMENTO` VARCHAR(100) NULL,
  `BAIRRO` VARCHAR(100) NULL,
  `CEP` VARCHAR(8) NULL,
  `CIDADE` VARCHAR(100) NULL,
  `UF` CHAR(2) NULL,
  `PAIS` VARCHAR(45) NULL,
  `ENTREGA` CHAR(1) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_PESSOA_ENDERECO_PESSOA1_idx` (`ID_PESSOA` ASC) VISIBLE,
  CONSTRAINT `fk_PESSOA_ENDERECO_PESSOA1`
    FOREIGN KEY (`ID_PESSOA`)
    REFERENCES `mydb`.`PESSOA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PESSOA_TELEFONE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PESSOA_TELEFONE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PESSOA` INT NOT NULL,
  `TIPO` CHAR(1) NULL,
  `DDD_NUMERO` VARCHAR(20) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_PESSOA_TELEFONE_PESSOA1_idx` (`ID_PESSOA` ASC) VISIBLE,
  CONSTRAINT `fk_PESSOA_TELEFONE_PESSOA1`
    FOREIGN KEY (`ID_PESSOA`)
    REFERENCES `mydb`.`PESSOA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PEÇA_POR_ESTOQUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PEÇA_POR_ESTOQUE` (
  `ID_ESTOQUE` INT NOT NULL,
  `ID_PRODUTO` INT NOT NULL,
  PRIMARY KEY (`ID_ESTOQUE`, `ID_PRODUTO`),
  INDEX `fk_Estoque_has_Produto_Produto1_idx` (`ID_PRODUTO` ASC) VISIBLE,
  INDEX `fk_Estoque_has_Produto_Estoque1_idx` (`ID_ESTOQUE` ASC) VISIBLE,
  CONSTRAINT `fk_Estoque_has_Produto_Estoque1`
    FOREIGN KEY (`ID_ESTOQUE`)
    REFERENCES `mydb`.`ESTOQUE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estoque_has_Produto_Produto1`
    FOREIGN KEY (`ID_PRODUTO`)
    REFERENCES `mydb`.`PEÇA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ST_PAGAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ST_PAGAMENTO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `SITUACAO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PAGAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PAGAMENTO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PEDIDO` INT NOT NULL,
  `ST_PAGAMENTO_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_PAGAMENTO_PEDIDO1_idx` (`ID_PEDIDO` ASC) VISIBLE,
  INDEX `fk_PAGAMENTO_ST_PAGAMENTO1_idx` (`ST_PAGAMENTO_ID` ASC) VISIBLE,
  CONSTRAINT `fk_PAGAMENTO_PEDIDO1`
    FOREIGN KEY (`ID_PEDIDO`)
    REFERENCES `mydb`.`ORÇAMENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PAGAMENTO_ST_PAGAMENTO1`
    FOREIGN KEY (`ST_PAGAMENTO_ID`)
    REFERENCES `mydb`.`ST_PAGAMENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TIPO_PAGAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TIPO_PAGAMENTO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PAGAMENTO` INT NOT NULL,
  `BOLETO` TINYINT NULL,
  `PIX` TINYINT NULL,
  `DEBITO` TINYINT NULL,
  `CREDITO` TINYINT NULL,
  `DINHEIRO` TINYINT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_TIPO_PAGAMENTO_PAGAMENTO1_idx` (`ID_PAGAMENTO` ASC) VISIBLE,
  CONSTRAINT `fk_TIPO_PAGAMENTO_PAGAMENTO1`
    FOREIGN KEY (`ID_PAGAMENTO`)
    REFERENCES `mydb`.`PAGAMENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CARTAO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CARTAO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TIPO` VARCHAR(1) NULL,
  `TIPO_PAG_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_CARTAO_TIPO_PAG1_idx` (`TIPO_PAG_ID` ASC) VISIBLE,
  CONSTRAINT `fk_CARTAO_TIPO_PAG1`
    FOREIGN KEY (`TIPO_PAG_ID`)
    REFERENCES `mydb`.`TIPO_PAGAMENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DEBITO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DEBITO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CARTAO_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_DEBITO_CARTAO1_idx` (`CARTAO_ID` ASC) VISIBLE,
  CONSTRAINT `fk_DEBITO_CARTAO1`
    FOREIGN KEY (`CARTAO_ID`)
    REFERENCES `mydb`.`CARTAO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CREDITO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CREDITO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_CREDITO` INT NOT NULL,
  `VALOR` VARCHAR(45) NOT NULL,
  `NUMERO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_CREDITO_CARTAO1_idx` (`ID_CREDITO` ASC) VISIBLE,
  CONSTRAINT `fk_CREDITO_CARTAO1`
    FOREIGN KEY (`ID_CREDITO`)
    REFERENCES `mydb`.`CARTAO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BOLETO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`BOLETO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TIPO_PAG_ID` INT NOT NULL,
  `VALOR` VARCHAR(45) NULL,
  `DATA_EMISSAO` DATE NULL,
  `DATA_VENCIMENTO` DATE NULL,
  `NUMERO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_BOLETO_TIPO_PAG1_idx` (`TIPO_PAG_ID` ASC) VISIBLE,
  CONSTRAINT `fk_BOLETO_TIPO_PAG1`
    FOREIGN KEY (`TIPO_PAG_ID`)
    REFERENCES `mydb`.`TIPO_PAGAMENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PIX`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PIX` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TIPO_PAG_ID` INT NOT NULL,
  `CHAVE` VARCHAR(45) NOT NULL,
  `VALOR` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_PIX_TIPO_PAG1_idx` (`TIPO_PAG_ID` ASC) VISIBLE,
  CONSTRAINT `fk_PIX_TIPO_PAG1`
    FOREIGN KEY (`TIPO_PAG_ID`)
    REFERENCES `mydb`.`TIPO_PAGAMENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DINHEIRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DINHEIRO` (
  `ID` INT NOT NULL,
  `VALOR` VARCHAR(45) NOT NULL,
  `ID_ST_PAGAMENTO` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_DINHEIRO_t1_idx` (`ID_ST_PAGAMENTO` ASC) VISIBLE,
  CONSTRAINT `fk_DINHEIRO_t1`
    FOREIGN KEY (`ID_ST_PAGAMENTO`)
    REFERENCES `mydb`.`TIPO_PAGAMENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PEÇA_POR_FORNECEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PEÇA_POR_FORNECEDOR` (
  `ID_PEÇA` INT NOT NULL,
  `ID_FORNECEDOR` INT NOT NULL,
  `QUANTIDADE` INT NULL,
  PRIMARY KEY (`ID_PEÇA`, `ID_FORNECEDOR`),
  INDEX `fk_PEÇA_has_FORNECEDOR_FORNECEDOR1_idx` (`ID_FORNECEDOR` ASC) VISIBLE,
  INDEX `fk_PEÇA_has_FORNECEDOR_PEÇA1_idx` (`ID_PEÇA` ASC) VISIBLE,
  CONSTRAINT `fk_PEÇA_has_FORNECEDOR_PEÇA1`
    FOREIGN KEY (`ID_PEÇA`)
    REFERENCES `mydb`.`PEÇA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PEÇA_has_FORNECEDOR_FORNECEDOR1`
    FOREIGN KEY (`ID_FORNECEDOR`)
    REFERENCES `mydb`.`FORNECEDOR` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PEÇA_POR_ORÇAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PEÇA_POR_ORÇAMENTO` (
  `ID_PEÇA` INT NOT NULL,
  `ID_ORÇAMENTO` INT NOT NULL,
  `QUANTIDADE` INT NULL,
  PRIMARY KEY (`ID_PEÇA`, `ID_ORÇAMENTO`),
  INDEX `fk_PEÇA_has_ORÇAMENTO_ORÇAMENTO1_idx` (`ID_ORÇAMENTO` ASC) VISIBLE,
  INDEX `fk_PEÇA_has_ORÇAMENTO_PEÇA1_idx` (`ID_PEÇA` ASC) VISIBLE,
  CONSTRAINT `fk_PEÇA_has_ORÇAMENTO_PEÇA1`
    FOREIGN KEY (`ID_PEÇA`)
    REFERENCES `mydb`.`PEÇA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PEÇA_has_ORÇAMENTO_ORÇAMENTO1`
    FOREIGN KEY (`ID_ORÇAMENTO`)
    REFERENCES `mydb`.`ORÇAMENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
