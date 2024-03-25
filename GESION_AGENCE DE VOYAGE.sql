START TRANSACTION;

CREATE TABLE Agence(
	id_agence SERIAL NOT NULL PRIMARY KEY,
	nom_agence VARCHAR(254) NOT NULL,
	adresse VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT NOW()
);

INSERT INTO Agence(nom_agence, adresse) VALUES('CAA', 'LUBUMBASHI'), 
('CAA', 'KINSHASA'),('CAA', 'KABINDA'),('CAA', 'KALEMIE'),('CAA', 'GOMA'),
('CAA', 'MBUJIMAYI'),('CAA', 'KANANGA'),('CAA', 'KISANGANI'),('CAA', 'BAS-UWULE'),
('CAA', 'BAS CONGO'),('CAA', 'LUKOMBE'),('GIMELLO', 'LUBAO'),('GIMELLO', 'KABINDA'),
('GIMELLO', 'TSHOFA'),('GIMELLO', 'KAMANA'),('SAKULU', 'KABINDA'),('MANASE TELECOM', 'KINDU'),
('MANASE TELECOM', 'NKONGOLO'),('MANASE TELECOM', 'KASUMBALESA');

COMMIT;



SELECT * FROM agence;

START TRANSACTION;
DROP TABLE Personne;
COMMIT;


START TRANSACTION;
	CREATE TABLE Personne(
		id_personne SERIAL NOT NULL PRIMARY KEY,
		nom VARCHAR(254) NOT NULL,
		postnom VARCHAR(254) NOT NULL,
		prenom VARCHAR(254) NOT NULL,
		sexe VARCHAR(1) NOT NULL,
		date_created DATE NULL DEFAULT NOW()
		CHECK (sexe='M' OR  sexe='F')
	);
	
COMMIT;


