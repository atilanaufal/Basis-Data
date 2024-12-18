-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: parentwatch
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `jadwal_makan`
--

DROP TABLE IF EXISTS `jadwal_makan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jadwal_makan` (
  `id_jadwal` int NOT NULL AUTO_INCREMENT,
  `id_anak` int NOT NULL,
  `waktu_sarapan` time DEFAULT NULL,
  `menu_sarapan` text,
  `waktu_makan_siang` time DEFAULT NULL,
  `menu_makan_siang` text,
  `waktu_makan_malam` time DEFAULT NULL,
  `menu_makan_malam` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_jadwal`),
  KEY `id_anak` (`id_anak`),
  CONSTRAINT `jadwal_makan_ibfk_1` FOREIGN KEY (`id_anak`) REFERENCES `data_anak` (`id_anak`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jadwal_makan`
--

LOCK TABLES `jadwal_makan` WRITE;
/*!40000 ALTER TABLE `jadwal_makan` DISABLE KEYS */;
INSERT INTO `jadwal_makan` VALUES (1,1,'07:00:00','Nasi Goreng','12:00:00','Ayam Goreng','18:00:00','Sup Ikan','2024-12-18 23:05:13','2024-12-18 23:05:13'),(2,1,'07:00:00','Udang','12:00:00','Ikan Tuna','18:00:00','Sup Iga','2024-12-18 23:41:06','2024-12-18 23:41:06'),(3,1,'07:00:00','Pasta Ikan','12:00:00','Sate Ayam','18:00:00','Martabak','2024-12-18 23:43:28','2024-12-18 23:43:28'),(4,1,'07:00:00','Pasta Ikan','12:00:00','Sate Ayam','18:00:00','Martabak','2024-12-18 23:45:06','2024-12-18 23:45:06');
/*!40000 ALTER TABLE `jadwal_makan` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-18 23:54:17
