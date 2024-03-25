START TRANSACTION;

CREATE TABLE Category(
	id_category SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254),
	date_created DATE NULL DEFAULT CURRENT_DATE
);


COMMIT;

SELECT * FROM Category;

INSERT INTO Category(designation) VALUES('ADULTE'), ('ENFANT'),('FEMME'), ('HOMME');



BEGIN;
INSERT INTO Category(designation) VALUES('ENFANT 0-5 ANS');
	
COMMIT;


START TRANSACTION;
	CREATE TABLE Product(
		id_product SERIAL NOT NULL PRIMARY KEY,
		id_category INT NOT NULL,
		designation VARCHAR(254) NOT NULL,
		quantity INT NOT NULL,
		unit_price MONEY NOT NULL,
		date_creaated DATE NULL DEFAULT CURRENT_DATE,
		CHECK(quantity >= 1)
	);
	ALTER TABLE Product ADD CONSTRAINT fk_category FOREIGN KEY(id_category) REFERENCES Category(id_category);
	
	INSERT INTO Product(id_category, designation,quantity, unit_price) VALUES(1, 'PARA',25, 1500),(1, 'DICLO',33, 2500), (2, 'QUININE', 150, 750),
	(3, 'PENI V', 85, 1200), (5, 'PENI PROCAINE', 1420, 450), (1, 'SERING',45, 150), (2, 'DOLAREIN', 125, 1450);
	
COMMIT;

ROLLBACK;


SELECT * FROM Product;




START TRANSACTION;

INSERT INTO Product(id_category, designation,quantity, unit_price) 
VALUES(1, 'DIAZEPAN',14, 1750),(1, 'SERING',74, 650),(1, 'RELIEF',85, 3525),
(4, 'PERFUSION',44, 3500),(2, 'DEXA',140, 650),(5, 'DEXA',45, 750),(3, 'ANAFLAM',35, 850),
(2, 'PERFUSION',78, 4850),(5, 'ACIDE FOLIC',140, 680),(4, 'VITAMINE C',46, 4800);

COMMIT;



SELECT
	Category.id_category AS ID_CAT,
	Category.designation AS CATEGORY,
	DENSE_RANK()
	OVER(ORDER BY SUM(Product.unit_price) DESC ) AS CLASSEMENT,
	COUNT(Product.id_category) AS NUMBER_product,
	SUM(Product.quantity) AS QUANTITY_NUMBER,
	CAST(SUM(Product.unit_price) AS DECIMAL) AS TOTAL_UNIT_PRICE,
	LAG(SUM(CAST(Product.unit_price AS DECIMAL)),1, CAST(0 AS DECIMAL)) OVER(ORDER BY Category.id_category) AS COMPARE,
	CASE 
		WHEN SUM(Product.unit_price) < CAST(5000 AS money) THEN 'MAUVAIS BENEFICE'
		ELSE 'BON BENEFICE'
	END AS DECISION
	FROM Category
	JOIN Product USING(id_category)
	GROUP BY ID_CAT, CATEGORY;

SELECT SUM(Product.unit_price) FROM Product;

SELECT * FROM Category;

SELECT * FROM Category WHERE id_category NOT IN(SELECT id_category FROM Product);


DROP TABLE Customer;
DROP TABLE Orders;
DROP TABLE OrderItem;

START TRANSACTION;
	CREATE TABLE Customer(
		id_customer SERIAL NOT NULL PRIMARY KEY,
		nom VARCHAR(254) NOT NULL,
		prenom VARCHAR(254) NOT NULL,
		sexe VARCHAR(1) NULL,
		date_created DATE NULL DEFAULT CURRENT_DATE,
		CHECK (sexe='M' OR sexe='F')
	);
	
	CREATE TABLE Orders(
		id_order SERIAL NOT NULL PRIMARY KEY,
		id_customer INT NOT NULL,
		date_created DATE NULL DEFAULT CURRENT_DATE
	);
	ALTER TABLE Orders ADD CONSTRAINT fk_customer FOREIGN KEY(id_customer) REFERENCES Customer(id_customer);
	
	CREATE TABLE OrderItem(
		id_order INT NOT NULL,
		id_product INT NOT NULL,
		quantity INT NOT NULL,
		date_created DATE NULL DEFAULT CURRENT_DATE,
		PRIMARY KEY(id_order, id_product),
		CHECK (quantity >= 1)
	);
	
	ALTER TABLE OrderItem ADD CONSTRAINT fk_order FOREIGN KEY(id_order) REFERENCES Orders(id_order);
	ALTER TABLE OrderItem ADD CONSTRAINT fk_product FOREIGN KEY(id_product) REFERENCES Product(id_product);


