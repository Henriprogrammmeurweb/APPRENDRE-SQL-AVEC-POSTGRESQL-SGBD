--TABLES :
-- Adresse or Ville
--Magasin,Produits,Fournisseurs,ventes, 
--employes,Clients,CommandeClient,CommandeMagasin,
--- Annee,CategorieProduct,ClasseEmploye,Paiement


START TRANSACTION;

CREATE TABLE Ville(
	id_ville SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	content_magasin BOOLEAN NULL DEFAULT FALSE,
	content_fornisseur BOOLEAN NULL DEFAULT FALSE,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Ville (designation) VALUES('KABINDA'),('MBUJIMAYI'),('LILLE'),('TOULOUSE'),('NICE'),('BUKAVU'),('LUBUMBASHI'),('KOLWEZI'),
('KANANGA'),('TSHIKAPA'),('MATADI'),('LIEGE'),('BRUXELLE'),('LUBAO'),('LUKOMBE'),('QUEBEC'),('ABIDJAN'),('CAPTON'),('GENEVE'),('FRANCFURT'),('KOLOGNE'),
('KINSHASA'),('KALEMIE'),('KISANGANI'),('KASUMBALESA'),('LIKASI'),('DITU'),('KAMINA'),('LUPUTA'),('WIKONGE'),('LODJA'),('TSHIUMBE'),('TSHOFA'),
('DILOLO'), ('SALAMABILA'),('NKONGOLO');


CREATE TABLE Magasin(
	id_magasin SERIAL NOT NULL PRIMARY KEY,
	id_ville INT NOT NULL,
	designation VARCHAR(254) NOT NULL,
	content_vendeur BOOLEAN NULL DEFAULT FALSE,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE Magasin ADD CONSTRAINT fk_ville_magasin FOREIGN KEY(id_ville) REFERENCES Ville(id_ville);

INSERT INTO Magasin(id_ville, designation) VALUES(1, 'M HENRI 1'),(1, 'M HENRI 2'),(3, 'M HENRI 1'),(8,'HENRI 1'),
(7,'HENRI 1'),(7,'HENRI 2'),(7,'HENRI 3'),(7,'HENRI 4'),(6,'HENRI 1'),(13,'HENRI 1'),(13,'HENRI 2');

CREATE TABLE Fournisseurs(
	id_fournisseur SERIAL NOT NULL PRIMARY KEY,
	id_ville INT NOT NULL,
	designation VARCHAR(254) NOT NULL,
	pass_order BOOLEAN NULL DEFAULT FALSE,
	date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE Fournisseurs ADD CONSTRAINT fk_ville_fournisseur FOREIGN KEY(id_ville) REFERENCES Ville(id_ville);

INSERT INTO Fournisseurs(id_ville, designation) VALUES(1, 'JAMBO MART'),(1, 'GIMELLO HOUSE'),(8, 'SAKULU'),(10, 'MULYKAP'),(12,'MANASSE HOUSE');

COMMIT;

START TRANSACTION;

	CREATE TABLE Category(
		id_category SERIAL NOT NULL PRIMARY KEY,
		designation VARCHAR(254),
		date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
	);

	CREATE TABLE Annee(
		id_annee SERIAL NOT NULL PRIMARY KEY,
		designation VARCHAR(254),
		date_created DATE NULL DEFAULT CURRENT_TIMESTAMP
	);
	
	CREATE TABLE Product(
		id_product SERIAL NOT NULL PRIMARY KEY,
		id_category INT NOT NULL,
		id_annee INT NOT NULL,
		id_fournisseur INT NOT NULL,
		designation VARCHAR(254) NOT NULL,
		quantity INT NOT NULL,
		price_unit DECIMAL NOT NULL,
		date_created DATE NULL DEFAULT CURRENT_TIMESTAMP,
		sousTotal MONEY GENERATED  ALWAYS AS (price_unit * quantity) STORED,
		CHECK (quantity >= 1),
		CHECK (price_unit >= 1)
	
	);
	
	ALTER TABLE Product ADD CONSTRAINT fk_category FOREIGN KEY(id_category) REFERENCES Category(id_category);
	ALTER TABLE Product ADD CONSTRAINT fk_annee FOREIGN KEY(id_annee) REFERENCES Annee(id_annee);
	ALTER TABLE Product ADD CONSTRAINT fk_fournisseur FOREIGN KEY(id_fournisseur) REFERENCES Fournisseurs(id_fournisseur);

COMMIT;







SELECT * FROM Magasin;
SELECT * FROM Ville;
SELECT * FROM Fournisseurs;

DROP PROCEDURE IF EXISTS Ps_insertData;

--CREATION DES PROCEDURES STOCKEES
--Procedure pour insérer
CREATE OR REPLACE PROCEDURE 
	Ps_insertDataFournisseurs(_id_ville INT, _designation VARCHAR)
	LANGUAGE SQL AS $$
		INSERT INTO Fournisseurs(id_ville,designation) VALUES(_id_ville, _designation);
	$$;

CALL Ps_insertDataFournisseurs(3, 'NEWS SAFI');

CREATE OR REPLACE PROCEDURE Ps_UpdateDataVilleFournisseurs(_id_fornisseur INT, _id_ville INT)
LANGUAGE SQL AS $$
	UPDATE Fournisseurs SET  id_ville=_id_ville WHERE id_fournisseur=_id_fornisseur;
$$;

CALL Ps_UpdateDataVilleFournisseurs(8,8);

CREATE OR REPLACE PROCEDURE Ps_UpdateDataDesignationFournisseurs(_id_fornisseur INT, _designation VARCHAR)
LANGUAGE SQL AS $$
	UPDATE Fournisseurs SET  designation=_designation WHERE id_fournisseur=_id_fornisseur;
$$;

CALL Ps_UpdateDataDesignationFournisseurs(8, 'GIMELLO HOUSE');


CREATE OR REPLACE PROCEDURE Ps_DeleteFournisseur(_id_fournisseur INT)
LANGUAGE SQL AS $$
	DELETE FROM Fournisseurs WHERE id_fournisseur=_id_fournisseur;
$$;

CALL Ps_DeleteFournisseur(6);

DROP PROCEDURE display_Ville;

CREATE OR REPLACE PROCEDURE display_Ville()
	LANGUAGE SQL AS $$ SELECT * FROM Ville; $$;
	
CALL display_Ville();
	

SELECT * FROM Ville;

UPDATE Ville SET content_fornisseur=True WHERE id_ville IN(SELECT id_ville FROM Fournisseurs);

SELECT * FROM Fournisseurs;

--CREATE DE TRIGGER

CREATE OR REPLACE FUNCTION Insert_Fournisseur()
	RETURNS TRIGGER AS $insert_f$
	BEGIN
	IF NEW.id_ville NOT IN (SELECT id_ville FROM Fournisseurs) THEN
		UPDATE Ville SET content_fornisseur=True WHERE id_ville=NEW.id_ville;
	END IF;
		RETURN NEW;
	END
$insert_f$ LANGUAGE plpgsql;



CREATE TRIGGER 
	ChangeLineTrue 
	BEFORE INSERT ON Fournisseurs FOR EACH ROW EXECUTE PROCEDURE
	Insert_Fournisseur();


SELECT * FROM Ville;

SELECT * FROM Fournisseurs;

INSERT INTO Fournisseurs(id_ville, designation) VALUES(2,'KLM');


SELECT * FROM Ville;


CREATE OR REPLACE FUNCTION update_Fournisseurs() RETURNS TRIGGER AS $update_f$
	BEGIN
		IF NEW.id_ville NOT IN (SELECT id_ville FROM Fournisseurs) THEN
			UPDATE Ville SET content_fornisseur=True WHERE id_ville=NEW.id_ville;
		END IF;
		ELSE IF OLD.id_ville <> NEW.id_ville AND OLD.id_ville IN(SELECT id_ville FROM Fournisseurs) THEN
			IF SELECT COUNT(OLD.id_ville)  IN(SELECT id_ville FROM Fournisseurs)

		RETURN NEW;
	END
$update_f$ LANGUAGE plpgsql;


CREATE 
	OR REPLACE TRIGGER update_ville_Fournisseur 
	AFTER UPDATE ON Fournisseurs FOR EACH ROW EXECUTE PROCEDURE update_Fournisseurs();
	
	
SELECT * FROM Ville WHERE content_fornisseur=False and id_ville=12;
SELECT * FROM Fournisseurs; WHERE id_ville=36;
UPDATE Ville SET content_fornisseur=False WHERE id_ville=13;

UPDATE Fournisseurs SET id_ville=10 WHERE id_ville=36;
--UPINSERT
SELECT * FROM Ville;

INSERT INTO Ville(id_ville, designation) VALUES(4, 'BOENDE')
ON CONFLICT(id_ville)
DO UPDATE SET 
designation=EXCLUDED.designation;

INSERT INTO Ville(id_ville, designation) VALUES(4, 'BOENDE')
ON CONFLICT(id_ville)
DO NOTHING;






--LE FENETRAGE AVEC ROW_NUMBER
SELECT ROW_NUMBER()OVER(ORDER BY designation) AS N°, * FROM Fournisseurs;

SELECT * FROM Ville;

INSERT INTO Fournisseurs(id_ville,designation) VALUES(7, 'MATOSKA');
INSERT INTO Fournisseurs(id_ville,designation) VALUES(7, 'DEKALO');
INSERT INTO Fournisseurs(id_ville,designation) VALUES(7, 'DE NSA');
INSERT INTO Fournisseurs(id_ville,designation) VALUES(7, 'KABEMBA KABUELE');

CREATE VIEW V_NUMBER_FOURNISSEUR_VILLE AS 
	SELECT
		ROW_NUMBER()OVER(ORDER BY ville.designation) AS NUM,
		ville.designation AS VILLE,
		COUNT(fournisseurs.id_ville) AS NUMBER_FOURNISSEUR
		FROM Fournisseurs
		JOIN Ville USING (id_ville)
		GROUP BY VILLE;
	
CREATE VIEW LISTE_MAGASIN_ET_FOURNISSEUR_PAR_VILLE AS 
	SELECT
		ROW_NUMBER()OVER(ORDER BY ville.designation) AS NUM,
		ville.designation AS VILLE,
		COUNT(DISTINCT(Magasin.id_magasin)) AS NUMBER_MAGASIN,
		COUNT(DISTINCT(Fournisseurs.id_fournisseur)) AS NUMB_F
		FROM Ville
		LEFT JOIN Magasin USING(id_ville) 
		LEFT JOIN Fournisseurs USING(id_ville)
		GROUP BY VILLE;
	
	
SELECT
	ROW_NUMBER()OVER(ORDER BY ville.designation) AS NUM,
	ville.designation AS VILLE,
	COUNT(DISTINCT(Magasin.id_magasin)) AS NUMBER_MAGASIN,
	COUNT(DISTINCT(Fournisseurs.id_fournisseur)) AS NUMB_F
	FROM Ville
	LEFT JOIN Magasin USING(id_ville) 
	LEFT JOIN Fournisseurs USING(id_ville)
	GROUP BY VILLE HAVING(COUNT(DISTINCT(Magasin.id_magasin)))=0 AND COUNT(DISTINCT(Fournisseurs.id_fournisseur))=0;
	
SELECT
	ROW_NUMBER()OVER(ORDER BY ville.designation) AS NUM,
	ville.designation AS VILLE,
	COUNT(DISTINCT(Magasin.id_magasin)) AS NUMBER_MAGASIN,
	COUNT(DISTINCT(Fournisseurs.id_fournisseur)) AS NUMB_F
	FROM Ville
	LEFT JOIN Magasin USING(id_ville) 
	LEFT JOIN Fournisseurs USING(id_ville)
	GROUP BY VILLE HAVING(COUNT(DISTINCT(Magasin.id_magasin))) >=1 AND COUNT(DISTINCT(Fournisseurs.id_fournisseur))=0;
		
SELECT
	ROW_NUMBER()OVER(ORDER BY ville.designation) AS NUM,
	ville.designation AS VILLE,
	COUNT(DISTINCT(Magasin.id_magasin)) AS NUMBER_MAGASIN,
	COUNT(DISTINCT(Fournisseurs.id_fournisseur)) AS NUMB_F
	FROM Ville
	LEFT JOIN Magasin USING(id_ville) 
	LEFT JOIN Fournisseurs USING(id_ville)
	GROUP BY VILLE HAVING(COUNT(DISTINCT(Magasin.id_magasin)))=0 AND COUNT(DISTINCT(Fournisseurs.id_fournisseur)) >=1;
			
		
SELECT
	ROW_NUMBER()OVER(ORDER BY ville.designation) AS NUM,
	ville.designation AS VILLE,
	COUNT(DISTINCT(Magasin.id_magasin)) AS NUMBER_MAGASIN,
	COUNT(DISTINCT(Fournisseurs.id_fournisseur)) AS NUMB_F
	FROM Ville
	LEFT JOIN Magasin USING(id_ville) 
	LEFT JOIN Fournisseurs USING(id_ville)
	GROUP BY VILLE HAVING(COUNT(DISTINCT(Magasin.id_magasin))) >= 1 AND COUNT(DISTINCT(Fournisseurs.id_fournisseur)) >= 1;
	

		
		
SELECT * FROM Ville;
	
SELECT
	ROW_NUMBER()OVER(ORDER BY ville.designation) AS NUM,
	ville.designation AS VILLE,
	COUNT(DISTINCT(Magasin.id_magasin)) AS NUMBER_MAGASIN
	FROM Ville
	JOIN Magasin USING(id_ville) 
	GROUP BY VILLE;
	
	

SELECT * FROM Magasin;




SELECT * FROM v_number_fournisseur_ville;
SELECT * FROM LISTE_MAGASIN_ET_FOURNISSEUR_PAR_VILLE;


SELECT * FROM Fournisseurs;


DELETE FROM Fournisseurs WHERE id_fournisseur=16;


INSERT INTO	Annee(designation) VALUES ('2000'),('2001'),('2002'),
	('2003'),('2004'),('2005') RETURNING *;


INSERT INTO	Category(designation) VALUES ('ADULTE'),('ENFANT'),('FEMMES'),
	('HOMME'),('MINE'),('TOXIQUE') RETURNING *;

INSERT INTO	Category(designation) VALUES ('WHITE') RETURNING *;


SELECT * FROM Product;
SELECT * FROM Fournisseurs;

INSERT INTO Product(id_category, id_annee,id_fournisseur,designation, quantity, price_unit)
VALUES(2, 2,1,'CHEMISE',25,3500),(1,2, 2, 'CULOTTES',45, 2500),(4,1,1, 'PANTANLON',30,5500) RETURNING *;


INSERT INTO Product(id_category, id_annee,id_fournisseur,designation, quantity, price_unit)
VALUES(2, 2,2,'CHEMISE MARK',1,500);


SELECT * FROM Product;


INSERT INTO Product(id_category, id_annee,id_fournisseur,designation, quantity, price_unit)
VALUES (5, 4, 14, 'PARA', 12,150) RETURNING *;

INSERT INTO Product(id_category, id_annee,id_fournisseur,designation, quantity, price_unit)
VALUES (8, 4, 14, 'DOLAREIN', 15,450) RETURNING *;


SELECT 
	Product.designation AS PRODUITS,
	Product.quantity AS QUANT_PRODUITS,
	Product.price_unit AS PRIX_UNITAIRES,
	Product.soustotal AS SOUS_TOTAL
	FROM Product GROUP BY
	GROUPING SETS ((PRODUITS,QUANT_PRODUITS,PRIX_UNITAIRES,SOUS_TOTAL),());
	
SELECT 
	ROW_NUMBER() OVER(ORDER BY COALESCE(Category.designation)) AS N°,
	CASE
		WHEN Category.designation IS NOT NULL THEN Category.designation 
		ELSE 'TOTAL GENERAL' END AS CATEGORY,
	COUNT(Product.quantity) AS QUANTITE,
	SUM(Product.price_unit) AS PRIX_UNIT,
	SUM(Product.soustotal) AS SOUS_TOTAL
	FROM Product
	JOIN Category USING(id_category)
	GROUP BY GROUPING SETS((Category.designation),()) ORDER BY Category.designation;


SELECT * FROM Fournisseurs WHERE id_fournisseur IN(SELECT id_fournisseur FROM Product);


SELECT
	Fournisseurs.designation AS FOURNISSEURS,
	Ville.designation AS VILLE,
	Annee.designation AS ANNEE,
	COUNT(Product.id_product) AS NUB_PRODUCT,
	SUM(Product.quantity) AS NUB_QUANTITY,
	SUM(Product.soustotal) AS SOMME,
	LAG(SUM(Product.soustotal),1,CAST(0 as MONEY))
		OVER(ORDER BY Fournisseurs.designation) AS COMPARAISON
	FROM Fournisseurs
	JOIN Product USING(id_fournisseur)
	JOIN Ville USING(id_ville)
	JOIN Annee USING(id_annee)
	GROUP BY GROUPING SETS((FOURNISSEURS,VILLE,ANNEE), ()) ORDER BY VILLE;



SELECT
	Fournisseurs.designation AS FOURNISSEURS,
	Ville.designation AS VILLE,
	Annee.designation AS ANNEE,
	COUNT(Product.id_product) AS NUB_PRODUCT,
	SUM(Product.quantity) AS NUB_QUANTITY,
	CAST(SUM(Product.soustotal) AS DECIMAL) AS SOMME
	FROM Fournisseurs
	JOIN Product USING(id_fournisseur)
	JOIN Ville USING(id_ville)
	JOIN Annee USING(id_annee)
	GROUP BY FOURNISSEURS,VILLE,ANNEE ORDER BY VILLE;




SELECT 
	product.designation AS PRODUIT,
	Annee.designation AS ANNEE,
	EXTRACT (WEEK FROM product.date_created) AS SEMAINE,
	EXTRACT (QUARTER FROM product.date_created) TRIMESTRE,
	EXTRACT (ISOYEAR FROM product.date_created) ANNEE_ISO
	FROM Product
	JOIN Annee USING(id_annee) GROUP BY PRODUIT,ANNEE,product.date_created;


INSERT INTO Product(id_category, id_annee,id_fournisseur,designation, quantity, price_unit,date_created)
VALUES (8, 4, 14, 'DICLO ENFANT 03', 15,3500, '2024-07-31') RETURNING *;


CREATE OR REPLACE PROCEDURE Insert_product (_id_category INT, _id_annee INT,_id_fournisseur INT,_designation VARCHAR, _quantity INT, _price_unit DECIMAL)
LANGUAGE SQL AS $$
	INSERT INTO Product(id_category, id_annee,id_fournisseur,designation, quantity, price_unit) VALUES
	(_id_category, _id_annee,_id_fournisseur,_designation, _quantity, _price_unit)
$$;

SELECT * FROM Product;

CALL Insert_product(2,4,5,'BLOUSE',45,450);




CREATE TABLE COPY_PRODUCT2 AS SELECT * FROM Product WITH NO DATA;

SELECT * FROM Product
INTERSECT
SELECT * FROM COPY_PRODUCT2;

DROP TABLE COPY_PRODUCT1;

/*LES SOUS REQUETES */
SELECT * FROM Product;

SELECT * FROM Product 
	WHERE quantity > (SELECT quantity FROM Product WHERE designation='CHEMISE')
	AND id_annee=2 AND id_category=1;


SELECT * FROM Product 
	WHERE price_unit > (SELECT price_unit FROM Product WHERE designation='BLOUSE');


SELECT * FROM Product 
	WHERE EXISTS (SELECT price_unit FROM Product WHERE designation='BLOUSE');



SELECT * FROM Category WHERE id_category = ANY(SELECT id_category FROM Product);


SELECT 
	category.id_category AS ID_CAT,
	category.designation AS CATEGORY,
	SUM(product.soustotal) AS SOMME
	FROM Product
	JOIN Category USING(id_category)
	GROUP BY CATEGORY,ID_CAT;
	

SELECT * FROM Product;


SELECT ID_PRODUCT, PRODUCT,CATEGORY,PRIX_UNITAIRE, PARTITIONNEMENT FROM(
	SELECT
		product.id_product AS ID_PRODUCT,
		product.designation AS PRODUCT,
		category.designation AS CATEGORY,
		product.price_unit AS PRIX_UNITAIRE,
		SUM(soustotal) OVER(PARTITION BY product.id_category) AS PARTITIONNEMENT
		FROM Product
		JOIN Category USING(id_category)
		GROUP BY CATEGORY, product.id_product) AS TABLE_TEMPO
		GROUP BY ID_PRODUCT, PRODUCT,CATEGORY,PRIX_UNITAIRE,PARTITIONNEMENT 
		HAVING(SUM(TABLE_TEMPO.partitionnement)) > (SELECT soustotal FROM Product WHERE id_product=2);


SELECT * FROM Product;

--Afficher tous les produits dont leurs prix unitaire est égal au prix unitaire du produit donné
SELECT * FROM Product 
	WHERE price_unit = (SELECT price_unit FROM Product WHERE id_product=15);

-- Afficher les produits ayant les prix unitaires les plus bas sur l'ensemble des produits

SELECT * FROM Product WHERE price_unit = (SELECT MIN(price_unit) FROM Product);

-- Afficher les produits ayant les prix unitaires les plus élévé sur l'ensemble des produits

SELECT * FROM Product WHERE price_unit = (SELECT MAX(price_unit) FROM Product);


SELECT * FROM Product WHERE price_unit IN(SELECT price_unit FROM Product WHERE price_unit <= 500);



SELECT 

SELECT t.CATEGORY,T3.designation AS PRODUITS,t.TOTAL FROM(
	SELECT T1.id_category AS CATEGORY,
		SUM(T2.soustotal) AS TOTAL
	FROM Category T1,Product T2
	WHERE T1.id_category=T2.id_category 
	GROUP BY CATEGORY	
) AS T,Product T3 WHERE t.CATEGORY=t3.id_category GROUP BY t.category,T3.designation,t.TOTAL HAVING(t.TOTAL) > (SELECT soustotal FROM Product WHERE id_product=2);


SELECT * FROM Product;


SELECT * FROM Product 
	WHERE id_category != 8 AND quantity > ANY(SELECT quantity FROM Product WHERE quantity=15);




