

DROP DATABASE IF EXISTS jakobk;


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

-- customers (7)
insert into customers (strName, strEmail, strPassword) value ('Petra Nilsson', 'petra@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Sara Molander', 'sara@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Bryan Adams', 'bryan@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Curt Cobain', 'curt@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Ingrid Nilsson', 'ingrid@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Petra Marklund', 'september@gmail.com', '123');
insert into customers (strName, strEmail, strPassword) value ('Bruce Willis', 'bruce@gmail.com', '123');

-- insert movies (20)
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


-- TODAY = 2018-05-13
-- 3. prepare data, insert fake log
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID)
value ('2018-05-11', '1','1','1');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID)
value ('2018-05-12', '2','2','2');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID)
value ('2018-05-07', '3','3','2');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID)
value ('2018-05-06', '4','1','2');

insert into isNotInStore (dteCreated, intMovieID, intRentalLogID) value ('2018-05-11', 1, 1);
insert into isNotInStore (dteCreated, intMovieID, intRentalLogID) value ('2018-05-12', 2, 2);

insert into isNotInStore (dteCreated, intMovieID, intRentalLogID) value ('2018-05-07', 3, 3);
insert into isNotInStore (dteCreated, intMovieID, intRentalLogID) value ('2018-05-06', 4, 4);

-- 5. prepare data, insert fake log
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-01', '1','1','1','2018-04-05');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-02', '2','2','1','2018-04-06');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-03', '3','3','1','2018-04-09');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-04', '4','4','1','2018-04-09');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-05', '5','4','1','2018-04-09');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-06', '6','5','1','2018-04-10');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-07', '1','1','1','2018-04-12');

insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-01', '7','7','2','2018-04-05');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-02', '8','5','2','2018-04-06');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-03', '9','6','2','2018-04-09');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-04', '10','4','2','2018-04-09');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-05', '11','4','2','2018-04-09');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-06', '12','5','2','2018-04-10');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-07', '13','7','2','2018-04-12');


insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-15', '1','1','1','2018-04-19');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-16', '2','2','1','2018-04-22');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-17', '3','3','1','2018-04-28');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-18', '4','4','1','2018-04-20');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-15', '5','4','1','2018-04-20');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-16', '6','5','1','2018-04-18');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-17', '1','1','1','2018-04-21');

insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-15', '7','7','2','2018-04-19');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-16', '8','5','2','2018-04-19');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-17', '9','6','2','2018-04-19');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-15', '10','4','2','2018-04-18');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-16', '11','4','2','2018-04-20');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-17', '12','5','2','2018-04-20');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-18', '13','7','2','2018-04-22');

insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-22', '14','5','2','2018-04-26');
insert into rentalLog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
value ('2018-04-22', '15','7','2','2018-04-26');

-- Fråga 10: Du ska underhålla en statistiktabell med hjälp av triggers. När du lämnar ut en fil ska det göras en notering 
-- om det i din statistiktabell. Du får inte lägga till informationen från din SP ovan, det ska skötas med triggers.

DROP TRIGGER IF EXISTS tr_isnotinstoreBackUp;
DELIMITER //
CREATE TRIGGER tr_isnotinstoreBackUp
AFTER DELETE ON isnotinstore 
FOR EACH ROW
BEGIN
	INSERT INTO isNotInStoreBackUp (intBackUpID, dteCreated, intMovieID, intRentalLogID)
    VALUES (OLD.intID, OLD.dteCreated, OLD.intMovieID, OLD.intRentalLogID);
END//
DELIMITER ;


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

DROP VIEW IF EXISTS view_LateMovies;
CREATE VIEW view_LateMovies AS
SELECT m.intID AS `ID`, m.strName AS `MOVIE NAME`, c.strName AS CUSTOMER,
s.strName AS STAFF,  DATE(rl.dteCreated) AS `HANDED OUT`,
DATE_ADD(rl.dteCreated, INTERVAL 4 DAY) AS `DATE OF RETURN`, DATE(rl.dteReturned) AS `RETURNED`
FROM rentalLog rl
JOIN staff s ON rl.intStaffID = s.intID
JOIN customers c ON rl.intCustomerID = c.intID
JOIN movies m ON rl.intMovieID = m.intID
WHERE rl.dteReturned NOT BETWEEN rl.dteCreated AND date_add(rl.dteCreated, interval 4 day)
ORDER BY m.strName;
where date_add(rl.dteCreated, interval 4 day) < '2018-05-13';

-- 5. lista över alla anställda och hur många filmer de har hyrt ut.
DROP VIEW IF EXISTS view_MoviesPerStaff;
CREATE VIEW view_MoviesPerStaff AS
SELECT s.strName AS `STAFF / EMPLOYER`,
(SELECT COUNT(*) AS MoviesPerStaff FROM rentallog rl WHERE rl.intStaffID = s.intID  ) AS `MOVIE PER STAFF MEMBER`
FROM staff s
ORDER BY `MOVIE PER STAFF MEMBER` DESC;

-- Fråga 6: En lista med statistik över de mest uthyrda filmerna den senaste månaden. Se fråga 10.