START TRANSACTION;
INSERT INTO Personne(nom, postnom, prenom, sexe) VALUES
('KIUKA', 'MBAYO', 'HENRI', 'M'),
('NGOLO', 'MBAYO', 'DENISE', 'F'),
('NYEMBO', 'MPAMPI', 'AUGU ROGER', 'M'),
('LUAMBA', 'NGOYI', 'PASCALINE', 'F'),
('FRAM', 'KIYENGA', 'FRAM', 'M'),
('KIKUDI', 'LOJI', 'CHRISTINE', 'F'),
('YAMPUA', 'YAMPUA', 'DJOMALY', 'M'),
('MUKONKOLE', 'MBAYO', 'GEDEON', 'M'),
('MBAYO', 'KIUKA', 'SALOMON', 'M'),
('EBONDO', 'MUKOMENA', 'ADELINE', 'F'),
('KIBONGIE', 'MPAMPI', 'CORNEILLE', 'M'),
('KITUMBIKA', 'KATEMBO','JULAIS', 'M'),
('MPUENGUE', 'KABOBO', 'BLANDINE', 'F'),
('MBUYU', 'MUTUALE', 'MIREILLE', 'F'),
('MBAYO', 'FUAMBA', 'PAPA RAOUL', 'M'),
('MUIKIEMUNE', 'LUMONGA', 'AIMERANCE', 'F'),
('BALUKIE', 'LUMONGA', 'CHANTAL', 'F'),
('BINGI', 'KAMBILO', 'ALI', 'M'),
('MBELE', 'BINGI', 'DELPHINE CHLOE', 'F'),
('KAKUNDA', 'BINGI', 'CLOVIS MANASSE', 'M'),
('KABEDI', 'KALUBI', 'LUCIANNA', 'F'),
('KALENGA', 'MUTOMBO', 'MIKE', 'M'),
('MATUMBA', 'KAPENGA', 'PRINCE', 'M'),
('NSOMUE', 'TSHIAMBA', 'PATIENT', 'M'),
('MITANTA', 'MUSONGIELA', 'JEAN PIERRE', 'M'),
('NGOYI', 'KABENGA', 'ALEXANDRE', 'M'),
('MUKONKOLE', 'KAWUMBILA', 'MIMIE', 'M'),
('KIPANGA', 'LUMBA', 'WILLY', 'M'),
('KASONGO', 'KIABU', 'FK 02', 'M'),
('LUSANGA', 'ILUNGA', 'JULES CESAR', 'M'),
('KIOMBA', 'KIOMBA', 'DIEU LE VEUT', 'M'),
('NTAMBWE', 'NTAMBWE', 'ELIEZER', 'M'),
('ELUMBA', 'LOMONGA', 'MAMIE', 'F'),
('LUMONGA', 'LUMONGA', 'SIMON', 'M'),
('LUMONGA', 'LUENYI', 'JUSTIN', 'M'),
('LUENYI', 'LUMONGA', 'VALENTIN', 'M'),
('KAYEYE', 'MUKOMBO', 'PATIENT', 'M'),
('KUNDA', 'FUAMBA', 'DELPHIN', 'M'),
('YAKUBA', 'ILUNGA', 'ARMEL', 'M'),
('LUMAMI', 'EBENDE', 'MARGUEIL', 'F'),
('BIADI', 'BUKULA', 'RIDEL', 'F'),
('LUENYI', 'KUNDA', 'SERGE', 'M'),
('ELUNGU','KAMBILO', 'GIRESSE', 'M'),
('NGOYI', 'NKUENYI', 'DECHRIS', 'M'),
('KAZAD', 'NACIBAD', 'FELICITE', 'F'),
('MBUYU', 'LONGO', 'ID', 'M'),
('FUMUNI', 'BUTAKAR', 'GERMAINE', 'F'),
('NSOMPO', 'LARRISSA', 'LARRISSA', 'F'),
('NGANDU', 'KALENGA', 'ALICE', 'F'),
('KALENGA', 'NGANDU', 'NASSER', 'M'),
('SHESHA', 'FUAMBA', 'BATONIER PAULIN', 'M'),
('MUTUMPE', 'FUAMBA', 'DA CHANTI', 'F'),
('MUBANGA', 'FUAMBA', 'FIDELE CASTRO', 'M'),
('YAMAKUNDA', 'YALUMANA', 'DIEU MERCI', 'M'),
('LUKUNKU', 'KABUNDJI', 'PIERROT BILL', 'M'),
('EBENDE', 'FUAMBA', 'ERICK KASHOKE', 'M'),
('NTAMBWE', 'LUMAMI', 'LAURENTINE', 'F'),
('LUMBA', 'ILUNGA', 'ALAIN', 'M'),
('MUTABA', 'LUAMBA', 'DALLAS', 'M'),
('YANKAMBI', 'DIBUE', 'JEAN PIERRE', 'M'),
('KALETSHIE', 'ARLETTE', 'ARLETTE', 'F'),
('KITENGIE', 'MARTIN', 'MARTIN', 'M'),
('MUEMBO', 'ELUNGU', 'ANDRE MUPETO', 'M');
COMMIT;


START TRANSACTION;
INSERT INTO Personne(nom, postnom, prenom, sexe) VALUES
('KIMANKINDA', 'YAMPUA', 'JOSE', 'F'),
('KIMANKINDA', 'KAPAMBA', 'JOSE', 'F'),
('NSONGA', 'NGOYI', 'STAPHANE', 'M'),
('KADIYA','LUMONGA', 'IVON', 'M'),
('KANKESA', 'SHESHA', 'FRANCOIS', 'M'),
('NTAMBWE', 'SHESHA', 'OMON', 'M'),
('SHESHA', 'MULENGA', 'RICHARD', 'M');

COMMIT;

INSERT INTO Personne(nom, postnom, prenom, sexe) VALUES('KASONGO', 'KITENGIE', 'SHEKINAH', 'F');




SELECT * FROM personne;


SELECT
	CASE personne.sexe
		WHEN 'M' THEN 'HOMME'
		WHEN 'F' THEN 'FEMME'
		ELSE 'PERSONALISE'
	END AS GENRE,
		
	personne.sexe AS SEXE,
	COUNT(personne.id_personne) AS NOMBRE,
	DENSE_RANK()
	OVER(ORDER BY COUNT(personne.id_personne) DESC) AS CLASSEMENT

FROM personne GROUP BY SEXE;


SELECT * FROM agence;

DELETE FROM agence WHERE nom_agence='KCC';


SELECT 
	agence.adresse AS VILLE,
	COUNT(agence.id_agence) AS NOMBRE_AGENCE
FROM agence GROUP BY VILLE;


SELECT 
	agence.nom_agence AS AGENCE,
	COUNT(agence.id_agence) AS NOMBRE_AGENCE