COMMIT;

ROLLBACK;


ALTER TABLE Customer RENAME COLUMN nom TO first_name;
ALTER TABLE Customer RENAME COLUMN prenom TO last_name;
ALTER TABLE Customer RENAME COLUMN sexe TO genre;


SELECT * FROM Customer;

INSERT INTO Customer(first_name, last_name, genre)VALUES
('KIUKA', 'HENRI','M'),
('CORNEILLE', 'TIM', 'M'), 
('PASCALINE', 'LUAMBA', 'F'),
('ADEL', 'EBONDO', 'F'), 
('DENISE', 'NGOLO', 'F'),
('CHRISTINE', 'KIKUDI', 'F'),
('PRINCE', 'CRIS', 'M'), 
('PATIENT', 'NSOMUE', 'M'), 
('FRAM', 'KIYENGA', 'M'), 
('LUCIANNE', 'KABEDI', 'F'),
('GERMAINE', 'FUMUNI', 'F'), 
('LARRISSA', 'NSOMPO','F'),
('IDRIS', 'MBUYU', 'M'),
('NASSER','KALENGA', 'M'),
('PIERRE', 'EBONDO', 'M'),
('PASCAL', 'TULIA', 'M'), ('FIDEL', 'CASTRO', 'M'), 
('JOLIE', 'MULEKUA', 'F'),
('RAPHAEL', 'KAZADI', 'M'),
('SABIN', 'NKONGE', 'M'), ('KABUYA', 'ARSENE', 'M'),
('CHRISTOPHE', 'NGOYI', 'M'),
('JEAN PIERRE', 'NSENGA', 'M'), 
('JEAN PIERRE','MUTEBA', 'M'),
('JEAN PIERRE', 'MITANTA', 'M'),
('MIREILLE', 'MBUYU', 'F'), 
('BLANDINE', 'MPUNGUE', 'F'),
('KASONGO', 'FERDINAND FK02', 'M'), 
('OMARY', 'GIFT', 'M'), ('NAMIKUKU', 'VERO', 'F'), 
('KAPAFULE', 'TANTINE', 'F'), ('CLOVIS', 'MANASSE', 'M'), 
('DELPHINE', 'CHLOE', 'F'),
('BINGI', 'ALI', 'M'), ('ARLETTE', 'PREMIERE DAME', 'F'),
('MARTIN', 'KITENGIE', 'M'),
('JEAN PIERRE', 'YAKEMBI', 'M'),
('WILLY', 'KIMPANGA', 'M'),('DALLAS', 'MUTABA', 'M');


SELECT * FROM Customer;

SELECT 
	genre, 
	COUNT(genre) AS NUMBER_SEXE 
	FROM Customer
	GROUP BY genre;

SELECT * FROM Orders;

INSERT INTO Orders(id_customer) VALUES(1),(35),(18),(14),(1),(1),(20),(20),(20),(20),(20),
(4),(14),(17),(5),(20),(1),(9),(21);

SELECT * FROM Customer WHERE id_customer IN(SELECT id_customer FROM Orders);


SELECT 
	CONCAT(Customer.first_name, ' ', Customer.last_name) AS CUSTOMER,
	COUNT(Orders.id_customer) AS NUMBER_ORDER
	FROM Customer
	JOIN Orders USING(id_customer) 
	GROUP BY CUSTOMER ORDER BY NUMBER_ORDER DESC;
	

