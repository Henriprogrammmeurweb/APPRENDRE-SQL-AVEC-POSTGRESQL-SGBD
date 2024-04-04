---TABLES : EMPLOYE,GRADE,DEPARTEMENT...................................

/*DROP TABLE Grade CASCADE;
DROP TABLE Departement CASCADE;
DROP TABLE Employe CASCADE;

ROLLBACK;*/

START TRANSACTION;

	CREATE TABLE Grade(
		id_grade SERIAL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE Departement(
		id_departement SERIAL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE Employe(
		id_employe SERIAL PRIMARY KEY,
		id_departement INT NOT NULL,
		id_grade INT NOT NULL,
		nom VARCHAR(254) NOT NULL,
		postnom VARCHAR(254) NOT NULL,
		prenom VARCHAR(254) NOT NULL,
		sexe VARCHAR(1) NOT NULL,
		personne_en_charge INT NOT NULL,
		date_naissance DATE NULL,
		salaire MONEY NULL,
		prime MONEY NULL,
		salaire_total MONEY GENERATED ALWAYS AS (salaire + prime) STORED,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK (sexe = 'M' OR sexe = 'F' AND personne_en_charge >= 0)
	);
	
	CREATE TABLE Annee(
		id_annee SERIAL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL UNIQUE,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE Mission(
		id_mission SERIAL PRIMARY KEY,
		id_annee INT NOT NULL,
		titre VARCHAR(254) NOT NULL,
		description TEXT NULL,
		date_debut DATE NOT NULL,
		date_fin DATE NOT NULL,
		cout MONEY NOT NULL,
		nombre_personne  INT NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE Affectation(
		id_mission INT NOT NULL,
		id_employe INT NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		PRIMARY KEY(id_mission, id_employe)
	);

	ALTER TABLE Mission ADD CONSTRAINT fk_date CHECK (date_debut <= date_fin);
	ALTER TABLE Mission ADD CONSTRAINT fk_cout CHECK (cout >= 0::MONEY);
	ALTER TABLE Mission ADD COLUMN Nombre_jours INT GENERATED ALWAYS AS (date_fin - date_debut) STORED;
	ALTER TABLE Mission ADD CONSTRAINT fk_nombre_personne CHECK (nombre_personne >= 0);
	ALTER TABLE Employe ADD CONSTRAINT fk_grade FOREIGN KEY (id_grade) REFERENCES Grade(id_grade);
	ALTER TABLE Employe ADD CONSTRAINT fk_departement FOREIGN KEY (id_departement) REFERENCES Departement(id_departement);
	ALTER TABLE Mission ADD CONSTRAINT fk_annee FOREIGN KEY(id_annee) REFERENCES Annee(id_annee);
	ALTER TABLE Affectation ADD CONSTRAINT fk_mission FOREIGN KEY(id_mission) REFERENCES Mission(id_mission);
	ALTER TABLE Affectation ADD CONSTRAINT fk_employe FOREIGN KEY(id_employe) REFERENCES Employe(id_employe);
	
	

COMMIT;



START TRANSACTION;

INSERT INTO Grade(designation) VALUES('LICIENCE'),('MASTER'), ('DIPLOME D6'), ('GRADUE'),('OUVRIER'),('CHEF DE BUREAU'),('COMPTABLE'),
										('CAISSIER'),('ETUDIANT'),('STAGIAIRE');

INSERT INTO Departement(designation) VALUES ('IT'),('RH'),('RM'),('FINANCE'),('LOGISTIQUE'),('SECURITE'),('DG'),
											('SECREATARIAT'),('HYGIENE');

INSERT INTO Employe(id_departement, id_grade, nom, postnom, prenom, sexe, salaire, personne_en_charge, date_naissance)
VALUES(1, 2, 'KIUKA', 'MBAYO', 'HENRI', 'M', 25000, 3, '2001-06-26'), (1, 2, 'KALENGA', 'MUTOMBO', 'MIKE', 'M', 25000, 2, '1999-01-05'),
(1, 1, 'LUAMBA', 'NGOYI', 'PASCALINE', 'M', 18000, 5, '2000-02-25'),(1,4, 'MATUMBA', 'KAPENGA', 'PRINCE', 'M', 15000,3, '1999-12-25'),
(2, 3, 'KISUAKA', 'MBAYO', 'GAUIS', 'M', 12500, 6, '2005-01-30'),(1, 2, 'KABEYA', 'KAZADI', 'MARCEL', 'M', 2500, 3, '1999-02-25'),
(2, 3, 'KIABU', 'YAMPUA', 'PASCAL', 'M', 16000, 3, '2005-01-25'),(7, 1, 'EBONDO', 'MBAYO', 'PIERRE', 'M', 15000, 5, '2000-01-23'),
(7, 3, 'BIADI', 'BUKULA', 'RIDEL', 'F', 15000, 2, '1998-01-04'),(7, 2, 'LUMONGA', 'LUMONGA', 'SIMON', 'M', 25000, 8, '1990-01-14'),
(4, 9, 'KABIKA', 'MBETA', 'MARCELINE', 'F', 12500, 0, '1998-05-05'),(3,4, 'KAZADI', 'NGONGO', 'RACHEL', 'M', 3500, 1, '1996-01-28'),
(3, 5, 'KITENGIE', 'LUMAMI', 'GERMAIN', 'M', 3000, 1, '1997-01-25'),(3,5, 'KIABU', 'NSOMUE','SOUZANIE', 'F', 3500, 0, '1997-01-13'),
(5, 10, 'MBAYO', 'KIUKA', 'SALOMON', 'M', 1500, 0, '2024-02-14'),(5, 7, 'MBELE', 'BINGI', 'DELPHINE CHLOE', 'F', 2500, 1, '2014-01-26'),
(9, 2, 'KAKUNDI', 'BINGI', 'MANASSE CLOVIS', 'M', 16000, 0, '2020-08-14'),(1, 3, 'Doe', 'John', 'Doe', 'M', 30000, 2, '1990-05-15'),(2, 5, 'Smith', 'Jane', 'Smith', 'F', 35000, 3, '1985-08-22'),(3, 2, 'Johnson', 'Michael', 'Johnson', 'M', 28000, 1, '1982-11-10'),
(4, 7, 'Williams', 'Emily', 'Williams', 'F', 40000, 4, '1995-02-28'),(5, 4, 'Brown', 'David', 'Brown', 'M', 32000, 2, '1988-04-03'),(1, 2, 'Doe', 'John', 'Doe', 'M', 30000, 2, '1990-05-15'),(2, 3, 'Smith', 'Jane', 'Smith', 'F', 35000, 3, '1985-08-22'),(3, 4, 'Johnson', 'Michael', 'Johnson', 'M', 28000, 1, '1982-11-10'),
(4, 5, 'Williams', 'Emily', 'Williams', 'F', 40000, 4, '1995-02-28'),(5, 6, 'Brown', 'David', 'Brown', 'M', 32000, 2, '1988-04-03'),
(1, 3, 'Taylor', 'Emma', 'Taylor', 'F', 38000, 3, '1991-09-18'),(2, 4, 'Martinez', 'Daniel', 'Martinez', 'M', 31000, 2, '1987-07-12'),
(3, 5, 'Anderson', 'Olivia', 'Anderson', 'F', 37000, 4, '1993-03-26'),(4, 6, 'Thomas', 'James', 'Thomas', 'M', 33000, 1, '1986-06-08'),
(5, 7, 'Harris', 'Sophia', 'Harris', 'F', 39000, 3, '1990-12-05'),(1, 4, 'Lee', 'Alexander', 'Lee', 'M', 29000, 2, '1984-01-31'),
(2, 5, 'Walker', 'Mia', 'Walker', 'F', 36000, 4, '1992-10-14'),(3, 6, 'Perez', 'Ethan', 'Perez', 'M', 34000, 3, '1989-02-07'),
(4, 7, 'Hall', 'Isabella', 'Hall', 'F', 41000, 2, '1994-07-23'),
(5, 8, 'Young', 'Ava', 'Young', 'F', 38000, 1, '1983-05-19'),
(1, 5, 'Allen', 'Elijah', 'Allen', 'M', 37000, 3, '1991-11-09'),
(2, 6, 'King', 'Benjamin', 'King', 'M', 32000, 2, '1988-08-16'),
(3, 7, 'Wright', 'Madison', 'Wright', 'F', 40000, 4, '1995-04-02'),
(4, 8, 'Lopez', 'Gabriel', 'Lopez', 'M', 35000, 1, '1987-06-25'),
(5, 9, 'Hill', 'Natalie', 'Hill', 'F', 42000, 3, '1992-12-20'),
(1, 6, 'Scott', 'Nathan', 'Scott', 'M', 33000, 2, '1989-03-15'),
(2, 7, 'Green', 'Samantha', 'Green', 'F', 41000, 4, '1994-08-30'),
(3, 8, 'Adams', 'Logan', 'Adams', 'M', 38000, 3, '1990-01-25'),
(4, 9, 'Baker', 'Aiden', 'Baker', 'M', 36000, 1, '1985-04-07'),
(5, 10, 'Gonzalez', 'Chloe', 'Gonzalez', 'F', 43000, 2, '1993-09-10'),
(1, 7, 'Miller', 'Avery', 'Miller', 'M', 34000, 2, '1989-06-20'),
(2, 8, 'Turner', 'Hannah', 'Turner', 'F', 42000, 4, '1994-01-07'),
(3, 9, 'Cook', 'Evelyn', 'Cook', 'F', 39000, 3, '1990-04-12'),
(4, 10, 'Cooper', 'Wyatt', 'Cooper', 'M', 37000, 1, '1986-09-05'),
(5, 1, 'Stewart', 'Henry', 'Stewart', 'M', 44000, 2, '1993-02-18'),
(1, 8, 'Morris', 'Addison', 'Morris', 'F', 43000, 4, '1992-07-30'),
(2, 9, 'Murphy', 'Scarlett', 'Murphy', 'F', 40000, 3, '1987-11-23'),
(3, 10, 'Rivera', 'Luke', 'Rivera', 'M', 38000, 2, '1984-08-15'),
(4, 1, 'Gray', 'Nora', 'Gray', 'F', 45000, 1, '1991-03-03'),
(5, 2, 'James', 'Liam', 'James', 'M', 47000, 4, '1996-06-28'),
(1, 9, 'West', 'Aria', 'West', 'F', 44000, 3, '1990-10-25'),
(2, 10, 'Brooks', 'Mason', 'Brooks', 'M', 39000, 2, '1988-05-13'),
(3, 1, 'Kelly', 'Ella', 'Kelly', 'F', 46000, 1, '1983-12-08'),
(4, 2, 'Sanders', 'Levi', 'Sanders', 'M', 48000, 4, '1997-09-21'),
(5, 3, 'Price', 'Nathan', 'Price', 'M', 40000, 3, '1992-02-14'),
(1, 10, 'Long', 'Landon', 'Long', 'M', 40000, 2, '1987-04-19'),
(2, 1, 'Foster', 'Camila', 'Foster', 'F', 47000, 4, '1996-01-05'),
(3, 2, 'Barnes', 'Brooklyn', 'Barnes', 'F', 45000, 3, '1991-06-22'),
(4, 3, 'Ross', 'Nicholas', 'Ross', 'M', 42000, 1, '1986-11-16'),
(5, 4, 'Perry', 'Zoe', 'Perry', 'F', 49000, 2, '1981-08-11'),
(1, 1, 'Butler', 'Grayson', 'Butler', 'M', 43000, 4, '1995-05-07'),
(2, 2, 'Simmons', 'Amelia', 'Simmons', 'F', 48000, 3, '1990-10-02'),
(3, 3, 'Coleman', 'Jackson', 'Coleman', 'M', 46000, 2, '1988-03-29'),
(4, 4, 'Jenkins', 'Penelope', 'Jenkins', 'F', 44000, 1, '1983-02-12'),
(5, 5, 'Griffin', 'Emma', 'Griffin', 'F', 50000, 4, '1998-07-26'),
(1, 6, 'Watson', 'Eleanor', 'Watson', 'F', 42000, 3, '1991-08-14'),
(2, 7, 'Garcia', 'Eli', 'Garcia', 'M', 47000, 4, '1996-03-29'),
(3, 8, 'Collins', 'Audrey', 'Collins', 'F', 49000, 2, '1988-12-24'),
(4, 9, 'Russell', 'Sebastian', 'Russell', 'M', 45000, 1, '1983-07-09'),
(5, 10, 'Griffin', 'Emma', 'Griffin', 'F', 52000, 3, '1992-04-02'),
(1, 1, 'Butler', 'Grayson', 'Butler', 'M', 43000, 2, '1986-01-18'),
(2, 2, 'Simmons', 'Amelia', 'Simmons', 'F', 48000, 4, '1991-05-03'),
(3, 3, 'Coleman', 'Jackson', 'Coleman', 'M', 46000, 3, '1988-10-17'),
(4, 4, 'Jenkins', 'Penelope', 'Jenkins', 'F', 44000, 1, '1983-09-12'),
(5, 5, 'Griffin', 'Emma', 'Griffin', 'F', 50000, 2, '1998-06-27'),
(1, 6, 'Watson', 'Eleanor', 'Watson', 'F', 42000, 3, '1991-08-14'),
(2, 7, 'Garcia', 'Eli', 'Garcia', 'M', 47000, 4, '1996-03-29'),
(3, 8, 'Collins', 'Audrey', 'Collins', 'F', 49000, 2, '1988-12-24'),
(4, 9, 'Russell', 'Sebastian', 'Russell', 'M', 45000, 1, '1983-07-09'),
(5, 10, 'Bailey', 'Abigail', 'Bailey', 'F', 51000, 3, '1992-04-02'),
(1, 1, 'Taylor', 'Eli', 'Taylor', 'M', 43000, 2, '1986-01-18'),
(2, 2, 'Adams', 'Amelia', 'Adams', 'F', 48000, 4, '1991-05-03'),
(3, 3, 'Martinez', 'Jackson', 'Martinez', 'M', 46000, 3, '1988-10-17');



INSERT INTO Annee(designation) VALUES('2001'),('2002'),('2003'),('2004'),('2005'),('2006'),('2007'),
('2008'),('2009'),('2010'),('2011'),('2012'),('2013'),('2014'),('2015'),('2016'),('2017'),('2018'),('2019'),
('2020'),('2021'),('2022'),('2023'),('2024');


INSERT INTO Mission(id_annee, titre, description, date_debut, date_fin, cout, nombre_personne) VALUES(15, 'INFORMATISATION', 'Pour cette mission  l''objectif est de créer une plateformz pour votre entreprise', '2015-01-25', '2015-05-25', 8500, 10),
(1, 'AUDIT', 'Cette mission a pour objectif de suivre les fonds qui ont été financé par OMS', '2001-12-30', '2002-02-03', 16000, 5) RETURNING *;


COMMIT;



SELECT * FROM Employe;
SELECT * FROM Mission;

SELECT * FROM Employe WHERE id_employe = 70;
SELECT * FROM Employe WHERE sexe = 'M';
SELECT * FROM Employe WHERE sexe = 'F';

SELECT MAX(salaire) FROM Employe;
SELECT MIN(salaire) FROM Employe;
SELECT MIN(personne_en_charge) FROM Employe;
SELECT MAX(personne_en_charge) FROM Employe;



SELECT 
	nom,postnom,prenom,sexe,
	Departement.designation AS DEPARTEMENTS,
	Grade.designation AS GRADES,
	salaire,
	personne_en_charge,
	date_naissance
	FROM Employe
	JOIN Departement USING(id_departement)
	JOIN Grade USING(id_grade) 
	ORDER BY nom;
	

SELECT 
	nom,postnom,prenom,sexe,
	Departement.designation AS DEPARTEMENTS,
	Grade.designation AS GRADES,
	salaire::DECIMAL,
	personne_en_charge,
	EXTRACT(YEAR FROM date_naissance) ANNEE_NAISSANCE
	FROM Employe
	JOIN Departement USING(id_departement)
	JOIN Grade USING(id_grade) 
	ORDER BY nom;
	
	
	

SELECT 
	Departement.designation AS DEPARTEMENTS,
	COUNT(Employe.id_employe) AS NOMBRE_EMPLOOYE,
	SUM(Employe.salaire) AS SALAIRES_EMPLOYE
	FROM Employe
	JOIN Departement USING(id_departement)
	GROUP BY DEPARTEMENTS;
	

SELECT 
	Departement.designation AS DEPARTEMENTS,
	SUM(CASE WHEN Employe.sexe = 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) AS FEMMES,
	COUNT(Employe.id_employe) AS NOMBRE_EMPLOOYE,
	SUM(Employe.salaire) AS SALAIRES_EMPLOYE
	FROM Employe
	JOIN Departement USING(id_departement)
	GROUP BY DEPARTEMENTS;
	
	
SELECT 
	Departement.designation AS DEPARTEMENTS,
	SUM(CASE WHEN Employe.sexe = 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) AS FEMMES,
	COUNT(Employe.id_employe) AS TOTAL_EMPLOOYE,
	SUM(CASE WHEN Employe.sexe = 'M' THEN Employe.salaire ELSE 0::MONEY END) SALAIRE_HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN Employe.salaire ELSE 0::MONEY END) SALAIRE_FEMMES,
	SUM(Employe.salaire) AS SALAIRES_EMPLOYE
	FROM Employe
	JOIN Departement USING(id_departement)
	GROUP BY DEPARTEMENTS;
	

SELECT 
	COALESCE(Departement.designation, 'TOTAL GENERAL') AS DEPARTEMENTS,
	SUM(CASE WHEN Employe.sexe = 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) AS FEMMES,
	COUNT(Employe.id_employe) AS TOTAL_EMPLOOYE,
	SUM(CASE WHEN Employe.sexe = 'M' THEN Employe.salaire::DECIMAL ELSE 0::DECIMAL END) SALAIRE_HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN Employe.salaire::DECIMAL ELSE 0::DECIMAL END) SALAIRE_FEMMES,
	SUM(Employe.salaire::DECIMAL) AS SALAIRES_EMPLOYE
	FROM Employe
	JOIN Departement USING(id_departement)
	GROUP BY ROLLUP(Departement.designation)
	ORDER BY DEPARTEMENTS;	
	
	

SELECT * FROM Employe WHERE id_departement = 7;
SELECT SUM(salaire) FROM Employe;


SELECT 
	Departement.designation AS DEPARTEMENTS,
	SUM(Employe.salaire) AS NOMBRE_EMPLOOYE
	FROM Employe
	JOIN Departement USING(id_departement)
	GROUP BY DEPARTEMENTS;
	
SELECT 
	Departement.designation AS DEPARTEMENTS,
	COALESCE(SUM(Employe.salaire), 0::MONEY) AS NOMBRE_EMPLOOYE
	FROM Employe
	RIGHT JOIN Departement USING(id_departement)
	GROUP BY DEPARTEMENTS;


-----------------------------------------------------SOUS REQUETES-------------------------------------------------------------------------------------


SELECT * FROM Departement WHERE id_departement IN(SELECT id_departement FROM Employe);
SELECT * FROM Departement WHERE id_departement NOT IN(SELECT id_departement FROM Employe);

SELECT * FROM Employe WHERE salaire = (SELECT MAX(salaire) FROM Employe);
SELECT * FROM Employe WHERE salaire = (SELECT MIN(salaire) FROM Employe);


SELECT * FROM Employe;

SELECT * FROM Annee;

SELECT 
	nom,postnom,prenom,sexe,
	Departement.designation AS DEPARTEMENTS,
	Grade.designation AS GRADES,
	salaire,
	personne_en_charge,
	date_naissance
	FROM Employe
	JOIN Departement USING(id_departement)
	JOIN Grade USING(id_grade)
	WHERE id_grade = (SELECT id_grade 
					  		FROM Employe 
					  		WHERE id_employe = 1) 
							AND id_departement = (SELECT id_departement FROM Employe WHERE id_employe = 1)
							ORDER BY nom;




SELECT * FROM Employe WHERE id_employe = 15;
SELECT * FROM Employe WHERE id_employe = 9;

UPDATE Employe SET salaire = (
	CASE
		WHEN salaire = 1500::MONEY THEN salaire + 500::MONEY
		WHEN salaire = 15000::MONEY THEN salaire - 5000::MONEY
		WHEN Salaire = 12500::MONEY THEN salaire - 2500::MONEY
		ELSE salaire
	END
);


--------------------------WITH----------------------------------



WITH all_person AS (
	SELECT 
	id_departement,
	SUM(salaire) AS SALAIRE_P
	FROM Employe
	GROUP BY id_departement
), grande_somme_dep AS (
	SELECT id_departement FROM all_person WHERE  SALAIRE_P = (SELECT MAX(SALAIRE_P)  FROM all_person)
)
SELECT 
	departement.designation AS DEPARTEMENT,
	SUM(Employe.salaire) AS SALAIRES
	FROM Departement 
	JOIN Employe USING(id_departement)
	WHERE id_departement IN(SELECT id_departement FROM grande_somme_dep)
	GROUP BY DEPARTEMENT;



------------------------------WINDWOW------------------------------
SELECT 
	Departement.designation AS DEPARTEMENTS,
	COALESCE(SUM(Employe.salaire), 0::MONEY) AS NOMBRE_EMPLOYE,
	DENSE_RANK()
	OVER(ORDER BY COALESCE(SUM(Employe.salaire), 0::MONEY) DESC) AS CLASSEMENT
	FROM Employe
	RIGHT JOIN Departement USING(id_departement)
	GROUP BY DEPARTEMENTS;
	
SELECT * FROM Employe;




SELECT
	Employe.id_departement
	nom,postnom,prenom,sexe,
	Departement.designation AS DEPARTEMENTS,
	SUM(salaire) OVER(PARTITION BY Employe.id_departement) AS PARTITIONNEMENT_DEP
	FROM Employe
	JOIN Departement USING(id_departement)
	ORDER BY nom;



SELECT 
	Departement.designation AS DEPARTEMENTS,
	SUM(Employe.salaire) AS NOMBRE_EMPLOOYE,
	NTILE(3)
	OVER(ORDER BY SUM(Employe.salaire) DESC) AS REGROUPEMENT
	FROM Employe
	JOIN Departement USING(id_departement)
	GROUP BY DEPARTEMENTS;



SELECT * FROM Employe;

SELECT * FROM Employe WHERE date_naissance BETWEEN '1990-01-01' AND '2000-12-31';

SELECT * FROM Employe WHERE EXTRACT(YEAR FROM date_naissance) BETWEEN 1990 AND 2000;

SELECT * FROM Employe WHERE nom LIKE '%a';
SELECT * FROM Employe WHERE nom LIKE 'G____a';
SELECT * FROM Employe WHERE nom LIKE 'B%';


SELECT MAX(date_naissance) FROM Employe;


SELECT * FROM Employe 
	WHERE EXTRACT(YEAR FROM date_naissance) = (SELECT EXTRACT(YEAR FROM date_naissance) FROM Employe WHERE id_employe=4);


INSERT INTO Employe(id_departement, id_grade, nom, postnom, prenom, sexe, salaire, personne_en_charge, date_naissance)
VALUES(4, 2, 'EBONDO', 'MBAYO', 'PIERRE', 'M', 1000, 2, '1999-12-25');


SELECT SUM(personne_en_charge) FROM Employe;



---------------------------------PRODECURES STOCKEES---------------------------------



CREATE OR REPLACE PROCEDURE InsertMission(_id_annee INT, _titre VARCHAR(254), _description TEXT, _date_debut DATE, _date_fin DATE, _cout MONEY, _nombre_personne INT)
	LANGUAGE SQL AS $$
		INSERT INTO Mission(id_annee, titre, description, date_debut, date_fin, cout, nombre_personne) VALUES(_id_annee, _titre, _description, _date_debut, _date_fin, _cout, _nombre_personne)
	$$;

CALL InsertMission(20, 'MAINTENANCE', 'Cette Mission a pour role de maintenir les ordinateurs du departement HR', '2020-01-25', '2020-03-31', 25000::MONEY, 3);
CALL InsertMission(3, 'SUIVI EVALUATION', 'Cette Mission a pour role tirer les conclusions sur la formation des agents', '2003-01-25', '2003-03-31', 60000::MONEY, 14);
CALL InsertMission(2, 'SUIVI EVALUATION', 'Cette Mission a pour role tirer les conclusions sur la formation des agents', '2002-01-25', '2002-03-31', 60000::MONEY, 25);
CALL InsertMission(2, 'REPORTING', 'Cette formation ou mission va former les agents au outils des rapports comme POWER BI', '2002-11-12', '2002-11-30', 3500::MONEY, 3);
CALL InsertMission(3, 'ANALYSE DES DONNEES', 'Cette mission portera sur l''analyse des données de l''entreprise afin de prendre les décisions stratégiques pour l''année prochaine', '2003-01-12', '2003-06-15', 18000::MONEY, 5);
CALL InsertMission(17, 'SPORT ET LOISIRS', 'Pour les raisons de santé, un match est organisé entre les jeunes et les vieux de la société', '2003-01-12', '2003-02-20', 66000::MONEY, 4);

CALL InsertMission(14, 'COORDINATION MASTER', 'Cette mission est là pour coordonner les activités de Master', '2014-05-25', '2014-06-15', 3000::MONEY, 1);

SELECT * FROM Mission;

SELECT * FROM Annee WHERE id_annee IN(SELECT id_annee FROM Mission);

SELECT 
	Annee.designation AS ANNEE,
	COUNT(Mission.id_mission) AS NOMBRE_MISSION
	FROM Mission
	JOIN Annee USING(id_annee)
	GROUP BY ANNEE;


SELECT 
	Annee.designation AS ANNEE,
	COUNT(Mission.id_mission) AS NOMBRE_MISSION,
	SUM(Mission.nombre_personne) AS NOMBRE_PERSONNE
	FROM Mission
	JOIN Annee USING(id_annee)
	GROUP BY ANNEE;



SELECT 
	Annee.designation AS ANNEE,
	COUNT(Mission.id_mission) AS NOMBRE_MISSION,
	SUM(Mission.nombre_personne) AS NOMBRE_PERSONNE,
	SUM(Mission.cout) AS COUT
	FROM Mission
	JOIN Annee USING(id_annee)
	GROUP BY ANNEE;


SELECT 
	Annee.designation AS ANNEE,
	COUNT(Mission.id_mission) AS NOMBRE_MISSION,
	SUM(Mission.nombre_personne) AS NOMBRE_PERSONNE,
	SUM(Mission.cout) AS COUT,
	CAST(SUM(Mission.cout::DECIMAL) / SUM(Mission.nombre_personne) AS MONEY) AS RENUMERATION_PERSONNE
	FROM Mission
	JOIN Annee USING(id_annee)
	GROUP BY ANNEE;
	
SELECT * FROM Mission;


SELECT * FROM Mission 
	WHERE date_debut = (SELECT date_debut FROM Mission WHERE id_mission = 11);

SELECT
	titre,
	description,
	Annee.designation AS annees,
	date_debut,
	date_fin,
	nombre_personne,
	nombre_jours,
	cout,
	CAST(cout::DECIMAL / nombre_personne AS MONEY) AS MONTANT_PERSONNE
	FROM Mission
	JOIN Annee USING(id_annee);


SELECT * FROM Affectation;
SELECT * FROM Employe;
SELECT * FROM Mission;



INSERT INTO Affectation(id_employe, id_mission) VALUES(1,3),(1,11),(1,10),(2,10),(74, 3),(65,3),(17,8),(8,8),(5,5),(14,5),(14,8),(25,4),(55,11),(45,3),(76,4),(67,3),(10,10),(11,11),(79,12),(90,9),(26,4),(26,3),(26,11),(26,12),(24,12),
(16,10),(34,11),(39,12),(40,12),(25,3),(85,3),(90,3),(66,3),(75,11),(49,5),(51,12),(41,5),(21,11),(20,12);

INSERT INTO Affectation(id_employe, id_mission) VALUES(91, 13);


SELECT 
	nom,postnom,prenom,sexe,
	Departement.designation AS DEPARTEMENTS,
	Grade.designation AS GRADES,
	COUNT(Affectation.id_employe) NOMBRE_AFFECTATION
	FROM Employe
	JOIN Affectation USING(id_employe)
	JOIN Departement USING(id_departement)
	JOIN Grade USING(id_grade)
	GROUP BY nom,postnom,prenom,sexe,DEPARTEMENTS,GRADES
	ORDER BY NOMBRE_AFFECTATION DESC;
	
	
	
SELECT 
	Mission.titre AS MISSIONS,
	Mission.nombre_personne AS NOMBRE_PERSONNE,
	COUNT(Affectation.id_mission) AS NOMBRE_AFFECTATION
	FROM Mission
	JOIN Affectation USING(id_mission)
	GROUP BY MISSIONS,NOMBRE_PERSONNE;
	
	


SELECT 
	Mission.titre AS MISSIONS,
	Mission.nombre_personne AS NOMBRE_PERSONNE,
	COUNT(Affectation.id_mission) AS NOMBRE_AFFECTATION
	FROM Mission
	JOIN Affectation USING(id_mission)
	GROUP BY MISSIONS,NOMBRE_PERSONNE
	HAVING(COUNT(Affectation.id_mission)) = Mission.nombre_personne;
	

SELECT 
	Mission.titre AS MISSIONS,
	Mission.nombre_personne AS NOMBRE_PERSONNE,
	COUNT(Affectation.id_mission) AS NOMBRE_AFFECTATION
	FROM Mission
	JOIN Affectation USING(id_mission)
	GROUP BY MISSIONS,NOMBRE_PERSONNE
	HAVING(COUNT(Affectation.id_mission)) > Mission.nombre_personne;

SELECT 
	Mission.titre AS MISSIONS,
	Mission.nombre_personne AS NOMBRE_PERSONNE,
	COUNT(Affectation.id_mission) AS NOMBRE_AFFECTATION
	FROM Mission
	JOIN Affectation USING(id_mission)
	GROUP BY MISSIONS,NOMBRE_PERSONNE
	HAVING(COUNT(Affectation.id_mission)) < Mission.nombre_personne;
	

SELECT 
	Mission.titre AS MISSIONS,
	Mission.nombre_personne AS NOMBRE_PERSONNE,
	COUNT(Affectation.id_mission) AS NOMBRE_AFFECTATION,
	Mission.nombre_personne - COUNT(Affectation.id_mission) AS RESTE_PLACE
	FROM Mission
	JOIN Affectation USING(id_mission)
	GROUP BY MISSIONS,NOMBRE_PERSONNE
	HAVING(COUNT(Affectation.id_mission)) < Mission.nombre_personne;
	

	
	
WITH All_Affectation AS (
	SELECT id_mission,COUNT(id_mission) AS NB_MISSION
	FROM Affectation GROUP BY id_mission
), Mission_Nb_Egal AS(
	SELECT id_mission FROM All_Affectation WHERE id_mission = ANY(SELECT id_mission FROM Mission WHERE nombre_personne = NB_MISSION)
)
SELECT * FROM Mission WHERE id_mission IN(SELECT id_mission FROM Mission_Nb_Egal);



WITH All_Affectation AS (
	SELECT id_mission,COUNT(id_mission) AS NB_MISSION
	FROM Affectation GROUP BY id_mission
), Mission_Nb_Egal AS(
	SELECT id_mission FROM All_Affectation WHERE id_mission = ANY(SELECT id_mission FROM Mission WHERE nombre_personne < NB_MISSION)
)
SELECT * FROM Mission WHERE id_mission IN(SELECT id_mission FROM Mission_Nb_Egal);
	

WITH All_Affectation AS (
	SELECT id_mission,COUNT(id_mission) AS NB_MISSION
	FROM Affectation GROUP BY id_mission
), Mission_Nb_Egal AS(
	SELECT id_mission FROM All_Affectation WHERE id_mission = ANY(SELECT id_mission FROM Mission WHERE nombre_personne > NB_MISSION)
)
SELECT * FROM Mission WHERE id_mission IN(SELECT id_mission FROM Mission_Nb_Egal);
	

WITH All_affectation AS (
	SELECT id_employe,
			COUNT(id_employe) AS NB_AFFECTATION 
			FROM Affectation
			GROUP BY id_employe					
), Best_employe AS(
	SELECT id_employe FROM All_affectation WHERE NB_AFFECTATION = (SELECT MAX(NB_AFFECTATION ) FROM All_affectation)
) SELECT * FROM Employe WHERE id_employe IN(SELECT id_employe FROM Best_employe);




SELECT 
	nom,postnom,prenom,sexe,
	Departement.designation AS DEPARTEMENTS,
	Grade.designation AS GRADES,
	COUNT(Affectation.id_employe) NOMBRE_AFFECTATION,
	DENSE_RANK()
	OVER(ORDER BY COUNT(Affectation.id_employe) DESC) AS CLASSEMENT
	FROM Employe
	JOIN Affectation USING(id_employe)
	JOIN Departement USING(id_departement)
	JOIN Grade USING(id_grade)
	GROUP BY nom,postnom,prenom,sexe,DEPARTEMENTS,GRADES
	ORDER BY NOMBRE_AFFECTATION DESC;
	
	

SELECT 
	nom,postnom,prenom,sexe,
	Departement.designation AS DEPARTEMENTS,
	Grade.designation AS GRADES,
	COUNT(Affectation.id_employe) NOMBRE_AFFECTATION,
	(SUM(Mission.cout / Mission.nombre_personne)) * COUNT(Affectation.id_employe) AS MONTANT_REMUNERES
	FROM Employe
	JOIN Affectation USING(id_employe)
	JOIN Mission USING(id_mission)
	JOIN Departement USING(id_departement)
	JOIN Grade USING(id_grade)
	GROUP BY nom,postnom,prenom,sexe,DEPARTEMENTS,GRADES
	ORDER BY NOMBRE_AFFECTATION DESC;
	
	
	
SELECT 
	nom,postnom,prenom,sexe,
	Departement.designation AS DEPARTEMENTS,
	Grade.designation AS GRADES,
	COUNT(Affectation.id_employe) NOMBRE_AFFECTATION,
	(SUM(Mission.cout / Mission.nombre_personne)) * COUNT(Affectation.id_employe) AS MONTANT_REMUNERES,
	CASE
		WHEN Grade.designation = 'MASTER' THEN (SUM(Mission.cout / Mission.nombre_personne)) * COUNT(Affectation.id_employe) + 500::MONEY
		WHEN Grade.designation = 'LICIENCE' THEN (SUM(Mission.cout / Mission.nombre_personne)) * COUNT(Affectation.id_employe) + 200::MONEY
		ELSE (SUM(Mission.cout / Mission.nombre_personne)) * COUNT(Affectation.id_employe)
	END AS APRES_MAJORATION
	FROM Employe
	JOIN Affectation USING(id_employe)
	JOIN Mission USING(id_mission)
	JOIN Departement USING(id_departement)
	JOIN Grade USING(id_grade)
	GROUP BY nom,postnom,prenom,sexe,DEPARTEMENTS,GRADES
	ORDER BY NOMBRE_AFFECTATION DESC;
	
	
	
SELECT
	Mission.titre AS MISSION,
	SUM(CASE WHEN Employe.sexe = 'M' THEN 1 ELSE 0 END) HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) FEMMES,
	COUNT(Affectation.id_mission) AS NOMBRE_PERSONNE
	FROM Mission
	JOIN Affectation USING(id_mission)
	JOIN Employe USING(id_employe)
	GROUP BY MISSION;
	
	
SELECT
	COALESCE(Mission.titre, 'TOTAL GENERAL') AS MISSION,
	SUM(CASE WHEN Employe.sexe = 'M' THEN 1 ELSE 0 END) HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) FEMMES,
	COUNT(Affectation.id_mission) AS NOMBRE_TOTAL_AFFECTATION
	FROM Mission
	JOIN Affectation USING(id_mission)
	JOIN Employe USING(id_employe)
	GROUP BY ROLLUP(Mission.titre) ORDER BY MISSION;
	
	
