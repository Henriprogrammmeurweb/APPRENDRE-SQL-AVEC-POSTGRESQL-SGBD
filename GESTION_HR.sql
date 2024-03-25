DROP TABLE Personnel;
DROP TABLE Grade;
DROP TABLE Fonction;
DROP TABLE Departement;

ROLLBACK;


START TRANSACTION;


CREATE TABLE Departement(
	id_departement SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Fonction(
	id_fonction SERIAL NOT NULL PRIMARY KEY,
	id_departement INT NULL,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE Fonction ADD CONSTRAINT fk_departement FOREIGN KEY(id_departement) REFERENCES Departement(id_departement);


CREATE TABLE Grade(
	id_grade SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Personnel(
	id_personnel SERIAL NOT NULL PRIMARY KEY,
	id_grade INT NOT NULL,
	id_fonction INT NOT NULL,
	first_name VARCHAR(254) NOT NULL,
	last_name VARCHAR(254) NOT NULL,
	genre VARCHAR(1) NOT NULL,
	date_naiss DATE NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK (genre = 'M' OR genre='F')
);

ALTER TABLE Personnel ADD CONSTRAINT fk_fonction FOREIGN KEY(id_fonction) REFERENCES Fonction(id_fonction);
ALTER TABLE Personnel ADD CONSTRAINT fk_grade FOREIGN KEY(id_grade) REFERENCES Grade(id_grade);

COMMIT;



SELECT * FROM Departement;
SELECT * FROM Fonction;
SELECT * FROM Grade;



START TRANSACTION;

INSERT INTO Departement(designation) VALUES('FINANCE'),('RESSOURES HUMAINES'),('RESSOURCES MATERIELLES'),('DIRECTION GENERALE'),
('LOGISTIQUE'),('STORE');

INSERT INTO Fonction(id_departement, designation) VALUES(1, 'CAISSIER'),(1,'COMPTABLE'),(1, 'AUDITEUR'),
(2, 'CHEF DE BUREAU'), (2,'SECRETAIRE'),(2, 'CHEF DE BUREAU ADJOINT');

INSERT INTO Grade(designation) VALUES('AG'),('ADMIN SITE'),('CADRE'),('MANEOUVRE'),('HUISSIER'), ('DG'), ('BAC+4');


COMMIT;

ROLLBACK;

SELECT * FROM Departement WHERE id_departement IN (SELECT id_departement FROM Fonction);

SELECT * FROM Departement WHERE id_departement NOT IN (SELECT id_departement FROM Fonction);

SELECT * FROM Personnel;

INSERT INTO Departement(designation) VALUES('IT');


INSERT INTO Fonction(id_departement, designation) VALUES(7, 'MANAGER IT'),(7,'DEV BACKEND'),
(7, 'DEV FRONT'),(7, 'INGENIEUR LOGICIEL'),(7, 'DATABASE MANAGER');

INSERT INTO Personnel(id_grade, id_fonction,first_name, last_name,genre)
VALUES(1,11,'KIUKA', 'HENRI', 'M'),(1,10,'KALENGA', 'MIKE', 'M');

SELECT * FROM Grade;
SELECT * FROM Fonction;

INSERT INTO Personnel (id_grade, id_fonction,first_name, last_name,genre)
VALUES(6, 4, 'CORNEILLE', 'KIBONGIE', 'M'),(1,6, 'PRINCE', 'MATUMBA', 'M');

INSERT INTO Personnel (id_grade, id_fonction,first_name, last_name,genre)
VALUES(2, 5, 'LUAMBA', 'PASCALINE', 'F'),(3,7, 'PETRONIE', 'KIBUNDULU', 'F'),
(1,5, 'PETRONIE', 'KIBUNDULU', 'F');



INSERT INTO Personnel (id_grade, id_fonction,first_name, last_name,genre, date_naiss)
VALUES(2, 2, 'SALOME', 'MBAYO', 'F', '2023-01-01');

INSERT INTO Personnel (id_grade, id_fonction,first_name, last_name,genre, date_naiss)
VALUES(2, 2, 'GEDEON', 'MUKONKOLE', 'M', '2023-01-02');

INSERT INTO Personnel (id_grade, id_fonction,first_name, last_name,genre, date_naiss)
VALUES(2, 2, 'PAULIN', 'SHESHA', 'M', '2023-12-30');

INSERT INTO Personnel (id_grade, id_fonction,first_name, last_name,genre, date_naiss)
VALUES(2, 2, 'DENISE', 'NGOLO', 'F', '2027-12-30');

INSERT INTO Personnel (id_grade, id_fonction,first_name, last_name,genre, date_naiss)
VALUES(2, 2, 'KISUAKA', 'MESCHACK', 'F', '2013-12-30');

INSERT INTO Personnel (id_grade, id_fonction,first_name, last_name,genre, date_naiss)
VALUES(2, 3, 'KASONGO', 'SHEKINAH', 'F', '2011-12-31');
INSERT INTO Personnel (id_grade, id_fonction,first_name, last_name,genre, date_naiss)
VALUES(3, 4, 'JUSTIN', 'LUMONGA', 'M', '2025-12-31');
INSERT INTO Personnel (id_grade, id_fonction,first_name, last_name,genre, date_naiss)
VALUES(4, 4, 'ALBERTINE', 'MUKONKOLE', 'F', '2026-12-31');


SELECT * FROM Fonction WHERE id_fonction IN(SELECT id_fonction FROM Personnel);
SELECT * FROM Grade WHERE id_grade IN(SELECT id_grade FROM Personnel);


SELECT 
	grade.designation AS GRADE,
	COUNT(personnel.id_grade) AS NUMBER_PERSONNEL
	FROM Personnel
	JOIN Grade USING(id_grade)
	GROUP BY ROLLUP(GRADE) ORDER BY GRADE;
	
	
SELECT 
	grade.designation AS GRADE,
	COUNT(personnel.id_grade) AS NUMBER_PERSONNEL,
	LAG(COUNT(personnel.id_grade)) OVER(ORDER BY grade.id_grade ASC) AS COMPARAISON,
	LEAD(COUNT(personnel.id_grade)) OVER(ORDER BY grade.id_grade ASC) AS COMPARAISON_2
	FROM Personnel
	JOIN Grade USING(id_grade)
	GROUP BY GRADE, grade.id_grade;	


SELECT 
	grade.designation AS GRADE,
	COUNT(personnel.id_grade) AS NUMBER_PERSONNEL,
	DENSE_RANK()
	OVER(ORDER BY COUNT(personnel.id_grade) DESC) AS CLASSEMENT
	FROM Personnel
	JOIN Grade USING(id_grade)
	GROUP BY GRADE, grade.id_grade ORDER BY NUMBER_PERSONNEL DESC;
	


SELECT * FROM Personnel;

SELECT 
	personnel.genre AS GENRE_PERSONNEL,
	COUNT(id_personnel) AS NUMBER_PERSONNEL
	FROM Personnel
	GROUP BY GENRE_PERSONNEL;
	


SELECT * FROM Personnel;


UPDATE Personnel SET date_naiss='2001-06-26' WHERE id_personnel=1;
UPDATE Personnel SET date_naiss='1997-05-13' WHERE id_personnel=2;
UPDATE Personnel SET date_naiss='1998-04-15' WHERE id_personnel=3;
UPDATE Personnel SET date_naiss='1998-12-05' WHERE id_personnel=4;
UPDATE Personnel SET date_naiss='1998-11-18' WHERE id_personnel=5;
UPDATE Personnel SET date_naiss='2000-10-12' WHERE id_personnel=6;
UPDATE Personnel SET date_naiss='2001-03-02' WHERE id_personnel=7;



SELECT 
	personnel.first_name,
	personnel.last_name,
	personnel.genre AS GENRE,
	grade.designation AS GRADE,
	fonction.designation AS FONCTION,
	personnel.date_naiss AS DATE_NAISS
	FROM Personnel
	JOIN Grade USING(id_grade)
	JOIN Fonction USING(id_fonction)
	WHERE personnel.date_naiss IS NOT NULL;
	
	

SELECT 
	personnel.first_name,
	personnel.last_name,
	personnel.genre AS GENRE,
	grade.designation AS GRADE,
	fonction.designation AS FONCTION,
	personnel.date_naiss AS DATE_NAISS
	FROM Personnel
	JOIN Grade USING(id_grade)
	JOIN Fonction USING(id_fonction)
	WHERE personnel.date_naiss IS NULL;
	
	
SELECT 
	personnel.first_name,
	personnel.last_name,
	personnel.genre AS GENRE,
	grade.designation AS GRADE,
	fonction.designation AS FONCTION,
	COALESCE(CAST(personnel.date_naiss AS VARCHAR), 'RIEN')
	FROM Personnel
	JOIN Grade USING(id_grade)
	JOIN Fonction USING(id_fonction);	
	
	
	
SELECT 
	personnel.first_name,
	personnel.last_name,
	personnel.genre AS GENRE,
	grade.designation AS GRADE,
	fonction.designation AS FONCTION,
	CASE
		WHEN personnel.date_naiss IS NULL AND Personnel.genre='M' THEN
			'HOMME RIEN'
		WHEN personnel.date_naiss IS NULL AND Personnel.genre='F' THEN
			'FEMME VIDE'
		ELSE CAST(personnel.date_naiss AS VARCHAR) END AS DATE_NAISS
	FROM Personnel
	JOIN Grade USING(id_grade)
	JOIN Fonction USING(id_fonction);	
	




SELECT 
	personnel.first_name,
	personnel.last_name,
	personnel.genre AS GENRE,
	grade.designation AS GRADE,
	fonction.designation AS FONCTION,
	personnel.date_naiss AS DATE_NAISS,
	EXTRACT(WEEK FROM date_naiss) AS SEMAINE_NAISS,
	EXTRACT(ISOYEAR FROM date_naiss) AS YEAR_FROM_ISO
	FROM Personnel
	JOIN Grade USING(id_grade)
	JOIN Fonction USING(id_fonction);



SELECT * FROM Personnel;

SELECT
	personnel.first_name AS NOM,
	personnel.last_name AS PRENOM,
	grade.designation AS GRADE,
	COUNT(personnel.id_grade),
	COUNT(personnel.id_grade) 
	OVER(PARTITION BY grade.designation)
	FROM grade
	JOIN Personnel USING(id_grade) GROUP BY GRADE, NOM, PRENOM,grade.id_grade,personnel.id_grade;

	
