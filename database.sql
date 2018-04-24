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
intPrice double NOT NULL, 
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
dteCreated datetime , 
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

-- 8. vilken skådis till vilken film (1.000)
-- https://mockaroo.com/1d1acc70
CREATE TABLE movieActor (
intMovieID integer NOT NULL, 
intActorID integer NOT NULL, 
FOREIGN KEY ( intMovieID ) REFERENCES movies ( intID ),
FOREIGN KEY ( intActorID ) REFERENCES actors ( intID )
);

-- 9. rental log :: what movie is / were in what place? (1.000 in a year)
-- https://mockaroo.com/b8cdc2d0
CREATE TABLE rentalLog (
intID integer NOT NULL AUTO_INCREMENT, 
dteCreated datetime , 
intMovieID integer , 
intCustomerID integer NOT NULL, 
intStaffID integer NOT NULL, 
dteReturned datetime, 
PRIMARY KEY (intID),
FOREIGN KEY ( intMovieID ) REFERENCES movies ( intID ),
FOREIGN KEY ( intCustomerID ) REFERENCES customers ( intID ),
FOREIGN KEY ( intStaffID ) REFERENCES staff ( intID )
);
-- 10. trigger / log 
CREATE TABLE rentalLogBackUp (
intID integer NOT NULL AUTO_INCREMENT, 
intBackUpID integer ,
dteCreated datetime , 
intMovieID integer , 
intCustomerID integer NOT NULL, 
intStaffID integer NOT NULL, 
dteReturned datetime, 
PRIMARY KEY (intID)
);

-- 9. vilken film finns "inne"
CREATE TABLE isNotInStore (
intID integer NOT NULL AUTO_INCREMENT, 
dteCreated datetime, 
intMovieID integer NOT NULL, 
intRentalLogID integer , 
PRIMARY KEY (intID),
FOREIGN KEY ( intMovieID ) REFERENCES movies ( intID )
);

-- 10. vilken film finns "inne" -- loggen med triggers
CREATE TABLE isNotInStoreBackUp (
intID integer NOT NULL AUTO_INCREMENT, 
intBackUpID integer ,
dteCreated datetime, 
intMovieID integer NOT NULL, 
intRentalLogID integer , 
PRIMARY KEY (intID)
);


-- INSERT äkta fejt data --

-- 1. prismodellen
insert into priceCategory (intID, strName, intPrice) values (1, 'Cheap as... ', 0.99);
insert into priceCategory (intID, strName, intPrice) values (2, 'OK deal', 1.99);
insert into priceCategory (intID, strName, intPrice) values (3, 'Upper limit', 2.99);
insert into priceCategory (intID, strName, intPrice) values (4, 'Rip-off', 3.99);
insert into priceCategory (intID, strName, intPrice) values (5, 'Gangster deal', 4.99);

-- 2. genre (11)
insert into genre (intID, strName) values (1, 'Film-Noir');
insert into genre (intID, strName) values (2, 'Comedy');
insert into genre (intID, strName) values (3, 'Drama');
insert into genre (intID, strName) values (4, 'IMAX');
insert into genre (intID, strName) values (5, 'Romance');
insert into genre (intID, strName) values (6, 'Crime');
insert into genre (intID, strName) values (7, 'Documentary');
insert into genre (intID, strName) values (8, 'Action');
insert into genre (intID, strName) values (9, 'Horror');
insert into genre (intID, strName) values (10, 'Thriller');
insert into genre (intID, strName) values (11, 'Children');