SELECT * FROM Employe;	
SELECT * FROM Grade;	

UPDATE Employe SET salaire = salaire + 200::MONEY WHERE id_grade = 2 ;
	
INSERT INTO Grade(designation) VALUES('CB ADJOINT'),('ACADEMIQUE');

SELECT 
	Grade.designation AS GRADES,
	SUM(CASE WHEN Employe.sexe = 'M' THEN 1 ELSE 0 END) HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) FEMMES,
	COUNT(Employe.id_employe) AS NOMBRE_TOTAL
	FROM Employe
	JOIN Grade USING(id_grade)
	GROUP BY GRADES;



SELECT 
	Grade.designation AS GRADES,
	SUM(CASE WHEN Employe.sexe = 'M' THEN 1 ELSE 0 END) HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) FEMMES,
	COUNT(Employe.id_employe) AS NOMBRE_TOTAL
	FROM Employe
	JOIN Grade USING(id_grade)
	GROUP BY GRADES
	HAVING(SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) = 0);
	

SELECT 
	Grade.designation AS GRADES,
	SUM(CASE WHEN Employe.sexe = 'M' THEN 1 ELSE 0 END) HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) FEMMES,
	COUNT(Employe.id_employe) AS NOMBRE_TOTAL
	FROM Employe
	JOIN Grade USING(id_grade)
	GROUP BY GRADES
	HAVING(SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) >= 1 AND SUM(CASE WHEN Employe.sexe = 'M' THEN 1 ELSE 0 END) >= 1);
	
	

