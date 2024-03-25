ALTER DATABASE "BDD_TEST" RENAME TO "";


DROP TABLE Faculte;
DROP TABLE promotion;

CREATE TABLE Faculte(
	id_fac SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT NOW()
);

INSERT INTO faculte(designation) VALUES('DROIT'),
('ECONOMIE'), ('AGRONOMIE'),('SANTE PUBLIQUE'), 
('DOUANE'), ('BANQUE ET ASSURANCE'), ('COMPTABILITE'), 
('MARKETING');

INSERT INTO faculte(designation) VALUES('INFORMATIQUE')

SELECT * FROM faculte;

CREATE TABLE promotion(
	id_promotion SERIAL NOT NULL PRIMARY KEY,
	id_fac INT NOT NULL ,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT NOW()
);


TRUNCATE TABLE promotion;
SELECT * FROM promotion;


ALTER TABLE promotion ADD CONSTRAINT fk_fac FOREIGN KEY(id_fac) REFERENCES Faculte(id_fac)

INSERT INTO promotion(id_fac, designation)VALUES(1, 'G1 DROIT'),
(1, 'G2 DROIT'),(1, 'G3 DROIT'),(1, 'L1 DROIT'),(1, 'L2 DROIT');

INSERT INTO promotion(id_fac, designation)VALUES(3, 'G1 AGRO'),
(3, 'G2 AGRO'),(3, 'G3 AGRO'),(3, 'L1 AGRO'),(3, 'L2 AGRO');

INSERT INTO promotion(id_fac, designation)VALUES(4, 'G1 SANTE PUBLIQUE'),
(4, 'G2 SANTE PUBLIQUE'),(4, 'G3 SANTE PUBLIQUE'),(4, 'L1 SANTE PUBLIQUE'),(4, 'L2 SANTE PUBLIQUE');


INSERT INTO promotion(id_fac, designation)VALUES(5, 'G1 DOUANE'),
(5, 'G2 DOUANE'),(5, 'G3 DOUANE'),(5, 'L1 DOUANE'),(5, 'L2 DOUANE');


INSERT INTO promotion(id_fac, designation)VALUES(6, 'G1 BANQUE ET ASSURANCE'),
(6, 'G2  BANQUE ET ASSURANCE'),(6, 'G3  BANQUE ET ASSURANCE'),(6, 'L1  BANQUE ET ASSURANCE'),(6, 'L2  BANQUE ET ASSURANCE');


INSERT INTO promotion(id_fac, designation)VALUES(7, 'G1 COMPTABILITE'),
(7, 'G2 COMPTABILITE'),(7, 'G3 COMPTABILITE'),(7, 'L1 COMPTABILITE'),(7, 'L2 COMPTABILITE');



INSERT INTO promotion(id_fac, designation)VALUES(8, 'G1 MARKETING'),
(8, 'G2 MARKETING'),(8, 'G3 MARKETING'),(8, 'L1 MARKETING'),(8, 'L2 MARKETING');

INSERT INTO promotion(id_fac, designation)VALUES(9, 'G1 INFORMATIQUE'),
(9, 'G2 INFORMATIQUE'),(9, 'G3 INFORMATIQUE'),(9, 'L1 INFORMATIQUE'),(9, 'L2 INFORMATIQUE');



SELECT * FROM promotion;


SELECT 
	faculte.designation AS FACULTE,
	promotion.designation AS PROMOTION,
	faculte.date_created AS DATE_CREATED_FAC,
	promotion.date_created AS DATE_CREATED_PROMO
	FROM faculte 
	LEFT JOIN promotion ON promotion.id_fac=faculte.id_fac;


SELECT 
	faculte.designation AS FACULTE,
	COUNT(DISTINCT(promotion.designation)) AS PROMOTION_NUMBER,
	faculte.date_created AS DATE_CREATED_FAC
	FROM faculte 
	LEFT JOIN promotion USING(id_fac) GROUP BY FACULTE,DATE_CREATED_FAC;