SELECT 
	CONCAT(Customer.first_name, ' ', Customer.last_name) AS CUSTOMER,
	COUNT(Orders.id_customer) AS NUMBER_ORDER,
	DENSE_RANK()
	OVER(ORDER BY COUNT(Orders.id_customer) DESC) AS CLASSEMENT
	FROM Customer
	JOIN Orders USING(id_customer) 
	GROUP BY CUSTOMER ORDER BY NUMBER_ORDER DESC;


SELECT 
	Customer.genre AS GENRE,
	COUNT(id_order) AS NUMBER_ORDER
	FROM Orders
	JOIN Customer USING(id_customer)
	GROUP BY GENRE;
	

SELECT * FROM Orders;
	
SELECT * FROM Product;

SELECT * FROM OrderItem;

INSERT INTO OrderItem(id_order, id_product,quantity) VALUES (1,1,10),(1,2,3),(1,3,15),(1,19,12),(1,25,18);
INSERT INTO OrderItem(id_order, id_product,quantity) VALUES (3,25,30);


SELECT 
	CONCAT(customer.first_name, ' ' , customer.last_name) AS CUSTOMER,
	customer.genre AS Genre,
	product.designation AS PRODUITS,
	category.designation AS CATEGORY,
	product.unit_price AS UNIT_PRICE,
	orderItem.quantity AS QUANTITE_CMD,
	product.unit_price * orderItem.quantity AS SUB_TOTAL
	FROM OrderItem
	JOIN Orders USING(id_order)
	JOIN Customer USING(id_customer)
	JOIN Product USING(id_product)
	JOIN category USING(id_category)
	WHERE id_order=2;
	
	
SELECT 
	product.id_product AS ID_PRODUCT,
	product.designation AS PRODUCT,
	category.designation AS CATEGORY,
	COUNT(OrderItem.id_order) AS NUMBER_ORDER,
	SUM(orderitem.quantity) AS QUANTITY_CMD,
	Product.quantity * SUM(orderitem.quantity) AS TOTAL,
	DENSE_RANK()
	OVER(ORDER BY SUM(orderitem.quantity) DESC) AS CLASSEMENT
	FROM Product
	INNER JOIN Category ON category.id_category=Product.id_category
	JOIN OrderItem USING(id_product)
	GROUP BY ID_PRODUCT,PRODUCT,CATEGORY;
	
	

SELECT 
	product.id_product AS ID_PRODUCT,
	product.designation AS PRODUCT,
	category.designation AS CATEGORY,
	COUNT(OrderItem.id_order) AS NUMBER_ORDER,
	SUM(orderitem.quantity) AS QUANTITY_CMD,
	Product.unit_price * SUM(orderitem.quantity) AS TOTAL,
	LAG(Product.unit_price * SUM(orderitem.quantity),1, CAST(0 AS MONEY))
	OVER(ORDER BY product.id_product) AS COMPARE,
	CASE
		WHEN LAG(Product.unit_price * SUM(orderitem.quantity))
			OVER(ORDER BY product.id_product) > Product.unit_price * SUM(orderitem.quantity) 
				THEN LAG(CAST(Product.unit_price * SUM(orderitem.quantity) AS DECIMAL))
					OVER(ORDER BY product.id_product) - CAST(Product.unit_price AS DECIMAL) * SUM(orderitem.quantity)
		WHEN LAG(Product.unit_price * SUM(orderitem.quantity))
			OVER(ORDER BY product.id_product) < Product.unit_price * SUM(orderitem.quantity) 
				THEN CAST(Product.unit_price AS DECIMAL) * SUM(orderitem.quantity) - LAG(CAST(Product.unit_price * SUM(orderitem.quantity) AS DECIMAL))
					OVER(ORDER BY product.id_product)
		ELSE 0
	END ECART,
	DENSE_RANK()
	OVER(ORDER BY SUM(orderitem.quantity) DESC) AS CLASSEMENT
	FROM Product
	INNER JOIN Category ON category.id_category=Product.id_category
	JOIN OrderItem USING(id_product)
	GROUP BY ID_PRODUCT,PRODUCT,CATEGORY;
	
	
	
	
	
	
	
	
	
	
SELECT * FROM OrderItem WHERE id_product=3;
	