SELECT
	Mission.titre AS MISSIONS,
	SUM(CASE WHEN Employe.sexe = 'M' THEN 1 ELSE 0 END) HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) FEMMES,
	COUNT(Employe.id_employe) AS NOMBRE_EMPLOYE
	FROM Affectation
	JOIN Employe USING(id_employe)
	JOIN Mission USING(id_mission)
	GROUP BY MISSIONS;


SELECT
	Mission.titre AS MISSIONS,
	SUM(CASE WHEN Employe.sexe = 'M' THEN 1 ELSE 0 END) HOMMES,
	SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) FEMMES,
	COUNT(Employe.id_employe) AS NOMBRE_EMPLOYE
	FROM Affectation
	JOIN Employe USING(id_employe)
	JOIN Mission USING(id_mission)
	GROUP BY MISSIONS
	HAVING(SUM(CASE WHEN Employe.sexe = 'F' THEN 1 ELSE 0 END) = 0);
	

INSERT INTO Employe(id_departement, id_grade, nom, postnom, prenom, sexe, salaire, personne_en_charge, date_naissance)
VALUES(2, 11, 'KABUYA', 'KABUYA', 'ARSENE', 'M', 4500, 2, '1992-01-25');


SELECT * FROM Employe;

SELECT Employe.id_employe,nom,postnom, 
		prenom,sexe,Mission.titre AS MISSION 
		FROM Employe
		 JOIN Affectation USING(id_employe)
		 JOIN Mission USING(id_mission)
		 WHERE id_mission = ANY(SELECT id_mission FROM Affectation WHERE id_employe = 1);