FROM agence GROUP BY AGENCE;


DROP TABLE Voyage;

START TRANSACTION;
CREATE TABLE Voyage(
	id_voyage SERIAL NOT NULL PRIMARY KEY,
	id_agence INT NOT NULL,
	ville_destination VARCHAR(254) NOT NULL,
	price_voyage DECIMAL NOT NULL,
	date_created DATE NULL DEFAULT NOW(),
	CHECK(price_voyage>=1),
	CONSTRAINT fk_agence FOREIGN KEY(id_agence) REFERENCES agence(id_agence) ON DELETE CASCADE
);
COMMIT;

SELECT * FROM Voyage;

ALTER TABLE Voyage ADD COLUMN date_voyage DATE;

ALTER TABLE Voyage ALTER COLUMN date_voyage TYPE DATE;

ALTER TABLE Voyage RENAME COLUMN date_voayages TO date_voyages;



--ALTER TABLE nom_table
--ALTER COLUMN nom_colonne TYPE type_donnees

UPDATE Voyage SET date_voyage='2024-01-01';


START TRANSACTION;
INSERT INTO Voyage(id_agence, ville_destination, price_voyage)
VALUES(1, 'KINSHASA', 2500),
(1, 'MBUJIMAYI', 1400), 
(1, 'KABINDA', 3000),
(1, 'KOLWEZI', 2500),
(1, 'FRANCE', 2450), 
(1,'ALLEMAGNE', 2500), 
(1, 'BRASIL', 15000);

COMMIT;

SELECT * FROM Voyage;

SELECT * FROM Agence WHERE id_agence IN(SELECT id_agence FROM Voyage);



START TRANSACTION;
CREATE TABLE Paiement(
	id_voyage INT NOT NULL,
	id_personne INT NOT NULL,
	montant_paye DECIMAL NOT NULL,
	date_created DATE NULL DEFAULT NOW(),
	CHECK(montant_paye>=1),
	PRIMARY KEY(id_voyage, id_personne)
);
ALTER TABLE Paiement ADD CONSTRAINT fk_voyage FOREIGN KEY(id_voyage) REFERENCES Voyage(id_voyage);
ALTER TABLE Paiement ADD CONSTRAINT fk_personne FOREIGN KEY(id_personne) REFERENCES Personne(id_personne);
COMMIT;

ROLLBACK;


SELECT * FROM Agence;

START TRANSACTION;
INSERT INTO Paiement(id_voyage, id_personne, montant_paye)VALUES
(1, 10, 2500);
COMMIT;

START TRANSACTION;
INSERT INTO Paiement(id_voyage, id_personne, montant_paye)VALUES
(5, 10, 2500),(5, 16, 2500),(5, 2, 2500),(5, 18, 2500),(5, 15, 2500),(5, 14, 2500);
COMMIT;

START TRANSACTION;
INSERT INTO Paiement(id_voyage, id_personne, montant_paye)VALUES
(5, 30, 2000);
COMMIT;


SELECT * FROM Paiement WHERE id_voyage=5;


UPDATE Paiement SET montant_paye = 2450 WHERE montant_paye > 2450 AND id_voyage=5;


ROLLBACK;

SELECT * FROM Voyage;

SELECT * FROM Paiement;


SELECT * FROM Personne WHERE id_personne IN(
	SELECT id_personne FROM Paiement 
);

SELECT * FROM Voyage WHERE id_voyage IN(
	SELECT id_voyage FROM  Paiement
);


SELECT 
	personne.nom as NOM,
	personne.postnom AS POSTNOM,
	personne.prenom AS PRENOM,
	personne.sexe AS SEXE,
	Voyage.ville_destination AS VILLE,
	paiement.date_created AS DATE_PAIEMENT
	FROM Paiement
	JOIN personne USING(id_personne)
	JOIN Voyage USING(id_voyage)
	WHERE Voyage.ville_destination LIKE '%S%'
	GROUP BY NOM, POSTNOM, PRENOM, SEXE,DATE_PAIEMENT, VILLE;
	
	

