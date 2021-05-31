
-- requetes Cours 

SELECT * FROM employes WHERE service != 'informatique';

SELECT nom, prenom, salaire FROM employes WHERE salaire > 3000;

SELECT nom,prenom, salaire FROM employes ORDER BY nom ASC;

SELECT service,nom,prenom, salaire FROM employes ORDER BY service ASC, salaire ASC;

SELECT * FROM employes ORDER BY salaire DESC LIMIT 0,3;

SELECT, nom,prenom, service, salaire FROM employes ORDER BY salaire DESC LIMIT 6,3;

SELECT nom, prenom, salaire,salaire*12 as salaire_annuel FROM employes ORDER BY salaire DESC;

SELECT SUM(salaire*12) FROM employes;

SELECT AVG(salaire*12) FROM employes;

SELECT ROUND( AVG(salaire*12))FROM employes;

SELECT COUNT(*) FROM employes WHERE sexe='m';

SELECT MAX(salaire) FROM employes;

 SELECT prenom, nom,  MIN(salaire)AS salaire_minimum FROM employes GROUP BY salaire ASC;
 

 SELECT prenom, salaire FROM employes WHERE salaire = (SELECT MIN(salaire) FROM employes);




-- SELECT LES SALAIRE HORAIRE
SELECT nom, prenom, salaire, salaire/150 AS salaire_heure FROM employes ORDER BY salaire_heure ASC;

-- SELECT EMPLOYES NOT IN SERVICE INFO and compta
SELECT nom, prenom, service FROM employes WHERE service NOT IN ('comptabilite', 'informatique');

--
SELECT nom, prenom, service, salaire FROM employes WHERE service = 'production' AND salaire = 1900 OR salaire = 2300;

SELECT nom, prenom, salaire FROM employes WHERE salaire IN (1900, 2300) AND service='production';


SELECT prenom, nom,service, salaire FROM employes WHERE  salaire = 2300 AND service = 'commercial' ORDER BY  salaire DESC;

--
SELECT service, COUNT(*) AS nombre_employe FROM employes GROUP BY service HAVING COUNT(*);

INSERT INTO employes (prenom,nom, sexe, service, date_embauche, salaire) VALUES('alexis', 'richy', 'm','informatique', '2011-12-28', 1800);

-- 
 SELECT id_employes FROM employes ORDER BY id_employes DESC LIMIT 1;
 

INSERT INTO employes (prenom,nom, sexe, service, date_embauche, salaire) VALUES ('becky', 'flegel', 'm','commercial', '2020-06-28', 1800);
INSERT INTO employes VALUES (NULL , 'Jean', 'Richy','m','informatique','2012-01-28', 1800);



-- UPDATE information into our table
UPDATE employes SET salaire = 1871 WHERE id_employes = 990;


--EXERCICE

SELECT service, salaire, AVG (salaire) FROM employes GROUP BY service;
SELECT service, salaire, round (AVG (salaire)) FROM employes GROUP BY service;


--CREATION DE BASES DE DONNEES

CREATE DATABASE IF NOT EXISTS bibliotheque CHARACTER SET 'utf8';

CREATE TABLE  IF NOT EXISTS abonne (
	id_abonne INT(3) NOT NULL AUTO_INCREMENT,
	prenom VARCHAR(20) NOT NULL,
	PRIMARY KEY (id_abonne)) ENGINE=innoDB;
	
	
CREATE TABLE IF NOT EXISTS livre (
	id_livre INT(3) NOT NULL AUTO_INCREMENT, 
	auteur VARCHAR(30) NOT NULL, 
	titre VARCHAR(30) NOT NULL,
	PRIMARY KEY (id_livre))ENGINE=innoDB;
	
CREATE TABLE IF NOT EXISTS emprunt (
	id_emprunt INT(3) NOT NULL AUTO_INCREMENT,
	id_livre INT(3) DEFAULT NULL,
	id_abonne INT(3) DEFAULT NULL,
	auteur VARCHAR(30) NOT NULL, 
	date_sortie DATE NOT NULL,
	date_rendu DATE DEFAULT NULL,
	PRIMARY KEY (id_emprunt))ENGINE=innoDB;

	