/* A REVENIR */
SELECT 
	Category.designation AS NAME_, 
	COUNT(*) AS NUB
	from Product
	JOIN category USING(id_category)
	GROUP BY NAME_ WITH ROLLUP;
	
SELECT nom_courant, COUNT(*) as nb_animaux
FROM Animal
INNER JOIN Espece ON Espece.id = Animal.espece_id
GROUP BY nom_courant WITH ROLLUP;


SELECT COALESCE(genre, 'vide') FROM customer;

SELECT NULLIF(genre, genre) FROM customer;

SELECT * FROM customer;

INSERT INTO customer(first_name, last_name)VALUES('YAMPUA', 'DJOMALI');





SELECT EXTRACT(DOW FROM CAST('2024-01-6' AS DATE));

SELECT EXTRACT(ISODOW FROM CAST('2024-01-6' AS DATE));

SELECT EXTRACT(DOY FROM CAST('2024-01-25' AS DATE));


SELECT * FROM Customer;

--SELECT FIELDS('HENRI', 'OK') AS RESULTATAS;


SELECT CURRENT_DATE;
SELECT CURRENT_TIMESTAMP;



SELECT * FROM Category;

/*  IMPLEMENTATION DE TRIGGERS */


ALTER TABLE Category ADD COLUMN In_Product BOOLEAN DEFAULT FALSE;

UPDATE Category SET in_product=True WHERE id_category IN(SELECT id_category FROM Product);


CREATE TRIGGER test AFTER INSERT ON product FOR EACH ROW
	IF NEW.id_category NOT IN(SELECT id_category FROM product) THEN
	UPDATE Category  SET in_product=True WHERE id_category=NEW.id_category;

	
CREATE TRIGGER after_insert_adoption AFTER INSERT
ON Adoption FOR EACH ROW
BEGIN
UPDATE Animal
SET disponible = FALSE
WHERE id = NEW.animal_id;
END
	
	
	
	

CREATE TRIGGER check_update
 BEFORE UPDATE ON accounts
 FOR EACH ROW
 WHEN (OLD.balance IS DISTINCT FROM NEW.balance)
 EXECUTE FUNCTION check_account_update();




CREATE TRIGGER log_update
 AFTER UPDATE ON accounts
 FOR EACH ROW
 WHEN (OLD.* IS DISTINCT FROM NEW.*)
 EXECUTE FUNCTION log_account_update();
 


/* FONCTION DE GROUP BY ROLLUP*/

SELECT * FROM OrderItem GROUP BY id_order,  orderitem.id_product;

SELECT * FROM Product;


SELECT 
	COALESCE(category.designation, 'TOTAL GENERAL') AS CATEGORY,
	COUNT(product.id_category) AS NUMBER_PRODUCT ,
	SUM(Product.quantity) AS QUANTITY,
	CAST(SUM(product.unit_price) AS DECIMAL) AS NUMBER_PRICE
	FROM Category 
	JOIN Product USING(id_category)
	GROUP BY ROLLUP(category.designation) 
	ORDER BY (CASE WHEN category.designation IS NULL THEN 0 END) DESC, CATEGORY;
	
	
	
SELECT 
	category.designation AS CATEGORY,
	COUNT(product.id_category) AS NUMBER_PRODUCT ,
	SUM(Product.quantity) AS QUANTITY,
	CAST(SUM(product.unit_price) AS DECIMAL) AS NUMBER_PRICE
	FROM Category 
	JOIN Product USING(id_category)
	GROUP BY ROLLUP(CATEGORY) 
	ORDER BY CATEGORY;
	

SELECT DISTINCT(CATEGORY),CATEGORYS, NUMBER_PRODUCT,QUANTITY,NUMBER_PRICE FROM(
	SELECT
	CASE
	WHEN category.id_category IS NULL THEN
	 0
	ELSE category.id_category END AS CATEGORYS,
	CASE
	WHEN category.designation IS NULL THEN
	 'TOTAL GENERAL'
	ELSE category.designation
	END AS CATEGORY,
	COUNT(product.id_category) AS NUMBER_PRODUCT ,
	SUM(Product.quantity) AS QUANTITY,
	CAST(SUM(product.unit_price) AS DECIMAL) AS NUMBER_PRICE
	FROM Category 
	JOIN Product USING(id_category)
	GROUP BY ROLLUP(category.designation, category.id_category)
	ORDER BY category.designation
) AS TEMPO WHERE CATEGORYS > 0 ORDER BY TEMPO.NUMBER_PRICE, TEMPO.NUMBER_PRODUCT, TEMPO.QUANTITY ASC;


