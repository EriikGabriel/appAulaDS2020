-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dbaulads
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbaulads
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbaulads` DEFAULT CHARACTER SET utf8 ;
USE `dbaulads` ;

-- -----------------------------------------------------
-- Table `dbaulads`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaulads`.`categorias` (
  `idcategoria` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `ativo` VARCHAR(1) NOT NULL,
  `datacriacao` DATETIME NOT NULL,
  `datamodificacao` DATETIME NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 70
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbaulads`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaulads`.`clientes` (
  `idcliente` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `telefone` VARCHAR(15) NULL DEFAULT NULL,
  `ativo` CHAR(1) NOT NULL,
  `datacriacao` DATETIME NOT NULL,
  `datamodificacao` DATETIME NOT NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbaulads`.`formas_pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaulads`.`formas_pagamento` (
  `idformas_pagamento` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `tera_troco` CHAR(1) NOT NULL,
  `tera_parcelamento` CHAR(1) NOT NULL,
  `ativo` CHAR(1) NOT NULL,
  `datacriacao` DATETIME NOT NULL,
  `datamodificacao` DATETIME NOT NULL,
  PRIMARY KEY (`idformas_pagamento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbaulads`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaulads`.`produtos` (
  `idproduto` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` TEXT NOT NULL,
  `estoque` INT(11) NOT NULL,
  `estoque_min` INT(11) NOT NULL,
  `valor` DECIMAL(7,2) NOT NULL,
  `ativo` CHAR(1) NOT NULL,
  `idcategoria` INT(11) NOT NULL,
  `imagem` VARCHAR(255) NULL,
  `datacriacao` DATETIME NOT NULL,
  `datamodificacao` DATETIME NOT NULL,
  PRIMARY KEY (`idproduto`),
  INDEX `fk_produtos_categorias_idx` (`idcategoria` ASC),
  CONSTRAINT `fk_produtos_categorias`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `dbaulads`.`categorias` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbaulads`.`vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaulads`.`vendas` (
  `idvenda` INT(11) NOT NULL AUTO_INCREMENT,
  `data_venda` DATETIME NOT NULL,
  `total_venda` DECIMAL(7,2) NOT NULL,
  `situacao` CHAR(1) NOT NULL,
  `idcliente` INT(11) NOT NULL,
  `idformas_pagamento` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idvenda`),
  INDEX `fk_vendas_clientes1_idx` (`idcliente` ASC),
  INDEX `fk_vendas_formas_pagamento1_idx` (`idformas_pagamento` ASC),
  CONSTRAINT `fk_vendas_clientes1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `dbaulads`.`clientes` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendas_formas_pagamento1`
    FOREIGN KEY (`idformas_pagamento`)
    REFERENCES `dbaulads`.`formas_pagamento` (`idformas_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbaulads`.`itens_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaulads`.`itens_venda` (
  `iditens_venda` INT(11) NOT NULL AUTO_INCREMENT,
  `idvenda` INT(11) NOT NULL,
  `idproduto` INT(11) NOT NULL,
  `quantidade` INT(11) NOT NULL,
  `valor_unitario` DECIMAL(7,2) NOT NULL,
  `subtotal` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`iditens_venda`),
  INDEX `fk_vendas_has_produtos_produtos1_idx` (`idproduto` ASC),
  INDEX `fk_vendas_has_produtos_vendas1_idx` (`idvenda` ASC),
  CONSTRAINT `fk_vendas_has_produtos_produtos1`
    FOREIGN KEY (`idproduto`)
    REFERENCES `dbaulads`.`produtos` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendas_has_produtos_vendas1`
    FOREIGN KEY (`idvenda`)
    REFERENCES `dbaulads`.`vendas` (`idvenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
