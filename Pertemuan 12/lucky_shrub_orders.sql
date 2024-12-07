-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: lucky_shrub
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
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL,
  `ClientID` varchar(10) DEFAULT NULL,
  `ProductID` varchar(10) DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Cost` decimal(6,2) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `IdxClientID` (`ClientID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'Cl1','P1',10,500.00,'2020-09-01'),(2,'Cl2','P2',5,100.00,'2020-09-05'),(3,'Cl3','P3',20,800.00,'2020-09-03'),(4,'Cl4','P4',15,150.00,'2020-09-07'),(5,'Cl3','P3',10,450.00,'2020-09-08'),(6,'Cl2','P2',5,800.00,'2020-09-09'),(7,'Cl1','P4',22,1200.00,'2020-09-10'),(8,'Cl3','P1',15,150.00,'2020-09-10'),(9,'Cl1','P1',10,500.00,'2020-09-12'),(10,'Cl2','P2',5,100.00,'2020-09-13'),(11,'Cl1','P2',15,80.00,'2020-09-12'),(12,'Cl1','P1',10,500.00,'2022-09-01'),(13,'Cl2','P2',5,100.00,'2022-09-05'),(14,'Cl3','P3',20,800.00,'2022-09-03'),(15,'Cl4','P4',15,150.00,'2022-09-07'),(16,'Cl3','P3',10,450.00,'2022-09-08'),(17,'Cl2','P2',5,800.00,'2022-09-09'),(18,'Cl1','P4',22,1200.00,'2022-09-10'),(19,'Cl3','P1',15,150.00,'2022-09-10'),(20,'Cl1','P1',10,500.00,'2022-09-12'),(21,'Cl2','P2',5,100.00,'2022-09-13'),(22,'Cl2','P1',10,500.00,'2021-09-01'),(23,'Cl2','P2',5,100.00,'2021-09-05'),(24,'Cl3','P3',20,800.00,'2021-09-03'),(25,'Cl4','P4',15,150.00,'2021-09-07'),(26,'Cl1','P3',10,450.00,'2021-09-08'),(27,'Cl2','P1',20,1000.00,'2022-09-01'),(28,'Cl2','P2',10,200.00,'2022-09-05'),(29,'Cl3','P3',20,800.00,'2021-09-03');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-07 11:27:40
