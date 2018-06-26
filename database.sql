

drop database if exists jakobk;


-- mysql workbench forward engineering

set @old_unique_checks=@@unique_checks, unique_checks=0;
set @old_foreign_key_checks=@@foreign_key_checks, foreign_key_checks=0;
set @old_sql_mode=@@sql_mode, sql_mode='traditional,allow_invalid_dates';

-- -----------------------------------------------------
-- schema jakobk
-- -----------------------------------------------------

-- -----------------------------------------------------
-- schema jakobk
-- -----------------------------------------------------
create schema if not exists `jakobk` default character set utf8 ;
use `jakobk` ;

-- -----------------------------------------------------
-- table `jakobk`.`actors`
-- -----------------------------------------------------
create table if not exists `jakobk`.`actors` (
  `intid` int(11) not null auto_increment,
  `strname` varchar(100) null default null,
  primary key (`intid`))
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `jakobk`.`customers`
-- -----------------------------------------------------
create table if not exists `jakobk`.`customers` (
  `intid` int(11) not null auto_increment,
  `strname` varchar(45) null default null,
  `stremail` varchar(45) null default null,
  `strpassword` varchar(45) null default null,
  primary key (`intid`),
  unique index `intid_unique` (`intid` asc))
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `jakobk`.`directors`
-- -----------------------------------------------------
create table if not exists `jakobk`.`directors` (
  `intid` int(11) not null auto_increment,
  `strname` varchar(200) null default null,
  primary key (`intid`))
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `jakobk`.`staff`
-- -----------------------------------------------------
create table if not exists `jakobk`.`staff` (
  `intid` int(11) not null auto_increment,
  `strname` varchar(100) null default null,
  `stremail` varchar(50) null default null,
  `strpassword` varchar(45) null default null,
  primary key (`intid`),
  unique index `intid_unique` (`intid` asc))
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `jakobk`.`movies`
-- -----------------------------------------------------
create table if not exists `jakobk`.`movies` (
  `intid` int(11) not null auto_increment,
  `strname` varchar(200) null default null,
  `stryear` varchar(20) null default null,
  `intprice` int null,
  `intdirectorid` int(11) not null,
  `strgenre` varchar(200) null default null,
  `intlength` int(11) null default null,
  `strdescription` varchar(500) null default null,
  primary key (`intid`),
  unique index `intid_unique` (`intid` asc),
  index `fk_movies_directors_idx` (`intdirectorid` asc),
  constraint `fk_movies_directors`
    foreign key (`intdirectorid`)
    references `jakobk`.`directors` (`intid`)
    on delete no action
    on update no action)
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `jakobk`.`rentallog`
-- -----------------------------------------------------
create table if not exists `jakobk`.`rentallog` (
  `intid` int(11) not null auto_increment,
  `dtecreated` date null default null,
  `intmovieid` int(11) not null,
  `intcustomerid` int(11) not null,
  `intstaffid` int(11) not null,
  `dtereturned` date null default null,
  primary key (`intid`),
  unique index `intid_unique` (`intid` asc),
  index `fk_rentallog_customer1_idx` (`intcustomerid` asc),
  index `fk_rentallog_staff1_idx` (`intstaffid` asc),
  index `fk_rentallog_movies1_idx` (`intmovieid` asc),
  constraint `fk_rentallog_customer1`
    foreign key (`intcustomerid`)
    references `jakobk`.`customers` (`intid`)
    on delete no action
    on update no action,
  constraint `fk_rentallog_staff1`
    foreign key (`intstaffid`)
    references `jakobk`.`staff` (`intid`)
    on delete no action
    on update no action,
  constraint `fk_rentallog_movies1`
    foreign key (`intmovieid`)
    references `jakobk`.`movies` (`intid`)
    on delete no action
    on update no action)
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `jakobk`.`isnotinstore`
-- -----------------------------------------------------
create table if not exists `jakobk`.`isnotinstore` (
  `intid` int(11) not null auto_increment,
  `dtecreated` date null default null,
  `intmovieid` int(11) not null,
  `intrentallogid` int(11) not null,
  primary key (`intid`),
  unique index `intid_unique` (`intid` asc),
  index `fk_isnotinstore_rentallog1_idx` (`intrentallogid` asc),
  index `fk_isnotinstore_movies1_idx` (`intmovieid` asc),
  constraint `fk_isnotinstore_rentallog1`
    foreign key (`intrentallogid`)
    references `jakobk`.`rentallog` (`intid`)
    on delete no action
    on update no action,
  constraint `fk_isnotinstore_movies1`
    foreign key (`intmovieid`)
    references `jakobk`.`movies` (`intid`)
    on delete no action
    on update no action)
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `jakobk`.`isnotinstorebackup`
-- -----------------------------------------------------
create table if not exists `jakobk`.`isnotinstorebackup` (
  `intid` int(11) not null auto_increment,
  `intbackupid` int(11) null default null,
  `dtecreated` date null default null,
  `intmovieid` int(11) null default null,
  `intrentallogid` int(11) null default null,
  primary key (`intid`))
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `jakobk`.`movieactor`
-- -----------------------------------------------------
create table if not exists `jakobk`.`movieactor` (
  `intmovieid` int(11) not null,
  `intactorid` int(11) not null,
  index `fk_movieactor_movies1_idx` (`intmovieid` asc),
  index `fk_movieactor_actors1_idx` (`intactorid` asc),
  constraint `fk_movieactor_movies1`
    foreign key (`intmovieid`)
    references `jakobk`.`movies` (`intid`)
    on delete no action
    on update no action,
  constraint `fk_movieactor_actors1`
    foreign key (`intactorid`)
    references `jakobk`.`actors` (`intid`)
    on delete no action
    on update no action)
