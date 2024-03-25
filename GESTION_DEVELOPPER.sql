-------------------------------------CREATION DES TABLES DE LA BASE DE DONNEES------------------------------------------------------------------------

START TRANSACTION;

CREATE TABLE Country(
	id_country SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) UNIQUE NOT NULL,
	date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Year_projects(
	id_year SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) UNIQUE NOT NULL,
	date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Projects(
	id_project SERIAL NOT NULL PRIMARY KEY,
	id_year INT NOT NULL,
	designation VARCHAR(254) NOT NULL,
	description TEXT NULL,
	date_start DATE NOT NULL,
	date_end DATE NOT NULL,
	number_days INT GENERATED ALWAYS AS (date_end - date_start) STORED,
	number_developer INT NULL,
	date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK (date_start <= date_end OR number_developer <= 1)
);


CREATE TABLE Level_language(
	id_level SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Languages(
	id_language SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Projects_Language(
	id_project INT NOT NULL,
	id_language INT NOT NULL,
	date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id_project, id_language)
);

CREATE TABLE Developer(
	id_developer SERIAL NOT NULL PRIMARY KEY,
	id_country INT NOT NULL,
	first_name VARCHAR(254) NOT NULL,
	last_name VARCHAR(254) NOT NULL,
	genre VARCHAR(1) NOT NULL,
	date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK (genre='M' OR genre='F')
);

CREATE TABLE Contribution(
	id_contribution SERIAL NOT NULL PRIMARY KEY,
	id_project INT NOT NULL,
	id_developer INT NOT NULL,
	description TEXT NOT NULL,
	date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE PredilectionLanguageDeveloper(
	id_language INT NOT NULL,
	id_developer INT NOT NULL,
	id_level INT NOT NULL,
	date_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id_language, id_developer, id_level)

);


ALTER TABLE Projects_Language ADD CONSTRAINT fk_project FOREIGN KEY (id_project) REFERENCES Projects(id_project);
ALTER TABLE Projects_Language ADD CONSTRAINT fk_language FOREIGN KEY (id_language) REFERENCES Languages(id_language);
ALTER TABLE Developer ADD CONSTRAINT fk_country FOREIGN KEY (id_country) REFERENCES Country(id_country);
ALTER TABLE Contribution ADD CONSTRAINT fk_developer FOREIGN KEY (id_developer) REFERENCES Developer(id_developer);
ALTER TABLE Contribution ADD CONSTRAINT fk_projects FOREIGN KEY (id_project) REFERENCES Projects(id_project);
ALTER TABLE PredilectionLanguageDeveloper ADD CONSTRAINT fk_developers FOREIGN KEY (id_developer) REFERENCES Developer(id_developer);
ALTER TABLE PredilectionLanguageDeveloper ADD CONSTRAINT fk_languages FOREIGN KEY (id_language) REFERENCES Languages(id_language);
ALTER TABLE PredilectionLanguageDeveloper ADD CONSTRAINT fk_level FOREIGN KEY (id_level) REFERENCES Level_language(id_level);
ALTER TABLE Projects ADD CONSTRAINT fk_year FOREIGN KEY(id_year) REFERENCES Year_projects(id_year);

COMMIT;


-----------------------------------------------------------CREATION DES INDEX-----------------------------------------------------------

START TRANSACTION;

CREATE INDEX index_search_country ON Country(id_country);

CREATE INDEX index_search_info_project ON Projects(id_project,id_year,date_start,date_end);

CREATE INDEX index_search_date_start_project ON Projects(date_start);

CREATE INDEX index_search_id_project ON Projects(id_project);

CREATE INDEX index_search_year_project ON Projects(id_year);

CREATE INDEX index_search_date_end_project ON Projects(date_end);

CREATE INDEX index_search_country_developer ON Developer(id_country);

COMMIT;
---------------------------------PROCEDURES STOCKEES-----------------------------------------------------------

START TRANSACTION;

CREATE OR REPLACE PROCEDURE InsertCountry(_designation VARCHAR(254)) LANGUAGE SQL AS $$
	INSERT INTO Country(designation) VALUES(_designation);
$$;

CREATE OR REPLACE PROCEDURE UpdateCountry(_id_country INT,_designation VARCHAR(254)) LANGUAGE SQL AS $$
	UPDATE Country SET designation=_designation WHERE id_country=_id_country;
$$;

CREATE OR REPLACE PROCEDURE DeleteCountry(_id_country INT) LANGUAGE SQL AS $$
	DELETE FROM Country  WHERE id_country=_id_country;
$$;

COMMIT;


-----------------------------APPELLE DES PROCEDURES----------------------------------

CALL InsertCountry('DAN MARK');

CALL UpdateCountry(46, 'DAN MARK EUROPE');

CALL DeleteCountry(46);

SELECT * FROM Country;

------------------------------------------INSERTION DES DONNEES-------------------------------------------------------------

START TRANSACTION;

INSERT INTO Country(designation) VALUES('FRANCE'),('ALLEMAGNE'),('AFRIQUE DU SUD'),('MAURITANIE'),('GAMBIE'),('JAPON'),
('MADAGASCAR'),('BELIQUE'),('FASA BURKINA'),('ANGLETERRE'),('CANADA'),('RDC'),('CHINE'),('INDE'),('AUTRICHE'),('IRAN'),('AUSTRALIE'),
('RUSSE'),('UKRAINE'),('SUISSE'),('SUEDE'),('MOZAMBIQUE'),('BRASIL'),('URGENTINE'),('COREE DU SUD'),('CORE DU NORD'),('TUNISIE'),('COTE IVOIRE'),('GUINE EQUATORIALE'),('GUINEE BISAU'),
('GUINEE CONAKRY'),('CAMEROUN'),('MALI'),('TCHAD'),('BOTSHANA'),('LIBERIA'),('USA'),('TOGO'),('MALAWI'),('SIERRA LEONE'),('ESPAGNE'),('PORTUGAL'),('TURKEY'),('LUXEMBOURG');


INSERT INTO Developer(id_country, first_name,last_name, genre) VALUES(3, 'HENRI', 'KIUKA', 'M'),(20,'KALENGA','MIKE','M'),(40,'MATUMBA','PRINCE', 'M'),(15,'LUAMBA','PASCALINE','F'),(3,'KIAMBE','NELLY','F'),
(44,'KAZADI','RAPHAEL','M'),(1,'NGOYI', 'GILBERT','M'),(1,'KIBONGIE','CORNEILLE','M'),(15,'KIBUNDULU','PETRONIE','F'),(15,'KABAMBA','DESIRE','M'),(15,'EBONDO','ADEL','F'),(19,'FRAM','KIYENGA','M'),(20,'MPUNGUE','BLANDINE', 'F'),
(20,'MBUYU', 'MIREILLE','F'),(30, 'KIKUDI','CHRISTINE','F'),(32,'KASONGO','GEORGES','M'),(30,'KITUMBIKA', 'JULAIS','M'),(1, 'KABUNDJI', 'SALOMON','M'),(30,'NSOMUE','PATIENT', 'M'),(19,'NGONGO','PLACIDE','M'),(14,'MITANTA', 'WILLY', 'M'),
(14,'KIABU','SOUZANIE', 'F'),(14, 'KABIKA', 'MARCELINE','F'),(14, 'NKONGOLO','SIDONIE', 'F'),(11,'NYEMBO', 'URBAIN','M'),(13, 'NSANGUA', 'POLIDOR', 'M'),(13,'NTAMBUE', 'THEODOR', 'M'),(19,'YAMANKUNDA', 'DIEUM', 'M');


INSERT INTO Languages(designation) VALUES('PYTHON'),('JAVA'),('C++'),('SCALA'),('RUBY'),('HTML'),('SQL'),('CSS'),
('JAVASCRIPT'),('PHP'),('C#'),('COBOL'),('DJANGO'),('SYNFONY'),('LARAVAL'),('FLASK'),('MYSQL'),('POSTGRESQL'),('SQL SERVER'),('POWER BI'),('C'),
('AJAX'),('JQUERY'),('GIT'),('GITHUB');


INSERT INTO Year_projects(designation) VALUES('2001'),('2002'),('2003'),
('2004'),('2005'),('2006'),('2007'),('2008'),('2009'),('2010'),('2011'),('2012'),('2013'),('2014'),
('2015'),('2016'),('2017'),('2018'),('2019'),('2020'),('2021'),('2022'),('2023'),('2024');


INSERT INTO Projects(designation, description,date_start,date_end,number_developer, id_year)
VALUES('INITIATION A LA PROGRAMMATION', 'Au cour de ce projet l objectif principal est de passer à l initiation des juniors à la Programmation Python', '2024-01-01','2024-01-25',4, 1);


INSERT INTO Projects(designation, description,date_start,date_end,number_developer, id_year)
VALUES('LA PROGRAMMATION FONCTIONNELLE EN PYTHON', 'Au cour de ce projet l objectif principal est de montrer aux débutants comment créeer une fonction,pourquoi les fonctions dans l ecriture de son code', '2024-03-25','2024-07-21',8, 1);

INSERT INTO Projects(designation, description,date_start,date_end,number_developer, id_year)
VALUES('LA PROGRAMMATION ORIENTEE OBJET EN PYTHON', 'Au cour de ce projet l objectif principal est de montrer aux débutants l utiliser de la programmation orientée objet dans le developpement Logiciel', '2023-11-02','2023-12-31',9, 1);


INSERT INTO Projects(designation, description,date_start,date_end,number_developer, id_year)
VALUES('LA PROGRAMMATION JAVA', 'Declaration des variables', '2013-04-25','2013-10-21',30, 13);

INSERT INTO Projects(designation, description,date_start,date_end,number_developer, id_year)
VALUES('LA PROGRAMMATION JAVA', 'Les structures de contrôle en JAVA', '2013-10-25','2013-10-29',25, 13);



SELECT * FROM Year_projects;

INSERT INTO Projects_Language(id_project,id_language) VALUES(3,1);

INSERT INTO Level_language(designation) VALUES('DEBUTANT'),('INTERMEDIAIRE'),('AVANCE');

INSERT INTO Contribution(id_project, id_developer,description) VALUES(3, 1,'Pour déclarer une variable en Python la syntaxe est a=5');
INSERT INTO Contribution(id_project, id_developer,description) VALUES(3, 1,'Pour mettre les commentaires sur une seule ligne dans un code Python la syntaxe est : #Commentaire');
INSERT INTO Contribution(id_project, id_developer,description) VALUES(3, 1,'Pour mettre les commentaires sur plusieurs lignes dans un code Python la syntaxe est : """ Commentaire """');
INSERT INTO Contribution(id_project, id_developer,description) VALUES(3, 1,'Pour mettre un commentaire dans un code python: print(ma_variable)');


INSERT INTO PredilectionLanguageDeveloper(id_developer, id_language,id_level)
VALUES(1,1,3),(1,7,2);

INSERT INTO PredilectionLanguageDeveloper(id_developer, id_language,id_level)
VALUES(1,6,3);

INSERT INTO PredilectionLanguageDeveloper(id_developer, id_language,id_level)
VALUES(15,2,2),(23,1,1),(4,8,3),(10,11,1),(10,21,2),(9,20,3),(12,10,1);

INSERT INTO PredilectionLanguageDeveloper(id_developer, id_language,id_level)
VALUES(8,1,1);

COMMIT;

------------------------------------------------POINT DE SAUVEGARDE------------------------------------------------

SELECT * FROM Projects;

START TRANSACTION;
		
	UPDATE Projects SET number_developer = number_developer - 5 WHERE id_project=4;
	SAVEPOINT first_savepoint;
	
	UPDATE Projects SET number_developer = number_developer + 5 WHERE id_project=3;
	SAVEPOINT second_savepoint;
	
	ROLLBACK TO first_savepoint;
		
	UPDATE Projects SET number_developer = number_developer + 5 WHERE id_project=5;
	SAVEPOINT three_savepoint;
	
COMMIT;

------------------------------------------------AFFICHAGE ET GROUPEMENT DES DONNEES ET FONCTION DES FENETRAGES ------------------------------------

SELECT * FROM Developer;
SELECT * FROM Projects;
SELECT * FROM Contribution;
SELECT * FROM PredilectionLanguageDeveloper;
SELECT * FROM Level_language;

SELECT 
	Country.designation AS COUNTRYS,
	COUNT(Developer.id_developer) AS NUMBER_DEVELOPER
	FROM Country
	JOIN Developer USING(id_country)
	GROUP BY COUNTRYS;

SELECT 
	Country.designation AS COUNTRYS,
	COUNT(contribution.id_contribution) AS NUMBER_CONTRIBUTION
	FROM Contribution
	JOIN Developer USING(id_developer)
	JOIN Country USING(id_country)
	GROUP BY COUNTRYS;
	

SELECT
	Developer.first_name AS NOM,
	Developer.last_name AS PRENOM,
	Developer.genre AS SEXE,
	Country.designation AS PAYS,
	COUNT(DISTINCT(Languages.id_language)) AS NB_LANGUAGE_PREDILECTION,
	COUNT(DISTINCT(Contribution.id_contribution)) AS NB_CONTRIBUTION
	FROM Developer
	JOIN Country USING(id_country)
	LEFT JOIN Contribution USING(id_developer)
	LEFT JOIN PredilectionLanguageDeveloper USING(id_developer)
	LEFT JOIN Languages USING(id_language)
	GROUP BY NOM,PRENOM,SEXE,PAYS;
	
	
SELECT
	COALESCE(Languages.designation,'TOTAL GENERAL') AS LANGAGE_FRAMEWORK,
	COALESCE(Level_language.designation, '-') AS NIVEAU,
	COUNT(PredilectionLanguageDeveloper.id_language) AS NUMBER_DEVELOPER
	FROM PredilectionLanguageDeveloper
	JOIN Languages USING(id_language)
	JOIN Level_language USING(id_level)
	GROUP BY GROUPING SETS((Languages.designation,Level_language.designation),()) ORDER BY LANGAGE_FRAMEWORK;

SELECT
	Level_language.designation AS NIVEAU,
	COUNT(PredilectionLanguageDeveloper.id_level) AS NOMBRE_DEVELOPPEUR,
	LAG(COUNT(PredilectionLanguageDeveloper.id_level),2,0) OVER(ORDER BY PredilectionLanguageDeveloper.id_level) AS COMPARAISON,
	DENSE_RANK()
	OVER(ORDER BY COUNT(PredilectionLanguageDeveloper.id_level) ASC) AS CLASSEMENT
	FROM PredilectionLanguageDeveloper
	JOIN Level_language USING(id_level)
	GROUP BY NIVEAU,PredilectionLanguageDeveloper.id_level;
	

SELECT 
	Year_projects.designation AS ANNEES,
	SUM(Projects.number_developer) AS NOMBRE_DEVELOPPEURS,
	COUNT(Projects.id_year) AS NOMBRE_PROJET
	FROM Projects
	JOIN Year_projects USING(id_year)
	GROUP BY ANNEES;


-----------------------------------------------LES SOUS REQUETES------------------------------------------------------------------------------

SELECT * FROM Languages WHERE id_language IN(SELECT id_language FROM PredilectionLanguageDeveloper);

SELECT * FROM Projects;
SELECT * FROM Projects WHERE number_developer < (SELECT MAX(number_developer) FROM Projects) AND date_start BETWEEN '2024-01-01' AND '2024-02-25';
	
	
SELECT * FROM Projects;
SELECT * FROM Contribution;

SELECT * FROM (
	SELECT
		Projects.id_project AS ID_PROJETS,
		Projects.designation AS PROJETS,
		Projects.description AS DESCRIPTION_PROJETS,
		Projects.date_start AS DATE_DEBUT,
		Projects.date_end AS DATE_FIN,
		Projects.number_days AS NOMBRE_JOURS,
		Year_projects.designation AS ANNEES,
		SUM(Projects.number_developer) AS NOMBRE_DEV,
		SUM(Projects.number_developer) 	OVER(PARTITION BY Year_projects.designation) AS PARTIONNEMENT_TOTAL
		FROM Projects
		JOIN Year_projects USING(id_year)
		GROUP BY ID_PROJETS,PROJETS,DESCRIPTION_PROJETS,DATE_DEBUT,DATE_FIN,NOMBRE_JOURS,ANNEES,Projects.number_developer
) AS TEMPO_TABLE WHERE TEMPO_TABLE.PARTIONNEMENT_TOTAL < (SELECT number_developer FROM Projects WHERE id_project=4) AND TEMPO_TABLE.id_projets IN(SELECT id_project FROM Contribution);

	
SELECT 
	Projects.designation AS PROJETS,
	Contribution.description AS DESCRIPTIONS
	FROM Contribution
	JOIN Projects USING(id_project)
	WHERE Projects.id_project IN(SELECT id_project FROM Contribution WHERE contribution.id_project=3) 
	ORDER BY Contribution.date_created DESC LIMIT 1;
	
	
SELECT * FROM Projects
	WHERE id_project = (SELECT id_project FROM Contribution ORDER BY date_created DESC LIMIT 1);
	
	
	

	
---------------------------------------AFFICHE LES NOMBRES DES HOMMES & DES FEMMES DEVELOPERS PAR PAYS--------------------------------

SELECT * FROM Country;

SELECT * FROM Country WHERE id_country IN(SELECT id_country FROM Developer);

EXPLAIN SELECT 
	Country.id_country AS ID_PAYS,
	Country.designation AS PAYS,
	SUM(CASE WHEN Developer.genre='M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN Developer.genre='F' THEN 1 ELSE 0 END) AS FEMMES
	FROM Country
	JOIN Developer USING(id_country)
	GROUP BY GROUPING SETS(( ID_PAYS,PAYS), ()) ORDER BY PAYS;
	
	
SELECT * FROM developer WHERE id_country=14;

SELECT * FROM Contribution;
SELECT * FROM Developer;


INSERT INTO Contribution(id_project,id_developer,description) VALUES(3,5,'x=10 est la syntaxe de déclaration d''une variable');

INSERT INTO Contribution(id_project,id_developer,description) VALUES(5,14,'Pour chaque voyage donné par son numéro et son
nom, donner le numéro');


SELECT
	ROW_NUMBER() OVER(ORDER BY projects.designation) AS N°,
	COALESCE(projects.designation, 'TOTAL GENERAL') AS PROJETS,
	SUM(CASE WHEN Developer.genre= 'M' THEN 1 ELSE 0 END) AS CONTRIBUTION_HOMMES,
	SUM(CASE WHEN Developer.genre= 'F' THEN 1 ELSE 0 END) AS CONTRIBUTION_FEMMES,
	SUM(CASE WHEN Developer.genre= 'M' THEN 1 ELSE 0 END) + SUM(CASE WHEN Developer.genre= 'F' THEN 1 ELSE 0 END) AS SOUS_TOTAL
	FROM Contribution
	JOIN Projects USING(id_project)
	JOIN Developer USING(id_developer)
	GROUP BY GROUPING SETS((projects.designation),()) ORDER BY(CASE WHEN projects.designation IS NOT NULL THEN 1 ELSE 0 END) DESC;
	
	
	
	
SELECT
	projects.designation AS PROJETS,
	COUNT(Contribution.id_contribution) AS NOMBRE_CONRIBUTION,
	LAG(COUNT(Contribution.id_contribution),2,0) OVER(ORDER BY projects.designation) AS COMPARAISON_LAG
	FROM Contribution
	JOIN Projects USING(id_project)
	GROUP BY projects.designation;
	
	
SELECT
	projects.designation AS PROJETS,
	COUNT(Contribution.id_contribution) AS NOMBRE_CONRIBUTION,
	LEAD(COUNT(Contribution.id_contribution),2,0) OVER(ORDER BY projects.designation) AS COMPARAISON_LEAD
	FROM Contribution
	JOIN Projects USING(id_project)
	GROUP BY projects.designation;
	
	

SELECT
	Projects.designation AS PROJECTS,
	COUNT(Contribution.id_contribution) AS NOMBRE_CONRIBUTION,
	DENSE_RANK()
	OVER(ORDER BY COUNT(Contribution.id_contribution) DESC) AS CLASSEMENT
	FROM Contribution
	JOIN Projects USING(id_project)
	GROUP BY projects.designation;
	

SELECT
	Projects.designation AS PROJECTS,
	COUNT(Contribution.id_contribution) AS NOMBRE_CONRIBUTION,
	NTILE(2)
	OVER(ORDER BY COUNT(Contribution.id_contribution) DESC) AS GROUPEMENT
	FROM Contribution
	JOIN Projects USING(id_project)
	GROUP BY projects.designation;
	
	

SELECT * FROM Languages;
	
SELECT * FROM Languages WHERE id_language IN(SELECT id_language FROM PredilectionLanguageDeveloper);


SELECT 
	COALESCE(CAST(Languages.id_language AS VARCHAR), '-') AS ID_LANGAGE_TECHNO,
	COALESCE(Languages.designation, 'TOTAL GENERAL') AS LANGAGE_TECHNO,
	SUM(CASE WHEN developer.genre = 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN developer.genre = 'F' THEN 1 ELSE 0 END) AS FEMMES,
	SUM(CASE WHEN developer.genre = 'M' THEN 1 ELSE 0 END) + SUM(CASE WHEN developer.genre= 'F' THEN 1 ELSE 0 END) AS SOUS_TOTAL
	FROM Languages
	JOIN PredilectionLanguageDeveloper USING(id_language)
	JOIN Developer USING(id_developer)
	GROUP BY GROUPING SETS((Languages.id_language, Languages.designation), ())
	ORDER BY (CASE WHEN Languages.designation IS NOT NULL THEN 1 ELSE 0 END,
			 CASE WHEN Languages.id_language IS NOT NULL THEN 1 ELSE 0 END) DESC;





SELECT 
	COALESCE(CAST(Languages.id_language AS VARCHAR), '-') AS ID_LANGAGE_TECHNO,
	COALESCE(Languages.designation, 'TOTAL GENERAL') AS LANGAGE_TECHNO,
	SUM(CASE WHEN developer.genre = 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN developer.genre = 'F' THEN 1 ELSE 0 END) AS FEMMES,
	SUM(CASE WHEN developer.genre = 'M' THEN 1 ELSE 0 END) + SUM(CASE WHEN developer.genre= 'F' THEN 1 ELSE 0 END) AS SOUS_TOTAL
	FROM Languages
	LEFT JOIN PredilectionLanguageDeveloper USING(id_language)
	LEFT JOIN Developer USING(id_developer)
	GROUP BY GROUPING SETS((Languages.id_language, Languages.designation), ())
	ORDER BY (CASE WHEN Languages.designation IS NOT NULL THEN 1 ELSE 0 END,
			 CASE WHEN Languages.id_language IS NOT NULL THEN 1 ELSE 0 END) DESC;



SELECT * FROM  Developer
	JOIN PredilectionLanguageDeveloper USING(id_developer)
	WHERE  PredilectionLanguageDeveloper.id_language=2;


SELECT * FROM PredilectionLanguageDeveloper;
	

SELECT
	Level_language.id_level AS ID_NIVEAUX,
	Level_language.designation AS NIVEAUX,
	SUM(CASE WHEN Developer.genre = 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN Developer.genre = 'F' THEN 1 ELSE 0 END) AS FEMMES
	FROM Level_language
	JOIN PredilectionLanguageDeveloper USING(id_level)
	JOIN Developer USING(id_developer)
	GROUP BY ID_NIVEAUX,NIVEAUX;
	
	
SELECT * FROM Developer WHERE id_developer IN(SELECT id_developer FROM PredilectionLanguageDeveloper WHERE id_level=3);

SELECT * FROM PredilectionLanguageDeveloper;