SELECT SUM(unit_price) FROM Product;
	
	
SELECT * FROM Product;

SELECT * FROM Category;

BEGIN;

INSERT INTO Product(id_category, designation, quantity, unit_price)
VALUES(3,'SERING 5ML', 45, 450);

SAVEPOINT Add_product01;

INSERT INTO Product(id_category, designation, quantity, unit_price)
VALUES(3,'SERING 5ML', 45, 450);
INSERT INTO Product(id_category, designation, quantity, unit_price)
VALUES(3,'SERING 5ML', 45, 450);

ROLLBACK TO Add_product01;

INSERT INTO Product(id_category, designation, quantity, unit_price)
VALUES(2,'SERING 5ML', 45, 250);

COMMIT;





SELECT * FROM Category;

SELECT * FROM Product;

ALTER TABLE Category DROP COLUMN in_product;

BEGIN;

INSERT INTO Category(designation)VALUES('ENFANT 5-10');
SAVEPOINT savepoint_1;
INSERT INTO Category(designation)VALUES('ENFANT 10-15');
INSERT INTO Category(designation)VALUES('ENFANT 12-15');
INSERT INTO Category(designation)VALUES('ENFANT 10-15');
INSERT INTO Category(designation)VALUES('ENFANT 10-15');

ROLLBACK TO  savepoint_1;
COMMIT;
	

SELECT 
	CASE 
	WHEN product.designation IS NOT NULL THEN product.designation 
	ELSE 'TOTAL' END AS PRODUCT,
	SUM(product.quantity) AS QUANITIE,
	CAST(SUM(product.unit_price) AS DECIMAL) AS PRICE,
	SUM(product.unit_price * product.quantity) AS CA
	FROM Product GROUP BY GROUPING SETS ((product.designation ), ()) ORDER BY PRICE,CA;



SELECT 
	CASE 
	WHEN product.designation IS NOT NULL THEN product.designation 
	ELSE 'TOTAL' END AS PRODUCT,
	SUM(product.quantity) AS QUANITIE,
	CAST(SUM(product.unit_price) AS DECIMAL) AS PRICE,
	SUM(product.unit_price * product.quantity) AS CA
	FROM Product GROUP BY  CUBE(product.designation) ORDER BY PRICE,CA;



SELECT * FROM Product;

/*Créer les colonnes générées*/

CREATE TABLE TestGenre(
	quantity INT NULL,
	unit_price MONEY,
	total MONEY GENERATED ALWAYS AS (unit_price * quantity) STORED

);

SELECT * FROM TestGenre;

INSERT INTO TestGenre(quantity, unit_price)VALUES(10,350),(5,550),(4, 8500);

DROP TABLE TestGenre;

SELECT 
	product.designation AS PRODUITS,
	category.designation AS CATEGORIES,
	product.quantity AS QUANTITES,
	CAST(product.unit_price AS DECIMAL) AS UNIT_PRICE,
	CAST(product.subtotal AS DECIMAL) AS SOUS_TOTAL
	FROM Product
	JOIN Category USING(id_category);



ALTER TABLE Product ADD COLUMN subTotal MONEY GENERATED ALWAYS AS (unit_price*quantity) STORED;

SELECT * FROM Product;

INSERT INTO Product(id_category, designation, quantity, unit_price)VALUES(2, 'CHLORA', 21,250) RETURNING id_product;


INSERT INTO Product(id_category, designation, quantity, unit_price)
VALUES(3, 'PAPAVERINE', 250,650) 
RETURNING id_product, designation, quantity, unit_price, subtotal;

UPDATE Product SET quantity=650, unit_price=350 WHERE id_product=33 RETURNING 
id_product, designation, quantity, unit_price, subtotal;


DELETE FROM Product WHERE id_product=33 RETURNING *;

