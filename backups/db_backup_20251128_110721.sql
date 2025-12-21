-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: localhost    Database: courto
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `appy_Category`
--

DROP TABLE IF EXISTS `appy_Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_Category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `couleur` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `positionMenus_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3BD61255ACB895C` (`positionMenus_id`),
  CONSTRAINT `FK_3BD61255ACB895C` FOREIGN KEY (`positionMenus_id`) REFERENCES `appy_PositionMenus` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_Category`
--

LOCK TABLES `appy_Category` WRITE;
/*!40000 ALTER TABLE `appy_Category` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_ChoicesQCM`
--

DROP TABLE IF EXISTS `appy_ChoicesQCM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_ChoicesQCM` (
  `id` int NOT NULL AUTO_INCREMENT,
  `qcm_id` int NOT NULL,
  `question` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isCorrect` tinyint(1) NOT NULL,
  `explication` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_B3840B43FF6241A6` (`qcm_id`),
  CONSTRAINT `FK_B3840B43FF6241A6` FOREIGN KEY (`qcm_id`) REFERENCES `appy_QCM` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_ChoicesQCM`
--

LOCK TABLES `appy_ChoicesQCM` WRITE;
/*!40000 ALTER TABLE `appy_ChoicesQCM` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_ChoicesQCM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_DocDeCode`
--

DROP TABLE IF EXISTS `appy_DocDeCode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_DocDeCode` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_DocDeCode`
--

LOCK TABLES `appy_DocDeCode` WRITE;
/*!40000 ALTER TABLE `appy_DocDeCode` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_DocDeCode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_Exo`
--

DROP TABLE IF EXISTS `appy_Exo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_Exo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exoMenu_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B53FFFF08F27B68` (`exoMenu_id`),
  CONSTRAINT `FK_B53FFFF08F27B68` FOREIGN KEY (`exoMenu_id`) REFERENCES `appy_ExoMenu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_Exo`
--

LOCK TABLES `appy_Exo` WRITE;
/*!40000 ALTER TABLE `appy_Exo` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_Exo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_ExoBlock`
--

DROP TABLE IF EXISTS `appy_ExoBlock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_ExoBlock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `code` longtext COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exoContent_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_626E16DAD5B57270` (`exoContent_id`),
  CONSTRAINT `FK_626E16DAD5B57270` FOREIGN KEY (`exoContent_id`) REFERENCES `appy_ExoContent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_ExoBlock`
--

LOCK TABLES `appy_ExoBlock` WRITE;
/*!40000 ALTER TABLE `appy_ExoBlock` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_ExoBlock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_ExoContent`
--

DROP TABLE IF EXISTS `appy_ExoContent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_ExoContent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exo_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `code` longtext COLLATE utf8mb4_unicode_ci,
  `exoMenu_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B81F09DFDA1C6F33` (`exo_id`),
  KEY `IDX_B81F09DF12469DE2` (`category_id`),
  KEY `IDX_B81F09DF8F27B68` (`exoMenu_id`),
  CONSTRAINT `FK_B81F09DF12469DE2` FOREIGN KEY (`category_id`) REFERENCES `appy_Category` (`id`),
  CONSTRAINT `FK_B81F09DF8F27B68` FOREIGN KEY (`exoMenu_id`) REFERENCES `appy_ExoMenu` (`id`),
  CONSTRAINT `FK_B81F09DFDA1C6F33` FOREIGN KEY (`exo_id`) REFERENCES `appy_Exo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_ExoContent`
--

LOCK TABLES `appy_ExoContent` WRITE;
/*!40000 ALTER TABLE `appy_ExoContent` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_ExoContent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_ExoMenu`
--

DROP TABLE IF EXISTS `appy_ExoMenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_ExoMenu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_61CDAD812469DE2` (`category_id`),
  CONSTRAINT `FK_61CDAD812469DE2` FOREIGN KEY (`category_id`) REFERENCES `appy_Category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_ExoMenu`
--

LOCK TABLES `appy_ExoMenu` WRITE;
/*!40000 ALTER TABLE `appy_ExoMenu` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_ExoMenu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_LanguageQCM`
--

DROP TABLE IF EXISTS `appy_LanguageQCM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_LanguageQCM` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_LanguageQCM`
--

LOCK TABLES `appy_LanguageQCM` WRITE;
/*!40000 ALTER TABLE `appy_LanguageQCM` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_LanguageQCM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_Logo`
--

DROP TABLE IF EXISTS `appy_Logo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_Logo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `docDeCode_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1EBF2ED0C703A8B4` (`docDeCode_id`),
  UNIQUE KEY `UNIQ_1EBF2ED012469DE2` (`category_id`),
  CONSTRAINT `FK_1EBF2ED012469DE2` FOREIGN KEY (`category_id`) REFERENCES `appy_Category` (`id`),
  CONSTRAINT `FK_1EBF2ED0C703A8B4` FOREIGN KEY (`docDeCode_id`) REFERENCES `appy_DocDeCode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_Logo`
--

LOCK TABLES `appy_Logo` WRITE;
/*!40000 ALTER TABLE `appy_Logo` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_Logo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_Menus`
--

DROP TABLE IF EXISTS `appy_Menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_Menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `positionMenus_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_70E2AA7112469DE2` (`category_id`),
  KEY `IDX_70E2AA71ACB895C` (`positionMenus_id`),
  CONSTRAINT `FK_70E2AA7112469DE2` FOREIGN KEY (`category_id`) REFERENCES `appy_Category` (`id`),
  CONSTRAINT `FK_70E2AA71ACB895C` FOREIGN KEY (`positionMenus_id`) REFERENCES `appy_PositionMenus` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_Menus`
--

LOCK TABLES `appy_Menus` WRITE;
/*!40000 ALTER TABLE `appy_Menus` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_Menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_NiveauQCM`
--

DROP TABLE IF EXISTS `appy_NiveauQCM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_NiveauQCM` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_NiveauQCM`
--

LOCK TABLES `appy_NiveauQCM` WRITE;
/*!40000 ALTER TABLE `appy_NiveauQCM` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_NiveauQCM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_Page`
--

DROP TABLE IF EXISTS `appy_Page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_Page` (
  `id` int NOT NULL AUTO_INCREMENT,
  `menus_id` int DEFAULT NULL,
  `seo_id` int DEFAULT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_EE3B02E397E3DD86` (`seo_id`),
  KEY `IDX_EE3B02E314041B84` (`menus_id`),
  CONSTRAINT `FK_EE3B02E314041B84` FOREIGN KEY (`menus_id`) REFERENCES `appy_Menus` (`id`),
  CONSTRAINT `FK_EE3B02E397E3DD86` FOREIGN KEY (`seo_id`) REFERENCES `appy_Seo` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_Page`
--

LOCK TABLES `appy_Page` WRITE;
/*!40000 ALTER TABLE `appy_Page` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_Page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_PageBlock`
--

DROP TABLE IF EXISTS `appy_PageBlock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_PageBlock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `code` longtext COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pageContent_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6F6419B1BD8FBEEF` (`pageContent_id`),
  CONSTRAINT `FK_6F6419B1BD8FBEEF` FOREIGN KEY (`pageContent_id`) REFERENCES `appy_PageContent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_PageBlock`
--

LOCK TABLES `appy_PageBlock` WRITE;
/*!40000 ALTER TABLE `appy_PageBlock` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_PageBlock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_PageContent`
--

DROP TABLE IF EXISTS `appy_PageContent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_PageContent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `page_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `menu_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `code` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_AEA9AB28C4663E4` (`page_id`),
  KEY `IDX_AEA9AB2812469DE2` (`category_id`),
  KEY `IDX_AEA9AB28CCD7E912` (`menu_id`),
  CONSTRAINT `FK_AEA9AB2812469DE2` FOREIGN KEY (`category_id`) REFERENCES `appy_Category` (`id`),
  CONSTRAINT `FK_AEA9AB28C4663E4` FOREIGN KEY (`page_id`) REFERENCES `appy_Page` (`id`),
  CONSTRAINT `FK_AEA9AB28CCD7E912` FOREIGN KEY (`menu_id`) REFERENCES `appy_Menus` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_PageContent`
--

LOCK TABLES `appy_PageContent` WRITE;
/*!40000 ALTER TABLE `appy_PageContent` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_PageContent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_PositionMenus`
--

DROP TABLE IF EXISTS `appy_PositionMenus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_PositionMenus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_PositionMenus`
--

LOCK TABLES `appy_PositionMenus` WRITE;
/*!40000 ALTER TABLE `appy_PositionMenus` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_PositionMenus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_PropositionIA`
--

DROP TABLE IF EXISTS `appy_PropositionIA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_PropositionIA` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `statut` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` json DEFAULT NULL,
  `createdAt` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_PropositionIA`
--

LOCK TABLES `appy_PropositionIA` WRITE;
/*!40000 ALTER TABLE `appy_PropositionIA` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_PropositionIA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_QCM`
--

DROP TABLE IF EXISTS `appy_QCM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_QCM` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `solution` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `languageQCM_id` int DEFAULT NULL,
  `niveauQCM_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_47C25A806C5D2C67` (`languageQCM_id`),
  KEY `IDX_47C25A80F662DA50` (`niveauQCM_id`),
  CONSTRAINT `FK_47C25A806C5D2C67` FOREIGN KEY (`languageQCM_id`) REFERENCES `appy_LanguageQCM` (`id`),
  CONSTRAINT `FK_47C25A80F662DA50` FOREIGN KEY (`niveauQCM_id`) REFERENCES `appy_NiveauQCM` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_QCM`
--

LOCK TABLES `appy_QCM` WRITE;
/*!40000 ALTER TABLE `appy_QCM` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_QCM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_Seo`
--

DROP TABLE IF EXISTS `appy_Seo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_Seo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metaDescription` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `metaKeywords` longtext COLLATE utf8mb4_unicode_ci,
  `ogTitle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ogDescription` longtext COLLATE utf8mb4_unicode_ci,
  `ogImage` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `canonicalUrl` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `noIndex` tinyint(1) NOT NULL DEFAULT '0',
  `noFollow` tinyint(1) NOT NULL DEFAULT '0',
  `page` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `structuredData` longtext COLLATE utf8mb4_unicode_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_52F84C2E140AB620` (`page`),
  UNIQUE KEY `UNIQ_52F84C2E12469DE2` (`category_id`),
  CONSTRAINT `FK_52F84C2E12469DE2` FOREIGN KEY (`category_id`) REFERENCES `appy_Category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_Seo`
--

LOCK TABLES `appy_Seo` WRITE;
/*!40000 ALTER TABLE `appy_Seo` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_Seo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_User`
--

DROP TABLE IF EXISTS `appy_User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_User` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_USERNAME` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_User`
--

LOCK TABLES `appy_User` WRITE;
/*!40000 ALTER TABLE `appy_User` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_UserPageVisit`
--

DROP TABLE IF EXISTS `appy_UserPageVisit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_UserPageVisit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `page_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visited_at` datetime NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_spent` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7D09FA76A76ED395` (`user_id`),
  KEY `IDX_7D09FA76A76ED395EDA764E3` (`user_id`,`visited_at`),
  CONSTRAINT `FK_7D09FA76A76ED395` FOREIGN KEY (`user_id`) REFERENCES `appy_User` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_UserPageVisit`
--

LOCK TABLES `appy_UserPageVisit` WRITE;
/*!40000 ALTER TABLE `appy_UserPageVisit` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_UserPageVisit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appy_favorite`
--

DROP TABLE IF EXISTS `appy_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appy_favorite` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `page_id` int NOT NULL,
  `createdAt` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_page_unique` (`user_id`,`page_id`),
  KEY `IDX_AC29E71BA76ED395` (`user_id`),
  KEY `IDX_AC29E71BC4663E4` (`page_id`),
  CONSTRAINT `FK_AC29E71BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `appy_User` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AC29E71BC4663E4` FOREIGN KEY (`page_id`) REFERENCES `appy_Page` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appy_favorite`
--

LOCK TABLES `appy_favorite` WRITE;
/*!40000 ALTER TABLE `appy_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `appy_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messenger_messages`
--

LOCK TABLES `messenger_messages` WRITE;
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-28 10:07:21
