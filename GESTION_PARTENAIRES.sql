--STRUCTURE DES TABLES DE LA BASE DE DONNEES DE GESTION DES FINANCEMENTS DES PARTENAIRES

START TRANSACTION;

CREATE TABLE Partenaires(
	id_partenaire SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Annee(
	id_annee SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254),
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Trimestres(
	id_trimestre SERIAL NOT NULL PRIMARY KEY,
	id_annee INT NOT NULL,
	designation VARCHAR(254) NOT NULL,
	date_debut DATE NOT NULL,
	date_fin DATE NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK(date_debut <= date_fin)
);

CREATE TABLE Activites(
	id_activite SERIAL NOT NULL PRIMARY KEY,
	id_trimestre INT NOT NULL,
	designation VARCHAR(254) NOT NULL,
	cout DECIMAL NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK (cout >= 1)
);


CREATE TABLE AffectationActivite(
	id_partenaire INT NOT NULL,
	id_activite INT NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Financement(
	id_finanancement SERIAL NOT NULL PRIMARY KEY,
	id_partenaire INT NOT NULL,
	id_activite INT NOT NULL,
	id_trimestre INT NOT NULL,
	montant DECIMAL NOT NULL,
	motif TEXT,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK (montant >= 1)
);


ALTER TABLE Financement RENAME COLUMN id_finanancement TO id_financement;

CREATE TABLE Beneficiaires(
	id_benficiaire SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE Financement ADD COLUMN id_beneficiaire INT NOT NULL;
ALTER TABLE Beneficiaires RENAME COLUMN id_benficiaire TO id_beneficiaire;

ALTER TABLE AffectationActivite ADD CONSTRAINT fk_key PRIMARY KEY(id_partenaire,id_activite);

ALTER TABLE Trimestres ADD CONSTRAINT fk_annee FOREIGN KEY(id_annee) REFERENCES Annee(id_annee);
ALTER TABLE AffectationActivite ADD CONSTRAINT fk_affectation FOREIGN KEY(id_activite) REFERENCES Activites(id_activite);
ALTER TABLE AffectationActivite ADD CONSTRAINT fk_partenaire FOREIGN KEY(id_partenaire) REFERENCES Partenaires(id_partenaire);
ALTER TABLE Financement ADD CONSTRAINT fk_partenaires FOREIGN KEY(id_partenaire) REFERENCES Partenaires(id_partenaire);
ALTER TABLE Financement ADD CONSTRAINT fk_activites FOREIGN KEY(id_activite) REFERENCES Activites(id_activite);
ALTER TABLE Financement ADD CONSTRAINT fk_trimestres FOREIGN KEY(id_trimestre) REFERENCES Trimestres(id_trimestre);
ALTER TABLE Financement ADD CONSTRAINT fk_beneficiaire FOREIGN KEY(id_beneficiaire) REFERENCES Beneficiaires(id_beneficiaire);

COMMIT;

-- FIN DE LA STRUCTURE

--PROCEDURES STOCKEES

START TRANSACTION;

CREATE OR REPLACE PROCEDURE InsertPartenaire(_designation VARCHAR(254)) LANGUAGE SQL AS $$
	INSERT INTO Partenaires(designation) VALUES(_designation);
$$;

CREATE OR REPLACE PROCEDURE UpdatePartenaire(_id_partenaire INT, _designation VARCHAR(254)) LANGUAGE SQL AS $$
	UPDATE Partenaires SET designation=_designation WHERE id_partenaire=_id_partenaire;
$$;

CREATE OR REPLACE PROCEDURE DeletePartenaire(_id_partenaire INT) LANGUAGE SQL AS $$
	DELETE FROM Partenaires WHERE id_partenaire=_id_partenaire;
$$;

CREATE OR REPLACE PROCEDURE UpInsertPartenaire(_id_partenaire INT,_designation VARCHAR(254)) LANGUAGE SQL AS $$
	INSERT INTO Partenaires(id_partenaire, designation) VALUES(_id_partenaire, _designation)
	ON CONFLICT(id_partenaire)
	DO UPDATE SET designation=EXCLUDED.designation WHERE Partenaires.id_partenaire=EXCLUDED.id_partenaire;
$$;


CREATE OR REPLACE PROCEDURE InsertAnnee(_designation VARCHAR(254)) LANGUAGE SQL AS $$
	INSERT INTO Annee(designation) VALUES(_designation);
$$;


CREATE OR REPLACE PROCEDURE UpdateAnnee(_id_annee INT, _designation VARCHAR(254)) LANGUAGE SQL AS $$
	UPDATE Annee SET designation=_designation WHERE id_annee=_id_annee;
$$;

CREATE OR REPLACE PROCEDURE DeleteAnnee(_id_annee INT) LANGUAGE SQL AS $$
	DELETE FROM Annee WHERE id_annee=_id_annee;
$$;

COMMIT;

--FIN DE CREATION DES PROCEDURES STOCKEES PREMIERE PHASE

SELECT * FROM Partenaires;

--UTILISATION DES PROCEDURES STOCKEES

CALL InsertPartenaire('OMS');
CALL InsertPartenaire('USAID');
CALL InsertPartenaire('PROSANI');
CALL InsertPartenaire('MEDECIN SANS FONTRIERES');
CALL InsertPartenaire('ONU');
CALL InsertPartenaire('OIF');
CALL InsertPartenaire('MULYKAP');
CALL InsertPartenaire('JAMBO MART');
CALL InsertPartenaire('CHEMAF');
CALL InsertPartenaire('GECAMINE');
CALL InsertPartenaire('RUASHI MINING');
CALL InsertPartenaire('VILLE POITEAU');
CALL InsertPartenaire('ZONE DE SANTE DE TSHOFA');
CALL InsertPartenaire('HGRF KABINDA');
CALL InsertPartenaire('SAINT MARTIN');


CALL UpdatePartenaire(1, 'O M S KAB');

CALL DeletePartenaire(1);

CALL UpInsertPartenaire(2, 'USAID');

SELECT * FROM Partenaires;

INSERT INTO Partenaires(id_partenaire,designation) 
	VALUES (2,'PROSANI USAID') 
	ON CONFLICT(id_partenaire)
	DO NOTHING;


INSERT INTO Partenaires(id_partenaire,designation) 
	VALUES (16,'VILLA RICH') 
	ON CONFLICT(id_partenaire)
	DO UPDATE SET designation=EXCLUDED.designation 
	WHERE Partenaires.id_partenaire=EXCLUDED.id_partenaire;
	
	
SELECT COUNT(*) AS PARTENAIRES FROM Partenaires;

SELECT * FROM Partenaires;
SELECT * FROM Partenaires WHERE designation LIKE 'M%P%S';
SELECT * FROM Partenaires WHERE designation LIKE '%E%';

INSERT INTO Partenaires(designation, date_created) VALUES('CLASSIC COACH', '2024-06-28');
INSERT INTO Partenaires(designation, date_created) VALUES('JOIN KENEDY 03', '2013-01-01');
INSERT INTO Partenaires(designation, date_created) VALUES('JOIN KENEDY 29', '2029-12-31');
INSERT INTO Partenaires(designation, date_created) VALUES('JOIN KENEDY 33', '2032-12-31');


SELECT
	id_partenaire AS ID_PARTENAIRE,
	designation AS PARTENAIRE,
	date_created AS DATE_CREATION,
	EXTRACT(QUARTER FROM date_created) AS TRIMESTRE,
	EXTRACT(WEEK FROM date_created) AS SEMAINE,
	EXTRACT(ISOYEAR FROM date_created) AS ANNEE_ISO
	FROM Partenaires;

TRUNCATE TABLE Partenaires CASCADE;




--INSERTION DES ANNEE
CALL InsertAnnee('2001');
CALL InsertAnnee('2002');
CALL InsertAnnee('2003');
CALL InsertAnnee('2004');
CALL InsertAnnee('2005');
CALL InsertAnnee('2006');
CALL InsertAnnee('2007');
CALL InsertAnnee('2008');
CALL InsertAnnee('2008');
CALL InsertAnnee('2009');
CALL InsertAnnee('2010');
CALL InsertAnnee('2011');
CALL InsertAnnee('2012');
CALL InsertAnnee('2013');
CALL InsertAnnee('2014');
CALL InsertAnnee('2015');
CALL InsertAnnee('2016');
CALL InsertAnnee('2017');
CALL InsertAnnee('2018');
CALL InsertAnnee('2019');
CALL InsertAnnee('2020');
CALL InsertAnnee('2021');
CALL InsertAnnee('2021');
CALL InsertAnnee('2022');
CALL InsertAnnee('2023');
CALL InsertAnnee('2024');

SELECT designation FROM Annee;

ALTER TABLE Annee ADD COLUMN NombreTrimestre INT NULL DEFAULT 4;

SELECT * FROM Annee;


SELECT * FROM Trimestres;


INSERT INTO Trimestres(id_annee, designation, date_debut,date_fin) 
VALUES (1,'T1', '2001-01-01', '2001-03-31'),
(1,'T2', '2001-04-01','2001-06-30'),
(1,'T3', '2001-07-01', '2001-09-01'),
(1,'T4', '2001-10-01','2001-12-31'),

(3,'T1', '2003-01-01', '2003-03-31'),
(3,'T2', '2003-04-01','2003-06-30'),
(3,'T3', '2003-07-01', '2003-09-01'),
(3,'T4', '2003-10-01','2003-12-31'),

(10,'T1', '2010-01-01', '20010-03-31'),
(10,'T2', '2010-04-01','20010-06-30'),
(10,'T3', '2010-07-01', '20010-09-01'),
(10,'T4', '2010-10-01','20010-12-31'),

(16,'T1', '2016-01-01', '2016-03-31'),
(16,'T2', '2016-04-01','2016-06-30'),
(16,'T3', '2016-07-01', '2016-09-01'),
(16,'T4', '2016-10-01','2016-12-31'),

(19,'T1', '2019-01-01', '2019-03-31'),
(19,'T2', '2019-04-01','2019-06-30'),
(19,'T3', '2019-07-01', '2019-09-01'),
(19,'T4', '2019-10-01','2019-12-31'),

(22,'T1', '2022-01-01', '2022-03-31'),
(22,'T2', '2022-04-01','2022-06-30'),
(22,'T3', '2022-07-01', '2022-09-01'),
(22,'T4', '2022-10-01','2022-12-31'),

(21,'T1', '2021-01-01', '2021-03-31'),
(21,'T2', '2021-04-01','2021-06-30'),
(26,'T3', '2026-07-01', '2026-09-01'),
(26,'T4', '2026-10-01','2026-12-31'),
(25,'T4', '2025-10-01','2025-12-31'),
(13,'T4', '2013-10-01','2013-12-31');

INSERT INTO Trimestres(id_annee, designation, date_debut,date_fin) 
VALUES (9,'T4', '2010-10-01','2010-12-31');
INSERT INTO Trimestres(id_annee, designation, date_debut,date_fin) 
VALUES (9,'T5', '2010-10-01','2010-12-31');

INSERT INTO Trimestres(id_annee, designation, date_debut,date_fin) 
VALUES (9,'T1', '2010-01-01', '2010-03-31');
INSERT INTO Trimestres(id_annee, designation, date_debut,date_fin) 
VALUES (9,'T2', '2010-04-01','2010-06-30');
INSERT INTO Trimestres(id_annee, designation, date_debut,date_fin) 
VALUES (9,'T3', '2010-07-01', '2010-09-01');


SELECT * FROM Annee WHERE id_annee IN(SELECT id_annee FROM Trimestres);


SELECT
	ROW_NUMBER()OVER(ORDER BY Annee.id_annee) AS N°,
	Annee.id_annee AS ID_ANNEE,
	Annee.designation AS ANNEE,
	CASE WHEN Annee.NombreTrimestre IS NOT NULL THEN Annee.NombreTrimestre 
	ELSE COUNT(Annee.NombreTrimestre) END AS NB_DEFAULT,
	COUNT(trimestres.id_annee) AS NOMBRE_TRI
	FROM Annee JOIN Trimestres USING(id_annee)
	GROUP BY Annee.id_annee, ANNEE,annee.nombretrimestre
	HAVING(COUNT(trimestres.id_annee)) < ALL(SELECT Annee.NombreTrimestre FROM Annee)
	ORDER BY id_annee;
	
	
SELECT * FROM Annee;	
	

SELECT * FROM Trimestres;


SELECT * FROM Activites;

ALTER TABLE Activites ALTER COLUMN cout TYPE MONEY;

ALTER TABLE Activites ADD CONSTRAINT activites_cout_check CHECK(cout >= CAST(1 AS MONEY));

INSERT INTO Activites(id_trimestre, designation,cout) 
VALUES(27, 'Transport des Agents', 3850),(2, 'Formation des Agents du Service comptable',1000),(27, 'Audit des Agents de la caisse',15550),(27,'Création de la plateforme pour les actualités de l entreprise',45000);


INSERT INTO Activites(id_trimestre, designation,cout) 
VALUES(28, 'Transport des Agents', 45000),(28, 'Formation des Agents du Service comptable',145000);



SELECT 
	Activites.designation AS ACTIVITES,
	Trimestres.designation AS TRIMESTRES,
	Activites.cout AS COUTS
	FROM Activites 
	JOIN Trimestres USING(id_trimestre)
	WHERE cout >= (SELECT cout FROM Activites WHERE id_activite=6)
	AND (Trimestres.designation='T1' OR Trimestres.designation='T2');


SELECT * FROM Activites WHERE CAST(cout AS DECIMAL) > (SELECT AVG(CAST(cout AS DECIMAL)) FROM Activites);


SELECT AVG(CAST(cout AS DECIMAL)) FROM Activites;


SELECT * FROM affectationActivite;


SELECT * FROM Partenaires;
SELECT * FROM Activites;

INSERT INTO affectationActivite(id_partenaire,id_activite)
VALUES (19, 4),(25,7);

INSERT INTO affectationActivite(id_partenaire,id_activite)
VALUES (36, 4);

INSERT INTO affectationActivite(id_partenaire,id_activite)
VALUES (36, 8),(36,9),(36,3);

SELECT * FROM Partenaires WHERE id_partenaire IN(SELECT id_partenaire FROM affectationActivite);

SELECT * FROM Financement;
SELECT * FROM Trimestres;


INSERT INTO Financement (id_partenaire,id_activite, id_trimestre, montant,motif,id_beneficiaire)
VALUES(36,4, 32,5000,'4eme versement de mon engagement',1);

CREATE VIEW ListeAffectationActivitePartenaires AS
SELECT 
	partenaires.designation AS PARTENAIRES,
	trimestres.designation AS TRIMETRES,
	Annee.designation AS ANNEE,
	trimestres.date_debut AS DATE_DEBUT_ACTIVITES,
	trimestres.date_FIN AS DATE_FIN_ACTIVITES,
	activites.designation AS ACTIVITES,
	activites.cout AS COUT_ACTIVITE
	FROM affectationActivite
	JOIN partenaires USING(id_partenaire)
	JOIN Activites USING(id_activite)
	JOIN Trimestres USING(id_trimestre)
	JOIN Annee USING(id_annee);

SELECT * FROM ListeAffectationActivitePartenaires;

SELECT * FROM Activites;


SELECT * FROM Beneficiaires;

INSERT INTO Beneficiaires(designation) VALUES('ISTIA KAB'),('UNILO'),('UNIKAB');




SELECT
	partenaires.id_partenaire ID_PARTENAIRE,
	partenaires.designation AS PARTENAIRES,
	trimestres.designation AS TRIMETRES,
	Annee.designation AS ANNEE,
	trimestres.date_debut AS DATE_DEBUT_ACTIVITES,
	trimestres.date_FIN AS DATE_FIN_ACTIVITES,
	activites.designation AS ACTIVITES,
	activites.cout AS COUT_ACTIVITE,
	COALESCE(financement.montant,0) AS MONTANT_VERSE,
	beneficiaires.designation AS BENEFICIAIRES
	FROM affectationActivite
	JOIN partenaires USING(id_partenaire)
	JOIN Activites USING(id_activite)
	JOIN Trimestres USING(id_trimestre)
	JOIN Annee USING(id_annee)
	LEFT JOIN Financement USING(id_partenaire)
	JOIN Beneficiaires USING(id_beneficiaire)
	ORDER BY MONTANT_VERSE DESC;





SELECT 
	partenaires.designation AS PARTENAIRES,
	trimestres.designation AS TRIMETRES,
	Annee.designation AS ANNEES,
	trimestres.date_debut AS DATE_DEBUT_ACTIVITES,
	trimestres.date_fin AS DATE_FIN_ACTIVITES,
	activites.designation AS ACTIVITES,
	activites.cout AS COUT_ACTIVITE,
	LAG(activites.cout,1,CAST(0 AS MONEY)) OVER(ORDER BY Annee.designation) AS COMPARAISON,
	DENSE_RANK()OVER(ORDER BY activites.cout DESC) AS CLASSEMENT
	FROM affectationActivite
	JOIN partenaires USING(id_partenaire)
	JOIN Activites USING(id_activite)
	JOIN Trimestres USING(id_trimestre)
	JOIN Annee USING(id_annee);


SELECT * FROM Financement;

SELECT * FROM Activites
DELETE FROM Activites WHERE id_activite=5;

SELECT * FROM Trimestres;


ALTER TABLE Activites ADD CONSTRAINT fk_trimestre FOREIGN KEY(id_trimestre) REFERENCES Trimestres(id_trimestre);



SELECT 
	ROW_NUMBER() OVER(ORDER BY T.designation) AS N°,
	ID_PARTENAIRES,ID_ACT, PARTENAIRES,A.designation AS ANNEES_PLANNING,T.designation AS TRIMESTRE_PLANNING, 
	ANNEE_FINANCEMENT,TRIMESTRES_FINANCEMENT,ACTIVITES, MONTANT_PREVU,COMPARAISON,MONT_VERSES,NOMBRE_BENIFICIARES
	FROM(SELECT partenaires.id_partenaire ID_PARTENAIRES,
			Activites.id_trimestre ID_ACT,
			partenaires.designation AS PARTENAIRES,
			Trimestres.designation AS TRIMESTRES_FINANCEMENT,
		 	Annee.designation AS ANNEE_FINANCEMENT,
			Activites.designation AS ACTIVITES,
			Activites.cout AS MONTANT_PREVU,
			CAST(SUM(financement.montant) AS MONEY) AS MONT_VERSES,
		 	LAG(CAST(SUM(financement.montant) AS MONEY),1,CAST(0 AS MONEY)) OVER (ORDER BY Activites.cout) COMPARAISON,
			COUNT(DISTINCT(financement.id_beneficiaire)) AS NOMBRE_BENIFICIARES
			FROM Financement
			JOIN Trimestres USING(id_trimestre)
			JOIN Annee USING(id_annee)
			JOIN Partenaires USING(id_partenaire)
			JOIN Activites USING(id_activite)
			GROUP BY ID_PARTENAIRES,ID_ACT,PARTENAIRES,ACTIVITES,
			MONTANT_PREVU,TRIMESTRES_FINANCEMENT,ANNEE_FINANCEMENT
	) AS TABLE_TEMPO,Trimestres T,Annee A WHERE TABLE_TEMPO.ID_ACT=T.id_trimestre AND A.id_annee=T.id_annee;


SELECT SUM(montant) FROM Financement;
SELECT * FROM Financement;


SELECT * FROM Trimestres 
	WHERE id_trimestre
	IN(SELECT id_trimestre FROM Activites WHERE id_activite IN(SELECT id_activite FROM Financement));
	
SELECT * FROM Partenaires;

SELECT * FROM Financement;

SELECT ID_PARTENAIRES,PARTENAIRES,NOMBRE_AFFECTION,
	COUNT(Finance.id_partenaire) FINANCEMENT_P,
	COUNT(DISTINCT(ACTIV.id_activite)) NOMBRE_ACTIVITES,
	COUNT(DISTINCT(Benf.id_beneficiaire)) AS NOMBRE_BENEFICIAIRES,
	SUM(ACTIV.cout) AS MONTANT_PREVU,CAST(SUM(Finance.montant) AS MONEY) AS MONTANT_VERSES,
	CASE
		WHEN CAST(SUM(Finance.montant) AS MONEY) < SUM(ACTIV.cout) THEN CAST(CONCAT('ENCORE :', ' ', CAST(SUM(ACTIV.cout) AS DECIMAL) - CAST(SUM(Finance.montant) AS DECIMAL)) AS TEXT)
		WHEN CAST(SUM(Finance.montant) AS MONEY) > SUM(ACTIV.cout) THEN  CAST(CONCAT('AU DE LA DE : ', ' ', CAST(SUM(Finance.montant) AS DECIMAL) - CAST(SUM(ACTIV.cout) AS DECIMAL)) AS TEXT)
		ELSE CAST(CAST(SUM(ACTIV.cout) AS DECIMAL) - CAST(SUM(Finance.montant) AS DECIMAL) AS TEXT) END AS ECART
	
	 FROM(
	SELECT 	
	Partenaires.id_partenaire AS ID_PARTENAIRES,
	Partenaires.designation AS PARTENAIRES,
	COUNT(DISTINCT(AffectationActivite.id_partenaire,AffectationActivite.id_activite)) AS NOMBRE_AFFECTION
	FROM Partenaires
	JOIN AffectationActivite USING(id_partenaire)
	JOIN Financement USING(id_partenaire)
	GROUP BY ID_PARTENAIRES,PARTENAIRES
	) AS TEMPO_TABLE,Financement Finance,Activites ACTIV,Beneficiaires Benf  
		WHERE Finance.id_partenaire=TEMPO_TABLE.ID_PARTENAIRES 
		AND ACTIV.id_activite=Finance.id_activite AND Benf.id_beneficiaire=Finance.id_beneficiaire
		GROUP BY ID_PARTENAIRES,PARTENAIRES,NOMBRE_AFFECTION;

	

SELECT * FROM AffectationActivite WHERE id_partenaire=36;
SELECT * FROM Financement WHERE id_partenaire=36;

SELECT SUM(montant) FROM Financement WHERE id_partenaire=36;

SELECT SUM(cout) FROM Activites WHERE id_partenaire=36;



SELECT * FROM AffectationActivite WHERE id_partenaire=30;
SELECT * FROM Financement WHERE id_partenaire=30;

SELECT * FROM financement;

EXPLAIN SELECT ID_TRIM, ANNEES,TRIMESTRE,NOMBRE_FINANCEMENT, NOMBRE_beneficiaire, SUM(A.cout) AS MONTANT_ATTENDU,
 	MONTANT_ENTRANT AS MONTANT_ENTRANT FROM (
	SELECT
	Trimestres.id_trimestre AS ID_TRIM,
	Annee.designation AS ANNEES,
	Trimestres.designation AS TRIMESTRE,
	COUNT(Financement.id_activite) AS NOMBRE_FINANCEMENT,
	COUNT(DISTINCT(Financement.id_beneficiaire)) AS NOMBRE_beneficiaire,
	SUM(Financement.montant) AS MONTANT_ENTRANT
	FROM Financement
	JOIN Trimestres USING(id_trimestre)
	JOIN Annee USING(id_annee)
	GROUP BY GROUPING SETS ((ID_TRIM, ANNEES,TRIMESTRE), ()) 
	ORDER BY MONTANT_ENTRANT
	) AS TEMPO, Activites A WHERE A.id_trimestre=TEMPO.ID_TRIM
	GROUP BY GROUPING SETS((ID_TRIM, ANNEES,TRIMESTRE,NOMBRE_FINANCEMENT, NOMBRE_beneficiaire,MONTANT_ENTRANT),()) ORDER BY MONTANT_ENTRANT;

	
EXPLAIN SELECT SUM(montant) FROM Financement WHERE id_trimestre=27 OR id_trimestre=28;	

SELECT * FROM Financement;

SELECT * FROM Trimestres;
	
EXPLAIN SELECT SUM(cout) FROM Activites;

SELECT 
	Annee.designation AS ANNEES,
	Trimestres.designation AS TRIMESTRE,
	SUM(Financement.montant) AS MONTANT
	FROM Financement
	JOIN Trimestres USING(id_trimestre)
	JOIN Annee USING(id_annee)
	GROUP BY ROLLUP (ANNEES,TRIMESTRE)
	ORDER BY ANNEES;


SELECT 
	Activites.id_activite AS ID_ACTIVITES,
	Activites.designation AS ACTIVITES,
	Activites.cout AS COUTS,
	Trimestres.designation AS TRIMESTRE,
	Annee.designation AS ANNEES
	FROM Activites 
	JOIN Trimestres USING(id_trimestre)
	JOIN Annee USING(id_annee)
	WHERE id_activite NOT IN(SELECT id_activite FROM affectationactivite) OR id_activite IN(SELECT id_activite FROM affectationactivite)
	GROUP BY ID_ACTIVITES,ACTIVITES,COUTS,TRIMESTRE,ANNEES;


SELECT * FROM affectationactivite;
SELECT * FROM partenaires;
SELECT * FROM Activites;

SELECT * FROM Annee;



SELECT 
	COALESCE(Activites.designation, 'TOTAL GENERAL') AS ACTIVITES,
	COALESCE(Activites.cout, SUM(Activites.cout)) AS COUTS,
	COALESCE(Trimestres.designation, CAST(COUNT(DISTINCT(Trimestres.designation)) AS TEXT)) AS TRIMESTRE
	FROM Activites 
	JOIN Trimestres USING(id_trimestre)
	WHERE id_trimestre=28 AND Trimestres.id_annee=1
	GROUP BY GROUPING SETS((Activites.designation, Activites.cout,Trimestres.designation), ());
	

SELECT * FROM Trimestres;

SELECT 
	ROW_NUMBER() OVER(ORDER BY Activites.cout) AS N°,
	COALESCE(Activites.designation, 'TOTAL GENERAL') AS ACTIVITES,
	COALESCE(Trimestres.designation, '-') AS TRIMESTRE,
	COALESCE(Annee.designation, '-') AS ANNEES,
	CAST(COALESCE(Activites.cout, SUM(Activites.cout)) AS DECIMAL) AS COUT
	FROM Activites
	JOIN Trimestres USING(id_trimestre)
	JOIN Annee USING(id_annee)
	GROUP BY GROUPING SETS((Activites.designation,Trimestres.designation,Annee.designation,Activites.cout), ());
	
SELECT SUM(cout) FROM Activites;

SELECT * FROM Activites;