SELECT 
	*
	FROM promotion 
	NATURAL JOIN faculte;

CREATE TABLE Anne_Academique(
	id_anne SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_debut DATE NOT NULL,
	date_fin DATE NOT NULL,
	date_created DATE NULL DEFAULT NOW()
);

SELECT * FROM Anne_Academique;

INSERT INTO Anne_Academique(designation, date_debut, date_fin) VALUES('2016', '2016-01-01', '2016-12-31')
,('2017', '2017-01-01', '2017-12-31'),('2018', '2018-01-01', '2018-12-31'),('2019', '2019-01-01', '2019-12-31'),
('2020', '2020-01-01', '2020-12-31'),('2021', '2021-01-01', '2021-12-31'),('2022', '2022-01-01', '2022-12-31'),
('2023', '2023-01-01', '2023-12-31'),('2024', '2024-01-01', '2024-12-31');

DROP TABLE Etudiant;
	
CREATE TABLE Etudiant(
	id_etudiant SERIAL NOT NULL PRIMARY KEY,
	id_promotion INT NOT NULL,
	nom VARCHAR(254) NOT NULL,
	postnom VARCHAR(254) NOT NULL,
	prenom VARCHAR(254) NOT NULL,
	sexe VARCHAR(1) NOT NULL,
	date_naiss DATE NULL,
	date_created DATE NULL DEFAULT NOW()
);


ALTER TABLE etudiant ADD COLUMN id_annee INT NOT NULL;

SELECT * FROM etudiant;

ALTER TABLE etudiant ADD CONSTRAINT fk_promo FOREIGN KEY(id_promotion) REFERENCES promotion(id_promotion);
ALTER TABLE etudiant ADD CONSTRAINT fk_anne_ac FOREIGN KEY(id_annee) REFERENCES Anne_Academique(id_anne);


INSERT INTO etudiant(id_promotion, nom, postnom, prenom, sexe, date_naiss, id_annee)VALUES
(70,'KIKUDI', 'LOJI', 'CHRISTINE', 'F', '1996-04-18', 1);

INSERT INTO etudiant(id_promotion, nom, postnom, prenom, sexe, date_naiss, id_annee)VALUES
(70,'KALENGA', 'MUTOMBO', 'MIKE', 'M', '1999-05-17', 1);

INSERT INTO etudiant(id_promotion, nom, postnom, prenom, sexe, date_naiss, id_annee)VALUES
(70,'KIUKA', 'MBAYO', 'HENRI', 'M', '2001-06-26', 4);

UPDATE etudiant SET id_promotion=66 WHERE id_etudiant=4;
DELETE FROM etudiant WHERE id_etudiant=4;

SELECT * FROM etudiant;

CREATE VIEW LISTE_ETUDIANT_PROMO_ANNEE AS 
	SELECT 
		etudiant.nom,
		etudiant.postnom, 
		etudiant.prenom, 
		etudiant.sexe, 
		etudiant.date_naiss,
		promotion.designation AS PROMOTION,
		Anne_Academique.designation AS ANNNE
		FROM etudiant
		JOIN promotion USING(id_promotion)
		INNER JOIN Anne_Academique ON Anne_Academique.id_anne=etudiant.id_annee;
		
		

