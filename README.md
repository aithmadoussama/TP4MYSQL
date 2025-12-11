# Lab 4 : Opérations CRUD avancées
## Exercice
### A. Création du schéma
```
CREATE DATABASE bibliotheque
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
USE bibliotheque;

CREATE TABLE AUTEUR (
  id INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE OUVRAGE (
  id INT NOT NULL AUTO_INCREMENT,
  titre VARCHAR(500) NOT NULL,
  disponible BOOLEAN NOT NULL DEFAULT TRUE,
  auteur_id INT NOT NULL,
  slug VARCHAR(255) DEFAULT NULL,         
  PRIMARY KEY (id),
  UNIQUE KEY ux_slug (slug),
  CONSTRAINT fk_ouvrage_auteur
    FOREIGN KEY (auteur_id) REFERENCES AUTEUR(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE ABONNE (
  id INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY ux_email (email)
) ENGINE=InnoDB;

CREATE TABLE EMPRUNT (
  ouvrage_id INT NOT NULL,
  abonne_id INT NOT NULL,
  date_debut DATE NOT NULL,
  date_fin DATE DEFAULT NULL,
  PRIMARY KEY (ouvrage_id, abonne_id, date_debut),
  CONSTRAINT fk_emprunt_ouvrage FOREIGN KEY (ouvrage_id) REFERENCES OUVRAGE(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_emprunt_abonne FOREIGN KEY (abonne_id) REFERENCES ABONNE(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CHECK (date_fin IS NULL OR date_fin >= date_debut)
) ENGINE=InnoDB;
```
### B. Contraintes d’intégrité

#### Effet de ON DELETE CASCADE sur OUVRAGE lorsque l’on supprime un auteur
Si on supprime une ligne dans AUTEUR, toutes les lignes de OUVRAGE qui référencent cet auteur (via auteur_id) seront automatiquement supprimées par MySQL.
#### Comportement si on insère un emprunt où date_fin < date_debut
L’insertion échouera (erreur de contrainte CHECK) : la requête INSERT sera rejetée et aucune donnée ne sera ajoutée.
#### Désactiver temporairement les vérifications de clés étrangères pour chargements massifs
```
SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;
```
### C. Sélection et filtrage
#### Tous les titres d’ouvrages actuellement disponibles
```
SELECT titre FROM OUVRAGE
WHERE disponible = TRUE;
```
#### Abonnés dont l’email se termine par @gmail.com
```
SELECT id, nom, email FROM ABONNE
WHERE email LIKE '%@gmail.com';
```
#### Emprunts en cours
```
SELECT * FROM EMPRUNT
WHERE date_fin IS NULL;
```
#### Affichage pour chaque emprunt du nom de l’abonné et du titre de l’ouvrage
```
SELECT e.date_debut, e.date_fin, a.nom AS abonne, o.titre AS ouvrage
FROM EMPRUNT e
JOIN ABONNE a ON e.abonne_id = a.id
JOIN OUVRAGE o ON e.ouvrage_id = o.id;
```
### D. Agrégation et groupements
#### Compter le nombre total d’emprunts par abonné
```
SELECT a.id, a.nom, COUNT(*) AS nb_emprunts
FROM ABONNE a
JOIN EMPRUNT e ON a.id = e.abonne_id
GROUP BY a.id, a.nom;
```
#### Liste des auteurs avec nombre d’ouvrages, triée décroissant
```
SELECT au.id, au.nom, COUNT(o.id) AS nb_ouvrages
FROM AUTEUR au
LEFT JOIN OUVRAGE o ON o.auteur_id = au.id
GROUP BY au.id, au.nom
ORDER BY nb_ouvrages DESC;
```
#### Filtrer auteurs ayant publié au moins 3 ouvrages
```
SELECT au.id, au.nom, COUNT(o.id) AS nb_ouvrages
FROM AUTEUR au
JOIN OUVRAGE o ON o.auteur_id = au.id
GROUP BY au.id, au.nom
HAVING COUNT(o.id) >= 3
ORDER BY nb_ouvrages DESC;
```
