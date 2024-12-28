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
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) DEFAULT NULL,
  `record_id` int DEFAULT NULL,
  `operation_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `changed_by` int DEFAULT NULL,
  `role` enum('admin','user') DEFAULT NULL,
  `changed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `old_data` json DEFAULT NULL,
  `new_data` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
INSERT INTO `audit_logs` VALUES (1,'akun_admin',1,'INSERT',1,'admin','2024-12-23 11:03:06',NULL,'{\"email\": \"admin1@gmail.com\", \"id_admin\": 1, \"nama_admin\": \"admin1\"}'),(2,'akun_user',1,'INSERT',1,'user','2024-12-23 11:03:06',NULL,'{\"email\": \"daffa@gmail.com\", \"id_user\": 1, \"nama_user\": \"Daffa\", \"tipe_user\": \"orang_tua\"}'),(3,'akun_user',2,'INSERT',2,'user','2024-12-23 11:03:06',NULL,'{\"email\": \"budi@gmail.com\", \"id_user\": 2, \"nama_user\": \"budi\", \"tipe_user\": \"pengasuh\"}'),(4,'data_anak',1,'INSERT',1,'user','2024-12-23 11:03:07',NULL,'{\"umur\": 4, \"id_anak\": 1, \"nama_anak\": \"Ma\'ruf\", \"jenis_kelamin\": \"laki-laki\", \"tanggal_lahir\": \"2020-01-15\", \"berat_badan_kg\": 20.50, \"tinggi_badan_cm\": 90.20}'),(5,'data_anak',2,'INSERT',1,'user','2024-12-23 11:03:07',NULL,'{\"umur\": 7, \"id_anak\": 2, \"nama_anak\": \"Mina\", \"jenis_kelamin\": \"perempuan\", \"tanggal_lahir\": \"2017-08-12\", \"berat_badan_kg\": 45.00, \"tinggi_badan_cm\": 125.00}'),(6,'jadwal_makan',1,'INSERT',1,NULL,'2024-12-23 11:03:07',NULL,'{\"id_anak\": 1, \"id_jadwal\": 1, \"menu_sarapan\": \"Roti\", \"waktu_sarapan\": \"07:00:00.000000\"}'),(7,'jadwal_makan',2,'INSERT',1,NULL,'2024-12-23 11:03:07',NULL,'{\"id_anak\": 2, \"id_jadwal\": 2, \"menu_sarapan\": \"Bubur Ayam\", \"waktu_sarapan\": \"07:00:00.000000\"}');
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-28 21:30:22