INSERT INTO etudiant(id_promotion, nom, postnom, prenom, sexe, date_naiss, id_annee)VALUES
(70,'MATUMBA', 'KAPENGA', 'PRINCE', 'M', '2000-09-25', 1),
(70,'LUAMBA', 'NGOYI', 'PASCALINE', 'F', '2000-09-25', 1),
(70,'EBONDO', 'MUKOMENA', 'ADELINE', 'F', '2001-09-25', 1),
(70,'KAZADI', 'NGONGO', 'RAPHAEL', 'M', '1992-10-30', 1),
(70,'YAMAKUNDA', 'YALUMANA', 'DIEUM', 'M', '1997-10-18', 1),
(70,'NGOYI', 'NKUENYI', 'DECHRIS', 'M', '2003-10-25', 1),
(70,'KIBONGIE', 'MPAMPI', 'CORNEILLE', 'M', '1998-11-25', 1),
(70,'KABAMBA', 'KABAMBA', 'DESIRE', 'M', '1989-10-25', 1),
(70,'MITANTA', 'MUSONGIELA', 'JEAN PIERRE', 'M', '1990-04-25', 1),
(70,'NYEMBO', 'MUKENDA', 'URBIAN', 'M', '1998-10-02', 1),
(70,'MPUENGIE', 'KABOBO', 'BLANDINE', 'F', '1996-10-12', 1),
(70,'KASENDWE', 'KIBAMBE', 'CHOUDEL', 'F', '2000-10-25', 1),
(70,'MBUYU', 'MUTUALE', 'MIREILLE', 'F', '1997-10-26', 1),
(70,'NGOYI', 'KASONGO', 'GEORGES', 'M', '1997-04-30', 1),
(70,'KIAMBE', 'KASONGO', 'NELLY', 'F', '1996-10-12', 1),
(70,'KITUMBIKA', 'KATEMBO', 'JULAIS', 'M', '2001-04-25', 1),
(70,'FRAM', 'KIYENGA', 'FRAM', 'M', '1992-10-28', 1);


UPDATE  etudiant SET id_promotion=66;



INSERT INTO etudiant(id_promotion, nom, postnom, prenom, sexe, date_naiss, id_annee)VALUES
(67,'MATUMBA', 'KAPENGA', 'PRINCE', 'M', '2000-09-25', 2),
(67,'LUAMBA', 'NGOYI', 'PASCALINE', 'F', '2000-09-25', 2),
(67,'EBONDO', 'MUKOMENA', 'ADELINE', 'F', '2001-09-25', 2),
(67,'KAZADI', 'NGONGO', 'RAPHAEL', 'M', '1992-10-30', 2),
(67,'YAMAKUNDA', 'YALUMANA', 'DIEUM', 'M', '1997-10-18', 2),
(67,'NGOYI', 'NKUENYI', 'DECHRIS', 'M', '2003-10-25', 2),
(67,'KIBONGIE', 'MPAMPI', 'CORNEILLE', 'M', '1998-11-25', 2),
(67,'KABAMBA', 'KABAMBA', 'DESIRE', 'M', '1989-10-25', 2),
(67,'MITANTA', 'MUSONGIELA', 'JEAN PIERRE', 'M', '1990-04-25', 2),
(67,'NYEMBO', 'MUKENDA', 'URBIAN', 'M', '1998-10-02', 2),
(67,'MPUENGIE', 'KABOBO', 'BLANDINE', 'F', '1996-10-12', 2),
(67,'KASENDWE', 'KIBAMBE', 'CHOUDEL', 'F', '2000-10-25', 2),
(67,'MBUYU', 'MUTUALE', 'MIREILLE', 'F', '1997-10-26', 2),
(67,'NGOYI', 'KASONGO', 'GEORGES', 'M', '1997-04-30', 2),
(67,'KIAMBE', 'KASONGO', 'NELLY', 'F', '1996-10-12', 2),
(67,'KITUMBIKA', 'KATEMBO', 'JULAIS', 'M', '2001-04-25', 2),
(67,'FRAM', 'KIYENGA', 'FRAM', 'M', '1992-10-28', 2),
(67,'KIUKA', 'MBAYO', 'HENRI', 'M', '2001-06-26', 2),
(67,'KIKUDI', 'LOJI', 'CHRISTINE', 'F', '1996-04-18', 2),
(67,'KALENGA', 'MUTOMBO', 'MIKE', 'M', '1999-05-17', 2);