DROP VIEW IF EXISTS view_MostWantedMovies;
CREATE VIEW view_MostWantedMovies AS 
SELECT m.strName AS `MOVIE NAME`,
(SELECT GROUP_CONCAT(DATE(rl.dteCreated)) FROM rentalLog rl
WHERE rl.intMovieID = m.intID AND (rl.dteCreated BETWEEN date_add('2018-05-13', INTERVAL -1 MONTH) AND '2018-05-13')
) AS `DATE OF RENTAL`,
(SELECT COUNT(rl.intID)  FROM rentalLog rl
WHERE rl.intMovieID = m.intID AND (rl.dteCreated BETWEEN date_add('2018-05-13', INTERVAL -1 MONTH) AND '2018-05-13')
) AS `MOST WANTED IN A MONTH`
FROM rentallog rl
JOIN movies m ON rl.intMovieID = m.intID
WHERE rl.dteCreated BETWEEN date_add('2018-05-13', INTERVAL -1 MONTH) AND '2018-05-13'
GROUP BY m.strName
ORDER BY `MOST WANTED IN A MONTH` DESC;

-- Fråga 7: En Stored Procedure som ska köras när en film lämnas ut. Ska alltså sätta filmen till uthyrd, vem som hyrt den osv.

DROP PROCEDURE IF EXISTS sp_MarkMovieAsRented;
DELIMITER //
CREATE PROCEDURE sp_MarkMovieAsRented(IN sp_MovieID int, IN sp_CustomerID int, IN sp_StaffID int, 
OUT out_Message varchar(100))
BEGIN

	DECLARE local_MovieID int default 0;
    DECLARE local_CustomerID int default 0;
    DECLARE local_StaffID int default 0;
    DECLARE local_lastID int default 0;

	set local_MovieID = sp_MovieID;
	set local_CustomerID = sp_MovieID;
	set local_StaffID = sp_MovieID;

	-- insert log file
	INSERT INTO rentallog (dteCreated, intMovieID, intCustomerID, intStaffID) 
	VALUES (current_date(), local_MovieID, local_CustomerID, local_StaffID );
    SET local_lastID = (select intid from rentallog order by intID desc limit 1,1);
	INSERT INTO isnotinstore (dteCreated, intMovieID, intRentalLogID) VALUES (current_date(), local_MovieID, local_lastID );
       
	SET out_Message = "Thank you for choosing MAX Video Rental!";
END //
DELIMITER ;

-- 8. en funktion som kollar om en film finns eller ej
-- tar en film som parameter och returnerar 1 om den är sen, 0 om allt är i sin ording.alter

DROP FUNCTION IF EXISTS func_isLateByDate;
DELIMITER //
CREATE FUNCTION func_isLateByDate ( f_movieID INT ) RETURNS int
BEGIN
	DECLARE local_intRentalLogID int DEFAULT 0;
	DECLARE local_dteCreated date;
	DECLARE valDateDiff int DEFAULT 0;
	-- 0 is fine. all is good
    -- 1 is late, not fine. not good.
    
    -- GET ID FOR LOG.
	select intRentalLogID into local_intRentalLogID from isnotinstore where intMovieID = f_movieID;
	IF local_intRentalLogID >= 1 THEN
		select rl.dteCreated into local_dteCreated from rentallog rl where intID = local_intRentalLogID;
        
        IF date_add(local_dteCreated, interval 4 day) > '2018-05-13' THEN
			return 0;
		ELSE
			return 1;
		END IF;
	ELSE 
		-- no movie met the criteria
        return 2;
    END IF;
END //
DELIMITER ;

-- Fråga 9: En Stored Procedure som ska köras när en film lämnas tillbaka. Den ska använda sig av
-- ovanstående funktion för att göra någon form av markering/utskrift om filmen är återlämnad för sent.

DROP PROCEDURE IF EXISTS sp_ReturnMovie;
DELIMITER //
CREATE PROCEDURE sp_ReturnMovie(IN intMovieID int, OUT strMessage varchar(200))
BEGIN
	DECLARE sp_intMovieID int default 0;
	DECLARE sp_rentalLogID int default 0;
	DECLARE intIsMovieLate int default 0;
    
    SET sp_intMovieID = intMovieID;
    SET intIsMovieLate = func_isLateByDate(sp_intMovieID);
    
    IF intIsMovieLate <= 1 THEN
		-- GET ID FOR LOG
        SELECT i.intRentalLogID INTO sp_rentalLogID from isnotinstore i WHERE i.intMovieID = sp_intMovieID;
        -- UPDATE LOG
        UPDATE rentallog rl SET rl.dteReturned = '2018-05-13' WHERE rl.intID = sp_rentalLogID;
        -- DELETE IS NOT IN STORE
        DELETE FROM isnotinstore  WHERE isnotinstore.intMovieID = sp_intMovieID;
    END IF;

    IF intIsMovieLate = 0 THEN
		SET strMessage = CONCAT('FALSE. Movie is out but not late. = ', intIsMovieLate);
    ELSEIF intIsMovieLate = 1 THEN
		SET strMessage = CONCAT('TRUE. Movie is out but late for return. = ', intIsMovieLate);
	ELSE
		SET strMessage = CONCAT('Movie not found. No changes are made.', intIsMovieLate);
	END IF;
END//
DELIMITER ;

