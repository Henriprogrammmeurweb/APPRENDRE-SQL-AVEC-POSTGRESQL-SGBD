	DROP TABLE IF EXISTS Ville CASCADE;
	DROP TABLE IF EXISTS Pays CASCADE;
	DROP TABLE IF EXISTS Fournisseurs CASCADE;
	DROP TABLE IF EXISTS Voyage CASCADE;
	DROP TABLE IF EXISTS Vehicule CASCADE;
	DROP TABLE IF EXISTS Conduire CASCADE;
	DROP TABLE IF EXISTS Vehicule_voyage CASCADE;
	DROP TABLE IF EXISTS Passager CASCADE;
	DROP TABLE IF EXISTS Voyager CASCADE;
	DROP TABLE IF EXISTS Panne CASCADE;
	DROP TABLE IF EXISTS Reparateur CASCADE;
	DROP TABLE IF EXISTS ReparteurPanne CASCADE;
	DROP TABLE IF EXISTS Conducteur CASCADE;
	DROP TABLE IF EXISTS ClassePassager CASCADE;
	DROP TABLE IF EXISTS AnneeAcquisition CASCADE;






START TRANSACTION;

	CREATE TABLE AnneeAcquisition(
		id_annee_acquisition SERIAL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	

	CREATE TABLE Pays(
		id_pays SERIAL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL UNIQUE,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);

	CREATE TABLE Ville(
		id_ville SERIAL PRIMARY KEY,
		id_pays INT NOT NULL,
		designation VARCHAR(254) NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);

	CREATE TABLE Fournisseurs(
		id_fournisseur SERIAL PRIMARY KEY,
		id_ville INT NOT NULL,
		designation VARCHAR(254) NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE Vehicule(
		id_vehicule SERIAL PRIMARY KEY,
		id_fournisseur INT NOT NULL,
		id_annee_acquisition INT NOT NULL,
		designation VARCHAR(254) NOT NULL,
		cout MONEY NOT NULL,
		nombre_roue INT NULL,
		nombre_chaise INT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK((nombre_roue >= 1) AND (nombre_chaise >= 1) AND (cout >= 0::MONEY))
	);
	
	CREATE TABLE Conducteur(
		id_conducteur SERIAL PRIMARY KEY,
		nom VARCHAR(254) NOT NULL,
		postnom VARCHAR(254) NOT NULL,
		prenom VARCHAR(254) NOT NULL,
		sexe VARCHAR(1) NOT NULL,
		etat_civil VARCHAR(254) NOT NULL,
		date_naiss DATE NULL,
		personne_en_charge INT NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK ((sexe = 'M' OR sexe = 'F' ) AND (etat_civil = 'Marie' OR etat_civil='Celibataire' 
												OR etat_civil = 'Veuve' OR etat_civil = 'Veuf') AND (personne_en_charge >= 0))
	);
	
	CREATE TABLE Conduire(
		id_vehicule INT NOT NULL,
		id_conducteur INT NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		PRIMARY KEY(id_vehicule, id_conducteur)
	);
	
	CREATE TABLE Voyage(
		id_voyage SERIAL PRIMARY KEY,
		id_ville INT NOT NULL,
		cout MONEY NOT NULL,
		nombre_passager INT NOT NULL,
		date_voyage DATE NOT NULL,
		Heure_depart TIME NOT NULL,
		total MONEY GENERATED ALWAYS AS (cout * nombre_passager) STORED,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK (cout >= 1::MONEY AND nombre_passager >= 1)
	);
	
	
	CREATE TABLE Vehicule_voyage(
		id_voyage INT NOT NULL,
		id_vehicule INT NOT NULL,
		id_conducteur INT NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		PRIMARY KEY(id_voyage, id_vehicule, id_conducteur)
	);
	
	
	CREATE TABLE ClassePassager(
		id_classe SERIAL PRIMARY KEY,
		designation VARCHAR(254) NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);	
	
	CREATE TABLE Passager(
		id_passager SERIAL PRIMARY KEY,
		id_ville_provenance INT NOT NULL,
		nom VARCHAR(254) NOT NULL,
		postnom VARCHAR(254) NOT NULL,
		prenom VARCHAR(254) NOT NULL,
		sexe VARCHAR(1) NULL,
		age INT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK (sexe = 'M' OR sexe = 'F' )
	);	
	
	
	CREATE TABLE Voyager(
		id_passager INT NOT NULL,
		id_voyage INT NOT NULL,
		id_classe INT NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE Panne(
		id_panne SERIAL PRIMARY KEY,
		id_vehicule INT NOT NULL,
		designation VARCHAR(254) NOT NULL,
		description TEXT NULL,
		cout MONEY NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK (cout >= 0::MONEY)
	);
	
	CREATE TABLE Reparateur(
		id_reparateur SERIAL PRIMARY KEY,
		id_ville INT NOT NULL,
		nom VARCHAR(254) NOT NULL,
		postnom VARCHAR(254) NOT NULL,
		prenom VARCHAR(254) NOT NULL,
		sexe VARCHAR(1) NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		CHECK (sexe='M' OR sexe = 'F')
	);
	
	CREATE TABLE ReparteurPanne(
		id_panne INT NOT NULL,
		id_reparateur INT NOT NULL,
		duree TIME NOT NULL,
		date_creation TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		PRIMARY KEY(id_panne, id_reparateur)
	);
	
	
	ALTER TABLE Ville ADD CONSTRAINT fk_pays FOREIGN KEY(id_pays) REFERENCES Pays(id_pays);
	ALTER TABLE Fournisseurs ADD CONSTRAINT fk_ville FOREIGN KEY(id_ville) REFERENCES Ville(id_ville);
	ALTER TABLE Voyage ADD CONSTRAINT fk_villes FOREIGN KEY(id_ville) REFERENCES Ville(id_ville);
	ALTER TABLE Vehicule ADD CONSTRAINT fk_fournisseur FOREIGN KEY(id_fournisseur) REFERENCES Fournisseurs(id_fournisseur);
	ALTER TABLE Vehicule ADD CONSTRAINT fk_annee FOREIGN KEY(id_annee_acquisition) REFERENCES AnneeAcquisition(id_annee_acquisition);
	ALTER TABLE Conduire ADD CONSTRAINT fk_conducteur FOREIGN KEY(id_conducteur) REFERENCES Conducteur(id_conducteur);
	ALTER TABLE Conduire ADD CONSTRAINT fk_vehicule FOREIGN KEY(id_vehicule) REFERENCES Vehicule(id_vehicule);
	ALTER TABLE Vehicule_voyage ADD CONSTRAINT fk_voyage FOREIGN KEY(id_voyage) REFERENCES Voyage(id_voyage);
	ALTER TABLE Vehicule_voyage ADD CONSTRAINT fk_vehicule FOREIGN KEY(id_vehicule) REFERENCES Vehicule(id_vehicule);
	ALTER TABLE Vehicule_voyage ADD CONSTRAINT fk_conducteurs FOREIGN KEY(id_conducteur) REFERENCES Conducteur(id_conducteur);
	ALTER TABLE Passager ADD CONSTRAINT fk_ville_passager FOREIGN KEY(id_ville_provenance) REFERENCES Ville(id_ville);
	ALTER TABLE Voyager ADD CONSTRAINT fk_passages FOREIGN KEY(id_passager) REFERENCES Passager(id_passager);
	ALTER TABLE Voyager ADD CONSTRAINT fk_classe FOREIGN KEY(id_classe) REFERENCES ClassePassager(id_classe);
	ALTER TABLE Panne ADD CONSTRAINT fk_vehicule FOREIGN KEY(id_vehicule) REFERENCES Vehicule(id_vehicule);
	ALTER TABLE Reparateur ADD CONSTRAINT fk_ville_reparateur FOREIGN KEY(id_ville) REFERENCES Ville(id_ville);
	ALTER TABLE ReparteurPanne ADD CONSTRAINT fk_panne_reparateur FOREIGN KEY(id_reparateur) REFERENCES Reparateur(id_reparateur);
	ALTER TABLE ReparteurPanne ADD CONSTRAINT fk_panne FOREIGN KEY(id_panne) REFERENCES Panne(id_panne);
	
	
COMMIT;


START TRANSACTION;

	INSERT INTO pays(designation) VALUES('RDC'),('MALI'),('BURKINA'),('FRANCE'),('ALLEMAGNE'),
	('BELGIQUE'),('ESPAGNE'),('LIBERIA'),('TUNISIE'),('MAROC'),('CANADA'),('BRASIL'),('EGYPT'),
	('KENYA'),('SUD AFRICA'),('TANZANIA'),('ZAMBIA'),('SENEGAL'),('CAMEROON'),('COTE D''IVOIRE'),
	('ALGERIE'),('NIGERIA'),('NIGER'),('CHINE'),('JAPON'),('IRAN'),('MAURITINIE'),('MADAGASCAR');
	
	INSERT INTO AnneeAcquisition(designation) VALUES ('2001'),('2002'),('2003'),('2004'),
	('2005'),('2006'),('2007'),('2008'),('2009'),('2010'),('2011'),('2012'),('2013'),('2014'),
	('2015'),('2016'),('2017'),('2018'),('2019'),('2020'),('2021'),('2022'),('2023'),('2024');
	
	INSERT INTO Ville(id_pays, designation) VALUES(10, 'LUKOMBE'),(11, 'KABINDA'),(10, 'LUBAO'),
	(15, 'KAMANA'),(1,'MUKIYA'),(1, 'LUBUMBASHI'),(1, 'GOMA'),(1,'BUKAVU'),(1, 'KISANGINI'),(1,'KINSHASA'),
	(1,'MATADI'),(12, 'LILLE'),(18, 'LINKS'),(6, 'LUSAMBO'),(1, 'TSHOFA'),(20, 'BORDEAU'),(12, 'LIEGE'),(17, 'PARISIENNA'),
	(10, 'BOENDE'),(9, 'LUEBO'),(4, 'KASUMBALESA'),(4, 'CUSTOME'),(2, 'OUDA'),(3, 'OUAGA'),(4, 'MARSEILLE'),(4,'MONTPELLIER'),
	(4,'BREST'),(6, 'LIEGE'),(6, 'ATWERP'),(13, 'OKUUA'),(15, 'SETING');
	
	INSERT INTO Fournisseurs(id_ville, designation) VALUES(1, 'ZIMBABWE'),(1, 'MABUISHA MAISON'),(5, 'OPERA'),(12, 'LOOLE'),(6, 'MULYKAP'),
	(8, 'KIN MARCHE'),(12, 'CHEMAF'),(11, 'GECAMINE'),(4, 'RUASHI MINING'),(4, 'FOREST NORTHING'),(4, 'ISTEEL'),(14, 'JAMBO MART');
	
	INSERT INTO Vehicule (id_fournisseur,id_annee_acquisition, designation, cout, nombre_chaise) VALUES(7,13, 'CARINA', 5000, 4),
	(10,10, 'SCANIA', 90000, 150),(11, 1, 'SCANIA', 6500, 12),(12, 1, 'SCANIA', 12000, 14),(7, 10, 'BUS TRAVAILLEURS', 100000, 175),
	(7,1,'BUS TRAVAILLEURS', 150000, 125),(7, 24, 'BUS ELEVE', 350000, 250),(6, 24, 'BUS ENFANT', 45000, 36),
	(12,22, 'V8', 50000, 355),(1,12, 'MOTO BOXER', 800, 3),(3, 23, 'VOITURE POUR MANAGER', 2400, 6),(1,23,'VOITURE POUR HR', 3600, 15);
	
	
	INSERT INTO Conducteur(nom, postnom, prenom, sexe, etat_civil, date_naiss, personne_en_charge) 
	VALUES('KASONGO', 'KASONGO', 'SHEKINAH','F', 'Marie', '2000-01-01', 2), 
	('LUBANGA', 'LUBUNGA', 'CELESTIN', 'M','Celibataire', '1999-01-20',4),
	('MITANTA', 'MUSONGIELA', 'JP', 'M', 'Marie', '1992-05-12',1),
	('KITENGIE', 'LUMAMI', 'GERMAIN','M', 'Celibataire',  '2001-06-25', 5);
	
	INSERT INTO Conduire(id_conducteur, id_vehicule) VALUES(4,1),(4,2),(4,10),(1,4),(1,1),(2,8),(2,2),(1,10),(1,9),(3,8),(3,3);
	
COMMIT;

SELECT * FROM Pays;
SELECT * FROM Conducteur;
SELECT * FROM Fournisseurs;
SELECT * FROM Vehicule;
SELECT * FROM AnneeAcquisition;
SELECT * FROM Conduire;
SELECT * FROM Ville;

SELECT * FROM Ville WHERE id_ville IN(SELECT id_ville FROM Fournisseurs);



SELECT
	nom,postnom,
	prenom,sexe,
	COUNT(Conduire.id_conducteur) AS NOMBRE_VOITURES
	FROM Conducteur
	JOIN Conduire USING(id_conducteur)
	GROUP BY nom,postnom,prenom,sexe;

SELECT 
	Vehicule.designation AS VEHICULES,
	COUNT(Conduire.id_vehicule) AS NOMBRE_CONDUCTEUR
	FROM Vehicule
	JOIN Conduire USING(id_vehicule)
	GROUP BY VEHICULES;

SELECT 
	Vehicule.designation AS VEHICULES,
	SUM(CASE WHEN Conducteur.sexe = 'M' THEN 1 ELSE 0 END) AS HOMMES,
	SUM(CASE WHEN Conducteur.sexe = 'F' THEN 1 ELSE 0 END) AS FEMMES,
	COUNT(Conduire.id_vehicule) AS NOMBRE_CONDUCTEUR
	FROM Vehicule
	JOIN Conduire USING(id_vehicule)
	JOIN Conducteur USING(id_conducteur)
	GROUP BY VEHICULES;
	

SELECT
	Pays.designation AS PAYS,
	COUNT(Ville.id_ville) AS NOMBRE_VILLES
	FROM Pays
	JOIN Ville USING(id_pays)
	GROUP BY PAYS;
	
	
	
SELECT
	Ville.designation AS VILLES,
	COUNT(Fournisseurs.id_fournisseur) AS NOMBRE_FOURNISEURS
	FROM Fournisseurs
	JOIN Ville USING(id_ville)
	GROUP BY VILLES;
	

SELECT
	Pays.designation AS PAYS,
	COUNT(DISTINCT(Ville.id_ville)) AS NOMBRE_VILLES,
	COUNT(Fournisseurs.id_ville) AS NOMBRE_FOURNISEURS
	FROM Pays
	JOIN Ville USING(id_pays)
	JOIN Fournisseurs USING(id_ville)
	GROUP BY PAYS;
	
	
SELECT
	Pays.designation AS PAYS,
	COUNT(DISTINCT(Ville.id_ville)) AS NOMBRE_VILLES,
	COUNT(Fournisseurs.id_ville) AS NOMBRE_FOURNISEURS
	FROM Pays
	JOIN Ville USING(id_pays)
	LEFT JOIN Fournisseurs USING(id_ville)
	GROUP BY PAYS;
	
	

SELECT * FROM Ville WHERE id_ville IN(SELECT id_ville FROM Fournisseurs) AND id_pays = 1;

SELECT * FROM Fournisseurs;

INSERT INTO Fournisseurs(id_ville, designation) VALUES(11,'COMIKA')

SELECT * FROM Ville WHERE id_pays = 1;


SELECT 
	DISTINCT nom,postnom,
	prenom,sexe
	FROM Conducteur
	JOIN Conduire USING(id_conducteur)
	JOIN Vehicule USING(id_vehicule)
	WHERE id_vehicule = ANY(SELECT id_vehicule FROM Conduire WHERE id_conducteur = 4);


SELECT * FROM Vehicule;



SELECT
	ROW_NUMBER()
	OVER(ORDER BY Fournisseurs.designation) AS NUM,
	COALESCE(Fournisseurs.designation, 'TOTAL GENERAL') AS FOURNISSEURS,
	COUNT(Vehicule.id_vehicule) AS NOMBRE_VEHICULES,
	SUM(Vehicule.cout::DECIMAL) AS MONTANT_TOUT_VEHICULE
	FROM Fournisseurs
	JOIN Vehicule USING(id_fournisseur)
	GROUP BY GROUPING SETS((Fournisseurs.designation), ())
	ORDER BY Fournisseurs.designation;




SELECT MIN(cout) FROM Vehicule;
SELECT MAX(cout) FROM Vehicule;
SELECT SUM(cout) FROM Vehicule;
SELECT AVG(cout::DECIMAL) FROM Vehicule;



SELECT 
	Vehicule.designation AS V,
	cout::DECIMAL
	FROM Vehicule;

SELECT * FROM Panne;

INSERT INTO Panne(id_vehicule, designation,description, cout) VALUES(5, 'PNEU DJD',NULL, 650),(5,'dhdh', NULL,500),
(12, 'JEND', NULL, 2300),(6, 'djdjdd', NULL, 4500),(12, 'ddhdhdh', NULL, 6500),
(10,'shshshs', NULL, 650),(4, 'DGDGEE', NULL, 200),(1, 'jjsjs', NULL, 300),(1, 'dhdhdhhd', NULL,600);

SELECT * FROM Voyage;
SELECT * FROM Ville;

INSERT INTO Voyage(id_ville, cout, nombre_passager, date_voyage, heure_depart) VALUES(2, 100, 55, '2024-02-25', '08:05:30');
INSERT INTO Voyage(id_ville, cout, nombre_passager, date_voyage, heure_depart) VALUES(1, 120, 65, '2023-03-03', '09:10:35');
INSERT INTO Voyage(id_ville, cout, nombre_passager, date_voyage, heure_depart) VALUES(1, 140, 100, '2023-03-03', '09:10:35');
INSERT INTO Voyage(id_ville, cout, nombre_passager, date_voyage, heure_depart) VALUES(8, 150, 200, '2020-01-01', '15:10:35');
INSERT INTO Voyage(id_ville, cout, nombre_passager, date_voyage, heure_depart) VALUES(16, 170, 103, '2003-01-01', '18:10:30');
INSERT INTO Voyage(id_ville, cout, nombre_passager, date_voyage, heure_depart) VALUES(13, 160, 100, '2002-02-02', '20:10:30');
INSERT INTO Voyage(id_ville, cout, nombre_passager, date_voyage, heure_depart) VALUES(10, 30, 85, '2024-04-03', '10:00:00')
,(20, 450, 160, '2001-05-25', '19:00:00'), (14, 110, 36, '2006-11-23', '11:00:05'),(11, 45, 105, '2006-06-26', '09:00:00');


SELECT * FROM ClassePassager;
SELECT * FROM Passager;

INSERT INTO ClassePassager(designation) VALUES('A'),('B'),('C'),('D'),('E') RETURNING *;

INSERT INTO Passager(id_ville_provenance, nom, postnom, prenom, sexe, age) VALUES(10, 'MBAYO', 'FUAMBA', 'RAOUL', 'M', 53),
(1, 'MUKIEMUNE', 'LUMONGA', 'AIMERANCE', 'F', 50),(1,'LUMONGA', 'LUMONGA', 'SIMON', 'M' ,44),(11, 'MUTUMPE', 'KALUNGA', 'RACHEL','F', 22),
(2, 'LOJI', 'NTOMENE', 'JULIETTE', 'F', 25),(2, 'NGOYI', 'NKUENYI', 'DECHRIS', 'M', 26),(2, 'LUSANGA', 'ILUNGA', 'JULES CESAR','M', 20),
(5, 'KASONGO', 'KIABU', 'FERDINAND FK', 'M', 21),(5, 'BINGI', 'KAMBILO', 'ALI','M', 36),(5, 'KAKUNDA', 'BINGI', 'MANASSE', 'M', 4),
(5, 'KIMPANGA', 'LUMBA', 'WILLY', 'M', 34),(5, 'MBELE', 'BINGI', 'DELPHINE CHLOE', 'F', 7),(10, 'MBAYO', 'MBAYO', 'SALOME', 'F', 13),
(6, 'EBONDO', 'MBAYO', 'PIERRE', 'M', 25),(6, 'YAMPUA', 'YAMPUA', 'DJOMALY', 'M', 24),(10, 'KIABU', 'YAMPUA', 'PASCARIUS', 'M', 26),
(10, 'KIMANKINDA', 'YAMPUA', 'JOSEPHINE', 'F', 17),(11, 'MUKONKOLE', 'MBAYO', 'GEDINIE', 'M', 16),(11, 'MBELE', 'MUTOMBO', 'ASSYSTRID','F', 16),(11, 'KAPAFULE', 'YAMPUA', 'CHRISTINE', 'F', 16),(14, 'LUMAMI', 'EBDENDE', 'MARGUEIL', 'F', 17),(14, 'YANGUBA', 'ILUNGA','ARMEL', 'M', 27),(19, 'EBENDE', 'FUAMBA', 'ERICK', 'M', 57),(19, 'BIASUE', 'KALONDA', 'DOMINIQUE','M', 34),(19, 'NGOLO', 'MBAYO', 'DENISE', 'F', 27),
(17, 'KALENGA', 'MUTOMBO', 'MIKE', 'M', 25),(14, 'BANZA', 'NKONGE', 'SABIN','M', 23),(14, 'LUNKUKU', 'KABUNDJI', 'BILL PIERROT', 'M',24),
(6, 'KASEMUANA', 'NTSHIKIE', 'WATIB', 'M', 24),(6, 'MPANYA', 'LUMAMI', 'SIDONIE', 'F', 35),(3, 'FUAMBA', 'ILUNGA', 'PASCALINE', 'M', 24),
(11, 'KAZAD', 'NACIBAND', 'FELICITE', 'F', 24),(12, 'NGANDU', 'KALENGA', 'ALICE', 'M',27),(12, 'KALENGA', 'NGANDU', 'NASSER', 'M', 24),
(11, 'KABEDI', 'KALUBI', 'LUCIANNE', 'F', 26),(17, 'FUMUNI', 'BUTAKAR', 'GERMAINE', 'F', 25),(17, 'MBUYU', 'LONGO', 'ID', 'M', 26),
(14, 'NSOMPO', 'LARISSA', 'LARISSA', 'F', 26),(14, 'KIBONGIE', 'MPAMPI', 'CORNEILLE', 'M', 25),(1, 'KITUMBIKA', 'KATEMBO', 'JULAIS', 'M',25),(1, 'NYEMBUE', 'MUKENDA', 'URBAIN', 'M', 26),(1, 'MPUNGUE', 'KABOBO', 'BLANDINE', 'F', 28),(3, 'NYEMBO', 'MPAMPI', 'AUGU ROGER', 'M', 34),(3, 'KATANGA', 'KABAMBA', 'JOELLE', 'F', 25),(5, 'KABAMBA', 'KABAMBA', 'DESIRE', 'M', 37),(5, 'KIBUNDULU', 'KAPANDA', 'PETRONIE', 'F', 27),(5, 'EBONDO', 'MUKOMENA', 'ADEL', 'F', 24),(5, 'LUAMBA', 'NGOYI', 'PASCALINE', 'F', 25),(5, 'KIKUDI', 'LOJI', 'CHRISTINE', 'F', 28),(1, 'MATUMBA', 'KAPENGA', 'PRINCE', 'M', 25),(1, 'NSOMUE', 'TSHIAMBA', 'PATIENT', 'M', 28),(2, 'KAYEYE', 'MUKOMBO', 'PATIENT', 'M', 25),(8, 'KIAYIMA', 'LUMONGA', 'JEAN BOSCO', 'M', 10),(5, 'NGOYI', 'MPOSHI', 'FELLY', 'M', 28),(10, 'KADIYA', 'LUMONGA', 'FRANCKLIN', 'M', 8),(15, 'KADIYA', 'LUMONGA', 'IVON', 'M', 63),(16, 'KISUAKA', 'MBAYO', 'GAUIS', 'M', 21),(12, 'BIADI', 'BUKULA', 'RIDEL', 'F', 25),
(4, 'MBU', 'ILUNGA', 'LIDI', 'F', 16),(4, 'EKAMBA', 'ILUNGA', 'GERMAIN', 'M', 17),(4, 'KUNDA', 'FUAMBA', 'DELPHIN', 'M', 30),
(4, 'LUENYI', 'LUMONGA', 'VALENTIN', 'M', 36),(2, 'LUENYI', 'KUNDA', 'SERGE','M', 14),(2, 'LUENYI', 'KIBONGIE', 'ANDRE', 'M', 30),
(2, 'KALONDA', 'KAPAFULE', 'NATHAN', 'M', 24),(1, 'NTAMBUE', 'MULAMBULUA', 'BIFALO', 'M', 29),(1, 'LUMAMI', 'LUMAMI', 'THEO', 'M', 28);

INSERT INTO Passager(id_ville_provenance, nom, postnom, prenom, sexe, age) VALUES(6, 'KIMBALANGA', 'KIABU', 'LONDRI', 'M', 22),
(5, 'NSONGIE', 'NGOYI', 'STEPHANE', 'M', 31),(6, 'KABUNDI', 'MAITRE', 'FONAKOSHE', 'M', 37);

INSERT INTO Passager(id_ville_provenance, nom, postnom, prenom, sexe, age) VALUES(6, 'KIABU', 'NSOMUE', 'SOUZA', 'F', 2),
(5, 'NSONGIE', 'NGOYI', 'STEPHANE', 'M', 31),(6, 'KABUNDI', 'MAITRE', 'FONAKOSHE', 'M', 37);

SELECT * FROM Voyager;


INSERT INTO Voyager(id_passager, id_voyage, id_classe) VALUES(5,1,5),(1,1,1),(2,1,1),(70,1,4),(65,1,3),(45,1,1),(36,1,3),(20,1,3),(21,1,1),
(23, 1, 5),(24, 1, 1),(68, 1, 1),(33, 1, 4),(9,1,3),(10, 1,2),(60,1,2),(61,1,3),(46, 1, 5);

INSERT INTO Voyager(id_passager, id_voyage, id_classe) VALUES(71, 1, 2);

SELECT
	Voyage.id_voyage AS ID_VOYAGE,
	Pays.designation AS PAYS,
	Ville.designation AS VILLE,
	Voyage.cout AS COUT_VOYAGE,
	Voyage.nombre_passager AS NB_PASSAGER_PREVU,
	Voyage.total AS TOTAL_PREVU,
	SUM(CASE WHEN Passager.sexe = 'M' THEN 1 ELSE 0 END) AS NB_HOMMES,
	SUM(CASE WHEN Passager.sexe = 'F' THEN 1 ELSE 0 END) AS NB_FEMMES,
	COUNT(Voyager.id_passager) AS NOMBRE_PASSAGER_PAIE,
	Voyage.cout * COUNT(Voyager.id_passager) AS PAIEMENT_POUR_CE_VOYAGE
	FROM Voyager
	JOIN Passager USING(id_passager)
	RIGHT JOIN Voyage USING(id_voyage)
	JOIN Ville USING(id_ville)
	JOIN Pays USING(id_pays)
	GROUP BY Voyage.id_voyage ,PAYS,VILLE,COUT_VOYAGE,NB_PASSAGER_PREVU, TOTAL_PREVU;
	
	

SELECT
	Voyage.id_voyage AS ID_VOYAGE,
	Pays.designation AS PAYS,
	Ville.designation AS VILLE,
	Voyage.cout AS COUT_VOYAGE,
	Voyage.nombre_passager AS NB_PASSAGER_PREVU,
	Voyage.total AS TOTAL_PREVU,
	SUM(CASE WHEN Passager.sexe = 'M' THEN 1 ELSE 0 END) AS NB_HOMMES,
	SUM(CASE WHEN Passager.sexe = 'F' THEN 1 ELSE 0 END) AS NB_FEMMES,
	COUNT(Voyager.id_passager) AS NOMBRE_PASSAGER,
	COUNT(DISTINCT(Voyager.id_classe)) AS NB_CLASSE,
	CASE 
		WHEN MIN(Passager.age) = ANY(SELECT MIN(age) FROM Passager 
									 WHERE sexe = 'M' AND id_passager IN(SELECT id_passager FROM Voyager) 
									 GROUP BY sexe) THEN CONCAT('sexe M AVEC :',' ', CAST(MIN(Passager.age) AS TEXT), ' ', 'ans') 
									 ELSE  CONCAT('sexe F AVEC :',' ', CAST(MIN(Passager.age) AS TEXT), ' ', 'ans') END AS GENRE_MOINS_AGE,
	CASE 
		WHEN MAX(Passager.age) = ANY(SELECT MAX(age) FROM Passager 
									 WHERE sexe = 'M' AND id_passager IN(SELECT id_passager FROM Voyager) 
									 GROUP BY sexe) THEN CONCAT('sexe M AVEC :',' ', CAST(MAX(Passager.age) AS TEXT), ' ', 'ans') 
									 ELSE  CONCAT('sexe F AVEC :',' ', CAST(MAX(Passager.age) AS TEXT), ' ', 'ans') END AS GENRE_PLUS_AGE,
	Voyage.cout * COUNT(Voyager.id_passager) AS PAIEMENT_POUR_CE_VOYAGE
	FROM Voyager
	JOIN Passager USING(id_passager)
	JOIN Voyage USING(id_voyage)
	JOIN Ville USING(id_ville)
	JOIN Pays USING(id_pays)
	GROUP BY Voyage.id_voyage ,PAYS,VILLE,COUT_VOYAGE,NB_PASSAGER_PREVU, TOTAL_PREVU;

	
	
	
SELECT MIN(age),MAX(age),sexe FROM Passager WHERE id_passager IN(SELECT id_passager FROM Voyager WHERE id_voyage=1)
GROUP BY sexe;


SELECT * FROM Passager;

SELECT * FROM Vehicule;
SELECT * FROM Voyage;
SELECT * FROM Voyager;
SELECT * FROM Conducteur;
SELECT * FROM Vehicule_voyage;


INSERT INTO Vehicule_voyage(id_vehicule, id_voyage, id_conducteur) VALUES(5, 1, 3);



SELECT * FROM Vehicule_voyage;

SELECT
	Vehicule.designation AS VEHICULES,
	Ville.designation AS VILLES,
	Pays.designation AS PAYS,
	COUNT(DISTINCT(Voyage.id_voyage)) AS NOMBRE_VOYAGE,
	Vehicule.cout AS COUT_VEHICULE,
	Voyage.nombre_passager AS NOMBRE_BILLET_PREVU,
	COUNT(Passager.id_passager) AS NOMBRE_BILLET_ACHETES,
	Voyage.cout AS COUTS_VOYAGE,
	Voyage.cout * COUNT(Passager.id_passager) AS MONTANT_PERCU
	FROM Vehicule_voyage
	JOIN Vehicule USING(id_vehicule)
	JOIN Voyage USING(id_voyage)
	JOIN Voyager USING(id_voyage)
	JOIN Passager USING(id_passager)
	JOIN Ville USING(id_ville)
	JOIN Pays USING(id_pays)
	GROUP BY VEHICULES,VILLES, PAYS, COUT_VEHICULE,NOMBRE_BILLET_PREVU, COUTS_VOYAGE;





SELECT SUM(nombre_passager) FROM Voyage;
SELECT cout * 19 FROM Voyage;

SELECT * FROM Voyager;
SELECT * FROM Voyage;
SELECT * FROM Vehicule_Voyage;

INSERT INTO Voyage(id_ville, cout, nombre_passager, date_voyage, heure_depart) VALUES(4,120,50, '2003-01-01', '00:00:00');

INSERT INTO Voyager(id_passager, id_voyage, id_classe) VALUES(2, 2,3);


INSERT INTO Vehicule_Voyage(id_voyage, id_vehicule, id_conducteur) VALUES(11, 5, 2);




