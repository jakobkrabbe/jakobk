-- redovisning 2018-03-29 DATABASE :: VIDEOUTHYRNING

-- KODEN BESTÅR AV TRE DELAR
-- 1. SKAPA DATABAS + TABELLER
-- 2. LÄGG IN DATA
-- 3. RENSA, FÖRBEREDA DATA FÖR VERKLIGT SCENARIO.

DROP DATABASE IF EXISTS jakobk;

CREATE DATABASE IF NOT EXISTS jakobk;

USE jakobk;

-- DROP TABLE IF EXISTS users;

-- 1. priceCategory :: olika priser för olika typer av filmer (5)
-- https://mockaroo.com/2636cd90 (äkta fejk. används inte, men behövs för modellen.)
CREATE TABLE priceCategory (
intID integer NOT NULL AUTO_INCREMENT, 
strName varchar(50) NOT NULL, 
intPrice integer NOT NULL, 
PRIMARY KEY (intID)
);

-- 2. genre :: olika genrer för olika typer av filmer (11)
-- https://mockaroo.com/7b7fb7f0  (äkta fejk. används inte, men behövs för modellen.)
CREATE TABLE genre (
intID integer NOT NULL AUTO_INCREMENT, 
strName varchar(50) NOT NULL, 
PRIMARY KEY (intID)
);

-- 3. skådisar :: olika skådisar för olika typer av filmer (300)
-- https://mockaroo.com/b0666b90
CREATE TABLE actors (
intID integer NOT NULL AUTO_INCREMENT, 
strFirstName varchar(50) NOT NULL, 
strLastName varchar(50) NOT NULL, 
dteBirthOfYear date NOT NULL, 
strText varchar(500) NOT NULL, 
PRIMARY KEY (intID)
);

-- 4. regisörer :: olika regisörer för olika av filmer (50)
-- https://mockaroo.com/47fb7c80
CREATE TABLE directors (
intID integer NOT NULL AUTO_INCREMENT, 
strFirstName varchar(50) NOT NULL, 
strLastName varchar(50) NOT NULL, 
dteBirthOfYear date NOT NULL, 
strText varchar(500) NOT NULL, 
PRIMARY KEY (intID)
);

-- 5. personal :: våra medarbetare (10)
-- https://mockaroo.com/60611970
CREATE TABLE staff (
intID integer NOT NULL AUTO_INCREMENT, 
dteCreated datetime NOT NULL, 
strFirstName varchar(50) NOT NULL, 
strLastName varchar(50) NOT NULL, 
strStreet varchar(50) NOT NULL, 
strCity varchar(50) NOT NULL, 
strZip varchar(20), 
strPhone1 varchar(50), 
strPhone2 varchar(50), 
strEmail varchar(50) NOT NULL, 
strPassword varchar(50) NOT NULL, 
PRIMARY KEY (intID)
);

-- 6. kunder :: kundlistan, den kända! (200)
-- https://mockaroo.com/420c0080
CREATE TABLE customers (
intID integer NOT NULL AUTO_INCREMENT, 
dteCreated datetime NOT NULL, 
strFirstName varchar(50) NOT NULL, 
strLastName varchar(50) NOT NULL, 
strStreet varchar(50) NOT NULL, 
strCity varchar(50) NOT NULL, 
strZip varchar(20), 
strPhone1 varchar(50), 
strPhone2 varchar(50), 
strEmail varchar(50) NOT NULL, 
strPassword varchar(50) NOT NULL, 
PRIMARY KEY (intID)
);

--  7. movie :: alla filmerna (300)
-- https://mockaroo.com/8040d340
CREATE TABLE movies (
intID integer NOT NULL AUTO_INCREMENT, 
dteCreated datetime NOT NULL, 
strName varchar(200) NOT NULL, 
strYear varchar(12)  NOT NULL,
intPriceCategoryID integer NOT NULL, 
intDirectorID integer NOT NULL, 
intGenreID integer NOT NULL, 
strGenre varchar(100) ,
strLength varchar(6) ,
strISBN varchar(20)  NOT NULL, 
strDescription varchar(255) NOT NULL,
strtext varchar(1000)  NOT NULL,
PRIMARY KEY (intID)
);

-- 9 vilken skådis till vilken film (1.000)
-- https://mockaroo.com/1d1acc70
CREATE TABLE movieActor (
intMovieID integer NOT NULL, 
intActorID integer NOT NULL, 
FOREIGN KEY ( intMovieID ) REFERENCES movies ( intID ),
FOREIGN KEY ( intActorID ) REFERENCES actors ( intID )
);
CREATE TABLE movieActorXX (
intMovieID integer NOT NULL, 
intActorID integer NOT NULL
);

-- 10. rental log :: what movie is / were in what place? (1.000 in a year)
-- https://mockaroo.com/b8cdc2d0
CREATE TABLE rentalLog (
intID integer NOT NULL AUTO_INCREMENT, 
dteCreated datetime NOT NULL, 
intMovieID integer NOT NULL, 
intCustomerID integer NOT NULL, 
intStaffID integer NOT NULL, 
dteReturn datetime, 
dteReturned datetime, 
PRIMARY KEY (intID),
FOREIGN KEY ( intMovieID ) REFERENCES movies ( intID ),
FOREIGN KEY ( intCustomerID ) REFERENCES customers ( intID ),
FOREIGN KEY ( intStaffID ) REFERENCES staff ( intID )
);


