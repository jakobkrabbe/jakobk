

DROP DATABASE IF EXISTS jakobk;

CREATE DATABASE IF NOT EXISTS jakobk;

USE jakobk;



-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema jakobk
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema jakobk
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jakobk` DEFAULT CHARACTER SET utf8 ;
USE `jakobk` ;

-- -----------------------------------------------------
-- Table `jakobk`.`actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jakobk`.`actors` (
  `intID` INT(11) NOT NULL AUTO_INCREMENT,
  `strName` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`intID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jakobk`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jakobk`.`customers` (
  `intID` INT(11) NOT NULL AUTO_INCREMENT,
  `strName` VARCHAR(45) NULL DEFAULT NULL,
  `strEmail` VARCHAR(45) NULL DEFAULT NULL,
  `strPassword` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`intID`),
  UNIQUE INDEX `intID_UNIQUE` (`intID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jakobk`.`directors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jakobk`.`directors` (
  `intID` INT(11) NOT NULL AUTO_INCREMENT,
  `strName` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`intID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jakobk`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jakobk`.`staff` (
  `intID` INT(11) NOT NULL AUTO_INCREMENT,
  `strName` VARCHAR(100) NULL DEFAULT NULL,
  `strEmail` VARCHAR(50) NULL DEFAULT NULL,
  `strPassword` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`intID`),
  UNIQUE INDEX `intID_UNIQUE` (`intID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jakobk`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jakobk`.`movies` (
  `intID` INT(11) NOT NULL AUTO_INCREMENT,
  `strName` VARCHAR(200) NULL DEFAULT NULL,
  `strYear` VARCHAR(20) NULL DEFAULT NULL,
  `intPrice` INT NULL,
  `intDirectorID` INT(11) NOT NULL,
  `strGenre` VARCHAR(200) NULL DEFAULT NULL,
  `intLength` INT(11) NULL DEFAULT NULL,
  `strDescription` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`intID`),
  UNIQUE INDEX `intID_UNIQUE` (`intID` ASC),
  INDEX `fk_movies_directors_idx` (`intDirectorID` ASC),
  CONSTRAINT `fk_movies_directors`
    FOREIGN KEY (`intDirectorID`)
    REFERENCES `jakobk`.`directors` (`intID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jakobk`.`rentallog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jakobk`.`rentallog` (
  `intID` INT(11) NOT NULL AUTO_INCREMENT,
  `dteCreated` DATE NULL DEFAULT NULL,
  `intMovieID` INT(11) NOT NULL,
  `intCustomerID` INT(11) NOT NULL,
  `intStaffID` INT(11) NOT NULL,
  `dteReturned` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`intID`),
  UNIQUE INDEX `intID_UNIQUE` (`intID` ASC),
  INDEX `fk_rentallog_customer1_idx` (`intCustomerID` ASC),
  INDEX `fk_rentallog_staff1_idx` (`intStaffID` ASC),
  INDEX `fk_rentallog_movies1_idx` (`intMovieID` ASC),
  CONSTRAINT `fk_rentallog_customer1`
    FOREIGN KEY (`intCustomerID`)
    REFERENCES `jakobk`.`customers` (`intID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rentallog_staff1`
    FOREIGN KEY (`intStaffID`)
    REFERENCES `jakobk`.`staff` (`intID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rentallog_movies1`
    FOREIGN KEY (`intMovieID`)
    REFERENCES `jakobk`.`movies` (`intID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jakobk`.`isnotinstore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jakobk`.`isnotinstore` (
  `intID` INT(11) NOT NULL AUTO_INCREMENT,
  `dteCreated` DATE NULL DEFAULT NULL,
  `intMovieID` INT(11) NOT NULL,
  `intRentalLogID` INT(11) NOT NULL,
  PRIMARY KEY (`intID`),
  UNIQUE INDEX `intID_UNIQUE` (`intID` ASC),
  INDEX `fk_isnotinstore_rentallog1_idx` (`intRentalLogID` ASC),
  INDEX `fk_isnotinstore_movies1_idx` (`intMovieID` ASC),
  CONSTRAINT `fk_isnotinstore_rentallog1`
    FOREIGN KEY (`intRentalLogID`)
    REFERENCES `jakobk`.`rentallog` (`intID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_isnotinstore_movies1`
    FOREIGN KEY (`intMovieID`)
    REFERENCES `jakobk`.`movies` (`intID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jakobk`.`isnotinstorebackup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jakobk`.`isnotinstorebackup` (
  `intID` INT(11) NOT NULL AUTO_INCREMENT,
  `intBackUpID` INT(11) NULL DEFAULT NULL,
  `dteCreated` DATE NULL DEFAULT NULL,
  `intMovieID` INT(11) NULL DEFAULT NULL,
  `intRentalLogID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`intID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jakobk`.`movieactor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jakobk`.`movieactor` (
  `intMovieID` INT(11) NOT NULL,
  `intActorID` INT(11) NOT NULL,
  INDEX `fk_movieactor_movies1_idx` (`intMovieID` ASC),
  INDEX `fk_movieactor_actors1_idx` (`intActorID` ASC),
  CONSTRAINT `fk_movieactor_movies1`
    FOREIGN KEY (`intMovieID`)
    REFERENCES `jakobk`.`movies` (`intID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movieactor_actors1`
    FOREIGN KEY (`intActorID`)
    REFERENCES `jakobk`.`actors` (`intID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;





-- insert data

insert into actors (strName) value ('Julia Roberts');
insert into actors (strName) value ('Richard Gere');
insert into actors (strName) value ('Mike Oldfield');
insert into actors (strName) value ('Anders Karlsson');
insert into actors (strName) value ('John Wayne');
insert into actors (strName) value ('Little Richard');
insert into actors (strName) value ('Robert Gustavsson');
insert into actors (strName) value ('Agnes Eriksson');
insert into actors (strName) value ('Povel Ramel');
insert into actors (strName) value ('Allram East');
insert into actors (strName) value ('James Bond');


insert into directors (strName) value ('Arne Långstrump');
insert into directors (strName) value ('Erik Jönsson');
insert into directors (strName) value ('Sofia Erlandsson');
insert into directors (strName) value ('Ingen Alls');
insert into directors (strName) value ('Per Mohall');
insert into directors (strName) value ('Lisa Frost');
insert into directors (strName) value ('Arne Anka');

insert into staff (strName, strEmail, strPassword) value ('Urban Olson', 'urban@gmail.com', '123');
insert into staff (strName, strEmail, strPassword) value ('Anna Stensson', 'anna@gmail.com', '456');

insert into customers (strName, strEmail, strPassword) value ('Petra Nilsson', 'petra@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Sara Molander', 'sara@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Bryan Adams', 'bryan@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Curt Cobain', 'curt@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Ingrid Nilsson', 'ingrid@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Petra Marklund', 'september@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Bruce Willis', 'bruce@gmail.com', '123');

insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Hela havet stormar', 1980, 49, 1, 'Humor', 90, 'En helt vanlig dat på arbetet. Vad kan gå fel? Ja, det är mycket ska det visa sig!');
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Hela havet stormar', 1980, 49, 1, 'Humor', 90, 'En helt vanlig dat på arbetet. Vad kan gå fel? Ja, det är mycket ska det visa sig!');

insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Vem räddar Willie?', 1990, 49, 2, 'Barn', 30, 'Willie är på dåligt humör och sprider dålig stämning i byn till alla som råkar vara där...');
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Vem räddar Willie?', 1990, 49, 2, 'Barn', 30, 'Willie är på dåligt humör och sprider dålig stämning i byn till alla som råkar vara där...');

insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('The bad, the evil', 2000, 49, 3, 'Skräck', 95, 'Vem smyger omkring på kyrkogården efter en fackliga arbetstiden? Nån med ambitioner att göra ett bra jhobb....?');
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('The bad, the evil', 2000, 49, 3, 'Skräck', 95, 'Vem smyger omkring på kyrkogården efter en fackliga arbetstiden? Nån med ambitioner att göra ett bra jhobb....?');
-- 7
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Lyckans ost', 1996, 49, 4, 'Humor', 110, 'En glad kommedi om problemet med att ta livet på allvar!');
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Lyckans ost', 1996, 49, 4, 'Humor', 110, 'En glad kommedi om problemet med att ta livet på allvar!');
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Lyckans ost', 1996, 49, 4, 'Humor', 110, 'En glad kommedi om problemet med att ta livet på allvar!');
-- 10
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('En svans i soppan', 2014, 49, 5, 'Skräck', 100, 'Soppan... vilken soppa!');
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('En svans i soppan', 2014, 49, 5, 'Skräck', 100, 'Soppan... vilken soppa!');
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('En svans i soppan', 2014, 49, 5, 'Skräck', 100, 'Soppan... vilken soppa!');
-- 13
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Vem stängde dörren?', 1999, 49, 6, 'Skräck', 80, 'En historia om en dörr, baserad på en verklig händelse.');
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Vem stängde dörren?', 1999, 49, 6, 'Skräck', 80, 'En historia om en dörr, baserad på en verklig händelse.');
-- 15
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Inget att förlora', 1986, 49, 7, 'Komedi', 210, 'En gång förirrade sig en man i ett köpcenter.');
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Inget att förlora', 1986, 49, 7, 'Komedi', 210, 'En gång förirrade sig en man i ett köpcenter.');
insert into movies (strName, strYear, intPrice, intDirectorID, strGenre, intLength, strDescription) value 
('Inget att förlora', 1986, 49, 7, 'Komedi', 210, 'En gång förirrade sig en man i ett köpcenter.');


insert into movieActor (intMovieID, intActorID) value ('1','1');
insert into movieActor (intMovieID, intActorID) value ('1','2');
insert into movieActor (intMovieID, intActorID) value ('2','1');
insert into movieActor (intMovieID, intActorID) value ('2','2');
insert into movieActor (intMovieID, intActorID) value ('3','3');
insert into movieActor (intMovieID, intActorID) value ('3','4');
insert into movieActor (intMovieID, intActorID) value ('3','5');
insert into movieActor (intMovieID, intActorID) value ('4','3');
insert into movieActor (intMovieID, intActorID) value ('4','4');
insert into movieActor (intMovieID, intActorID) value ('4','5');
insert into movieActor (intMovieID, intActorID) value ('5','6');
insert into movieActor (intMovieID, intActorID) value ('5','7');
insert into movieActor (intMovieID, intActorID) value ('6','6');
insert into movieActor (intMovieID, intActorID) value ('6','7');
insert into movieActor (intMovieID, intActorID) value ('7','8');
insert into movieActor (intMovieID, intActorID) value ('8','8');
insert into movieActor (intMovieID, intActorID) value ('9','8');

insert into movieActor (intMovieID, intActorID) value ('10','8');
insert into movieActor (intMovieID, intActorID) value ('11','8');
insert into movieActor (intMovieID, intActorID) value ('12','8');

insert into movieActor (intMovieID, intActorID) value ('13','9');
insert into movieActor (intMovieID, intActorID) value ('14','9');

insert into movieActor (intMovieID, intActorID) value ('15','9');
insert into movieActor (intMovieID, intActorID) value ('16','10');
insert into movieActor (intMovieID, intActorID) value ('17','11');

-- 3. prepare data, insert fake log


insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID) 
value ('2018-05-11', '1','1','1');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID) 
value ('2018-05-12', '2','2','2');

insert into isNotInStore (intMovieID, intRentalLogID) value (1, 1);
insert into isNotInStore (intMovieID, intRentalLogID) value (2, 2);





-- Fråga 1: Vilka filmer som firman äger, inklusive data om filmen.
DROP VIEW IF EXISTS view_MoviesInventory;
CREATE VIEW `view_MoviesInventory` AS
SELECT m.intID AS `ID`, m.strName AS `TITLE`, m.strYear AS `RELEASE`, m.intPrice as `PRICE`,
d.strName AS `DIRECTOR`,
(SELECT GROUP_CONCAT(a.strName ) FROM actors a, movieactor ma WHERE a.intID = ma.intActorID AND ma.intMovieID = m.intID ) AS `ACTORS IN THE MOVIE`,
m.strGenre AS `GENRE`, m.intLength AS `LENGHT`, m.strDescription AS `DESCRIPTION`
FROM movies m
LEFT JOIN directors d ON d.intID = m.intDirectorID
GROUP BY m.strName ORDER BY m.strName;

-- Fråga 2: Vilka filmer som finns i en viss genre.
DROP VIEW IF EXISTS view_genre;
CREATE VIEW view_genre AS 
SELECT m.strGenre AS GENRE, COUNT(m.strName) AS `NR OF MOVIES`, GROUP_CONCAT('ID:', m.intID, ' ', m.strName) AS `NAME OF MOVIE` 
FROM movies m
GROUP BY m.strGenre ORDER BY `NR OF MOVIES` DESC;

-- 3. vilka filmer är uthyrda, vem som hyrde (kund) och vem som hyrde ut dom
-- date = 2018-05-13

DROP VIEW IF EXISTS view_rentalLog;
CREATE VIEW view_rentalLog AS 
SELECT m.intID AS `ID`, m.strName AS `MOVIE NAME`, c.strName AS CUSTOMER,
s.strName AS STAFF,  DATE(rl.dteCreated) AS `HANDED OUT`,
DATE(rl.dteCreated) + INTERVAL 4 DAY AS `DATE OF RETURN`, DATE(rl.dteReturned) AS `RETURN DATE` 
FROM rentalLog rl
JOIN staff s ON rl.intStaffID = s.intID
JOIN customers c ON rl.intCustomerID = c.intID
JOIN movies m ON rl.intMovieID = m.intID
ORDER BY rl.dteCreated, m.strName;


-- 4. vilka filmer har gått över tiden. vilka har inte blivit återlämnade.
DROP VIEW IF EXISTS view_LateMoviesALL_LOG;
CREATE VIEW view_LateMoviesALL_LOG AS 
SELECT m.strName AS `MOVIE NAME`, CONCAT(c.strFirstName, ' ', c.strLastName) AS CUSTOMER,
CONCAT(s.strFirstName, ' ', s.strLastName) AS STAFF,  DATE(rl.dteCreated) AS CREATED,
DATE(rl.dteCreated) + INTERVAL 4 DAY AS `DATE OF RETURN`, DATE(rl.dteReturned) AS RETURNED 
FROM rentalLog rl
JOIN staff s ON rl.intStaffID = s.intID
JOIN customers c ON rl.intCustomerID = c.intID
JOIN movies m ON rl.intMovieID = m.intID
WHERE rl.dteReturned NOT BETWEEN rl.dteCreated AND date_add(rl.dteCreated, interval 4 day)
ORDER BY m.strName;