SELECT
	Voyage.ville_destination AS VILLE,
	CONCAT(Voyage.price_voyage, ' ', '$') AS COUT_VOYAGE,
	COUNT(Paiement.id_personne) AS NUMBER_PERSONNE,
	SUM(Paiement.montant_paye) AS MONTANT_PAYES
	FROM Paiement
	RIGHT JOIN Voyage USING(id_voyage)
	INNER JOIN Personne USING(id_personne)
	GROUP BY VILLE,COUT_VOYAGE;
	
/* A REVENIR POUR MIEUX PARTITIONNER */
SELECT
	Voyage.ville_destination AS VILLE,
	SUM(Paiement.montant_paye)
	OVER(PARTITION BY Paiement.id_voyage ROWS BETWEEN
			UNBOUNDED PRECEDING
			AND CURRENT ROW) AS MONTANT_PAYES
	FROM Paiement
	INNER JOIN Voyage USING(id_voyage);
	--GROUP BY Paiement.id_voyage;
	--GROUP BY VILLE,Paiement.id_voyage,Paiement.montant_paye;

SELECT * FROM Voyage;

SELECT *, NTILE(4) 
	OVER(ORDER BY price_voyage DESC) AS MYNTLE
FROM Voyage;


SELECT TOTAL_VENTE AS VENTE_DU_JOUR,
LAG (TOTAL_VETE) OVER
(ORDER BY DATE_VENTE) AS PrevDaySale
FROM TOTAL_JOUR;

SELECT
	SUM(Paiement.montant_paye) AS PAIEMNT_DAYS,
	LAG(SUM(Paiement.montant_paye))
	OVER(ORDER BY date_created) AS PrevDaySale
	FROM Paiement GROUP BY date_created,Paiement.montant_paye;


	
	
SELECT DISTINCT(paiement.id_voyage) FROM Paiement;
	
SELECT * FROM Paiement;
	


SELECT 
	personne.nom AS NOM,
	personne.postnom AS POSTNOM,
	personne.prenom AS PRENOM,
	personne.sexe AS SEXE,
	voyage.ville_destination AS VILLE,
	voyage.price_voyage AS COUT_VOYAGE,
	Paiement.montant_paye AS PAYE
	FROM Paiement
	JOIN Personne USING(id_personne)
	JOIN Voyage USING(id_voyage);
	
	
	
	
/* DAYS TWO */
SELECT * FROM Agence;
SELECT * FROM Voyage;
SELECT * FROM paiement;


START TRANSACTION;
INSERT INTO Voyage(id_agence, ville_destination, price_voyage, date_voyage)VALUES
(13, 'MBUJIMAYI', 150,'2023-01-01'),(13, 'LUBAO', 100,'2023-02-01'),
(13, 'KINSHASA', 250,'2023-05-25'),(13, 'MBUJIMAYI', 150,'2023-12-25'),
(13, 'KABINDA', 50,'2023-02-12'),(13, 'LUBUMBASHI', 1500,'2023-03-26'),
(13, 'TSHOFA', 1250,'2023-09-01'),(13, 'KANANGA', 850,'2023-06-10'),
(13, 'LUBAO', 750,'2023-04-25'),(13, 'MBUJIMAYI', 1500,'2023-05-01'),
(13, 'KISANGANI', 450,'2023-07-30'),(13, 'GOMA', 150,'2023-10-25');
COMMIT;

ROLLBACK;


INSERT INTO Voyage(id_agence, ville_destination, price_voyage, date_voyage)VALUES
(13, 'MBUJIMAYI', 150,'2025-01-01');




SELECT 
	agence.nom_agence AGENCE,
	--Voyage.ville_destination AS VILLE_DESTIONATION,
	COUNT(Voyage.id_agence) AS NUMBER_VOYAGE,
	SUM(Voyage.price_voyage) AS TOTAL_COUT
	FROM Voyage
	JOIN Agence USING (id_agence)
	GROUP BY AGENCE;






SELECT AGENCE,
ANNNEE,
CONCAT(TOTAL_COUT, ' ', '$') AS MONTANT_VOYAGE,
NUMBER_VOYAGE,
ROUND(AVG(TOTAL_COUT)) AS MOYENNE 
FROM(
SELECT 
	agence.nom_agence AGENCE,
	--agence.adresse ADRESSE,
	--Voyage.ville_destination AS VILLE_DESTIONATION,
	COUNT(Voyage.id_agence) AS NUMBER_VOYAGE,
	SUM(Voyage.price_voyage) AS TOTAL_COUT,
	EXTRACT(YEAR FROM Voyage.date_voyage) AS ANNNEE
	--COUNT(paiement.id_personne) AS PERSONNE_NUMBER
	FROM Voyage
	--RIGHT JOIN Paiement ON Voyage.id_voyage=paiement.id_voyage
	JOIN Agence USING(id_agence)
	GROUP BY AGENCE,ANNNEE
) AS temps GROUP BY temps.agence,temps.total_cout,temps.number_voyage, temps.ANNNEE;


