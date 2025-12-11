-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: localhost    Database: bibliotheque
-- ------------------------------------------------------
-- Server version	8.0.44-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Abonne`
--

DROP TABLE IF EXISTS `Abonne`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Abonne` (
  `id_Abonne` int NOT NULL AUTO_INCREMENT,
  `nom_Abonne` varchar(70) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_Abonne` varchar(70) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_Abonne`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Abonne`
--

LOCK TABLES `Abonne` WRITE;
/*!40000 ALTER TABLE `Abonne` DISABLE KEYS */;
INSERT INTO `Abonne` VALUES (1,'Oussama','oussama@example.com'),(2,'Sara','sara.new@mail.com'),(3,'Amine','amine@example.com'),(4,'Fatima','fatima@example.com'),(5,'Youssef','youssef@example.com'),(6,'Aya','aya@example.com'),(7,'Ali','Ali@mail.com');
/*!40000 ALTER TABLE `Abonne` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Auteur`
--

DROP TABLE IF EXISTS `Auteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Auteur` (
  `id_Auteur` int NOT NULL AUTO_INCREMENT,
  `nom_Auteur` varchar(70) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_Auteur`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Auteur`
--

LOCK TABLES `Auteur` WRITE;
/*!40000 ALTER TABLE `Auteur` DISABLE KEYS */;
INSERT INTO `Auteur` VALUES (1,'Victor Hugo'),(2,'Jules Verne'),(3,'Albert Camus'),(4,'George Orwell'),(5,'Jane Austen'),(6,'Ahmed Sefrioui');
/*!40000 ALTER TABLE `Auteur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Emprunt`
--

DROP TABLE IF EXISTS `Emprunt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Emprunt` (
  `id_Ouvrage` int NOT NULL,
  `id_Abonne` int NOT NULL,
  `date_debut_Emprunt` date DEFAULT NULL,
  `date_fin_Emprunt` date DEFAULT NULL,
  PRIMARY KEY (`id_Ouvrage`,`id_Abonne`),
  KEY `FK_Emprunt_id_Abonne` (`id_Abonne`),
  KEY `date_fin_Emprunt` (`date_fin_Emprunt`),
  CONSTRAINT `FK_Emprunt_id_Abonne` FOREIGN KEY (`id_Abonne`) REFERENCES `Abonne` (`id_Abonne`),
  CONSTRAINT `FK_Emprunt_id_Ouvrage` FOREIGN KEY (`id_Ouvrage`) REFERENCES `Ouvrage` (`id_Ouvrage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Emprunt`
--

LOCK TABLES `Emprunt` WRITE;
/*!40000 ALTER TABLE `Emprunt` DISABLE KEYS */;
INSERT INTO `Emprunt` VALUES (1,1,'2025-01-02','2025-12-11'),(2,2,'2025-02-01','2025-02-10'),(3,3,'2025-02-05','2025-02-20'),(4,4,'2025-03-01','2025-03-15'),(5,5,'2025-03-10','2025-03-22'),(6,6,'2025-04-01','2025-04-15');
/*!40000 ALTER TABLE `Emprunt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ouvrage`
--

DROP TABLE IF EXISTS `Ouvrage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ouvrage` (
  `id_Ouvrage` int NOT NULL AUTO_INCREMENT,
  `titre_Ouvrage` varchar(70) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disponibilite_Ouvrage` tinyint(1) DEFAULT NULL,
  `id_Auteur` int NOT NULL,
  PRIMARY KEY (`id_Ouvrage`),
  KEY `FK_Ouvrage_id_Auteur` (`id_Auteur`),
  KEY `disponibilite_Ouvrage` (`disponibilite_Ouvrage`),
  CONSTRAINT `FK_Ouvrage_id_Auteur` FOREIGN KEY (`id_Auteur`) REFERENCES `Auteur` (`id_Auteur`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ouvrage`
--

LOCK TABLES `Ouvrage` WRITE;
/*!40000 ALTER TABLE `Ouvrage` DISABLE KEYS */;
INSERT INTO `Ouvrage` VALUES (1,'Les Misérables',0,1),(2,'Le Tour du monde en 80 jours',0,2),(3,'L’Étranger',0,3),(4,'1984',1,4),(5,'Orgueil et Préjugés',0,5),(6,'La Boîte à Merveilles',1,6);
/*!40000 ALTER TABLE `Ouvrage` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-11 19:11:48
