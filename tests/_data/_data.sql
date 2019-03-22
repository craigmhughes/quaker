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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (69,'2014_10_12_000000_create_users_table',1),(70,'2014_10_12_100000_create_password_resets_table',1),(71,'2019_03_19_055908_create_questionnaires_table',1),(72,'2019_03_19_055917_create_questions_table',1),(73,'2019_03_19_055932_create_responses_table',1),(74,'2019_03_21_123537_options',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` int(10) unsigned NOT NULL,
  `option` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_no` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `options_question_id_foreign` (`question_id`),
  CONSTRAINT `options_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `options`
--

LOCK TABLES `options` WRITE;
/*!40000 ALTER TABLE `options` DISABLE KEYS */;
INSERT INTO `options` VALUES (1,1,'sapiente',0,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(2,3,'ipsum',0,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(3,2,'accusantium',0,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(4,1,'eaque',0,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(5,2,'enim',0,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(6,1,'eum',0,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(7,3,'necessitatibus',0,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(8,1,'molestias',0,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(9,3,'ut',0,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(10,2,'voluptatibus',0,'2019-03-22 15:26:04','2019-03-22 15:26:04');
/*!40000 ALTER TABLE `options` ENABLE KEYS */;
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
  `is_public` tinyint(1) NOT NULL,
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
INSERT INTO `questionnaires` VALUES (1,'Consequatur ipsa ducimus eveniet et.',1,0,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(2,'Dolorem qui modi soluta.',1,0,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(3,'Dolores minima sed officiis asperiores nemo itaque debitis aliquid.',1,1,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(4,'Ea eos possimus vitae exercitationem voluptatum nam.',1,1,'2019-03-22 15:26:04','2019-03-22 15:26:04'),(5,'Atque minus fugiat debitis.',1,1,'2019-03-22 15:26:04','2019-03-22 15:26:04');
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
INSERT INTO `questions` VALUES (1,'In labore ut voluptates quia in rerum.',3,'closed','2019-03-22 15:26:04','2019-03-22 15:26:04'),(2,'Ut commodi eius velit asperiores.',3,'closed','2019-03-22 15:26:04','2019-03-22 15:26:04'),(3,'Aperiam quia molestiae magnam.',4,'closed','2019-03-22 15:26:04','2019-03-22 15:26:04'),(4,'Vel blanditiis accusantium rerum eos vel possimus quas temporibus.',3,'open','2019-03-22 15:26:04','2019-03-22 15:26:04'),(5,'Et veniam rem velit adipisci exercitationem qui magnam.',2,'open','2019-03-22 15:26:04','2019-03-22 15:26:04'),(6,'Fugiat est nam ut sunt.',3,'open','2019-03-22 15:26:04','2019-03-22 15:26:04'),(7,'Vel doloremque laborum nihil laboriosam non aut.',5,'closed','2019-03-22 15:26:04','2019-03-22 15:26:04'),(8,'Non incidunt nulla laudantium quas libero repellat est.',2,'open','2019-03-22 15:26:04','2019-03-22 15:26:04'),(9,'Magni sed sint omnis quia et voluptates.',2,'open','2019-03-22 15:26:04','2019-03-22 15:26:04'),(10,'Officiis rerum voluptatibus nemo dolore deserunt consequatur voluptatem.',5,'open','2019-03-22 15:26:04','2019-03-22 15:26:04');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responses`
--

LOCK TABLES `responses` WRITE;
/*!40000 ALTER TABLE `responses` DISABLE KEYS */;
INSERT INTO `responses` VALUES (1,3,'closed','ipsum','2019-03-22 15:26:04','2019-03-22 15:26:04'),(2,3,'closed','ipsum','2019-03-22 15:26:04','2019-03-22 15:26:04'),(3,10,'open','Iste velit delectus optio autem aut iure.','2019-03-22 15:26:04','2019-03-22 15:26:04'),(4,4,'open','Doloribus dolor aut vitae omnis quia repudiandae.','2019-03-22 15:26:04','2019-03-22 15:26:04'),(5,3,'closed','ipsum','2019-03-22 15:26:04','2019-03-22 15:26:04'),(6,3,'closed','ipsum','2019-03-22 15:26:04','2019-03-22 15:26:04'),(7,1,'closed','sapiente','2019-03-22 15:26:04','2019-03-22 15:26:04'),(8,3,'closed','ipsum','2019-03-22 15:26:04','2019-03-22 15:26:04'),(9,10,'open','Non dignissimos maxime animi.','2019-03-22 15:26:04','2019-03-22 15:26:04'),(10,6,'open','Aut minus dolore dolor autem accusamus eligendi.','2019-03-22 15:26:04','2019-03-22 15:26:04'),(11,4,'open','Aliquid non ut numquam placeat atque consectetur eligendi.','2019-03-22 15:26:04','2019-03-22 15:26:04'),(12,10,'open','Quam dignissimos et consequuntur rerum.','2019-03-22 15:26:04','2019-03-22 15:26:04'),(13,3,'closed','ipsum','2019-03-22 15:26:04','2019-03-22 15:26:04'),(14,3,'closed','ipsum','2019-03-22 15:26:04','2019-03-22 15:26:04'),(15,3,'closed','ipsum','2019-03-22 15:26:04','2019-03-22 15:26:04'),(16,3,'closed','ipsum','2019-03-22 15:26:04','2019-03-22 15:26:04'),(17,1,'closed','sapiente','2019-03-22 15:26:04','2019-03-22 15:26:04'),(18,10,'open','Occaecati aspernatur saepe voluptatem voluptatum eveniet numquam nam inventore.','2019-03-22 15:26:04','2019-03-22 15:26:04'),(19,10,'open','Dolores ut aut voluptatem dolores iure.','2019-03-22 15:26:04','2019-03-22 15:26:04'),(20,3,'closed','ipsum','2019-03-22 15:26:04','2019-03-22 15:26:04');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Craig Hughes','23641835@edgehill.ac.uk',NULL,'$2y$10$kqWEWgYc./0VT.D.NycpDuldwM1G7oUc7Ydw9LKotXIliKFv9Vhvm',NULL,'2019-03-22 15:29:59','2019-03-22 15:29:59');
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

-- Dump completed on 2019-03-22 15:31:33
