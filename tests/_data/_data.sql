-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: question_sys
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.18.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `migrations`
--

use question_sys;

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (11,'2014_10_12_000000_create_users_table',1),(12,'2014_10_12_100000_create_password_resets_table',1),(13,'2019_03_19_055908_create_questionnaires_table',1),(14,'2019_03_19_055917_create_questions_table',1),(15,'2019_03_19_055932_create_responses_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaires`
--

DROP TABLE IF EXISTS `questionnaires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionnaires` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `questionnaires_user_id_foreign` (`user_id`),
  CONSTRAINT `questionnaires_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaires`
--

LOCK TABLES `questionnaires` WRITE;
/*!40000 ALTER TABLE `questionnaires` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionnaires` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `questionnaire_id` int(10) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `labels` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `questions_questionnaire_id_foreign` (`questionnaire_id`),
  CONSTRAINT `questions_questionnaire_id_foreign` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaires` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responses`
--

DROP TABLE IF EXISTS `responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `responses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` int(10) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `response` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `responses_question_id_foreign` (`question_id`),
  CONSTRAINT `responses_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responses`
--

LOCK TABLES `responses` WRITE;
/*!40000 ALTER TABLE `responses` DISABLE KEYS */;
/*!40000 ALTER TABLE `responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Craig Hughes','23641835@edgehill.ac.uk',NULL,'$2y$10$05HxCpBni.NjjD4nTMqzoOnleJUiGVhB1nzQK2.h6xZnAVgpRnlJm',NULL,'2019-03-19 12:57:17','2019-03-19 12:57:17'),(2,'Mossie Batz DVM','xschaefer@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','JAU3tqoe8h','2019-03-19 12:54:40','2019-03-19 12:54:40'),(3,'Brenden Greenfelder','sylvia20@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','itrfn9ft3R','2019-03-19 12:54:40','2019-03-19 12:54:40'),(4,'Bertrand Schroeder','daren82@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','kbX2cRuy51','2019-03-19 12:54:40','2019-03-19 12:54:40'),(5,'Dameon Johns','mathias24@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','3z10GQoHlM','2019-03-19 12:54:40','2019-03-19 12:54:40'),(6,'Max Frami','klocko.sierra@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','gvcNPTxtPA','2019-03-19 12:54:40','2019-03-19 12:54:40'),(7,'Lazaro Hermiston V','janis96@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','gxvesbveBF','2019-03-19 12:54:40','2019-03-19 12:54:40'),(8,'Thalia Turcotte PhD','runte.giovani@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','vtwdBdjEaI','2019-03-19 12:54:40','2019-03-19 12:54:40'),(9,'Rosa Kub III','zella88@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','m5SrPiso4O','2019-03-19 12:54:40','2019-03-19 12:54:40'),(10,'Tracey Torp V','dameon.hayes@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','MtUaUWS5N9','2019-03-19 12:54:40','2019-03-19 12:54:40'),(11,'Mr. Timothy Nolan MD','cummings.joanny@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','ucZvxZe1WQ','2019-03-19 12:54:40','2019-03-19 12:54:40'),(12,'Larue Swift','dfarrell@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','WXmnmIQBdN','2019-03-19 12:54:40','2019-03-19 12:54:40'),(13,'Mekhi Kulas','reynolds.mathias@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','kotFidGU5j','2019-03-19 12:54:40','2019-03-19 12:54:40'),(14,'Regan Cremin Sr.','erica34@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','K3HieG9Mxn','2019-03-19 12:54:40','2019-03-19 12:54:40'),(15,'Dr. Zetta Ratke I','maiya.lebsack@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','4NmQjpk13K','2019-03-19 12:54:40','2019-03-19 12:54:40'),(16,'Vena Kohler','gus54@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','iBlvZhbNsA','2019-03-19 12:54:40','2019-03-19 12:54:40'),(17,'Braeden Hyatt','bauch.donato@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','VgtZgvdE5p','2019-03-19 12:54:40','2019-03-19 12:54:40'),(18,'Hailee Homenick','ara.hickle@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','0uSZfFzZbb','2019-03-19 12:54:40','2019-03-19 12:54:40'),(19,'Lazaro Runolfsson','hnolan@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','mva2dPaWxf','2019-03-19 12:54:40','2019-03-19 12:54:40'),(20,'Alison Witting','sporer.mason@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','SmXdExMyFX','2019-03-19 12:54:40','2019-03-19 12:54:40'),(21,'Aracely Bauch','rveum@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','xwBfsfe5yu','2019-03-19 12:54:40','2019-03-19 12:54:40'),(22,'Ms. Jodie Strosin II','harry49@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','Z9452jY4k6','2019-03-19 12:54:40','2019-03-19 12:54:40'),(23,'Dejuan Block','ashlee85@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','Amd6Fvqw2R','2019-03-19 12:54:40','2019-03-19 12:54:40'),(24,'Dale Kunze','wlangosh@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','fajSq7xHO5','2019-03-19 12:54:40','2019-03-19 12:54:40'),(25,'Maryjane Kub','marcellus.price@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','H4ZGIS9Uda','2019-03-19 12:54:40','2019-03-19 12:54:40'),(26,'Tomas Haley','uschinner@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','AsbuHXWZyr','2019-03-19 12:54:40','2019-03-19 12:54:40'),(27,'Jocelyn Hoeger','vhirthe@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','SfFnDysH8i','2019-03-19 12:54:40','2019-03-19 12:54:40'),(28,'Zita Senger DVM','hettinger.jaiden@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','JR7DIIYljX','2019-03-19 12:54:40','2019-03-19 12:54:40'),(29,'Mellie Hansen','vincent82@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','CAkTZPDMx8','2019-03-19 12:54:40','2019-03-19 12:54:40'),(30,'Frederick Crooks','lilyan90@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','767Izqwm4W','2019-03-19 12:54:40','2019-03-19 12:54:40'),(31,'Enoch Baumbach','wallace76@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','Z9IdnKggpq','2019-03-19 12:54:40','2019-03-19 12:54:40'),(32,'Prof. Deion Altenwerth','xmcclure@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','mfd8t48CHO','2019-03-19 12:54:40','2019-03-19 12:54:40'),(33,'Dr. Tito Koelpin V','aankunding@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','8XAcCc8P9r','2019-03-19 12:54:40','2019-03-19 12:54:40'),(34,'Mr. Horace Pfeffer I','zrau@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','C7N4PChuu1','2019-03-19 12:54:40','2019-03-19 12:54:40'),(35,'Burnice Reinger','zebert@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','XJVOco9tyT','2019-03-19 12:54:40','2019-03-19 12:54:40'),(36,'Lon Boyer','eldridge66@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','rBhsyYGhU4','2019-03-19 12:54:40','2019-03-19 12:54:40'),(37,'Shemar Torp','towne.hertha@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','D7d5TDuYnk','2019-03-19 12:54:40','2019-03-19 12:54:40'),(38,'Alexandra Corwin','jevon.kemmer@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','VGRD3cmtyf','2019-03-19 12:54:40','2019-03-19 12:54:40'),(39,'Sheldon Bednar','reuben22@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','lmLYbo0aW0','2019-03-19 12:54:40','2019-03-19 12:54:40'),(40,'Mr. Jalen Schmidt III','jernser@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','z6VJWuNdZO','2019-03-19 12:54:40','2019-03-19 12:54:40'),(41,'Alfreda Koss PhD','arianna66@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','kAeMc60aIp','2019-03-19 12:54:40','2019-03-19 12:54:40'),(42,'Juston Kulas','allene.wiegand@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','CdDyMyhTNM','2019-03-19 12:54:40','2019-03-19 12:54:40'),(43,'Tomasa Shields','leopold05@example.org','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','MNx9tegF2w','2019-03-19 12:54:40','2019-03-19 12:54:40'),(44,'Dolores O\'Conner IV','oswaniawski@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','xJ9K5B5Eez','2019-03-19 12:54:40','2019-03-19 12:54:40'),(45,'Misael Leuschke','orpha67@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','PKRaXCHLrI','2019-03-19 12:54:40','2019-03-19 12:54:40'),(46,'Flossie Gleichner','orn.josiah@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','oJaQKerIUU','2019-03-19 12:54:40','2019-03-19 12:54:40'),(47,'Dr. Eusebio Homenick IV','tabitha26@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','SOKUPUmu68','2019-03-19 12:54:40','2019-03-19 12:54:40'),(48,'Curt Morissette','nella58@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','XkLyK3K8dr','2019-03-19 12:54:40','2019-03-19 12:54:40'),(49,'Heaven Kuhic','mckenzie.bettie@example.net','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','JEKPmCOauo','2019-03-19 12:54:40','2019-03-19 12:54:40'),(50,'Lawrence Gutmann','runolfsson.ophelia@example.com','2019-03-19 12:54:40','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','3Q7Fe2ZtlP','2019-03-19 12:54:40','2019-03-19 12:54:40');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-19 12:59:16
