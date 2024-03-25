CREATE USER Henri WITH PASSWORD 'Henri@Henri123456';

SELECT * FROM USER;


















---- User and role management (Gestion des utilisateurs et rôles) - PostgreSQL 

-------------------------------------------------------------------------------------------------------------------------
------------------------------------------- Création d'un groupe d'utilisateur ------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
/*  1- Création d'un groupe d'utilisateur ayant le droit de consulter les données */
CREATE GROUP read;

/*  2- Création d'un groupe d'utilisateur ayant le droit de consulter, d'insérer, de modifier et de supprimer les données */
CREATE GROUP write;


-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------ Création des utilisateurs -----------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
/* 3- Création de trois utilisateurs */
CREATE USER com_read_1 WITH PASSWORD 'com_read_1';
CREATE USER com_read_2 WITH PASSWORD 'com_read_2';
CREATE USER com_write WITH PASSWORD 'com_write';


-------------------------------------------------------------------------------------------------------------------------
---------------------------------------- Affectation des utilisateurs à un groupe ---------------------------------------
-------------------------------------------------------------------------------------------------------------------------
/* 4- Affectation au groupe "read" les utilsateurs "com_read_1", "com_read_2" */
ALTER GROUP read ADD USER com_read_1, com_read_2 ;

/* 5- Affectation au groupe "write" l'utilsateur "com_write" */
ALTER GROUP write ADD USER com_write ;


/* Afficher les groupes avec le nom des utilisateurs respectifs */
select groname as groupname, usename as username 
from pg_user
join pg_auth_members on pg_user.usesysid=pg_auth_members.member
join pg_group on pg_group.grosysid=pg_auth_members.roleid

-------------------------------------------------------------------------------------------------------------------------
----------------------------------------- Attribution des droits aux utilisateurs  ----------------------------------------
-------------------------------------------------------------------------------------------------------------------------
/* 6- Attribution des droits de connexion à la base de données "ICOMMERCE" aux différents utilisateurs */
GRANT CONNECT ON DATABASE "ICOMMERCE" TO read, write; 

/* 7- Attribution des droits d'utilisation du schéma "I_OPE" aux différents utilisateurs */
GRANT USAGE ON SCHEMA "I_OPE" TO read, write;

/* 8- Attribution des droits de sélection sur la table "TB_CATEGORIE" au groupe "read" */
GRANT SELECT ON "I_OPE"."TB_CATEGORIE" TO read;

/* 9- Attribution des droits de sélection sur toutes les tables du schéma "I_OPE" au groupe "read" */
GRANT SELECT ON ALL TABLES IN SCHEMA "I_OPE" TO read ;

/* 10- Attribution des droits de sélection, d'écriture, de mise à jour et de suppression sur toutes les tables du schéma "I_OPE" aux utilisateurs du groupe "write" */
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA "I_OPE" TO write;

/* 11- Attribution du droit de création d'une base de donnée */
ALTER USER com_write CREATEDB;

/* 12- Attribution des droits de superuser */
ALTER USER com_write WITH SUPERUSER;

-------------------------------------------------------------------------------------------------------------------------
------------------------------------------ Retrait des droits aux utilsateurs  ------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
/* 13- Retrait du droit de création d'une base de donnée */
ALTER USER com_write NOCREATEDB;

/* 14- Retrait des droits de superuser */
ALTER USER com_write WITH NOSUPERUSER;

/* 15- Retrait des droits de sélection, d'écriture, de mise à jour et de suppression sur toutes les tables du schéma "I_OPE" aux utilisateurs du groupe "write" */
REVOKE SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA "I_OPE" FROM write;

/* 16- Retrait des droits de sélection sur toutes les tables du schéma "I_OPE" au groupe "read" */
REVOKE SELECT ON ALL TABLES IN SCHEMA "I_OPE" FROM read ;

/* 17- Retrait des droits d'utilisation du schéma "I_OPE" aux différents utilisateurs */
REVOKE USAGE ON SCHEMA "I_OPE" FROM read, write;

/* 18- Retrait des droits de connexion à la base de donnée "ICOMMERCE" aux différents utilisateurs */
REVOKE CONNECT ON DATABASE "ICOMMERCE" FROM read, write; 


-------------------------------------------------------------------------------------------------------------------------
---------------------------------------- Suppression des groupes et utilsateurs  ----------------------------------------
-------------------------------------------------------------------------------------------------------------------------
/*  19- Suppression des groupes d'utilisateur "read" ET "write"  */
DROP GROUP read, write;

/*  20- Suppression des utilisateurs "com_read_1", "com_read_2" et "com_write" */
DROP USER com_read_1, com_read_2, com_write ;