-- 3. actors (200)
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (1, 'Eva', 'Sonnenschein', '1922-12-30', '"Light-for-dates" with signs of fetal malnutrition, 1,000-1,249 grams');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (2, 'Jeannette', 'Janoschek', '1958-08-16', 'Ocular torticollis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (3, 'Siward', 'Geistbeck', '1962-12-14', 'Malignant neoplasm of vagina');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (4, 'Torr', 'Harmant', '1976-02-09', 'Closed fracture of one or more phalanges of foot');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (5, 'Minetta', 'Ethelstone', '1959-01-27', 'Aneurysm of splenic artery');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (6, 'Ondrea', 'Hulson', '1953-12-02', 'Other disorders of lactation, postpartum condition or complication');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (7, 'Sondra', 'Pimblett', '1956-01-27', 'Carcinoma in situ of rectum');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (8, 'Tish', 'Kittow', '1966-07-25', 'Pemphigus');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (9, 'Westleigh', 'Saulter', '1936-09-16', 'Secondary diabetes mellitus with other specified manifestations, not stated as uncontrolled, or unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (10, 'Glad', 'Stoeckle', '1937-03-02', 'Family history of ischemic heart disease');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (11, 'Patsy', 'MacScherie', '1994-07-13', 'Pneumonia due to mycoplasma pneumoniae');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (12, 'Mehetabel', 'Studde', '1983-10-28', 'Intermittent exotropia, alternating');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (13, 'Anastasia', 'Ingree', '1911-01-09', 'Retinal exudates and deposits');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (14, 'Osgood', 'Scholling', '1998-12-19', 'Arthropathy associated with other bacterial diseases, upper arm');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (15, 'Blinny', 'Binyon', '1937-01-01', 'Unspecified reduction deformity of upper limb');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (16, 'Niels', 'Bultitude', '1966-09-29', 'Chondroectodermal dysplasia');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (17, 'Clair', 'O'' Dornan', '1980-12-23', 'Other and unspecified effects of high altitude');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (18, 'Obie', 'Nobbs', '1937-08-17', 'Secondary diabetes mellitus with ophthalmic manifestations, not stated as uncontrolled, or unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (19, 'Bernadette', 'Mozzetti', '1928-10-01', 'Other diseases of pharynx, not elsewhere classified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (20, 'Rudolph', 'Ginn', '1927-07-07', 'Balantidiasis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (21, 'Noellyn', 'Kestle', '1958-01-15', 'Burn of esophagus');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (22, 'Trisha', 'Truitt', '1992-09-05', 'Coronary artery anomaly');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (23, 'Lazarus', 'Gorey', '1974-01-19', 'Cellulitis and abscess of hand, except fingers and thumb');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (24, 'Kinsley', 'Leve', '1952-04-27', 'Nephritis and nephropathy, not specified as acute or chronic, in diseases classified elsewhere');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (25, 'Renault', 'Witherop', '1932-12-08', 'Migraine, unspecified, with intractable migraine, so stated, with status migrainosus');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (26, 'Roddie', 'Brideoke', '1944-10-10', 'Severe atrophy of the maxilla');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (27, 'Ulrica', 'Eydel', '1924-01-28', 'Open dislocation of acromioclavicular (joint)');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (28, 'Harli', 'Wrinch', '1928-03-23', 'Other benign secondary hypertension');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (29, 'Port', 'Trayford', '1985-09-12', 'Other placental conditions, affecting management of mother, antepartum condition or complication');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (30, 'Auroora', 'Cubbit', '1908-12-26', 'Bipolar I disorder, most recent episode (or current) mixed, unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (31, 'Clemmy', 'Bedle', '1938-06-17', 'Open fracture of coracoid process');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (32, 'Tommy', 'Kiefer', '1948-08-22', 'Hemorrhagic detachment of retinal pigment epithelium');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (33, 'Theresina', 'Thorndale', '1988-01-11', 'Opioid abuse, continuous');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (34, 'Robena', 'Carp', '1952-06-23', 'Other complications of anesthesia or other sedation in labor and delivery, delivered, with or without mention of antepartum condition');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (35, 'Kirby', 'Goosnell', '1914-07-15', 'Other investigation and testing');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (36, 'Son', 'Soppett', '1906-06-15', 'Abscess of eyelid');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (37, 'Barret', 'Rathbone', '1948-06-27', 'Open dislocation of ankle');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (38, 'Trey', 'Bulfield', '1957-11-23', 'Family history of malignant neoplasm of kidney');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (39, 'Llewellyn', 'Tinman', '1901-07-11', 'Vascular abnormalities of conjunctiva');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (40, 'Mac', 'Hurdman', '1913-11-22', 'Infection and inflammatory reaction due to other genitourinary device, implant, and graft');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (41, 'Roana', 'Hawken', '1934-10-28', 'Pressure ulcer, heel');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (42, 'Nikolaus', 'Wooffinden', '1933-08-23', 'Hyperosmolality and/or hypernatremia');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (43, 'Benjamen', 'Bensen', '1949-12-21', 'Solitary pulmonary nodule');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (44, 'Russ', 'Liver', '1925-05-17', '"Light-for-dates" with signs of fetal malnutrition, 750-999 grams');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (45, 'Kristos', 'Gunney', '1996-03-07', 'Mechanical complication of tracheostomy');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (46, 'Gilberta', 'Luisetti', '1928-07-03', 'Open fracture of base of skull with subarachnoid, subdural, and extradural hemorrhage, with moderate [1-24 hours] loss of consciousness');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (47, 'Hyman', 'McGougan', '1927-05-29', 'Malignant neoplasm of bronchus and lung, unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (48, 'Jerri', 'Ofer', '1933-11-14', 'Acute thyroiditis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (49, 'Joice', 'Canete', '1926-09-19', 'Accidental fall from ladder');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (50, 'Huntley', 'Lashley', '1977-01-24', 'Hodgkin''s disease, unspecified type, intra-abdominal lymph nodes');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (51, 'Appolonia', 'Bartoletti', '1937-09-22', 'Legal circumstances');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (52, 'Benedict', 'Tromans', '1957-08-01', 'Acute respiratory failure following trauma and surgery');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (53, 'Thoma', 'Acott', '1953-12-15', 'Mixed disorders as reaction to stress');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (54, 'Maryanna', 'Eccleshare', '1901-11-20', 'Failure in suture and ligature during surgical operation');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (55, 'Hynda', 'Saylor', '1942-01-19', 'Orchitis and epididymitis, unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (56, 'Layne', 'Tyt', '1979-07-21', 'Unspecified adjustment reaction');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (57, 'Fidelio', 'Lithgow', '1977-06-22', 'Closed dislocation, vertebra, unspecified site');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (58, 'Regina', 'Semour', '1936-01-06', 'Severe birth asphyxia');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (59, 'Lissie', 'Jovey', '1998-08-27', 'Spectator at an event');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (60, 'Charita', 'Brigshaw', '1921-09-15', 'Other specific muscle disorders');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (61, 'Barbee', 'Rebert', '1921-07-26', 'Acute laryngotracheitis without mention of obstruction');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (62, 'Hy', 'Monnery', '1982-04-21', 'Other closed skull fracture with cerebral laceration and contusion, with no loss of consciousness');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (63, 'Hunfredo', 'Lacy', '1921-07-21', 'Other acquired deformities of toe');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (64, 'Lory', 'O'' Scallan', '1950-09-08', 'Pernicious anemia');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (65, 'Harlie', 'Lucio', '1901-07-25', 'Pathologic fracture of distal radius and ulna');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (66, 'Yovonnda', 'Mattisson', '1946-07-03', 'Meningococcal endocarditis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (67, 'Sadye', 'Leighfield', '1941-07-29', 'Other complications due to other vascular device, implant, and graft');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (68, 'Dmitri', 'Woodruff', '1950-10-18', 'Illegitimacy or illegitimate pregnancy');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (69, 'Johna', 'Dutteridge', '1947-05-05', 'Other specified complications of pregnancy, delivered, with mention of postpartum complication');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (70, 'Kath', 'Arkley', '1984-08-09', 'Acute myeloid leukemia, in remission');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (71, 'Modesta', 'Ivankovic', '1919-02-07', 'Other respiratory abnormalities');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (72, 'Johna', 'Billingham', '1924-10-18', 'Other specified ancylostoma');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (73, 'Bowie', 'Piddlesden', '1923-04-24', 'Medial epicondylitis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (74, 'Dallon', 'Radleigh', '1969-02-11', 'Great toe amputation status');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (75, 'Maritsa', 'Rouge', '1990-09-16', 'Open fracture of base of skull with other and unspecified intracranial hemorrhage, with prolonged [more than 24 hours] loss of consciousness and return to pre-existing conscious level');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (76, 'Kristy', 'Eagar', '1958-07-03', 'Cerebellar or brain stem laceration with open intracranial wound, with loss of consciousness of unspecified duration');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (77, 'Micheline', 'Martinello', '1937-10-10', 'Poisoning by keratolytics, keratoplastics, other hair treatment drugs and preparations');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (78, 'Lowrance', 'Duxfield', '1990-03-06', 'Interstitial keratitis, unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (79, 'Land', 'Blackly', '1968-01-09', 'Acute petrositis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (80, 'Bradly', 'Moubray', '1919-11-19', 'Other preterm infants, 500-749 grams');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (81, 'Alli', 'Langeren', '1923-06-08', 'General psychiatric examination, other and unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (82, 'Rania', 'Stoakley', '1964-08-04', 'Femoral hernia with obstruction, unilateral or unspecified (not specified as recurrent)');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (83, 'Eolande', 'Samweyes', '1939-10-09', 'Unspecified nonpsychotic mental disorder following organic brain damage');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (84, 'Lincoln', 'Behan', '1958-06-01', 'Periapical abscess with sinus');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (85, 'Emiline', 'Barnett', '1951-06-29', 'Other activity involving ice and snow');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (86, 'Lizzy', 'Laste', '1973-10-14', 'Personal history of malignant neoplasm of renal pelvis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (87, 'Haleigh', 'Paur', '1967-04-15', 'Accidental poisoning by benzodiazepine-based tranquilizers');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (88, 'Ripley', 'Bompass', '1997-07-14', 'Other specified bullous dermatoses');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (89, 'Davy', 'Kloska', '1992-10-21', 'Other congenital deformity of hip (joint)');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (90, 'Judi', 'Sandbrook', '1980-10-24', 'Other specified anomalies of respiratory system');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (91, 'Darcie', 'Menichini', '1965-02-23', 'Other specified open wounds of ocular adnexa');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (92, 'Bride', 'Colbeck', '1960-06-09', 'Immersion foot');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (93, 'Swen', 'Turville', '1904-11-05', 'Pulmonary complications of anesthesia or other sedation in labor and delivery, delivered, with or without mention of antepartum condition');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (94, 'Peria', 'Luciano', '1971-10-20', 'Typhoid fever');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (95, 'Bayard', 'Gautrey', '1920-02-04', 'Malignant histiocytosis, lymph nodes of axilla and upper limb');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (96, 'Winnah', 'Wilde', '1989-03-16', 'Injury to celiac and mesenteric arteries, other');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (97, 'Isaak', 'Brawn', '1935-04-17', 'Arthropathy associated with helminthiasis, site unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (98, 'Zonda', 'Hubball', '1968-10-13', 'Fetishism');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (99, 'Katusha', 'Whitmore', '1983-09-07', 'Other accidental drowning or submersion');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (100, 'Standford', 'Beernaert', '1972-03-28', 'Unspecified indication for care or intervention related to labor and delivery, unspecified as to episode of care or not applicable');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (101, 'Burr', 'Smallacombe', '1998-06-11', 'Injury to peroneal nerve');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (102, 'Bird', 'Euplate', '1912-02-10', 'Failed moderate sedation during procedure');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (103, 'Liva', 'Foulkes', '1958-04-12', 'Chronic maxillary sinusitis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (104, 'Brandais', 'Lawrey', '1993-03-05', 'Accidental poisoning by lead and its compounds and fumes');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (105, 'Michale', 'Sommersett', '1974-06-05', 'Open fracture of coronoid process of ulna');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (106, 'Samaria', 'Cutbush', '1960-02-22', 'Hypotropia');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (107, 'Deborah', 'Matus', '1976-03-20', 'Perpetrator of child and adult abuse, by other specified person');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (108, 'Emmey', 'Zecchinelli', '1976-09-12', 'Secondary diabetes mellitus with unspecified complication, uncontrolled');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (109, 'Monika', 'Mulqueen', '1971-11-05', 'Macrotia');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (110, 'Fredericka', 'Ellery', '1976-02-12', 'Unspecified disorder of joint, pelvic region and thigh');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (111, 'Mathilda', 'Bruhnke', '1966-03-06', 'Open wound of larynx with trachea, without mention of complication');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (112, 'Clarke', 'Pretious', '1909-06-28', 'Counseling for perpetrator of spousal and partner abuse');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (113, 'Gale', 'Leynton', '1942-04-19', 'Angiodysplasia of stomach and duodenum with hemorrhage');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (114, 'Torrie', 'Stennett', '2001-01-24', 'Stiff-man syndrome');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (115, 'Meridel', 'Grunbaum', '1987-08-21', 'Breech extraction, without mention of indication, unspecified as to episode of care or not applicable');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (116, 'Peadar', 'Peschka', '1918-03-20', 'Visual deprivation nystagmus');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (117, 'Frederick', 'Mickleburgh', '1957-02-21', 'Spontaneous abortion, without mention of complication, incomplete');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (118, 'Kathlin', 'Neylan', '1970-03-28', 'Hodgkin''s disease, lymphocytic depletion, spleen');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (119, 'Sig', 'Sodor', '1973-10-07', 'Screening examination for trypanosomiasis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (120, 'Gram', 'Leet', '1915-12-10', 'Centipede and venomous millipede (tropical) bite causing poisoning and toxic reactions');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (121, 'Isabelle', 'Gipp', '1993-05-25', 'Open fracture of mandible, multiple sites');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (122, 'Manya', 'Dorricott', '1930-01-21', 'Other specified housing or economic circumstances');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (123, 'Fleur', 'Creus', '1943-09-03', 'Second-degree perineal laceration, delivered, with or without mention of antepartum condition');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (124, 'Cordie', 'Baise', '1918-10-24', 'Unspecified abortion, complicated by damage to pelvic organs or tissues, complete');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (125, 'Candide', 'Trevena', '1991-03-07', 'Benign neoplasm of scrotum');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (126, 'Mata', 'Hews', '1907-09-19', 'Hypertrophic obstructive cardiomyopathy');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (127, 'Agnola', 'McFaul', '1951-05-16', 'Cervical incompetence, unspecified as to episode of care or not applicable');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (128, 'Doria', 'Ham', '1940-01-15', 'Closed fracture of shaft of fibula with tibia');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (129, 'Elysee', 'D''Almeida', '1965-09-13', 'Other primary progressive tuberculosis, tubercle bacilli found (in sputum) by microscopy');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (130, 'Fidel', 'Awin', '1940-12-28', 'Serous choroidal detachment');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (131, 'Tammie', 'Vanichkov', '1928-08-03', 'Sprain of sacrotuberous (ligament)');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (132, 'Jacintha', 'Huegett', '1967-02-06', 'Closed dislocation of radioulnar (joint), distal');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (133, 'Ange', 'Tatlowe', '1987-05-20', 'Osteitis condensans');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (134, 'Dario', 'Uc', '1924-10-03', 'Neoplasm of uncertain behavior of urinary organ, unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (135, 'Bekki', 'Snar', '1972-02-05', 'Other closed skull fracture with other and unspecified intracranial hemorrhage, with no loss of consciousness');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (136, 'Ludvig', 'Daal', '1955-11-02', 'Epilepsy complicating pregnancy, childbirth, or the puerperium, delivered, with mention of postpartum complication');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (137, 'Lotti', 'Hengoed', '1953-06-04', 'Quadruplet gestation, with two or more monochorionic fetuses');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (138, 'Lanny', 'Crosser', '1950-02-02', 'Toxic multinodular goiter with mention of thyrotoxic crisis or storm');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (139, 'Trudey', 'Town', '1997-10-10', 'Chondrocalcinosis, unspecified, shoulder region');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (140, 'Fin', 'McDuff', '1917-01-16', 'Injury due to war operations from pellets (rifle)');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (141, 'Hanny', 'Tunsley', '1974-12-09', 'Crushing injury of hip');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (142, 'Leilah', 'Simmgen', '2001-04-05', 'Other seborrheic dermatitis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (143, 'Pooh', 'Cayette', '1953-10-11', 'Accidental cut, puncture, perforation or hemorrhage during administration of enema');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (144, 'Vincents', 'Cornill', '1917-03-08', 'Chronic leukemia of unspecified cell type, in relapse');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (145, 'Georas', 'Fuzzey', '1913-06-05', 'Peripheral neuritis in pregnancy, postpartum condition or complication');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (146, 'Neal', 'Amthor', '1903-07-27', 'Dermatochalasis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (147, 'Gayla', 'Sergeant', '1937-11-11', 'Malignant histiocytosis, unspecified site, extranodal and solid organ sites');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (148, 'Layla', 'Cuxson', '1911-06-27', 'Gastrojejunal ulcer, unspecified as acute or chronic, without mention of hemorrhage or perforation, with obstruction');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (149, 'Helenelizabeth', 'Duffy', '1995-12-16', 'Suicide and self-inflicted poisoning by gas distributed by pipeline');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (150, 'Hewet', 'Sale', '1974-10-30', 'Rupture of bladder, nontraumatic');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (151, 'Weider', 'Valente', '1948-08-16', 'Malignant neoplasm of anterior two-thirds of tongue, part unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (152, 'Eleonore', 'Freak', '1927-06-05', 'Pre-operative respiratory examination');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (153, 'Branden', 'Brundill', '1933-03-09', 'Unspecified secondary syphilis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (154, 'Marius', 'Bautiste', '1939-04-04', 'Aortic valve disorders');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (155, 'Janenna', 'Boick', '1963-12-04', 'Cutaneous leishmaniasis, American');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (156, 'Susette', 'Damato', '1930-08-08', 'Accidental poisoning by other specified drugs');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (157, 'Dorri', 'Nelthorpe', '1919-05-06', 'Unspecified anomaly of genital organs');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (158, 'Frankie', 'Buckley', '1945-12-08', 'Nonallopathic lesions, pelvic region');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (159, 'Clevie', 'Espinheira', '1943-07-17', 'Other and unspecified abnormality of organs and soft tissues of pelvis, delivered, with or without mention of antepartum condition');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (160, 'Johan', 'Mullally', '1957-11-03', 'Acute infection of pinna');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (161, 'Ilise', 'Shave', '1948-10-20', 'Other and unspecified alcohol dependence, in remission');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (162, 'Rodolph', 'Rassell', '1996-08-18', 'Unspecified anomaly of fallopian tubes and broad ligaments');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (163, 'Amandie', 'Peterson', '1996-04-16', 'Malignant neoplasm of other sites of floor of mouth');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (164, 'Mace', 'Raynham', '1982-05-13', 'Lipoprotein deficiencies');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (165, 'Alonzo', 'Bleything', '2001-10-11', 'Injury to nerves, unspecified site');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (166, 'Minetta', 'Smissen', '1999-11-19', 'Neoplasm of uncertain behavior of pleura, thymus, and mediastinum');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (167, 'Jessika', 'Arnolds', '1905-06-19', 'Personal history of malignant neoplasm of bone');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (168, 'Trula', 'Danzey', '1903-04-18', 'Other and unspecified cerebral laceration and contusion, with open intracranial wound, with brief [less than one hour] loss of consciousness');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (169, 'Claudine', 'Slidders', '1957-08-25', 'Other allergy, other than to medicinal agents');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (170, 'Bernardine', 'Addington', '1911-07-14', 'Articular cartilage disorder, multiple sites');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (171, 'Noellyn', 'Clendennen', '1936-10-29', 'Streptobacillary fever');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (172, 'Inessa', 'Probate', '1906-02-22', 'Other inflammatory disorders of male genital organs');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (173, 'Marion', 'Blench', '1908-03-17', 'Hypertensive heart and chronic kidney disease, malignant, with heart failure and with chronic kidney disease stage I through stage IV, or unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (174, 'Astrix', 'Kerry', '1935-10-03', 'Accidental poisoning by mercury and its compounds and fumes');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (175, 'Juana', 'Czadla', '1997-08-28', 'Pick''s disease');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (176, 'Dacey', 'Falls', '1973-07-19', 'Screening for other rheumatic disorders');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (177, 'Emlyn', 'Lorking', '1954-12-24', 'Alcoholism in family');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (178, 'Clim', 'Garret', '1925-07-24', 'Burn [any degree] involving 40-49 percent of body surface with third degree burn, 20-29%');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (179, 'Isac', 'Grewar', '1968-09-15', 'Papanicolaou smear of vagina with cytologic evidence of malignancy');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (180, 'Sutherland', 'Wetwood', '1978-07-10', 'Monoplegia of lower limb affecting nondominant side');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (181, 'Andy', 'Imloch', '1914-12-10', 'Machinery accident in water transport injuring occupant of other watercraft -- other than crew');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (182, 'Jamesy', 'Huddleston', '1984-06-02', 'Accident caused by travel and motion');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (183, 'Jerry', 'Iston', '1927-01-31', 'Fall on stairs or ladders in water transport injuring occupant of small boat, powered');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (184, 'Ugo', 'McCarney', '1932-12-24', 'Secondary malignant neoplasm of other urinary organs');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (185, 'Fransisco', 'Tenbrug', '1915-02-23', 'Contracture of joint, lower leg');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (186, 'Estevan', 'Peacey', '1912-09-13', 'Unspecified complication of anesthesia and other sedation in labor and delivery, postpartum condition or complication');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (187, 'Robbie', 'Fairrie', '1920-12-14', 'Unspecified injury of lung with open wound into thorax');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (188, 'Gusella', 'Farrants', '1901-04-13', 'Corneal anesthesia and hypoesthesia');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (189, 'Keelby', 'McGrorty', '1991-05-05', 'Mottled teeth');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (190, 'Merrilee', 'Sparrowe', '1952-01-10', 'Other prophylactic gland removal');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (191, 'Calida', 'Sabbin', '1953-07-03', 'Other fall from one level to another in water transport injuring dockers, stevedores');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (192, 'Rubin', 'Clemmensen', '1909-07-12', 'Aggressive periodontitis, unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (193, 'Beck', 'Rohfsen', '1924-07-17', 'Closed fracture of vault of skull without mention of intracranial injury, with loss of consciousness of unspecified duration');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (194, 'Carlye', 'Glendenning', '1919-09-21', 'Other and unspecified prion disease of central nervous system');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (195, 'Darnall', 'Kennett', '1939-05-16', 'Other umbilical cord complications complicating labor and delivery, delivered, with or without mention of antepartum condition');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (196, 'Lillis', 'Gaitone', '1994-06-21', 'Open wound of vagina, complicated');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (197, 'Rosaline', 'Binham', '1905-01-03', 'Disorders of thyrocalcitonin secretion');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (198, 'Betteann', 'Mercy', '1928-01-02', 'Other retained organic fragments');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (199, 'Belita', 'Slaymaker', '1982-02-26', 'Crushing injury of upper arm');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (200, 'Gregoire', 'Ledgley', '1946-09-09', 'Unspecified abortion, with other specified complications, unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (201, 'Tallou', 'Musselwhite', '1995-06-05', 'Falciparum malaria [malignant tertian]');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (202, 'Salli', 'Featherstonhaugh', '1931-10-11', 'Hodgkin''s disease, nodular sclerosis, intrathoracic lymph nodes');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (203, 'Miner', 'Meineken', '1972-04-12', 'Anomalies of ovaries');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (204, 'Toinette', 'Viscovi', '1976-04-22', 'Primary central nervous system lymphoma, intrathoracic lymph nodes');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (205, 'Jeremie', 'Gerritsma', '1930-10-09', 'Other specified air transport accidents injuring occupant of spacecraft');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (206, 'Maximilian', 'Grzegorzewicz', '1929-11-11', 'Accidental mechanical suffocation due to lack of air (in closed place)');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (207, 'Rosamond', 'Maryan', '1938-10-25', 'Closed fracture of condyle, femoral');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (208, 'Lucius', 'Sollime', '1925-12-09', 'Abdominal tenderness, other specified site');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (209, 'Pen', 'Shipley', '1974-12-14', 'Open posterior dislocation of hip');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (210, 'Dee dee', 'Le Marquand', '1909-06-17', 'Radial styloid tenosynovitis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (211, 'Udale', 'Sargison', '1968-09-10', 'Anaphylactic reaction due to eggs');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (212, 'Sherry', 'Labeuil', '1937-09-25', 'Tympanosclerosis involving tympanic membrane and ear ossicles');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (213, 'Vaughn', 'Bonicelli', '1960-03-18', 'Malignant neoplasm of rectum');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (214, 'Vinnie', 'Junes', '1979-03-05', 'Poisoning by unspecified antibiotic');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (215, 'Anita', 'Mewhirter', '1966-01-29', 'Outcome of delivery, twins, both liveborn');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (216, 'Xenia', 'Sisneros', '1961-03-28', 'Congenital nuclear cataract');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (217, 'Celestyna', 'Di Carli', '1973-01-07', 'Shoulder (girdle) dystocia, delivered, with or without mention of antepartum condition');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (218, 'Brigg', 'Baradel', '1950-08-09', 'Madelung''s deformity');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (219, 'Legra', 'Smurthwaite', '1974-02-07', 'Bcg vaccine causing adverse effects in therapeutic use');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (220, 'Terri', 'Podd', '1917-03-25', 'Body Mass Index 32.0-32.9, adult');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (221, 'Ravi', 'Corthes', '1976-12-07', 'Injury to portal vein');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (222, 'Nicolais', 'Goodrick', '1934-01-28', 'Congenital hydrocephalus');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (223, 'Valery', 'Mobley', '1905-03-27', 'Other open skull fracture with subarachnoid, subdural, and extradural hemorrhage, with moderate [1-24 hours] loss of consciousness');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (224, 'Maggee', 'Errey', '1997-05-21', 'Polycythemia vera');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (225, 'Emiline', 'Kagan', '1981-06-07', 'Presence of subdermal contraceptive implant');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (226, 'Erika', 'Dartnell', '2000-08-04', 'Other open skull fracture without mention of intracranial injury, with moderate [1-24 hours] loss of consciousness');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (227, 'Kelcy', 'McConigal', '1919-05-29', 'Unspecified infection or infestation of mother, delivered, with mention of postpartum complication');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (228, 'Waldon', 'Ander', '1909-03-31', 'Other lesion of median nerve');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (229, 'Gottfried', 'Nyland', '1989-01-28', 'Hereditary corneal dystrophy, unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (230, 'Elyssa', 'O''Sheerin', '1906-07-02', 'Nontraumatic rupture of achilles tendon');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (231, 'Gilberto', 'Delouch', '1991-05-02', 'Carrier or suspected carrier of other gastrointestinal pathogens');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (232, 'Kaye', 'Gapp', '1923-09-02', 'Other infections involving bone in diseases classified elsewhere, forearm');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (233, 'Tamqrah', 'Jeness', '1919-07-12', 'Special screening examination for Human papillomavirus (HPV)');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (234, 'Reeba', 'McPeeters', '1970-08-08', 'Excessive or frequent menstruation');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (235, 'Yehudi', 'Winders', '1933-05-19', 'Cataract in degenerative ocular disorders');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (236, 'Sioux', 'Aisman', '1981-11-06', 'Late effects of injuries due to legal intervention');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (237, 'Paten', 'Duce', '1984-11-22', 'Atheroembolism of lower extremity');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (238, 'Jodie', 'Lune', '1973-01-27', 'Hodgkin''s granuloma, lymph nodes of multiple sites');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (239, 'Chas', 'Kinsman', '1908-08-24', 'Stage II necrotizing enterocolitis in newborn');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (240, 'Sherwin', 'Nestle', '1911-08-15', 'Qualitative platelet defects');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (241, 'Delmar', 'Castanaga', '1963-06-05', 'Injury to posterior tibial nerve');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (242, 'Everard', 'Kopke', '1991-07-17', 'Mixed hearing loss, unilateral');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (243, 'Axe', 'Everleigh', '1991-12-14', 'Poisoning by other antihypertensive agents');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (244, 'Kate', 'Yanshin', '1970-02-14', 'Polymyalgia rheumatica');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (245, 'Emmaline', 'Lodwick', '1990-02-27', 'Other open skull fracture with cerebral laceration and contusion, unspecified state of consciousness');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (246, 'Anastasia', 'Bellay', '1916-09-27', 'Convalescence following other treatment');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (247, 'Flin', 'Nono', '1922-08-16', 'Hodgkin''s sarcoma, unspecified site, extranodal and solid organ sites');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (248, 'Georgianna', 'Jenks', '1958-07-31', 'Family history of malignant neoplasm of other genital organs');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (249, 'Lon', 'Godin', '1961-11-08', 'Soemmering''s ring');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (250, 'Constantia', 'Marrable', '1905-01-06', 'Mitral stenosis with insufficiency');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (251, 'Kerianne', 'Nazaret', '1907-01-09', 'Postvaccination fever');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (252, 'Shina', 'Salisbury', '1960-04-03', 'Spondylosis with myelopathy, lumbar region');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (253, 'Fairleigh', 'Caldaro', '1956-02-29', 'Acute myocardial infarction of unspecified site, subsequent episode of care');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (254, 'Giorgi', 'Martinat', '1917-08-23', 'Extradural hemorrhage following injury with open intracranial wound, with moderate [1-24 hours] loss of consciousness');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (255, 'Candi', 'McQuirter', '1997-03-14', '"Light-for-dates" without mention of fetal malnutrition, 750-999 grams');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (256, 'Aube', 'Farndale', '1943-07-08', 'Other specified diseases of pulmonary circulation');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (257, 'Rudyard', 'Challice', '1932-08-30', 'Pneumonia due to other specified bacteria');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (258, 'Perice', 'Housiaux', '1974-08-20', 'Cataract fragments in eye following cataract surgery');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (259, 'Gerri', 'Tapenden', '1903-08-30', 'Arthropathy associated with other viral diseases, shoulder region');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (260, 'Sofia', 'Barkley', '1951-03-11', 'Acute hepatitis C without mention of hepatic coma');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (261, 'Valerye', 'Antushev', '1903-11-19', 'Other specified respiratory tuberculosis, unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (262, 'Nina', 'Schukraft', '1916-03-17', 'Deep necrosis of underlying tissues [deep third degree]) without mention of loss of a body part, of breast');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (263, 'Constantine', 'Willmett', '1911-12-04', 'Open wound of gum (alveolar process), without mention of complication');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (264, 'Lori', 'Farnan', '1917-01-25', 'Blisters, epidermal loss [second degree] of other and multiple sites of trunk');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (265, 'Lennard', 'Casford', '2001-08-08', 'Heart valve replaced by transplant');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (266, 'Winnifred', 'Rew', '1910-04-08', 'Hodgkin''s sarcoma, unspecified site, extranodal and solid organ sites');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (267, 'Gale', 'Rodenburg', '1989-07-23', 'Other and unspecified superficial injury of face, neck, and scalp, without mention of infection');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (268, 'Asia', 'Walpole', '1910-05-21', 'Accident due to abandonment or neglect of infants and helpless persons');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (269, 'Vikky', 'Kirsz', '1949-02-19', 'Kaschin-Beck disease, pelvic region and thigh');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (270, 'Maynord', 'McVitie', '1981-10-01', 'Failed attempted abortion complicated by shock');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (271, 'Olly', 'Itzhaiek', '1981-12-03', 'Traumatic urethral stricture');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (272, 'Noellyn', 'Somerset', '1965-02-03', 'Other fall from one level to another in water transport injuring other specified person');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (273, 'Kandace', 'Raeburn', '1911-03-20', 'Unspecified systemic agent causing adverse effects in therapeutic use');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (274, 'Moselle', 'Guppy', '1970-07-05', 'Anomalies of cerebrovascular system');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (275, 'Friedrick', 'Terren', '2001-11-17', 'Accidental fall from other furniture');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (276, 'Dorie', 'Szach', '1917-01-13', 'Malignant neoplasm of rectosigmoid junction');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (277, 'Chan', 'Philbrook', '1915-02-02', 'Need for prophylactic vaccination and inoculation against respiratory syncytial virus (RSV)');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (278, 'Antons', 'Hatchard', '1983-06-04', 'Other open skull fracture with subarachnoid, subdural, and extradural hemorrhage, with prolonged [more than 24 hours] loss of consciousness and return to pre-existing conscious level');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (279, 'Kacey', 'Postle', '1901-10-04', 'Other road vehicle accidents injuring pedestrian');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (280, 'Franky', 'Meir', '1981-05-05', 'Disseminated chorioretinitis, unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (281, 'Niel', 'Fairey', '1997-03-03', 'Other multiple pregnancy with fetal loss and retention of one or more fetus(es), unspecified as to episode of care or not applicable');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (282, 'Jana', 'Bartell', '1956-01-31', 'Dermatophytosis of hand');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (283, 'Wilbert', 'Scafe', '1980-02-10', 'Traumatic pneumothorax without mention of open wound into thorax');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (284, 'Johnathan', 'O''Dyvoy', '1931-07-05', 'Meconium obstruction in fetus or newborn');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (285, 'Benedikt', 'Sparrowhawk', '1928-08-09', 'Coxsackie pericarditis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (286, 'Natasha', 'Kumaar', '1992-05-23', 'Tuberculous meningitis, tubercle bacilli not found by bacteriological examination, but tuberculosis confirmed histologically');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (287, 'Jarib', 'Ruffles', '1975-01-23', 'Terrorism involving chemical weapons');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (288, 'Carola', 'Lightollers', '1917-10-11', 'Chronic venous embolism and thrombosis of internal jugular veins');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (289, 'Dion', 'O''Reagan', '1999-12-01', 'Louse-borne (epidemic) typhus');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (290, 'Jessamine', 'Mauditt', '1984-07-21', 'Pulmonary interstitial glycogenosis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (291, 'Ad', 'Motion', '1963-06-12', 'Aftercare for healing traumatic fracture of arm, unspecified');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (292, 'Idette', 'Boat', '1919-07-01', 'Retractile testis');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (293, 'Hope', 'Barnhill', '1956-02-28', 'Exposure to SARS-associated coronavirus');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (294, 'Whitby', 'Ashbey', '1953-01-11', 'Railway accident involving collision with other object and injuring railway employee');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (295, 'Ronalda', 'Borit', '1964-12-17', 'Transient arthropathy, upper arm');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (296, 'Arne', 'Wettern', '1992-03-05', 'History of emotional abuse');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (297, 'Averyl', 'Stopford', '1991-12-31', 'Secondary iridocyclitis, noninfectious');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (298, 'Mareah', 'Dudin', '1995-07-30', 'Full-thickness skin loss [third degree, not otherwise specified] of genitalia');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (299, 'Reese', 'Drinkale', '1984-12-29', 'Hodgkin''s disease, lymphocytic depletion, intrathoracic lymph nodes');
insert into actors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (300, 'Sascha', 'Pipworth', '1926-07-16', 'Subarachnoid hemorrhage following injury without mention of open intracranial wound, with brief [less than one hour] loss of consciousness');

-- 4. director  (50)

insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (1, 'Cheslie', 'Marcam', '1930-01-04', 'Parasympatholytics [anticholinergics and antimuscarinics] and spasmolytics causing adverse effects in therapeutic use');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (2, 'Danika', 'Hitcham', '1938-04-06', 'Other specified miliary tuberculosis, tubercle bacilli not found by bacteriological examination, but tuberculosis confirmed histologically');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (3, 'Danyette', 'Deniseau', '1984-05-01', 'Rhesus isoimmunization, unspecified as to episode of care or not applicable');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (4, 'Aldrich', 'Achrameev', '1910-03-31', 'Embolism and thrombosis of other specified artery');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (5, 'Tamqrah', 'Sutty', '1988-09-01', 'Intraventricular hemorrhage, grade IV');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (6, 'Belvia', 'Raggett', '1941-05-03', 'Respiratory conditions due to smoke inhalation');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (7, 'Kris', 'Greatorex', '1944-11-20', 'Intrauterine synechiae');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (8, 'Alf', 'Hanson', '1912-07-08', 'Basal cell carcinoma of skin of lower limb, including hip');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (9, 'Gallagher', 'Landsbury', '1959-01-22', 'Other motor vehicle nontraffic accident involving collision with moving object injuring occupant of streetcar');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (10, 'Andie', 'Pfiffer', '1935-07-25', 'Degenerative disorder of globe, unspecified');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (11, 'Fee', 'Pardal', '1954-07-08', 'Tuberculous abscess of brain, tubercle bacilli not found by bacteriological examination, but tuberculosis confirmed histologically');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (12, 'Inglebert', 'Beamson', '2001-04-30', 'Aspiration of postnatal stomach contents with respiratory symptoms');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (13, 'Jacques', 'Clifforth', '1951-09-06', 'Other symptoms referable to joint, multiple sites');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (14, 'Irving', 'Launder', '1934-07-10', 'Streptococcus infection in conditions classified elsewhere and of unspecified site, streptococcus, group D [Enterococcus]');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (15, 'Mellicent', 'Zimmerman', '1947-06-05', 'Other inflammations of eyelids');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (16, 'Trina', 'Sneesbie', '1971-12-20', 'Other anomalies of tooth position');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (17, 'Ferdie', 'Leydon', '1933-01-09', 'Diabetes with hyperosmolarity, type II or unspecified type, uncontrolled');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (18, 'Reba', 'Calloway', '1987-01-31', 'Accidental poisoning by other cleansing and polishing agents');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (19, 'Malissa', 'Gwioneth', '1923-09-22', 'Oxytocic agents causing adverse effects in therapeutic use');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (20, 'Cherin', 'Smalles', '1978-11-10', 'Hypertrophy of tongue papillae');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (21, 'Junina', 'Crellim', '1923-02-20', 'Nephrotic syndrome in diseases classified elsewhere');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (22, 'Fabian', 'Woolacott', '1936-09-18', 'Osteoarthrosis, localized, primary, shoulder region');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (23, 'Patrizia', 'Campo', '1984-10-19', 'Degenerative disorder of eyelid, unspecified');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (24, 'Hodge', 'Pickthorn', '1945-04-21', 'Injury due to war operations by fragments from other improvised explosive device [IED]');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (25, 'Aggy', 'Rickeard', '1913-10-01', 'Ancylostomiasis due to ancylostoma duodenale');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (26, 'Carolynn', 'Abelovitz', '1919-07-22', 'Other open skull fracture with subarachnoid, subdural, and extradural hemorrhage, unspecified state of consciousness');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (27, 'Petra', 'Gylle', '1910-02-05', 'Contact dermatitis and other eczema, unspecified cause');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (28, 'Benoit', 'Terrett', '1946-04-04', 'Lesion of ulnar nerve');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (29, 'Dido', 'Leafe', '1928-04-18', 'Posterior dislocation of tibia, proximal end, closed');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (30, 'Deni', 'Aasaf', '1917-09-22', 'Motor vehicle traffic accident involving collision with pedestrian injuring rider of animal; occupant of animal drawn vehicle');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (31, 'Margalo', 'Ramsted', '1988-05-27', 'Unspecified adverse effect of unspecified drug, medicinal and biological substance');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (32, 'Tersina', 'Goodwin', '1969-05-31', 'Uterovaginal prolapse, complete');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (33, 'Aliza', 'Kirdsch', '1916-12-19', 'Noncollision motor vehicle traffic accident while boarding or alighting injuring passenger in motor vehicle other than motorcycle');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (34, 'Miof mela', 'Charlet', '1964-12-20', 'Open fractures involving skull or face with other bones, with cerebral laceration and contusion, with loss of consciousness of unspecified duration');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (35, 'Honoria', 'Ternouth', '1948-05-24', 'Inhalation and ingestion of other object causing obstruction of respiratory tract or suffocation');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (36, 'Ethelind', 'Dohms', '1911-05-20', 'Illegally induced abortion, complicated by metabolic disorder, unspecified');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (37, 'Ennis', 'Foottit', '1930-06-21', 'Celiac disease');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (38, 'Steffane', 'Apfler', '1928-07-17', 'Femoral hernia with gangrene, bilateral (not specified as recurrent)');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (39, 'Feodor', 'McCaughey', '1927-04-30', 'Heat cramps');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (40, 'Eduardo', 'Willder', '1904-12-24', 'Infection and inflammatory reaction due to internal joint prosthesis');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (41, 'Kimmie', 'Emsden', '1959-09-22', 'Railway accident involving explosion, fire, or burning injuring pedal cyclist');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (42, 'Lou', 'Conlaund', '1923-05-23', 'Assault by criminal neglect');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (43, 'Keri', 'Moogan', '1941-08-20', 'Placental polyp, unspecified as to episode of care or not applicable');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (44, 'Hulda', 'Timoney', '1934-04-09', 'Closed fracture of C1-C4 level with other specified spinal cord injury');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (45, 'Felicle', 'Pibsworth', '1931-06-14', 'Lacrimal fistula');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (46, 'Flor', 'Costall', '1920-04-21', 'Malignant neoplasm of frontal sinus');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (47, 'Iver', 'Baddoe', '1979-08-07', 'Syndactyly of fingers without fusion of bone');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (48, 'Matt', 'Rodbourne', '1949-06-12', 'Full-thickness skin loss [third degree, not otherwise specified] of scapular region');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (49, 'Issiah', 'Esselen', '1942-08-26', 'Cervical shortening, unspecified as to episode of care or not applicable');
insert into directors (intID, strFirstName, strLastName, dteBirthOfYear, strText) values (50, 'Garv', 'Gailor', '1937-12-15', 'Arthropathy associated with Reiter''s disease and nonspecific urethritis, shoulder region');

-- 5. staff (10)
insert into staff (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (1, '2018-02-05 00:16:49', 'Michaelina', 'Candwell', '08508 Towne Crossing', 'Měnín', '664 57', '634-839-7916', '276-737-2734', 'mcandwell0@purevolume.com', '88AO5w9qUgHB');
insert into staff (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (2, '2018-02-21 05:11:20', 'Ly', 'Daouse', '55509 Sage Point', 'Abashiri', '336-0926', '581-801-8276', '540-783-1288', 'ldaouse1@blogger.com', 'ZQcVDgZESK');
insert into staff (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (3, '2017-04-30 16:58:36', 'Georas', 'Sommerville', '546 Riverside Street', 'Cẩm Phả', null, '702-601-4143', '846-747-7543', 'gsommerville2@army.mil', 'o0RGQv');
insert into staff (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (4, '2017-08-08 16:24:31', 'Bevan', 'Huortic', '30 Little Fleur Park', 'Houston', '77070', '281-886-5410', '490-483-1536', 'bhuortic3@arstechnica.com', 'UWcjfo0REBh');
insert into staff (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (5, '2017-08-04 18:23:04', 'Chrissy', 'Bohlsen', '8782 Continental Pass', 'Soutelo', '4740-497', '632-203-1444', '474-263-1554', 'cbohlsen4@ehow.com', 'ycU2xhYnw219');
insert into staff (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (6, '2017-12-03 04:46:36', 'Danyelle', 'Daubney', '0124 Haas Pass', 'Filothéi', null, '848-696-7731', '572-850-1065', 'ddaubney5@topsy.com', 'rOZjKN');
insert into staff (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (7, '2017-08-21 11:18:18', 'Jelene', 'Lazer', '6770 Merrick Alley', 'Bigaa', '3016', '989-651-9156', '190-384-8205', 'jlazer6@lulu.com', 'pKiKVDQhx');
insert into staff (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (8, '2018-03-07 03:04:04', 'Adelina', 'Shirt', '1 Kennedy Junction', 'Clonskeagh', 'D04', '136-256-8075', '485-934-3012', 'ashirt7@skyrock.com', '5DwiWpa');
insert into staff (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (9, '2017-07-04 08:32:45', 'Prue', 'Jemmett', '7159 Stone Corner Center', 'Gierałtowice', '44-186', '903-890-3032', '247-623-7219', 'pjemmett8@photobucket.com', 'Si8uP0t1Yv');
insert into staff (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (10, '2017-04-25 02:36:32', 'Jaymee', 'Fairtlough', '357 Claremont Drive', 'Gorshechnoye', '307425', '538-116-0577', '710-112-4858', 'jfairtlough9@mapy.cz', 'qm9gS6rQcG');

-- 6. customers (200)
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (1, '2017-12-03 20:26:51', 'Meggi', 'Pigram', 'Arapahoe', 'Zliten', null, '495-858-8993', '672-898-3708', 'mpigram0@aboutads.info', '9wd915TC');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (2, '2017-04-27 05:25:14', 'Reagan', 'Ebdon', 'Graceland', 'Xilin', null, '284-352-4669', '327-133-2425', 'rebdon1@marriott.com', 'IdONCUmfEMF');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (3, '2017-06-15 08:37:15', 'Revkah', 'Eliassen', 'Clyde Gallagher', 'Gines-Patay', '1121', '981-454-8806', '451-394-4491', 'reliassen2@dot.gov', 'QbQSW3ET');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (4, '2017-07-07 09:30:31', 'Kelsey', 'Bason', 'Maywood', 'Peñal', null, '506-309-1050', '881-844-8229', 'kbason3@slate.com', 'VfFLYfwcc');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (5, '2017-08-19 15:47:17', 'Celesta', 'Barensky', 'Wayridge', 'Lodwar', null, '646-809-5000', '738-244-4185', 'cbarensky4@netlog.com', 'nAzsDnJ');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (6, '2017-05-31 13:29:28', 'Bamby', 'Stothert', 'Harbort', 'Broniszewice', '63-304', '827-345-2475', '982-920-2328', 'bstothert5@economist.com', 'cI1kRQV');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (7, '2017-06-26 17:09:02', 'Gunner', 'Arnault', 'Express', 'Grande Cache', 'N2Z', '726-490-3054', '341-591-3971', 'garnault6@wp.com', 'UvEq6w');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (8, '2017-11-01 03:09:15', 'Tamqrah', 'Monkman', 'Eastlawn', 'Aguachica', '205018', '351-458-5608', '995-316-4476', 'tmonkman7@reuters.com', 'lCdZMJ6q');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (9, '2018-02-24 23:49:14', 'Leigh', 'Lansdale', 'Hallows', 'Mencon', null, '816-136-9563', '746-530-3810', 'llansdale8@biglobe.ne.jp', 'UySrNK69');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (10, '2017-05-04 18:50:22', 'Vally', 'Clubley', 'Sloan', 'Longotea', null, '853-915-9084', '927-759-4490', 'vclubley9@wunderground.com', 'Mjv3lGJicCsW');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (11, '2017-05-19 15:37:14', 'Ab', 'McGrorty', 'Kipling', 'Gucheng', null, '971-831-4876', '865-888-5634', 'amcgrortya@51.la', 'JlkQ9HmA');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (12, '2018-01-21 00:33:05', 'Sydney', 'Brownlea', 'Saint Paul', 'Zonghan', null, '477-661-2086', '340-740-4781', 'sbrownleab@slideshare.net', 'ArTRqZK1U');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (13, '2018-03-09 06:29:43', 'Arabella', 'Rubertelli', 'Stuart', 'San Cristóbal', '10702', '117-715-6088', '154-615-1495', 'arubertellic@dell.com', '3zlLgs1d5sH');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (14, '2017-11-19 05:42:10', 'Cecilius', 'Deetlof', 'Weeping Birch', 'Terra Chã', '9700-685', '455-752-0381', '339-635-7050', 'cdeetlofd@theguardian.com', '9gObcZitib8');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (15, '2017-08-24 07:06:29', 'Jessamine', 'Crofts', 'Springs', 'Xiqi', null, '253-611-3523', '322-250-9677', 'jcroftse@about.me', 'BXV5Dm');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (16, '2018-02-26 15:18:29', 'Jarib', 'Kiggel', 'Westport', 'Āsmār', null, '500-806-5391', '943-338-2983', 'jkiggelf@meetup.com', '08InaP9prR');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (17, '2017-11-07 12:39:14', 'Sancho', 'Sleeman', 'High Crossing', 'Chojnice', '89-620', '373-830-6153', '786-864-8621', 'ssleemang@theglobeandmail.com', 'HS8ND2a0drDc');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (18, '2017-05-02 19:25:38', 'Maible', 'Ensley', 'Oneill', 'Hualongyan', null, '908-469-3453', '346-411-4802', 'mensleyh@fc2.com', 'q7fEIRD');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (19, '2017-10-01 12:39:40', 'Dedie', 'Laste', 'Debs', 'Khān Shaykhūn', null, '804-260-0729', '813-199-3631', 'dlastei@google.fr', 'DCnLXtXI');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (20, '2017-06-08 07:50:24', 'Teddie', 'Gludor', 'Atwood', 'Kaa-Khem', '667901', '550-809-2570', '113-523-1572', 'tgludorj@fotki.com', 'YtfOOKnVQITr');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (21, '2017-08-13 18:42:29', 'Paule', 'Fradson', 'Lerdahl', 'Mengla', null, '837-226-9944', '762-312-9623', 'pfradsonk@blog.com', 'pIVyhyeLpO8');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (22, '2017-08-01 14:29:10', 'Opalina', 'Brinded', 'Goodland', 'Sari', null, '832-961-4567', '395-187-3055', 'obrindedl@chron.com', 'xSzI9cLU');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (23, '2017-04-05 09:33:50', 'Earvin', 'Rainbow', 'Mariners Cove', 'Troitskoye', '140168', '815-469-2781', '735-898-4211', 'erainbowm@shinystat.com', 'sRnvWDLo181s');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (24, '2018-01-28 14:57:39', 'Shelba', 'Swait', 'John Wall', 'Sinegor''ye', '404102', '584-116-3703', '596-349-6035', 'sswaitn@psu.edu', 'hHI47ZAomgj');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (25, '2017-07-19 15:59:56', 'Ilaire', 'Geekin', 'Commercial', 'Surami', null, '603-240-3353', '113-368-2749', 'igeekino@quantcast.com', '2xtVbvW');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (26, '2018-02-03 19:16:38', 'Natal', 'Kellitt', 'Cherokee', 'Lingkou', null, '402-919-2585', '673-188-4104', 'nkellittp@plala.or.jp', 'dcIltk');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (27, '2017-05-16 00:17:17', 'Corbett', 'Rigard', 'Bartelt', 'Komoro', '925-0373', '612-476-9997', '773-754-2978', 'crigardq@e-recht24.de', 'GyKsuJ');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (28, '2017-08-23 08:48:11', 'Sylvia', 'Nisen', 'School', 'Dimitrovgrad', '6435', '965-726-7578', '975-616-7817', 'snisenr@gmpg.org', 'FczBqz5lzmNh');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (29, '2017-11-27 21:56:35', 'Cally', 'Castille', 'Oneill', 'Siaton', '6219', '850-472-1779', '751-541-3579', 'ccastilles@xrea.com', 'rjeCyzDPmFA');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (30, '2017-09-19 14:07:07', 'Holly-anne', 'Grinikhinov', 'Dwight', 'Don Carlos', '8712', '277-984-3278', '815-310-3544', 'hgrinikhinovt@dagondesign.com', '5zAZ76');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (31, '2017-06-24 12:40:05', 'Renato', 'Scala', 'South', 'Pessac', '33604 CEDEX', '199-967-5426', '145-392-8423', 'rscalau@github.com', 'rK4Dnz');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (32, '2018-02-20 01:30:34', 'Timothee', 'Brockman', 'Linden', 'Dapitan', '3307', '285-753-3924', '971-551-1539', 'tbrockmanv@adobe.com', 'eF7oPxWzy');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (33, '2017-06-06 12:55:59', 'Melanie', 'Ferrario', 'Corscot', 'Augusto Corrêa', '68610-000', '433-290-2604', '756-294-2784', 'mferrariow@comsenz.com', 'hL0T4FU2R');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (34, '2017-12-31 10:03:08', 'Annalee', 'Battershall', 'Mockingbird', 'Alexandria', null, '371-272-5886', '795-536-3344', 'abattershallx@gnu.org', 'g50WjggTuC6O');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (35, '2017-11-10 04:20:43', 'Saree', 'Sandwith', 'Swallow', 'Pacatuba', '49970-000', '214-471-8001', '313-242-3489', 'ssandwithy@mysql.com', '9nPmjafkBPLp');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (36, '2018-02-20 23:39:50', 'Charlot', 'Alliban', 'Cody', 'Sambirata', null, '349-643-5270', '996-180-5432', 'callibanz@edublogs.org', 'v7QOv5ES0nge');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (37, '2017-08-02 18:30:47', 'Berget', 'Thormwell', 'Rockefeller', 'Poços de Caldas', '37700-000', '868-518-4373', '453-874-1262', 'bthormwell10@bluehost.com', 'Uv6tVNZmUPls');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (38, '2017-11-07 18:42:29', 'Grove', 'Pryer', 'Sutteridge', 'Żabno', '33-240', '461-630-9996', '647-268-1085', 'gpryer11@booking.com', '2pSQsCUauY9o');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (39, '2018-02-07 01:18:59', 'Christiana', 'Lawson', 'Lillian', 'Oslob', '6025', '848-697-9835', '205-294-5250', 'clawson12@free.fr', '2RL0YNO');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (40, '2017-04-27 11:40:57', 'Ardella', 'Leipold', 'Summit', 'Jambangan', null, '612-101-1102', '898-981-2735', 'aleipold13@rambler.ru', 'IRvh7iX');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (41, '2017-04-04 01:13:16', 'Fannie', 'O''Corhane', 'Dapin', 'Barbacoas', null, '213-223-4226', '106-436-2814', 'focorhane14@mysql.com', 'p6WfLdMtC');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (42, '2018-01-16 12:14:52', 'Martelle', 'Schwand', 'Marcy', 'Pakemitan', null, '663-118-5966', '188-411-3753', 'mschwand15@psu.edu', 'pWNiImTRJAc');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (43, '2017-07-22 10:37:09', 'Kinnie', 'Biaggetti', 'Melody', 'Cayur', null, '971-949-0667', '317-356-4739', 'kbiaggetti16@soup.io', 'jiTjgcS');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (44, '2017-07-27 14:35:05', 'Jamil', 'Allchorn', 'Swallow', 'Trà My', null, '426-340-3798', '568-769-8319', 'jallchorn17@netvibes.com', 'mAm34rIUmN9q');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (45, '2018-02-04 14:43:07', 'Shawn', 'Wyleman', 'Corry', 'Puerto Eldorado', '3382', '773-555-1354', '666-744-3007', 'swyleman18@umich.edu', '7zfzZQOlwy');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (46, '2017-06-20 19:28:41', 'Jasen', 'Shirtliff', 'Summit', 'Nyalindung', null, '565-721-8597', '671-844-1225', 'jshirtliff19@yahoo.com', 'tqXfti');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (47, '2017-04-25 20:58:15', 'Celie', 'Wheal', 'Lerdahl', 'Waitenepang', null, '911-215-1309', '985-358-0178', 'cwheal1a@a8.net', 'prvhKhJi1EhJ');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (48, '2017-08-05 15:35:27', 'Coletta', 'Picheford', 'Maple', 'Wulan Haye', null, '739-581-1933', '596-688-8335', 'cpicheford1b@harvard.edu', 'mFp45VR6Lg');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (49, '2018-02-21 23:55:44', 'Theresa', 'Lydiard', 'Thompson', 'Botshabelo', '9789', '672-937-2241', '742-577-1928', 'tlydiard1c@t-online.de', 'AVmpY3');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (50, '2017-06-29 03:29:50', 'Xaviera', 'Speak', 'Buena Vista', 'Jardinópolis', '14680-000', '840-449-7232', '984-916-9719', 'xspeak1d@ning.com', 'pAhSUOjNDmPb');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (51, '2018-01-29 04:05:20', 'Townsend', 'Zapater', 'Barnett', 'Huangkeng', null, '901-818-5178', '964-735-6389', 'tzapater1e@fda.gov', 'eaeoHNLgtd');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (52, '2017-10-07 04:34:46', 'David', 'Kingsbury', 'Bartillon', 'Lārkāna', '77381', '547-561-4484', '200-214-2490', 'dkingsbury1f@mtv.com', 'Is9SYWFo');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (53, '2017-04-30 14:44:19', 'Eimile', 'Goldman', '5th', 'Capissayan Sur', '3513', '813-942-1030', '712-834-4033', 'egoldman1g@adobe.com', 'VXnupJm');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (54, '2017-07-01 07:41:58', 'Chelsy', 'O''Cullen', 'Longview', 'Taizi', null, '327-966-2710', '232-547-9974', 'cocullen1h@businessweek.com', '2corAUMxvjZ');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (55, '2017-12-21 12:27:24', 'Nehemiah', 'Spincks', 'Charing Cross', 'Ijuw', null, '767-836-3480', '649-945-9231', 'nspincks1i@newsvine.com', 'p2K7zCnqj');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (56, '2018-02-26 21:52:35', 'Bili', 'Gilford', 'Fremont', 'Qiashui', null, '727-134-2727', '198-688-9966', 'bgilford1j@nature.com', 'ZdEQqlwyRU7Q');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (57, '2017-09-24 12:14:50', 'Roxanne', 'Oldam', 'Sauthoff', 'Bielawa', '58-263', '797-173-0910', '454-655-1442', 'roldam1k@xinhuanet.com', 'caV6g6FQVmT');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (58, '2017-10-17 13:12:59', 'Lindie', 'Finney', 'Kinsman', 'Havana', null, '549-491-5471', '645-847-9677', 'lfinney1l@berkeley.edu', 'SHZIuWoTPK5');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (59, '2018-03-06 15:39:11', 'Sigfried', 'Petrenko', 'Dryden', 'Listowel', 'V31', '160-792-2897', '786-110-8405', 'spetrenko1m@naver.com', '9T2uu539oG');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (60, '2017-08-22 02:36:23', 'Nealon', 'Picken', 'Welch', 'Nakhon Pathom', '40140', '238-671-1591', '550-449-6518', 'npicken1n@time.com', 'MZtKgP');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (61, '2017-11-17 17:36:42', 'Liesa', 'Breissan', 'Cambridge', 'Damawato', '5309', '392-527-6733', '758-457-1621', 'lbreissan1o@weather.com', '0d6oFBT2vY2q');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (62, '2017-10-13 11:26:43', 'Jasper', 'Ivakhno', 'Farmco', 'Minjian', null, '458-103-6605', '401-816-8337', 'jivakhno1p@census.gov', '2NjvG16');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (63, '2017-07-27 18:45:52', 'Marla', 'Creevy', 'Parkside', 'Kadugadung', null, '164-263-8315', '663-302-9436', 'mcreevy1q@reddit.com', 'UsZX9Iht');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (64, '2017-07-12 11:26:46', 'Baily', 'Patrick', 'Lawn', 'Washington', '20430', '202-735-6931', '743-953-6646', 'bpatrick1r@dyndns.org', 'wI2xk8asmlkV');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (65, '2018-03-15 21:19:43', 'Quincy', 'Boswood', 'Fair Oaks', 'Unidos', '9208', '347-641-5589', '299-180-2674', 'qboswood1s@cpanel.net', 'AoL8pMDu');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (66, '2017-04-10 15:25:51', 'Pascale', 'Wyllis', 'John Wall', 'Cihaur', null, '311-258-1838', '661-784-0214', 'pwyllis1t@vkontakte.ru', 'ljvcQsK');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (67, '2017-08-31 02:37:14', 'Olivero', 'Eldershaw', 'Oak Valley', 'Vratsa', '3053', '254-166-2733', '564-201-5167', 'oeldershaw1u@issuu.com', 'E14rqtMF5q');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (68, '2017-05-05 17:42:35', 'Nikolia', 'Jackett', 'Milwaukee', 'Sandgerði', '245', '763-181-3929', '937-478-1605', 'njackett1v@springer.com', '9BksmxYYlw');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (69, '2017-12-07 00:03:36', 'Emelda', 'Rehm', 'Hauk', 'Odzi', null, '974-419-8399', '654-600-3735', 'erehm1w@pcworld.com', '0rRUJcMP26');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (70, '2017-10-28 20:34:39', 'Antoinette', 'Crates', 'Lukken', 'Ziliang', null, '620-398-2373', '858-658-2476', 'acrates1x@tamu.edu', 'zzzIGwj0BHPg');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (71, '2017-09-06 09:05:59', 'Aeriel', 'Springle', 'Waxwing', 'Kuznetsovs’k', null, '376-424-6612', '807-927-7506', 'aspringle1y@nymag.com', 'T7rmO39wkuM');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (72, '2017-05-30 18:36:04', 'Emily', 'Thamelt', 'Maple Wood', 'Cinagrog Girang', null, '449-120-9920', '593-688-6225', 'ethamelt1z@ed.gov', 'fwey1TCkRHh');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (73, '2017-12-27 21:06:26', 'Stormy', 'Blackeby', 'Esch', 'Pejibaye', '11907', '776-678-9832', '684-797-3132', 'sblackeby20@behance.net', 'WcexWuJS9');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (74, '2017-12-27 16:44:22', 'Kort', 'Capner', 'Grasskamp', 'Oster', null, '968-559-7121', '963-749-6118', 'kcapner21@geocities.com', 'mKKxlo99kUWN');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (75, '2017-04-10 15:37:11', 'Archaimbaud', 'O''Cannovane', 'Lotheville', 'Nancy', '54046 CEDEX', '875-259-2267', '442-747-4450', 'aocannovane22@dmoz.org', 'ns30KiJiq7Ow');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (76, '2017-10-29 03:07:54', 'Sam', 'Schrieves', 'Lindbergh', 'Znamenskoye', '366814', '195-699-6246', '608-146-8632', 'sschrieves23@army.mil', 'O9TQIX');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (77, '2017-09-05 01:50:53', 'Bird', 'Trewett', 'Swallow', 'Ban Lam Luk Ka', '77140', '104-333-8974', '195-656-5074', 'btrewett24@bluehost.com', 'CUqvcbrF9d');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (78, '2017-06-08 15:07:04', 'Franzen', 'Marron', 'Superior', 'Igbo-Ukwu', null, '649-870-3840', '875-420-8547', 'fmarron25@ning.com', 'CIQA6uLu');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (79, '2017-11-21 05:24:09', 'Ruthanne', 'Routhorn', 'Vahlen', 'Caen', '14058 CEDEX 4', '286-641-8628', '671-328-0193', 'rrouthorn26@myspace.com', 'kzVtDh0Lcd8');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (80, '2017-08-11 08:31:46', 'Yasmeen', 'Curnok', 'Hagan', 'Ajman', null, '131-164-3294', '402-995-9982', 'ycurnok27@google.de', '81TusArhYfrH');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (81, '2017-09-22 15:04:17', 'Llywellyn', 'Rosenblum', 'Oneill', 'Hanamaki', '936-0056', '174-834-1456', '276-688-6441', 'lrosenblum28@weebly.com', 'WVgRxMe');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (82, '2017-11-19 16:03:47', 'Hogan', 'Pilcher', 'Transport', 'Yicheng', null, '361-428-5288', '411-796-7087', 'hpilcher29@yahoo.co.jp', 'K76ENilR7oU');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (83, '2017-09-12 23:38:16', 'Brooke', 'Hyndley', 'Kenwood', 'Dranoc', null, '678-473-9172', '251-522-2943', 'bhyndley2a@prnewswire.com', 'ndjBbdg6X');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (84, '2017-12-25 00:18:27', 'Germana', 'O''Doohaine', 'Ramsey', 'Beitai', null, '493-127-2750', '454-659-0773', 'godoohaine2b@wisc.edu', 'OPdUJo');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (85, '2018-02-22 05:22:42', 'Annice', 'Spyvye', 'Upham', 'Kỳ Anh', null, '110-461-7875', '101-318-0575', 'aspyvye2c@nbcnews.com', 'E9UZlcsH');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (86, '2017-11-10 08:51:18', 'Paton', 'Capoun', 'School', 'Taveiro', '3045-451', '532-151-7759', '785-868-4142', 'pcapoun2d@hc360.com', 'u4wqY3W');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (87, '2018-03-13 02:52:24', 'Ilsa', 'Seman', 'Mcbride', 'Sarae', null, '337-826-6208', '459-515-4466', 'iseman2e@hao123.com', '8FoF5r');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (88, '2017-06-07 22:30:50', 'Phoebe', 'Ivanilov', 'Spenser', 'Marsa Alam', null, '291-886-6637', '655-436-1913', 'pivanilov2f@cbc.ca', 'oLX5xMUBcT');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (89, '2018-01-21 15:31:34', 'Amil', 'Baraja', 'Sundown', 'Nytva', '617000', '271-580-5386', '236-827-0355', 'abaraja2g@arizona.edu', '2swQHOpx');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (90, '2017-06-10 06:31:54', 'Winne', 'Poyle', 'Melby', 'Negotin', null, '724-767-0209', '126-845-5791', 'wpoyle2h@abc.net.au', 'XGY2jKXl');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (91, '2018-03-02 00:03:18', 'Andreas', 'Whale', 'Kennedy', 'Cikiwul Satu', null, '417-254-6766', '812-278-0588', 'awhale2i@phoca.cz', 'isXZKX');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (92, '2017-06-27 23:38:34', 'Earl', 'Drover', 'Melby', 'Kyaikkami', null, '463-368-8221', '408-185-9723', 'edrover2j@unicef.org', '27F5ERG');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (93, '2017-10-27 04:29:19', 'Joelly', 'Digger', 'Lawn', 'Ringinagung', null, '856-667-2803', '310-276-1192', 'jdigger2k@ovh.net', 'czuAnPs');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (94, '2017-09-11 13:18:26', 'Lynnea', 'Flarity', 'Old Shore', 'Hetang', null, '315-615-4797', '910-829-3196', 'lflarity2l@1und1.de', 'nV8dRDQWBvTz');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (95, '2018-01-23 05:49:04', 'Antoni', 'Clemensen', 'Union', 'Minūf', null, '543-311-1556', '890-921-7481', 'aclemensen2m@cisco.com', 'UEml7QuW');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (96, '2018-02-07 20:40:17', 'Marthe', 'Darke', 'Green Ridge', 'Bologna', '40128', '800-167-8735', '691-423-4501', 'mdarke2n@i2i.jp', 'tcX5yG6Q');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (97, '2017-05-10 18:19:57', 'Vilma', 'Etty', '6th', 'Zheng’an', null, '799-804-7108', '489-261-6469', 'vetty2o@blogtalkradio.com', 'LOKRo0C6');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (98, '2017-12-10 08:05:11', 'Hollis', 'Roddy', 'Saint Paul', 'Bograd', '655340', '759-297-0108', '172-813-0939', 'hroddy2p@facebook.com', 'e4sTdwU8hH0');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (99, '2017-08-12 19:18:35', 'Ody', 'Corthes', 'Hauk', 'Verkhnye Syn’ovydne', null, '363-189-2274', '864-508-4026', 'ocorthes2q@bing.com', '4VMmgcFgo97s');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (100, '2017-07-23 23:40:23', 'Ewan', 'Sterre', 'Bunting', 'Portmore', null, '238-616-2687', '399-911-1152', 'esterre2r@ftc.gov', 'h4U1QqDBiTME');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (101, '2017-11-20 12:56:13', 'Faustina', 'Castana', 'Eliot', 'Cô Tô', null, '673-383-1040', '477-434-5176', 'fcastana2s@bigcartel.com', 'VmnFE7');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (102, '2017-07-25 13:03:58', 'Demetra', 'Honniebal', 'Maple Wood', 'Trondheim', '7425', '754-658-0970', '221-397-2671', 'dhonniebal2t@reuters.com', 'OglUwYUaVEpY');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (103, '2017-07-17 20:05:01', 'Gail', 'Godden', 'Corry', 'Valky', null, '122-523-4248', '279-855-3613', 'ggodden2u@oaic.gov.au', 'sMYUikB6Ry');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (104, '2017-08-07 11:31:02', 'Ermengarde', 'Woodford', 'Vidon', 'Marseille', '13219 CEDEX 02', '820-769-5524', '126-633-5523', 'ewoodford2v@biglobe.ne.jp', 'gSQqew7ssHJb');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (105, '2018-01-19 10:08:35', 'Gal', 'Lang', 'Oneill', 'Fram', null, '104-776-9837', '751-967-4440', 'glang2w@europa.eu', 'P5bvweq3');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (106, '2017-05-22 11:25:55', 'Judon', 'Diloway', 'Schurz', 'Xinshao', null, '275-967-9040', '722-331-3101', 'jdiloway2x@ed.gov', 'PnvbMddEThBo');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (107, '2017-05-27 18:34:53', 'Dorey', 'Danson', 'Algoma', 'Lavadorinhos', '4415-708', '799-604-3230', '314-433-5539', 'ddanson2y@bizjournals.com', 'lmawfAjK31yY');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (108, '2017-08-24 10:31:06', 'Anthia', 'Aupol', 'Fairview', 'Xianlong', null, '265-176-6194', '564-158-3503', 'aaupol2z@zimbio.com', 'mDo2ByPf');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (109, '2017-04-01 14:00:13', 'Hughie', 'Linford', 'Reinke', 'Santa Maria', '8011', '625-748-6408', '628-105-2905', 'hlinford30@seesaa.net', 'cKItNRKCBc');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (110, '2017-04-28 23:22:16', 'Wendi', 'Triplett', 'New Castle', 'Vuka', '31403', '130-696-3723', '506-926-9111', 'wtriplett31@livejournal.com', 'pigXBDQY');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (111, '2017-10-04 21:04:37', 'Marlane', 'Gianullo', 'Loeprich', 'Brvenica', '1216', '434-761-9994', '626-712-7569', 'mgianullo32@printfriendly.com', 'z4bs0Y');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (112, '2018-02-08 16:38:53', 'Carmine', 'Coldwell', 'Cordelia', 'Pisão', '3220-331', '909-636-2292', '968-324-7179', 'ccoldwell33@163.com', 'EDrbh8');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (113, '2017-12-28 03:14:53', 'Natalina', 'Sorrill', 'Onsgard', 'Ytterby', '442 53', '722-579-7998', '489-318-4883', 'nsorrill34@sogou.com', 'B634Kcym');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (114, '2017-10-08 00:28:42', 'Emlynn', 'Tregenza', 'Tomscot', 'Yuwang', null, '807-565-8405', '591-360-2593', 'etregenza35@gmpg.org', 'XXMPaRA');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (115, '2018-01-15 01:07:35', 'Lorin', 'Treppas', 'Cody', 'Sel’tso', '241551', '770-422-2280', '356-726-5125', 'ltreppas36@twitpic.com', 'r2J1zxjnC');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (116, '2017-08-28 03:57:36', 'Freemon', 'Freen', 'American', 'Qianjiang', null, '644-717-7106', '823-285-1664', 'ffreen37@ox.ac.uk', 'QRTCETZ');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (117, '2017-12-03 11:54:17', 'Emlen', 'Jeannenet', 'Forster', 'Nouna', null, '459-773-5468', '946-926-0903', 'ejeannenet38@surveymonkey.com', 'OAPm6Nkm0U');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (118, '2017-07-03 22:02:24', 'Estevan', 'Green', 'Oriole', 'Krajan', null, '644-288-1803', '851-187-6892', 'egreen39@accuweather.com', 'xD1mRL');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (119, '2017-08-09 00:41:33', 'Bebe', 'Winchester', 'Pleasure', 'Baraya', '411067', '426-902-7016', '205-384-9113', 'bwinchester3a@posterous.com', '07bRtw');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (120, '2017-08-05 00:40:40', 'Felisha', 'Zoephel', 'Miller', 'Żabia Wola', '96-321', '374-864-2814', '178-815-2777', 'fzoephel3b@blogspot.com', 'S7LZjCi');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (121, '2017-10-16 06:36:23', 'Link', 'Shawcroft', 'Buell', 'Novovasylivka', null, '622-693-4172', '403-442-1602', 'lshawcroft3c@si.edu', 'kOFaNGMQvR53');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (122, '2017-06-02 17:00:52', 'Maribeth', 'Fereday', 'Hooker', 'Araraquara', '14800-000', '533-178-7584', '972-470-7021', 'mfereday3d@youku.com', 'JZZQe2y');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (123, '2017-06-05 18:42:41', 'Noell', 'Livezley', 'Heffernan', 'Sukkozero', '186956', '530-162-6996', '519-291-4021', 'nlivezley3e@amazon.co.uk', 'XIKaUdT5Z');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (124, '2017-05-03 02:00:22', 'Anders', 'Moncur', 'Sloan', 'Yirshi', null, '894-965-6330', '224-214-9655', 'amoncur3f@businessweek.com', 'CDT7XU1');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (125, '2018-02-11 21:59:26', 'Carlye', 'Harsent', 'Hagan', 'Buang', '1224', '929-512-6839', '253-932-8638', 'charsent3g@columbia.edu', 'kYl4ai');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (126, '2018-03-26 10:26:45', 'Reynard', 'Sitlinton', 'Pine View', 'Tuka', '3120', '798-963-6807', '504-735-2249', 'rsitlinton3h@drupal.org', 'SSgvSwZDfsqu');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (127, '2017-11-03 01:50:55', 'Warde', 'Syncke', 'Oxford', 'Lubao', '2005', '652-452-3377', '725-556-0315', 'wsyncke3i@yellowbook.com', 'lSwZSrI');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (128, '2018-02-17 23:17:11', 'Nico', 'Langwade', 'Jenna', 'Liuji', null, '342-865-1771', '358-333-8281', 'nlangwade3j@skyrock.com', 'ATjNdtZdet');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (129, '2017-11-12 17:45:52', 'Shari', 'Yarnold', 'Village', 'Baoping', null, '548-133-8489', '143-560-7193', 'syarnold3k@washingtonpost.com', 's4RLyyvKa0b');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (130, '2017-04-07 21:26:35', 'Kermit', 'Yakubov', 'Esker', 'Waegwan', null, '138-535-3074', '555-613-6214', 'kyakubov3l@devhub.com', 'k59j4PaR');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (131, '2017-12-02 17:22:48', 'Colman', 'Pinxton', 'Dapin', 'Saint-Paul', '97435', '783-636-1541', '411-489-8721', 'cpinxton3m@usgs.gov', 'iRYjPQH1JWr');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (132, '2017-08-10 17:27:56', 'Dmitri', 'Mantha', 'Kipling', 'Babirik', null, '357-116-3691', '111-321-3432', 'dmantha3n@yellowbook.com', 'tnUiU6');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (133, '2017-05-31 18:05:04', 'Phil', 'Cassy', 'Monterey', 'Kup', '46-082', '386-294-2678', '682-916-6038', 'pcassy3o@yandex.ru', 'QOzDTJ1lD');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (134, '2017-10-12 10:25:59', 'Karie', 'Leeds', 'Ruskin', 'Šumperk', '787 01', '688-690-2109', '702-202-1560', 'kleeds3p@vistaprint.com', 'wi6hm4ouye');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (135, '2018-03-18 13:51:34', 'Jennilee', 'Acheson', 'Hanson', 'Dailing', null, '372-253-9611', '624-823-2021', 'jacheson3q@abc.net.au', 'BziTBSE4');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (136, '2017-06-16 23:07:15', 'Willetta', 'Freezor', 'Nelson', 'Teryayevo', '175147', '400-490-4344', '630-328-7673', 'wfreezor3r@naver.com', 'EX0DAir');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (137, '2017-07-17 21:16:52', 'Beryle', 'Mummery', 'Ilene', 'Pepe', null, '402-365-8597', '811-128-9117', 'bmummery3s@deliciousdays.com', 'fq9OjbMRi');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (138, '2018-02-21 09:03:13', 'Archy', 'Kemson', 'Lotheville', 'Varberg', '432 51', '750-344-2673', '761-852-2423', 'akemson3t@t.co', 'XcXKR6CgHb9y');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (139, '2017-06-05 04:20:32', 'Had', 'Capnor', 'Lindbergh', 'Viçosa do Ceará', '62300-000', '441-292-3858', '179-546-4444', 'hcapnor3u@comcast.net', 'XR0UEYB');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (140, '2017-07-13 11:27:47', 'Carter', 'Okenden', 'Moose', 'Sirindhorn', '65150', '807-686-5627', '430-923-2160', 'cokenden3v@behance.net', 'SYvRPB3V7');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (141, '2017-05-12 18:06:04', 'Pepito', 'Emmanuele', 'Brickson Park', 'Luebo', null, '769-491-1692', '740-609-3946', 'pemmanuele3w@umich.edu', 'VyI43G6L');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (142, '2017-04-10 02:26:00', 'Leena', 'Eddisforth', 'Talmadge', 'Castillos', null, '224-166-8403', '204-598-0848', 'leddisforth3x@blog.com', 'RSB97r');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (143, '2018-01-26 12:02:34', 'Katina', 'Sayle', 'Sutteridge', 'Arnhem', '6804', '578-487-9398', '434-390-7317', 'ksayle3y@ehow.com', 'GUuKtkm');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (144, '2018-03-10 18:35:58', 'Aura', 'Kliner', 'Barby', 'Ban Dung', '41190', '899-683-5199', '560-688-4220', 'akliner3z@1und1.de', 'THV4K77pI');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (145, '2018-01-11 17:37:06', 'Catharine', 'Grenshields', 'Eggendart', 'Zhongjiapu', null, '775-814-2868', '425-505-5846', 'cgrenshields40@cpanel.net', 'SrC8T1JRj77R');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (146, '2018-03-28 12:10:18', 'Evie', 'Dearlove', 'Kensington', 'Prakhon Chai', '31140', '352-341-5709', '498-504-9206', 'edearlove41@taobao.com', '4QaCylK');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (147, '2017-12-14 02:49:54', 'Hedvige', 'Harniman', 'Crest Line', 'Tëploye', '242522', '193-569-0879', '220-814-1890', 'hharniman42@spiegel.de', 'DXDtYkdAGPYN');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (148, '2017-10-23 19:58:06', 'Candis', 'Carrel', 'Melrose', 'Lafiagi', null, '636-804-4671', '431-204-8184', 'ccarrel43@paginegialle.it', 'pFsgmUnu');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (149, '2018-01-10 04:15:44', 'Philly', 'Chavrin', 'Grim', 'Častolovice', '517 50', '987-941-4840', '359-808-5492', 'pchavrin44@cmu.edu', '129uUIu65');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (150, '2017-05-25 22:26:06', 'Hillard', 'Fairbrother', 'Division', '20 de Noviembre', '93828', '137-702-8501', '198-992-5808', 'hfairbrother45@ovh.net', '7LKDS1n');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (151, '2017-12-23 23:27:27', 'Evonne', 'Estick', 'Carpenter', 'Kurayyimah', null, '373-488-5130', '647-629-5223', 'eestick46@sbwire.com', 'WLU0dkWr');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (152, '2017-12-18 02:45:57', 'Skip', 'Rapelli', 'Glacier Hill', 'Minusinsk', '662622', '944-177-3250', '646-607-1558', 'srapelli47@bigcartel.com', 'aaLKoqC');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (153, '2017-06-04 16:15:35', 'Tyrone', 'Diggin', 'Susan', 'Gaoqiaolou', null, '468-449-5738', '307-796-7702', 'tdiggin48@usnews.com', 'aPxtzfZ0H');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (154, '2017-08-14 06:12:58', 'Henry', 'Savil', 'Scoville', 'Dongke', null, '726-459-3408', '890-978-0286', 'hsavil49@privacy.gov.au', 'PP9fB1JB');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (155, '2017-06-24 09:21:23', 'Maris', 'Jayme', 'Oak Valley', 'Ha', null, '112-868-4218', '657-758-1819', 'mjayme4a@digg.com', 'OcpdRKNx54');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (156, '2017-07-31 16:00:05', 'Mathias', 'Frostdicke', 'Ohio', 'Shaxi', null, '101-685-4471', '912-470-0622', 'mfrostdicke4b@auda.org.au', 'C5zuIsyH');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (157, '2017-06-05 20:01:15', 'Berty', 'Bolstridge', 'Paget', 'Moerewa', '0244', '110-625-6424', '107-705-1082', 'bbolstridge4c@adobe.com', '31AIFrW6y');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (158, '2017-05-19 23:58:33', 'Gardy', 'Jermey', 'Stoughton', 'Mananum', '6118', '672-594-6677', '490-332-7117', 'gjermey4d@theatlantic.com', 'cnX9elB8Lf2');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (159, '2018-01-26 19:50:58', 'Zorana', 'Furzer', 'Dunning', 'Baishi', null, '780-554-2059', '707-100-0486', 'zfurzer4e@blogger.com', 's78OoB');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (160, '2017-06-17 10:59:03', 'Jerrie', 'Tuson', 'Sutherland', 'Ventsy', '352177', '300-201-2032', '151-130-9995', 'jtuson4f@aol.com', 'EaZtrJs7vF');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (161, '2018-03-02 07:51:03', 'Lisle', 'Locksley', 'Moose', 'Kamenka', '412378', '380-441-3521', '605-698-5317', 'llocksley4g@is.gd', 'TbKbQjxuSYsJ');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (162, '2017-06-07 04:13:41', 'Imogene', 'MacCaughey', 'Roxbury', 'Vredenburg', '7390', '963-244-9007', '343-155-0539', 'imaccaughey4h@baidu.com', 'iUbfbcw8YL2Y');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (163, '2017-11-30 11:15:34', 'Augy', 'Boyet', 'Green Ridge', 'Banyo', null, '707-164-3024', '429-539-5588', 'aboyet4i@about.me', 'E9J6g5Q7Hcqy');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (164, '2017-07-07 11:02:14', 'Arther', 'Hacking', 'Karstens', 'Yuktae-dong', null, '629-217-8614', '260-344-3134', 'ahacking4j@fema.gov', 'vKacu0N2');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (165, '2017-05-21 09:04:41', 'Adrianna', 'Riveles', 'Talisman', 'Wadung', null, '567-701-5487', '235-212-9155', 'ariveles4k@t.co', 'axCPQb');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (166, '2017-10-09 12:45:24', 'Craig', 'Bulley', 'Reindahl', 'Oslo', '0620', '417-867-9109', '587-374-6415', 'cbulley4l@macromedia.com', 'd3Qdxg73ah9J');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (167, '2017-04-07 19:58:09', 'Kristine', 'Clampe', 'Dahle', 'Miramichi', 'L7G', '274-426-3028', '489-823-6416', 'kclampe4m@nydailynews.com', 'kZVJ4hhIVG');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (168, '2017-07-11 00:58:53', 'Mar', 'Riste', 'Derek', 'Dallas', '75260', '214-297-4229', '715-153-1430', 'mriste4n@indiegogo.com', '99CTR8sWy');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (169, '2018-02-14 07:32:53', 'Lindsay', 'Barling', 'Mandrake', 'Zhuzuo', null, '164-865-4440', '434-363-0953', 'lbarling4o@clickbank.net', 'aIuONvcC');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (170, '2018-01-22 17:54:14', 'Zolly', 'Simenel', 'Reindahl', 'Cayungnan', '2408', '460-595-6401', '998-387-6197', 'zsimenel4p@shutterfly.com', 'dzlVBDRxjE5');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (171, '2017-08-17 13:51:16', 'Selinda', 'Jocelyn', 'Vernon', 'Tianzhou', null, '882-424-2146', '419-952-2724', 'sjocelyn4q@baidu.com', 'HudPT8wOosa');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (172, '2017-06-17 18:22:35', 'Enid', 'Petegre', 'Kipling', 'Hluboká nad Vltavou', '373 41', '618-651-3264', '533-835-9116', 'epetegre4r@opera.com', 'Exh8Tc');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (173, '2017-05-20 09:07:52', 'Netty', 'Dorran', 'Garrison', 'Mariental', null, '281-906-1575', '755-461-7518', 'ndorran4s@51.la', '91uwaRwgU');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (174, '2017-06-20 12:04:50', 'Cassondra', 'Inns', 'Buhler', 'Sumberagung', null, '138-207-3289', '979-214-8737', 'cinns4t@washingtonpost.com', 'G9oZET7rUC');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (175, '2017-06-25 10:29:59', 'Anatollo', 'Callaby', 'Oriole', 'Shishan', null, '804-114-2938', '731-644-1464', 'acallaby4u@mozilla.org', 'xyqGZUwd');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (176, '2018-02-27 17:23:15', 'Hastie', 'Stetson', 'Montana', 'Primorsko-Akhtarsk', '353866', '597-822-1720', '853-859-2292', 'hstetson4v@geocities.com', 'WDACm9Nmy8Y');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (177, '2017-12-07 12:41:12', 'Avril', 'Woolvin', 'Aberg', 'Żabnica', '34-382', '875-820-3222', '788-346-8869', 'awoolvin4w@about.com', 'QnYLC3Z');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (178, '2017-07-24 12:48:29', 'Mufi', 'Whittington', 'Shopko', 'Toulouse', '31019 CEDEX 2', '185-735-5797', '901-612-4844', 'mwhittington4x@soup.io', 'rZTS4Dr1RbOS');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (179, '2017-08-07 19:19:52', 'Dewain', 'Mansion', 'Moose', 'Tuanlin', null, '350-510-7850', '486-798-3470', 'dmansion4y@buzzfeed.com', 'FOKx9b5');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (180, '2018-02-04 14:05:37', 'Lenci', 'Sidry', 'Marcy', 'Xianghua', null, '882-747-8903', '995-977-7137', 'lsidry4z@dion.ne.jp', '1jREozYHi7Z');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (181, '2018-03-24 04:58:59', 'Henrie', 'Gobeau', 'Haas', 'Vila Nova de Gaia', '4400-005', '701-265-9513', '257-638-5352', 'hgobeau50@bbb.org', 'Jx7oPz');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (182, '2018-01-26 02:05:14', 'Carroll', 'Blumire', 'Mcbride', 'Cigadog', null, '574-741-0901', '718-587-5748', 'cblumire51@goo.ne.jp', 'qCGSfGR');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (183, '2017-09-19 23:54:55', 'Ambrosi', 'Pimer', 'Forster', 'Poręba Spytkowska', '32-865', '559-145-7480', '198-207-2169', 'apimer52@mozilla.org', 'GP9OHIochHFF');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (184, '2017-08-03 22:47:28', 'Konstantine', 'Darlow', 'Jay', 'Kyurdarmir', null, '972-221-7874', '834-264-4126', 'kdarlow53@imgur.com', 'QfIoXgQY8if');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (185, '2017-10-16 12:21:50', 'Agathe', 'Schwander', 'Crescent Oaks', 'Íos', null, '639-333-6553', '258-226-0386', 'aschwander54@dropbox.com', 'dU6vuvtHXd');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (186, '2017-11-03 06:41:57', 'Yelena', 'Beartup', 'Kennedy', 'Denver', '80249', '720-366-3043', '877-820-1631', 'ybeartup55@blinklist.com', 'QScyQDBG');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (187, '2018-02-28 05:08:54', 'Frieda', 'Christoforou', 'Jana', 'Mabini', '6313', '204-601-9332', '730-676-6816', 'fchristoforou56@163.com', 'lSCLtk6d');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (188, '2017-05-27 20:54:32', 'Estelle', 'Abdie', 'Portage', 'Palkino', '181280', '517-390-3432', '267-197-9374', 'eabdie57@nsw.gov.au', 'PbclkmBlyV');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (189, '2017-07-07 17:47:54', 'Carlee', 'Dreossi', '8th', 'Cairo', null, '666-561-3938', '710-567-0655', 'cdreossi58@t-online.de', 'RAFhPey3I');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (190, '2017-08-25 17:04:02', 'Baird', 'Harriss', 'Springs', 'Helmsange', 'L-7270', '315-345-0377', '105-903-9002', 'bharriss59@pagesperso-orange.fr', 'mOi5uGv1PLn');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (191, '2017-07-25 00:56:36', 'Arlette', 'Gilkison', '4th', 'Liulang', null, '149-990-5402', '552-158-0323', 'agilkison5a@surveymonkey.com', 'BCFcgsZx01tJ');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (192, '2018-03-21 02:07:15', 'Brade', 'Tadman', 'Kensington', 'Ballinteer', 'D6W', '385-478-4313', '240-484-8273', 'btadman5b@cargocollective.com', 'gHkx8REE1Kw');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (193, '2017-04-25 03:43:27', 'Basia', 'Shill', 'Loomis', 'Fonseca', '444018', '559-730-5172', '546-488-3875', 'bshill5c@wired.com', 'SHr0CJyDQ3w');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (194, '2018-03-06 02:25:24', 'Janice', 'Trood', 'Pine View', 'Baghlān', null, '652-976-4536', '727-475-2429', 'jtrood5d@rediff.com', 'BH8HS2xa');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (195, '2017-05-05 08:20:39', 'Lucretia', 'Mazonowicz', 'Toban', 'Hāsilpur', '51130', '420-985-7335', '680-671-6669', 'lmazonowicz5e@discovery.com', 'cn7otD4ynr');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (196, '2017-07-11 12:07:26', 'Doyle', 'Clipson', 'Russell', 'Chitagá', '544038', '748-991-1477', '570-346-1689', 'dclipson5f@parallels.com', 'jXbH75i2bNBs');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (197, '2017-07-11 02:03:20', 'Decca', 'Hazlegrove', 'Nancy', 'Tegalsari', null, '368-935-3965', '898-953-1842', 'dhazlegrove5g@newsvine.com', 'Sk7QsobzkUgB');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (198, '2017-07-31 12:25:24', 'Meredithe', 'Brockett', 'Sommers', 'Sorodot', null, '241-762-9581', '255-779-0137', 'mbrockett5h@bloglovin.com', '4agjJHvf');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (199, '2018-01-19 17:12:14', 'Somerset', 'Fellona', 'Anthes', 'Austin', '78737', '512-639-9430', '296-441-5142', 'sfellona5i@weather.com', 'oWhVyJ');
insert into customers (intID, dteCreated, strFirstName, strLastName, strStreet, strCity, strZip, strPhone1, strPhone2, strEmail, strPassword) values (200, '2018-01-05 17:51:09', 'Guntar', 'Samsin', 'Almo', 'Chinú', '232059', '775-406-1698', '829-596-0519', 'gsamsin5j@hao123.com', 'EUYBJtoJCI');

-- 7. movies (300) 

insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (1, '2017-07-04 05:22:38', 'Rimini, Rimini: A Year Later', '1918-05-10', 4, 46, 11, 'Comedy', 159, '982085645-0', '35 weeks gestation of pregnancy', 'Control Bleeding in Left Wrist Region, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (2, '2017-04-17 16:28:10', 'Emperor Waltz, The', '1939-02-16', 4, 21, 2, 'Comedy|Musical|Romance', 172, '914135917-8', 'Immuniz not crd out bec chronic illness or cond of patient', 'Repair Left Eustachian Tube, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (3, '2017-11-02 01:16:36', 'How to Murder Your Wife', '1946-09-30', 5, 22, 1, 'Comedy', 174, '854720619-1', 'Oth injury due to oth accident on board canoe/kayk, sequela', 'Revision of Autologous Tissue Substitute in Chest Wall, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (4, '2017-04-05 00:22:06', 'G-Force', '2006-06-17', 5, 33, 2, 'Action|Adventure|Children|Fantasy', 122, '040794721-3', 'Rheu heart disease w rheumatoid arthritis of l shoulder', 'Restriction of Right Subclavian Artery, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (5, '2017-10-14 10:42:47', 'Iron Island (Jazireh Ahani)', '1931-05-01', 5, 42, 2, 'Drama', 195, '599472082-8', 'Poisoning by antithrombotic drugs, self-harm, sequela', 'Insertion of Reservoir into Chest Subcutaneous Tissue and Fascia, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (6, '2017-10-14 21:56:15', 'Disney Sing Along Songs: Under the Sea', '2017-10-20', 4, 7, 9, 'Animation|Children|Musical', 198, '439492157-0', 'Sltr-haris Type II physeal fx phalanx of unsp toe, sequela', 'Drainage of Left Brachial Vein, Percutaneous Endoscopic Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (7, '2017-09-01 15:43:36', 'Waist Deep', '2017-07-09', 3, 30, 9, 'Action|Crime|Drama|Thriller', 193, '465038539-3', 'Occupant (driver) of 3-whl mv injured in unsp nontraf', 'Excision of Left Knee Bursa and Ligament, Percutaneous Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (8, '2017-06-27 07:14:00', 'Film Noir: Bringing Darkness to Light', '2013-12-18', 2, 15, 9, 'Documentary', 169, '140806247-X', 'Unsp dislocation of unspecified shoulder joint, sequela', 'Supplement Right Renal Vein with Nonautologous Tissue Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (9, '2017-10-05 01:49:31', 'Jim Gaffigan: Mr. Universe', '1919-08-24', 5, 34, 1, 'Comedy', 180, '041565494-7', 'Nondisp fx of trapezium, right wrist, subs for fx w malunion', 'Destruction of Right Internal Mammary Artery, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (10, '2017-05-07 15:26:08', 'Trailer Park Boys: Countdown to Liquor Day', '1962-09-15', 3, 41, 4, 'Comedy|Crime', 195, '737461827-1', 'Exposure to X-rays, initial encounter', 'Robotic Assisted Procedure of Lower Extremity');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (11, '2017-05-04 12:23:38', 'Madigan', '1937-01-30', 2, 42, 1, 'Crime|Drama', 107, '344502477-4', 'Toxic effect of dichloromethane, intentional self-harm, init', 'Resection of Left Main Bronchus, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (12, '2017-06-09 15:29:24', 'Asterix in Britain (Astérix chez les Bretons)', '1917-08-09', 5, 2, 5, 'Adventure|Animation|Children|Comedy', 186, '778581671-9', 'Peripheral T-cell lymphoma, not classified, unspecified site', 'Revision of Autologous Tissue Substitute in Left Breast, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (13, '2017-07-23 07:00:11', 'Tarda estate', '1934-11-02', 3, 18, 8, 'Drama', 112, '531799817-4', 'Indeterminate leprosy', 'Excision of Uterus, Via Natural or Artificial Opening Endoscopic, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (14, '2017-05-26 16:00:17', 'Airplane II: The Sequel', '1964-12-01', 5, 9, 4, 'Comedy', 184, '096316897-5', 'Toxic effect of rodenticides, assault, sequela', 'Destruction of Right Lower Arm Subcutaneous Tissue and Fascia, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (15, '2017-04-29 19:50:07', 'Bunch Of Amateurs, A', '1964-04-09', 1, 7, 5, 'Comedy', 150, '854544505-9', 'Terorsm w oth explosn and fragmt, publ sfty offcl inj, init', 'Bypass Right Femoral Vein to Lower Vein, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (16, '2017-05-17 03:02:11', 'The Invitation', '1940-08-29', 2, 5, 8, 'Drama|Horror|Thriller', 123, '828053361-3', 'Nondisp fx of shaft of 1st MC bone, l hand, init for opn fx', 'Sensory Awareness/Processing/Integrity Assessment of Neurological System - Upper Back / Upper Extremity');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (17, '2017-09-25 22:46:55', 'Strange Brew', '2017-06-26', 2, 12, 9, 'Comedy', 186, '794908143-0', 'Other disorders of patella, right knee', 'Inspection of Trachea, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (18, '2017-08-15 04:44:38', 'Dances Sacred and Profane', '1998-07-29', 3, 6, 2, 'Documentary', 177, '374919925-6', 'Bent bone of l ulna, subs for opn fx type I/2 w routn heal', 'Removal of Bandage on Right Upper Arm');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (19, '2017-08-30 14:15:08', 'In Your Hands', '2002-12-21', 2, 47, 5, 'Drama', 97, '215922621-1', 'Nondisp fx of base of third metacarpal bone, left hand', 'Supplement Cisterna Chyli with Synthetic Substitute, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (20, '2017-09-10 07:38:46', 'Last Dispatch, The', '2000-02-22', 5, 47, 2, 'Documentary', 165, '384154951-9', 'Apparent life threatening event in infant (ALTE)', 'Reposition Right Metatarsal-Phalangeal Joint with External Fixation Device, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (21, '2017-08-31 00:49:18', 'Quiet Man, The', '1983-05-10', 5, 32, 4, 'Drama|Romance', 125, '400529664-5', 'Sltr-haris Type III physl fx lower end humer, unsp arm, init', 'Occlusion of Right Femoral Vein with Extraluminal Device, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (22, '2017-09-06 23:00:39', 'Macbeth', '1939-05-20', 5, 12, 3, 'Drama', 137, '069111941-4', 'Lac w/o fb of l little finger w/o damage to nail, subs', 'Insertion of Internal Fixation Device into Left Finger Phalangeal Joint, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (23, '2017-07-24 14:52:39', 'It''s a Disaster', '1975-08-03', 4, 44, 4, 'Comedy|Drama', 167, '473615733-X', 'Toxic effect of zinc and its compounds, self-harm, sequela', 'Release Left Elbow Bursa and Ligament, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (24, '2017-06-09 21:38:48', 'Hollywood Complex, The', '2004-09-22', 3, 39, 9, 'Documentary', 184, '506073294-0', 'Infection of amputation stump, unspecified extremity', 'Release Right Lower Eyelid, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (25, '2017-11-22 20:45:47', 'Princess for Christmas, A', '1999-04-24', 5, 5, 9, 'Children|Comedy', 123, '125170384-4', 'Retained (old) foreign body in vitreous body, left eye', 'Extirpation of Matter from Left Inguinal Lymphatic, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (26, '2017-10-23 16:12:32', '[REC]', '1987-10-22', 2, 8, 7, 'Drama|Horror|Thriller', 185, '410524111-7', 'Fracture of medial condyle of femur', 'Removal of Monitoring Device from Left Lung, Via Natural or Artificial Opening Endoscopic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (27, '2017-10-01 04:43:27', 'Shadow Warriors 2 (Assault on Devil''s Island)', '1974-01-02', 4, 23, 2, 'Action|Adventure|Thriller', 196, '302951489-7', 'Age-rel osteopor w current path fracture, r femur, sequela', 'Inspection of Right Metatarsal-Phalangeal Joint, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (28, '2017-07-10 06:53:47', 'Queen to Play (Joueuse)', '1920-12-14', 5, 37, 4, 'Drama', 133, '712200612-3', 'Open wound of thumb with damage to nail', 'Supplement Sacral Nerve with Autologous Tissue Substitute, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (29, '2017-06-26 08:12:28', 'Doc Savage: The Man of Bronze', '1983-11-16', 5, 21, 4, 'Adventure', 191, '689306215-X', 'Toxic effect of corrosv alkalis and alk-like substnc, asslt', 'Removal of Infusion Device from Left Finger Phalangeal Joint, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (30, '2017-08-09 07:17:57', 'When Love Is Not Enough: The Lois Wilson Story', '1992-07-10', 4, 11, 6, 'Drama', 91, '993117351-3', 'Nondisp transverse fx shaft of unsp fibula, 7thB', 'Destruction of Left Superior Parathyroid Gland, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (31, '2017-04-04 07:25:50', 'April Love', '2004-10-24', 4, 18, 4, 'Comedy|Drama|Musical', 182, '651398216-2', 'Maternal care for oth rhesus isoimmun, third tri, fetus 5', 'Insertion of Intraluminal Device into Ileum, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (32, '2017-05-28 06:48:27', 'King''s Ransom', '1955-04-13', 1, 8, 11, 'Comedy|Crime', 163, '370334851-8', 'Milt op involving gasoline bomb, military personnel, init', 'Magnetic Resonance Imaging (MRI) of Lower Extremity Connective Tissue using Other Contrast, Unenhanced and Enhanced');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (33, '2017-09-06 05:36:18', 'Sure Thing, The', '1936-10-09', 5, 26, 10, 'Comedy|Romance', 112, '844434660-8', 'Underdosing of local anesthetics', 'Dilation of Hepatic Artery, Bifurcation, with Intraluminal Device, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (34, '2017-09-10 08:39:21', 'Loose Change 9/11: An American Coup', '1979-02-10', 1, 32, 5, 'Documentary', 165, '164219168-X', 'Idiopathic chronic gout, unsp ankle and foot, with tophus', 'High Dose Rate (HDR) Brachytherapy of Pelvis Lymphatics using Californium 252 (Cf-252)');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (35, '2017-05-12 14:17:48', 'Gorko!', '1934-02-18', 3, 16, 5, 'Comedy', 176, '124626343-2', 'Unspecified subluxation of left ring finger, init encntr', 'Supplement Sacrum with Autologous Tissue Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (36, '2017-07-05 20:53:53', 'Winnetou: The Last Shot', '1928-11-16', 2, 37, 7, 'Action|Adventure|Western', 146, '578198286-8', 'Unsp injury of posterior tibial artery, left leg, subs', 'Drainage of Left Carpal Joint, Open Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (37, '2017-10-30 18:43:29', 'Hide Your Smiling Faces', '1920-11-04', 5, 27, 10, 'Drama', 135, '604054531-3', 'Prph tear of lat mensc, current injury, left knee, init', 'Introduction of Oxazolidinones into Pleural Cavity, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (38, '2017-05-14 13:17:34', 'Kid Brother, The', '1989-10-31', 2, 49, 7, 'Children|Comedy|Romance', 143, '272197247-2', 'Unsp car occupant injured in collision w van in traf, init', 'Reposition Sacral Nerve, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (39, '2017-05-09 18:07:11', 'Flight', '1973-10-01', 2, 31, 10, 'Drama', 178, '485036398-9', 'Nondisp fx of distal phalanx of unsp thumb, init for clos fx', 'Supplement Right Greater Saphenous Vein with Autologous Tissue Substitute, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (40, '2017-10-03 03:58:01', 'America 3000', '1918-08-20', 5, 48, 6, 'Action|Adventure|Sci-Fi', 115, '014521303-X', 'Nondisp fx of nk of 5th MC bone, r hand, 7thP', 'Excision of Right Ulnar Artery, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (41, '2017-09-04 01:03:44', 'Happening, The', '1925-05-22', 2, 2, 8, 'Drama|Sci-Fi|Thriller', 172, '268084173-5', 'Injury of median nerve at upper arm level, left arm', 'Supplement Right Nipple with Synthetic Substitute, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (42, '2017-12-17 01:38:00', 'Ski Patrol', '2004-03-01', 3, 18, 4, 'Action|Comedy', 199, '251868383-6', 'Unsp injury of dorsal artery of left foot, init encntr', 'Wheelchair Mobility Assessment using Assistive, Adaptive, Supportive or Protective Equipment');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (43, '2017-08-26 11:49:14', 'Now!', '1963-04-06', 1, 43, 7, 'Documentary', 188, '874837759-7', 'Struck by nonvenomous snake, subsequent encounter', 'Positron Emission Tomographic (PET) Imaging of Lungs and Bronchi using Fluorine 18 (F-18)');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (44, '2017-04-24 17:32:03', 'Colombiana', '1974-11-20', 1, 47, 3, 'Action|Adventure|Drama|Thriller', 136, '174727910-2', 'Other cystitis', 'Removal of Drainage Device from Lower Intestinal Tract, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (45, '2017-08-18 01:40:25', 'Neverwas', '1931-10-28', 5, 17, 3, 'Drama|Fantasy|Mystery', 134, '553333715-6', 'Laceration with foreign body, unspecified hip, sequela', 'Revision of Autologous Tissue Substitute in Lower Artery, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (46, '2017-08-09 17:51:01', 'Mondo Cane', '1977-12-18', 4, 2, 6, 'Documentary', 179, '612264853-1', 'Parasitic endophthalmitis, unspecified, unspecified eye', 'Restriction of Right Inguinal Lymphatic, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (47, '2017-10-30 16:11:31', 'Source Code', '1953-04-02', 4, 3, 4, 'Action|Drama|Mystery|Sci-Fi|Thriller', 116, '585243565-1', 'Displaced dome fracture of unsp acetabulum, init for clos fx', 'Introduction of Other Anti-infective into Spinal Canal, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (48, '2017-04-09 01:03:04', 'Dressed to Kill', '1937-07-16', 2, 39, 3, 'Mystery|Thriller', 177, '083409403-7', 'I/I react d/t other prosth dev/grft in urinary system, subs', 'Supplement Left External Iliac Artery with Synthetic Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (49, '2017-10-21 17:44:40', 'Fade to Black', '2013-03-02', 1, 11, 5, 'Documentary', 159, '940859878-4', 'I/I react d/t implnt elec nstim of spinal cord, lead', 'Beam Radiation of Pineal Body using Photons 1 - 10 MeV');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (50, '2017-07-07 19:41:06', 'A Spell to Ward Off the Darkness', '2005-12-04', 1, 39, 9, 'Documentary', 92, '923957460-3', 'Other antepartum hemorrhage, unspecified trimester', 'Restriction of Left Internal Mammary Lymphatic with Intraluminal Device, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (51, '2017-10-29 15:19:08', 'Morning for the Osone Family', '1944-09-07', 3, 7, 8, '(no genres listed)', 104, '117506476-9', 'Recurrent dislocation, knee', 'Excision of Left Pleura, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (52, '2017-04-05 14:51:10', 'Bill & Ted''s Bogus Journey', '1993-05-07', 2, 23, 10, 'Adventure|Comedy|Fantasy|Sci-Fi', 178, '641068522-X', 'Other subluxation of left wrist and hand', 'Extirpation of Matter from Right Ankle Joint, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (53, '2017-07-30 13:19:18', 'Don''t Be Afraid of the Dark', '1953-07-30', 4, 28, 4, 'Horror|Thriller', 186, '390679452-0', 'Displ seg fx shaft of l fibula, subs for clos fx w nonunion', 'Reposition Left Hand Bursa and Ligament, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (54, '2017-11-06 01:51:51', 'Little Engine That Could, The', '1951-11-14', 4, 34, 11, 'Animation|Children', 116, '282993115-7', 'Nondisp fx of med malleolus of l tibia, 7thE', 'Drainage of Left Foot Artery with Drainage Device, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (55, '2017-12-04 03:44:58', 'Bright Star', '2003-09-06', 5, 38, 11, 'Drama|Romance', 110, '198425703-X', 'Physeal arrest, forearm', 'Excision of Right Renal Artery, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (56, '2017-07-23 16:35:57', 'Hannah Montana: The Movie', '1935-05-15', 3, 43, 9, 'Comedy|Drama|Musical|Romance', 99, '525237172-5', 'Nondisp fx of body of unsp calcaneus, 7thG', 'Alteration of Right Buttock with Autologous Tissue Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (57, '2017-05-13 14:46:19', 'Amor?', '1978-08-30', 1, 21, 5, 'Drama', 129, '026536698-4', 'Poisoning by anthelminthics, undetermined, sequela', 'Drainage of Cranial Cavity, Open Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (58, '2017-04-13 07:03:53', 'Terror of Mechagodzilla (Mekagojira no gyakushu)', '1925-10-02', 2, 14, 1, 'Action|Sci-Fi', 191, '401540143-3', 'Complications of anesthesia during the puerperium', 'Revision of Synthetic Substitute in Left Knee Joint, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (59, '2017-07-06 01:27:50', 'A Magnificent Haunting', '1964-02-27', 2, 15, 3, 'Drama', 165, '866619090-6', 'Serous choroidal detachment, bilateral', 'Restriction of Left Kidney Pelvis with Intraluminal Device, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (60, '2017-07-20 22:16:23', 'Two Night Stand', '1967-05-22', 3, 50, 8, 'Comedy|Romance', 105, '922221122-7', 'Lacerat unsp musc/fasc/tend at forarm lv, left arm, sequela', 'Destruction of Left Nipple, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (61, '2017-10-29 20:04:09', 'Man from the Future, The (O Homem do Futuro)', '1963-03-05', 3, 28, 7, 'Comedy|Fantasy|Sci-Fi', 92, '117235554-1', 'Exhaustion due to exposure, sequela', 'Drainage of Left Internal Mammary Artery, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (62, '2017-10-03 08:55:42', 'Jason and the Argonauts', '1968-05-16', 4, 14, 5, 'Action|Adventure|Fantasy', 145, '133631858-9', 'Oth fx upr and low end l fibula, subs for clos fx w malunion', 'Supplement Right Orbit with Nonautologous Tissue Substitute, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (63, '2017-07-21 01:49:30', 'House of Angels (Änglagård)', '1930-01-11', 3, 28, 2, 'Comedy|Drama', 120, '475049091-1', 'Multiple fractures of pelvis w/o disruption of pelvic ring', 'Drainage of Right Cornea, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (64, '2017-08-23 21:48:26', 'Juha', '1936-01-13', 5, 19, 2, 'Comedy|Drama|Romance', 108, '043888877-4', 'Toxic effect of oth metals, intentional self-harm, init', 'Insertion of Cardiac Lead into Right Atrium, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (65, '2017-05-24 01:55:54', 'Bomber', '2017-10-23', 3, 48, 2, 'Action|Comedy', 157, '027056624-4', 'Oth fx fourth MC bone, left hand, subs for fx w malunion', 'Replacement of Perineum Tendon with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (66, '2017-08-31 06:44:17', 'Nightmare on Elm Street 2: Freddy''s Revenge, A', '1992-03-26', 1, 47, 4, 'Horror', 168, '477855201-6', 'Juvenile dermatopolymyositis with respiratory involvement', 'Repair Male Perineum, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (67, '2017-04-29 05:52:22', 'Way Back, The', '1975-04-04', 2, 25, 1, 'Drama', 117, '364293002-6', 'Osteopathy in diseases classified elsewhere, upper arm', 'Plain Radiography of Left Subclavian Artery using Low Osmolar Contrast');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (68, '2017-12-09 23:38:16', 'Subject Two', '1999-11-16', 4, 44, 4, 'Drama|Thriller', 155, '517517493-2', 'Nondisp fx of lateral condyle of unsp tibia, 7thP', 'Reattachment of Left Abdomen Bursa and Ligament, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (69, '2017-08-12 16:04:01', 'Killing Bono', '1964-02-12', 1, 47, 5, 'Comedy', 146, '334480929-6', 'Sprain of tarsal ligament of unspecified foot, init encntr', 'Bypass Left Axillary Vein to Upper Vein, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (70, '2017-12-17 21:42:16', 'Dracula: Prince of Darkness', '1944-03-25', 5, 34, 2, 'Horror|Mystery', 189, '893098440-1', 'Sltr-haris Type II physl fx low end humer, r arm, 7thP', 'Measurement of Respiratory Rate, Via Natural or Artificial Opening');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (71, '2017-04-15 07:13:45', 'I''m So Excited (Los amantes pasajeros)', '1947-05-11', 1, 36, 11, 'Comedy', 113, '134253994-X', 'Preterm labor third tri w preterm del third tri, fetus 3', 'Bypass Right Femoral Vein to Lower Vein with Synthetic Substitute, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (72, '2017-08-16 14:29:27', 'Deadly Spawn, The', '2012-08-14', 4, 2, 10, 'Horror|Sci-Fi', 127, '037507710-3', 'Unspecified dislocation of right shoulder joint, sequela', 'Drainage of Thoracic Spinal Cord, Percutaneous Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (73, '2017-09-21 23:12:54', 'Undisputed', '1948-08-10', 4, 36, 8, 'Drama', 167, '865626495-8', 'Hit by object from burning bldg in controlled fire', 'Caregiver Training in Dressing using Prosthesis');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (74, '2017-06-11 00:44:01', 'Remorques (Stormy Waters)', '1972-09-18', 4, 38, 5, 'Action|Drama|Romance', 115, '867724425-5', 'Acute angle-closure glaucoma, right eye', 'Reposition Intracranial Vein, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (75, '2017-04-11 20:08:34', 'Morning for the Osone Family', '1996-03-31', 1, 10, 4, '(no genres listed)', 119, '481763306-9', 'Handgun discharge, undetermined intent, initial encounter', 'Removal of Nonautologous Tissue Substitute from Sternum, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (76, '2017-07-13 03:37:13', 'Who''s That Knocking at My Door?', '1983-10-03', 2, 23, 8, 'Drama', 117, '030173702-9', 'Insect bite (nonvenomous) of breast, unsp breast, init', 'Removal of Infusion Device from Hepatobiliary Duct, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (77, '2017-06-26 02:31:01', 'Fados', '1927-11-11', 1, 31, 1, 'Documentary|Musical', 143, '518742955-8', 'Dislocation of carpometacarpal joint of left thumb, sequela', 'Resection of Left Foot Muscle, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (78, '2017-09-06 06:25:14', 'Lumiere and Company (Lumière et compagnie)', '2008-05-28', 1, 19, 5, 'Documentary', 125, '702071388-2', 'Herpes gestationis', 'Bypass Ascending Colon to Descending Colon with Nonautologous Tissue Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (79, '2017-11-01 16:51:55', 'Liverpool', '1995-06-03', 1, 11, 5, 'Drama', 187, '157781222-0', 'Nondisp fx of greater trochanter of unsp femr, 7thH', 'Bypass Innominate Artery to Right Extracranial Artery with Autologous Arterial Tissue, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (80, '2017-11-09 00:31:14', 'Before I Go to Sleep', '2012-03-15', 1, 27, 2, 'Mystery|Thriller', 92, '981932428-9', 'Mech compl of other urinary devices and implants', 'Drainage of Right Temporal Artery, Percutaneous Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (81, '2017-11-14 14:36:51', 'Two Brothers (Deux frères)', '1960-09-01', 4, 20, 7, 'Adventure|Children|Drama', 110, '159690215-9', 'Corrosion of first deg mult sites of left wrist and hand', 'Restriction of Left Axillary Artery, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (82, '2017-07-04 01:08:30', 'Where Eagles Dare', '1966-09-18', 3, 22, 5, 'Action|Adventure|War', 107, '287814399-X', 'Explosion of bicycle tire, sequela', 'Plaque Radiation of Left Breast');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (83, '2017-12-15 18:22:24', 'Mr. Majestyk', '1954-04-01', 4, 28, 8, 'Action|Drama', 157, '602394255-5', 'Burn of unspecified degree of left foot, subs encntr', 'Inspection of Left Temporomandibular Joint, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (84, '2017-04-24 05:07:30', 'Forget Paris', '1963-06-02', 1, 41, 6, 'Comedy|Romance', 116, '661776339-4', 'Fall in (into) bucket of water causing other injury, sequela', 'Planar Nuclear Medicine Imaging of Left Upper Extremity Veins using Other Radionuclide');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (85, '2017-11-03 08:18:39', 'Born to Fight', '1948-08-26', 1, 6, 9, 'Action|Children|Drama', 123, '555165386-2', 'Low vision, left eye, normal vision right eye', 'Replacement of Right Temporal Bone with Nonautologous Tissue Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (86, '2017-11-19 21:34:46', 'Ruby Red', '1968-11-05', 2, 7, 3, 'Adventure|Children|Fantasy|Sci-Fi', 97, '984946217-5', 'Milt op involving dest arcrft due to clsn w oth aircraft', 'Computerized Tomography (CT Scan) of Left Pulmonary Artery using High Osmolar Contrast');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (87, '2017-04-15 18:31:54', 'Control Room', '1973-05-05', 5, 1, 5, 'Documentary|War', 195, '492457408-2', 'Nondisp fx of medial condyle of r humerus, init for opn fx', 'Bypass Portal Vein to Lower Vein, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (88, '2017-04-06 21:51:04', 'Angels and Insects', '1994-04-29', 4, 17, 9, 'Drama|Romance', 154, '850517058-X', 'Subluxation of C6/C7 cervical vertebrae, subs encntr', 'Insertion of Vascular Access Device into Right Lower Leg Subcutaneous Tissue and Fascia, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (89, '2017-08-08 07:43:07', 'We Are Young. We Are Strong.', '1990-08-22', 3, 15, 10, 'Drama', 148, '320427677-5', 'Supervision of pregnancy with history of infertility', 'Drainage of Left Tunica Vaginalis, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (90, '2017-10-20 13:18:38', 'Freddy Got Fingered', '1955-05-08', 4, 47, 1, 'Comedy', 111, '120605182-5', 'Quadriplegia, C5-C7 incomplete', 'Detachment at Left Foot, Complete 5th Ray, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (91, '2017-07-19 17:13:50', 'Brokedown Palace', '1944-02-15', 4, 19, 8, 'Drama', 121, '961758623-1', 'Primary blast injury of transverse colon', 'Insertion of Intraluminal Device into Right Hand Vein, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (92, '2017-08-16 18:32:38', 'Rambo: First Blood Part II', '1931-12-06', 4, 31, 4, 'Action|Adventure|Thriller', 185, '207149166-1', 'Breakdown of artificial skin grft /decellular alloderm, subs', 'Drainage of Hymen, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (93, '2017-05-06 16:32:05', 'Yobi, The Five-Tailed Fox', '1959-12-11', 1, 7, 9, 'Animation|Fantasy', 144, '052877064-0', 'Injury of peroneal nerve at lower leg level, right leg, subs', 'Range of Motion and Joint Mobility Treatment of Integumentary System - Head and Neck using Orthosis');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (94, '2017-06-16 01:37:14', 'Goldfish Memory', '1923-09-27', 4, 8, 6, 'Comedy|Drama', 197, '375162633-6', 'Adverse effect of other bacterial vaccines', 'Drainage of Bilateral Adrenal Glands, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (95, '2017-11-21 14:08:06', 'Orwell Rolls in His Grave', '1917-04-23', 4, 6, 3, 'Documentary', 108, '636063104-0', 'Nondisp fx of med malleolus of unsp tibia, 7thR', 'Drainage of Left Upper Extremity with Drainage Device, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (96, '2017-08-17 12:36:53', 'Over My Dead Body', '1925-07-10', 3, 9, 8, 'Comedy|Fantasy|Romance', 127, '073227417-6', 'Pain in limb, unspecified', 'Transfusion of Nonautologous Frozen Red Cells into Central Artery, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (97, '2017-09-30 20:10:00', 'Time That Remains, The', '1947-01-04', 3, 2, 11, 'Drama', 96, '287146250-X', 'Latex allergy status', 'Insertion of Infusion Device into Right Peroneal Artery, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (98, '2017-11-12 23:45:01', 'Titanic', '1960-10-04', 4, 30, 1, 'Action|Drama', 148, '690489827-5', 'Contact with power take-off devices (PTO), sequela', 'Excision of Head Lymphatic, Open Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (99, '2017-08-26 07:30:40', 'Miami Rhapsody', '1949-12-13', 3, 35, 5, 'Comedy', 97, '851010003-9', 'Idiopathic chronic gout, unsp shoulder, without tophus', 'Excision of Lumbar Vertebral Joint, Percutaneous Endoscopic Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (100, '2017-09-14 07:41:54', 'Commare secca, La (Grim Reaper, The)', '1942-02-04', 3, 44, 10, 'Drama|Mystery', 104, '143946566-5', 'Inj unsp musc/fasc/tend at shldr/up arm, left arm, subs', 'Drainage of Right Ankle Region, Open Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (101, '2017-08-03 04:55:22', 'Hanging Up', '1977-01-20', 5, 11, 10, 'Comedy|Drama', 134, '006810841-9', 'Epidural hemorrhage w LOC of 31-59 min, init', 'Revision of Diaphragmatic Pacemaker Lead in Diaphragm, Via Natural or Artificial Opening');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (102, '2017-08-20 00:47:15', 'Blaise Pascal', '1981-01-24', 1, 37, 9, 'Drama', 182, '525709459-2', 'Injury of portal vein', 'Revision of Autologous Tissue Substitute in Facial Bone, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (103, '2017-10-01 14:26:10', 'Amber Alert ', '1967-10-28', 3, 1, 11, 'Thriller', 157, '809165370-0', 'Laceration of peroneal artery, left leg, initial encounter', 'Removal of Autologous Tissue Substitute from Heart, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (104, '2017-04-10 10:08:27', 'Car Wash', '2005-02-21', 3, 32, 7, 'Comedy', 122, '124441129-9', 'Parachutist injured on landing, sequela', 'Removal of Radioactive Element from Pericardial Cavity, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (105, '2017-12-06 02:37:10', 'Lemora: A Child''s Tale of the Supernatural', '1943-04-22', 4, 17, 7, 'Horror', 91, '347139605-5', 'Lateral disloc of proximal end of tibia, left knee, sequela', 'Drainage of Pituitary Gland with Drainage Device, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (106, '2017-05-12 10:38:57', 'Paris Blues', '1953-01-22', 2, 30, 11, 'Drama|Romance', 181, '762498301-X', 'Hordeolum externum unspecified eye, unspecified eyelid', 'Insertion of Spacer into Lumbosacral Disc, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (107, '2017-07-23 16:03:33', 'April Fool''s Day', '1945-03-10', 2, 50, 2, 'Horror', 182, '648140039-2', 'Nondisp fx of med condyle of l femr, 7thQ', 'Introduction of Autologous Fertilized Ovum into Female Reproductive, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (108, '2017-12-09 07:01:13', 'Mona and the Time of Burning Love (Mona ja palavan rakkauden aika))', '1995-12-08', 4, 41, 3, 'Drama', 112, '264476507-2', 'Poisoning by expectorants, undetermined, sequela', 'Removal of Autologous Tissue Substitute from Right Thumb Phalanx, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (109, '2017-07-18 21:34:13', 'Myth of the American Sleepover, The', '1987-04-10', 5, 2, 9, 'Comedy|Drama|Romance', 151, '420481084-5', 'Toxic effect of venom of other spider, assault, init encntr', 'Insertion of Infusion Device into Left Metatarsal-Tarsal Joint, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (110, '2017-06-05 19:20:33', 'Night Ambush (Ill Met by Moonlight)', '1932-02-21', 3, 41, 10, 'Action|Adventure|Drama|War', 137, '229753978-9', 'Burn first deg mult right fngr (nail), not inc thumb, init', 'Removal of Infusion Device from Upper Vein, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (111, '2017-09-08 02:04:27', 'Knock on Any Door', '2013-08-29', 2, 21, 5, 'Crime|Drama|Film-Noir', 171, '488614080-7', 'Sexual masochism', 'Excision of Vagina, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (112, '2017-05-01 19:32:47', 'Those Magnificent Men in Their Flying Machines', '1993-08-06', 2, 13, 2, 'Action|Adventure|Comedy', 94, '906010801-9', 'Oth osteopor w crnt path fx, r femr, 7thG', 'Extraction of Ova, Open');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (113, '2017-08-24 07:48:33', 'Adventures in Babysitting', '1956-11-26', 1, 6, 9, 'Adventure|Comedy', 155, '032856058-8', 'Driver of hv veh injured in nonclsn trnsp acc in traf, init', 'Tomographic (Tomo) Nuclear Medicine Imaging of Lungs and Bronchi using Technetium 99m (Tc-99m)');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (114, '2017-04-07 14:02:00', 'Sleepy Time Gal, The', '1966-01-10', 4, 19, 3, 'Drama', 106, '956738842-3', 'Drug induced acute pancreatitis with uninfected necrosis', 'Drainage of Left Ovary with Drainage Device, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (115, '2017-07-29 00:45:27', 'Billy Jack Goes to Washington', '1963-11-24', 1, 1, 2, 'Drama', 136, '353662423-5', 'Displaced pilon fx unsp tibia, subs for clos fx w malunion', 'Beam Radiation of Pituitary Gland using Electrons');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (116, '2017-11-01 10:34:51', 'King of Germany', '1944-02-12', 5, 14, 1, 'Comedy', 191, '038638230-1', 'Unspecified sprain of thumb', 'Revision of Nonautologous Tissue Substitute in Left Metatarsal-Tarsal Joint, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (117, '2017-12-02 16:44:12', 'Art School Confidential', '2006-11-02', 3, 34, 7, 'Comedy|Drama', 144, '826536405-9', 'Traumatic rupture of left ulnar collateral ligament', 'Insertion of Feeding Device into Duodenum, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (118, '2017-06-19 10:14:58', 'All American Orgy (Cummings Farm)', '1958-08-10', 2, 44, 4, 'Comedy', 159, '502480863-0', 'Superficial foreign body of right elbow, initial encounter', 'Planar Nuclear Medicine Imaging of Abdomen using Iodine 131 (I-131)');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (119, '2017-10-30 10:40:44', 'Below Sea Level', '1954-09-13', 5, 35, 6, 'Documentary', 150, '677866320-0', 'Hemarthrosis, left hand', 'Revision of Synthetic Substitute in Abdominal Wall, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (120, '2017-08-16 06:28:47', 'Christmas Toy, The', '1985-06-26', 2, 32, 4, 'Children|Musical', 155, '083765434-3', 'Pathological fracture, left hand, init encntr for fracture', 'Removal of External Fixation Device from Left Patella, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (121, '2017-08-21 16:29:55', 'Swedish Love Story, A (Kärlekshistoria, En)', '1999-04-11', 1, 12, 2, 'Drama|Romance', 90, '615825796-6', 'Oth comp of fb acc left in body fol remov cath/pack, sequela', 'Inspection of Upper Tendon, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (122, '2017-04-28 08:09:37', 'West Is West', '1960-06-25', 1, 9, 10, 'Comedy|Drama', 92, '594224483-9', 'Displ unsp condyle fx low end l femr, 7thB', 'Occlusion of Left Inguinal Lymphatic with Intraluminal Device, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (123, '2017-10-16 08:07:52', 'Welcome to Sherwood! The Story of ''The Adventures of Robin Hood''', '1955-01-02', 5, 14, 5, 'Documentary', 189, '837320703-1', 'Complex regional pain syndrome I of left upper limb', 'Supplement Left Upper Femur with Autologous Tissue Substitute, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (124, '2017-09-12 16:43:26', 'American Bandits: Frank and Jesse James', '2016-09-06', 2, 42, 10, 'Western', 154, '189831190-0', 'Disp fx of lateral cuneiform of l ft, 7thD', 'Drainage of Right Palatine Bone, Open Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (125, '2017-06-07 06:21:14', 'Up the River', '1967-02-12', 1, 3, 2, 'Comedy|Crime|Drama', 171, '207863328-3', 'Other bursitis of elbow, right elbow', 'Reposition Upper Tooth, Single, with External Fixation Device, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (126, '2017-06-05 23:57:24', 'Protector, The', '1987-12-11', 3, 5, 11, 'Action|Comedy|Drama|Thriller', 173, '697408514-1', 'Complete traum amp at level betw knee and ankl, unsp low leg', 'Occlusion of Accessory Pancreatic Duct with Intraluminal Device, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (127, '2017-12-05 03:28:43', 'Rocaterrania', '1995-08-30', 3, 47, 9, 'Documentary|Fantasy', 156, '626972196-2', 'Other fracture of shaft of humerus', 'Release Lower Gingiva, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (128, '2017-07-12 23:24:23', 'Addiction, The', '2000-05-28', 3, 14, 8, 'Drama|Horror', 193, '711552590-0', 'Unspecified malignant neoplasm of anal skin', 'Resection of Epiglottis, Via Natural or Artificial Opening');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (129, '2017-10-13 16:21:31', 'The Hunchback of Paris', '1945-06-24', 4, 38, 8, 'Action|Adventure', 152, '802001411-X', 'Oth disrd of amniotic fluid and membrns, unsp tri, fetus 2', 'Revision of Autologous Tissue Substitute in Left Carpal Joint, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (130, '2017-07-10 23:38:29', 'Chaos', '2011-10-09', 1, 25, 3, 'Crime|Drama|Horror', 90, '512284397-X', 'Path fx in oth disease, r tibia, subs for fx w delay heal', 'Revision of Drainage Device in Larynx, Via Natural or Artificial Opening');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (131, '2017-04-22 07:22:15', 'Conrack', '1939-02-17', 4, 24, 6, 'Drama', 127, '437213875-X', 'Nondisp fx of dist phalanx of r lit fngr, 7thD', 'Transfer Left Abdomen Muscle, Transverse Rectus Abdominis Myocutaneous Flap, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (132, '2017-05-16 17:57:32', 'Manson', '1962-06-09', 5, 23, 9, 'Documentary', 178, '948942500-1', 'Oth fracture of third lumbar vertebra, init for opn fx', 'Replacement of Pulmonary Valve with Nonautologous Tissue Substitute, Transapical, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (133, '2017-07-04 11:23:32', 'Taming of the Shrew, The', '1993-12-05', 2, 27, 10, 'Comedy', 129, '057189702-9', 'Oth malignant neoplasm of skin of oth and unsp parts of face', 'Transplantation of Lung Lingula, Zooplastic, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (134, '2017-06-10 09:59:19', 'Moment to Remember, A (Nae meorisokui jiwoogae)', '1931-07-10', 3, 28, 10, 'Drama|Romance', 176, '637320714-5', 'Awaiting organ transplant status', 'Reposition Left Metatarsal, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (135, '2017-11-08 10:00:57', 'There Will Be Blood', '1972-11-27', 2, 17, 2, 'Drama|Western', 97, '029491783-7', 'Contusion of left little finger w damage to nail, init', 'Low Dose Rate (LDR) Brachytherapy of Bronchus using Palladium 103 (Pd-103)');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (136, '2017-07-05 18:53:30', 'Zona Zamfirova', '1973-10-05', 5, 18, 7, 'Comedy|Drama', 200, '981654866-6', 'Simple and mucopurulent chronic bronchitis', 'Drainage of Right Basilic Vein, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (137, '2017-06-04 01:40:52', '27 Club, The', '2005-01-29', 3, 47, 1, 'Drama', 163, '591813327-5', 'Displaced fracture of medial cuneiform of right foot', 'Fragmentation in Right Main Bronchus, Via Natural or Artificial Opening');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (138, '2017-04-26 07:23:35', 'Poison Ivy: New Seduction', '1992-03-12', 5, 41, 9, 'Drama|Thriller', 137, '651702395-X', 'Traum rupt of palmar ligmt of r rng fngr at MCP/IP jt, sqla', 'Extirpation of Matter from Right Popliteal Artery, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (139, '2017-10-28 16:08:01', 'Last Witness, The', '1917-06-21', 4, 22, 9, 'Drama|Thriller', 126, '659024416-2', 'Unspecified dislocation of left sternoclavicular joint', 'Drainage of Right Subclavian Artery, Percutaneous Endoscopic Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (140, '2017-11-13 20:45:55', 'Adventures of Sharkboy and Lavagirl 3-D, The', '1931-02-18', 5, 42, 9, 'Action|Adventure|Children|Fantasy', 179, '294746053-7', 'Lac w/o fb of r frnt wl of thorax w penet thor cavity, subs', 'Drainage of Sacrum, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (141, '2017-05-26 23:39:46', 'Game of Death', '1922-11-08', 3, 49, 9, 'Action|Adventure|Thriller', 178, '547304568-5', 'Methicillin resis staph infection, unsp site', 'Excision of Accessory Pancreatic Duct, Via Natural or Artificial Opening Endoscopic, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (142, '2017-04-07 12:13:25', 'FM', '1936-05-22', 3, 1, 9, 'Drama', 132, '946447504-8', 'Complete traum amp of l hip and thigh, level unsp, sequela', 'Dilation of Left Thyroid Artery, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (143, '2017-11-26 01:42:45', 'Desert Trail, The', '1943-08-02', 5, 23, 7, 'Western', 172, '402804674-2', 'Other specified injuries of neck', 'Drainage of Left Lower Extremity, Percutaneous Endoscopic Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (144, '2017-08-16 06:45:52', 'Snakes on a Plane', '1986-07-14', 3, 12, 3, 'Action|Comedy|Horror|Thriller', 118, '639409726-8', 'Heredit neuropath, NEC w diffuse mesangial prolif glomrlneph', 'Revision of Internal Fixation Device in Left Metatarsal-Tarsal Joint, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (145, '2017-05-13 05:52:20', 'Stephen Tobolowsky''s Birthday Party', '1977-05-29', 1, 39, 4, 'Comedy|Documentary|Drama', 197, '301404943-3', 'Unsp malignant neoplasm skin/ right lower limb, inc hip', 'Insertion of Monitoring Electrode into Products of Conception, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (146, '2017-08-13 19:45:15', 'Soul of a Man, The', '1973-03-03', 5, 26, 4, 'Documentary|Musical', 124, '813972046-1', 'Double inlet ventricle', 'Release Right External Iliac Vein, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (147, '2017-08-23 08:43:23', 'Dracula''s Daughter', '1971-01-28', 5, 32, 2, 'Drama|Horror', 147, '151618644-3', 'Iridodialysis', 'Revision of Nonautologous Tissue Substitute in Upper Bursa and Ligament, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (148, '2017-04-08 09:33:27', 'Madame Tutli-Putli', '1955-11-09', 1, 1, 4, 'Animation|Fantasy', 134, '160431537-7', 'Poisoning by peripheral vasodilators, accidental, init', 'Removal of Synthetic Substitute from Lumbar Vertebral Disc, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (149, '2017-12-11 01:03:40', 'Christmas Tale, A (Un conte de Noël)', '1933-12-10', 4, 21, 4, 'Comedy|Drama', 143, '943957910-2', 'Oth benign neoplasm skin/ left eyelid, including canthus', 'Insertion of Infusion Device into Hepatic Vein, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (150, '2017-10-26 17:24:08', 'Mr. & Mrs. Smith', '1932-10-13', 4, 47, 6, 'Comedy|Romance', 143, '754984598-0', 'Unsp superficial injury of left lower leg, init encntr', 'Dilation of Middle Colic Artery with Four or More Drug-eluting Intraluminal Devices, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (151, '2017-08-08 08:12:34', 'Love Meetings (Comizi d''amore)', '1988-12-21', 1, 27, 5, 'Documentary', 164, '268172617-4', 'Glider (nonpowered) accident injuring occupant', 'Reposition Facial Muscle, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (152, '2017-05-03 06:02:52', 'Thunder Bay', '1963-05-11', 5, 1, 6, 'Adventure', 113, '994733571-2', 'Displaced transverse fx shaft of left femur, sequela', 'Excision of Upper Back, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (153, '2017-11-10 12:33:25', 'Outrageous Class (Hababam sinifi)', '1929-09-01', 5, 48, 7, 'Comedy|Drama', 90, '160861264-3', 'Essential fatty acid [EFA] deficiency', 'Supplement Bilateral Breast with Synthetic Substitute, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (154, '2017-04-29 02:07:40', 'Broadway Melody of 1938', '1965-07-21', 5, 48, 2, 'Musical|Romance', 99, '258162740-9', 'Unspecified superficial injury of right ear, subs encntr', 'Reposition Left Upper Leg Tendon, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (155, '2017-08-04 03:18:47', 'Caribe', '1976-12-21', 5, 45, 3, 'Drama|Mystery|Romance', 183, '289016759-3', 'Nondisp fx of med cuneiform of l ft, 7thD', 'Drainage of Left External Iliac Artery, Percutaneous Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (156, '2017-10-06 19:19:55', 'Without a Paddle: Nature''s Calling', '1922-08-14', 2, 32, 11, 'Adventure|Comedy', 165, '490435895-3', 'Fx unsp part of scapula, l shldr, subs for fx w delay heal', 'Extirpation of Matter from Right External Jugular Vein, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (157, '2017-09-21 03:24:35', 'Bamako', '1991-01-16', 4, 28, 7, 'Drama', 133, '557094307-2', 'Corrosion of unspecified degree of scalp [any part], sequela', 'Excision of Right Lower Leg Skin, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (158, '2017-06-13 09:10:11', 'New Rulers of the World, The', '1962-06-09', 4, 12, 6, 'Documentary', 96, '563030104-7', 'Mtrcy passenger injured in clsn w unsp mv in traf, sequela', 'Removal of Resurfacing Device from Right Hip Joint, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (159, '2017-04-22 18:02:38', 'General''s Daughter, The', '1999-01-19', 2, 19, 9, 'Crime|Drama|Mystery|Thriller', 116, '729273827-3', 'Counseling related to sexual attitude', 'Dilation of Upper Vein, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (160, '2017-08-31 12:22:25', 'Heidi Fleiss: Hollywood Madam', '1994-06-27', 5, 23, 4, 'Documentary', 167, '911618342-8', 'Eccrine sweat disorder, unspecified', 'Release Right External Iliac Vein, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (161, '2017-06-18 23:51:49', 'Chattahoochee', '1951-07-05', 2, 4, 3, 'Drama', 95, '328616075-X', 'Oth fx of lower end unsp radius, init for opn fx type 3A/B/C', 'Replacement of Tricuspid Valve with Autologous Tissue Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (162, '2017-04-09 15:49:56', 'Kanal', '1920-12-01', 2, 1, 1, 'Drama|War', 101, '899739541-6', 'Unspecified dislocation of right index finger, sequela', 'Revision of Infusion Pump in Upper Extremity Subcutaneous Tissue and Fascia, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (163, '2017-04-26 00:15:34', 'Cameraman, The', '1995-07-17', 4, 47, 10, 'Comedy|Drama|Romance', 175, '979002323-5', 'Trisomy 13, translocation', 'Bypass Descending Colon to Sigmoid Colon with Autologous Tissue Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (164, '2017-11-07 03:29:23', 'Party, The', '1976-10-10', 2, 23, 7, 'Comedy', 173, '718049977-3', 'Total (external) ophthalmoplegia, bilateral', 'Change Other Device in Pelvic Cavity, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (165, '2017-06-03 21:37:32', 'Love Finds Andy Hardy', '1935-03-15', 3, 39, 10, 'Comedy|Romance', 112, '259033024-3', 'Toxic effect of oth pesticides, intentional self-harm, init', 'Release Right Middle Lobe Bronchus, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (166, '2017-11-17 20:52:27', 'Waking Ned Devine (a.k.a. Waking Ned)', '2002-03-11', 3, 49, 10, 'Comedy', 106, '683518089-7', 'Ehrlichiosis', 'Insertion of Infusion Device into Left Subclavian Vein, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (167, '2017-06-23 21:41:17', 'Witnesses, The (Les témoins)', '1945-04-08', 2, 35, 10, 'Drama', 198, '536738132-4', 'Other fall on same level, subsequent encounter', 'Bypass Bilateral Ureters to Ileocutaneous with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (168, '2017-07-30 02:14:52', 'Vampire in Venice (Nosferatu a Venezia) (Nosferatu in Venice)', '1960-09-06', 1, 47, 8, 'Horror', 151, '067359433-5', 'Partial traumatic MCP amputation of thmb, sequela', 'Repair Pituitary Gland, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (169, '2017-05-10 06:53:26', 'Suck', '1975-03-14', 5, 14, 3, 'Comedy|Horror|Musical', 182, '606370764-6', 'Diseases of the circ sys comp pregnancy, first trimester', 'Dilation of Left Popliteal Artery with Four or More Intraluminal Devices, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (170, '2017-11-11 22:43:07', 'Heart Is a Lonely Hunter, The', '1945-08-12', 4, 24, 9, 'Drama', 167, '325612364-3', 'Meningismus', 'Drainage of Abdominal Sympathetic Nerve with Drainage Device, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (171, '2017-09-01 20:08:59', 'Angels & Demons', '1982-03-25', 3, 33, 3, 'Crime|Drama|Mystery|Thriller', 170, '949432642-3', 'Partial traumatic MCP amputation of right thumb, sequela', 'Release Left Carotid Body, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (172, '2017-06-24 07:55:53', 'W.E.', '1981-08-27', 4, 23, 5, 'Drama|Romance', 180, '161969914-1', 'Sprain of metatarsophalangeal joint of unsp toe(s), subs', 'Reposition Right Internal Mammary Artery, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (173, '2017-08-25 01:29:17', 'Prophecy II, The', '2012-12-17', 1, 11, 10, 'Horror', 158, '649094462-6', 'Unsp disp fx of sixth cervcal vert, subs for fx w nonunion', 'Extirpation of Matter from Left Colic Artery, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (174, '2017-09-21 09:04:26', 'My Father''s Glory (La gloire de mon père)', '1974-01-07', 2, 5, 10, 'Adventure|Drama', 148, '149345830-2', 'Resistance to beta lactam antibiotics', 'Removal of Radioactive Element from Hepatobiliary Duct, Via Natural or Artificial Opening Endoscopic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (175, '2017-12-02 22:23:18', 'Afterglow', '2004-07-15', 4, 49, 3, 'Drama|Romance', 194, '495181916-3', 'Other spacecraft accident injuring occupant, init encntr', 'Supplement Left Vas Deferens with Synthetic Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (176, '2017-11-16 11:47:50', 'Heavy', '1943-05-27', 3, 36, 2, 'Drama|Romance', 146, '449166113-8', 'Superficial foreign body of penis, sequela', 'Removal of Drainage Device from Upper Bone, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (177, '2017-07-01 16:44:41', 'Place of One''s Own, A', '1979-09-03', 1, 7, 4, 'Drama|Mystery|Thriller', 122, '044233949-6', 'Nondisp pilon fx right tibia, subs for clos fx w delay heal', 'Drainage of Left Sublingual Gland, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (178, '2017-08-30 15:16:41', 'Perfect Day, A (Un giorno perfetto)', '1919-11-26', 1, 34, 2, 'Drama', 123, '097093374-6', 'Rupture of card wall w/o hemoperic as current comp fol AMI', 'Revision of Nonautologous Tissue Substitute in Right Toe Phalanx, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (179, '2017-11-11 14:18:16', 'Big Day, The (We Met on the Vineyard)', '1998-12-17', 2, 42, 8, 'Comedy', 127, '302839322-0', 'Contusion of scrotum and testes', 'Transfusion of Autologous Antihemophilic Factors into Central Vein, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (180, '2017-05-27 17:18:54', 'Frankenstein', '2018-01-26', 1, 5, 3, 'Drama|Horror|Sci-Fi', 106, '582464054-8', 'Drug/chem diabetes mellitus w oral complications', 'Extirpation of Matter from Pelvic Cavity, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (181, '2017-09-24 03:29:38', 'Men, Women & Children', '1964-12-02', 4, 10, 8, 'Comedy|Drama', 131, '831579650-X', 'Oth injury of popliteal artery, unspecified leg, subs encntr', 'Bypass Left Femoral Artery to Left Femoral Artery with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (182, '2017-12-14 02:39:05', 'Macbeth (a.k.a. Tragedy of Macbeth, The)', '1987-03-29', 2, 49, 5, 'Drama', 112, '700951625-1', 'Lacerat blood vessels at ank/ft level, right leg, sequela', 'Removal of Synthetic Substitute from Right Radius, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (183, '2017-11-29 10:31:01', 'Tobor the Great', '1950-11-06', 5, 1, 3, 'Children|Sci-Fi', 122, '327421922-3', 'Laceration of unsp msl/tnd at ank/ft level, left foot', 'Reposition Left Humeral Shaft with Intramedullary Internal Fixation Device, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (184, '2017-08-02 06:53:45', 'Tyler Perry''s Madea''s Big Happy Family', '1964-10-27', 5, 16, 4, 'Comedy|Drama', 156, '352465217-4', 'Stiffness of joint, not elsewhere classified', 'Removal of Infusion Device from Esophagus, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (185, '2017-12-10 01:48:45', 'Innocents, The', '1967-11-12', 4, 33, 1, 'Drama|Horror|Thriller', 122, '010422151-8', 'Sltr-haris Type IV physeal fracture of l calcaneus, sequela', 'Replacement of Left Ethmoid Bone with Synthetic Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (186, '2017-08-16 00:17:13', 'Changeling, The', '1939-07-25', 4, 31, 5, 'Horror|Mystery|Thriller', 188, '640625671-9', 'Nondisp transverse fx r patella, 7thD', 'Dilation of Coronary Artery, Four or More Arteries, Bifurcation, with Two Drug-eluting Intraluminal Devices, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (187, '2017-08-21 00:59:47', 'Defender, The (a.k.a. Bodyguard from Beijing, The) (Zhong Nan Hai bao biao)', '1946-07-02', 4, 25, 2, 'Action', 168, '549933271-1', 'Oth diab with prolif diabetic rtnop with trctn dtch n-mcla', 'Inspection of Left Carpal Joint, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (188, '2017-05-26 05:49:05', 'Stake Land', '2005-08-07', 5, 37, 10, 'Horror', 98, '534184678-8', 'Incomplete spontaneous abortion with other complications', 'Repair Cervical Vertebral Joint, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (189, '2017-07-20 19:48:04', 'King of California', '1935-09-10', 5, 3, 4, 'Comedy', 96, '949626267-8', 'Transient synovitis, left hand', 'Destruction of Right Temporal Bone, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (190, '2017-12-04 19:44:01', 'Beethoven''s 5th', '1939-03-28', 2, 7, 7, 'Adventure|Children|Comedy', 148, '935309783-5', 'Unsp injury of popliteal vein, unspecified leg, subs encntr', 'Dilation of Left Internal Mammary Artery with Four or More Drug-eluting Intraluminal Devices, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (191, '2017-11-02 05:52:34', 'Primal', '1930-08-21', 2, 18, 8, 'Horror|Thriller', 145, '074869982-1', 'Pressr collapse of lung d/t anesth during preg, second tri', 'Destruction of Left Wrist Joint, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (192, '2017-05-17 09:11:19', 'Aziz Ansari: Intimate Moments for a Sensual Evening', '1989-06-18', 3, 37, 5, 'Comedy|Documentary', 100, '717414304-0', 'Disp fx of med epicondyl of l humer, 7thG', 'Division of Right Upper Leg Tendon, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (193, '2017-05-26 21:35:56', 'Ron Clark Story, The', '2000-02-14', 1, 13, 4, 'Drama', 152, '838497346-6', 'Displ unsp condyle fx low end l femr, 7thG', 'Revision of Drainage Device in Peritoneum, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (194, '2017-10-28 03:40:47', 'Camille', '1987-11-18', 1, 13, 5, 'Comedy|Drama|Romance', 97, '432305244-8', 'Nondisp fx of med condyle of l femr, 7thR', 'Insertion of External Fixation Device into Right Metatarsal-Tarsal Joint, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (195, '2017-06-07 19:36:31', 'Mr. Troop Mom', '1919-05-08', 5, 39, 5, 'Children|Comedy', 95, '659611564-X', 'Other contact with parrot', 'Restriction of Aortic Lymphatic with Intraluminal Device, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (196, '2017-09-04 03:00:08', 'Wrestling (Bræðrabylta)', '2010-11-16', 2, 3, 5, 'Drama|Romance', 106, '003931008-6', 'Partial traumatic MCP amputation of thmb, init', 'Drainage of Cervical Plexus, Percutaneous Endoscopic Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (197, '2017-05-09 03:26:00', 'Deadline', '1919-05-31', 3, 49, 9, 'Mystery|Thriller', 174, '765420878-2', 'Oth fx low end unsp ulna, 7thF', 'Alteration of Right Upper Arm with Autologous Tissue Substitute, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (198, '2017-04-13 23:54:08', 'Wheel of Time', '1997-11-25', 3, 4, 1, 'Documentary', 125, '551692579-7', 'Unsp complication of unsp transplanted organ and tissue', 'Division of Head and Neck Subcutaneous Tissue and Fascia, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (199, '2017-09-23 10:19:19', 'Peter Pan', '1970-03-07', 1, 33, 7, 'Action|Adventure|Children|Fantasy', 99, '559644316-6', 'Oth fracture of shaft of r humerus, subs for fx w delay heal', 'Drainage of Right Lobe Liver with Drainage Device, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (200, '2017-12-10 17:39:28', 'History of Future Folk, The', '1948-06-23', 4, 31, 5, 'Adventure|Comedy|Musical|Sci-Fi', 115, '237583091-1', 'Quad preg, unable to dtrm num plcnta & amnio sacs, third tri', 'Dilation of Left Cephalic Vein with Intraluminal Device, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (201, '2017-07-01 06:11:14', 'Striking Range', '1959-06-18', 4, 27, 5, 'Action|Thriller', 187, '479197819-6', 'Disp fx of prox phalanx of unsp fngr, subs for fx w nonunion', 'Insertion of Monitoring Device into Right Pulmonary Artery, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (202, '2017-11-18 17:32:12', 'American Mullet', '1952-06-05', 5, 36, 1, 'Documentary', 186, '652048474-1', 'Causalgia of left upper limb', 'Restriction of Left Lower Lobe Bronchus with Intraluminal Device, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (203, '2017-05-25 12:32:33', 'Den tatuerade änkan (Tattooed Widow, The) ', '1953-10-25', 2, 23, 4, 'Comedy|Drama|Romance', 176, '948847110-7', 'Toxic effect of carb monx from oth source, undet, sequela', 'Supplement Skull with Nonautologous Tissue Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (204, '2017-04-08 02:54:24', 'Heart of a Lion (Leijonasydän)', '2005-02-25', 4, 43, 4, 'Drama|Romance', 148, '248642625-6', 'Maternal care for fetal problem, unsp, third tri, fetus 4', 'Removal of Internal Fixation Device from Left Knee Joint, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (205, '2017-11-22 00:04:33', 'Soldier of Fortune', '2003-06-03', 4, 2, 5, 'Adventure|Crime|Drama|Romance|Thriller', 129, '585177488-6', 'Subluxation of T3/T4 thoracic vertebra', 'Revision of Synthetic Substitute in Right Humeral Shaft, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (206, '2017-10-22 10:19:25', 'The Righteous Thief', '1917-08-04', 5, 11, 8, 'Adventure', 110, '945188775-X', 'Pnctr w foreign body of r rng fngr w damage to nail, sequela', 'Drainage of Right Greater Saphenous Vein, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (207, '2017-07-15 17:08:43', 'Timbuktu', '1992-10-21', 3, 37, 4, 'Drama', 107, '054117136-4', '4-part fx surg neck of l humerus, subs for fx w routn heal', 'Extirpation of Matter from Bilateral Epididymis, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (208, '2017-06-10 08:52:23', 'Rumor of Angels, A', '1987-03-02', 4, 24, 1, 'Drama', 167, '606400116-X', 'Expsr to resdnce or prolonged visit at high altitude, subs', 'Occlusion of Middle Esophagus with Intraluminal Device, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (209, '2017-10-16 01:39:35', 'Newburgh Sting, The', '1983-10-11', 1, 41, 6, 'Documentary', 194, '493167379-1', 'Terrorism w chemical weapons, publ sfty offcl injured', 'Dilation of Right Vertebral Artery, Bifurcation, with Two Intraluminal Devices, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (210, '2017-07-10 20:18:42', 'Rocaterrania', '2010-09-13', 2, 47, 3, 'Documentary|Fantasy', 91, '144277982-9', 'Sprain of unsp cruciate ligament of left knee, sequela', 'Bypass Left Femoral Artery to Popliteal Artery, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (211, '2017-10-07 14:19:46', 'Nathalie...', '1929-02-15', 5, 25, 6, 'Drama', 90, '049568589-5', 'Frostbite with tissue necrosis of right hand, sequela', 'Dilation of Ductus Arteriosus with Intraluminal Device, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (212, '2017-05-02 23:42:26', 'SpaceCamp', '1919-06-06', 4, 12, 4, 'Adventure|Sci-Fi', 150, '617792908-7', 'Dermatochalasis of left lower eyelid', 'Destruction of Left Superior Parathyroid Gland, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (213, '2017-10-27 15:09:03', 'Nas: Time Is Illmatic', '1996-03-07', 3, 14, 3, 'Documentary', 186, '928460136-3', 'Unsp fx r low leg, subs for opn fx type I/2 w delay heal', 'Excision of Mitral Valve, Open Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (214, '2017-10-04 14:31:31', 'Man with an Apartment (Czlowiek z M-3)', '1919-09-21', 4, 17, 4, 'Comedy', 173, '429981941-1', 'Malignant neoplasm of medulla of right adrenal gland', 'Revision of Drainage Device in Left Acromioclavicular Joint, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (215, '2017-10-08 11:33:38', 'Rudderless', '1998-11-30', 4, 48, 8, 'Comedy|Drama', 180, '851172509-1', 'Toxic effect of aflatoxin, undetermined', 'Plain Radiography of Left Lower Extremity Arteries using Other Contrast');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (216, '2017-09-04 12:29:48', 'Man Of The Moment', '1953-03-05', 1, 20, 7, 'Comedy', 93, '826795188-1', 'Pnctr w/o fb of low back and pelv w penet retroperiton, init', 'Resection of Left Trunk Bursa and Ligament, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (217, '2017-11-04 23:30:43', 'Western', '2000-07-18', 5, 17, 7, 'Comedy|Romance', 140, '886881858-2', 'Fracture of oth parts of pelvis, subs for fx w nonunion', 'Transfer Left Abdomen Muscle, Transverse Rectus Abdominis Myocutaneous Flap, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (218, '2017-09-13 23:13:54', 'Clockwise', '1975-05-19', 1, 40, 10, 'Comedy', 153, '649633715-2', 'Inj intrinsic musc/fasc/tend right thumb at wrs/hnd lv', 'Beam Radiation of Bronchus using Photons 1 - 10 MeV');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (219, '2017-12-11 05:03:17', 'She No Longer Talks, She Shoots', '1939-11-10', 2, 8, 2, 'Comedy', 171, '954530123-6', 'Strain of musc/fasc/tend at shldr/up arm, left arm, subs', 'Revision of Intraluminal Device in Uterus and Cervix, Via Natural or Artificial Opening Endoscopic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (220, '2017-11-07 03:06:30', 'Knockaround Guys', '2016-10-01', 4, 16, 7, 'Action|Comedy|Crime', 190, '000916178-3', 'Mech compl of int fix of right humerus, sequela', 'Beam Radiation of Esophagus using Neutron Capture');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (221, '2017-09-11 22:49:00', 'Spontaneous Combustion', '1959-01-24', 4, 23, 4, 'Horror|Sci-Fi|Thriller', 117, '431197685-2', 'Antihyperlipidemic and antiarteriosclerotic drugs', 'Reposition Right Hypogastric Vein, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (222, '2017-07-06 17:51:46', 'Fireman, The', '2008-03-21', 2, 35, 4, 'Comedy', 133, '933556619-5', 'Nondisp fx of olecran pro w/o intartic extn unsp ulna, 7thN', 'Restriction of Abdominal Aorta with Intraluminal Device, Temporary, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (223, '2017-11-09 15:01:33', 'La vérité si je mens !', '1955-08-30', 2, 31, 1, 'Comedy', 129, '529909754-9', 'Adverse effect of other synthetic narcotics, sequela', 'Individual Psychotherapy for Substance Abuse Treatment, Cognitive-Behavioral');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (224, '2017-10-29 21:48:04', 'Carlito''s Way', '1949-09-30', 1, 14, 1, 'Crime|Drama', 153, '306953359-0', 'Unspecified injury of thoracic trachea, subsequent encounter', 'Insertion of Other Device into Left Foot, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (225, '2017-04-03 08:27:23', 'Forgiveness of Blood, The (Falja e gjakut)', '1994-11-08', 3, 49, 7, 'Drama', 152, '254501755-8', 'Unspecified injury of transverse colon, initial encounter', 'Insertion of Infusion Device into Right Renal Vein, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (226, '2017-06-05 12:50:14', 'Four Men and a Prayer', '2013-01-06', 5, 3, 1, 'Adventure|Mystery', 167, '605672046-2', 'Disp fx of lateral epicondyl of l humer, 7thG', 'Restriction of Right Common Iliac Vein with Intraluminal Device, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (227, '2017-06-02 03:22:41', 'Kart Racer', '1932-12-11', 2, 3, 1, 'Drama', 144, '770683813-7', 'Puncture wound with foreign body, unspecified hip, sequela', 'Release Left Upper Leg Tendon, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (228, '2017-10-10 03:35:28', 'Monsters, Inc.', '1992-11-02', 3, 10, 10, 'Adventure|Animation|Children|Comedy|Fantasy', 113, '093428689-2', 'Oth physeal fracture of upper end of radius, left arm, init', 'Removal of Radioactive Element from Vagina and Cul-de-sac, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (229, '2017-07-02 01:42:37', 'William Shakespeare''s Romeo + Juliet', '1991-05-27', 3, 35, 5, 'Drama|Romance', 129, '559367720-4', 'Displaced fracture of cuboid bone of unspecified foot', 'Resection of Bladder Neck, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (230, '2017-12-05 02:53:21', 'All These Women (För att inte tala om alla dessa kvinnor)', '1996-07-16', 2, 23, 10, 'Comedy', 160, '203620364-7', 'Spontaneous rupture of other tendons, multiple sites', 'Reposition Right Thumb Phalanx, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (231, '2017-06-22 08:13:30', 'Code Conspiracy, The', '1974-11-07', 1, 41, 10, 'Action|Mystery|Thriller', 94, '565677142-3', 'Contact with rat', 'Bypass Superior Vena Cava to Right Pulmonary Vein with Autologous Venous Tissue, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (232, '2017-07-14 23:30:48', 'Polish Wedding', '1973-07-20', 2, 3, 8, 'Comedy', 127, '535214079-2', 'Non-prs chronic ulcer oth prt l low leg w necrosis of bone', 'Revision of Synthetic Substitute in Right Metacarpophalangeal Joint, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (233, '2017-11-16 18:14:57', 'Me You Them (Eu, Tu, Eles)', '1920-09-06', 4, 25, 3, 'Comedy|Drama|Romance', 119, '471229552-X', 'Open bite of left ring finger without damage to nail', 'Drainage of Left Subclavian Vein with Drainage Device, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (234, '2017-05-19 23:54:46', 'Return of the Secaucus 7', '1999-08-11', 3, 18, 8, 'Drama', 173, '066460843-4', 'Surgical instrumnt, matrl and radiolog devices assoc w incdt', 'Drainage of Left Vas Deferens with Drainage Device, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (235, '2017-12-12 00:15:39', 'Obsessed', '1992-10-05', 5, 50, 9, 'Crime|Drama|Thriller', 101, '014907580-4', 'Poisoning by anterior pituitary hormones, undetermined', 'Reattachment of Uterine Supporting Structure, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (236, '2017-09-10 11:20:37', 'Night of the Shooting Stars (Notte di San Lorenzo, La)', '1986-07-04', 2, 33, 11, 'Drama|War', 113, '932609057-4', 'Unsp injury of superior mesenteric artery, subs encntr', 'Dilation of Left Ulnar Artery with Two Drug-eluting Intraluminal Devices, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (237, '2017-05-01 09:12:37', 'Trespass', '1971-03-07', 1, 5, 2, 'Crime|Drama|Thriller', 101, '427933170-7', 'Posterior dislocation of left radial head', 'Supplement Face with Synthetic Substitute, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (238, '2017-06-09 08:40:12', 'Pursuit of Happiness, The', '1950-04-18', 1, 24, 3, 'Drama', 150, '825460128-3', 'Inj extensor musc/fasc/tend right ring finger at wrs/hnd lv', 'Removal of Drainage Device from Trunk Subcutaneous Tissue and Fascia, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (239, '2017-05-24 00:29:03', 'Red Dust', '2000-01-26', 2, 14, 2, 'Drama', 173, '301605385-3', 'Ulcerative (chronic) rectosigmoiditis without complications', 'Bypass Superior Vena Cava to Pulmonary Trunk, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (240, '2017-07-21 23:03:51', 'Roman Spring of Mrs. Stone, The', '1967-12-27', 4, 33, 6, 'Drama|Romance', 123, '568301296-1', 'Nondisp fx of r tibial tuberosity, 7thN', 'Division of Right Trunk Tendon, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (241, '2017-11-22 09:04:21', 'My Blue Heaven', '1959-10-02', 4, 37, 7, 'Comedy', 195, '109730696-8', 'Laceration of adductor musc/fasc/tend unsp thigh', 'Bypass Right External Iliac Artery to Right External Iliac Artery with Autologous Arterial Tissue, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (242, '2017-08-12 13:59:54', 'Rosalie Goes Shopping', '1978-01-30', 2, 42, 5, 'Comedy', 151, '143194472-6', 'Displ commnt fx shaft of l tibia, 7thH', 'Bypass Coronary Artery, Two Arteries from Abdominal Artery with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (243, '2017-07-09 18:32:17', 'Quick Change', '1949-11-03', 1, 48, 9, 'Comedy|Crime', 107, '967388563-X', 'Displaced dome fracture of right acetabulum, sequela', 'Dilation of Upper Artery with Three Intraluminal Devices, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (244, '2017-07-31 22:36:50', 'Confessions of a Driving Instructor', '1980-12-11', 2, 36, 7, 'Comedy', 103, '385905490-2', 'Disp fx of anterior column of right acetabulum, sequela', 'Restriction of Left Foot Vein with Intraluminal Device, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (245, '2017-06-16 07:15:51', 'Unforgiven', '1960-02-19', 2, 20, 4, 'Drama|Western', 198, '953153795-X', 'Other hypertrophic osteoarthropathy, left upper arm', 'Reattachment of Right Inferior Parathyroid Gland, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (246, '2017-09-29 02:32:39', 'Blindman', '1975-08-09', 5, 15, 6, 'Western', 131, '285612842-4', 'Encounter for surgical aftcr following surgery on the GU sys', 'Reattachment of Left Lower Leg Skin, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (247, '2017-06-24 12:09:22', 'Ascent of Money, The', '1950-05-14', 2, 43, 9, 'Documentary', 200, '896140618-3', 'Expsr to rdct in atmos pressr wh surfc fr dp-watr div, subs', 'Bypass Left Subclavian Artery to Bilateral Lower Arm Artery with Autologous Arterial Tissue, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (248, '2017-06-19 07:15:22', 'Superman/Shazam!: The Return of Black Adam (DC Showcase Original Shorts Collection)', '1934-01-20', 4, 18, 3, 'Action|Adventure|Animation', 115, '854663910-8', 'Chronic migraine w/o aura, not intractable, w stat migr', 'Supplement Right Axillary Artery with Autologous Tissue Substitute, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (249, '2017-04-16 02:13:00', 'Crimewave', '1964-12-18', 2, 14, 5, 'Comedy|Crime', 117, '565500662-6', 'Laceration without foreign body, right foot, sequela', 'Muscle Performance Treatment of Musculoskeletal System - Upper Back / Upper Extremity');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (250, '2017-05-08 08:18:31', 'Jauja', '1962-05-20', 5, 13, 1, 'Drama|Western', 105, '370157648-3', 'Nondisp fx of lateral condyle of unspecified tibia, sequela', 'Plain Radiography of Right Subclavian Vein using High Osmolar Contrast');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (251, '2017-06-20 22:20:15', 'Hasty Heart, The', '1953-05-11', 3, 13, 2, 'Drama', 175, '053075939-X', 'Puncture wound with foreign body of penis', 'Repair Right Eustachian Tube, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (252, '2017-04-28 14:02:31', 'Bunraku', '1982-10-28', 1, 32, 3, 'Action|Drama|Fantasy', 115, '602596836-5', 'Other complications of anesthesia, sequela', 'Excision of Lower Back, External Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (253, '2017-09-12 19:53:21', 'Star Is Born, A', '2007-02-02', 5, 36, 6, 'Drama', 183, '223932001-X', 'Injury of median nerve at wrs/hnd lv of left arm, sequela', 'Drainage of Left Vertebral Artery, Open Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (254, '2017-08-24 04:44:36', 'Shanghai', '1966-02-22', 2, 33, 9, 'Drama|Mystery|Romance', 115, '712542859-2', 'Poisn by oth nonopio analges/antipyret, NEC, asslt, sequela', 'Revision of Autologous Tissue Substitute in Right Metacarpocarpal Joint, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (255, '2017-04-09 13:49:26', 'Enid Is Sleeping', '1988-11-01', 4, 16, 10, 'Comedy', 150, '765027496-9', 'Drown due to fall/jump fr burning inflatbl crft, init', 'Revision of Synthetic Substitute in Upper Vein, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (256, '2017-07-07 16:09:25', 'Rashomon (Rashômon)', '2007-02-03', 3, 35, 2, 'Crime|Drama|Mystery', 171, '304019043-1', 'Occup of 3-whl mv injured in nonclsn trnsp acc nontraf, subs', 'Supplement Right Inguinal Lymphatic with Synthetic Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (257, '2017-06-04 23:25:07', 'Last Summer', '2001-12-31', 1, 48, 8, 'Drama', 98, '490670136-1', 'Exposure to disaster, war and other hostilities', 'Supplement Left Common Iliac Vein with Synthetic Substitute, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (258, '2017-05-03 18:33:16', 'Diary of a Shinjuku Thief (Shinjuku dorobo nikki)', '1924-10-01', 1, 41, 1, 'Comedy|Drama', 129, '062553503-0', 'Myositis ossificans traumatica, right upper arm', 'Revision of Nonautologous Tissue Substitute in Nose, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (259, '2017-06-17 11:55:35', 'Shadowboxer', '2006-11-23', 1, 37, 5, 'Crime|Drama|Thriller', 97, '390415679-9', 'Chronic myringitis, bilateral', 'Extirpation of Matter from Left Kidney, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (260, '2017-11-16 15:08:25', 'Windows', '1978-06-07', 2, 50, 1, 'Drama', 122, '364770820-8', 'Minor laceration of unsp part of pancreas, subs encntr', 'Inspection of Coccygeal Joint, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (261, '2017-11-27 23:30:14', 'Lemonade Joe (Limonádový Joe aneb Konská opera)', '1938-10-26', 2, 9, 11, 'Adventure|Comedy|Musical|Romance|Western', 97, '563120785-0', 'Retained (nonmagnetic) (old) foreign body in lens, left eye', 'Excision of Right Buttock, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (262, '2017-11-26 05:39:11', 'Olympian Holiday (Loma) ', '1989-03-13', 2, 27, 2, 'Comedy|Romance', 198, '958347703-6', 'Nondisp fx of med epicondyl of unsp humer, 7thG', 'Supplement Left Common Carotid Artery with Autologous Tissue Substitute, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (263, '2017-08-22 15:04:48', 'Mr. Average', '1947-02-09', 5, 23, 10, 'Comedy|Romance', 156, '599362648-8', 'Toxic effect of nitrodrv/aminodrv of benzn/homolog', 'Plain Radiography of Bilateral Tracheobronchial Trees using Other Contrast');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (264, '2017-06-27 17:40:03', 'Elektra Luxx', '1936-06-01', 5, 49, 7, 'Comedy', 113, '925626772-1', 'Other subluxation of unspecified shoulder joint', 'Therapeutic Exercise Treatment of Neurological System - Upper Back / Upper Extremity');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (265, '2017-12-17 22:51:00', 'Getaway, The', '2011-05-01', 3, 23, 8, 'Action|Adventure|Crime|Drama|Romance|Thriller', 183, '860901016-3', 'Nondisp spiral fx shaft of rad, l arm, 7thE', 'Revision of Nonautologous Tissue Substitute in Left Upper Femur, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (266, '2017-07-27 12:51:15', 'Magic Flute, The (Trollflöjten)', '1999-01-05', 3, 13, 5, 'Comedy|Fantasy|Musical|Romance', 199, '074802081-0', 'Pathological dislocation of right hip, NEC', 'Excision of Right Axillary Artery, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (267, '2017-07-18 18:50:56', 'Advanced Style', '1983-06-28', 1, 22, 1, 'Comedy|Documentary|Drama', 181, '433580313-3', 'Malignant neoplasm of unspecified epididymis', 'Replacement of Thoracic Aorta, Ascending/Arch with Autologous Tissue Substitute, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (268, '2017-11-15 14:36:18', 'Living Out Loud', '1930-09-12', 2, 37, 3, 'Comedy|Drama|Romance', 132, '923101610-5', 'Displ seg fx shaft of r fibula, init for opn fx type I/2', 'Bypass Coronary Artery, One Artery from Left Internal Mammary with Zooplastic Tissue, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (269, '2017-09-18 22:14:20', 'Murph: The Protector', '1966-01-18', 3, 35, 9, 'Documentary|War', 103, '608956694-2', 'Toxic effect of ingested berries, self-harm, sequela', 'Inspection of Left Breast, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (270, '2017-08-05 19:47:10', 'Ciao Bella', '1949-06-08', 2, 6, 11, 'Comedy|Drama|Romance', 136, '332027707-3', 'Unsp foreign body in larynx causing asphyxiation, init', 'Supplement Left External Iliac Artery with Autologous Tissue Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (271, '2017-09-20 16:20:18', 'Hollow Crown, The', '1960-07-30', 1, 12, 2, 'Drama', 121, '641729001-8', 'Sltr-haris Type II physl fx upr end r tibia, 7thP', 'Introduction of Electrolytic and Water Balance Substance into Mouth and Pharynx, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (272, '2017-05-17 10:22:45', 'Play It Again, Sam', '1940-06-11', 1, 48, 6, 'Comedy|Romance', 97, '820341824-4', 'Gestational edema, complicating the puerperium', 'Destruction of Penis, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (273, '2017-11-22 22:11:42', 'Dylan Moran: Like, Totally', '1958-12-27', 5, 48, 10, 'Comedy', 186, '641731561-4', 'Primary osteoarthritis, unspecified shoulder', 'Destruction of Scrotum, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (274, '2017-07-20 02:13:34', 'Broken Windows', '1945-07-05', 4, 32, 4, 'Drama', 92, '753669561-6', 'Spontaneous rupture of extensor tendons, unspecified hand', 'Fusion of Right Hip Joint, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (275, '2017-05-19 08:19:34', 'Blossoms in the Dust', '1956-11-16', 4, 9, 8, 'Drama', 191, '216726899-8', 'Unspecified juvenile rheumatoid arthritis, shoulder', 'Insertion of Internal Fixation Device into Left Rib, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (276, '2017-04-17 01:08:10', 'Rover, The', '1930-11-09', 5, 32, 1, 'Crime|Drama', 167, '849116717-X', 'Type 1 diabetes mellitus with periodontal disease', 'Excision of Lingula Bronchus, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (277, '2017-10-13 10:33:00', 'Blood Creek (a.k.a. Town Creek)', '1920-03-06', 5, 10, 3, 'Horror', 114, '631890394-1', 'Kissing spine', 'Occlusion of Anus with Intraluminal Device, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (278, '2017-08-26 20:31:33', 'Big Sur', '1983-07-07', 2, 12, 11, 'Drama', 99, '468398950-6', 'Milt op w thermal radn effect of nuclear weapon, civ, init', 'Revision of Infusion Device in Lower Intestinal Tract, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (279, '2017-06-20 06:01:19', 'Threesome', '1922-08-08', 4, 10, 10, 'Comedy|Romance', 141, '201351715-7', 'Accidental pnctr & lac of a dgstv sys org dur dgstv sys proc', 'Bypass Coronary Artery, One Artery from Abdominal Artery with Autologous Arterial Tissue, Percutaneous Endoscopic Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (280, '2017-10-31 22:36:55', 'First Love (Primo Amore)', '2017-09-04', 1, 7, 2, 'Drama|Romance', 96, '077126028-8', 'Nondisp fx of olecran pro w intartic extn unsp ulna, 7thP', 'Removal of Synthetic Substitute from Penis, Via Natural or Artificial Opening Endoscopic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (281, '2017-12-14 02:54:40', 'Passport to Pimlico', '2009-09-10', 2, 8, 11, 'Comedy', 166, '430646008-8', 'Displacement of int fix of bones of foot and toes, init', 'Muscle Performance Assessment of Integumentary System - Head and Neck using Other Equipment');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (282, '2017-12-14 06:54:20', 'Aces ''N'' Eights', '1927-02-05', 4, 29, 6, 'Action|Adventure|Drama|Romance|Western', 110, '707900857-3', 'Nondisp fx of medial phalanx of oth finger, init for opn fx', 'Division of Right Shoulder Tendon, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (283, '2017-10-04 17:02:29', 'Osmosis Jones', '1963-11-06', 2, 42, 1, 'Action|Animation|Comedy|Crime|Drama|Romance|Thriller', 112, '336331688-7', 'Nondisp oblique fx shaft of l femr, 7thH', 'Vocational Activities and Functional Community or Work Reintegration Skills Assessment using Assistive, Adaptive, Supportive or Protective Equipment');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (284, '2017-04-02 06:50:56', 'Broadway Melody of 1940', '1939-04-05', 2, 7, 10, 'Musical', 101, '027359689-6', 'Displ simple suprcndl fx w/o intrcndl fx r humerus, init', 'Occlusion of Small Intestine with Extraluminal Device, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (285, '2017-06-21 20:34:19', 'Beautiful Creatures', '1967-10-16', 4, 37, 11, 'Comedy|Crime|Drama|Thriller', 186, '437414041-7', 'Sprain of metacarpophalangeal joint of right ring finger', 'Insertion of Internal Fixation Device into Left Hip Joint, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (286, '2017-08-21 20:26:36', 'Dead Snow (Død snø)', '1953-06-12', 1, 14, 7, 'Action|Adventure|Comedy|Horror', 147, '090961204-8', 'Laceration with foreign body of right shoulder, sequela', 'Dilation of Left Temporal Artery with Three Drug-eluting Intraluminal Devices, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (287, '2017-05-15 00:46:22', 'Rite, The', '1949-03-03', 3, 15, 5, 'Drama|Horror|Thriller', 149, '017033812-6', 'Prsnl hx of malig neoplm of lip, oral cavity, and pharynx', 'Resection of Left Extraocular Muscle, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (288, '2017-08-30 10:33:39', 'Howard the Duck', '1930-10-22', 5, 11, 7, 'Adventure|Comedy|Sci-Fi', 151, '566055322-2', 'Undescended testicle, unilateral', 'Release Left Choroid, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (289, '2017-07-08 23:49:47', 'Three Ages', '1969-03-07', 1, 37, 5, 'Comedy', 196, '098128296-2', 'Underdosing of pyrazolone derivatives', 'Drainage of Right Lower Extremity with Drainage Device, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (290, '2017-10-05 18:22:17', 'Slipping-Down Life, A', '1959-07-20', 2, 31, 11, 'Drama|Romance', 185, '708162527-4', 'Lacerat extensor musc/fasc/tend finger at wrs/hnd lv, subs', 'Revision of Drainage Device in Head and Neck Subcutaneous Tissue and Fascia, External Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (291, '2017-04-06 15:33:58', 'City Slickers', '1943-02-21', 4, 15, 2, 'Comedy|Western', 115, '571819165-4', 'Breakdown (mechanical) of muscle and tendon graft, subs', 'Fragmentation in Rectum, Via Natural or Artificial Opening Endoscopic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (292, '2017-05-17 16:24:17', 'Born Romantic', '1971-07-19', 4, 37, 2, 'Comedy|Drama|Romance', 128, '683530792-7', 'Drown due to falling or jumping from burning sailboat', 'Repair Left Ovary, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (293, '2017-09-21 12:56:52', 'Silver Stallion (Silver Brumpy, The)', '1989-01-26', 3, 2, 3, 'Drama', 127, '605071696-X', 'Pedl cyclst (driver) injured in oth transport acc, sequela', 'Supplement Tibial Nerve with Autologous Tissue Substitute, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (294, '2017-06-24 03:55:27', 'Ciao Bella', '1967-03-29', 2, 12, 11, 'Comedy|Drama|Romance', 93, '723699418-9', 'Oth incmpl lesion at unsp level of cerv spinal cord, sequela', 'Extirpation of Matter from Stomach, Via Natural or Artificial Opening Endoscopic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (295, '2017-11-30 05:54:54', 'Act of Valor', '1965-05-24', 4, 25, 5, 'Action|Thriller|War', 98, '549942448-9', 'Sltr-haris Type II physeal fx lower end of r tibia, sequela', 'Release Left Auditory Ossicle, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (296, '2017-07-03 11:36:30', 'Come Dance with Me!', '1981-03-19', 2, 4, 7, 'Crime|Drama|Mystery', 186, '734592336-3', 'Poisoning by iminostilbenes, intentional self-harm, sequela', 'Drainage of Optic Nerve, Open Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (297, '2017-05-31 22:12:25', 'Place at the Table, A', '2012-07-10', 1, 44, 9, 'Documentary', 155, '928566188-2', 'Poisoning by oth antihypertn drugs, accidental, init', 'Excision of Skull, Percutaneous Approach, Diagnostic');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (298, '2017-07-10 12:32:38', 'Secret Honor', '1993-10-02', 5, 29, 8, 'Drama', 200, '785206769-7', 'Primary biliary cirrhosis', 'Extirpation of Matter from Left Parietal Bone, Percutaneous Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (299, '2017-12-17 01:39:38', 'Citizen Cohn', '1981-04-05', 4, 6, 10, 'Drama', 173, '146115051-5', 'Injury of ulnar nerve at wrist and hand level of left arm', 'Bypass Right External Iliac Artery to Left Femoral Artery with Autologous Venous Tissue, Open Approach');
insert into movies (intID, dteCreated, strName, strYear, intPriceCategoryID, intDirectorID, intGenreID, strGenre, strLength, strISBN, strDescription, strText) values (300, '2017-08-31 18:41:58', 'All Night Long', '2008-01-12', 1, 18, 11, 'Comedy|Drama', 186, '193413326-4', 'Oth foreign object in oth prt resp tract cause asphyx, init', 'Resection of Right Upper Eyelid, Open Approach');


-- 9. actors in each movie (1.000)

insert into movieActor (intMovieID, intActorID) values (25, 178);
insert into movieActor (intMovieID, intActorID) values (236, 199);
insert into movieActor (intMovieID, intActorID) values (187, 34);
insert into movieActor (intMovieID, intActorID) values (76, 201);
insert into movieActor (intMovieID, intActorID) values (286, 150);
insert into movieActor (intMovieID, intActorID) values (125, 288);
insert into movieActor (intMovieID, intActorID) values (179, 25);
insert into movieActor (intMovieID, intActorID) values (207, 111);
insert into movieActor (intMovieID, intActorID) values (161, 291);
insert into movieActor (intMovieID, intActorID) values (11, 83);
insert into movieActor (intMovieID, intActorID) values (285, 149);
insert into movieActor (intMovieID, intActorID) values (263, 76);
insert into movieActor (intMovieID, intActorID) values (159, 202);
insert into movieActor (intMovieID, intActorID) values (291, 130);
insert into movieActor (intMovieID, intActorID) values (232, 73);
insert into movieActor (intMovieID, intActorID) values (287, 12);
insert into movieActor (intMovieID, intActorID) values (229, 241);
insert into movieActor (intMovieID, intActorID) values (13, 142);
insert into movieActor (intMovieID, intActorID) values (154, 270);
insert into movieActor (intMovieID, intActorID) values (144, 24);
insert into movieActor (intMovieID, intActorID) values (55, 88);
insert into movieActor (intMovieID, intActorID) values (188, 220);
insert into movieActor (intMovieID, intActorID) values (141, 167);
insert into movieActor (intMovieID, intActorID) values (60, 162);
insert into movieActor (intMovieID, intActorID) values (285, 54);
insert into movieActor (intMovieID, intActorID) values (34, 285);
insert into movieActor (intMovieID, intActorID) values (142, 90);
insert into movieActor (intMovieID, intActorID) values (218, 89);
insert into movieActor (intMovieID, intActorID) values (63, 259);
insert into movieActor (intMovieID, intActorID) values (1, 148);
insert into movieActor (intMovieID, intActorID) values (58, 157);
insert into movieActor (intMovieID, intActorID) values (10, 148);
insert into movieActor (intMovieID, intActorID) values (257, 66);
insert into movieActor (intMovieID, intActorID) values (41, 257);
insert into movieActor (intMovieID, intActorID) values (139, 228);
insert into movieActor (intMovieID, intActorID) values (187, 37);
insert into movieActor (intMovieID, intActorID) values (202, 110);
insert into movieActor (intMovieID, intActorID) values (104, 65);
insert into movieActor (intMovieID, intActorID) values (158, 188);
insert into movieActor (intMovieID, intActorID) values (129, 30);
insert into movieActor (intMovieID, intActorID) values (178, 140);
insert into movieActor (intMovieID, intActorID) values (188, 41);
insert into movieActor (intMovieID, intActorID) values (278, 185);
insert into movieActor (intMovieID, intActorID) values (227, 195);
insert into movieActor (intMovieID, intActorID) values (6, 88);
insert into movieActor (intMovieID, intActorID) values (212, 141);
insert into movieActor (intMovieID, intActorID) values (120, 55);
insert into movieActor (intMovieID, intActorID) values (241, 186);
insert into movieActor (intMovieID, intActorID) values (117, 223);
insert into movieActor (intMovieID, intActorID) values (79, 123);
insert into movieActor (intMovieID, intActorID) values (97, 191);
insert into movieActor (intMovieID, intActorID) values (247, 217);
insert into movieActor (intMovieID, intActorID) values (43, 110);
insert into movieActor (intMovieID, intActorID) values (21, 279);
insert into movieActor (intMovieID, intActorID) values (120, 276);
insert into movieActor (intMovieID, intActorID) values (53, 147);
insert into movieActor (intMovieID, intActorID) values (173, 78);
insert into movieActor (intMovieID, intActorID) values (232, 53);
insert into movieActor (intMovieID, intActorID) values (27, 248);
insert into movieActor (intMovieID, intActorID) values (227, 149);
insert into movieActor (intMovieID, intActorID) values (130, 277);
insert into movieActor (intMovieID, intActorID) values (159, 150);
insert into movieActor (intMovieID, intActorID) values (278, 96);
insert into movieActor (intMovieID, intActorID) values (211, 127);
insert into movieActor (intMovieID, intActorID) values (284, 19);
insert into movieActor (intMovieID, intActorID) values (16, 192);
insert into movieActor (intMovieID, intActorID) values (18, 279);
insert into movieActor (intMovieID, intActorID) values (63, 15);
insert into movieActor (intMovieID, intActorID) values (120, 177);
insert into movieActor (intMovieID, intActorID) values (241, 100);
insert into movieActor (intMovieID, intActorID) values (89, 194);
insert into movieActor (intMovieID, intActorID) values (127, 91);
insert into movieActor (intMovieID, intActorID) values (41, 202);
insert into movieActor (intMovieID, intActorID) values (61, 236);
insert into movieActor (intMovieID, intActorID) values (136, 199);
insert into movieActor (intMovieID, intActorID) values (164, 271);
insert into movieActor (intMovieID, intActorID) values (289, 278);
insert into movieActor (intMovieID, intActorID) values (233, 75);
insert into movieActor (intMovieID, intActorID) values (124, 147);
insert into movieActor (intMovieID, intActorID) values (5, 30);
insert into movieActor (intMovieID, intActorID) values (142, 189);
insert into movieActor (intMovieID, intActorID) values (42, 130);
insert into movieActor (intMovieID, intActorID) values (110, 45);
insert into movieActor (intMovieID, intActorID) values (115, 233);
insert into movieActor (intMovieID, intActorID) values (298, 125);
insert into movieActor (intMovieID, intActorID) values (135, 205);
insert into movieActor (intMovieID, intActorID) values (233, 19);
insert into movieActor (intMovieID, intActorID) values (51, 207);
insert into movieActor (intMovieID, intActorID) values (248, 135);
insert into movieActor (intMovieID, intActorID) values (253, 135);
insert into movieActor (intMovieID, intActorID) values (226, 93);
insert into movieActor (intMovieID, intActorID) values (10, 120);
insert into movieActor (intMovieID, intActorID) values (115, 115);
insert into movieActor (intMovieID, intActorID) values (28, 298);
insert into movieActor (intMovieID, intActorID) values (186, 258);
insert into movieActor (intMovieID, intActorID) values (151, 72);
insert into movieActor (intMovieID, intActorID) values (184, 203);
insert into movieActor (intMovieID, intActorID) values (78, 279);
insert into movieActor (intMovieID, intActorID) values (238, 124);
insert into movieActor (intMovieID, intActorID) values (56, 243);
insert into movieActor (intMovieID, intActorID) values (293, 271);
insert into movieActor (intMovieID, intActorID) values (177, 47);
insert into movieActor (intMovieID, intActorID) values (59, 214);
insert into movieActor (intMovieID, intActorID) values (123, 199);
insert into movieActor (intMovieID, intActorID) values (217, 230);
insert into movieActor (intMovieID, intActorID) values (282, 26);
insert into movieActor (intMovieID, intActorID) values (77, 241);
insert into movieActor (intMovieID, intActorID) values (30, 219);
insert into movieActor (intMovieID, intActorID) values (251, 287);
insert into movieActor (intMovieID, intActorID) values (138, 159);
insert into movieActor (intMovieID, intActorID) values (48, 92);
insert into movieActor (intMovieID, intActorID) values (99, 273);
insert into movieActor (intMovieID, intActorID) values (59, 172);
insert into movieActor (intMovieID, intActorID) values (282, 26);
insert into movieActor (intMovieID, intActorID) values (136, 66);
insert into movieActor (intMovieID, intActorID) values (28, 248);
insert into movieActor (intMovieID, intActorID) values (95, 29);
insert into movieActor (intMovieID, intActorID) values (12, 64);
insert into movieActor (intMovieID, intActorID) values (81, 17);
insert into movieActor (intMovieID, intActorID) values (228, 225);
insert into movieActor (intMovieID, intActorID) values (98, 279);
insert into movieActor (intMovieID, intActorID) values (223, 107);
insert into movieActor (intMovieID, intActorID) values (60, 59);
insert into movieActor (intMovieID, intActorID) values (173, 166);
insert into movieActor (intMovieID, intActorID) values (222, 52);
insert into movieActor (intMovieID, intActorID) values (142, 172);
insert into movieActor (intMovieID, intActorID) values (134, 15);
insert into movieActor (intMovieID, intActorID) values (140, 256);
insert into movieActor (intMovieID, intActorID) values (290, 23);
insert into movieActor (intMovieID, intActorID) values (225, 232);
insert into movieActor (intMovieID, intActorID) values (101, 152);
insert into movieActor (intMovieID, intActorID) values (293, 290);
insert into movieActor (intMovieID, intActorID) values (62, 34);
insert into movieActor (intMovieID, intActorID) values (242, 196);
insert into movieActor (intMovieID, intActorID) values (82, 50);
insert into movieActor (intMovieID, intActorID) values (256, 147);
insert into movieActor (intMovieID, intActorID) values (222, 123);
insert into movieActor (intMovieID, intActorID) values (81, 197);
insert into movieActor (intMovieID, intActorID) values (89, 183);
insert into movieActor (intMovieID, intActorID) values (273, 20);
insert into movieActor (intMovieID, intActorID) values (265, 115);
insert into movieActor (intMovieID, intActorID) values (45, 184);
insert into movieActor (intMovieID, intActorID) values (115, 15);
insert into movieActor (intMovieID, intActorID) values (253, 226);
insert into movieActor (intMovieID, intActorID) values (37, 185);
insert into movieActor (intMovieID, intActorID) values (283, 195);
insert into movieActor (intMovieID, intActorID) values (174, 170);
insert into movieActor (intMovieID, intActorID) values (103, 149);
insert into movieActor (intMovieID, intActorID) values (158, 185);
insert into movieActor (intMovieID, intActorID) values (235, 36);
insert into movieActor (intMovieID, intActorID) values (233, 132);
insert into movieActor (intMovieID, intActorID) values (62, 133);
insert into movieActor (intMovieID, intActorID) values (170, 40);
insert into movieActor (intMovieID, intActorID) values (177, 172);
insert into movieActor (intMovieID, intActorID) values (215, 152);
insert into movieActor (intMovieID, intActorID) values (105, 2);
insert into movieActor (intMovieID, intActorID) values (56, 199);
insert into movieActor (intMovieID, intActorID) values (265, 249);
insert into movieActor (intMovieID, intActorID) values (51, 69);
insert into movieActor (intMovieID, intActorID) values (151, 33);
insert into movieActor (intMovieID, intActorID) values (113, 269);
insert into movieActor (intMovieID, intActorID) values (128, 101);
insert into movieActor (intMovieID, intActorID) values (200, 176);
insert into movieActor (intMovieID, intActorID) values (170, 188);
insert into movieActor (intMovieID, intActorID) values (136, 86);
insert into movieActor (intMovieID, intActorID) values (298, 12);
insert into movieActor (intMovieID, intActorID) values (94, 5);
insert into movieActor (intMovieID, intActorID) values (12, 19);
insert into movieActor (intMovieID, intActorID) values (36, 284);
insert into movieActor (intMovieID, intActorID) values (186, 146);
insert into movieActor (intMovieID, intActorID) values (73, 203);
insert into movieActor (intMovieID, intActorID) values (135, 109);
insert into movieActor (intMovieID, intActorID) values (218, 158);
insert into movieActor (intMovieID, intActorID) values (164, 244);
insert into movieActor (intMovieID, intActorID) values (218, 52);
insert into movieActor (intMovieID, intActorID) values (240, 102);
insert into movieActor (intMovieID, intActorID) values (83, 33);
insert into movieActor (intMovieID, intActorID) values (104, 205);
insert into movieActor (intMovieID, intActorID) values (3, 154);
insert into movieActor (intMovieID, intActorID) values (173, 29);
insert into movieActor (intMovieID, intActorID) values (284, 252);
insert into movieActor (intMovieID, intActorID) values (11, 179);
insert into movieActor (intMovieID, intActorID) values (206, 67);
insert into movieActor (intMovieID, intActorID) values (216, 156);
insert into movieActor (intMovieID, intActorID) values (98, 18);
insert into movieActor (intMovieID, intActorID) values (11, 265);
insert into movieActor (intMovieID, intActorID) values (150, 157);
insert into movieActor (intMovieID, intActorID) values (2, 181);
insert into movieActor (intMovieID, intActorID) values (158, 19);
insert into movieActor (intMovieID, intActorID) values (133, 8);
insert into movieActor (intMovieID, intActorID) values (20, 90);
insert into movieActor (intMovieID, intActorID) values (118, 240);
insert into movieActor (intMovieID, intActorID) values (209, 21);
insert into movieActor (intMovieID, intActorID) values (239, 154);
insert into movieActor (intMovieID, intActorID) values (279, 55);
insert into movieActor (intMovieID, intActorID) values (60, 252);
insert into movieActor (intMovieID, intActorID) values (100, 159);
insert into movieActor (intMovieID, intActorID) values (91, 10);
insert into movieActor (intMovieID, intActorID) values (225, 211);
insert into movieActor (intMovieID, intActorID) values (121, 138);
insert into movieActor (intMovieID, intActorID) values (1, 190);
insert into movieActor (intMovieID, intActorID) values (123, 300);
insert into movieActor (intMovieID, intActorID) values (106, 26);
insert into movieActor (intMovieID, intActorID) values (100, 83);
insert into movieActor (intMovieID, intActorID) values (27, 251);
insert into movieActor (intMovieID, intActorID) values (221, 76);
insert into movieActor (intMovieID, intActorID) values (194, 61);
insert into movieActor (intMovieID, intActorID) values (80, 46);
insert into movieActor (intMovieID, intActorID) values (110, 246);
insert into movieActor (intMovieID, intActorID) values (241, 294);
insert into movieActor (intMovieID, intActorID) values (296, 179);
insert into movieActor (intMovieID, intActorID) values (268, 82);
insert into movieActor (intMovieID, intActorID) values (230, 186);
insert into movieActor (intMovieID, intActorID) values (284, 242);
insert into movieActor (intMovieID, intActorID) values (166, 163);
insert into movieActor (intMovieID, intActorID) values (188, 73);
insert into movieActor (intMovieID, intActorID) values (29, 182);
insert into movieActor (intMovieID, intActorID) values (76, 235);
insert into movieActor (intMovieID, intActorID) values (191, 197);
insert into movieActor (intMovieID, intActorID) values (25, 166);
insert into movieActor (intMovieID, intActorID) values (85, 122);
insert into movieActor (intMovieID, intActorID) values (206, 34);
insert into movieActor (intMovieID, intActorID) values (185, 199);
insert into movieActor (intMovieID, intActorID) values (168, 227);
insert into movieActor (intMovieID, intActorID) values (213, 72);
insert into movieActor (intMovieID, intActorID) values (102, 120);
insert into movieActor (intMovieID, intActorID) values (74, 282);
insert into movieActor (intMovieID, intActorID) values (225, 13);
insert into movieActor (intMovieID, intActorID) values (262, 271);
insert into movieActor (intMovieID, intActorID) values (291, 82);
insert into movieActor (intMovieID, intActorID) values (26, 232);
insert into movieActor (intMovieID, intActorID) values (92, 158);
insert into movieActor (intMovieID, intActorID) values (126, 218);
insert into movieActor (intMovieID, intActorID) values (177, 106);
insert into movieActor (intMovieID, intActorID) values (179, 117);
insert into movieActor (intMovieID, intActorID) values (211, 51);
insert into movieActor (intMovieID, intActorID) values (26, 97);
insert into movieActor (intMovieID, intActorID) values (288, 278);
insert into movieActor (intMovieID, intActorID) values (53, 79);
insert into movieActor (intMovieID, intActorID) values (10, 50);
insert into movieActor (intMovieID, intActorID) values (267, 177);
insert into movieActor (intMovieID, intActorID) values (300, 183);
insert into movieActor (intMovieID, intActorID) values (95, 178);
insert into movieActor (intMovieID, intActorID) values (175, 258);
insert into movieActor (intMovieID, intActorID) values (198, 63);
insert into movieActor (intMovieID, intActorID) values (74, 157);
insert into movieActor (intMovieID, intActorID) values (194, 91);
insert into movieActor (intMovieID, intActorID) values (223, 94);
insert into movieActor (intMovieID, intActorID) values (118, 227);
insert into movieActor (intMovieID, intActorID) values (262, 263);
insert into movieActor (intMovieID, intActorID) values (14, 176);
insert into movieActor (intMovieID, intActorID) values (295, 111);
insert into movieActor (intMovieID, intActorID) values (282, 299);
insert into movieActor (intMovieID, intActorID) values (216, 75);
insert into movieActor (intMovieID, intActorID) values (260, 71);
insert into movieActor (intMovieID, intActorID) values (35, 94);
insert into movieActor (intMovieID, intActorID) values (104, 42);
insert into movieActor (intMovieID, intActorID) values (34, 17);
insert into movieActor (intMovieID, intActorID) values (140, 85);
insert into movieActor (intMovieID, intActorID) values (93, 82);
insert into movieActor (intMovieID, intActorID) values (237, 176);
insert into movieActor (intMovieID, intActorID) values (80, 289);
insert into movieActor (intMovieID, intActorID) values (212, 70);
insert into movieActor (intMovieID, intActorID) values (8, 228);
insert into movieActor (intMovieID, intActorID) values (229, 233);
insert into movieActor (intMovieID, intActorID) values (293, 143);
insert into movieActor (intMovieID, intActorID) values (114, 119);
insert into movieActor (intMovieID, intActorID) values (75, 77);
insert into movieActor (intMovieID, intActorID) values (97, 176);
insert into movieActor (intMovieID, intActorID) values (12, 110);
insert into movieActor (intMovieID, intActorID) values (234, 172);
insert into movieActor (intMovieID, intActorID) values (4, 286);
insert into movieActor (intMovieID, intActorID) values (21, 193);
insert into movieActor (intMovieID, intActorID) values (14, 21);
insert into movieActor (intMovieID, intActorID) values (72, 186);
insert into movieActor (intMovieID, intActorID) values (294, 212);
insert into movieActor (intMovieID, intActorID) values (133, 49);
insert into movieActor (intMovieID, intActorID) values (86, 146);
insert into movieActor (intMovieID, intActorID) values (50, 40);
insert into movieActor (intMovieID, intActorID) values (57, 289);
insert into movieActor (intMovieID, intActorID) values (136, 211);
insert into movieActor (intMovieID, intActorID) values (182, 232);
insert into movieActor (intMovieID, intActorID) values (181, 149);
insert into movieActor (intMovieID, intActorID) values (238, 77);
insert into movieActor (intMovieID, intActorID) values (125, 211);
insert into movieActor (intMovieID, intActorID) values (46, 295);
insert into movieActor (intMovieID, intActorID) values (135, 109);
insert into movieActor (intMovieID, intActorID) values (90, 165);
insert into movieActor (intMovieID, intActorID) values (235, 52);
insert into movieActor (intMovieID, intActorID) values (156, 38);
insert into movieActor (intMovieID, intActorID) values (163, 62);
insert into movieActor (intMovieID, intActorID) values (208, 150);
insert into movieActor (intMovieID, intActorID) values (128, 240);
insert into movieActor (intMovieID, intActorID) values (257, 200);
insert into movieActor (intMovieID, intActorID) values (181, 115);
insert into movieActor (intMovieID, intActorID) values (119, 277);
insert into movieActor (intMovieID, intActorID) values (261, 6);
insert into movieActor (intMovieID, intActorID) values (42, 210);
insert into movieActor (intMovieID, intActorID) values (164, 237);
insert into movieActor (intMovieID, intActorID) values (178, 283);
insert into movieActor (intMovieID, intActorID) values (99, 226);
insert into movieActor (intMovieID, intActorID) values (60, 17);
insert into movieActor (intMovieID, intActorID) values (184, 141);
insert into movieActor (intMovieID, intActorID) values (207, 167);
insert into movieActor (intMovieID, intActorID) values (178, 290);
insert into movieActor (intMovieID, intActorID) values (165, 203);
insert into movieActor (intMovieID, intActorID) values (101, 235);
insert into movieActor (intMovieID, intActorID) values (200, 79);
insert into movieActor (intMovieID, intActorID) values (146, 18);
insert into movieActor (intMovieID, intActorID) values (215, 116);
insert into movieActor (intMovieID, intActorID) values (110, 161);
insert into movieActor (intMovieID, intActorID) values (89, 94);
insert into movieActor (intMovieID, intActorID) values (102, 239);
insert into movieActor (intMovieID, intActorID) values (12, 221);
insert into movieActor (intMovieID, intActorID) values (159, 62);
insert into movieActor (intMovieID, intActorID) values (174, 154);
insert into movieActor (intMovieID, intActorID) values (263, 87);
insert into movieActor (intMovieID, intActorID) values (103, 76);
insert into movieActor (intMovieID, intActorID) values (159, 27);
insert into movieActor (intMovieID, intActorID) values (34, 77);
insert into movieActor (intMovieID, intActorID) values (296, 9);
insert into movieActor (intMovieID, intActorID) values (31, 117);
insert into movieActor (intMovieID, intActorID) values (217, 103);
insert into movieActor (intMovieID, intActorID) values (205, 17);
insert into movieActor (intMovieID, intActorID) values (251, 175);
insert into movieActor (intMovieID, intActorID) values (5, 282);
insert into movieActor (intMovieID, intActorID) values (243, 284);
insert into movieActor (intMovieID, intActorID) values (68, 46);
insert into movieActor (intMovieID, intActorID) values (7, 18);
insert into movieActor (intMovieID, intActorID) values (274, 223);
insert into movieActor (intMovieID, intActorID) values (194, 127);
insert into movieActor (intMovieID, intActorID) values (30, 174);
insert into movieActor (intMovieID, intActorID) values (93, 37);
insert into movieActor (intMovieID, intActorID) values (233, 98);
insert into movieActor (intMovieID, intActorID) values (169, 86);
insert into movieActor (intMovieID, intActorID) values (12, 92);
insert into movieActor (intMovieID, intActorID) values (58, 172);
insert into movieActor (intMovieID, intActorID) values (284, 245);
insert into movieActor (intMovieID, intActorID) values (29, 253);
insert into movieActor (intMovieID, intActorID) values (189, 235);
insert into movieActor (intMovieID, intActorID) values (53, 164);
insert into movieActor (intMovieID, intActorID) values (129, 140);
insert into movieActor (intMovieID, intActorID) values (227, 44);
insert into movieActor (intMovieID, intActorID) values (33, 138);
insert into movieActor (intMovieID, intActorID) values (30, 103);
insert into movieActor (intMovieID, intActorID) values (213, 166);
insert into movieActor (intMovieID, intActorID) values (116, 125);
insert into movieActor (intMovieID, intActorID) values (77, 3);
insert into movieActor (intMovieID, intActorID) values (214, 92);
insert into movieActor (intMovieID, intActorID) values (255, 186);
insert into movieActor (intMovieID, intActorID) values (274, 233);
insert into movieActor (intMovieID, intActorID) values (272, 53);
insert into movieActor (intMovieID, intActorID) values (148, 147);
insert into movieActor (intMovieID, intActorID) values (217, 47);
insert into movieActor (intMovieID, intActorID) values (92, 72);
insert into movieActor (intMovieID, intActorID) values (10, 293);
insert into movieActor (intMovieID, intActorID) values (91, 177);
insert into movieActor (intMovieID, intActorID) values (245, 21);
insert into movieActor (intMovieID, intActorID) values (27, 31);
insert into movieActor (intMovieID, intActorID) values (17, 189);
insert into movieActor (intMovieID, intActorID) values (117, 190);
insert into movieActor (intMovieID, intActorID) values (63, 29);
insert into movieActor (intMovieID, intActorID) values (117, 258);
insert into movieActor (intMovieID, intActorID) values (266, 276);
insert into movieActor (intMovieID, intActorID) values (87, 300);
insert into movieActor (intMovieID, intActorID) values (152, 67);
insert into movieActor (intMovieID, intActorID) values (162, 4);
insert into movieActor (intMovieID, intActorID) values (159, 250);
insert into movieActor (intMovieID, intActorID) values (53, 252);
insert into movieActor (intMovieID, intActorID) values (67, 239);
insert into movieActor (intMovieID, intActorID) values (50, 91);
insert into movieActor (intMovieID, intActorID) values (98, 195);
insert into movieActor (intMovieID, intActorID) values (176, 215);
insert into movieActor (intMovieID, intActorID) values (45, 20);
insert into movieActor (intMovieID, intActorID) values (228, 12);
insert into movieActor (intMovieID, intActorID) values (142, 239);
insert into movieActor (intMovieID, intActorID) values (160, 152);
insert into movieActor (intMovieID, intActorID) values (226, 294);
insert into movieActor (intMovieID, intActorID) values (237, 38);
insert into movieActor (intMovieID, intActorID) values (41, 126);
insert into movieActor (intMovieID, intActorID) values (19, 1);
insert into movieActor (intMovieID, intActorID) values (205, 278);
insert into movieActor (intMovieID, intActorID) values (33, 258);
insert into movieActor (intMovieID, intActorID) values (117, 204);
insert into movieActor (intMovieID, intActorID) values (151, 103);
insert into movieActor (intMovieID, intActorID) values (11, 258);
insert into movieActor (intMovieID, intActorID) values (252, 126);
insert into movieActor (intMovieID, intActorID) values (99, 272);
insert into movieActor (intMovieID, intActorID) values (35, 85);
insert into movieActor (intMovieID, intActorID) values (156, 179);
insert into movieActor (intMovieID, intActorID) values (143, 184);
insert into movieActor (intMovieID, intActorID) values (287, 21);
insert into movieActor (intMovieID, intActorID) values (67, 231);
insert into movieActor (intMovieID, intActorID) values (12, 160);
insert into movieActor (intMovieID, intActorID) values (145, 184);
insert into movieActor (intMovieID, intActorID) values (115, 232);
insert into movieActor (intMovieID, intActorID) values (166, 195);
insert into movieActor (intMovieID, intActorID) values (287, 112);
insert into movieActor (intMovieID, intActorID) values (111, 188);
insert into movieActor (intMovieID, intActorID) values (244, 50);
insert into movieActor (intMovieID, intActorID) values (174, 40);
insert into movieActor (intMovieID, intActorID) values (77, 264);
insert into movieActor (intMovieID, intActorID) values (147, 292);
insert into movieActor (intMovieID, intActorID) values (9, 246);
insert into movieActor (intMovieID, intActorID) values (228, 152);
insert into movieActor (intMovieID, intActorID) values (252, 149);
insert into movieActor (intMovieID, intActorID) values (120, 164);
insert into movieActor (intMovieID, intActorID) values (6, 129);
insert into movieActor (intMovieID, intActorID) values (41, 82);
insert into movieActor (intMovieID, intActorID) values (265, 173);
insert into movieActor (intMovieID, intActorID) values (23, 282);
insert into movieActor (intMovieID, intActorID) values (288, 22);
insert into movieActor (intMovieID, intActorID) values (146, 71);
insert into movieActor (intMovieID, intActorID) values (27, 131);
insert into movieActor (intMovieID, intActorID) values (258, 202);
insert into movieActor (intMovieID, intActorID) values (77, 93);
insert into movieActor (intMovieID, intActorID) values (18, 41);
insert into movieActor (intMovieID, intActorID) values (268, 274);
insert into movieActor (intMovieID, intActorID) values (167, 31);
insert into movieActor (intMovieID, intActorID) values (166, 6);
insert into movieActor (intMovieID, intActorID) values (77, 259);
insert into movieActor (intMovieID, intActorID) values (159, 135);
insert into movieActor (intMovieID, intActorID) values (62, 180);
insert into movieActor (intMovieID, intActorID) values (103, 247);
insert into movieActor (intMovieID, intActorID) values (103, 110);
insert into movieActor (intMovieID, intActorID) values (285, 275);
insert into movieActor (intMovieID, intActorID) values (290, 131);
insert into movieActor (intMovieID, intActorID) values (177, 82);
insert into movieActor (intMovieID, intActorID) values (27, 247);
insert into movieActor (intMovieID, intActorID) values (209, 238);
insert into movieActor (intMovieID, intActorID) values (87, 287);
insert into movieActor (intMovieID, intActorID) values (221, 284);
insert into movieActor (intMovieID, intActorID) values (58, 215);
insert into movieActor (intMovieID, intActorID) values (144, 21);
insert into movieActor (intMovieID, intActorID) values (212, 296);
insert into movieActor (intMovieID, intActorID) values (75, 130);
insert into movieActor (intMovieID, intActorID) values (42, 288);
insert into movieActor (intMovieID, intActorID) values (109, 163);
insert into movieActor (intMovieID, intActorID) values (131, 239);
insert into movieActor (intMovieID, intActorID) values (244, 283);
insert into movieActor (intMovieID, intActorID) values (75, 113);
insert into movieActor (intMovieID, intActorID) values (34, 243);
insert into movieActor (intMovieID, intActorID) values (176, 240);
insert into movieActor (intMovieID, intActorID) values (135, 60);
insert into movieActor (intMovieID, intActorID) values (108, 261);
insert into movieActor (intMovieID, intActorID) values (72, 190);
insert into movieActor (intMovieID, intActorID) values (259, 93);
insert into movieActor (intMovieID, intActorID) values (91, 123);
insert into movieActor (intMovieID, intActorID) values (21, 98);
insert into movieActor (intMovieID, intActorID) values (224, 222);
insert into movieActor (intMovieID, intActorID) values (55, 122);
insert into movieActor (intMovieID, intActorID) values (102, 13);
insert into movieActor (intMovieID, intActorID) values (160, 279);
insert into movieActor (intMovieID, intActorID) values (141, 243);
insert into movieActor (intMovieID, intActorID) values (8, 206);
insert into movieActor (intMovieID, intActorID) values (35, 72);
insert into movieActor (intMovieID, intActorID) values (226, 43);
insert into movieActor (intMovieID, intActorID) values (298, 247);
insert into movieActor (intMovieID, intActorID) values (20, 70);
insert into movieActor (intMovieID, intActorID) values (148, 277);
insert into movieActor (intMovieID, intActorID) values (270, 203);
insert into movieActor (intMovieID, intActorID) values (123, 236);
insert into movieActor (intMovieID, intActorID) values (185, 248);
insert into movieActor (intMovieID, intActorID) values (136, 134);
insert into movieActor (intMovieID, intActorID) values (32, 13);
insert into movieActor (intMovieID, intActorID) values (171, 139);
insert into movieActor (intMovieID, intActorID) values (116, 116);
insert into movieActor (intMovieID, intActorID) values (48, 221);
insert into movieActor (intMovieID, intActorID) values (257, 218);
insert into movieActor (intMovieID, intActorID) values (247, 216);
insert into movieActor (intMovieID, intActorID) values (72, 239);
insert into movieActor (intMovieID, intActorID) values (126, 254);
insert into movieActor (intMovieID, intActorID) values (262, 154);
insert into movieActor (intMovieID, intActorID) values (172, 138);
insert into movieActor (intMovieID, intActorID) values (128, 113);
insert into movieActor (intMovieID, intActorID) values (149, 129);
insert into movieActor (intMovieID, intActorID) values (249, 263);
insert into movieActor (intMovieID, intActorID) values (75, 54);
insert into movieActor (intMovieID, intActorID) values (55, 193);
insert into movieActor (intMovieID, intActorID) values (117, 165);
insert into movieActor (intMovieID, intActorID) values (232, 32);
insert into movieActor (intMovieID, intActorID) values (144, 259);
insert into movieActor (intMovieID, intActorID) values (270, 262);
insert into movieActor (intMovieID, intActorID) values (293, 79);
insert into movieActor (intMovieID, intActorID) values (9, 64);
insert into movieActor (intMovieID, intActorID) values (167, 243);
insert into movieActor (intMovieID, intActorID) values (207, 90);
insert into movieActor (intMovieID, intActorID) values (138, 251);
insert into movieActor (intMovieID, intActorID) values (250, 235);
insert into movieActor (intMovieID, intActorID) values (126, 9);
insert into movieActor (intMovieID, intActorID) values (248, 26);
insert into movieActor (intMovieID, intActorID) values (1, 207);
insert into movieActor (intMovieID, intActorID) values (152, 159);
insert into movieActor (intMovieID, intActorID) values (44, 291);
insert into movieActor (intMovieID, intActorID) values (299, 159);
insert into movieActor (intMovieID, intActorID) values (190, 255);
insert into movieActor (intMovieID, intActorID) values (184, 124);
insert into movieActor (intMovieID, intActorID) values (73, 263);
insert into movieActor (intMovieID, intActorID) values (295, 224);
insert into movieActor (intMovieID, intActorID) values (124, 211);
insert into movieActor (intMovieID, intActorID) values (200, 211);
insert into movieActor (intMovieID, intActorID) values (75, 79);
insert into movieActor (intMovieID, intActorID) values (52, 26);
insert into movieActor (intMovieID, intActorID) values (57, 31);
insert into movieActor (intMovieID, intActorID) values (223, 245);
insert into movieActor (intMovieID, intActorID) values (245, 148);
insert into movieActor (intMovieID, intActorID) values (97, 173);
insert into movieActor (intMovieID, intActorID) values (169, 73);
insert into movieActor (intMovieID, intActorID) values (229, 272);
insert into movieActor (intMovieID, intActorID) values (26, 242);
insert into movieActor (intMovieID, intActorID) values (113, 236);
insert into movieActor (intMovieID, intActorID) values (287, 217);
insert into movieActor (intMovieID, intActorID) values (263, 51);
insert into movieActor (intMovieID, intActorID) values (98, 190);
insert into movieActor (intMovieID, intActorID) values (16, 28);
insert into movieActor (intMovieID, intActorID) values (152, 32);
insert into movieActor (intMovieID, intActorID) values (242, 14);
insert into movieActor (intMovieID, intActorID) values (185, 40);
insert into movieActor (intMovieID, intActorID) values (170, 124);
insert into movieActor (intMovieID, intActorID) values (73, 171);
insert into movieActor (intMovieID, intActorID) values (292, 249);
insert into movieActor (intMovieID, intActorID) values (2, 176);
insert into movieActor (intMovieID, intActorID) values (171, 21);
insert into movieActor (intMovieID, intActorID) values (182, 238);
insert into movieActor (intMovieID, intActorID) values (276, 178);
insert into movieActor (intMovieID, intActorID) values (4, 60);
insert into movieActor (intMovieID, intActorID) values (88, 172);
insert into movieActor (intMovieID, intActorID) values (115, 276);
insert into movieActor (intMovieID, intActorID) values (274, 16);
insert into movieActor (intMovieID, intActorID) values (247, 76);
insert into movieActor (intMovieID, intActorID) values (160, 4);
insert into movieActor (intMovieID, intActorID) values (183, 33);
insert into movieActor (intMovieID, intActorID) values (292, 169);
insert into movieActor (intMovieID, intActorID) values (163, 208);
insert into movieActor (intMovieID, intActorID) values (234, 140);
insert into movieActor (intMovieID, intActorID) values (230, 11);
insert into movieActor (intMovieID, intActorID) values (29, 289);
insert into movieActor (intMovieID, intActorID) values (284, 250);
insert into movieActor (intMovieID, intActorID) values (206, 70);
insert into movieActor (intMovieID, intActorID) values (220, 114);
insert into movieActor (intMovieID, intActorID) values (60, 259);
insert into movieActor (intMovieID, intActorID) values (258, 243);
insert into movieActor (intMovieID, intActorID) values (261, 183);
insert into movieActor (intMovieID, intActorID) values (46, 128);
insert into movieActor (intMovieID, intActorID) values (92, 25);
insert into movieActor (intMovieID, intActorID) values (258, 62);
insert into movieActor (intMovieID, intActorID) values (149, 11);
insert into movieActor (intMovieID, intActorID) values (30, 36);
insert into movieActor (intMovieID, intActorID) values (18, 41);
insert into movieActor (intMovieID, intActorID) values (225, 140);
insert into movieActor (intMovieID, intActorID) values (190, 271);
insert into movieActor (intMovieID, intActorID) values (54, 174);
insert into movieActor (intMovieID, intActorID) values (96, 155);
insert into movieActor (intMovieID, intActorID) values (296, 33);
insert into movieActor (intMovieID, intActorID) values (105, 62);
insert into movieActor (intMovieID, intActorID) values (172, 59);
insert into movieActor (intMovieID, intActorID) values (18, 93);
insert into movieActor (intMovieID, intActorID) values (288, 179);
insert into movieActor (intMovieID, intActorID) values (76, 56);
insert into movieActor (intMovieID, intActorID) values (57, 30);
insert into movieActor (intMovieID, intActorID) values (292, 29);
insert into movieActor (intMovieID, intActorID) values (158, 26);
insert into movieActor (intMovieID, intActorID) values (194, 287);
insert into movieActor (intMovieID, intActorID) values (215, 144);
insert into movieActor (intMovieID, intActorID) values (17, 173);
insert into movieActor (intMovieID, intActorID) values (25, 153);
insert into movieActor (intMovieID, intActorID) values (36, 104);
insert into movieActor (intMovieID, intActorID) values (199, 168);
insert into movieActor (intMovieID, intActorID) values (83, 98);
insert into movieActor (intMovieID, intActorID) values (178, 217);
insert into movieActor (intMovieID, intActorID) values (28, 173);
insert into movieActor (intMovieID, intActorID) values (179, 185);
insert into movieActor (intMovieID, intActorID) values (83, 78);
insert into movieActor (intMovieID, intActorID) values (253, 293);
insert into movieActor (intMovieID, intActorID) values (100, 230);
insert into movieActor (intMovieID, intActorID) values (167, 107);
insert into movieActor (intMovieID, intActorID) values (73, 252);
insert into movieActor (intMovieID, intActorID) values (135, 285);
insert into movieActor (intMovieID, intActorID) values (8, 58);
insert into movieActor (intMovieID, intActorID) values (10, 263);
insert into movieActor (intMovieID, intActorID) values (122, 75);
insert into movieActor (intMovieID, intActorID) values (9, 159);
insert into movieActor (intMovieID, intActorID) values (262, 1);
insert into movieActor (intMovieID, intActorID) values (65, 141);
insert into movieActor (intMovieID, intActorID) values (218, 270);
insert into movieActor (intMovieID, intActorID) values (91, 253);
insert into movieActor (intMovieID, intActorID) values (248, 235);
insert into movieActor (intMovieID, intActorID) values (111, 160);
insert into movieActor (intMovieID, intActorID) values (33, 131);
insert into movieActor (intMovieID, intActorID) values (174, 243);
insert into movieActor (intMovieID, intActorID) values (209, 177);
insert into movieActor (intMovieID, intActorID) values (185, 190);
insert into movieActor (intMovieID, intActorID) values (283, 39);
insert into movieActor (intMovieID, intActorID) values (58, 25);
insert into movieActor (intMovieID, intActorID) values (127, 189);
insert into movieActor (intMovieID, intActorID) values (85, 225);
insert into movieActor (intMovieID, intActorID) values (34, 265);
insert into movieActor (intMovieID, intActorID) values (96, 256);
insert into movieActor (intMovieID, intActorID) values (241, 20);
insert into movieActor (intMovieID, intActorID) values (243, 206);
insert into movieActor (intMovieID, intActorID) values (103, 102);
insert into movieActor (intMovieID, intActorID) values (227, 178);
insert into movieActor (intMovieID, intActorID) values (47, 226);
insert into movieActor (intMovieID, intActorID) values (139, 4);
insert into movieActor (intMovieID, intActorID) values (181, 62);
insert into movieActor (intMovieID, intActorID) values (8, 26);
insert into movieActor (intMovieID, intActorID) values (131, 234);
insert into movieActor (intMovieID, intActorID) values (131, 49);
insert into movieActor (intMovieID, intActorID) values (225, 263);
insert into movieActor (intMovieID, intActorID) values (63, 195);
insert into movieActor (intMovieID, intActorID) values (33, 54);
insert into movieActor (intMovieID, intActorID) values (257, 91);
insert into movieActor (intMovieID, intActorID) values (175, 119);
insert into movieActor (intMovieID, intActorID) values (174, 74);
insert into movieActor (intMovieID, intActorID) values (273, 90);
insert into movieActor (intMovieID, intActorID) values (142, 295);
insert into movieActor (intMovieID, intActorID) values (79, 236);
insert into movieActor (intMovieID, intActorID) values (141, 51);
insert into movieActor (intMovieID, intActorID) values (97, 178);
insert into movieActor (intMovieID, intActorID) values (194, 30);
insert into movieActor (intMovieID, intActorID) values (77, 194);
insert into movieActor (intMovieID, intActorID) values (115, 131);
insert into movieActor (intMovieID, intActorID) values (143, 165);
insert into movieActor (intMovieID, intActorID) values (205, 224);
insert into movieActor (intMovieID, intActorID) values (17, 266);
insert into movieActor (intMovieID, intActorID) values (67, 262);
insert into movieActor (intMovieID, intActorID) values (247, 279);
insert into movieActor (intMovieID, intActorID) values (276, 284);
insert into movieActor (intMovieID, intActorID) values (6, 132);
insert into movieActor (intMovieID, intActorID) values (250, 140);
insert into movieActor (intMovieID, intActorID) values (109, 103);
insert into movieActor (intMovieID, intActorID) values (189, 99);
insert into movieActor (intMovieID, intActorID) values (282, 85);
insert into movieActor (intMovieID, intActorID) values (152, 3);
insert into movieActor (intMovieID, intActorID) values (262, 238);
insert into movieActor (intMovieID, intActorID) values (223, 205);
insert into movieActor (intMovieID, intActorID) values (152, 102);
insert into movieActor (intMovieID, intActorID) values (237, 233);
insert into movieActor (intMovieID, intActorID) values (276, 225);
insert into movieActor (intMovieID, intActorID) values (66, 66);
insert into movieActor (intMovieID, intActorID) values (32, 3);
insert into movieActor (intMovieID, intActorID) values (120, 140);
insert into movieActor (intMovieID, intActorID) values (188, 260);
insert into movieActor (intMovieID, intActorID) values (221, 39);
insert into movieActor (intMovieID, intActorID) values (246, 1);
insert into movieActor (intMovieID, intActorID) values (213, 57);
insert into movieActor (intMovieID, intActorID) values (242, 286);
insert into movieActor (intMovieID, intActorID) values (235, 128);
insert into movieActor (intMovieID, intActorID) values (44, 273);
insert into movieActor (intMovieID, intActorID) values (38, 141);
insert into movieActor (intMovieID, intActorID) values (147, 145);
insert into movieActor (intMovieID, intActorID) values (188, 16);
insert into movieActor (intMovieID, intActorID) values (281, 174);
insert into movieActor (intMovieID, intActorID) values (203, 61);
insert into movieActor (intMovieID, intActorID) values (232, 30);
insert into movieActor (intMovieID, intActorID) values (2, 64);
insert into movieActor (intMovieID, intActorID) values (150, 194);
insert into movieActor (intMovieID, intActorID) values (24, 27);
insert into movieActor (intMovieID, intActorID) values (186, 211);
insert into movieActor (intMovieID, intActorID) values (158, 102);
insert into movieActor (intMovieID, intActorID) values (149, 169);
insert into movieActor (intMovieID, intActorID) values (245, 208);
insert into movieActor (intMovieID, intActorID) values (97, 21);
insert into movieActor (intMovieID, intActorID) values (117, 49);
insert into movieActor (intMovieID, intActorID) values (61, 67);
insert into movieActor (intMovieID, intActorID) values (207, 50);
insert into movieActor (intMovieID, intActorID) values (175, 267);
insert into movieActor (intMovieID, intActorID) values (95, 50);
insert into movieActor (intMovieID, intActorID) values (126, 79);
insert into movieActor (intMovieID, intActorID) values (113, 38);
insert into movieActor (intMovieID, intActorID) values (288, 300);
insert into movieActor (intMovieID, intActorID) values (232, 210);
insert into movieActor (intMovieID, intActorID) values (131, 261);
insert into movieActor (intMovieID, intActorID) values (62, 300);
insert into movieActor (intMovieID, intActorID) values (113, 146);
insert into movieActor (intMovieID, intActorID) values (234, 192);
insert into movieActor (intMovieID, intActorID) values (133, 258);
insert into movieActor (intMovieID, intActorID) values (3, 87);
insert into movieActor (intMovieID, intActorID) values (227, 272);
insert into movieActor (intMovieID, intActorID) values (26, 74);
insert into movieActor (intMovieID, intActorID) values (31, 187);
insert into movieActor (intMovieID, intActorID) values (218, 135);
insert into movieActor (intMovieID, intActorID) values (142, 90);
insert into movieActor (intMovieID, intActorID) values (39, 82);
insert into movieActor (intMovieID, intActorID) values (143, 247);
insert into movieActor (intMovieID, intActorID) values (65, 35);
insert into movieActor (intMovieID, intActorID) values (54, 55);
insert into movieActor (intMovieID, intActorID) values (130, 146);
insert into movieActor (intMovieID, intActorID) values (91, 177);
insert into movieActor (intMovieID, intActorID) values (40, 99);
insert into movieActor (intMovieID, intActorID) values (36, 173);
insert into movieActor (intMovieID, intActorID) values (46, 172);
insert into movieActor (intMovieID, intActorID) values (123, 297);
insert into movieActor (intMovieID, intActorID) values (3, 106);
insert into movieActor (intMovieID, intActorID) values (30, 90);
insert into movieActor (intMovieID, intActorID) values (70, 19);
insert into movieActor (intMovieID, intActorID) values (217, 270);
insert into movieActor (intMovieID, intActorID) values (248, 259);
insert into movieActor (intMovieID, intActorID) values (183, 239);
insert into movieActor (intMovieID, intActorID) values (163, 283);
insert into movieActor (intMovieID, intActorID) values (15, 134);
insert into movieActor (intMovieID, intActorID) values (268, 91);
insert into movieActor (intMovieID, intActorID) values (264, 34);
insert into movieActor (intMovieID, intActorID) values (153, 268);
insert into movieActor (intMovieID, intActorID) values (66, 267);
insert into movieActor (intMovieID, intActorID) values (149, 44);
insert into movieActor (intMovieID, intActorID) values (246, 151);
insert into movieActor (intMovieID, intActorID) values (154, 88);
insert into movieActor (intMovieID, intActorID) values (260, 219);
insert into movieActor (intMovieID, intActorID) values (144, 31);
insert into movieActor (intMovieID, intActorID) values (223, 187);
insert into movieActor (intMovieID, intActorID) values (205, 138);
insert into movieActor (intMovieID, intActorID) values (245, 9);
insert into movieActor (intMovieID, intActorID) values (106, 5);
insert into movieActor (intMovieID, intActorID) values (199, 240);
insert into movieActor (intMovieID, intActorID) values (283, 97);
insert into movieActor (intMovieID, intActorID) values (27, 137);
insert into movieActor (intMovieID, intActorID) values (260, 153);
insert into movieActor (intMovieID, intActorID) values (236, 21);
insert into movieActor (intMovieID, intActorID) values (121, 15);
insert into movieActor (intMovieID, intActorID) values (31, 243);
insert into movieActor (intMovieID, intActorID) values (166, 206);
insert into movieActor (intMovieID, intActorID) values (247, 274);
insert into movieActor (intMovieID, intActorID) values (153, 8);
insert into movieActor (intMovieID, intActorID) values (114, 215);
insert into movieActor (intMovieID, intActorID) values (87, 237);
insert into movieActor (intMovieID, intActorID) values (174, 174);
insert into movieActor (intMovieID, intActorID) values (218, 149);
insert into movieActor (intMovieID, intActorID) values (182, 17);
insert into movieActor (intMovieID, intActorID) values (175, 292);
insert into movieActor (intMovieID, intActorID) values (287, 131);
insert into movieActor (intMovieID, intActorID) values (24, 84);
insert into movieActor (intMovieID, intActorID) values (15, 24);
insert into movieActor (intMovieID, intActorID) values (94, 129);
insert into movieActor (intMovieID, intActorID) values (116, 110);
insert into movieActor (intMovieID, intActorID) values (91, 127);
insert into movieActor (intMovieID, intActorID) values (291, 209);
insert into movieActor (intMovieID, intActorID) values (196, 262);
insert into movieActor (intMovieID, intActorID) values (101, 189);
insert into movieActor (intMovieID, intActorID) values (6, 262);
insert into movieActor (intMovieID, intActorID) values (62, 242);
insert into movieActor (intMovieID, intActorID) values (78, 25);
insert into movieActor (intMovieID, intActorID) values (11, 264);
insert into movieActor (intMovieID, intActorID) values (85, 231);
insert into movieActor (intMovieID, intActorID) values (290, 242);
insert into movieActor (intMovieID, intActorID) values (105, 131);
insert into movieActor (intMovieID, intActorID) values (174, 108);
insert into movieActor (intMovieID, intActorID) values (133, 287);
insert into movieActor (intMovieID, intActorID) values (53, 260);
insert into movieActor (intMovieID, intActorID) values (197, 268);
insert into movieActor (intMovieID, intActorID) values (99, 163);
insert into movieActor (intMovieID, intActorID) values (131, 165);
insert into movieActor (intMovieID, intActorID) values (169, 291);
insert into movieActor (intMovieID, intActorID) values (102, 149);
insert into movieActor (intMovieID, intActorID) values (56, 68);
insert into movieActor (intMovieID, intActorID) values (252, 55);
insert into movieActor (intMovieID, intActorID) values (267, 233);
insert into movieActor (intMovieID, intActorID) values (33, 220);
insert into movieActor (intMovieID, intActorID) values (132, 67);
insert into movieActor (intMovieID, intActorID) values (99, 223);
insert into movieActor (intMovieID, intActorID) values (189, 182);
insert into movieActor (intMovieID, intActorID) values (256, 173);
insert into movieActor (intMovieID, intActorID) values (298, 167);
insert into movieActor (intMovieID, intActorID) values (238, 87);
insert into movieActor (intMovieID, intActorID) values (224, 107);
insert into movieActor (intMovieID, intActorID) values (220, 103);
insert into movieActor (intMovieID, intActorID) values (28, 153);
insert into movieActor (intMovieID, intActorID) values (233, 158);
insert into movieActor (intMovieID, intActorID) values (109, 193);
insert into movieActor (intMovieID, intActorID) values (151, 219);
insert into movieActor (intMovieID, intActorID) values (188, 202);
insert into movieActor (intMovieID, intActorID) values (280, 148);
insert into movieActor (intMovieID, intActorID) values (244, 36);
insert into movieActor (intMovieID, intActorID) values (170, 179);
insert into movieActor (intMovieID, intActorID) values (181, 43);
insert into movieActor (intMovieID, intActorID) values (290, 88);
insert into movieActor (intMovieID, intActorID) values (162, 293);
insert into movieActor (intMovieID, intActorID) values (49, 32);
insert into movieActor (intMovieID, intActorID) values (14, 269);
insert into movieActor (intMovieID, intActorID) values (135, 71);
insert into movieActor (intMovieID, intActorID) values (159, 38);
insert into movieActor (intMovieID, intActorID) values (261, 99);
insert into movieActor (intMovieID, intActorID) values (55, 284);
insert into movieActor (intMovieID, intActorID) values (268, 251);
insert into movieActor (intMovieID, intActorID) values (207, 160);
insert into movieActor (intMovieID, intActorID) values (98, 121);
insert into movieActor (intMovieID, intActorID) values (147, 173);
insert into movieActor (intMovieID, intActorID) values (180, 101);
insert into movieActor (intMovieID, intActorID) values (293, 45);
insert into movieActor (intMovieID, intActorID) values (196, 93);
insert into movieActor (intMovieID, intActorID) values (101, 2);
insert into movieActor (intMovieID, intActorID) values (232, 192);
insert into movieActor (intMovieID, intActorID) values (226, 254);
insert into movieActor (intMovieID, intActorID) values (86, 213);
insert into movieActor (intMovieID, intActorID) values (109, 253);
insert into movieActor (intMovieID, intActorID) values (196, 240);
insert into movieActor (intMovieID, intActorID) values (221, 284);
insert into movieActor (intMovieID, intActorID) values (285, 166);
insert into movieActor (intMovieID, intActorID) values (236, 246);
insert into movieActor (intMovieID, intActorID) values (276, 56);
insert into movieActor (intMovieID, intActorID) values (10, 39);
insert into movieActor (intMovieID, intActorID) values (280, 39);
insert into movieActor (intMovieID, intActorID) values (158, 5);
insert into movieActor (intMovieID, intActorID) values (71, 60);
insert into movieActor (intMovieID, intActorID) values (84, 100);
insert into movieActor (intMovieID, intActorID) values (58, 85);
insert into movieActor (intMovieID, intActorID) values (293, 223);
insert into movieActor (intMovieID, intActorID) values (42, 58);
insert into movieActor (intMovieID, intActorID) values (67, 137);
insert into movieActor (intMovieID, intActorID) values (105, 293);
insert into movieActor (intMovieID, intActorID) values (283, 234);
insert into movieActor (intMovieID, intActorID) values (72, 68);
insert into movieActor (intMovieID, intActorID) values (282, 111);
insert into movieActor (intMovieID, intActorID) values (57, 60);
insert into movieActor (intMovieID, intActorID) values (21, 114);
insert into movieActor (intMovieID, intActorID) values (131, 82);
insert into movieActor (intMovieID, intActorID) values (296, 33);
insert into movieActor (intMovieID, intActorID) values (131, 227);
insert into movieActor (intMovieID, intActorID) values (287, 216);
insert into movieActor (intMovieID, intActorID) values (243, 194);
insert into movieActor (intMovieID, intActorID) values (296, 39);
insert into movieActor (intMovieID, intActorID) values (117, 272);
insert into movieActor (intMovieID, intActorID) values (154, 47);
insert into movieActor (intMovieID, intActorID) values (63, 166);
insert into movieActor (intMovieID, intActorID) values (192, 59);
insert into movieActor (intMovieID, intActorID) values (217, 14);
insert into movieActor (intMovieID, intActorID) values (201, 83);
insert into movieActor (intMovieID, intActorID) values (126, 295);
insert into movieActor (intMovieID, intActorID) values (130, 118);
insert into movieActor (intMovieID, intActorID) values (157, 290);
insert into movieActor (intMovieID, intActorID) values (144, 6);
insert into movieActor (intMovieID, intActorID) values (43, 285);
insert into movieActor (intMovieID, intActorID) values (80, 85);
insert into movieActor (intMovieID, intActorID) values (165, 32);
insert into movieActor (intMovieID, intActorID) values (127, 6);
insert into movieActor (intMovieID, intActorID) values (199, 292);
insert into movieActor (intMovieID, intActorID) values (168, 11);
insert into movieActor (intMovieID, intActorID) values (255, 226);
insert into movieActor (intMovieID, intActorID) values (58, 80);
insert into movieActor (intMovieID, intActorID) values (110, 111);
insert into movieActor (intMovieID, intActorID) values (171, 11);
insert into movieActor (intMovieID, intActorID) values (231, 76);
insert into movieActor (intMovieID, intActorID) values (144, 138);
insert into movieActor (intMovieID, intActorID) values (211, 61);
insert into movieActor (intMovieID, intActorID) values (22, 202);
insert into movieActor (intMovieID, intActorID) values (52, 143);
insert into movieActor (intMovieID, intActorID) values (152, 202);
insert into movieActor (intMovieID, intActorID) values (77, 120);
insert into movieActor (intMovieID, intActorID) values (124, 130);
insert into movieActor (intMovieID, intActorID) values (25, 264);
insert into movieActor (intMovieID, intActorID) values (42, 162);
insert into movieActor (intMovieID, intActorID) values (14, 223);
insert into movieActor (intMovieID, intActorID) values (195, 109);
insert into movieActor (intMovieID, intActorID) values (166, 156);
insert into movieActor (intMovieID, intActorID) values (73, 253);
insert into movieActor (intMovieID, intActorID) values (185, 163);
insert into movieActor (intMovieID, intActorID) values (119, 144);
insert into movieActor (intMovieID, intActorID) values (273, 161);
insert into movieActor (intMovieID, intActorID) values (295, 207);
insert into movieActor (intMovieID, intActorID) values (150, 44);
insert into movieActor (intMovieID, intActorID) values (29, 182);
insert into movieActor (intMovieID, intActorID) values (285, 165);
insert into movieActor (intMovieID, intActorID) values (227, 235);
insert into movieActor (intMovieID, intActorID) values (12, 150);
insert into movieActor (intMovieID, intActorID) values (9, 231);
insert into movieActor (intMovieID, intActorID) values (191, 162);
insert into movieActor (intMovieID, intActorID) values (221, 294);
insert into movieActor (intMovieID, intActorID) values (138, 57);
insert into movieActor (intMovieID, intActorID) values (224, 234);
insert into movieActor (intMovieID, intActorID) values (30, 83);
insert into movieActor (intMovieID, intActorID) values (102, 10);
insert into movieActor (intMovieID, intActorID) values (292, 58);
insert into movieActor (intMovieID, intActorID) values (38, 163);
insert into movieActor (intMovieID, intActorID) values (281, 225);
insert into movieActor (intMovieID, intActorID) values (293, 107);
insert into movieActor (intMovieID, intActorID) values (233, 266);
insert into movieActor (intMovieID, intActorID) values (207, 164);
insert into movieActor (intMovieID, intActorID) values (91, 15);
insert into movieActor (intMovieID, intActorID) values (123, 196);
insert into movieActor (intMovieID, intActorID) values (294, 96);
insert into movieActor (intMovieID, intActorID) values (70, 165);
insert into movieActor (intMovieID, intActorID) values (234, 297);
insert into movieActor (intMovieID, intActorID) values (240, 159);
insert into movieActor (intMovieID, intActorID) values (199, 39);
insert into movieActor (intMovieID, intActorID) values (111, 116);
insert into movieActor (intMovieID, intActorID) values (7, 201);
insert into movieActor (intMovieID, intActorID) values (65, 104);
insert into movieActor (intMovieID, intActorID) values (195, 188);
insert into movieActor (intMovieID, intActorID) values (207, 206);
insert into movieActor (intMovieID, intActorID) values (217, 48);
insert into movieActor (intMovieID, intActorID) values (159, 234);
insert into movieActor (intMovieID, intActorID) values (298, 277);
insert into movieActor (intMovieID, intActorID) values (109, 120);
insert into movieActor (intMovieID, intActorID) values (123, 85);
insert into movieActor (intMovieID, intActorID) values (171, 210);
insert into movieActor (intMovieID, intActorID) values (180, 135);
insert into movieActor (intMovieID, intActorID) values (129, 112);
insert into movieActor (intMovieID, intActorID) values (180, 231);
insert into movieActor (intMovieID, intActorID) values (142, 75);
insert into movieActor (intMovieID, intActorID) values (299, 34);
insert into movieActor (intMovieID, intActorID) values (228, 68);
insert into movieActor (intMovieID, intActorID) values (152, 290);
insert into movieActor (intMovieID, intActorID) values (220, 73);
insert into movieActor (intMovieID, intActorID) values (234, 201);
insert into movieActor (intMovieID, intActorID) values (146, 74);
insert into movieActor (intMovieID, intActorID) values (111, 265);
insert into movieActor (intMovieID, intActorID) values (21, 253);
insert into movieActor (intMovieID, intActorID) values (101, 93);
insert into movieActor (intMovieID, intActorID) values (57, 34);
insert into movieActor (intMovieID, intActorID) values (112, 95);
insert into movieActor (intMovieID, intActorID) values (127, 91);
insert into movieActor (intMovieID, intActorID) values (244, 27);
insert into movieActor (intMovieID, intActorID) values (131, 210);
insert into movieActor (intMovieID, intActorID) values (183, 196);
insert into movieActor (intMovieID, intActorID) values (74, 231);
insert into movieActor (intMovieID, intActorID) values (40, 170);
insert into movieActor (intMovieID, intActorID) values (114, 34);
insert into movieActor (intMovieID, intActorID) values (199, 250);
insert into movieActor (intMovieID, intActorID) values (243, 117);
insert into movieActor (intMovieID, intActorID) values (260, 47);
insert into movieActor (intMovieID, intActorID) values (92, 34);
insert into movieActor (intMovieID, intActorID) values (17, 145);
insert into movieActor (intMovieID, intActorID) values (52, 256);
insert into movieActor (intMovieID, intActorID) values (163, 183);
insert into movieActor (intMovieID, intActorID) values (296, 180);
insert into movieActor (intMovieID, intActorID) values (99, 72);
insert into movieActor (intMovieID, intActorID) values (233, 46);
insert into movieActor (intMovieID, intActorID) values (228, 171);
insert into movieActor (intMovieID, intActorID) values (204, 199);
insert into movieActor (intMovieID, intActorID) values (242, 156);
insert into movieActor (intMovieID, intActorID) values (139, 269);
insert into movieActor (intMovieID, intActorID) values (272, 15);
insert into movieActor (intMovieID, intActorID) values (287, 229);
insert into movieActor (intMovieID, intActorID) values (79, 272);
insert into movieActor (intMovieID, intActorID) values (9, 101);
insert into movieActor (intMovieID, intActorID) values (144, 222);
insert into movieActor (intMovieID, intActorID) values (35, 187);
insert into movieActor (intMovieID, intActorID) values (185, 298);
insert into movieActor (intMovieID, intActorID) values (11, 132);
insert into movieActor (intMovieID, intActorID) values (112, 234);
insert into movieActor (intMovieID, intActorID) values (63, 61);
insert into movieActor (intMovieID, intActorID) values (258, 8);
insert into movieActor (intMovieID, intActorID) values (92, 82);
insert into movieActor (intMovieID, intActorID) values (115, 195);
insert into movieActor (intMovieID, intActorID) values (186, 182);
insert into movieActor (intMovieID, intActorID) values (4, 274);
insert into movieActor (intMovieID, intActorID) values (292, 265);
insert into movieActor (intMovieID, intActorID) values (19, 105);
insert into movieActor (intMovieID, intActorID) values (188, 262);
insert into movieActor (intMovieID, intActorID) values (50, 104);
insert into movieActor (intMovieID, intActorID) values (110, 238);
insert into movieActor (intMovieID, intActorID) values (250, 164);
insert into movieActor (intMovieID, intActorID) values (186, 296);
insert into movieActor (intMovieID, intActorID) values (58, 201);
insert into movieActor (intMovieID, intActorID) values (23, 269);
insert into movieActor (intMovieID, intActorID) values (135, 3);
insert into movieActor (intMovieID, intActorID) values (75, 178);
insert into movieActor (intMovieID, intActorID) values (229, 151);
insert into movieActor (intMovieID, intActorID) values (72, 208);
insert into movieActor (intMovieID, intActorID) values (296, 150);
insert into movieActor (intMovieID, intActorID) values (22, 47);
insert into movieActor (intMovieID, intActorID) values (290, 28);
insert into movieActor (intMovieID, intActorID) values (98, 5);
insert into movieActor (intMovieID, intActorID) values (99, 122);
insert into movieActor (intMovieID, intActorID) values (275, 107);
insert into movieActor (intMovieID, intActorID) values (129, 27);
insert into movieActor (intMovieID, intActorID) values (127, 31);
insert into movieActor (intMovieID, intActorID) values (86, 254);
insert into movieActor (intMovieID, intActorID) values (5, 79);
insert into movieActor (intMovieID, intActorID) values (139, 132);
insert into movieActor (intMovieID, intActorID) values (33, 123);
insert into movieActor (intMovieID, intActorID) values (169, 83);
insert into movieActor (intMovieID, intActorID) values (170, 114);
insert into movieActor (intMovieID, intActorID) values (123, 181);
insert into movieActor (intMovieID, intActorID) values (231, 143);
insert into movieActor (intMovieID, intActorID) values (17, 177);
insert into movieActor (intMovieID, intActorID) values (30, 55);
insert into movieActor (intMovieID, intActorID) values (66, 61);
insert into movieActor (intMovieID, intActorID) values (128, 175);
insert into movieActor (intMovieID, intActorID) values (271, 218);
insert into movieActor (intMovieID, intActorID) values (47, 119);
insert into movieActor (intMovieID, intActorID) values (227, 192);
insert into movieActor (intMovieID, intActorID) values (123, 148);
insert into movieActor (intMovieID, intActorID) values (168, 135);
insert into movieActor (intMovieID, intActorID) values (113, 183);
insert into movieActor (intMovieID, intActorID) values (253, 200);
insert into movieActor (intMovieID, intActorID) values (103, 85);
insert into movieActor (intMovieID, intActorID) values (266, 239);
insert into movieActor (intMovieID, intActorID) values (29, 62);
insert into movieActor (intMovieID, intActorID) values (21, 211);
insert into movieActor (intMovieID, intActorID) values (224, 193);
insert into movieActor (intMovieID, intActorID) values (274, 142);
insert into movieActor (intMovieID, intActorID) values (90, 204);
insert into movieActor (intMovieID, intActorID) values (38, 164);
insert into movieActor (intMovieID, intActorID) values (268, 200);
insert into movieActor (intMovieID, intActorID) values (45, 13);
insert into movieActor (intMovieID, intActorID) values (87, 37);
insert into movieActor (intMovieID, intActorID) values (148, 119);
insert into movieActor (intMovieID, intActorID) values (148, 5);
insert into movieActor (intMovieID, intActorID) values (148, 194);

-- Fråga 10: Du ska underhålla en statistiktabell med hjälp av triggers. När du lämnar ut en fil ska det göras en notering 
-- om det i din statistiktabell. Du får inte lägga till informationen från din SP ovan, det ska skötas med triggers.

DROP TRIGGER IF EXISTS tr_isnotinstoreBackUp;
DELIMITER //
CREATE TRIGGER tr_isnotinstoreBackUp
AFTER UPDATE ON isnotinstore 
FOR EACH ROW
BEGIN
	INSERT INTO isNotInStoreBackUp (intBackUpID, dteCreated, intMovieID, intRentalLogID)
    VALUES (OLD.intID, OLD.dteCreated, OLD.intMovieID, OLD.intRentalLogID);
END//
DELIMITER ;

DROP TRIGGER IF EXISTS tr_rentalLogBackUp;
DELIMITER //
CREATE TRIGGER tr_rentalLogBackUp
AFTER UPDATE ON rentalLog 
FOR EACH ROW
BEGIN
	INSERT INTO rentalLogBackUp (intBackUpID, dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned)
    VALUES (OLD.intID, OLD.dteCreated, OLD.intMovieID, OLD.intCustomerID, OLD.intStaffID, OLD.dteReturned);
END//
DELIMITER ;

-- 10. rentalLog (1.000)

-- added dynamic // per date


-- GENERATE FAKE DATA --
DROP PROCEDURE IF EXISTS sp_INSERTDefaultEntries;
DELIMITER //
CREATE PROCEDURE sp_INSERTDefaultEntries(in sp_loop int)
BEGIN
	DECLARE sp_dteCreated datetime default current_timestamp();
	DECLARE sp_dteReturned datetime default current_timestamp();
	DECLARE intDaysInterval int default 0;
    DECLARE intDayForEntry int default 0;
    DECLARE intRandomDaysOfRental int default 0;
    DECLARE intRandomReturnDate int default 0;
    DECLARE intLastID int default 0;

	DECLARE intAllMovies int default 0;
	DECLARE intRandomMovie int default 0;
	DECLARE intAllCustomers int default 0;
	DECLARE intRandomCustomer int default 0;
	DECLARE intAllStaff int default 0;
	DECLARE intRandomStaff int default 0;

	DECLARE intStart int default 0;
	DECLARE intStop int default 0;
	DECLARE intDuplicateEntry int default 0;

	SET intStop = sp_loop;

    SET intAllMovies = (SELECT COUNT(*) FROM movies);
    SET intAllCustomers = (SELECT COUNT(*) FROM customers);
    SET intAllStaff = (SELECT COUNT(*) FROM staff);

	-- count days = 3 months
    SET intDaysInterval =  datediff(current_date(), date_add(current_date(), interval -3 month));

	REPEAT
		-- select random day for entry
		SET intDayForEntry = (select FORMAT(RAND()*(intDaysInterval - 1)+1,0));
		-- set dteCreated for this entry
        SET sp_dteCreated = date_add(current_date(), interval -intDayForEntry day);
	
		-- set dteReturned
        SET intRandomReturnDate = (select FORMAT(RAND()*(8)+2,0)); -- slackers don't always return movies on time. (from 2 to 10 days.)
        SET sp_dteReturned = date_add(sp_dteCreated, interval intRandomReturnDate day);

		-- make sure random returndate is not in the future because of obvious reasons! :-)
       IF date(sp_dteReturned) > current_date() THEN
			SET sp_dteReturned = null;
		END IF;

		-- select random movie
   		SET intRandomMovie = (SELECT FORMAT(RAND()*(intAllMovies -1)+1,0));
        -- select random customer
   		SET intRandomCustomer = (SELECT FORMAT(RAND()*(intAllCustomers -1)+1,0));
        -- select random staff
   		SET intRandomStaff = (SELECT FORMAT(RAND()*(intAllStaff -1)+1,0));

		-- check for duplicate entery :: movie is returned!!
		SET intDuplicateEntry = 0;
        IF sp_dteReturned IS NOT NULL THEN
			SET intDuplicateEntry = (SELECT COUNT(*) FROM rentallog rl 
            WHERE intMovieID = intRandomMovie AND dteCreated BETWEEN sp_dteCreated AND sp_dteReturned );
			IF intDuplicateEntry = 0 THEN
				INSERT INTO rentallog (dteCreated, intMovieID, intCustomerID, intStaffID, dteReturned ) 
				VALUES (sp_dteCreated, intRandomMovie, intRandomCustomer, intRandomStaff, sp_dteReturned );
			END IF;
		END IF;
		-- movie is not in store :: movie not returned!
		IF sp_dteReturned IS NULL THEN
			SET intDuplicateEntry = 0;
			SET intDuplicateEntry = (SELECT COUNT(*) FROM isnotinstore WHERE intMovieID = intRandomMovie );
			IF intDuplicateEntry = 0 THEN
                -- inset in new log
				INSERT INTO rentallog (dteCreated, intMovieID, intCustomerID, intStaffID ) 
				VALUES (sp_dteCreated, intRandomMovie, intRandomCustomer, intRandomStaff);
                SET intLastID = last_insert_id();
				INSERT INTO isnotinstore (dteCreated, intMovieID, intRentalLogID) VALUES (sp_dteCreated, intRandomMovie, intLastID);
			END IF;
		END IF;
		SET intDuplicateEntry = 0;
   		SET intStart = intStart + 1;
	UNTIL intStart = intStop END REPEAT;
END//

DELIMITER ;

CALL sp_INSERTDefaultEntries(3000);


-- INSERT VIEWS
DROP VIEW IF EXISTS view_MoviesInventory;
CREATE VIEW view_MoviesInventory AS 
SELECT m.strName AS TITLE, CONCAT(pc.strName, ' ',  pc.intPrice, ' kr.') AS PRICE, m.strLength AS MINUTES, YEAR(m.strYear) AS RELEASED,
CONCAT(d.strFirstname, ' ', d.strLastname, ' (', YEAR(d.dteBirthOfYear), ')') AS DIRECTOR, 
(SELECT GROUP_CONCAT(CONCAT(a.strFirstName, ' ', a.strLastName )) FROM actors a, movieactor ma WHERE a.intID = ma.intActorID AND ma.intMovieID = m.intID ) AS `ACTORS IN THE MOVIE`,
(SELECT COUNT(*) FROM actors a, movieactor ma WHERE a.intID = ma.intActorID AND ma.intMovieID = m.intID ) AS `# ACTORS IN THE MOVIE`,
g.strName AS GENRE, m.strISBN AS ISBN, m.strDescription AS SHORTTEXT
FROM movies m
LEFT JOIN genre g ON g.intID = m.intGenreID 
LEFT JOIN directors d ON d.intID = m.intDirectorID
LEFT JOIN priceCategory pc ON pc.intID = m.intPriceCategoryID 
ORDER BY TITLE;

-- WORKS!! :-) V1
-- två olika typer av [genre] : som separat tabell. 
DROP VIEW IF EXISTS view_genreV1;
CREATE VIEW view_genreV1 AS 
SELECT g.strName AS GENRE, COUNT(m.strName) AS `NR OF MOVIES`, GROUP_CONCAT(m.strName) AS `NAME OF MOVIE` 
FROM genre g
JOIN movies m ON g.intID = m.intGenreID
GROUP BY g.strName;

-- WORKS!! :-) V2
-- två olika typer av [genre] : som fält i tabellen. 
DROP VIEW IF EXISTS view_genreV2;
CREATE VIEW view_genreV2 AS 
SELECT m.strGenre AS GENRE, COUNT(m.strName) AS `NR OF MOVIES`, GROUP_CONCAT(m.strName) AS `NAME OF MOVIE` 
FROM movies m
GROUP BY m.strGenre ORDER BY `NR OF MOVIES` DESC;

-- 3. vilka filmer är uthyrda, vem som hyrde (kund) och vem som hyrde ut dom
DROP VIEW IF EXISTS view_rentalLog;
CREATE VIEW view_rentalLog AS 
SELECT m.strName AS `MOVIE NAME`, CONCAT(c.strFirstName, ' ', c.strLastName) AS CUSTOMER,
CONCAT(s.strFirstName, ' ', s.strLastName) AS STAFF,  DATE(rl.dteCreated) AS `HANDED OUT`,
DATE(rl.dteCreated) + INTERVAL 4 DAY AS `DATE OF RETURN`, DATE(rl.dteReturned) AS RETURNED 
FROM rentalLog rl
JOIN staff s ON rl.intStaffID = s.intID
JOIN customers c ON rl.intCustomerID = c.intID
JOIN movies m ON rl.intMovieID = m.intID
ORDER BY rl.dteCreated, m.strName;


-- 3. vilka filmer är uthyrda, vem som hyrde (kund) och vem som hyrde ut dom -- date = TODAY date()
DROP VIEW IF EXISTS view_rentalLogDATE;
CREATE VIEW view_rentalLogDATE AS 
SELECT m.intID as ID, m.strName AS `MOVIE NAME`, CONCAT(c.strFirstName, ' ', c.strLastName) AS CUSTOMER,
CONCAT(s.strFirstName, ' ', s.strLastName) AS STAFF,  DATE(rl.dteCreated) AS `HANDED OUT`,
DATE(rl.dteCreated) + INTERVAL 4 DAY AS `DATE OF RETURN` 
FROM isnotinstore i 
INNER JOIN movies m ON i.intMovieID = m.intID
INNER JOIN rentallog rl ON i.intRentalLogID = rl.intID
INNER JOIN staff s ON rl.intStaffID = s.intID
INNER JOIN customers c ON rl.intCustomerID = c.intID
GROUP BY i.intID
ORDER BY m.intID;


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

DROP VIEW IF EXISTS view_LateMoviesDATE;
CREATE VIEW view_LateMoviesDATE AS 
SELECT i.intID AS COUNTER , m.intID AS `MOVIE ID`, m.strName AS `NAME OF MOVIE`, DATE(i.dteCreated) AS `DAY OF RENTAL`,
date(i.dteCreated + INTERVAL 4 DAY) AS `DAY OF EXPECTED RETURN`,
current_date() - date(i.dteCreated + INTERVAL 4 DAY) AS `DAY(S) LATE`,
CONCAT(s.strFirstName, ' ', s.strLastName ) AS STAFF, CONCAT(c.strFirstName, ' ', c.strLastName) AS CUSTOMER
FROM isnotinstore i 
JOIN movies m ON m.intID = i.intMovieID
INNER JOIN rentallog rl ON rl.intMovieID = m.intID
JOIN staff s ON s.intID = rl.intStaffID
JOIN customers c ON c.intID = rl.intCustomerID
WHERE i.dteCreated + INTERVAL 4 DAY < current_date()
GROUP BY i.intID;


-- 5. lista över alla anställda och hur många filmer de har hyrt ut.
DROP VIEW IF EXISTS view_MoviesPerStaffALL_LOG;
CREATE VIEW view_MoviesPerStaffALL_LOG AS 
SELECT CONCAT(s.strFirstName, ' ', s.strLastName) AS `STAFF / EMPLOYER`,
(SELECT COUNT(*) AS MoviesPerStaff FROM rentallog rl WHERE rl.intStaffID = s.intID  ) AS `MOVIE PER STAFF MEMBER` 
FROM staff s
ORDER BY `MOVIE PER STAFF MEMBER` DESC;

-- 6. en lista med statistik över de mest uthyrda filmerna den senaste månaden. 
-- för uppgiften: månad = mars 2018, 2018-03-01 --> 184 rader
-- för uppgiften: månad = mars 2018, 2018-03-01 -- 2018-04-01 --> 184 rader

DROP VIEW IF EXISTS view_MostWantedMovies;
CREATE VIEW view_MostWantedMovies AS 
SELECT m.strName AS `MOVIE NAME`,
(SELECT GROUP_CONCAT(DATE(rl.dteCreated)) FROM rentalLog rl
WHERE rl.intMovieID = m.intID AND (rl.dteCreated BETWEEN date_add(current_date(), INTERVAL -1 MONTH) AND current_date())
) AS `DATE OF RENTAL`,
(SELECT COUNT(rl.intID)  FROM rentalLog rl
WHERE rl.intMovieID = m.intID AND (rl.dteCreated BETWEEN date_add(current_date(), INTERVAL -1 MONTH) AND current_date())
) AS `MOST WANTED IN A MONTH`
FROM rentallog rl
JOIN movies m ON rl.intMovieID = m.intID
WHERE rl.dteCreated BETWEEN date_add(current_date(), INTERVAL -1 MONTH) AND current_date()
GROUP BY m.strName
ORDER BY `MOST WANTED IN A MONTH` DESC;



-- Fråga 7: En Stored Procedure som ska köras när en film lämnas ut. Ska alltså sätta filmen till uthyrd, vem som hyrt den osv.

-- skapa en post, isNotInStore (date, intMovieID)
-- skapa en post, rentalLog (date, intMovieID, intCustomerID, intStaffID)
-- om fälten är tomma, random! :-)

DROP PROCEDURE IF EXISTS sp_MarkMovieAsRented;
DELIMITER //
CREATE PROCEDURE sp_MarkMovieAsRented(IN sp_MovieID int, IN sp_CustomerID int, IN sp_StaffID int, 
OUT out_movieID int,
OUT out_movieName varchar(200),
OUT out_moviePriceText varchar(100),
OUT out_moviePrice double,
OUT out_DayOfRental date,
OUT out_DayOfReturn date,
OUT out_CustomerName varchar(200),
OUT out_StaffName varchar(200),
OUT out_Message varchar(100))
BEGIN

	DECLARE local_MovieID int default 0;
    DECLARE local_CustomerID int default 0;
    DECLARE local_StaffID int default 0;
    DECLARE local_randomID integer default 0;
	DECLARE local_isForRental integer default 0;
    DECLARE local_lastID integer default 0;
    -- sp_FakeDays = 0 = new post
    -- sp_FakeDays = int = 'old' post 'int' days ago.

-- update code
-- select movie
    IF sp_MovieID = 0 THEN
	--	SET local_randomID = (SELECT COUNT(*) FROM movies);
	--	SET local_MovieID = FORMAT(RAND()*(local_randomID -1)+1,0);
		SET local_MovieID = (select m.intID FROM movies m left join isnotinstore i ON m.intID = i.intMovieID where i.intID IS NULL LIMIT 1,1);   
    ELSE
		SET local_MovieID = sp_MovieID;
    END IF;
    
    -- check if movie is for rental!
    SET local_isForRental = (SELECT COUNT(*) FROM isnotinstore WHERE intMovieID = local_MovieID );

	IF local_isForRental = 0 THEN
     
		-- select customer
		IF sp_CustomerID = 0 THEN
			SET local_randomID = (SELECT COUNT(*) FROM customers);
			SET local_CustomerID = (SELECT FORMAT(RAND()*(local_randomID -1)+1,0));
		ELSE
			SET local_CustomerID = sp_CustomerID;
		END IF;
    
-- select staff
    IF sp_StaffID = 0 THEN
		SET local_randomID = (SELECT COUNT(*) FROM staff);
		SET local_StaffID = (SELECT FORMAT(RAND()*(local_randomID -1)+1,0));
    ELSE
		SET local_StaffID = sp_StaffID;
    END IF;

-- insert log file
		INSERT INTO rentallog (dteCreated, intMovieID, intCustomerID, intStaffID) 
		VALUES (current_timestamp(), local_MovieID, local_CustomerID, local_StaffID );
        SET local_lastID = (select intid from rentallog order by intID desc limit 1,1);
		INSERT INTO isnotinstore (dteCreated, intMovieID, intRentalLogID) VALUES (current_timestamp(), local_MovieID, local_lastID );
        SET local_lastID = (select intid from isnotinstore order by intID desc limit 1,1);
 
		-- set return values ::  @movieID, @movieName, @moviePrice, @dayOfRental, @dayOfReturn, @customer, @staff, @message);
		select m.intID INTO out_movieID from isnotinstore i, movies m where i.intID = local_lastID AND m.intID = i.intMovieID;
		select m.strName INTO out_movieName from isnotinstore i, movies m where i.intID = local_lastID AND m.intID = i.intMovieID;
        select pc.strName INTO out_moviePriceText from isnotinstore i, movies m, pricecategory pc 
			where i.intID = local_lastID AND i.intMovieID = m.intID AND m.intPriceCategoryID = pc.intID;

        select pc.intPrice INTO out_moviePrice from isnotinstore i, movies m, pricecategory pc 
			where i.intID = local_lastID AND i.intMovieID = m.intID AND m.intPriceCategoryID = pc.intID;
            
        select date(i.dteCreated) INTO out_DayOfRental from movies m, isnotinstore i 
			where i.intID = local_lastID and m.intID = i.intMovieID;
        select date(date_add(i.dteCreated, interval 4 day)) INTO out_DayOfReturn from movies m, isnotinstore i 
			where i.intID = local_lastID and m.intID = i.intMovieID;
        select  concat(c.strFirstName, ' ', c.strLastName) INTO out_CustomerName from isnotinstore i, movies m, rentallog rl, customers c 
        where i.intID = local_lastID and i.intMovieID = m.intID AND rl.intMovieID = m.intID and rl.intCustomerID = c.intID  order by i.intID desc limit 1,1;
        select  concat(s.strFirstName, ' ', s.strLastName) INTO out_StaffName from isnotinstore i, movies m, rentallog rl, staff s 
        where i.intID = local_lastID and i.intMovieID = m.intID AND rl.intMovieID = m.intID and rl.intStaffID = s.intID  order by i.intID desc limit 1,1;

        
		SET out_Message = "Thank you for choosing MAX VideoRental!";
	ELSE
		SET out_Message = "This movie is taken. Please choose another.";
    END IF;
END //

DELIMITER ;

-- 8. en funktion som kollar om en film finns eller ej
-- tar en film som parameter och returnerar 1 om den är sen, 0 om allt är i sin ording.alter

DROP FUNCTION IF EXISTS func_isLateByDate;
DELIMITER //
CREATE FUNCTION func_isLateByDate ( f_movieID INT ) RETURNS int
BEGIN
	DECLARE valReturned int DEFAULT 0;
	-- 0 is fine. all is good
    -- 1 is late, not fine. not good.
	select count(*) into valReturned from rentallog rl 
		where rl.dteReturned is null and rl.dteCreated < date_add(current_date(), interval -4 day)
		and intMovieID = f_movieID;
--    SET valReturned = ABS(valReturned - 1);
	return valReturned;
END //
DELIMITER ;

-- Fråga 9: En Stored Procedure som ska köras när en film lämnas tillbaka. Den ska använda sig av
-- ovanstående funktion för att göra någon form av markering/utskrift om filmen är återlämnad för sent.

DROP PROCEDURE IF EXISTS sp_ReturnMovie;
DELIMITER //
CREATE PROCEDURE sp_ReturnMovie(IN intMovieID int, OUT strMessage varchar(200))
BEGIN
	DECLARE sp_intMovieID int default intMovieID;
	DECLARE intAllMovies int default 0;
	DECLARE intRandomMovie int default 0;
	DECLARE intIsMovieLate int default 0;
	DECLARE intMovieLateDays int default 0;

	DECLARE sp_movieTitle varchar(200);
	DECLARE sp_dteCreated date;
	DECLARE sp_strCreated varchar(20);

	-- if movieID = 0 then select random movie
    IF sp_intMovieID = 0 THEN
    	-- how many movies are not inb the store?
	    SET intAllMovies = (SELECT COUNT(*) FROM isnotinstore);
   		-- select random movie
   		SET sp_intMovieID = FORMAT(RAND()*(intAllMovies -1)+1,0);
    END IF;
    
    -- select name of movie
    select strName into sp_movieTitle from movies where intID =  sp_intMovieID;
    -- select date of movie
    select dteCreated into sp_dteCreated from rentallog where intMovieID = sp_intMovieID;

    	-- check if movie is late
    SET intIsMovieLate = (select func_isLateByDate (sp_intMovieID));
   
	IF intIsMovieLate = 0 THEN
		-- movie is on time = 0 
		SET strMessage = concat("Movie is returned on time. Thank you! Name of movie: ", sp_movieTitle);
	ELSE
		-- movie is late = 1
		SET strMessage = concat("Movie is late. We hope you enjoyed it! Name of movie: ", sp_movieTitle);
    END IF;
END//
DELIMITER ;