ALTER TABLE livre ADD FOREIGN KEY (id_livre) REFERENCES bibliotheque.livre (id_livre);
ALTER TABLE emprunt ADD FOREIGN KEY (id_abonne) REFERENCES bibliotheque.abonne (id_abonne);

--INSERT
INSERT INTO abonne (prenom) VALUES('Guillaume');
INSERT INTO abonne (prenom) VALUES('Benoit');
INSERT INTO abonne (prenom) VALUES('Chloe');
INSERT INTO abonne (prenom) VALUES('Laura');
INSERT INTO abonne (prenom) VALUES('baroude'),('grace');



INSERT INTO livre (id_livre, auteur, titre) VALUES
(100, 'GUY DE MAUPASSANT', 'Une vie'),
(101, 'GUY DE MAUPASSANT', 'Bel-Ami '),
(102, 'HONORE DE BALZAC', 'Le père Goriot'),
(103, 'ALPHONSE DAUDET', 'Le Petit chose'),
(104, 'ALEXANDRE DUMAS', 'La Reine Margot'),
(105, 'ALEXANDRE DUMAS', 'Les Trois Mousquetaires');

INSERT INTO emprunt (id_emprunt, id_livre, id_abonne, date_sortie, date_rendu) VALUES
(1, 100, 1, '2014-12-17', '2014-12-18'),
(2, 101, 2, '2014-12-18', '2014-12-20'),
(3, 100, 3, '2014-12-19', '2014-12-22'),
(4, 103, 4, '2014-12-19', '2014-12-22'),
(5, 104, 1, '2014-12-19', '2014-12-28'),
(6, 105, 2, '2015-03-20', '2015-03-26'),
(7, 105, 3, '2015-06-13', NULL),
(8, 100, 2, '2015-06-15', NULL);







SELECT titre FROM livre WHERE auteur = 'ALPHONSE DAUDET';


SELECT titre, auteur, id_emprunt FROM livre WHERE livre.id_livre = emprunt.id_emprunt;


SELECT COUNT(*) FROM emprunt WHERE id_abonne = (SELECT id_abonne FROM abonne WHERE prenom = 'guillaume');


--Tables de jointure

SELECT abonne.prenom, emprunt.date_sortie, emprunt.date_rendu FROM abonne, emprunt WHERE abonne.id_abonne = emprunt.id_abonne AND abonne.prenom = 'GUILLAUME';


SELECT prenom, date_sortie, date_rendu FROM abonne, emprunt WHERE abonne.id_abonne = emprunt.id_abonne AND abonne.prenom = 'Guillaume';


SELECT a.prenom, e.date_sortie, e.date_rendu FROM abonne a, emprunt e WHERE a.id_abonne=e.id_abonne AND a.prenom = 'guillaume';
--


-- Qui emprunter "une vie" en 2014

--without prefix

SELECT abonne.prenom 
FROM abonne, emprunt, livre 
WHERE livre.id_livre = emprunt.id_livre AND emprunt.id_abonne = abonne.id_abonne AND livre.titre = 'une vie' AND emprunt.date_sortie LIKE '2014%';

-- with prefix

SELECT a.prenom FROM abonne a, emprunt e, livre l 

WHERE l.id_livre = e.id_livre AND e.id_abonne = a.id_abonne AND l.titre = 'Une vie' AND e.date_sortie LIKE '2014%';

-- jointure


SELECT a.prenom, COUNT(e.id_livre) AS 'nombre de livres empruntés' FROM abonne a, emprunt e WHERE a.id_abonne = e.id_abonne GROUP BY e.id_abonne;


SELECT abonne.prenom, COUNT(emprunt.id_livre) AS 'nombre de livres empruntés' FROM abonne, emprunt WHERE abonne.id_abonne = emprunt.id_abonne GROUP BY;