INSERT INTO etudiant(id_promotion, nom, postnom, prenom, sexe, date_naiss, id_annee)VALUES
(68,'MATUMBA', 'KAPENGA', 'PRINCE', 'M', '2000-09-25', 3),
(68,'LUAMBA', 'NGOYI', 'PASCALINE', 'F', '2000-09-25', 3),
(68,'EBONDO', 'MUKOMENA', 'ADELINE', 'F', '2001-09-25', 3),
(68,'KAZADI', 'NGONGO', 'RAPHAEL', 'M', '1992-10-30', 3),
(68,'YAMAKUNDA', 'YALUMANA', 'DIEUM', 'M', '1997-10-18', 3)
;


INSERT INTO etudiant(id_promotion, nom, postnom, prenom, sexe, date_naiss, id_annee)VALUES
(69,'MATUMBA', 'KAPENGA', 'PRINCE', 'M', '2000-09-25', 4),
(69,'LUAMBA', 'NGOYI', 'PASCALINE', 'F', '2000-09-25', 4),
(69,'EBONDO', 'MUKOMENA', 'ADELINE', 'F', '2001-09-25', 4),
(69,'KAZADI', 'NGONGO', 'RAPHAEL', 'M', '1992-10-30', 4),
(69,'YAMAKUNDA', 'YALUMANA', 'DIEUM', 'M', '1997-10-18', 4),
(69,'NGOYI', 'NKUENYI', 'DECHRIS', 'M', '2003-10-25', 4),
(69,'KIBONGIE', 'MPAMPI', 'CORNEILLE', 'M', '1998-11-25', 4),
(69,'KABAMBA', 'KABAMBA', 'DESIRE', 'M', '1989-10-25', 4),
(69,'MITANTA', 'MUSONGIELA', 'JEAN PIERRE', 'M', '1990-04-25', 4),
(69,'NYEMBO', 'MUKENDA', 'URBIAN', 'M', '1998-10-02', 4),
(69,'MPUENGIE', 'KABOBO', 'BLANDINE', 'F', '1996-10-12', 4),
(69,'KASENDWE', 'KIBAMBE', 'CHOUDEL', 'F', '2000-10-25', 4),
(69,'FRAM', 'KIYENGA', 'FRAM', 'M', '1992-10-28', 4),
(69,'KIUKA', 'MBAYO', 'HENRI', 'M', '2001-06-26', 4),
(69,'KIKUDI', 'LOJI', 'CHRISTINE', 'F', '1996-04-18', 4),
(69,'KALENGA', 'MUTOMBO', 'MIKE', 'M', '1999-05-17', 4);





INSERT INTO etudiant(id_promotion, nom, postnom, prenom, sexe, date_naiss, id_annee)VALUES
(70,'MITANTA', 'MUSONGIELA', 'JEAN PIERRE', 'M', '1990-04-25', 5),
(70,'NYEMBO', 'MUKENDA', 'URBIAN', 'M', '1998-10-02', 5),
(70,'MPUENGIE', 'KABOBO', 'BLANDINE', 'F', '1996-10-12', 5),
(70,'KASENDWE', 'KIBAMBE', 'CHOUDEL', 'F', '2000-10-25', 5),
(70,'FRAM', 'KIYENGA', 'FRAM', 'M', '1992-10-28', 5),
(70,'KIUKA', 'MBAYO', 'HENRI', 'M', '2001-06-26', 5),
(70,'KIKUDI', 'LOJI', 'CHRISTINE', 'F', '1996-04-18', 5),
(70,'KALENGA', 'MUTOMBO', 'MIKE', 'M', '1999-05-17', 5);



CREATE VIEW CLASSEMENT_NB_ETUDIANT_ANN_PROMO AS
SELECT 
	Anne_Academique.designation AS ANNEE,  
	Anne_Academique.date_debut AS DATE_BUT,
	Anne_Academique.date_fin AS DATE_FIN,
	promotion.designation AS PROMOTION,
	count(etudiant.id_etudiant) AS NOMBRE_ETUDIANT,
	DENSE_RANK()
	OVER(ORDER BY count(etudiant.id_etudiant) DESC) AS CLASSEMENT,
	
	CASE
		WHEN count(etudiant.id_etudiant) >=10 THEN 'BON EFFECTIF'
		ELSE 'MAUVAIS EFFECIF' 
		END AS DECISION
	
	FROM etudiant
	INNER JOIN promotion ON promotion.id_promotion=etudiant.id_promotion
	INNER JOIN Anne_Academique ON Anne_Academique.id_anne=etudiant.id_annee
	GROUP BY ANNEE, PROMOTION,DATE_BUT, DATE_FIN;

