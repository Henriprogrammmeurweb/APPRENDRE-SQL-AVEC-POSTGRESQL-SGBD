---Tables : Événements, Participants, Lieux, Inscriptions, Organisateurs

START TRANSACTION;

CREATE TABLE Annee(
	id_annee SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254),
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Lieux(
	id_lieu SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254),
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Participants(
	id_participant SERIAL NOT NULL PRIMARY KEY,
	nom VARCHAR(254) NOT NULL,
	postnom VARCHAR(254) NOT NULL,
	prenom VARCHAR(254) NOT NULL,
	sexe VARCHAR(1) NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK (sexe = 'M' or sexe = 'F')
);

CREATE TABLE Organisateur(
	id_participant SERIAL NOT NULL PRIMARY KEY,
	nom VARCHAR(254) NOT NULL,
	postnom VARCHAR(254) NOT NULL,
	prenom VARCHAR(254) NOT NULL,
	sexe VARCHAR(1) NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK (sexe = 'M' OR sexe = 'F')
);

CREATE TABLE Evenements(
	id_evenement SERIAL NOT NULL PRIMARY KEY,
	id_lieu INT NOT NULL,
	id_annee INT NOT NULL,
	titre VARCHAR(254) NOT NULL,
	date_evenement DATE NOT NULL,
	heure_debut TIME NOT NULL,
	heure_fin TIME NOT NULL,
	description TEXT,
	nombre_participant INT NOT NULL,
	cout DECIMAL NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK (nombre_participant >= 1),
	CHECK (cout >= 1)
);

CREATE TABLE Organiser(
	id_evenement INT NOT NULL,
	id_organisateur INT NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id_evenement, id_organisateur)
);

CREATE TABLE participer(
	id_participant INT NOT NULL,
	id_evenement INT NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id_participant, id_evenement)
);


COMMIT;



ALTER TABLE Evenements ADD CONSTRAINT fk_annee FOREIGN KEY(id_annee) REFERENCES Annee(id_annee); 
ALTER TABLE Evenements ADD CONSTRAINT fk_lieu FOREIGN KEY(id_lieu) REFERENCES Lieux(id_lieu); 

ALTER TABLE Organisateur RENAME COLUMN id_participant TO id_organisateur;

ALTER TABLE Organiser ADD CONSTRAINT fk_envenement FOREIGN KEY(id_evenement) REFERENCES Evenements(id_evenement);
ALTER TABLE Organiser ADD CONSTRAINT fk_organisateur FOREIGN KEY(id_organisateur) REFERENCES Organisateur(id_organisateur);



ALTER TABLE Participer ADD CONSTRAINT fk_evenement FOREIGN KEY(id_evenement) REFERENCES Evenements(id_evenement);
ALTER TABLE Participer ADD CONSTRAINT fk_participant FOREIGN KEY(id_participant) REFERENCES Participants(id_participant);



START TRANSACTION;

INSERT INTO Lieux(designation) VALUES('KABINDA'),('LUBAO'),('GOMA'),('LODJA'),('LUKOMBE'),('KINDU'), ('NKONGOLO'), ('SANKANIA'), ('KASUMBALESA'), ('LUBUMBASHI'), ('KINSHASA'),('LILLE'),
('TOULESE'),('BORDEAUX'), ('MONTPELLIER'),('NICE'),('BRUXELLE'),('LIEGE'),('ABIDJAN'),('TUNIS'),('QUEBEC'),('OTTAWA'),('MBUJIMAYI'),('KANANGA'),('TSHOFA'),('KAMANA');

INSERT INTO Annee(designation) VALUES('2001'),('2002'),('2003'),('2004'),('2005'),('2006'),('2007'),
('2008'),('2009'),('2010'),('2011'),('2012'),('2013'),('2014'),('2015'),('2016'),('2017'),('2018'),('2019'),
('2020'),('2021'),('2022'),('2023'),('2024');

COMMIT;

SELECT * FROM Annee;
SELECT * FROM Lieux;


INSERT INTO Participants(nom, postnom, prenom, sexe)
VALUES('NGOYI', 'KIOMBA', 'GENTIL', 'M'),
('NGOLO', 'MBAYO', 'DENISE', 'F'),('LUAMBA', 'NGOYI', 'PASCALINE', 'F'),
('MATUMBA', 'KAPENGA', 'PRINCE', 'M'), ('KALENGA', 'MUTOMBO', 'MIKE', 'M'),
('KASONGO', 'KITENGIE', 'SHEKINAH', 'F'), ('KABEDI', 'KALUBI', 'LUCIANNA', 'F'),
('KAZAD', 'NACIBAD', 'FELICITE', 'F');

SELECT * FROM Participants;