-- Qui a emprunté quoi ? et quand ? : (indice Qui = prénom, quoi = titre du livre, quand date de sortie ; 3 colonnes)
SELECT abonne.prenom, livre.titre, emprunt.date_sortie 
FROM abonne, livre, emprunt
WHERE abonne.id_abonne = emprunt.id_abonne AND emprunt.id_livre = livre.id_livre
ORDER BY abonne.prenom;

-- OR

SELECT a.prenom, l.titre, e.date_sortie FROM abonne a, livre l, emprunt e WHERE a.id_abonne = e.id_abonne AND e.id_livre = l.id_livre ORDER BY prenom

SELECT abonne.prenom, livre.titre, emprunt.date_sortie 
FROM abonne, livre, emprunt WHERE abonne.id_abonne = emprunt.id_abonne AND emprunt.id_livre = livre.id_livre 
ORDER BY abonne.prenom
------------------------------------------------------------------------------------------------------------------------------------------------------------



INSERT INTO abonne (prenom) VALUES('Alex');
INSERT INTO abonne VALUES (NULL, 'Alex');

--Affiche le prénom des abonnés avec l'id ou le numéro des livres qu'ils ont emprunt

SELECT abonne.prenom, emprunt.id_livre
FROM abonne, emprunt
WHERE abonne.id_abonne=emprunt.id_abonne
GROUP BY abonne.prenom;

---USING PREFIX
SELECT a.prenom, e.id_livre FROM abonne a, emprunt e 
WHERE a.id_abonne = e.id_abonne 
ORDER BY prenom;


SELECT abonne.prenom, emprunt.id_livre FROM abonne LEFT JOIN emprunt ON abonne.id_abonne = emprunt.id_abonne;

SELECT a.prenom, e.id_livre FROM emprunt e right JOIN abonne a  ON a.id_abonne = e.id_abonne;

/* CREATE A DABASE


 */
CREATE DATABASE immobilier CHARACTER SET 'utf8';



CREATE TABLE IF NOT EXISTS agence (
    idAgence INT(6) NOT NULL AUTO_INCREMENT?
    nom VARCHAR(100) NOT NULL, 
    adresse VARCHAR(100) NOT NULL,
    PRIMARY KEY (idAgence))ENGINE=innoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS person (
    idPerson INT(3) NOT NULL AUTO_INCREMENT,
    prenom VARCHAR(100) NOT NULL
    PRIMARY KEY (idPerson))ENGINE=innoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS logement (
    idLogement INT(4) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    Ville VARCHAR(100) NOT NULL,
    prix INT(7) NOT NULL,
    superficie INT(5) NOT NULL,
    categorie VARCHAR(100) NOT NULL,
    PRIMARY KEY (idLogement))ENGINE=innoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS logement_agence (
    idLogementAgence INT(5) NOT NULL AUTO_INCREMENT,
    idAgence INT(6) NOT NULL,
    idLogement INT(4) NOT NULL,
    frais INT(7) NOT NULL,
    PRIMARY KEY (idLogementAgence))ENGINE=innoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS demande (
    idDemande INT(5) NOT NULL AUTO_INCREMENT, 
    genre VARCHAR(100) NOT NULL,
    ville VARCHAR(100) NOT NULL,
    budget INT(7) NOT NULL, 
    superficie INT(5) NOT NULL, 
    categorie VARCHAR(100)NOT NULL,
    PRIMARY KEY (idLogementAgence))ENGINE=innoDB DEFAULT CHARSET=latin1;
);



