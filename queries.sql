


-- queries.sql

-- Fråga 1: Vilka filmer som firman äger, inklusive data om filmen.

SELECT * FROM view_MoviesInventory;

-- Fråga 2: Vilka filmer som finns i en viss genre.

SELECT * FROM view_genre;

-- Fråga 3: Vilka filmer som är uthyrda, vem som hyrde dem (kund) och vem som hyrde ut dem (anställd).

SELECT * FROM view_rentalLog;

-- Fråga 4: Vilka filmer som har gått över tiden, dvs filmer som inte har blivit återlämnade trots att de borde vara det, tillsammans med namnet på kunden som har hyrt den.

SELECT * FROM view_LateMovies;

-- Fråga 5: En lista över alla anställda och hur många filmer varje anställd har hyrt ut.

SELECT * FROM view_MoviesPerStaff;

-- Fråga 6: En lista med statistik över de mest uthyrda filmerna den senaste månaden. Se fråga 10.

SELECT * FROM view_MostWantedMovies;

-- Fråga 7: En Stored Procedure som ska köras när en film lämnas ut. Ska alltså sätta filmen till uthyrd, vem som hyrt den osv.

-- intMovieID = 1-20
-- intCustomerID = 1-7
-- intStaffID = 1-2
CALL sp_MarkMovieAsRented(2,2,2, @message);

select @message AS `MESSAGE`;


-- Fråga 8: Gör en funktion som tar en film som parameter och returnerar olika värden beroende på om filmen är 
-- sent inlämnad eller inte. Dvs, om du matar in film nr 345 ska du få tillbaka TRUE om filmen är uthyrd men 
-- borde vara tillbakalämnad, annars FALSE. (1 och 0 funkar också om det är lättare.)
    -- 1 is late, not fine. not good.
	-- 0 is fine. all is good
-- movie ID #1 = 1, is fine
-- movie ID #4 = should be returned

select * from isnotinstore i , rentallog rl where rl.intID = i.intRentalLogID; 
select func_isLateByDate (1); -- FALSE. Movie is out but not late
select func_isLateByDate (2); -- FALSE. Movie is out but not late
select func_isLateByDate (3); -- TRUE. Movie is out but late for return.
select func_isLateByDate (4); -- TRUE. Movie is out but late for return.
select func_isLateByDate (5); -- not found = 2



-- INSTRUCTIONS:
-- To find a valid movieID, please run code for "late" and "not late" movies to get ID's to choose from.
-- is late = 1
-- select * from rentallog rl where rl.dteReturned is null and rl.dteCreated < date_add(current_date(), interval -4 day);
-- is not late = 0
-- select * from rentallog rl where rl.dteReturned is null and rl.dteCreated >= date_add(current_date(), interval -4 day);


-- Fråga 9: En Stored Procedure som ska köras när en film lämnas tillbaka. Den ska använda sig av
-- ovanstående funktion för att göra någon form av markering/utskrift om filmen är återlämnad för sent.
select * from isnotinstore;
select * from rentallog;
select * from isnotinstore i , rentallog rl where rl.intID = i.intRentalLogID; 
CALL sp_ReturnMovie(1, @message); -- FALSE. Movie is out but not late.
select @message;
CALL sp_ReturnMovie(2, @message); -- FALSE. Movie is out but not late.
select @message;
CALL sp_ReturnMovie(3, @message); -- TRUE. Movie is out but late for return.
select @message;
CALL sp_ReturnMovie(4, @message); -- TRUE. Movie is out but late for return.
select @message;
CALL sp_ReturnMovie(5, @message); -- Not found = 2. No changes are made.
select @message;

-- Fråga 10: Du ska underhålla en statistiktabell med hjälp av triggers. När du lämnar ut en fil ska det göras en notering 
-- om det i din statistiktabell. Du får inte lägga till informationen från din SP ovan, det ska skötas med triggers.

select * from isNotInStoreBackUp;