engine = innodb
default character set = utf8;


set sql_mode=@old_sql_mode;
set foreign_key_checks=@old_foreign_key_checks;
set unique_checks=@old_unique_checks;

-- insert data

insert into actors (strname) value ('julia roberts');
insert into actors (strname) value ('richard gere');
insert into actors (strname) value ('mike oldfield');
insert into actors (strname) value ('anders karlsson');
insert into actors (strname) value ('john wayne');
insert into actors (strname) value ('little richard');
insert into actors (strname) value ('robert gustavsson');
insert into actors (strname) value ('agnes eriksson');
insert into actors (strname) value ('povel ramel');
insert into actors (strname) value ('allram east');
insert into actors (strname) value ('james bond');


insert into directors (strname) value ('arne långstrump');
insert into directors (strname) value ('erik jönsson');
insert into directors (strname) value ('sofia erlandsson');
insert into directors (strname) value ('ingen alls');
insert into directors (strname) value ('per mohall');
insert into directors (strname) value ('lisa frost');
insert into directors (strname) value ('arne anka');

insert into staff (strname, stremail, strpassword) value ('urban olson', 'urban@gmail.com', '123');
insert into staff (strname, stremail, strpassword) value ('anna stensson', 'anna@gmail.com', '456');

-- customers (7)
insert into customers (strname, stremail, strpassword) value ('petra nilsson', 'petra@gmail.com', '123');
insert into customers (strname, stremail, strpassword) value ('sara molander', 'sara@gmail.com', '123');
insert into customers (strname, stremail, strpassword) value ('bryan adams', 'bryan@gmail.com', '123');
insert into customers (strname, stremail, strpassword) value ('curt cobain', 'curt@gmail.com', '123');
insert into customers (strname, stremail, strpassword) value ('ingrid nilsson', 'ingrid@gmail.com', '123');
insert into customers (strname, stremail, strpassword) value ('petra marklund', 'september@gmail.com', '123');
insert into customers (strname, stremail, strpassword) value ('bruce willis', 'bruce@gmail.com', '123');

-- insert movies (20)
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('hela havet stormar', 1980, 49, 1, 'humor', 90, 'en helt vanlig dat på arbetet. vad kan gå fel? ja, det är mycket ska det visa sig!');
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('hela havet stormar', 1980, 49, 1, 'humor', 90, 'en helt vanlig dat på arbetet. vad kan gå fel? ja, det är mycket ska det visa sig!');

insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('vem räddar willie?', 1990, 49, 2, 'barn', 30, 'willie är på dåligt humör och sprider dålig stämning i byn till alla som råkar vara där...');
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('vem räddar willie?', 1990, 49, 2, 'barn', 30, 'willie är på dåligt humör och sprider dålig stämning i byn till alla som råkar vara där...');

insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('the bad, the evil', 2000, 49, 3, 'skräck', 95, 'vem smyger omkring på kyrkogården efter en fackliga arbetstiden? nån med ambitioner att göra ett bra jhobb....?');
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('the bad, the evil', 2000, 49, 3, 'skräck', 95, 'vem smyger omkring på kyrkogården efter en fackliga arbetstiden? nån med ambitioner att göra ett bra jhobb....?');
-- 7
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('lyckans ost', 1996, 49, 4, 'humor', 110, 'en glad kommedi om problemet med att ta livet på allvar!');
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('lyckans ost', 1996, 49, 4, 'humor', 110, 'en glad kommedi om problemet med att ta livet på allvar!');
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('lyckans ost', 1996, 49, 4, 'humor', 110, 'en glad kommedi om problemet med att ta livet på allvar!');
-- 10
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('en svans i soppan', 2014, 49, 5, 'skräck', 100, 'soppan... vilken soppa!');
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('en svans i soppan', 2014, 49, 5, 'skräck', 100, 'soppan... vilken soppa!');
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('en svans i soppan', 2014, 49, 5, 'skräck', 100, 'soppan... vilken soppa!');
-- 13
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('vem stängde dörren?', 1999, 49, 6, 'skräck', 80, 'en historia om en dörr, baserad på en verklig händelse.');
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('vem stängde dörren?', 1999, 49, 6, 'skräck', 80, 'en historia om en dörr, baserad på en verklig händelse.');
-- 15
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('inget att förlora', 1986, 49, 7, 'komedi', 210, 'en gång förirrade sig en man i ett köpcenter.');
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('inget att förlora', 1986, 49, 7, 'komedi', 210, 'en gång förirrade sig en man i ett köpcenter.');
insert into movies (strname, stryear, intprice, intdirectorid, strgenre, intlength, strdescription) value
('inget att förlora', 1986, 49, 7, 'komedi', 210, 'en gång förirrade sig en man i ett köpcenter.');


insert into movieactor (intmovieid, intactorid) value ('1','1');
insert into movieactor (intmovieid, intactorid) value ('1','2');
insert into movieactor (intmovieid, intactorid) value ('2','1');
insert into movieactor (intmovieid, intactorid) value ('2','2');
insert into movieactor (intmovieid, intactorid) value ('3','3');
insert into movieactor (intmovieid, intactorid) value ('3','4');
insert into movieactor (intmovieid, intactorid) value ('3','5');
insert into movieactor (intmovieid, intactorid) value ('4','3');
insert into movieactor (intmovieid, intactorid) value ('4','4');
insert into movieactor (intmovieid, intactorid) value ('4','5');
insert into movieactor (intmovieid, intactorid) value ('5','6');
insert into movieactor (intmovieid, intactorid) value ('5','7');
insert into movieactor (intmovieid, intactorid) value ('6','6');
insert into movieactor (intmovieid, intactorid) value ('6','7');
insert into movieactor (intmovieid, intactorid) value ('7','8');
insert into movieactor (intmovieid, intactorid) value ('8','8');
insert into movieactor (intmovieid, intactorid) value ('9','8');

insert into movieactor (intmovieid, intactorid) value ('10','8');
insert into movieactor (intmovieid, intactorid) value ('11','8');
insert into movieactor (intmovieid, intactorid) value ('12','8');

insert into movieactor (intmovieid, intactorid) value ('13','9');
insert into movieactor (intmovieid, intactorid) value ('14','9');

insert into movieactor (intmovieid, intactorid) value ('15','9');
insert into movieactor (intmovieid, intactorid) value ('16','10');
insert into movieactor (intmovieid, intactorid) value ('17','11');


-- today = 2018-05-13
-- 3. prepare data, insert fake log
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid)
value ('2018-05-11', '1','1','1');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid)
value ('2018-05-12', '2','2','2');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid)
value ('2018-05-07', '3','3','2');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid)
value ('2018-05-06', '4','1','2');

insert into isnotinstore (dtecreated, intmovieid, intrentallogid) value ('2018-05-11', 1, 1);
insert into isnotinstore (dtecreated, intmovieid, intrentallogid) value ('2018-05-12', 2, 2);

insert into isnotinstore (dtecreated, intmovieid, intrentallogid) value ('2018-05-07', 3, 3);
insert into isnotinstore (dtecreated, intmovieid, intrentallogid) value ('2018-05-06', 4, 4);

-- 5. prepare data, insert fake log
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-01', '1','1','1','2018-04-05');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-02', '2','2','1','2018-04-06');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-03', '3','3','1','2018-04-09');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-04', '4','4','1','2018-04-09');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-05', '5','4','1','2018-04-09');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-06', '6','5','1','2018-04-10');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-07', '1','1','1','2018-04-12');

insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-01', '7','7','2','2018-04-05');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-02', '8','5','2','2018-04-06');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-03', '9','6','2','2018-04-09');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-04', '10','4','2','2018-04-09');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-05', '11','4','2','2018-04-09');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-06', '12','5','2','2018-04-10');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-07', '13','7','2','2018-04-12');


insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-15', '1','1','1','2018-04-19');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-16', '2','2','1','2018-04-22');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-17', '3','3','1','2018-04-28');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-18', '4','4','1','2018-04-20');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-15', '5','4','1','2018-04-20');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-16', '6','5','1','2018-04-18');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-17', '1','1','1','2018-04-21');

insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-15', '7','7','2','2018-04-19');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-16', '8','5','2','2018-04-19');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-17', '9','6','2','2018-04-19');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-15', '10','4','2','2018-04-18');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-16', '11','4','2','2018-04-20');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-17', '12','5','2','2018-04-20');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-18', '13','7','2','2018-04-22');

insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-22', '14','5','2','2018-04-26');
insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid, dtereturned)
value ('2018-04-22', '15','7','2','2018-04-26');

-- fråga 10: du ska underhålla en statistiktabell med hjälp av triggers. när du lämnar ut en fil ska det göras en notering
-- om det i din statistiktabell. du får inte lägga till informationen från din sp ovan, det ska skötas med triggers.

drop trigger if exists tr_isnotinstorebackup;
delimiter //
create trigger tr_isnotinstorebackup
after delete on isnotinstore
for each row
begin
	insert into isnotinstorebackup (intbackupid, dtecreated, intmovieid, intrentallogid)
    values (old.intid, old.dtecreated, old.intmovieid, old.intrentallogid);
end//
delimiter ;


-- fråga 1: vilka filmer som firman äger, inklusive data om filmen.
drop view if exists view_moviesinventory;
create view `view_moviesinventory` as
select m.intid as `id`, m.strname as `title`, m.stryear as `release`, m.intprice as `price`,
d.strname as `director`,
(select group_concat(a.strname ) from actors a, movieactor ma where a.intid = ma.intactorid and ma.intmovieid = m.intid ) as `actors in the movie`,
m.strgenre as `genre`, m.intlength as `lenght`, m.strdescription as `description`
from movies m
left join directors d on d.intid = m.intdirectorid
group by m.strname order by m.strname;

-- fråga 2: vilka filmer som finns i en viss genre.
drop view if exists view_genre;
create view view_genre as
select m.strgenre as genre, count(m.strname) as `nr of movies`, group_concat('id:', m.intid, ' ', m.strname) as `name of movie`
from movies m
group by m.strgenre order by `nr of movies` desc;

-- 3. vilka filmer är uthyrda, vem som hyrde (kund) och vem som hyrde ut dom
-- date = 2018-05-13

drop view if exists view_rentallog;
create view view_rentallog as
select m.intid as `id`, m.strname as `movie name`, c.strname as customer,
s.strname as staff,  date(rl.dtecreated) as `handed out`,
date(rl.dtecreated) + interval 4 day as `date of return`, date(rl.dtereturned) as `return date`
from rentallog rl
join staff s on rl.intstaffid = s.intid
join customers c on rl.intcustomerid = c.intid
join movies m on rl.intmovieid = m.intid
order by rl.dtecreated, m.strname;


-- 4. vilka filmer har gått över tiden. vilka har inte blivit återlämnade.

drop view if exists view_latemovies;
create view view_latemovies as
select m.intid as `id`, m.strname as `movie name`, c.strname as customer,
s.strname as staff,  date(rl.dtecreated) as `handed out`,
date_add(rl.dtecreated, interval 4 day) as `date of return`, date(rl.dtereturned) as `returned`
from rentallog rl
join staff s on rl.intstaffid = s.intid
join customers c on rl.intcustomerid = c.intid
join movies m on rl.intmovieid = m.intid
where rl.dtereturned not between rl.dtecreated and date_add(rl.dtecreated, interval 4 day)
order by m.strname;


-- 5. lista över alla anställda och hur många filmer de har hyrt ut.
drop view if exists view_moviesperstaff;
create view view_moviesperstaff as
select s.strname as `staff / employer`,
(select count(*) as moviesperstaff from rentallog rl where rl.intstaffid = s.intid  ) as `movie per staff member`
from staff s
order by `movie per staff member` desc;