INSERT INTO personne (idPersonne, prenom) VALUES
(1, 'william'),
(2, 'gaetan'),
(3, 'mehdi'),
(4, 'charles'),
(5, 'brigitte'),
(6, 'sarah'),
(7, 'lucas'),
(8, 'quentin'),
(9, 'patrick'),
(10, 'emmanuel'),
(11, 'elodie'),
(12, 'agathe'),
(13, 'valentine'),
(14, 'charlotte'),
(15, 'alice'),
(16, 'samuel'),
(17, 'mathieu'),
(18, 'noemie'),
(19, 'simon'),
(20, 'florian'),
(21, 'clement'),
(22, 'yvon'),
(23, 'lea'),
(24, 'chloe'),
(25, 'camille'),
(26, 'alexandre'),
(27, 'julie'),
(28, 'leo'),
(29, 'antoine'),
(30, 'lola'),
(31, 'celia'),
(32, 'anna'),
(33, 'caroline'),
(34, 'adele'),
(35, 'sabrina'),
(36, 'nathalie'),
(37, 'franck'),
(38, 'tom'),
(39, 'johan'),
(40, 'priscillia'),
(41, 'assia'),
(42, 'nathan'),
(43, 'aurore'),
(44, 'marie'),
(45, 'oceane'),
(46, 'enzo'),
(47, 'ines'),
(48, 'hugo'),
(49, 'jonathan'),
(50, 'axelle'),
(51, 'morgane'),
(52, 'melissa'),
(53, 'kevin'),
(54, 'ophelie'),
(55, 'victoria'),
(56, 'alexis'),
(57, 'robin');

/* use immobilier database */

USE immobilier;

SELECT * FROM logement 
WHERE prix < 150000 AND categorie = 'vente' ORDER BY prix ASC;


--AFFICHER LES VILLE # rechercher par des personnes demandeuse de logement

SELECT DISTINCT (demande.ville) FROM demande;

--afficher le nombre de bien a vendre par ville

SELECT COUNT(idLogement) AS 'nombre_de_bien_en-vente', ville FROM logement 
WHERE categorie = 'vente' GROUP BY ville;

SELECT ville, COUNT(ville) AS 'nombre_de_bien_en-vente', ville FROM logement 
WHERE categorie = 'vente' GROUP BY ville;
----------------------------------------------------------------------------

-- Quels sont les id des logements entre 20 et 30m²

SELECT idLogement, superficie
FROM logement
WHERE superficie BETWEEN 20 AND 30;

SELECT MIN(prix) AS 'prix minimum'
FROM logement 
WHERE categorie = 'vente';

SELECT * FROM logement_agence
WHERE idAgence IN (608870);



---solution 
UPDATE logement_agence
SET frais = 730
WHERE idLogement = 5246 AND idAgence = (
    SELECT idAgence
FROM agence WHERE nom = 'orpi'
);

-- Affichez le nombre de propriétaires dans la ville de Paris (Alias : Nombre propriétaire parisien)

SELECT COUNT(idLogementPersonne) AS 'nombre_de_logement_louer' FROM logement_personne
WHERE logement_personne.idLogement IN (
    
    SELECT idLogement
    FROM logement
    WHERE ville = 'paris'
    );


-- Dans quelle ville se trouve les maisons à vendre ?

SELECT DISTINCT ville 
FROM logement 
WHERE categorie = 'vente'AND genre = 'maison';


-- <li>Quels sont les logements gérés par l'agence « laforet »<code></code></li>
SELECT idLogement FROM logement_agence
WHERE logement_agence.idAgence = agence.idAgence AND nom = 'laforet';

-- logement a paris
SELECT DISTINCT(COUNT(idLogementPersonne)) AS 'nombre_de_logement_louer' FROM logement_personne
WHERE logement_personne.idLogement iN (
SELECT logement.idLogement
FROM logement
WHERE ville = 'paris');
--AUTRE SOLUTION
SELECT COUNT(DISTINCT(logement_personne.idPerson)) AS 'nombre_de_propriétaire'
FROM logement_personne, logement 
WHERE logement_personne.idLogement = logement.idLogement
AND logement.ville = "Paris"

--Affichez les informations des trois premierès personnes souhaitant acheter un logement
SELECT * 
FROM personne, demande
WHERE personne.idPersonne = demande.idPersonne AND categorie = 'vente' LIMIT 0,3;
-------------------


---Affichez le prénom du vendeur pour le logement ayant la référence « 5770 » 
SELECT personne.prenom, logement_personne.idLogement
FROM personne, logement_personne
WHERE personne.idPersonne = logement_personne.idPersonne
AND logement_personne.idLogement = 5770;


