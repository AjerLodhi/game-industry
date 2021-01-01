
-- Entities
CREATE TABLE VideoGameDevelopers(
Dname			VARCHAR(30)		NOT NULL,
GameHistory		INTEGER,		
PRIMARY KEY(Dname)
);


CREATE TABLE VideoGamePublisher(
Pname			VARCHAR(30)		NOT NULL,
Pstreet			INTEGER,
Pcity			VARCHAR(30),
Pstate			CHAR(2),		
PRIMARY KEY(Pname)
);

CREATE TABLE VideoGames(
Gname			VARCHAR(30)		NOT NULL,
Rating			char(1), 
Pname 			VARCHAR(30),	
PRIMARY KEY(Gname),
FOREIGN KEY(Pname) REFERENCES VideoGamePublisher(Pname)
				ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Stores(
Sname			VARCHAR(30)		NOT NULL,
Sstreet			INTEGER,
Scity			VARCHAR(30),
Sstate			CHAR(2),		
PRIMARY KEY(Sname)
);

-- tables referencing entities
CREATE TABLE Customer(
SSN				INTEGER			NOT NULL,
Cname			VARCHAR(30)		NOT NULL,
Age				INTEGER,
Gender			char(1),
PRIMARY KEY(SSN)
);

CREATE TABLE CreatedBy(
Dname			VARCHAR(30),
Gname			VARCHAR(30),
Years			INTEGER,
Months			INTEGER,		
FOREIGN KEY(Dname) REFERENCES VideoGameDevelopers(Dname)
				ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY(Gname) REFERENCES VideoGames(Gname)
				ON DELETE SET NULL ON UPDATE CASCADE                
);

CREATE TABLE Price(
Gname			VARCHAR(30),
Price			DECIMAL(6,2),
FOREIGN KEY(Gname) REFERENCES VideoGames(Gname)
				ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Dlocation(
Dname			VARCHAR(30),
Dstreet			INTEGER,
Dcity			VARCHAR(30),
Dstate			CHAR(2),
FOREIGN KEY(Dname) REFERENCES VideoGameDevelopers(Dname)
				ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Console(
Gname			VARCHAR(30),
Console			VARCHAR(30),
FOREIGN KEY(Gname) REFERENCES VideoGames(Gname)
				ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE SoldIn(
Gname			VARCHAR(30),
Sname			VARCHAR(30),
FOREIGN KEY(Gname) REFERENCES VideoGames(Gname)
				ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY(Sname) REFERENCES Stores(Sname)
				ON DELETE SET NULL ON UPDATE CASCADE                
);

CREATE TABLE BoughtBy(
Gname			VARCHAR(30),
SSN				INTEGER,
FOREIGN KEY(Gname) REFERENCES VideoGames(Gname)
				ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY(SSN) REFERENCES Customer(SSN)
				ON DELETE SET NULL ON UPDATE CASCADE 
);

CREATE TABLE RentedBy(
Gname			VARCHAR(30),
SSN				INTEGER,
dueDate			DATE,
FOREIGN KEY(Gname) REFERENCES VideoGames(Gname)
				ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY(SSN) REFERENCES Customer(SSN)
				ON DELETE SET NULL ON UPDATE CASCADE 
);

DESC Price;

DESC Dlocation;

DESC VideoGameDevelopers;

DESC CreatedBy;

DESC VideoGames;

DESC SoldIn;

DESC Stores;

DESC BoughtBy;

DESC RentedBy;

DESC Customer;

DESC Console;

INSERT INTO VideoGamePublisher
		VALUES('Bethesda', 1200, 'Rockville', 'MD');
INSERT INTO VideoGames
		VALUES('Doom(2016)', 'M', 'Bethesda');
        
INSERT INTO VideoGamePublisher
		VALUES('Rockstar', 1170, 'New York City', 'NY');
INSERT INTO VideoGames
		VALUES('GTA', 'M', 'Rockstar');

INSERT INTO VideoGamePublisher
		VALUES('Rocksteady', 1354, 'Seattle', 'WA');
INSERT INTO VideoGames
		VALUES('Batman: Arkham city', 'T', 'Rocksteady');
        
INSERT INTO VideoGamePublisher
		VALUES('CD Projekt', 4260, 'Tacoma', 'WA');
INSERT INTO VideoGames
		VALUES('The Witcher 3', 'M', 'CD Projekt');
        
INSERT INTO VideoGamePublisher
		VALUES('Nintendo', 4600, 'Redmond', 'WA');
INSERT INTO VideoGames
		VALUES('Super Mario Maker 2', 'T', 'Nintendo');

SELECT *
FROM VideoGames;

SELECT *
FROM VideoGameDevelopers;

SELECT COUNT(*)
FROM VideoGameDevelopers;

SELECT *
FROM VideoGameDevelopers
Limit 3;

SELECT *
FROM VideoGamePublisher;

SELECT COUNT(*)
FROM VideoGamePublisher;

SELECT *
FROM VideoGamePublisher
Limit 3;

SELECT *
FROM VideoGames;

SELECT COUNT(*)
FROM VideoGames;

SELECT *
FROM VideoGames
Limit 3;

SELECT *
FROM Stores;

SELECT COUNT(*)
FROM Stores;

SELECT *
FROM Customer;

SELECT COUNT(*)
FROM Customer;

SELECT *
FROM CreatedBy;

SELECT COUNT(*)
FROM CreatedBy;

SELECT *
FROM Price;

SELECT COUNT(*)
FROM Price;

SELECT *
FROM Dlocation;

SELECT COUNT(*)
FROM Dlocation;

SELECT *
FROM Console;

SELECT COUNT(*)
FROM Console;

SELECT *
FROM SoldIn;

SELECT COUNT(*)
FROM SoldIn;

SELECT *
FROM BoughtBy;

SELECT COUNT(*)
FROM BoughtBy;


SELECT *
FROM RentedBy;

SELECT COUNT(*)
FROM RentedBy;

SELECT *
FROM VideoGameDevelopers
Limit 6;

SELECT *
FROM CreatedBy
Limit 6;

SELECT 
    *
FROM
    VideoGames
LIMIT 6;

#------
# PDA5
#------

#(a)

# (1) One query is just a simple select from one relation with a limit clause
#     that limits the results to 20 or fewer tuples

SELECT *
FROM	CreatedBy
WHERE	Years < 2
LIMIT	15;

# (2) One query must involve a two-way join (involving two tables)
#     with a limit clause that limits the results to 20 or fewer tuples.

SELECT 	DISTINCT v.Gname, v.Rating
FROM 	Price p, VideoGames v
WHERE   v.Gname = p.Gname AND p.Price < 80
LIMIT   15;

# (3) One query must be aggregate using a group by clause

SELECT 	c.Gender, MIN(Age)
FROM 	Customer c
GROUP BY c.Gender;

# (b)

# (1) One should be a simple insert.
INSERT INTO VideoGamePublisher
		VALUES('A pub comp', 5000, 'Tacoma', 'WA');
SELECT *
FROM VideoGamePublisher
WHERE Pname = 'A pub comp';

# (2) One a simple update.
SELECT  p.Gname, p.Price
FROM    Price p
WHERE	p.Gname = 'Cade' AND p.Price < 30;

UPDATE Price
SET    Price = Price+10
WHERE  Gname = 'Cade'AND Price < 30;

# (3) One an update that updates several tuples at once
SELECT	   DISTINCT*
FROM	   Price
WHERE	   Gname = 'Cade'
ORDER BY   Price; 

UPDATE Price
SET    Price = Price+10
WHERE  Gname = 'Cade';

# (4) One should be a delete that deletes a tuple.
SELECT *
FROM VideoGamePublisher
WHERE Pname = 'A pub comp';

DELETE FROM VideoGamePublisher
WHERE Pname = 'A pub comp';