START TRANSACTION;

CREATE TABLE MyUser(
	id_user SERIAL NOT NULL PRIMARY KEY,
	nom VARCHAR(254) NOT NULL,
	postnom VARCHAR(254) NOT NULL,
	prenom VARCHAR(254) NOT NULL,
	sexe VARCHAR(1) NOT NULL,
	email VARCHAR(254) NOT NULL UNIQUE,
	date_created DATE NULL DEFAULT NOW(),
	CHECK (sexe='M' OR 'F')
);

CREATE TABLE LevelQuiz(
	id_level SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	date_created DATE NULL DEFAULT NOW()
);

CREATE TABLE Langage(
	id_langage SERIAL NOT NULL PRIMARY KEY,
	designation VARCHAR(254) NOT NULL,
	id_level INT NOT NULL,
	date_created DATE NULL DEFAULT NOW()
);

ALTER TABLE Langage ADD CONSTRAINT fk_level FOREIGN KEY(id_level) REFERENCES LevelQuiz(id_level);

CREATE TABLE Quiz(
	id_quiz SERIAL NOT NULL PRIMARY KEY,
	id_langage INT NOT NULL,
	quiz TEXT,
	note INT NULL DEFAULT 10,
	date_created DATE NULL DEFAULT NOW(),
	CHECK (note =10)
);

ALTER TABLE Quiz ADD CONSTRAINT fk_langage FOREIGN KEY(id_langage) REFERENCES Langage(id_langage);

COMMIT;



SELECT * FROM Quiz;

START TRANSACTION;

INSERT INTO  levelquiz(designation) VALUES('INTERMEDIAIRE'), ('DEBUTANT', '45')

COMMIT;










