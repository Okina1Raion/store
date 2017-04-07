-- MySQL Script generated by MySQL Workbench
-- 02/15/17 14:01:48
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(41) NOT NULL,
  `telephone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`suppliers` (
  `id_supplier` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(41) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(45) NOT NULL,
  `info` TINYTEXT NULL,
  PRIMARY KEY (`id_supplier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`isActive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`isActive` (
  `user_id` INT NOT NULL,
  `GET` VARCHAR(45) NOT NULL,
  `isActive` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `activation`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `id_category` INT NOT NULL AUTO_INCREMENT,
  `parent_id` INT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_category`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`favorites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`favorites` (
  `user_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `category_id`),
  INDEX `liked_category_idx` (`category_id` ASC),
  CONSTRAINT `user_like`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `liked_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `mydb`.`category` (`id_category`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`goods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`goods` (
  `id_goods` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `supplier_id` INT NULL,
  `numberOf` INT NOT NULL,
  `information` TINYTEXT NULL,
  `isAlwaysHere` TINYINT(1) NOT NULL DEFAULT 1,
  `isVisible` TINYINT(1) NOT NULL DEFAULT 1,
  `mark_id` INT NULL DEFAULT NULL,
  `key_words` TINYTEXT NOT NULL,
  `minimumOrderNum` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_goods`),
  INDEX `supplier_idx` (`supplier_id` ASC),
  CONSTRAINT `supplier`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `mydb`.`suppliers` (`id_supplier`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prices` (
  `goods_id` INT NOT NULL,
  `income_price` DOUBLE NOT NULL DEFAULT 0,
  `wholesale_persent` DOUBLE NOT NULL,
  `retail_persent` DOUBLE NOT NULL,
  `currency` VARCHAR(45) NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`goods_id`),
  CONSTRAINT `priced_goods`
    FOREIGN KEY (`goods_id`)
    REFERENCES `mydb`.`goods` (`id_goods`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`goodsInCategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`goodsInCategories` (
  `goods_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`goods_id`, `category_id`),
  INDEX `category_fo_goods_idx` (`category_id` ASC),
  CONSTRAINT `goods_in_category`
    FOREIGN KEY (`goods_id`)
    REFERENCES `mydb`.`goods` (`id_goods`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `category_fo_goods`
    FOREIGN KEY (`category_id`)
    REFERENCES `mydb`.`category` (`id_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`goodsImages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`goodsImages` (
  `goods_id` INT NOT NULL,
  `passToImage` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`goods_id`, `passToImage`),
  CONSTRAINT `image_goods`
    FOREIGN KEY (`goods_id`)
    REFERENCES `mydb`.`goods` (`id_goods`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`marks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`marks` (
  `goods_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `imagePass` TEXT(128) NOT NULL,
  PRIMARY KEY (`goods_id`),
  CONSTRAINT `goods_mark`
    FOREIGN KEY (`goods_id`)
    REFERENCES `mydb`.`goods` (`id_goods`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `id_orders` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `client_id` INT NOT NULL,
  `adress` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_orders`),
  INDEX `client_idx` (`client_id` ASC),
  CONSTRAINT `client`
    FOREIGN KEY (`client_id`)
    REFERENCES `mydb`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orderLists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orderLists` (
  `order_id` INT NOT NULL,
  `goods_id` INT NOT NULL,
  `number` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`order_id`, `goods_id`),
  INDEX `goods_in_list_idx` (`goods_id` ASC),
  CONSTRAINT `odrer_id_for`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`orders` (`id_orders`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `goods_in_list`
    FOREIGN KEY (`goods_id`)
    REFERENCES `mydb`.`goods` (`id_goods`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;