-- fråga 6: en lista med statistik över de mest uthyrda filmerna den senaste månaden. se fråga 10.

drop view if exists view_mostwantedmovies;
create view view_mostwantedmovies as
select m.strname as `movie name`,
(select group_concat(date(rl.dtecreated)) from rentallog rl
where rl.intmovieid = m.intid and (rl.dtecreated between date_add('2018-05-13', interval -1 month) and '2018-05-13')
) as `date of rental`,
(select count(rl.intid)  from rentallog rl
where rl.intmovieid = m.intid and (rl.dtecreated between date_add('2018-05-13', interval -1 month) and '2018-05-13')
) as `most wanted in a month`
from rentallog rl
join movies m on rl.intmovieid = m.intid
where rl.dtecreated between date_add('2018-05-13', interval -1 month) and '2018-05-13'
group by m.strname
order by `most wanted in a month` desc;

-- fråga 7: en stored procedure som ska köras när en film lämnas ut. ska alltså sätta filmen till uthyrd, vem som hyrt den osv.

drop procedure if exists sp_markmovieasrented;
delimiter //
create procedure sp_markmovieasrented(in sp_movieid int, in sp_customerid int, in sp_staffid int,
out out_message varchar(100))
begin

	declare local_movieid int default 0;
    declare local_customerid int default 0;
    declare local_staffid int default 0;
    declare local_lastid int default 0;

	set local_movieid = sp_movieid;
	set local_customerid = sp_movieid;
	set local_staffid = sp_movieid;

	-- insert log file
	insert into rentallog (dtecreated, intmovieid, intcustomerid, intstaffid)
	values (current_date(), local_movieid, local_customerid, local_staffid );
    set local_lastid = (select intid from rentallog order by intid desc limit 1,1);
	insert into isnotinstore (dtecreated, intmovieid, intrentallogid) values (current_date(), local_movieid, local_lastid );

	set out_message = "thank you for choosing max video rental!";
end //
delimiter ;

-- 8. en funktion som kollar om en film finns eller ej
-- tar en film som parameter och returnerar 1 om den är sen, 0 om allt är i sin ording.alter

drop function if exists func_islatebydate;
delimiter //
create function func_islatebydate ( f_movieid int ) returns int
begin
	declare local_intrentallogid int default 0;
	declare local_dtecreated date;
	declare valdatediff int default 0;
	-- 0 is fine. all is good
    -- 1 is late, not fine. not good.

    -- get id for log.
	select intrentallogid into local_intrentallogid from isnotinstore where intmovieid = f_movieid;
	if local_intrentallogid >= 1 then
		select rl.dtecreated into local_dtecreated from rentallog rl where intid = local_intrentallogid;

        if date_add(local_dtecreated, interval 4 day) > '2018-05-13' then
			return 0;
		else
			return 1;
		end if;
	else
		-- no movie met the criteria
        return 2;
    end if;
end //
delimiter ;

-- fråga 9: en stored procedure som ska köras när en film lämnas tillbaka. den ska använda sig av
-- ovanstående funktion för att göra någon form av markering/utskrift om filmen är återlämnad för sent.

drop procedure if exists sp_returnmovie;
delimiter //
create procedure sp_returnmovie(in intmovieid int, out strmessage varchar(200))
begin
	declare sp_intmovieid int default 0;
	declare sp_rentallogid int default 0;
	declare intismovielate int default 0;

    set sp_intmovieid = intmovieid;
    set intismovielate = func_islatebydate(sp_intmovieid);

    if intismovielate <= 1 then
		-- get id for log
        select i.intrentallogid into sp_rentallogid from isnotinstore i where i.intmovieid = sp_intmovieid;
        -- update log
        update rentallog rl set rl.dtereturned = '2018-05-13' where rl.intid = sp_rentallogid;
        -- delete is not in store
        delete from isnotinstore  where isnotinstore.intmovieid = sp_intmovieid;
    end if;

    if intismovielate = 0 then
		set strmessage = concat('false. movie is out but not late. = ', intismovielate);
    elseif intismovielate = 1 then
		set strmessage = concat('true. movie is out but late for return. = ', intismovielate);
	else
		set strmessage = concat('movie not found. no changes are made.', intismovielate);
	end if;
end//
delimiter ;