SELECT Employe.id_employe,nom,postnom, 
		prenom,sexe,Mission.titre AS MISSION 
		FROM Employe
		 JOIN Affectation USING(id_employe)
		 JOIN Mission USING(id_mission)
		 WHERE id_mission = ANY(SELECT id_mission FROM Affectation WHERE id_employe = 1) AND id_mission = 3;

SELECT
	* FROM Employe
	WHERE salaire = (SELECT salaire FROM Employe WHERE id_employe = 1);

SELECT
	* FROM Employe
	WHERE salaire > (SELECT salaire FROM Employe WHERE id_employe = 1);


SELECT 
	* FROM Employe
	WHERE salaire = (SELECT MIN(salaire) FROM Employe);
	
SELECT 
	* FROM Employe
	WHERE salaire = (SELECT MAX(salaire) FROM Employe);
		
SELECT 
	* FROM Employe
	WHERE salaire::DECIMAL > (SELECT AVG(salaire::DECIMAL) FROM Employe);
		
	
UPDATE Employe SET prime = 300 WHERE id_grade = 3;
UPDATE Employe SET prime = 4500 WHERE id_grade = 2;
UPDATE Employe SET prime = 100 WHERE id_grade = 1;
UPDATE Employe SET prime = 120 WHERE id_grade = 5;
UPDATE Employe SET prime = 110 WHERE id_grade = 10;
UPDATE Employe SET prime = 110 WHERE id_grade = 4;
UPDATE Employe SET prime = 110 WHERE id_grade = 7;
UPDATE Employe SET prime = 110 WHERE id_grade = 9;
UPDATE Employe SET prime = 130 WHERE id_grade = 6;
UPDATE Employe SET prime = 114 WHERE id_grade = 8;
	

CREATE OR REPLACE VIEW Liste_Personnel AS
	SELECT
		nom,postnom,prenom,sexe,Departement.designation AS DEPARTEMENT,
		Grade.designation AS GRADES,personne_en_charge,salaire,prime,salaire_total,
		COUNT(Affectation.id_employe) AS AFFECTATIONS,
		(SUM(Mission.cout / Mission.nombre_personne)) * COUNT(Affectation.id_employe) AS RENUMERATIONS_MISSIONS
		FROM Employe
		JOIN Grade USING(id_grade)
		JOIN Departement USING(id_departement)
		JOIN Affectation USING(id_employe)
		JOIN Mission USING(id_mission)
		GROUP BY nom,postnom,prenom,sexe,DEPARTEMENT,
		GRADES,personne_en_charge,salaire,prime,salaire_total;
	
	
SELECT * FROM Liste_Personnel;

SELECT * FROM Employe WHERE id_employe=90 OR id_employe = 10 OR id_employe = 50 OR id_employe = 80;

EXPLAIN SELECT * FROM Employe WHERE id_grade = 11;

CREATE INDEX index_seach_id_employe ON Employe(id_employe);
CREATE INDEX index_search_id_grade_on_Employe ON Employe(id_grade);



	


