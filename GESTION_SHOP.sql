START TRANSACTION;

CREATE TABLE Category(
	id_category SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Annee(
	id_annee SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Product(
	id_product SERIAL NOT NULL PRIMARY KEY,
	id_category INT NOT NULL,
	id_annee INT NOT NULL,
	designation VARCHAR(254) NOT NULL,
	quantity INT NOT NULL,
	unit_price MONEY NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	subTotal MONEY GENERATED ALWAYS AS (unit_price * quantity) STORED,
	CHECK (quantity >= 1 AND CAST(unit_price AS DECIMAL) >=1)
);

ALTER TABLE Product ADD CONSTRAINT fk_category FOREIGN KEY(id_category) REFERENCES Category(id_category);
ALTER TABLE Product ADD CONSTRAINT fk_annee FOREIGN KEY(id_annee) REFERENCES Annee(id_annee);



CREATE TABLE Adresse(
	id_adresse SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Magasin(
	id_magasin SERIAL NOT NULL PRIMARY KEY,
	id_adresse INT NOT NULL,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE Magasin ADD CONSTRAINT fk_adresse FOREIGN KEY (id_adresse) REFERENCES Adresse(id_adresse);

CREATE TABLE Vendeur(
	id_vendeur SERIAL NOT NULL PRIMARY KEY,
	id_magasin INT NOT NULL,
	first_name VARCHAR(254) NOT NULL,
	last_name VARCHAR(254) NOT NULL,
	genre VARCHAR(1) NOT NULL,
	date_naiss DATE NULL,
	etat_civil BOOLEAN DEFAULT False,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK (genre='M' OR genre='F')
);

ALTER TABLE Vendeur ADD CONSTRAINT fk_magasin FOREIGN KEY (id_magasin) REFERENCES Magasin(id_magasin);


CREATE TABLE Client(
	id_client SERIAL NOT NULL PRIMARY KEY,
	first_name VARCHAR(254) NOT NULL,
	last_name VARCHAR(254) NOT NULL,
	genre VARCHAR(1) NULL,
	date_naiss DATE NULL,
	etat_civil BOOLEAN DEFAULT False,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK (genre='M' OR genre='F')
);

CREATE TABLE Commande(
	id_commande SERIAL NOT NULL PRIMARY KEY,
	id_client INT NOT NULL,
	id_vendeur INT NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE Commande ADD CONSTRAINT fk_client FOREIGN KEY(id_client) REFERENCES Client(id_client);
ALTER TABLE Commande ADD CONSTRAINT fk_vendeur FOREIGN KEY(id_vendeur) REFERENCES Vendeur(id_vendeur);


CREATE TABLE Paiement(
	id_commande INT NOT NULL,
	id_product INT NOT NULL,
	id_vendeur INT NOT NULL,
	quantity INT NOT NULL,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
	CHECK (quantity >=1)
);

ALTER TABLE Paiement ADD CONSTRAINT fk_commande FOREIGN KEY(id_commande) REFERENCES Commande(id_commande);
ALTER TABLE Paiement ADD CONSTRAINT fk_product FOREIGN KEY(id_product) REFERENCES Product(id_product);
ALTER TABLE Paiement ADD CONSTRAINT fk_vendeur FOREIGN KEY(id_vendeur) REFERENCES Vendeur(id_vendeur);

COMMIT;



ROLLBACK;



START TRANSACTION;

INSERT INTO Adresse(designation) VALUES('KABINDA'),('LUKOMBE'), ('KASUMBALESA'), ('LUBUMUBASHI'), ('KINSHASA'),
('MBUJIMAYI'), ('KANANGA'), ('SANKANIA'), ('KIPUSHI'), ('LUBAO'), ('KISANGANI'),('GOMA'), ('BUKAVU'), ('BOENDE'),
('MOANDA'), ('LILLE'), ('TOULOUSE'), ('MONTPELLIER'),('NICE'), ('BORDEAUX'), ('COLOGNE'), ('FRANCFURT'),('LIEGE'),
('BRUXELLE'), ('PARIS'),('QUEBEC'),('OTAWA'),('BURKA FASA'), ('YAOUNDE'),('ABIDJAN'), ('POINTE NOIR');


INSERT INTO Annee(designation) VALUES('2001'),('2002'), ('2003'),('2004'),('2005'),('2006'),('2007'),('2008'),('2008'),('2009'),('2010'),('2011'),
('2012'),('2013'),('2014'),('2015'),('2016'),('2017'),('2018'),('2019'),('2020'),('2021'),('2022'),('2023'),('2024');

INSERT INTO Category(designation) VALUES('ENFANT'), ('HOMME'), ('FEMME'), ('GARCON'), ('FILLE');


INSERT INTO Magasin(id_adresse, designation) VALUES(1, 'HENRI SHOP 1'),(2, 'HENRI SHOP 1'),(2, 'HENRI SHOP 2'),
(1, 'HENRI SHOP 2'),(1, 'HENRI SHOP 3'),(3, 'HENRI SHOP 1'),(4, 'HENRI SHOP 1'),(10, 'HENRI SHOP 1'),
(10, 'HENRI SHOP 2'),(9, 'HENRI SHOP 1'),(8, 'HENRI SHOP 1'),(14, 'HENRI SHOP 1'),(10, 'HENRI SHOP 1'),
(10, 'HENRI SHOP 3'),(15, 'HENRI SHOP 1'),(16, 'HENRI SHOP 1'),(17, 'HENRI SHOP 1'),(10, 'HENRI SHOP 4');

COMMIT;


SELECT * FROM Adresse;
SELECT * FROM Category;
SELECT * FROM Magasin;
SELECT * FROM Annee;
SELECT * FROM Product;

SELECT * FROM Adresse WHERE id_adresse IN(SELECT id_adresse FROM Magasin);


SELECT 
	Adresse.designation AS VILLE,
	COUNT(Magasin.id_adresse) AS NOMBRE_MAGASIN,
	DENSE_RANK()
	OVER(ORDER BY COUNT(Magasin.id_adresse) DESC) AS CLASSEMENT
	FROM Adresse
	JOIN Magasin USING(id_adresse)
	GROUP BY VILLE ORDER BY CLASSEMENT ASC;


BEGIN;

INSERT INTO Product(id_category, id_annee, designation, quantity,unit_price)
VALUES(1,1,'PANTALON', 14, 18500), (1, 1, 'CHEMISE NEWS', 12,4500), (2,1, 'SOUS VETEMENT', 18,3500),
(2, 2, 'SOUS VETEMENT', 150, 3800);

COMMIT;


INSERT INTO Product(id_category, id_annee, designation, quantity,unit_price)
VALUES(5, 5, 'PARA', 40, 450),(5,5, 'DEXA',450, 1000) RETURNING id_category, id_annee, designation, quantity,unit_price;

SELECT * FROM Product;

SELECT * FROM Annee WHERE id_annee IN(SELECT id_annee FROM Product);

SELECT 
	Annee.designation AS ANNEE,
	COUNT(Product.id_annee) AS NOMBRE_PRODUIT,
	COUNT(DISTINCT(Product.id_category)) AS NUMBER_CATEGORY,
	SUM(SubTotal) AS TOTAL
	FROM Product
	JOIN Annee USING(id_annee) 
	GROUP BY ROLLUP(ANNEE) ORDER BY ANNEE;


SELECT * FROM Client;

INSERT INTO Client(first_name, last_name, genre, etat_civil)
VALUES('Patrick', 'Kasongo', 'M',True), ('ARSENE', 'KABUYA', 'M', True),
('HENRI', 'KIUKA', 'M', False);



SELECT * FROM Commande;
SELECT * FROM Vendeur;

INSERT INTO Vendeur(id_magasin,first_name, last_name, genre)
VALUES(5, 'JEAN PIERRE', 'MITANTA', 'M'),(2,'JOSE', 'NGOYI', 'F'),
(5, 'YAMAKUNDA','DIEUM', 'M'), (1,'PIERRE', 'EBONDO', 'M')
RETURNING id_magasin,first_name, last_name, genre;


INSERT INTO Vendeur(id_magasin,first_name, last_name, genre)
VALUES(1, 'GILBERT', 'NGOYI', 'M');



SELECT * FROM Magasin WHERE id_magasin IN(SELECT id_magasin FROM Vendeur);


SELECT 
	Magasin.designation AS MAGASIN,
	Adresse.designation AS VILLE,
	COUNT(DISTINCT(Commande.id_vendeur)) AS VENDEUR_MAGASIN,
	COUNT(Commande.id_vendeur) AS NUMBER_COMMANDE
	FROM Magasin
	JOIN Adresse USING(id_adresse)
	JOIN Vendeur USING(id_magasin)
	JOIN Commande USING(id_vendeur)
	GROUP BY Magasin.designation,Adresse.designation;

SELECT * FROM Commande;
SELECT * FROM Paiement;
SELECT * FROM Client;
SELECT * FROM Product;
TRUNCATE TABLE Commande CASCADE;

DELETE FROM Paiement WHERE id_commande=15 AND id_product=3 AND quantity=11;

INSERT INTO Commande(id_client, id_vendeur) VALUES(2, 1) RETURNING id_client, id_vendeur;

INSERT INTO Paiement(id_commande,id_vendeur, id_product, quantity) VALUES(14,1,3,12),(15,1,7,7);

UPDATE Paiement SET id_commande=15 WHERE id_commande=14 AND id_product=3;

SELECT 
	--CONCAT(Vendeur.first_name, ' ', Vendeur.last_name) AS VENDEUR,
	--COALESCE(Vendeur.first_name) AS VENDEUR,
 	COALESCE(Product.designation) AS PRODUIT,
	--Category.designation AS CATEGORY,
	SUM(paiement.quantity) AS QUANTITE_CMD,
	SUM(Product.unit_price) AS PRIX_UNITAIRE,
	SUM(Product.unit_price * paiement.quantity) AS SOUS_TOTAL
	FROM Paiement
	JOIN Product USING(id_product)
	JOIN Vendeur USING(id_vendeur)
	JOIN Category USING(id_category)
	WHERE id_commande=14
	--GROUP BY GROUPING SETS((VENDEUR, PRODUIT, CATEGORY), ())
	GROUP BY ROLLUP(Product.designation)
	ORDER BY Product.designation;
	



SELECT * FROM Paiement WHERE id_commande=15;

SELECT * FROM product;

ALTER TABLE product RENAME COLUMN subtotal TO subTotal;


--ALTER TABLE Product MODIFY COLUMN subtotal subtotals;


ALTER TABLE Product ALTER COLUMN subtotals TYPE MONEY;

SELECT * FROM Adresse;

SELECT * FROM Magasin;

--ESSAIE PARTITION

	
SELECT * FROM product;	

SELECT 
	--product.designation AS Products,
	category.designation AS CATEGORY,
	product.unit_price,
	RANK()
	OVER(PARTITION BY category.designation ORDER BY product.unit_price DESC) 
	AS MY_PARTITION
	FROM Product
	JOIN Category USING(id_category) GROUP BY category.designation,product.unit_price;
	
SELECT 
	--product.designation AS Products,
	category.designation AS CATEGORY,
	AVG(CAST(product.unit_price AS DECIMAL)),
	RANK()
	OVER(PARTITION BY category.designation)
	FROM Product
	JOIN Category USING(id_category) 
	GROUP BY category.designation,product.designation;
	
SELECT * FROM Category;	

INSERT INTO Category(designation)VALUES('HOMME'), ('HOMME');

SELECT * FROM Product;

INSERT INTO Product(id_category, id_annee, designation, quantity, unit_price)
VALUES(7, 7, 'DACKIN', 25,1500);
	