DROP TABLE Tranche;
	
CREATE TABLE Tranche(
	id_tranche SERIAL NOT NULL PRIMARY KEY,
	id_annee INT NOT NULL,
	designation VARCHAR(254) NOT NULL,
	frais_fixe DECIMAL NULL,
	date_created DATE NULL DEFAULT NOW()
	CHECK(frais_fixe >=1 )
);

ALTER TABLE tranche ADD CONSTRAINT fk_anne_acad FOREIGN KEY(id_annee) REFERENCES Anne_Academique(id_anne);

SELECT * FROM tranche;


INSERT INTO tranche(id_annee, designation, frais_fixe) VALUES(2, 'TRANCHE 1', 500),
(2, 'TRANCHE 2', 600),(2, 'TRANCHE 3', 400),(3, 'TRANCHE 1', 500),
(3, 'TRANCHE 2', 600),(3, 'TRANCHE 3', 400),(4, 'TRANCHE 1', 500),
(4, 'TRANCHE 2', 600),(4, 'TRANCHE 3', 400),(5, 'TRANCHE 1', 500),
(5, 'TRANCHE 2', 600),(5, 'TRANCHE 3', 400),(6, 'TRANCHE 1', 500),
(6, 'TRANCHE 2', 600),(6, 'TRANCHE 3', 400),(7, 'TRANCHE 1', 500),
(7, 'TRANCHE 2', 600),(7, 'TRANCHE 3', 400),(8, 'TRANCHE 1', 500),
(8, 'TRANCHE 2', 600),(8, 'TRANCHE 3', 400),(9, 'TRANCHE 1', 500),
(9, 'TRANCHE 2', 600),(9, 'TRANCHE 3', 400);






DROP TABLE Paiement;
CREATE TABLE Paiement(
	id_tranche INT NOT NULL,
	id_etudiant INT NOT NULL,
	montant DECIMAL NOT NULL,
	date_created DATE NULL DEFAULT NOW(),
	PRIMARY KEY(id_tranche, id_etudiant),
	CHECK(montant >=1 )
);

ALTER TABLE Paiement ADD CONSTRAINT fk_etudiant FOREIGN KEY(id_etudiant) REFERENCES etudiant(id_etudiant);
ALTER TABLE Paiement ADD CONSTRAINT fk_tranche FOREIGN KEY(id_tranche) REFERENCES tranche(id_tranche);



SELECT * FROM etudiant;
SELECT * FROM etudiant WHERE nom='KALENGA';




INSERT INTO paiement(id_etudiant, id_tranche, montant) VALUES(2,1,250),(2,2,400),(2,3,500),
(3,1,500),(3,2,600),(3,3,500);


INSERT INTO paiement(id_etudiant, id_tranche, montant) VALUES(10,1,500),(10, 2,800),(10,3,200);


SELECT 
	etudiant.nom AS NOM,
	etudiant.postnom AS POSTNOM, 
	etudiant.prenom AS PRENOM,
	etudiant.sexe,
	Anne_Academique.designation AS ANNEE,
	promotion.designation AS PROMOTION,
	SUM(tranche.frais_fixe) AS FIXE_MONTANT,
	SUM(paiement.montant) AS MONTANT_PAYE,
	
	CASE
		WHEN SUM(tranche.frais_fixe) = SUM(paiement.montant) THEN 'EN ORDRE'
		WHEN SUM(paiement.montant) > SUM(tranche.frais_fixe) THEN 
		CONCAT('AU DELA', ' : ', SUM(paiement.montant)-SUM(tranche.frais_fixe))
		ELSE 'PAS ENCORE ATTEINT'
	END AS SITUATION_FRAIS
	FROM paiement
	INNER JOIN etudiant ON etudiant.id_etudiant=paiement.id_etudiant
	INNER JOIN tranche ON tranche.id_tranche=paiement.id_tranche
	INNER JOIN Anne_Academique ON tranche.id_annee=Anne_Academique.id_anne
	INNER JOIN promotion ON promotion.id_promotion=etudiant.id_promotion
	WHERE promotion.designation='G1 INFORMATIQUE'
	GROUP BY NOM,POSTNOM,PRENOM, SEXE,ANNEE,PROMOTION
	HAVING(SUM(paiement.montant) >= SUM(tranche.frais_fixe));



