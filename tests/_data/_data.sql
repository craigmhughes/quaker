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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (75,'2014_10_12_000000_create_users_table',1),(76,'2014_10_12_100000_create_password_resets_table',1),(77,'2019_03_19_055908_create_questionnaires_table',1),(78,'2019_03_19_055917_create_questions_table',1),(79,'2019_03_19_055932_create_responses_table',1),(80,'2019_03_21_123537_options',1);
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
  `order_no` int(11) DEFAULT NULL,
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
INSERT INTO `options` VALUES (1,1,'accusamus',0,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(2,1,'rem',0,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(3,10,'laudantium',0,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(4,2,'a',0,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(5,10,'rem',0,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(6,2,'perspiciatis',0,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(7,2,'ratione',0,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(8,10,'aut',0,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(9,2,'sint',0,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(10,5,'quaerat',0,'2019-04-04 12:55:46','2019-04-04 12:55:46');
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
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `questionnaires` VALUES (1,'Repellat magni earum consequatur voluptatem totam deserunt repudiandae nam.','Cumque architecto id odit est.',1,0,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(2,'Et ea dolore quo iste.','Sed fuga assumenda labore.',1,0,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(3,'Repudiandae quis rerum aliquid esse exercitationem vel sit.','Voluptas quas ex possimus assumenda temporibus voluptatem qui dicta.',1,1,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(4,'Neque error nisi cupiditate.','Voluptates repellat rerum at quia.',1,1,'2019-04-04 12:55:46','2019-04-04 12:55:46'),(5,'Ea dolorem sunt maiores odio.','Numquam temporibus architecto labore fuga qui.',1,0,'2019-04-04 12:55:46','2019-04-04 12:55:46');
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
INSERT INTO `questions` VALUES (1,'Voluptates voluptatem rem excepturi commodi.',2,'closed','2019-04-04 12:55:46','2019-04-04 12:55:46'),(2,'Voluptatem quasi provident quo.',5,'closed','2019-04-04 12:55:46','2019-04-04 12:55:46'),(3,'Nihil temporibus neque et.',2,'open','2019-04-04 12:55:46','2019-04-04 12:55:46'),(4,'Laudantium et dolorum necessitatibus laudantium.',1,'open','2019-04-04 12:55:46','2019-04-04 12:55:46'),(5,'Omnis sed non excepturi hic quod eum.',1,'closed','2019-04-04 12:55:46','2019-04-04 12:55:46'),(6,'Voluptas at sint aut voluptatem natus laboriosam nisi.',3,'open','2019-04-04 12:55:46','2019-04-04 12:55:46'),(7,'Molestias commodi asperiores rerum est fuga minus sequi.',4,'open','2019-04-04 12:55:46','2019-04-04 12:55:46'),(8,'Doloribus quo quibusdam magni voluptatem praesentium et.',1,'open','2019-04-04 12:55:46','2019-04-04 12:55:46'),(9,'Cum aut et non praesentium illo impedit id dolores.',1,'open','2019-04-04 12:55:46','2019-04-04 12:55:46'),(10,'Ut quas commodi facere dolorem aspernatur pariatur.',5,'closed','2019-04-04 12:55:46','2019-04-04 12:55:46');
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
INSERT INTO `responses` VALUES (1,6,'open','Est hic magnam officia quidem possimus veniam vero.','2019-04-04 12:55:46','2019-04-04 12:55:46'),(2,6,'open','Pariatur nesciunt perferendis deserunt dignissimos culpa consequatur earum.','2019-04-04 12:55:46','2019-04-04 12:55:46'),(3,6,'open','Facere deleniti quos enim sint voluptas.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(4,7,'open','Necessitatibus laudantium autem architecto commodi rerum.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(5,7,'open','Laboriosam ullam id dolores voluptas ea.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(6,7,'open','Numquam inventore pariatur laboriosam et sit omnis animi.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(7,7,'open','Non vel asperiores assumenda praesentium mollitia ad.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(8,6,'open','Dicta sit quo reprehenderit voluptas.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(9,7,'open','Ipsum maiores officia animi eum.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(10,6,'open','Et accusamus dignissimos tenetur exercitationem repellendus error.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(11,7,'open','Autem nihil impedit unde et eius dolorum sed.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(12,6,'open','Quis ea sunt sit pariatur enim neque.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(13,6,'open','Autem aliquid molestiae ut voluptatem esse consequatur.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(14,7,'open','Ab quam autem deserunt debitis sit dolores nemo voluptatum.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(15,6,'open','Quod ea alias corrupti libero facilis impedit.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(16,7,'open','Aliquid natus quam tempora ut fuga accusantium.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(17,7,'open','Natus nostrum inventore omnis et impedit exercitationem.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(18,7,'open','Veniam modi dolore doloremque enim sit voluptatem dolores.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(19,6,'open','Enim qui enim odit neque dignissimos fugit.','2019-04-04 12:55:47','2019-04-04 12:55:47'),(20,7,'open','Aut et ad veniam rerum aut.','2019-04-04 12:55:47','2019-04-04 12:55:47');
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
INSERT INTO `users` VALUES (1,'Craig Hughes','test@mail.com',NULL,'$2y$10$aWa6/adDBpq8e0gONO2Qp.558mN./Xb/S.GMyyu/NwoCxSdvvj3Iu',NULL,'2019-04-04 12:56:05','2019-04-04 12:56:05');
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

-- Dump completed on 2019-04-04 14:56:35
