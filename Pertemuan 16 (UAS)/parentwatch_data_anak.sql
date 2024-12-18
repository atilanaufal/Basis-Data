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
-- Table structure for table `data_anak`
--

DROP TABLE IF EXISTS `data_anak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_anak` (
  `id_anak` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `nama_anak` varchar(255) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `umur` int NOT NULL,
  `jenis_kelamin` enum('laki-laki','perempuan') NOT NULL,
  `hobi` text,
  `berat_badan_kg` decimal(5,2) DEFAULT NULL,
  `tinggi_badan_cm` decimal(5,2) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_anak`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `data_anak_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `akun_user` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_anak`
--

LOCK TABLES `data_anak` WRITE;
/*!40000 ALTER TABLE `data_anak` DISABLE KEYS */;
INSERT INTO `data_anak` VALUES (1,1,'Dita','2015-05-10',8,'perempuan','Menyanyi',30.50,120.40,'2024-12-18 23:05:13','2024-12-18 23:05:13'),(2,2,'Yerenika','2015-05-10',8,'perempuan','Menyanyi',30.50,120.40,'2024-12-18 23:41:06','2024-12-18 23:41:06'),(4,2,'anto','2015-05-10',10,'laki-laki','ngegame',30.50,120.40,'2024-12-18 23:45:06','2024-12-18 23:45:06');
/*!40000 ALTER TABLE `data_anak` ENABLE KEYS */;
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