SELECT * FROM Agence;
SELECT * FROM Voyage;
SELECT SUM(price_voyage) FROM Voyage WHERE id_agence=1;


SELECT EXTRACT(WEEK FROM date_voyage) FROM Voyage;

SELECT 
	agence.nom_agence AS AGENCE,
	EXTRACT(YEAR FROM Voyage.date_voyage) AS ANNEE,
	--COUNT(DISTINCT(voyage.ville_destination)) AS NUMBER_VILLE,
	EXTRACT(QUARTER FROM Voyage.date_voyage) AS TRIMESTRE,
	COUNT(voyage.id_agence) AS NUMBER_VOYAGE,
	SUM(voyage.price_voyage) AS MONTANT_TOTAL_TRIMESTRE,
	SUM(paiement.montant_paye) AS MONTANT_RECU,
	COUNT(paiement.id_personne)
	FROM Voyage
	LEFT JOIN Paiement ON Voyage.id_voyage=Paiement.id_voyage
	LEFT JOIN Personne USING(id_personne)
	JOIN Agence USING(id_agence)
	GROUP BY AGENCE, ANNEE,TRIMESTRE,paiement.id_voyage;

	
SELECT 
	Agence.nom_agence AS AGENCE,
	EXTRACT(QUARTER FROM voyage.date_voyage) AS Tr,
	SUM(voyage.price_voyage) AS MONTANT 
	FROM Voyage
	JOIN Agence USING(id_agence)
	
	GROUP BY AGENCE,Tr;



	
SELECT SUM(price_voyage) FROM Voyage WHERE id_agence=1;
SELECT * FROM Voyage;

SELECT SUM(montant_paye) FROM Paiement;


SELECT * FROM Voyage WHERE id_agence=1;

UPDATE Voyage SET date_voyage='2024-01-25' WHERE id_voyage=21;

INSERT INTO Voyage(id_agence, ville_destination, price_voyage) VALUES(1, 'MBUJIMAYI',450);


SELECT * FROM Paiement;

SELECT 
	Voyage.price_voyage,
	SUM(Voyage.price_voyage) AS SOMME
	FROM Voyage 
	WHERE id_agence=1 
	AND EXTRACT(QUARTER FROM date_voyage)=1 
	GROUP BY Voyage.price_voyage;
	
SELECT SUM(montant_paye) from Paiement WHERE id_voyage=5;

SELECT * FROM Paiement;


SELECT * FROM Voyage WHERE id_voyage=1;

SELECT * FROM Agence;

SELECT * FROM Voyage;

SELECT 
	Agence.nom_agence AS AGENCE,
	EXTRACT(QUARTER FROM Voyage.date_voyage) AS Trimestre,
	SUM(Voyage.price_voyage) FROM 
	Voyage 
	JOIN Agence using(id_agence)
WHERE Agence.nom_agence='GIMELLO' AND EXTRACT(QUARTER FROM Voyage.date_voyage)=4 GROUP BY AGENCE,Trimestre;



SELECT 
	Agence.nom_agence AS AGENCE,
	EXTRACT(QUARTER FROM Voyage.date_voyage) AS Trimestre,
	Voyage.price_voyage AS PRICE
	FROM 
	Voyage 
	JOIN Agence using(id_agence)
WHERE Agence.nom_agence='CAA' AND 
EXTRACT(QUARTER FROM Voyage.date_voyage)=1 GROUP BY AGENCE,Trimestre,PRICE;

SELECT DISTINCT(Voyage.ville_destination) FROM Voyage;