INSERT INTO Organisateur(nom, postnom, prenom, sexe)
VALUES('KABAMBA', 'KABAMBA', 'DESIRE', 'M'),
('FRAM', 'KINYENGA', 'FRAM', 'M'),
('EBONDO', 'MUKOMENA', 'ADEL', 'F'),
('NGOYI', 'NKUENYI', 'DECHRIS', 'M'),
('NGOYI', 'MALOBA', 'GILBERT', 'M'),
('LUSANGA', 'ILUNGA', 'JULES CESAR', 'M'),
('BINGI', 'KAMBILO', 'ALI', 'M'),
('ARLETTE', 'ARLETTE BINGI', 'PREMIERE DAME', 'F'),
('MUIKIEMUNE', 'LUMONGA', 'AIMERANCE', 'F'),
('NTAMBWE', 'LUBAMBA', 'BEATRICE','F'),
('SHESHA', 'FUAMBA','PAULIN BATONIER', 'M'),
('KABUYA', 'ARSENE', 'MR ARSENE', 'M'),
('FERNAND', 'ALI', 'FERNAND', 'M'),
('GEORGES', 'KOUAMOU', 'EDOUARD', 'M');

SELECT * FROM Organisateur;

SELECT * FROM Evenements;


SELECT * FROM Lieux;

SELECT CAST(cout AS MONEY) FROM Evenements;

DELETE FROM Evenements WHERE id_evenement=2;

INSERT INTO Evenements(id_lieu, id_annee,titre,date_evenement,heure_debut,heure_fin,description,nombre_participant, cout)
VALUES(21,1, 'LES DEVELOPPEURS FRANCOPHONES', '2001-01-01','07:15:35', '14:15:00', 'Au cours de cet evenement les developpeurs francophone doivent s exprimer par rapport à l AI', 
	   1500,5000);
	   
INSERT INTO Evenements(id_lieu, id_annee,titre,date_evenement,heure_debut,heure_fin,description,nombre_participant, cout)
VALUES(13,5, 'LES DATA SCIENTISTES 01', '2005-05-25','09:15:00', '14:00:00', 'Pour visualiser les données de FACEBOOK', 
	   450,15000);
	   
INSERT INTO Evenements(id_lieu, id_annee,titre,date_evenement,heure_debut,heure_fin,description,nombre_participant, cout)
VALUES(13,5, 'LES DATA SCIENTISTES 02', '2005-05-25','09:15:00', '14:00:00', 'Pour visualiser les données de FACEBOOK', 
	   450,18000);
	   
SELECT * FROM Organisateur;	   

SELECT * from Organiser;


INSERT INTO Organiser(id_evenement, id_organisateur) VALUES(1,5),(1,3),(1,8);
INSERT INTO Organiser(id_evenement, id_organisateur) VALUES(5,5),(3,5);


SELECT
	lieux.designation AS VILLE,
	annee.designation AS ANNEE,
	Evenements.titre AS EVENEMENT,
	COUNT(Organiser.id_organisateur) AS NUMBER_ORGANISATEUR
	FROM Evenements
	JOIN Lieux USING(id_lieu)
	JOIN Annee USING(id_annee)
	JOIN Organiser USING(id_evenement)
	INNER JOIN Organisateur ON Organisateur.id_organisateur=Organiser.id_organisateur
	GROUP BY VILLE, ANNEE, EVENEMENT;


SELECT * FROM Organiser;


SELECT * FROM Organisateur WHERE id_organisateur IN(SELECT id_organisateur FROM Organiser);

SELECT 
	nom, 
	postnom,
	prenom,sexe, 
	COUNT(organiser.id_organisateur) AS NB_PART,
	CAST(SUM(Evenements.cout) AS MONEY) AS COUT_EVENEMENT,
	CAST(SUM(Evenements.cout) * COUNT(organiser.id_organisateur) AS MONEY) AS SALAIRE
	FROM Organisateur
	JOIN Organiser USING(id_organisateur)
	JOIN Evenements USING(id_evenement)
	GROUP BY nom, postnom, prenom, sexe;
	
SELECT * FROM Evenements;

SELECT SUM(cout) FROM Evenements;
SELECT * FROM Participants;
SELECT * FROM Participer;

INSERT INTO Participer(id_participant, id_evenement) VALUES(2, 1);
INSERT INTO Participer(id_participant, id_evenement) VALUES(10, 1);
INSERT INTO Participer(id_participant, id_evenement) VALUES(14, 1);
INSERT INTO Participer(id_participant, id_evenement) VALUES(20, 1);
INSERT INTO Participer(id_participant, id_evenement) VALUES(23, 1);
INSERT INTO Participer(id_participant, id_evenement) VALUES(11, 1);
INSERT INTO Participer(id_participant, id_evenement) VALUES(17, 1);
INSERT INTO Participer(id_participant, id_evenement) VALUES(18, 1);
INSERT INTO Participer(id_participant, id_evenement) VALUES(22, 3);


SELECT * FROM Participants WHERE id_participant IN(SELECT id_participant FROM Participer);



