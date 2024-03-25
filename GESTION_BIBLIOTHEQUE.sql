--TABLES : Book,Home Edition,Othor,OtherEditBook,Client,Order,Country

START TRANSACTION;

	CREATE TABLE Year_Published(
		id_year SERIAL NOT NULL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL UNIQUE,
		date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);

	CREATE TABLE Country(
		id_country SERIAL NOT NULL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL UNIQUE,
		date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE Home_Edition(
		id_home SERIAL NOT NULL PRIMARY KEY,
		id_country INT NOT NULL,
		designation VARCHAR(254) NOT NULL,
		date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	
	CREATE TABLE Othor(
		id_othor SERIAL NOT NULL PRIMARY KEY,
		id_country INT NOT NULL,
		first_name VARCHAR(254) NOT NULL,
		last_name VARCHAR(254) NOT NULL,
		genre VARCHAR(1) NOT NULL,
		date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK (genre='M' OR genre='F')
	);


	CREATE TABLE Client(
		id_client SERIAL NOT NULL PRIMARY KEY,
		id_country INT NOT NULL,
		first_name VARCHAR(254) NOT NULL,
		last_name VARCHAR(254) NOT NULL,
		genre VARCHAR(1) NOT NULL,
		date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK (genre='M' OR genre='F')
	);


	CREATE TABLE Ebook(
		id_ebook SERIAL NOT NULL PRIMARY KEY,
		id_home_edition INT NOT NULL,
		title VARCHAR(254) NOT NULL,
		price MONEY NOT NULL,
		number_page INT NOT NULL,
		decription TEXT NULL,
		date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK ( CAST(price AS DECIMAL) >= 1 AND  number_page >= 1)
	
	);
	
	CREATE TABLE OtherEditBook(
		id_othor INT NOT NULL,
		id_ebook INT NOT NULL,
		date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		PRIMARY KEY(id_othor, id_ebook)
	);
	
	CREATE TABLE OrderEbook(
		id_order SERIAL NOT NULL PRIMARY KEY,
		id_client INT NOT NULL,
		id_ebook INT NOT NULL,
		number_ebook INT NOT NULL,
		date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK (number_ebook >=1)
	);


	ALTER TABLE Ebook ADD COLUMN id_year INT NOT NULL;
	ALTER TABLE Ebook RENAME COLUMN decription TO description;
	ALTER TABLE Home_Edition ADD CONSTRAINT fk_country FOREIGN KEY(id_country) REFERENCES Country(id_country);
	ALTER TABLE Othor ADD CONSTRAINT fk_countrys FOREIGN KEY(id_country) REFERENCES Country(id_country);
	ALTER TABLE Client ADD CONSTRAINT fk_country_client FOREIGN KEY(id_country) REFERENCES Country(id_country);
	ALTER TABLE Ebook ADD CONSTRAINT fk_home FOREIGN KEY(id_home_edition) REFERENCES Home_Edition(id_home);
	ALTER TABLE OtherEditBook ADD CONSTRAINT fk_othor FOREIGN KEY(id_othor) REFERENCES Othor(id_othor);
	ALTER TABLE OtherEditBook ADD CONSTRAINT fk_ebook FOREIGN KEY(id_ebook) REFERENCES Ebook(id_ebook);
	ALTER TABLE OrderEbook ADD CONSTRAINT fk_ebooks FOREIGN KEY(id_ebook) REFERENCES Ebook(id_ebook);
	ALTER TABLE OrderEbook ADD CONSTRAINT fk_client FOREIGN KEY(id_client) REFERENCES Client(id_client);
	ALTER TABLE Ebook ADD CONSTRAINT fk_year FOREIGN KEY (id_year) REFERENCES Year_Published(id_year);
COMMIT;


START TRANSACTION;

INSERT INTO Country(designation) VALUES('PARIS'),('KINSHASA'),('LUBUMBASHI'),('LIKASI'),('GOMA'),('BUKAVU'),('CAMEROUN'),('COTE D''IVOIRE'),
('GABON'),('BURKINA FASO'),('EGYPTE'),('ALLEMAGNE'),('CANADA');

INSERT INTO Home_Edition(id_country,designation) VALUES(1, 'RUE DE PARIS 01'),(1, 'RUE DE LILLE 145'),(1, 'BORDEAUX SAINT VINCENT'),(1, 'NICE RUE DE JOSEPH');
INSERT INTO Home_Edition(id_country,designation) VALUES(11, 'PYRAMIDS'),(9, 'ECOLE FRANCAISE');
INSERT INTO Home_Edition(id_country,designation) VALUES(2, 'MAISON MPUENGUE'),(13, 'MAISON HENRI'),(8, 'QUIZ EBOOK'),(5, 'SQL EBOOK LINE');


SELECT * FROM Othor;

INSERT INTO Othor(id_country, first_name, last_name, genre) VALUES(10, 'KIUKA', 'HENRI', 'M'),
(12, 'MIKE', 'MUTOMBO','M'),(9, 'NSOMUE','PATIENT','M'),(9,'LUAMBA','PASCALINE','F'),(9,'KIBUNDULU','PETRONIE','F'),
(1, 'EBONDO','ADELINE', 'F'),(5,'NGOLO', 'DENISE','F'),(5, 'MBAYO', 'SALOME','F'),(9, 'KIDUDI', 'CHRISTINE', 'F');


INSERT INTO Year_Published(designation) VALUES ('1990'),('1992'),('1993'),('1994'),('1995'),('1996'),('1997'),('1998'),('1999'),('2000'),('2001'),('2002'),('2003'),('2004'),('2005'),('2006'),('2007'),('2008'),('2009'),('2010')
,('2011'),('2012'),('2013'),('2014'),('2015'),('2016'),('2017'),('2018'),('2019'),('2020'),('2021'),('2022'),('2023'),('2024') RETURNING * ;

INSERT INTO Ebook(id_home_edition, title, price, number_page, description,id_year)
VALUES(2, 'APPRENDRE LES BASES DE SQL', 85, 145, 'Avec ce cours vous allez apprendre toutes les bases du langage SQL',12),
(8, 'SQL POUR LES NULS', 74,255, 'Les compétences en bases de données est l''une les plus recherchée actuellement dans le marché de l''emploi, alors avec ce cours vous allez apprendre toutes notions nécessaires de ce langage SQL',3 ),
(10, 'LES BASES DE JAVA',25,105, 'Apprendre à créer les algo des qualités avec JAVA',15),
(8,'DYNANMISER LES SITES WEB AVEC JAVASCRIPT',63,89, 'Javascript vous permet de rendre vos pages web plus dynamique et d''améliorer l''expérience utilisteurs',1),
(6,'LES BASE DU WEB',63,145, 'Apprendre HTML & CSS à votre rythme', 15);

INSERT INTO Ebook(id_home_edition, title, price, number_page, description,id_year) 
VALUES(7, 'ALGOTRITHME',300,256,'Apprendre les bases de la programmation Informatiques', 20);


INSERT INTO OtherEditBook(id_othor, id_ebook) VALUES(1,1),(3,1),(9,3),(6, 5),(2,5),(1,2);


COMMIT;


SELECT * FROM Country WHERE id_country IN(SELECT id_country FROM Home_Edition);
SELECT * FROM Country WHERE id_country IN(SELECT id_country FROM Othor);

SELECT 
	Othor.first_name AS AUTEUR_NOM,
	Othor.last_name AS AUTEUR_PRENOM,
	Othor.genre AS AUTEUR_SEXE,
	Country.designation AS VILLE_PAYS
	FROM Country
	JOIN Othor USING(id_country);

SELECT
	Country.designation AS VILLE_PAYS,
	COUNT(Othor.id_country) AS NOMBRE_AUTEUR
	FROM Country
	JOIN Othor USING(id_country)
	GROUP BY VILLE_PAYS;


SELECT
	COALESCE(Country.designation, 'TOTAL GENERAL') AS VILLE_PAYS,
	COUNT(Othor.id_country) AS NOMBRE_AUTEUR
	FROM Country
	JOIN Othor USING(id_country)
	GROUP BY GROUPING SETS((Country.designation),())
	ORDER BY(CASE WHEN Country.designation IS NULL THEN 0 ELSE 1 END) DESC;
	
SELECT
	Othor.genre AS SEXE,
	COUNT(*) AS NOMBRE
	FROM Othor
	GROUP BY SEXE;


	
SELECT
	Country.designation AS VILLE_PAYS,
	COUNT(Othor.id_country) AS NOMBRE_AUTEUR,
	SUM(CASE WHEN Othor.genre = 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN Othor.genre = 'F' THEN 1 ELSE 0 END) AS FEMMES
	FROM Country
	JOIN Othor USING(id_country)
	GROUP BY VILLE_PAYS;


SELECT 
	Home_Edition.designation AS MAISON_EDITION,
	COUNT(Ebook.id_home_edition) AS NOMBRE_LIVRES
	FROM Home_Edition
	JOIN Ebook ON Ebook.id_home_edition=Home_Edition.id_home
	GROUP BY MAISON_EDITION;


SELECT 
	Ebook.id_ebook AS ID_LIVRE,
	Ebook.title AS TITRE_LIVRE,
	COUNT(Othor.id_othor) AS NOMBRE_AUTEUR,
	SUM(CASE WHEN Othor.genre= 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN Othor.genre= 'F' THEN 1 ELSE 0 END) AS FEMMES
	FROM Ebook
	JOIN OtherEditBook USING(id_ebook) 
	JOIN Othor USING(id_othor)
	GROUP BY ID_LIVRE,TITRE_LIVRE;
	
SELECT * FROM Ebook;


SELECT * FROM (
	SELECT 
		Ebook.title AS TITRE_LIVRES,
		Ebook.number_page AS PAGE_LIVRES,
		Year_Published.designation AS ANNEE_EDITION,
		SUM(Ebook.price) OVER(PARTITION BY Year_Published.designation) AS PARTIONNEMENT
		FROM Ebook
		JOIN Year_Published USING(id_year)
		GROUP BY TITRE_LIVRES,PAGE_LIVRES,ANNEE_EDITION,Ebook.price
	) AS TEMPO_TABLE 
	WHERE TEMPO_TABLE.PARTIONNEMENT < (SELECT price FROM Ebook WHERE id_ebook=6);
	
	
	
	
SELECT * FROM Ebook;
	
	