--- Affichez les prénoms des personnes souhaitant accéder à un logement sur la ville de Lyon :
SELECT  personne.prenom
FROM demande, personne
WHERE demande.idPersonne = personne.idPersonne 
AND demande.ville = 'lyon'
ORDER BY prenom;
-- OU 
SELECT prenom FROM personne 
WHERE idPersonne IN (
    SELECT idPersonne
    FROM demande
    WHERE ville='lyon') 

---- Affichez les prénoms des personnes souhaitant accéder à un logement en location sur la ville de Paris

SELECT prenom
FROM demande, personne
WHERE demande.idPersonne = personne.idPersonne
AND demande.ville = 'Paris' 
AND demande.categorie = 'location'
ORDER BY prenom
LIMIT 5;

-- ou 
SELECT prenom 
FROM personne 
idPersonne IN (
    SELECT idPersonne 
    FROM demande 
    WHERE ville = 'paris' 
    AND categorie = 'location');

---- Affichez les prénoms des personnes souhaitant acheter un logement de la plus grande à la plus petite superficie :
SELECT prenom, superficie
FROM demande, personne
WHERE demande.idPersonne = personne.idPersonne
AND demande.categorie = 'vente'
ORDER BY demande.superficie DESC;

--Quel sont les prix finaux proposés par les agences pour la maison à la vente ayant la référence « 5091 » ?

SELECT agence.nom, (logement_agence.frais + logement.prix)
AS 'prix finaux'
FROM agence, logement_agence, logement
WHERE agence.idAgence = logement_agence.idAgence
AND logement.idLogement = logement_agence.idLogement
AND logement_agence.idLogement = 5091;

SELECT agence.nom,(logement.prix + logement_agence.frais) AS 'prix finaux'
FROM agence,logement_agence,logement
WHERE agence.idAgence = logement_agence.idAgence
AND logement.idLogement = logement_agence.idLogement;
AND logement_agence.idLogement = 5091;



SELECT agence.nom, SUM(logement_agence.frais)
AS 'total des frais'
FROM agence, logement_agence
WHERE agence.idAgence = logement_agence.idAgence
GROUP BY agence.nom
ORDER BY 'total des frais';

SELECT a.nom, l.idLogement, l.prix, la.frais 
FROM agence a, logement l, logement_agence la 
WHERE l.idLogement = la.idLogement 
AND a.idAgence = la.idAgence 
AND l.categorie = 'location' 
ORDER BY l.prix ASC;

--Indiquez les frais ajoutés par l’agence immobilière pour le logement ayant la référence « 5873 »
SELECT prix, logement_agence.frais, (logement.prix+logement_agence.frais) AS 'prix total', logement.idLogement
FROM logement_agence, logement
WHERE logement_agence.idLogement = logement.idLogement
AND logement_agence.idLogement= 5873;
-------------------------------------
-- Quel est le prénom du propriétaire proposant le logement le moins cher à louer ? : 

SELECT personne.prenom,MIN(logement.prix) AS 'prix minim'
FROM personne, logement, logement_personne
WHERE personne.idPersonne = logement_personne.idPersonne
AND logement_personne.idLogement = logement.idLogement 
AND logement.categorie = 'location'
GROUP BY personne.prenom 
ORDER BY 'prix minim' DESC 
LIMIT 1;

SELECT logement.prix,MIN(logement.prix) AS 'prix minim', logement.idLogement
FROM logement,logement_personne,personne
WHERE logement.idLogement = logement_personne.idLogement
AND logement_personne.idPersonne = personne.idPersonne WHERE logement.categorie = 'location'
GROUP BY logement.prix;



---Affichez le prénom et la ville où se trouve le logement de chaque propriétaire 
SELECT personne.prenom, logement.ville
FROM  personne,logement, logement_personne
WHERE personne.idPersonne = logement_personne.idPersonne
AND logement_personne.idLogement = logement.idLogement;