SELECT 
	Evenements.id_evenement AS ID_EVENT,
	Evenements.titre AS TITRE_EVENEMENT,
	COUNT(participer.id_participant)
	FROM Participer
	JOIN Evenements USING(id_evenement)
	GROUP BY GROUPING SETS ((ID_EVENT,TITRE_EVENEMENT),()) ORDER BY TITRE_EVENEMENT;

SELECT * FROM lieux;


SELECT * FROM Lieux WHERE id_lieu=1
UNION
SELECT * FROM Lieux WHERE id_lieu=4;


SELECT 
	Annee.designation AS ANNEE,
	COUNT(Evenements.id_evenement) AS EVENT_NUB,
	COUNT(participer.id_evenement) AS PARTICIPANTS_NUB,
	--LAG(COUNT(Annee.id_annee)) OVER(ORDER BY Evenements.id_annee) AS COMPARE_1,
	--DENSE_RANK()
	--OVER(ORDER BY COUNT(Evenements.id_annee) DESC) AS CLASSEMENT,
	COUNT(DISTINCT(Lieux.id_lieu)) AS NUMBER_COUNTRY
	FROM Annee
	JOIN Evenements  USING(id_annee)
	JOIN Lieux USING(id_lieu)
	JOIN Participer USING(id_evenement)
	GROUP BY ANNEE,evenements.id_annee;
	
	
SELECT 
	Evenements.titre AS TITLE,
	COUNT(participer.id_participant)
	FROM Evenements
	JOIN Participer USING(id_evenement)
	GROUP BY TITLE;
	

	
SELECT * FROM Participer;
	
SELECT * FROM Annee WHERE id_annee IN(SELECT id_annee FROM Evenements);

SELECT * FROM Evenements;




SELECT
	Annee.designation AS ANNEE_,
	Evenements.titre AS EVENEMENT,
	COUNT(Participer.id_evenement) AS NUB_PART,
	COUNT(DISTINCT(Lieux.id_lieu)) AS NUB_LIEUX
	FROM Evenements
	JOIN Lieux USING(id_lieu)
	JOIN Participer USING(id_evenement)
	JOIN Annee USING(id_annee)
	GROUP BY EVENEMENT, ANNEE_;
	
	

SELECT ANNEE,EVENEMENT,NUMB_PART FROM (
	SELECT 
		Annee.designation AS ANNEE,
		COUNT(Evenements.id_annee) AS EVENEMENT,
		COUNT(participer.id_evenement) AS NUMB_PART
		FROM Evenements
		JOIN Participer USING(id_evenement)
		JOIN Annee USING(id_annee) GROUP BY ANNEE
) AS TEMPO;
	

SELECT 
	Annee.designation AS ANNEE,
	COUNT(Evenements.id_evenement) AS EVENEMENT,
	COUNT(participer.id_evenement)
	FROM Evenements
	LEFT JOIN Participer USING(id_evenement)
	JOIN Annee USING(id_annee) GROUP BY ANNEE;
	
	

SELECT * FROM Evenements;

SELECT * FROM Participer;
SELECT * FROM Organiser;

INSERT INTO Participer(id_participant,id_evenement) VALUES(4,4);


SELECT * FROM Participants;

SELECT * FROM Participants WHERE id_participant IN (SELECT id_participant FROM Participer);

SELECT 
	participants.nom AS NOM,
	participants.postnom AS POSTNOM,
	participants.prenom AS PRENOM,
	participants.sexe AS GENRE,
	COUNT(participer.id_participant) AS NUMBER_PARTICIPE,
	CASE 
		WHEN COUNT(participer.id_participant) >= 4 THEN 5000
		WHEN COUNT(participer.id_participant) = 2 THEN 2500
	ELSE 0 END AS TROMPHE
	FROM Participer
	RIGHT JOIN Participants USING(id_participant)
	RIGHT JOIN Evenements USING(id_evenement)
	GROUP BY  NOM,POSTNOM,PRENOM,GENRE
	ORDER BY NOM;

	
SELECT COUNT(titre) FROM Evenements;


SELECT
	Lieux.designation AS LIEUX,
	Annee.designation AS ANNEE,
	Evenements.titre AS EVENEMENTS,
	COUNT(participer.id_evenement) AS NUMB_PART,
	LAG(COUNT(participer.id_evenement),1,0) 
	OVER(ORDER BY Evenements.id_evenement) COMPARAISON,
	DENSE_RANK()
	OVER(ORDER BY COUNT(Evenements.id_evenement) DESC) AS CLASSEMENT
	FROM Evenements
	JOIN Participer USING(id_evenement)
	JOIN Lieux USING(id_lieu)
	JOIN Annee USING(id_annee)
	GROUP BY EVENEMENTS,participer.id_evenement,Evenements.id_evenement,LIEUX,ANNEE;