SELECT * FROM promotion;

SELECT * FROM etudiant;

CREATE TABLE Enseignant(
	id_enseignant SERIAL NOT NULL PRIMARY KEY,
	nom VARCHAR(254) NOT NULL,
	postnom VARCHAR(254) NOT NULL,
	prenom VARCHAR(254) NOT NULL,
	sexe VARCHAR(1) NOT NULL,
	date_created DATE NULL DEFAULT NOW()
);


INSERT INTO Enseignant(nom, postnom,prenom,sexe) VALUES
('NYEMBO', 'MPAMPI', 'ROGER', 'M'),
('TSHIKUTU', 'MBIKENGELA', 'ANACLET', 'M'),
('TSHILUMBA', 'NOBLA', 'HENRI', 'M'),
('KASEKA', 'VIVIANNE', 'VIVIANNE', 'F'),
('NGOYI', 'KAPENGA', 'ALEXANDRE', 'M'),
('MUTUMPE', 'GRACIA', 'GRACIA', 'F'),
('KASONGA', 'KASONGA', 'PATRICK','M'),
('KIUKA', 'MBAYO', 'HENRI', 'M'),
('EBONDO', 'MBAYO', 'PIERRE', 'M');




DROP TABLE Cours;

CREATE TABLE Cours(
	id_cours SERIAL NOT NULL PRIMARY KEY,
	id_enseignant INT NOT NULL,
	id_promotion INT NOT NULL,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT NOW()
);

ALTER TABLE Cours ADD CONSTRAINT fk_cours FOREIGN KEY(id_enseignant) REFERENCES Enseignant(id_enseignant);
ALTER TABLE Cours ADD CONSTRAINT fk_promotion_cours FOREIGN KEY(id_promotion) REFERENCES Promotion(id_promotion);
ALTER TABLE Cours ADD COLUMN note_cours INT NULL DEFAULT 20;


SELECT * FROM Cours;
SELECT * FROM promotion;

INSERT INTO Cours(id_enseignant,id_promotion, designation) VALUES(1,66, 'HTML'),(1,66, 'CSS'),(8, 68,'SQL'),(8,66,'PYTHON'),(8,67, 'DJANGO'),(8,67, 'HTML');


INSERT INTO Cours(id_enseignant,id_promotion, designation) VALUES(1,66, 'OOP'),(3,66, 'LOGIQUE'),(3, 68,'SQL'),(8,66,'JAVA'),(8,66, 'DJANGO'),(8,66, 'TELEMATIQUE'),(5,66, 'ORGANISATION D ENTREPRISE'), (6, 66, 'COMPTABILITE CG'),(7,66,'BI'), (5,66, 'PROCESS METIER'), (5, 66, 'SCALA');

SELECT * FROM cours;



CREATE TABLE NoteCours(
	id_etudiant INT NOT NULL,
	id_cours INT NOT NULL,
	note DECIMAL NOT NULL,
	date_created DATE NULL DEFAULT NOW(),
	PRIMARY KEY(id_etudiant, id_cours),
	CONSTRAINT fk_etudiant FOREIGN KEY(id_etudiant) REFERENCES etudiant(id_etudiant),
	CONSTRAINT fk_cours FOREIGN KEY(id_cours) REFERENCES cours(id_cours),
	CHECK (note <= 20)
);

SELECT * FROM NoteCours;
SELECT * FROM etudiant;

