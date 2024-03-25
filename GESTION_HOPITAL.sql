DROP  TABLE IF EXISTS GradeMedecin CASCADE;
DROP  TABLE IF EXISTS Salle CASCADE;
DROP  TABLE IF EXISTS Medecin CASCADE;
DROP  TABLE IF EXISTS Patient CASCADE;
DROP  TABLE IF EXISTS CategoryProduit CASCADE;
DROP  TABLE IF EXISTS FournisseurProduit CASCADE;
DROP  TABLE IF EXISTS AnneeAcquisition CASCADE;
DROP  TABLE IF EXISTS PatientExamen CASCADE;
DROP  TABLE IF EXISTS Examen CASCADE;
DROP  TABLE IF EXISTS Facture CASCADE;
DROP  TABLE IF EXISTS Produits CASCADE;
DROP  TABLE IF EXISTS ProduitFacture CASCADE;
DROP  TABLE IF EXISTS Maladie CASCADE;
DROP  TABLE IF EXISTS MaladieTraite CASCADE;
DROP TABLE IF EXISTS CategoryExamen CASCADE;


START TRANSACTION;

	CREATE TABLE GradeMedecin(
		id_grade SERIAL NOT NULL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL UNIQUE,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	
	CREATE TABLE Medecin(
		id_medecin SERIAL NOT NULL PRIMARY KEY,
		id_grade INT NOT NULL,
		nom VARCHAR(254) NOT NULL,
		postnom VARCHAR(254) NOT NULL,
		prenom VARCHAR(254) NOT NULL,
		sexe VARCHAR(1) NOT NULL,
		date_naissance DATE NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK (sexe = 'M' OR sexe = 'F'),
		CONSTRAINT fk_grade FOREIGN KEY(id_grade) REFERENCES GradeMedecin(id_grade)
	);
	
	CREATE TABLE Salle(
		id_salle SERIAL NOT NULL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL UNIQUE,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE Patient(
		id_patient SERIAL NOT NULL PRIMARY KEY,
		id_salle INT NOT NULL,
		nom VARCHAR(254) NOT NULL,
		postnom VARCHAR(254) NOT NULL,
		prenom VARCHAR(254) NOT NULL,
		sexe VARCHAR(1) NOT NULL,
		age INT NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CONSTRAINT fk_salle FOREIGN KEY(id_salle) REFERENCES Salle(id_salle),
		CHECK (sexe = 'M' OR sexe = 'F' AND age >= 1)
		
	);
	
	CREATE TABLE CategoryProduit(
		id_category SERIAL NOT NULL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL UNIQUE,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE FournisseurProduit(
		id_fournisseur SERIAL NOT NULL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL UNIQUE,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);

	CREATE TABLE AnneeAcquisition(
		id_annee SERIAL NOT NULL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL UNIQUE,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE Produits(
		id_produit SERIAL NOT NULL PRIMARY KEY,
		id_category INT NOT NULL,
		id_fournisseur INT NOT NULL,
		id_annee INT NOT NULL,
		designation VARCHAR(254) NOT NULL,
		quantite INT NOT NULL,
		prix_unitaire MONEY NOT NULL,
		sous_total MONEY GENERATED ALWAYS AS (prix_unitaire * quantite) STORED,
		CONSTRAINT fk_categoryProduit FOREIGN KEY(id_category) REFERENCES CategoryProduit(id_category),
		CONSTRAINT fk_fournisseur FOREIGN KEY(id_fournisseur) REFERENCES FournisseurProduit(id_fournisseur),
		CONSTRAINT fk_annee FOREIGN KEY(id_annee) REFERENCES AnneeAcquisition(id_annee),
		CHECK (quantite >= 1 AND CAST(prix_unitaire AS DECIMAL) >= 1)
	);
	
	CREATE TABLE Maladie(
		id_maladie SERIAL NOT NULL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL UNIQUE,
		prix MONEY NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK (CAST(prix AS DECIMAL) >= 1)
	);
	
	
	CREATE TABLE MaladieTraite(
		id_patient INT NOT NULL,
		id_maladie INT NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		PRIMARY KEY(id_patient, id_maladie),
		CONSTRAINT fk_maladie FOREIGN KEY(id_maladie) REFERENCES Maladie(id_maladie),
		CONSTRAINT fk_patient FOREIGN KEY(id_patient) REFERENCES Patient(id_patient)
		
	);
	
	CREATE TABLE Facture(
		id_facture SERIAL NOT NULL PRIMARY KEY,
		id_patient INT NOT NULL,
		CONSTRAINT fk_patients FOREIGN KEY(id_patient) REFERENCES Patient(id_patient),
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE ProduitFacture(
		id_facture INT NOT NULL,
		id_produit INT NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		PRIMARY KEY(id_facture,id_produit),
		CONSTRAINT fk_facture FOREIGN KEY(id_facture) REFERENCES Facture(id_facture),
		CONSTRAINT fk_produits FOREIGN KEY(id_produit) REFERENCES Produits(id_produit)
	);
	
	CREATE TABLE CategoryExamen(
		id_categoryExamen SERIAL NOT NULL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL UNIQUE,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);

	CREATE TABLE Examen(
		id_examen SERIAL NOT NULL PRIMARY KEY,
		id_categoryExamen INT NOT NULL,
		designation VARCHAR(254) NOT NULL UNIQUE,
		prix MONEY NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CONSTRAINT fk_categoryexamen FOREIGN KEY(id_categoryExamen) REFERENCES CategoryExamen(id_categoryExamen),
		CHECK (CAST(prix AS DECIMAL) >= 1)
	);
	
	CREATE TABLE PatientExamen(
		id_patientExamen SERIAL NOT NULL PRIMARY KEY,
		id_medecin INT NOT NULL,
		id_examen INT NOT NULL,
		id_patient INT NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CONSTRAINT fk_patient_examen FOREIGN KEY(id_patient) REFERENCES Patient(id_patient),
		CONSTRAINT fk_medecin_examen FOREIGN KEY(id_medecin) REFERENCES Medecin(id_medecin),
		CONSTRAINT fk_examen FOREIGN KEY(id_examen) REFERENCES Examen(id_examen)
	);
	
	SELECT * FROM ProduitFacture;
	
	ALTER TABLE ProduitFacture ADD COLUMN quantite INT NOT NULL;
	ALTER TABLE ProduitFacture ADD CONSTRAINT fk_check_quantity CHECK(quantite >= 1);
	
	ALTER TABLE PatientExamen ADD COLUMN commentaire TEXT NOT NULL;
	
	
COMMIT;




SELECT * FROM FournisseurProduit;
SELECT * FROM Medecin;
SELECT * FROM GradeMedecin;


START TRANSACTION;
	INSERT INTO FournisseurProduit(designation) VALUES ('USAID'), ('PROSANI'), ('OMS'), 
	('MONUSCO'),('ICAP'), ('ENABEL'), ('CORDAID'), ('CAMELU'),('KIN MARCHE'),('JAMBO MART'),('MULYKAP');
	
	INSERT INTO GradeMedecin(designation) VALUES ('A1'), ('A2'), ('A3'), ('COMPTABLE'),('CHEF DE BUREAU'),('SECRETAIRE'),
	('CAISSIERE'),('A05'),('A COUCHEUSE'),('INFIRMIER');
	
	INSERT INTO GradeMedecin(designation) VALUES('DATA');
	
	INSERT INTO Medecin(id_grade, nom,postnom,prenom,sexe) VALUES(3, 'KIUKA', 'MBAYO', 'HENRI', 'M'),
	(4, 'KALENGA', 'MUTOMBO', 'MIKE', 'M'),(2, 'KASONGO', 'KITENGIE', 'GERMAIN', 'M'),(2, 'KIKUDI', 'LOJI', 'CHRISTINE', 'F'),
	(7, 'MPUENGUE','KABOBO', 'BLANDINE','F'), (1, 'FRAM','KIYENGA', 'FRAM', 'M'),(2, 'EBENDE', 'FUAMBA', 'ERICK', 'M'),(3, 'KABEYA', 'KAZADI', 'MARCEL', 'M'),
	(6, 'NGONGO', 'NGOBA', 'PLACIDE', 'M'),(2,'LUAMBA', 'NGOYI', 'PASCALINE', 'F'),(4,'NKONGOLO', 'MBETA', 'SIDONIE', 'F'),(5,'KIABU', 'NSOMUE', 'SOUZANIE', 'F'),
	(4, 'NSOMUE', 'NSTHIAMBA', 'PATIENT', 'M'),(4,'MATUMBA', 'KAPENGA', 'PRINCE', 'M'),(3,'KAZADI', 'NGONGO', 'RAPHAEL', 'M');
	
	INSERT INTO Medecin(id_grade, nom,postnom,prenom,sexe, date_naissance) VALUES(5, 'KISUAKA', 'MBAYO', 'MESCHACK', 'M', '2004-06-25'),
	(4,'MBUYU', 'MUTUALE', 'MIREILLE', 'F', '1998-01-28'),(8, 'KIBOGIE', 'MPAMPI', 'CORNEILLE', 'M', '1999-10-02');
	
	INSERT INTO Salle(designation) VALUES('LABORATOIRE'),('MATERNITE'),('ACOUCHEUSE'),('DEPOT PHARMACEUIQUE'),('URGENCE'),('RAILLANT'),
	('SALLE D''ATENTE'),('SALLE D''OPERATION');
	
COMMIT;

ROLLBACK;




SELECT 
	GradeMedecin.designation AS GRADES,
	COUNT(Medecin.id_medecin) AS NOMBRE_MEDECIN
	FROM Medecin
	RIGHT JOIN GradeMedecin USING(id_grade)
	GROUP BY GRADES ORDER BY NOMBRE_MEDECIN DESC;

SELECT 
	GradeMedecin.designation AS GRADES,
	COUNT(Medecin.id_medecin) AS NOMBRE_MEDECIN
	FROM Medecin
	JOIN GradeMedecin USING(id_grade)
	GROUP BY GRADES ORDER BY GRADES;

SELECT 
	GradeMedecin.designation AS GRADES,
	COUNT(Medecin.id_medecin) AS NOMBRE_MEDECIN,
	SUM(CASE WHEN Medecin.sexe = 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN Medecin.sexe = 'F' THEN 1 ELSE 0 END) AS FEMMES
	FROM Medecin
	JOIN GradeMedecin USING(id_grade)
	GROUP BY GRADES ORDER BY GRADES;



SELECT 
	GradeMedecin.designation AS GRADES,
	COUNT(Medecin.id_medecin) AS NOMBRE_MEDECIN,
	SUM(CASE WHEN Medecin.sexe = 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN Medecin.sexe = 'F' THEN 1 ELSE 0 END) AS FEMMES
	FROM Medecin
	JOIN GradeMedecin USING(id_grade)
	GROUP BY GROUPING SETS((GradeMedecin.designation), ()) ORDER BY GRADES;
	

SELECT 
	COALESCE(GradeMedecin.designation, 'TOTAL GENERAL') AS GRADES,
	COUNT(Medecin.id_medecin) AS NOMBRE_MEDECIN,
	SUM(CASE WHEN Medecin.sexe = 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN Medecin.sexe = 'F' THEN 1 ELSE 0 END) AS FEMMES
	FROM Medecin
	JOIN GradeMedecin USING(id_grade)
	GROUP BY GROUPING SETS((GradeMedecin.designation), ()) ORDER BY GRADES;


SELECT sexe,COUNT(*) FROM Medecin
	GROUP BY sexe;





SELECT * FROM Medecin;
SELECT * FROM GradeMedecin;

DELETE FROM GradeMedecin WHERE id_grade = 10;

UPDATE GradeMedecin SET designation='DATA ANALYSTE' WHERE id_grade = 11;

SELECT *,
	CASE 
		WHEN date_naissance IS NOT NULL THEN 'IL A UNE DATE DE NAISS'
		ELSE 'IL N''A PAS DES DATES DES NAISSANCES'
	END AS DECISION
FROM Medecin;



SELECT * FROM Medecin WHERE date_naissance IS NULL;
SELECT * FROM Medecin WHERE date_naissance IS NOT NULL;

SELECT * FROM GradeMedecin WHERE id_grade IN(SELECT id_grade FROM Medecin);




INSERT INTO AnneeAcquisition(designation) VALUES ('2001'),('2002'),('2003'),('2004'),
('2005'),('2006'),('2007'),('2008'),('2009'),('2010'),('2011'),('2012'),('2013'),('2014'),
('2015'),('2016'),('2017'),('2018'),('2019'),('2020'),('2021'),('2022'),('2023'),('2024')
RETURNING *;


SELECT * FROM CategoryProduit;

INSERT INTO CategoryProduit(designation) VALUES('ENFANT'), ('FEMMES'),('HOMMES'),('0-5 ANS'),('0-3 MOIS'),('10-17 ANS'),('65 ANS HOMMES FEMMES')
RETURNING *;

SELECT * FROM Produits;
SELECT * FROM FournisseurProduit;

INSERT INTO Produits(id_category, id_fournisseur, id_annee, designation, quantite, prix_unitaire)
VALUES(5, 3, 12, 'PARACETAMOL', 250, 300) RETURNING *;


INSERT INTO Produits(id_category, id_fournisseur, id_annee, designation, quantite, prix_unitaire)
VALUES(7, 3, 12, 'PARACETAMOL', 400, 750),(1,6,14, 'DEXA', 32,150),(4,10,24, 'FLAGILE', 150, 250),
(1, 4,24, 'MALADOXE', 410, 305),(3,4,24,'DICLOFENAC', 78, 200),(2,7,23,'QUININE 050', 255, 650),(2,5,5,'PERFUSION', 25, 2500),
(1, 4, 5, 'MEPROBAMATE', 350, 1250),(3, 6,16, 'DOLAREIN', 45, 150),(2,6,16,'PROMETHAZINE',65, 350),(1, 5,5,'PARACETAMOL', 85, 850),
(5,5,6, 'RELIEF', 450, 1500),(3,11,16,'ANAFLAM', 12, 1200)
RETURNING *;


SELECT
	FournisseurProduit.id_fournisseur AS ID_FOURNISSEURS,
	FournisseurProduit.designation AS FOURNISSEURS,
	COUNT(produits.id_produit) AS NOMBRE_PRODUITS,
	SUM(produits.sous_total) AS SOUS_TOTAL
	FROM FournisseurProduit
	JOIN Produits USING(id_fournisseur)
	GROUP BY ID_FOURNISSEURS,FOURNISSEURS;
	
	
SELECT
	COALESCE(CAST(FournisseurProduit.id_fournisseur AS TEXT), '-') AS ID_FOURNISSEURS,
	COALESCE(FournisseurProduit.designation, 'TOTAL GENERAL') AS FOURNISSEURS,
	COUNT(produits.id_produit) AS NOMBRE_PRODUITS,
	SUM(CASE WHEN categoryProduit.designation = 'ENFANT' THEN 1 ELSE 0 END) AS CATEGORY_ENFANT,
	SUM(CASE WHEN categoryProduit.designation = 'HOMMES' THEN 1 ELSE 0 END) AS CATEGORY_HOMMES,
	SUM(CASE WHEN categoryProduit.designation = 'FEMMES' THEN 1 ELSE 0 END) AS CATEGORY_FEMMES,
	SUM(CASE WHEN categoryProduit.designation = '0-5 ANS' THEN 1 ELSE 0 END) AS CATEGORY_0_A_5_ANS,
	SUM(CASE WHEN categoryProduit.designation = '0-3 MOIS' THEN 1 ELSE 0 END) AS CATEGORY_0_3_MOIS,
	SUM(CASE WHEN categoryProduit.designation = '65 ANS HOMMES FEMMES' THEN 1 ELSE 0 END) AS CATEGORY_HOMMES_FEMMES_65_ANS,
	SUM(produits.sous_total) AS SOUS_TOTAL
	FROM FournisseurProduit
	JOIN Produits USING(id_fournisseur)
	JOIN categoryProduit USING(id_category)
	GROUP BY GROUPING SETS ((FournisseurProduit.id_fournisseur,FournisseurProduit.designation), ())
	ORDER BY FOURNISSEURS;
	
	
SELECT
	AnneeAcquisition.designation AS ANNEE,
	COUNT(produits.id_produit) AS NOMBRE_PRODUITS,
	SUM(produits.sous_total) AS SOUS_TOTAL,
	DENSE_RANK()
	OVER(ORDER BY SUM(produits.sous_total) DESC) CLASSEMENT
	FROM AnneeAcquisition
	JOIN Produits USING(id_annee)
	GROUP BY ANNEE;	
	
	

SELECT
	AnneeAcquisition.designation AS ANNEE,
	COUNT(produits.id_produit) AS NOMBRE_PRODUITS,
	SUM(produits.sous_total) AS SOUS_TOTAL,
	LAG(SUM(produits.sous_total),6,0::MONEY) 
		OVER(ORDER BY AnneeAcquisition.designation DESC) AS COMPARAISON
	FROM AnneeAcquisition
	JOIN Produits USING(id_annee)
	GROUP BY ANNEE;
	

SELECT
	AnneeAcquisition.designation AS ANNEE,
	COUNT(produits.id_produit) AS NOMBRE_PRODUITS,
	SUM(produits.sous_total) AS SOUS_TOTAL,
	LEAD(SUM(produits.sous_total),1,0::MONEY) 
		OVER(ORDER BY AnneeAcquisition.designation DESC) AS COMPARAISON
	FROM AnneeAcquisition
	JOIN Produits USING(id_annee)
	GROUP BY ANNEE;
	
	
SELECT
	AnneeAcquisition.designation AS ANNEE,
	COUNT(produits.id_produit) AS NOMBRE_PRODUITS,
	SUM(produits.sous_total) AS SOUS_TOTAL,
	NTILE(3) OVER(ORDER BY SUM(produits.sous_total) DESC) AS GROUPEMENT
	FROM AnneeAcquisition
	JOIN Produits USING(id_annee)
	GROUP BY ANNEE;
	

SELECT * FROM CategoryProduit WHERE id_category IN(SELECT id_category FROM Produits);
	
SELECT * FROM Produits WHERE id_fournisseur=5;
	
SELECT
	AnneeAcquisition.designation AS ANNEE,
	COUNT(Produits.id_produit) AS NOMBRE_PRODUITS,
	SUM(CASE WHEN CategoryProduit.designation = 'ENFANT' THEN 1 ELSE 0 END) AS CATEGORY_ENFANT,
	SUM(CASE WHEN CategoryProduit.designation = 'HOMMES' THEN 1 ELSE 0 END) AS CATEGORY_HOMMES,
	SUM(CASE WHEN CategoryProduit.designation = 'FEMMES' THEN 1 ELSE 0 END) AS CATEGORY_FEMMES,
	SUM(CASE WHEN CategoryProduit.designation = '0-5 ANS' THEN 1 ELSE 0 END) AS CATEGORY_0_5_ANS,
	SUM(CASE WHEN CategoryProduit.designation = '0-3 MOIS' THEN 1 ELSE 0 END) AS CATEGORY_0_3_MOIS,
	SUM(CASE WHEN CategoryProduit.designation = '65 ANS HOMMES FEMMES' THEN 1 ELSE 0 END) AS CATEGORY_65_ANS_HOMMES_FEMMES,
	SUM(Produits.sous_total) AS SOMMES_PRODUITS
	FROM AnneeAcquisition
	JOIN Produits USING(id_annee)
	JOIN CategoryProduit USING(id_category)
	GROUP BY ANNEE;
	

SELECT * FROM Produits;
	
	
SELECT 
	Produits.designation AS PRODUITS,
	CategoryProduit.designation AS CATEGORY,
	SUM(Produits.sous_total) 
		OVER(PARTITION BY CategoryProduit.designation ORDER BY CategoryProduit.designation) AS PARTITIONNEMENT
	FROM Produits
	JOIN CategoryProduit USING(id_category)
	ORDER BY CATEGORY;


SELECT * FROM Salle WHERE id_salle IN(SELECT id_salle FROM Patient);


SELECT * FROM Salle;
SELECT * FROM Patient;



INSERT INTO Patient(id_salle, nom, postnom, prenom, sexe, age) VALUES(3, 'KASONGO', 'FUAMBA', 'FIDELIE', 'F',27),
(2,'MUTUMPE', 'KALUNGA', 'RACHEL', 'F', 22),(7,'LUBAMBA', 'KIBAMBE', 'LANGAYI', 'M',55),(2,'KASONGO', 'KITENGIE', 'SHEKINAH', 'F', 24),
(4,'KUNDA', 'FUAMBA', 'DELPHIN', 'M', 30),(2, 'KALENGA', 'NGANDU', 'NASSER', 'M', 24),(3,'FRAM', 'KIYENGA','FRAM', 'M', 29),
(6, 'KABEMBA', 'YA LUMAMI', 'KAS', 'M', 36),(2, 'NKONGOLO', 'LUMAMI', 'DENISE','F', 26),(3, 'KABEDI', 'KALUBI', 'LUCIANNE','F', 24),
(5, 'FUMUNI', 'BUTAKAR', 'GERMAINE', 'F', 25),(1, 'MBUYU', 'LONGO', 'ID', 'M',25),(4,'KAZAD', 'NACIBAD', 'FELICITE','F', 24),
(4, 'KIUKA', 'MBAYO', 'HENRI', 'M', 20),(2, 'NGANDU', 'KALENGA', 'ALICE', 'F',27),(4, 'BANGULA', 'BANGULA', 'ANTOINE', 'M', 67),
(2, 'FERNAND', 'ALI', 'FERNAND', 'M',34),(6,'KABUYA', 'KABUYA','ARSENE', 'M', 31),(4,'MAKUKA', 'MAKUKA', 'VERDI', 'M', 57),
(1, 'LUSANGA', 'ILUNGA', 'JULES CESAR', 'M', 20);

INSERT INTO Patient(id_salle, nom, postnom, prenom, sexe, age) VALUES(5, 'KASONGO', 'KIABU', 'FK 02','M', 20),
(2, 'MUEMBO', 'ELUNGU', 'ANDRE', 'M', 28),(3, 'YANKAMBI', 'DIBUE', 'JEAN PIERRE', 'M', 48),(3, 'MUIKIEMUNE', 'LUMONGA', 'NYINA HENRI', 'M', 46),
(3, 'KIOMBA', 'KALONDA', 'ERICK', 'M', 47),(4,'EBENDE', 'FUAMBA', 'ERICK', 'M', 59),(5,'BUKULA', 'FUAMBA', 'TONTON', 'M',69),
(2, 'YA LUENYI','KIBONGIE', 'ANDRE', 'M',35),(2, 'KABIKA', 'MBETA', 'MARCELINE', 'F', 26),(5,'KIKUDI', 'LOJI', 'CHRISTINE', 'F', 28),
(7, 'KAPAFULE', 'YAMPUA', 'CHRISTINE', 'F', 16),(4, 'KIMANKINDA', 'YAMPUA', 'JOSE','F',18),(6,'EBENDE','BUKULA', 'DAVID', 'M',15);




SELECT
	Salle.designation AS SALLES,
	COUNT(Patient.id_patient) AS NOMBRE_PATIENTS
	FROM Salle
	JOIN Patient USING(id_salle)
	GROUP BY SALLES;


SELECT
	COALESCE(Salle.designation, 'TOTAL GENERAL') AS SALLES,
	COUNT(Patient.id_patient) AS NOMBRE_PATIENTS
	FROM Salle
	JOIN Patient USING(id_salle)
	GROUP BY GROUPING SETS((Salle.designation), ())
	ORDER BY NOMBRE_PATIENTS;


SELECT
	Salle.designation AS SALLES,
	SUM(CASE WHEN Patient.sexe = 'M' THEN 1 ELSE 0 END) AS NOMBRE_HOMMES,
	SUM(CASE WHEN Patient.sexe = 'F' THEN 1 ELSE 0 END) AS NOMBRE_FEMMES,
	COUNT(Patient.id_patient) AS NOMBRE_PATIENTS
	FROM Salle
	JOIN Patient USING(id_salle)
	WHERE Patient.age <= (SELECT age FROM Patient WHERE age = 18)
	GROUP BY SALLES;

SELECT * FROM Patient WHERE age > 18;


SELECT
	Salle.designation AS SALLES,
	SUM(CASE WHEN Patient.sexe = 'M' THEN 1 ELSE 0 END) AS NOMBRE_HOMMES,
	SUM(CASE WHEN Patient.sexe = 'F' THEN 1 ELSE 0 END) AS NOMBRE_FEMMES,
	COUNT(Patient.id_patient) AS NOMBRE_PATIENTS
	FROM Salle
	JOIN Patient USING(id_salle)
	WHERE Patient.age >= (SELECT age FROM Patient WHERE age = 18)
	GROUP BY SALLES;


SELECT * FROM Patient;

EXPLAIN SELECT * FROM Patient 
	WHERE age = (SELECT age FROM Patient WHERE id_patient=6) AND id_salle = (SELECT id_salle FROM Salle WHERE id_salle=2);


SELECT * FROM Produits;


SELECT * FROM Facture;
SELECT * FROM ProduitFacture;
SELECT * FROM Produits;

INSERT INTO Facture(id_patient) VALUES (2),(30) RETURNING *;



START TRANSACTION;

	INSERT INTO ProduitFacture(id_facture,id_produit, quantite) VALUES(1, 1, 30),(1,40,10);
	UPDATE Produits SET quantite=quantite - 30 WHERE id_produit = 1;
	UPDATE Produits SET quantite=quantite - 10 WHERE id_produit = 40;
	
	SAVEPOINT Save_pointInsertProduct1;

	INSERT INTO ProduitFacture(id_facture,id_produit, quantite) VALUES(2, 1, 10),(2,40,1);
	UPDATE Produits SET quantite=quantite - 10 WHERE id_produit = 1;
	UPDATE Produits SET quantite=quantite - 1 WHERE id_produit = 40;
	SAVEPOINT Save_pointInsertProduct2;
	
	ROLLBACK TO Save_pointInsertProduct1;
	
	INSERT INTO ProduitFacture(id_facture,id_produit, quantite) VALUES(1, 39, 10);
	UPDATE Produits SET quantite=quantite - 10 WHERE id_produit = 39;
	SAVEPOINT Save_pointInsertProduct3;

COMMIT;

ROLLBACK;






---------------------------------------------PROCEDURE STOCKEES------------------------------------------------------

CREATE OR REPLACE PROCEDURE InsertProduitToFacture(_id_facture INT,_id_produit INT, _quantite INT) 
	LANGUAGE SQL AS $$;
		INSERT INTO ProduitFacture(id_facture,id_produit, quantite) VALUES(_id_facture,_id_produit, _quantite);
		UPDATE Produits SET quantite=quantite - _quantite WHERE id_produit=_id_produit;
	$$;
	

	
CALL InsertProduitToFacture(1, 29,20);


SELECT * FROM Produits 
	WHEN quantite >=200 THEN INSERT INTO Produits(id_category,id_fournisseur,id_annee,designation, quantite,prix_unitaire) WHERE 




SELECT * FROM ProduitFacture;

SELECT 
	Patient.nom AS NOM,
	Patient.postnom AS POSTNOM,
	Patient.prenom AS PRENOM,
	Patient.sexe AS SEXE,
	COUNT(DISTINCT(facture.id_facture)) AS NOMBRE_FACTURE_A_PAYEES,
	COUNT(produits.id_produit) AS NOMBRE_PRODUITS,
	COALESCE(SUM(ProduitFacture.quantite), 0) AS QUANTITE_PRODUITS,
	COALESCE(SUM(produits.prix_unitaire), 0::MONEY) AS PRIX_UNITAIRE_TOTAL,
	COALESCE(SUM(produits.prix_unitaire) * SUM(ProduitFacture.quantite), 0::MONEY) AS TOTAL_PRODUITS_A_PAYE
	FROM Patient
	JOIN Facture USING(id_patient)
	LEFT JOIN ProduitFacture USING(id_facture)
	LEFT JOIN Produits USING(id_produit)
	GROUP BY NOM, POSTNOM,PRENOM,SEXE;
	
CREATE VIEW V_FACTURE_PRODUITS_MALADES AS	
	SELECT 
		Patient.nom AS NOM,
		Patient.postnom AS POSTNOM,
		Patient.prenom AS PRENOM,
		Patient.sexe AS SEXE,
		COUNT(DISTINCT(facture.id_facture)) AS NOMBRE_FACTURE_A_PAYEES,
		COUNT(produits.id_produit) AS NOMBRE_PRODUITS,
		COALESCE(SUM(ProduitFacture.quantite), 0) AS QUANTITE_PRODUITS,
		COALESCE(SUM(produits.prix_unitaire), 0::MONEY) AS PRIX_UNITAIRE_TOTAL,
		COALESCE(SUM(produits.prix_unitaire) * SUM(ProduitFacture.quantite), 0::MONEY) AS TOTAL_PRODUITS_A_PAYE
		FROM Patient
		JOIN Facture USING(id_patient)
		LEFT JOIN ProduitFacture USING(id_facture)
		LEFT JOIN Produits USING(id_produit)
		GROUP BY NOM, POSTNOM,PRENOM,SEXE,Facture.date_creation
		ORDER BY Facture.date_creation DESC;

	
	
	
	
SELECT * FROM Facture;

SELECT SUM(quantite) FROM  ProduitFacture WHERE id_facture=1;
SELECT * FROM  ProduitFacture WHERE id_facture=1;

SELECT SUM(prix_unitaire) FROM Produits WHERE id_produit IN(SELECT id_produit FROM ProduitFacture);

SELECT 
	ProduitFacture.id_facture AS ID_FACT,
	COUNT(Produits.id_produit) ID_PROD,
	SUM(Produits.prix_unitaire) * SUM(ProduitFacture.quantite) AS SOMME_PAYE
	FROM ProduitFacture
	JOIN Produits USING(id_produit)
	GROUP BY ID_FACT;
	
	
	
SELECT * FROM Facture;
INSERT INTO Facture(id_patient) VALUES(2);
SELECT * FROM ProduitFacture;

SELECT * FROM Produits;

CALL InsertProduitToFacture(2, 39,30);

CALL InsertProduitToFacture(5, 30,3);
CALL InsertProduitToFacture(5, 34,5);

CALL InsertProduitToFacture(1, 33,112);

SELECT * FROM ProduitFacture;

UPDATE ProduitFacture SET quantite=2  WHERE id_facture = 5 AND id_produit=30;

INSERT INTO Facture(id_patient) VALUES(21);
	
SELECT * FROM V_FACTURE_PRODUITS_MALADES;



---------------------------- CREATION DES TRIGGERS -------------------------------

CREATE OR REPLACE FUNCTION Update_QuantiteProduitFacture() RETURNS TRIGGER AS $$
	BEGIN
		IF 
			NEW.quantite < OLD.quantite THEN 
				UPDATE Produits SET quantite = quantite + OLD.quantite - NEW.Quantite WHERE id_produit=NEW.id_produit;
		END IF;
		RETURN NEW;
	END;

$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION FilterQuantiteProduitStock() RETURNS TRIGGER AS $$
	BEGIN
		IF NEW.quantite > (SELECT quantite + OLD.quantite FROM Produits WHERE id_produit=NEW.id_produit) THEN
			RAISE NOTICE 'Impossible la quantité en stock est inféreure !';
		END IF;
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;


DROP FUNCTION FilterQuantiteProduitStock() CASCADE;



CREATE OR REPLACE TRIGGER 
	updateProduitFacture 
	AFTER UPDATE ON ProduitFacture FOR EACH ROW 
	EXECUTE PROCEDURE Update_QuantiteProduitFacture();


CREATE OR REPLACE TRIGGER 
	FilterQuantiteProduitStocks
	BEFORE INSERT OR UPDATE ON ProduitFacture FOR EACH ROW 
	EXECUTE PROCEDURE FilterQuantiteProduitStock();


SELECT * FROM Medecin;


SELECT * FROM AnneeAcquisition;

SELECT * FROM Produits;

SELECT * FROM Patient;

SELECT * FROM Patient WHERE age = (SELECT MIN(age) FROM Patient WHERE sexe = 'M');
SELECT * FROM Patient WHERE age = (SELECT MIN(age) FROM Patient WHERE sexe = 'F');
EXPLAIN SELECT * FROM Patient WHERE age = (SELECT MIN(age) FROM Patient);

SELECT * FROM Patient WHERE age = (SELECT MAX(age) FROM Patient);


INSERT INTO Patient(id_salle, nom,postnom, prenom,sexe, age) VALUES(5 ,'KAPEPULA', 'MUKONKOLE', 'ALAIN', 'M', 15) RETURNING *;

SELECT * FROM Patient;
SELECT * FROM Patient_CopyData2;
SELECT * FROM Patient_CopyData3;

DROP TABLE Patient_CopyData;
DROP TABLE Patient_CopyData2;
DROP TABLE Patient_CopyData3;

CREATE TABLE Patient_CopyData AS SELECT * FROM Patient;

CREATE TABLE Patient_CopyData2 AS SELECT * FROM Patient WITH DATA;
CREATE TABLE Patient_CopyData3 AS SELECT * FROM Patient WITH NO DATA;


SELECT * FROM Patient_CopyData;

SELECT * FROM Produits;

SELECT 
	CategoryProduit.id_category AS ID_CATEGORY,
	CategoryProduit.designation AS CATEGORY,
	COUNT(Produits.id_produit) NOMBRE_PRODUIT
	FROM Produits
	JOIN CategoryProduit USING(id_category)
	GROUP BY CategoryProduit.id_category,CATEGORY;
	
	
	
	
SELECT Produits.designation AS PRODUITS,
	CategoryProduit.designation AS CATEGORY,
	COUNT(Produits.id_category) NOMBRE_PRODUIT 
	FROM Produits
	JOIN CategoryProduit USING(id_category)
	GROUP BY PRODUITS,CATEGORY;
	
	
SELECT TEMPO.id_category,P.designation AS PRODUIT,P.quantite AS QUANTITE, P.Prix_unitaire AS PU, P.sous_total FROM(
	SELECT * FROM CategoryProduit 
		WHERE id_category IN(SELECT id_category 
							 FROM Produits
							 GROUP BY id_category
							 HAVING COUNT(id_category) <= 1
							)) AS TEMPO, Produits P WHERE TEMPO.id_category=P.id_category;


SELECT * FROM FournisseurProduit;

SELECT * FROM Produits;

SELECT
	FournisseurProduit.id_fournisseur AS ID_FOURNISSEURS,
	FournisseurProduit.designation AS FOURNISSEURS,
	COUNT(Produits.id_produit) AS NOMBRE_PRODUITS
	FROM Produits
	JOIN FournisseurProduit USING(id_fournisseur)
	GROUP BY ID_FOURNISSEURS, FOURNISSEURS;


SELECT
	FournisseurProduit.id_fournisseur AS ID_FOURNISSEURS,
	FournisseurProduit.designation AS FOURNISSEURS,
	COUNT(Produits.id_produit) AS NOMBRE_PRODUITS
	FROM Produits
	JOIN FournisseurProduit USING(id_fournisseur)
	GROUP BY ID_FOURNISSEURS, FOURNISSEURS HAVING(COUNT(Produits.id_produit)) < (SELECT COUNT(*) FROM Produits WHERE id_fournisseur=3 GROUP BY id_fournisseur);



SELECT 
	AnneeAcquisition.designation AS ANNEE
	FROM AnneeAcquisition;
	

SELECT 
	AnneeAcquisition.id_annee AS ID_ANNEE,
	AnneeAcquisition.designation AS ANNEE,
	COUNT(Produits.id_produit) AS NOMBRE_PRODUIT
	FROM AnneeAcquisition
	JOIN Produits USING(id_annee)
	GROUP BY ID_ANNEE,ANNEE;
	


SELECT 
	AnneeAcquisition.id_annee AS ID_ANNEE,
	AnneeAcquisition.designation AS ANNEE,
	COUNT(Produits.id_produit) AS NOMBRE_PRODUIT
	FROM AnneeAcquisition
	JOIN Produits USING(id_annee)
	GROUP BY ID_ANNEE,ANNEE HAVING(COUNT(Produits.id_produit)) = (SELECT COUNT(*) FROM Produits WHERE id_annee=23 GROUP BY id_annee);


INSERT INTO CategoryExamen(designation) VALUES('LABO'),('MATERNITE'),('LEPRE') RETURNING *;

INSERT INTO Examen(id_categoryexamen, designation, prix) VALUES(1, 'Examen de labo de sang', 6500),
(1, 'Examen de Labo pour le groupe sangin', 9500),(1, 'Pré-utilisation des medicaments avant injection aux patients', 14500),
(2, 'Chaque vendredi pour les femmes enceintes', 6500),(3, 'Pour question de lutter contre la lepre chaque jeudi les personnes souffrants de cette maladie doivent être traitées et soignées', 5500)
RETURNING *;

SELECT * FROM CategoryExamen;
SELECT * FROM Examen;

SELECT * FROM PatientExamen;

SELECT * FROM Examen WHERE prix = (SELECT prix FROM Examen WHERE id_examen=1);

INSERT INTO PatientExamen(id_medecin, id_examen, id_patient ,commentaire) VALUES (5, 1, 34, 'Après avoir enceinté une fille, ce Monsieur a demande de passer un test des sangs avec sa copine afin de s''assurer que la grossesse est pour lui') RETURNING *;

SELECT * FROM Medecin WHERE id_medecin IN(SELECT id_medecin FROM PatientExamen);
SELECT * FROM Examen WHERE id_examen IN(SELECT id_medecin FROM PatientExamen);

SELECT * FROM Medecin;
SELECT * FROM Patient;

SELECT * FROM ProduitFacture;


SELECT 
	Patient.nom AS NOM_PATIENT
	FROM Patient, Facture
	WHERE Patient.id_patient = Facture.id_patient;
	

SELECT 
	Patient.nom AS NOM_PATIENT,
	Patient.postnom AS POSTNOM_PATIENT,
	Patient.prenom AS PRENOM_PATIENT,
	Patient.sexe AS SEXE_PATIENT,
	COUNT(Facture.id_facture) AS NOMBRE_FACTURE
	FROM Patient
	JOIN Facture USING(id_patient)
	GROUP BY NOM_PATIENT,POSTNOM_PATIENT,PRENOM_PATIENT,SEXE_PATIENT
	HAVING(COUNT(Facture.id_facture)) = (SELECT COUNT(id_facture) FROM Facture 
										 WHERE id_patient = 2 GROUP BY id_patient);
	

SELECT * FROM Facture;


SELECT SUM(sous_total) FROM Produits;

SELECT 
	COALESCE(id_produit::VARCHAR, '-'),
	COALESCE(designation, 'TOTAL GENERAL') AS PRODUITS,
	COALESCE(quantite,SUM(quantite)) AS QUANTITE,
	COALESCE(prix_unitaire, SUM(prix_unitaire)) AS PU,
	COALESCE(sous_total, SUM(sous_total)) AS SOUS_TOTAL 
	FROM Produits
	GROUP BY GROUPING SETS((id_produit,designation,quantite,prix_unitaire,sous_total),());

	
SELECT * FROM Patient;


SELECT * FROM Patient WHERE nom LIKE 'K%';

SELECT * FROM Patient WHERE nom LIKE '%A';

SELECT * FROM Patient WHERE nom LIKE '%K%';


SELECT * FROM Patient WHERE nom LIKE 'K____A';



SELECT * FROM Patient LIMIT 4 OFFSET 2;

SELECT * FROM Produits;

SELECT produits.designation AS PROD,
		COUNT(DISTINCT(Produits.id_fournisseur)) AS Nb_F
		FROM Produits
		GROUP BY PROD;

SELECT produits.designation AS PROD,
		COUNT(DISTINCT(Produits.id_fournisseur)) AS Nb_F
		FROM Produits
		GROUP BY PROD HAVING(COUNT(DISTINCT(Produits.id_fournisseur))) >= 2;
		

SELECT * FROM Produits
	WHERE designation = ANY(SELECT designation 
							FROM Produits 
							GROUP BY designation 
							HAVING(COUNT(DISTINCT(Produits.id_fournisseur))) >= 2 );

SELECT 
	Produits.designation AS PRODUITS,
	COUNT(DISTINCT(produits.id_fournisseur)) AS NOMBRE_FOURNISSEURS
	FROM Produits
	GROUP BY PRODUITS;


SELECT
	COUNT(*) FROM Produits
	GROUP BY id_fournisseur;


SELECT * FROM Produits;
SELECT * FROM CategoryProduit;
SELECT * FROM FournisseurProduit;

INSERT INTO Produits(id_category, id_fournisseur, id_annee, designation, quantite, prix_unitaire) 
VALUES(2, 1,21, 'TETRA', 450,150),(1, 2, 21,'TETRA', 450, 200), (3, 4,4, 'TETRA', 300,300),(5, 8, 8, 'TETRA', 100, 50)
RETURNING *;


SELECT
	FournisseurProduit.designation FOURNISSEURS,
	AnneeAcquisition.designation ANNEES,
	COUNT(Produits.id_produit) NOMBRE_PRODUIT
	FROM FournisseurProduit
	JOIN Produits USING(id_fournisseur)
	JOIN AnneeAcquisition USING(id_annee)
	GROUP BY ROLLUP (FournisseurProduit.designation),(AnneeAcquisition.designation) ORDER BY ANNEES DESC;
	
SELECT
	COALESCE(AnneeAcquisition.designation, 'TOTAL GENERAL') ANNEES,
	COUNT(Produits.id_produit) NOMBRE_PRODUIT
	FROM Produits
	JOIN AnneeAcquisition USING(id_annee)
	GROUP BY ROLLUP(AnneeAcquisition.designation) ORDER BY ANNEES;


SELECT * FROM Produits;

SELECT 
	CategoryProduit.id_category AS ID_CATEGORYS,
	CategoryProduit.designation AS CATEGORY,
	SUM(Produits.sous_total) AS NOMBRE_PRODUIT
	FROM Produits
	JOIN CategoryProduit USING(id_category)
	GROUP BY ID_CATEGORYS,CATEGORY;


SELECT * FROM Produits
	WHERE id_category IN(SELECT id_category
						 FROM Produits
						 GROUP BY id_category 
						 HAVING(COUNT(produits.id_produit)) >= 4);
						 
SELECT * FROM Produits
	WHERE id_category IN(SELECT id_category
						 FROM Produits
						 GROUP BY id_category 
						 HAVING(SUM(produits.sous_total)) = 37000::MONEY);


SELECT * FROM Produits
	WHERE id_category IN(SELECT id_category
						 FROM Produits
						 GROUP BY id_category 
						 HAVING(SUM(produits.sous_total)) < (SELECT sous_total 
															 FROM Produits 
															 WHERE id_produit=30));



SELECT 
	id_category,
	COUNT(id_produit) NOMBRE_PRODUIT,
	SUM(sous_total) SOUS_TOTAL
	FROM Produits
	GROUP BY id_category;

SELECT * FROM FournisseurProduit;
						 
SELECT * FROM CategoryProduit WHERE id_category  NOT IN(SELECT id_category FROM Produits);

INSERT INTO Produits(id_category, id_fournisseur, id_annee, designation, quantite, prix_unitaire) VALUES(6,10, 10,'VITAMINE C', 10, 10),(6,11,10,'POW PLUS', 20,250) RETURNING *;						 
						 				 

SELECT * FROM Patient;

SELECT * FROM Patient
	WHERE id_salle = ALL(SELECT id_salle FROM Patient WHERE id_salle = 5);
	
SELECT * FROM Patient
	WHERE id_salle = (SELECT id_salle FROM Patient WHERE id_patient = 11);
	
SELECT * FROM Patient
	WHERE id_salle = (SELECT id_salle FROM Patient WHERE id_patient = 11) AND (sexe='F') AND (age <= 25);
	
	
SELECT * FROM Produits;	
SELECT * FROM Produits WHERE id_produit IN(SELECT id_produit FROM ProduitFacture);	
	
SELECT
	Produits.designation PROD,
	COUNT(ProduitFacture.id_facture) AS NB_FACT
	FROM Produits
	JOIN ProduitFacture USING(id_produit)
	GROUP BY PROD;
	


SELECT
	Patient.id_patient ID_P,
	Patient.nom NOM_P,
	Patient.postnom POSTNOM_P,
	Patient.prenom PRENOM_P,
	Patient.sexe SEXE_P,
	COUNT(DISTINCT(Facture.id_facture))
	FROM Patient
	JOIN Facture USING(id_patient)
	JOIN ProduitFacture USING(id_facture)
	JOIN Produits USING(id_produit)
	WHERE id_produit = (SELECT id_produit FROM Produits WHERE id_produit = 39)
	GROUP BY ID_P, NOM_P,POSTNOM_P,PRENOM_P,SEXE_P;


SELECT
	Patient.id_patient ID_P,
	Patient.nom NOM_P,
	Patient.postnom POSTNOM_P,
	Patient.prenom PRENOM_P,
	Patient.sexe SEXE_P,
	COUNT(DISTINCT(Facture.id_facture)) AS NOMBRE_FACTURE,
	SUM(ProduitFacture.quantite) * Produits.prix_unitaire AS MONTANT_PAYES
	FROM Patient
	JOIN Facture USING(id_patient)
	JOIN ProduitFacture USING(id_facture)
	JOIN Produits USING(id_produit)
	WHERE id_produit = (SELECT id_produit FROM Produits WHERE id_produit = 39)
	GROUP BY ID_P, NOM_P,POSTNOM_P,PRENOM_P,SEXE_P,Produits.prix_unitaire;
	
	
SELECT
	Patient.id_patient ID_P,
	Facture.id_facture ID_F,
	Patient.nom NOM_P,
	Patient.postnom POSTNOM_P,
	Patient.prenom PRENOM_P,
	Patient.sexe SEXE_P,
	COUNT(DISTINCT(Facture.id_facture)) AS NOMBRE_FACTURE,
	SUM(ProduitFacture.quantite) * Produits.prix_unitaire AS MONTANT_PAYES
	FROM Patient
	JOIN Facture USING(id_patient)
	JOIN ProduitFacture USING(id_facture)
	JOIN Produits USING(id_produit)
	WHERE id_produit = (SELECT id_produit FROM Produits WHERE id_produit = 39)
	GROUP BY ID_P, NOM_P,POSTNOM_P,PRENOM_P,SEXE_P,Produits.prix_unitaire,ID_F;



SELECT
	Patient.id_patient ID_P,
	Patient.nom NOM_P,
	Patient.postnom POSTNOM_P,
	Patient.prenom PRENOM_P,
	Patient.sexe SEXE_P,
	COUNT(DISTINCT(Facture.id_facture)) AS NOMBRE_FACTURE,
	SUM(ProduitFacture.quantite) AS QUANTITE_CMD,
	SUM(ProduitFacture.quantite) * Produits.prix_unitaire AS MONTANT_PAYES
	FROM Patient
	JOIN Facture USING(id_patient)
	JOIN ProduitFacture USING(id_facture)
	JOIN Produits USING(id_produit)
	WHERE id_produit = (SELECT id_produit FROM Produits WHERE id_produit = 39)
	GROUP BY ID_P, NOM_P,POSTNOM_P,PRENOM_P,SEXE_P,Produits.prix_unitaire;



SELECT * FROM Facture;
SELECT * FROM ProduitFacture;

INSERT INTO ProduitFacture(id_facture, id_produit, quantite) VALUES(4,28, 100);


SELECT 
	Produits.id_produit AS ID_PROD,
	Produits.designation AS PROD,
	ProduitFacture.quantite * Produits.prix_unitaire
	FROM Produits
	JOIN ProduitFacture USING(id_produit);
	


UPDATE ProduitFacture SET quantite = quantite + 10 WHERE id_facture = 1 AND id_produit = 39;


SELECT * FROM Patient;

SELECT * FROM Medecin;

SELECT * FROM Examen;




INSERT INTO PatientExamen(id_medecin, id_examen, id_patient, commentaire) VALUES (1, 1, 20, 'Si vous souhaitez installer Git sur Linux via un programme d’installation binaire, vous pouvez
généralement le faire via l’outil de gestion de paquetage de base fourni avec votre distribution. Si
vous êtes sur Fedora, vous pouvez utiliser yum:'),(8, 1, 10, 'Si vous souhaitez installer Git sur Linux via un programme d’installation binaire, vous pouvez
généralement le faire via l’outil de gestion de paquetage de base fourni avec votre distribution. Si
vous êtes sur Fedora, vous pouvez utiliser yum:'),(14, 1, 25, 'Si vous souhaitez installer Git sur Linux via un programme d’installation binaire, vous pouvez
généralement le faire via l’outil de gestion de paquetage de base fourni avec votre distribution. Si
vous êtes sur Fedora, vous pouvez utiliser yum:');


INSERT INTO PatientExamen(id_medecin, id_examen, id_patient, commentaire) VALUES(15, 2, 14, 'Pour récupérer le contenu d''un tableau, vous utilisez typiquement l''opérateur')



SELECT * FROM PatientExamen;


SELECT * FROM Medecin
	WHERE id_medecin IN(SELECT id_medecin FROM PatientExamen WHERE id_examen = 1);


SELECT * FROM Examen WHERE id_examen = (SELECT id_examen FROM PatientExamen WHERE id_medecin=1);
	
SELECT * FROM Medecin
	WHERE id_medecin = (SELECT id_examen FROM PatientExamen WHERE id_medecin = 1);
	

SELECT 
	id_medecin FROM
	PatientExamen
	WHERE id_examen = (SELECT id_examen FROM PatientExamen WHERE id_medecin = 1);
	
	
	
SELECT 
	id_medecin, nom,postnom,prenom,sexe date_naissance, gradeMedecin.designation GRADE 
	FROM Medecin
	JOIN GradeMedecin USING(id_grade)
	JOIN PatientExamen USING(id_medecin)
	WHERE id_examen = (SELECT id_examen FROM PatientExamen WHERE id_medecin = 1);
	
SELECT * FROM Medecin;
