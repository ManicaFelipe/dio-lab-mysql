
-- Criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- 
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUTO` (
  `ID` INT NOT NULL,
  `CATEGORIA` VARCHAR(45) NULL,
  `DESCRICAO` VARCHAR(45) NULL,
  `PRECO` INT NULL,
  `FRETE` VARCHAR(45) NULL,
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
-- Table `mydb`.`PRODUTO_POR_FORNECEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUTO_POR_FORNECEDOR` (
  `ID_PRODUTO` INT NOT NULL,
  `ID_FORNECEDOR` INT NOT NULL,
  `QUANTIDADE` INT NULL,
  PRIMARY KEY (`ID_PRODUTO`, `ID_FORNECEDOR`),
  INDEX `fk_Produto_has_Fornecedor_Fornecedor1_idx` (`ID_FORNECEDOR` ASC) VISIBLE,
  INDEX `fk_Produto_has_Fornecedor_Produto_idx` (`ID_PRODUTO` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Fornecedor_Produto`
    FOREIGN KEY (`ID_PRODUTO`)
    REFERENCES `mydb`.`PRODUTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`ID_FORNECEDOR`)
    REFERENCES `mydb`.`FORNECEDOR` (`ID`)
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
-- Table `mydb`.`ST_PEDIDO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ST_PEDIDO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PEDIDO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PEDIDO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CLIENTE_ID` INT NOT NULL,
  `ID_ST_PEDIDO` INT NOT NULL,
  `OBSERVACAO` VARCHAR(250) NULL,
  `TOTAL` DECIMAL(9,2) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_PEDIDO_CLIENTE1_idx` (`CLIENTE_ID` ASC) VISIBLE,
  INDEX `fk_PEDIDO_ST_PEDIDO1_idx` (`ID_ST_PEDIDO` ASC) VISIBLE,
  CONSTRAINT `fk_PEDIDO_CLIENTE1`
    FOREIGN KEY (`CLIENTE_ID`)
    REFERENCES `mydb`.`CLIENTE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PEDIDO_ST_PEDIDO1`
    FOREIGN KEY (`ID_ST_PEDIDO`)
    REFERENCES `mydb`.`ST_PEDIDO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUTO_PEDIDO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUTO_PEDIDO` (
  ` ID_PRODUTO` INT NOT NULL,
  `ID_PEDIDO` INT NOT NULL,
  `QUANTIDADE` VARCHAR(45) NULL,
  PRIMARY KEY (` ID_PRODUTO`, `ID_PEDIDO`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`ID_PEDIDO` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (` ID_PRODUTO` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (` ID_PRODUTO`)
    REFERENCES `mydb`.`PRODUTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`ID_PEDIDO`)
    REFERENCES `mydb`.`PEDIDO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`VENDEDOR_TERCEIRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VENDEDOR_TERCEIRO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PESSOA` INT NOT NULL,
  `DATA_CADASTRO` VARCHAR(45) NULL,
  `OBSERVACAO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Terceiro_Vendedor_Pessoa1_idx` (`ID_PESSOA` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro_Vendedor_Pessoa1`
    FOREIGN KEY (`ID_PESSOA`)
    REFERENCES `mydb`.`PESSOA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUTO_POR_VEND_TERCEIRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUTO_POR_VEND_TERCEIRO` (
  `ID_VENDEDOR_TERCEIRO` INT NOT NULL,
  `ID_PRODUTO` INT NOT NULL,
  `PRODUTO_VENDEDOR` VARCHAR(45) NULL,
  `QUANTIDADE` INT NULL,
  PRIMARY KEY (`ID_VENDEDOR_TERCEIRO`, `ID_PRODUTO`),
  INDEX `fk_Terceiro_Vendedor_has_Produto_Produto1_idx` (`ID_PRODUTO` ASC) VISIBLE,
  INDEX `fk_Terceiro_Vendedor_has_Produto_Terceiro_Vendedor1_idx` (`ID_VENDEDOR_TERCEIRO` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Terceiro_Vendedor1`
    FOREIGN KEY (`ID_VENDEDOR_TERCEIRO`)
    REFERENCES `mydb`.`VENDEDOR_TERCEIRO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Produto1`
    FOREIGN KEY (`ID_PRODUTO`)
    REFERENCES `mydb`.`PRODUTO` (`ID`)
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
-- Table `mydb`.`TRANSPORTADORA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TRANSPORTADORA` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PESSOA` INT NOT NULL,
  `DATA_CADASTRO` DATE NULL,
  `OBSERVACAO` VARCHAR(250) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_TRANSPORTADORA_PESSOA1_idx` (`ID_PESSOA` ASC) VISIBLE,
  CONSTRAINT `fk_TRANSPORTADORA_PESSOA1`
    FOREIGN KEY (`ID_PESSOA`)
    REFERENCES `mydb`.`PESSOA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUTO_POR_ESTOQUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUTO_POR_ESTOQUE` (
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
    REFERENCES `mydb`.`PRODUTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
-- Table `mydb`.`ENTREGA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ENTREGA` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_PEDIDO` INT NOT NULL,
  `ID_TRANSPORTADORA` INT NOT NULL,
  `COD_RASTREIO` VARCHAR(45) NULL,
  `STATUS` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_ENTREGA_PEDIDO1_idx` (`ID_PEDIDO` ASC) VISIBLE,
  INDEX `fk_ENTREGA_TRANSPORTADORA1_idx` (`ID_TRANSPORTADORA` ASC) VISIBLE,
  CONSTRAINT `fk_ENTREGA_PEDIDO1`
    FOREIGN KEY (`ID_PEDIDO`)
    REFERENCES `mydb`.`PEDIDO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ENTREGA_TRANSPORTADORA1`
    FOREIGN KEY (`ID_TRANSPORTADORA`)
    REFERENCES `mydb`.`TRANSPORTADORA` (`ID`)
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
    REFERENCES `mydb`.`PEDIDO` (`ID`)
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
-- Table `mydb`.`ST_ENTREGA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ST_ENTREGA` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ID_ENTREGA` INT NOT NULL,
  `SITUACAO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_STATUS_ENTREGA_ENTREGA1_idx` (`ID_ENTREGA` ASC) VISIBLE,
  CONSTRAINT `fk_STATUS_ENTREGA_ENTREGA1`
    FOREIGN KEY (`ID_ENTREGA`)
    REFERENCES `mydb`.`ENTREGA` (`ID`)
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
