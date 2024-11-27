CREATE DATABASE  IF NOT EXISTS `leafy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `leafy`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: leafy
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `plant`
--

DROP TABLE IF EXISTS `plant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plant` (
  `Id` varchar(36) NOT NULL,
  `Created` datetime NOT NULL,
  `Modified` datetime NOT NULL,
  `Deleted` bit(1) NOT NULL DEFAULT (0),
  `Name` varchar(100) NOT NULL,
  `Description` varchar(500) NOT NULL,
  `PlantInfoId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `PlantInfoId` (`PlantInfoId`),
  CONSTRAINT `plant_ibfk_1` FOREIGN KEY (`PlantInfoId`) REFERENCES `plantinfo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plantinfo`
--

DROP TABLE IF EXISTS `plantinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plantinfo` (
  `Id` varchar(36) NOT NULL,
  `Created` datetime NOT NULL,
  `Modified` datetime NOT NULL,
  `Deleted` bit(1) NOT NULL DEFAULT (0),
  `IdealHumidityPerc` decimal(4,2) NOT NULL,
  `AvgHeight` decimal(6,2) NOT NULL,
  `AvgDiameter` decimal(4,2) NOT NULL,
  `IdealSunlightK` decimal(4,2) NOT NULL,
  `WeeklyWater` int NOT NULL DEFAULT (0),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `planttag`
--

DROP TABLE IF EXISTS `planttag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planttag` (
  `Id` varchar(36) NOT NULL,
  `Created` datetime NOT NULL,
  `Modified` datetime NOT NULL,
  `Deleted` bit(1) NOT NULL DEFAULT (0),
  `Name` varchar(50) NOT NULL,
  `PlantId` varchar(36) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `PlantId` (`PlantId`),
  CONSTRAINT `planttag_ibfk_1` FOREIGN KEY (`PlantId`) REFERENCES `plant` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `Id` varchar(36) NOT NULL,
  `Created` datetime NOT NULL,
  `Modified` datetime NOT NULL,
  `Email` varchar(356) NOT NULL,
  `PasswordHash` varchar(64) DEFAULT NULL,
  `FirstName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Surname` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Deleted` bit(1) NOT NULL DEFAULT (0),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'leafy'
--

--
-- Dumping routines for database 'leafy'
--
/*!50003 DROP PROCEDURE IF EXISTS `Plant_List_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Plant_List_GET`()
BEGIN

	SELECT 
		p.Id,
        p.Name,
        pi.WeeklyWater
	FROM Plant p
    INNER JOIN PlantInfo pi ON pi.Id = p.PlantInfoId
    WHERE p.Deleted = 0
    ORDER BY p.Name;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `User_Authenticate_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `User_Authenticate_GET`(
	IN Email VARCHAR(346)
)
BEGIN

	SELECT 
		u.Id,
        u.PasswordHash
	FROM User u
    WHERE u.Email = Email
    AND u.Deleted = 0;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `User_Exists_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `User_Exists_GET`(	
	IN Email VARCHAR(356)
)
BEGIN

	SELECT u.Id
    FROM User u
    WHERE u.Email = Email
    AND u.Deleted = 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `User_GET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `User_GET`(	
	IN Id VARCHAR(36)
)
BEGIN

	SELECT
		u.Created,
        u.Modified,
		u.Email,
        u.FirstName,
        u.Surname
    FROM User u
    WHERE u.Id = Id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `User_INSERT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `User_INSERT`(	
	IN Id VARCHAR(36),
    IN Email VARCHAR(356),
    IN PasswordHash VARCHAR(64),
    IN FirstName NVARCHAR(100),
    IN Surname NVARCHAR(100)
)
BEGIN

	INSERT INTO User
	(
		Id,
        Created,
        Modified,
        Email,
        PasswordHash,
        FirstName,
        Surname
    )
    VALUES
    (
		Id,
        NOW(),
        NOW(),
        Email,
        PasswordHash,
        FirstName,
        Surname
    );

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

INSERT INTO PlantInfo (Id, Created, Modified, Deleted, IdealHumidityPerc, AvgHeight, AvgDiameter, IdealSunlightK, WeeklyWater) VALUES
('13ae6b4a-1c7f-4d51-88e3-3cc12a29e5f7', NOW(), NOW(), 0, 50.00, 150.00, 60.00, 5.50, 250),
('d1573dd3-6314-45de-9fcf-7c72974d3b2f', NOW(), NOW(), 0, 40.00, 100.00, 30.00, 7.00, 500),
('2fdde712-53b2-44b6-9d99-344ebf798647', NOW(), NOW(), 0, 60.00, 300.00, 20.00, 6.50, 375),
('3c4a35dc-daf8-4382-b1af-924789f2638d', NOW(), NOW(), 0, 55.00, 250.00, 40.00, 6.00, 250),
('551f5bba-739d-4057-a78f-b83b8a329f69', NOW(), NOW(), 0, 70.00, 200.00, 50.00, 8.00, 100),
('63dd8904-105d-4dc2-9df3-819f43ffb0ef', NOW(), NOW(), 0, 65.00, 120.00, 25.00, 5.50, 900),
('751a8c72-6217-4d1f-b238-69e07f20a284', NOW(), NOW(), 0, 50.00, 180.00, 30.00, 6.75, 250),
('82fa04e5-b007-4a72-8a0f-b6375e3c67da', NOW(), NOW(), 0, 45.00, 250.00, 70.00, 7.00, 275),
('94ffb147-2f08-4d7c-9f44-72e4f635da5e', NOW(), NOW(), 0, 30.00, 50.00, 10.00, 5.00, 300),
('a276c2b0-3d13-4f89-b9c3-efe1b57d5c8f', NOW(), NOW(), 0, 35.00, 75.00, 15.00, 6.25, 500);

INSERT INTO Plant (Id, Created, Modified, Deleted, `Name`, `Description`, PlantInfoId) VALUES
('6a8f8970-1f0c-41f9-a0ba-8b39430d6aa0', NOW(), NOW(), 0, 'Fiddle Leaf Fig', 'A popular houseplant with large glossy leaves.', '13ae6b4a-1c7f-4d51-88e3-3cc12a29e5f7'),
('c6bc1a68-fb88-4f90-9b59-f764128b6c4a', NOW(), NOW(), 0, 'Snake Plant', 'A hardy plant known for its air-purifying abilities.', 'd1573dd3-6314-45de-9fcf-7c72974d3b2f'),
('23e6ff8e-7892-4db0-b77c-3f9b283761af', NOW(), NOW(), 0, 'Pothos', 'A vining plant with heart-shaped leaves.', '2fdde712-53b2-44b6-9d99-344ebf798647'),
('e1cb14e4-d8b3-453d-9183-3a20d4578ba3', NOW(), NOW(), 0, 'Spider Plant', 'An easy-to-care-for plant with arching leaves.', '3c4a35dc-daf8-4382-b1af-924789f2638d'),
('95f8e04b-f57c-4396-9aa3-3a846d36238f', NOW(), NOW(), 0, 'Monstera Deliciosa', 'Known for its large, split leaves.', '551f5bba-739d-4057-a78f-b83b8a329f69'),
('b193c4e1-8123-49b8-8f98-2cf89dbb5c7d', NOW(), NOW(), 0, 'Peace Lily', 'A beautiful flowering plant with white blooms.', '63dd8904-105d-4dc2-9df3-819f43ffb0ef'),
('36af82d7-580e-48c3-9367-13b7af23ab9c', NOW(), NOW(), 0, 'Bamboo Palm', 'A plant known for its lush, tropical look.', '751a8c72-6217-4d1f-b238-69e07f20a284'),
('0c4f3ab5-4df7-4691-9bfc-d08a4d1ea3d5', NOW(), NOW(), 0, 'Rubber Plant', 'A tree-like plant with thick, glossy leaves.', '82fa04e5-b007-4a72-8a0f-b6375e3c67da'),
('adcf632e-8327-41fc-bb06-d789c98e78a4', NOW(), NOW(), 0, 'Aloe Vera', 'A succulent known for its medicinal properties.', '94ffb147-2f08-4d7c-9f44-72e4f635da5e'),
('63f5a3b3-4c97-48a5-89a7-1d47c9f3e94b', NOW(), NOW(), 0, 'Jade Plant', 'A small, fleshy-leafed succulent.', 'a276c2b0-3d13-4f89-b9c3-efe1b57d5c8f');


-- Dump completed on 2024-11-27 23:29:04
