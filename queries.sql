


-- queries.sql

-- Fråga 1: Vilka filmer som firman äger, inklusive data om filmen.

SELECT * FROM view_MoviesInventory;

-- Fråga 2: Vilka filmer som finns i en viss genre.

SELECT * FROM view_genreV1;
SELECT * FROM view_genreV2;

-- Fråga 3: Vilka filmer som är uthyrda, vem som hyrde dem (kund) och vem som hyrde ut dem (anställd).

SELECT * FROM view_rentalLog;
SELECT * FROM view_rentalLogDATE;

-- Fråga 4: Vilka filmer som har gått över tiden, dvs filmer som inte har blivit återlämnade trots att de borde vara det, tillsammans med namnet på kunden som har hyrt den.

SELECT * FROM view_LateMoviesALL_LOG;
SELECT * FROM view_LateMoviesDATE;

-- Fråga 5: En lista över alla anställda och hur många filmer varje anställd har hyrt ut.

SELECT * FROM view_MoviesPerStaffALL_LOG;

-- Fråga 6: En lista med statistik över de mest uthyrda filmerna den senaste månaden. Se fråga 10.

SELECT * FROM view_MostWantedMovies;

-- Fråga 7: En Stored Procedure som ska köras när en film lämnas ut. Ska alltså sätta filmen till uthyrd, vem som hyrt den osv.

CALL sp_MarkMovieAsRented(0,0,0, @movieID, @movieName, @moviePriceText, @moviePrice, @dayOfRental, @dayOfReturn, @customer, @staff, @message);

select  @movieID AS `MOVIE ID`, @movieName AS `MOVIE NAME`, @moviePriceText AS `PRICING NAME`, @moviePrice AS `PRICE IN $`, 
@dayOfRental AS `DAY OF RENTAL`, @dayOfReturn AS `DAY OF RETURN`, @customer AS `CUSTOMER`, @staff AS `STAFF`,
@message AS MESSAGE;


-- Fråga 8: Gör en funktion som tar en film som parameter och returnerar olika värden beroende på om filmen är 
-- sent inlämnad eller inte. Dvs, om du matar in film nr 345 ska du få tillbaka TRUE om filmen är uthyrd men 
-- borde vara tillbakalämnad, annars FALSE. (1 och 0 funkar också om det är lättare.)

select func_isLateByDate (16);

-- INSTRUCTIONS:
-- To find a valid movieID, please run code for "late" and "not late" movies to get ID's to choose from.
-- is late = 1
-- select * from rentallog rl where rl.dteReturned is null and rl.dteCreated < date_add(current_date(), interval -4 day);
-- is not late = 0
-- select * from rentallog rl where rl.dteReturned is null and rl.dteCreated >= date_add(current_date(), interval -4 day);


-- Fråga 9: En Stored Procedure som ska köras när en film lämnas tillbaka. Den ska använda sig av
-- ovanstående funktion för att göra någon form av markering/utskrift om filmen är återlämnad för sent.

-- 0 = random moies.
CALL sp_ReturnMovie(0, @message);
select @message;

-- Fråga 10: Du ska underhålla en statistiktabell med hjälp av triggers. När du lämnar ut en fil ska det göras en notering 
-- om det i din statistiktabell. Du får inte lägga till informationen från din SP ovan, det ska skötas med triggers.

select * from isNotInStoreBackUp;

