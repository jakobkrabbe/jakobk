


-- queries.sql

-- fråga 1: vilka filmer som firman äger, inklusive data om filmen.

select * from view_moviesinventory;

-- fråga 2: vilka filmer som finns i en viss genre.

select * from view_genre;

-- fråga 3: vilka filmer som är uthyrda, vem som hyrde dem (kund) och vem som hyrde ut dem (anställd).

select * from view_rentallog;

-- fråga 4: vilka filmer som har gått över tiden, dvs filmer som inte har blivit återlämnade trots att de borde vara det, tillsammans med namnet på kunden som har hyrt den.

select * from view_latemovies;

-- fråga 5: en lista över alla anställda och hur många filmer varje anställd har hyrt ut.

select * from view_moviesperstaff;

-- fråga 6: en lista med statistik över de mest uthyrda filmerna den senaste månaden. se fråga 10.

select * from view_mostwantedmovies;

-- fråga 7: en stored procedure som ska köras när en film lämnas ut. ska alltså sätta filmen till uthyrd, vem som hyrt den osv.

-- intmovieid = 1-20
-- intcustomerid = 1-7
-- intstaffid = 1-2
call sp_markmovieasrented(2,2,2, @message);

select @message as `message`;


-- fråga 8: gör en funktion som tar en film som parameter och returnerar olika värden beroende på om filmen är
-- sent inlämnad eller inte. dvs, om du matar in film nr 345 ska du få tillbaka true om filmen är uthyrd men
-- borde vara tillbakalämnad, annars false. (1 och 0 funkar också om det är lättare.)
    -- 1 is late, not fine. not good.
	-- 0 is fine. all is good
-- movie id #1 = 1, is fine
-- movie id #4 = should be returned

select * from isnotinstore i , rentallog rl where rl.intid = i.intrentallogid;
select func_islatebydate (1); -- false. movie is out but not late
select func_islatebydate (2); -- false. movie is out but not late
select func_islatebydate (3); -- true. movie is out but late for return.
select func_islatebydate (4); -- true. movie is out but late for return.
select func_islatebydate (5); -- not found = 2



-- instructions:
-- to find a valid movieid, please run code for "late" and "not late" movies to get id's to choose from.
-- is late = 1
-- select * from rentallog rl where rl.dtereturned is null and rl.dtecreated < date_add(current_date(), interval -4 day);
-- is not late = 0
-- select * from rentallog rl where rl.dtereturned is null and rl.dtecreated >= date_add(current_date(), interval -4 day);


-- fråga 9: en stored procedure som ska köras när en film lämnas tillbaka. den ska använda sig av
-- ovanstående funktion för att göra någon form av markering/utskrift om filmen är återlämnad för sent.
select * from isnotinstore;
select * from rentallog;
select * from isnotinstore i , rentallog rl where rl.intid = i.intrentallogid;
call sp_returnmovie(1, @message); -- false. movie is out but not late.
select @message;
call sp_returnmovie(2, @message); -- false. movie is out but not late.
select @message;
call sp_returnmovie(3, @message); -- true. movie is out but late for return.
select @message;
call sp_returnmovie(4, @message); -- true. movie is out but late for return.
select @message;
call sp_returnmovie(5, @message); -- not found = 2. no changes are made.
select @message;

-- fråga 10: du ska underhålla en statistiktabell med hjälp av triggers. när du lämnar ut en fil ska det göras en notering
-- om det i din statistiktabell. du får inte lägga till informationen från din sp ovan, det ska skötas med triggers.

select * from isnotinstorebackup;