/* MISE EN PLACE DE A FONCION LAG */
SELECT 
	Agence.nom_agence AS AGENCE,
	Agence.adresse AS ADRESSE_AGENCE,
	EXTRACT(YEAR FROM Voyage.date_voyage) AS ANNEE,
	COUNT(Voyage.id_agence) AS NUMBER_VOYAGE,
	COUNT(DISTINCT(Voyage.ville_destination)) AS NUMBER_COUNTRY,
	SUM(Voyage.price_voyage) AS ALL_MONEY,
	LAG(SUM(Voyage.price_voyage)) OVER(ORDER BY Voyage.id_agence) AS COMPARE
	FROM Voyage
	JOIN Agence USING(id_agence)
	GROUP BY AGENCE,ANNEE, ADRESSE_AGENCE,Voyage.id_agence;

SELECT 
	Agence.nom_agence AS AGENCE,
	Agence.adresse AS ADRESSE_AGENCE,
	EXTRACT(YEAR FROM Voyage.date_voyage) AS ANNEE,
	COUNT(Voyage.id_agence) AS NUMBER_VOYAGE,
	COUNT(DISTINCT(Voyage.ville_destination)) AS NUMBER_COUNTRY,
	SUM(Voyage.price_voyage) AS ALL_MONEY,
	LAG(SUM(Voyage.price_voyage),1,0) OVER(ORDER BY Voyage.date_created) AS COMPARE
	FROM Voyage
	JOIN Agence USING(id_agence)
	GROUP BY AGENCE,ANNEE, ADRESSE_AGENCE,voyage.date_created;
	

SELECT DATE_VENTE,
	SUM( 
		CASE 
		WHEN PRIX_VENTE < VALUE OF (PRIX_VENTE AT CURRENT ROW) THEN 1 ELSE 0 )
	OVER (ORDER BY DATE_VENTE
	ROWS BETWEEN 100 PRECEDING AND CURRENT ROW )
FROM STOCK_VENTE;
	