INSERT INTO NoteCours(id_etudiant, id_cours, note)
VALUES(2,1,20),(2,2,10),
(2,3,8),(2,7,15),
(2,8,11),(2,9,14),
(2,10,13),(2,11,7),
(2,12,15),(2,13,13),
(2,14,20),(2,15,10),
(2,16,9),(2,17,11);


INSERT INTO NoteCours(id_etudiant, id_cours, note)
VALUES(3,1,14),(3,2,10),
(3,3,7),(3,7,15),
(3,8,11),(3,9,14),
(3,10,20),(3,11,10),
(3,12,12),(3,13,11),
(3,14,15),(3,15,10),
(3,16,9.9),(3,17,11);



INSERT INTO NoteCours(id_etudiant, id_cours, note)
VALUES(5,1,14),(5,2,10),
(5,3,7),(5,7,15),
(5,8,18),(5,9,14),
(5,10,13),(5,11,11),
(5,12,12),(5,13,11.5),
(5,14,15.5),(5,15,14),
(5,16,15),(5,17,13);

INSERT INTO NoteCours(id_etudiant, id_cours, note)
VALUES(6,1,18),(6,2,14),
(6,3,14),(6,7,15),
(6,8,18),(6,9,14),
(6,10,13.8),(6,11,20),
(6,12,14),(6,13,20),
(6,14,15.5),(6,15,14.8),
(6,16,17),(6,17,14);

INSERT INTO NoteCours(id_etudiant, id_cours, note)
VALUES(10,1,12),(10,2,3),
(10,3,1),(10,7,15),
(10,8,8),(10,9,10),
(10,10,13.8),(10,11,20),
(10,12,4),(10,13,2),
(10,14,5),(10,15,14.8),
(10,16,1),(10,17,14);




CREATE VIEW DELIBE_SESSION1 AS 
SELECT 
	etudiant.nom AS NOM,
	etudiant.postnom AS POSTNOM,
	etudiant.prenom as PRENOM,
	etudiant.sexe AS SEXE,
	promotion.designation AS PROMOTION,
	SUM(Cours.note_cours) AS TOTAL_NOTE,
	SUM(NoteCours.note) AS TOTAL_OBTENU,
	CONCAT(ROUND(SUM((NoteCours.note) * 100) / SUM(Cours.note_cours)), ' ', '%') AS POURCENTAGE,
	CASE 
		WHEN SUM((NoteCours.note) * 100) / SUM(Cours.note_cours) > 75 THEN 'GRANDE DISTINCTION'
		WHEN SUM((NoteCours.note) * 100) / SUM(Cours.note_cours) >= 70 THEN 'DISTINCTION'
		WHEN SUM((NoteCours.note) * 100) / SUM(Cours.note_cours) >= 50 THEN 'SATISFACTION'
		ELSE 'A JOURNEE'
	END AS RESULTAT
	FROM NoteCours 
	INNER JOIN etudiant ON etudiant.id_etudiant=NoteCours.id_etudiant
	INNER JOIN Cours ON Cours.id_cours=NoteCours.id_cours
	INNER JOIN promotion ON etudiant.id_promotion=promotion.id_promotion
	GROUP BY NOM, POSTNOM, PRENOM,SEXE,PROMOTION;
	
	

SELECT * FROM etudiant;

--Les Transactions
START TRANSACTION;
SELECT * FROM etudiant;
INSERT INTO etudiant(id_promotion, nom,postnom,prenom, sexe, date_naiss, id_annee)
VALUES(69, 'NGOLO', 'MBAYO', 'DENISE', 'F', '1997-04-25', 4);
SELECT *  FROM etudiant;
COMMIT;

ROLLBACK;


SELECT * FROM etudiant;



START TRANSACTION;

SAVEPOINT point1;

ROLLBACK TO point1;
SELECT *  FROM etudiant;
COMMIT;

SELECT *  FROM etudiant;

PREPARE req FROM 'SELECT * FROM etudiant';