/*Mise en place de partition BY*/
SELECT 
	Agence.nom_agence AS AGENCE,
	Agence.adresse AS ADRESSE_AGENCE,
	EXTRACT(YEAR FROM Voyage.date_voyage) AS ANNEE,
	COUNT(Voyage.id_agence) AS NUMBER_VOYAGE,
	COUNT(DISTINCT(Voyage.ville_destination)) AS NUMBER_COUNTRY,
	SUM(Voyage.price_voyage)
	OVER(PARTITION BY Voyage.id_agence ORDER BY Agence.nom_agence GROUPS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS COMPARE
	FROM Voyage
	JOIN Agence USING(id_agence)
	GROUP BY AGENCE,ANNEE, ADRESSE_AGENCE,Voyage.id_agence,voyage.price_voyage;

/* MISE EN PLACE DE LA FONCTION NTILE */
SELECT 
	Agence.nom_agence AS AGENCE,
	Agence.adresse AS ADRESSE_AGENCE,
	EXTRACT(YEAR FROM Voyage.date_voyage) AS ANNEE,
	COUNT(Voyage.id_agence) AS NUMBER_VOYAGE,
	COUNT(DISTINCT(Voyage.ville_destination)) AS NUMBER_COUNTRY,
	SUM(Voyage.price_voyage) AS MONEY_ALL,
	NTILE(6)
	OVER(ORDER BY SUM(Voyage.price_voyage) DESC) AS NTILES
	FROM Voyage
	JOIN Agence USING(id_agence)
	GROUP BY AGENCE,ANNEE, ADRESSE_AGENCE,Voyage.id_agence,voyage.price_voyage;
	
	
SELECT * FROM Voyage;
SELECT * FROM Agence;

DELETE FROM Voyage WHERE id_voyage=22;
INSERT INTO Voyage(id_agence,ville_destination, price_voyage, date_voyage) VALUES(2, 'LUSH', 100, '2024-06-25');


SELECT * FROM Voyage;

INSERT INTO Voyage(id_agence, ville_destination, price_voyage, date_voyage)
VALUES(21, 'LUBAO', 25500, '2024-09-23');

SELECT * FROM Agence;

SELECT 
	date_created,
	COUNT(*) AS ALL_VOYAGE,
	LAG(COUNT(*),-2,0) OVER(ORDER BY date_created DESC) AS COMPARE, 
	SUM(price_voyage) AS SUM_BY_DATE,
	COUNT(DISTINCT(voyage.ville_destination)) AS NUMBER_COUNTRY
	FROM  Voyage 
	GROUP BY date_created;
	
SELECT 
	date_created,
	SUM(price_voyage) AS SUM_BY_DATE,
	LAG(SUM(price_voyage)) OVER(ORDER BY date_created DESC) AS COMPARE
	FROM  Voyage 
	GROUP BY date_created;
	
	
SELECT 
	date_created,
	COUNT(Voyage.id_voyage) AS NUMBER_VOYAGE,
	COUNT(DISTINCT(Voyage.id_agence)) AS NUMBER_COMPANY,
	COUNT(DISTINCT(Voyage.date_voyage)) AS NUMBER_DATE,
	SUM(price_voyage) AS SUM_BY_DATE,
	LAG(SUM(price_voyage),2,0) OVER(ORDER BY date_created DESC) AS COMPARE,
	CASE 
		WHEN LAG(SUM(price_voyage),2)OVER(ORDER BY date_created DESC) > SUM(price_voyage) 
			THEN LAG(SUM(price_voyage),2)OVER(ORDER BY date_created DESC) - SUM(price_voyage)
		WHEN LAG(SUM(price_voyage),2)OVER(ORDER BY date_created DESC) < SUM(price_voyage) 
			THEN SUM(price_voyage) - LAG(SUM(price_voyage),2)OVER(ORDER BY date_created DESC) 
		ELSE 0
	END INTERVALLE
	FROM  Voyage 
	GROUP BY date_created;

SELECT SUM(price_voyage) FROM Voyage WHERE date_created ='2024-02-21';

SELECT * FROM Agence NATURAL JOIN Voyage;
SELECT * FROM Voyage NATURAL JOIN Agence;

SELECT * FROM Agence;
SELECT * FROM Voyage;

SELECT * FROM Agence, Voyage WHERE Agence.id_agence=Voyage.id_agence;


	
	
	

/* LAG IGNORE NULLS A REVENIR FAIRE*/
SELECT 
	date_created,
	SUM(price_voyage) AS SUM_BY_DATE,
	LAG(SUM(price_voyage),2,0) IGNORE NULLS OVER(ORDER BY date_created DESC) AS COMPARE
	FROM  Voyage 
	GROUP BY date_created;
	
/* FONCTION LEAD */
SELECT 
	date_created,
	SUM(price_voyage) AS SUM_BY_DATE,
	LEAD(SUM(price_voyage)) OVER(ORDER BY date_created DESC) AS COMPARE
	FROM  Voyage 
	GROUP BY date_created;
	

SELECT * FROM Voyage;
SELECT * FROM Agence;

SELECT * FROM Voyage WHERE EXISTS(
	SELECT * FROM Agence WHERE id_agence=id_agence

);


SELECT * FROM personne;
SELECT * FROM Paiement;
SELECT * FROM Voyage;
SELECT * FROM Agence;

SELECT
	personne.nom AS NOM,
	personne.postnom AS POSTNOM,
	personne.prenom AS PRENOM,
	personne.sexe AS SEXE,
	voyage.ville_destination AS VILLE,
	voyage.price_voyage,
	paiement.montant_paye,
	voyage.date_voyage,
	Agence.nom_agence,
	Agence.adresse,
	CASE 
		WHEN paiement.montant_paye=voyage.price_voyage THEN 'EN ORDRE'
		WHEN paiement.montant_paye > voyage.price_voyage THEN 'AU DE LA'
		ELSE 'PAS EN ORDRE'
	END AS DECISION_VOYAGE
	FROM Personne 
	JOIN Paiement USING(id_personne) 
	JOIN Voyage USING(id_voyage) 
	JOIN Agence USING(id_agence) 
	GROUP BY 
	NOM,POSTNOM,PRENOM,SEXE,VILLE,
	voyage.price_voyage,
	paiement.montant_paye,
	voyage.date_voyage,
	Agence.nom_agence,
	Agence.adresse;
	--HAVING(paiement.montant_paye < voyage.price_voyage);

INSERT INTO Paiement(id_voyage, id_personne, montant_paye) VALUES(24,10,150);


SELECT
	paiement.id_personne AS Id_Personne_p,
	personne.nom AS NOM,
	personne.postnom AS POSTNOM,
	personne.prenom AS PRENOM,
	personne.sexe AS SEXE,
	----------Passager Info---------
	COUNT(paiement.id_personne) AS NUMBER_PAIEMENT,
	SUM(Paiement.montant_paye) AS MONTANT_PAYE,
	COUNT(DISTINCT(Voyage.ville_destination)) AS NUMBER_COUNTRY,
	COUNT(DISTINCT(Voyage.date_voyage)) AS DATE_VOYAGE,
	COUNT(DISTINCT(Voyage.id_agence)) AS AGENCE_NUMBER
	FROM Personne
	JOIN Paiement USING(id_personne)
	JOIN Voyage USING(id_voyage)
	GROUP BY Id_Personne_p,NOM, POSTNOM,PRENOM,SEXE
	ORDER BY NUMBER_PAIEMENT DESC;




--COPY DES TABLES
CREATE TABLE Agence_2 AS SELECT * FROM Agence;
SELECT * FROM Agence;
SELECT * FROM Agence_2;
DROP TABLE Agence_2;

SELECT * FROM Agence NATURAL JOIN Agence_2;

SELECT * FROM Agence
EXCEPT
SELECT * FROM Agence_2;

SELECT * FROM Agence_2
EXCEPT
SELECT * FROM Agence;

UPDATE Agence_2 SET date_created='2024-02-23' WHERE id_agence=13420;

SELECT * FROM Agence
UNION
SELECT * FROM Agence_2;

SELECT * FROM Agence
UNION ALL
SELECT * FROM Agence_2;


SELECT * FROM Agence
INTERSECT
SELECT * FROM Agence_2;


INSERT INTO Agence_2 (nom_agence, adresse, date_created)VALUES('TAKATUFU', 'KABINDA', '2024-02-23');



SELECT * FROM Voyage;
SELECT 
	EXTRACT(YEAR FROM date_voyage) AS ANNEE,
	date_voyage AS DATE_VOYAGE,
	EXTRACT(WEEK FROM date_voyage) AS SEMAINE,
	COUNT(id_voyage) AS NUMBER_VOYAGE,
	SUM(price_voyage) AS COUT
FROM Voyage 
GROUP BY ANNEE,SEMAINE,DATE_VOYAGE;



SELECT EXTRACT(WEEK FROM CAST('2023-12-31' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2023-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2024-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2027-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2027-12-31' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2028-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2030-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2022-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2021-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2020-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2019-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2011-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2010-12-31' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2018-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2016-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2017-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2016-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2005-12-31' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2004-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2003-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2002-01-01' AS DATE));
SELECT EXTRACT(WEEK FROM CAST('2001-01-01' AS DATE));

SELECT EXTRACT(WEEK FROM CAST('2023-12-30' AS DATE));

SELECT CAST('2023-01-01' AS DATE);

SELECT EXTRACT(YEAR FROM CAST('2024-01-01' AS DATE));

SELECT EXTRACT(COUNT(YEAR FROM CAST('2011-01-02' AS DATE)));


SELECT EXTRACT(YEAR FROM date_voyage) AS ANNEE, COUNT(EXTRACT(WEEK FROM date_voyage)) FROM Voyage GROUP BY ANNEE;
SELECT EXTRACT(YEAR FROM CAST('2024-01-01' AS DATE)) AS ANNEE;



CREATE TABLE testDate(
	date_jours DATE NOT NULL

);

SELECT * FROM TestDate;
ALTER TABLE TestDate ADD COLUMN argent money;
ALTER TABLE TestDate ADD COLUMN argent money NOT NULL;


UPDATE TestDate SET argent=8500;

ALTER TABLE TestDate RENAME COLUMN argent TO argents;

ALTER TABLE Voyage ALTER COLUMN date_voyage TYPE DATE;

ALTER TABLE Voyage RENAME COLUMN date_voayages TO date_voyages;

INSERT INTO testDate(date_jours) VALUES('2006-01-02');

SELECT 
	date_jours, 
	EXTRACT(QUARTER FROM date_jours) AS QUARTERS,
	EXTRACT(WEEK FROM date_jours) AS WEEK,
	---EXTRACT(WEEK FROM date_jours  ISOYEAR FROM date_jours) AS ISO_,
	EXTRACT(ISOYEAR FROM date_jours) AS ISO_YEAR
	FROM testDate;

SELECT version();


SELECT EXTRACT(DOW FROM TIMESTAMP '2001-02-16 20:38:40');

SELECT * FROM Agence;

