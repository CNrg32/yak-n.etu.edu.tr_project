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
-- Database: SchoolManagement
-- 

CREATE DATABASE IF NOT EXISTS SchoolManagement;
USE SchoolManagement;

-- 
-- Table structure for Users
-- 
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: schoolmanagement
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
-- Table structure for table cafeteria_menu
--

DROP TABLE IF EXISTS cafeteria_menu;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE cafeteria_menu (
  menu_id int NOT NULL AUTO_INCREMENT,
  date date NOT NULL,
  menu_description text NOT NULL,
  PRIMARY KEY (menu_id)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table cafeteria_menu
--

LOCK TABLES cafeteria_menu WRITE;
/*!40000 ALTER TABLE cafeteria_menu DISABLE KEYS */;
INSERT INTO cafeteria_menu VALUES (1,'2024-12-02','Mercimek Çorbası, Etli Nohut, Pilav, Ayran'),(2,'2024-12-03','Dana Rosto, Makarna, Komposto, Salata'),(3,'2024-12-04','Domates Çorbası, Fırın Köfte, Bulgur Pilavı, Yoğurt'),(4,'2024-12-05','Düğün Çorbası, Kıy. Karnabahar, Lorlu Börek, Tatlı'),(5,'2024-12-06','Ezogelin Çorbası, Köfte Karışık Kızartma, Makarna, Helva'),(6,'2024-12-09','A. Şehriye Çorbası, Etli Nohut, Pilav, Ayran'),(7,'2024-12-10','Mercimek Çorbası, Dana Rosto, Makarna, Komposto'),(8,'2024-12-11','Domates Çorbası, Fırın Köfte, Bulgur Pilavı, Tatlı'),(9,'2024-12-12','Düğün Çorbası, Kıy. Karnabahar, Lorlu Börek, Cacık'),(10,'2024-12-13','Ezogelin Çorbası, Köfte Karışık Kızartma, Makarna, Yoğurt'),(11,'2024-12-16','Mercimek Çorbası, Orman Kebabı, Bulgur Pilavı, Komposto'),(12,'2024-12-17','Düğün Çorbası, Ispanak, Makarna, Ayran'),(13,'2024-12-18','Ezogelin Çorba, Kadınbudu Köfte, Patates Kızartması, Salata'),(14,'2024-12-19','Gerdan Çorba, Patlıcan Musakka, Nohutlu Pilav, Yoğurt'),(15,'2024-12-20','Domates Çorbası, Z.Yağlı Pırasa, Börek, Komposto'),(16,'2024-12-23','Mercimek Çorbası, Sebzeli Kuru Fasulye, Bulgur Pilavı, Salata'),(17,'2024-12-24','K. Mantar Çorbası, Etli Tavuk, Makarna, Yoğurt'),(18,'2024-12-25','Düğün Çorbası, Karnıyarık, Bulgur Pilavı, Cacık'),(19,'2024-12-26','Ezogelin Çorbası, Çoban Kavurma, Erişte, Ayran'),(20,'2024-12-27','Domates Çorbası, Tas Kebabı, Pilav, Tatlı'),(21,'2024-12-30','Mercimek Çorbası, Z.Yağlı Kereviz, Börek, Yoğurt'),(22,'2024-12-31','Ezogelin Çorbası, Arnavut Ciğeri, Pilav, Cacık');
/*!40000 ALTER TABLE cafeteria_menu ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table classrooms
--

DROP TABLE IF EXISTS classrooms;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE classrooms (
  classroom_id int NOT NULL AUTO_INCREMENT,
  room_name varchar(50) NOT NULL,
  is_empty tinyint(1) NOT NULL DEFAULT '1',
  last_updated timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  hours varchar(6) DEFAULT NULL,
  PRIMARY KEY (classroom_id)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table classrooms
--

LOCK TABLES classrooms WRITE;
/*!40000 ALTER TABLE classrooms DISABLE KEYS */;
INSERT INTO classrooms VALUES (1,'Class A1',0,'2024-11-16 17:19:14','08:00'),(2,'Class A2',1,'2024-11-16 17:19:14','08:00'),(3,'Class A3',1,'2024-11-16 17:19:14','08:00'),(4,'Class A4',0,'2024-11-16 16:40:58','08:00'),(5,'Class A5',1,'2024-11-16 17:19:14','08:00'),(6,'Class A6',0,'2024-11-16 16:40:58','08:00'),(7,'Class A7',0,'2024-11-16 17:19:14','08:00'),(8,'Class A8',0,'2024-11-16 16:40:58','08:00'),(9,'Class A9',1,'2024-11-16 16:40:58','08:00'),(10,'Class A10',0,'2024-11-16 16:40:58','08:00'),(11,'Class A11',1,'2024-11-16 16:40:58','08:00'),(12,'Class A12',1,'2024-11-16 17:19:14','08:00'),(13,'Class A13',1,'2024-11-16 16:40:58','08:00'),(14,'Class A14',0,'2024-11-16 16:40:58','08:00'),(15,'Class A15',1,'2024-11-16 16:40:58','08:00'),(16,'Class A16',0,'2024-11-16 16:40:58','08:00'),(17,'Class A17',1,'2024-11-16 17:19:14','08:00'),(18,'Class A18',1,'2024-11-16 17:19:14','08:00'),(19,'Class A19',1,'2024-11-16 17:19:14','08:00'),(20,'Class A20',1,'2024-11-16 17:19:14','08:00'),(21,'Class A21',0,'2024-11-16 17:19:14','08:00'),(22,'Class A22',1,'2024-11-16 17:19:14','08:00'),(23,'Class A23',1,'2024-11-16 16:40:58','08:00'),(24,'Class A24',0,'2024-11-16 16:40:58','08:00'),(25,'Class A25',1,'2024-11-16 16:40:58','08:00'),(26,'Class A26',1,'2024-11-16 17:19:14','08:00'),(27,'Class A27',1,'2024-11-16 16:40:58','08:00'),(28,'Class A28',1,'2024-11-16 17:19:14','08:00'),(29,'Class A29',1,'2024-11-16 16:40:58','08:00'),(30,'Class A30',1,'2024-11-16 17:19:14','08:00'),(31,'Class A1',1,'2024-11-16 17:19:14','10:00'),(32,'Class A2',0,'2024-11-16 16:40:58','10:00'),(33,'Class A3',1,'2024-11-16 16:40:58','10:00'),(34,'Class A4',1,'2024-11-16 17:19:14','10:00'),(35,'Class A5',0,'2024-11-16 17:19:14','10:00'),(36,'Class A6',1,'2024-11-16 17:19:14','10:00'),(37,'Class A7',0,'2024-11-16 17:19:14','10:00'),(38,'Class A8',0,'2024-11-16 16:40:58','10:00'),(39,'Class A9',1,'2024-11-16 16:40:58','10:00'),(40,'Class A10',0,'2024-11-16 16:40:58','10:00'),(41,'Class A11',1,'2024-11-16 17:19:14','10:00'),(42,'Class A12',1,'2024-11-16 17:19:14','10:00'),(43,'Class A13',1,'2024-11-16 16:40:58','10:00'),(44,'Class A14',1,'2024-11-16 17:19:14','10:00'),(45,'Class A15',0,'2024-11-16 17:19:14','10:00'),(46,'Class A16',0,'2024-11-16 16:40:58','10:00'),(47,'Class A17',0,'2024-11-16 17:19:14','10:00'),(48,'Class A18',1,'2024-11-16 17:19:14','10:00'),(49,'Class A19',1,'2024-11-16 16:40:58','10:00'),(50,'Class A20',0,'2024-11-16 16:40:58','10:00'),(51,'Class A21',1,'2024-11-16 16:40:58','10:00'),(52,'Class A22',0,'2024-11-16 16:40:58','10:00'),(53,'Class A23',1,'2024-11-16 16:40:58','10:00'),(54,'Class A24',1,'2024-11-16 17:19:14','10:00'),(55,'Class A25',0,'2024-11-16 17:19:14','10:00'),(56,'Class A26',1,'2024-11-16 17:19:14','10:00'),(57,'Class A27',1,'2024-11-16 17:19:14','10:00'),(58,'Class A28',0,'2024-11-16 16:40:58','10:00'),(59,'Class A29',1,'2024-11-16 16:40:58','10:00'),(60,'Class A30',0,'2024-11-16 16:40:58','10:00'),(61,'Class A1',0,'2024-11-16 17:19:14','12:00'),(62,'Class A2',1,'2024-11-16 17:19:14','12:00'),(63,'Class A3',0,'2024-11-16 17:19:14','12:00'),(64,'Class A4',0,'2024-11-16 16:40:58','12:00'),(65,'Class A5',0,'2024-11-16 17:19:14','12:00'),(66,'Class A6',1,'2024-11-16 17:19:14','12:00'),(67,'Class A7',1,'2024-11-16 17:19:14','12:00'),(68,'Class A8',0,'2024-11-16 16:40:58','12:00'),(69,'Class A9',1,'2024-11-16 17:19:14','12:00'),(70,'Class A10',1,'2024-11-16 17:19:14','12:00'),(71,'Class A11',1,'2024-11-16 16:40:58','12:00'),(72,'Class A12',0,'2024-11-16 16:40:58','12:00'),(73,'Class A13',1,'2024-11-16 17:19:14','12:00'),(74,'Class A14',0,'2024-11-16 16:40:58','12:00'),(75,'Class A15',0,'2024-11-16 17:19:14','12:00'),(76,'Class A16',0,'2024-11-16 16:40:58','12:00'),(77,'Class A17',0,'2024-11-16 17:19:14','12:00'),(78,'Class A18',1,'2024-11-16 17:19:14','12:00'),(79,'Class A19',1,'2024-11-16 17:19:14','12:00'),(80,'Class A20',0,'2024-11-16 16:40:58','12:00'),(81,'Class A21',1,'2024-11-16 16:40:58','12:00'),(82,'Class A22',0,'2024-11-16 16:40:58','12:00'),(83,'Class A23',0,'2024-11-16 17:19:14','12:00'),(84,'Class A24',0,'2024-11-16 16:40:58','12:00'),(85,'Class A25',1,'2024-11-16 16:40:58','12:00'),(86,'Class A26',1,'2024-11-16 17:19:14','12:00'),(87,'Class A27',1,'2024-11-16 16:40:58','12:00'),(88,'Class A28',1,'2024-11-16 17:19:14','12:00'),(89,'Class A29',1,'2024-11-16 16:40:58','12:00'),(90,'Class A30',0,'2024-11-16 16:40:58','12:00'),(91,'Class A1',0,'2024-11-16 17:19:14','14:00'),(92,'Class A2',1,'2024-11-16 17:19:14','14:00'),(93,'Class A3',0,'2024-11-16 17:19:14','14:00'),(94,'Class A4',0,'2024-11-16 16:40:58','14:00'),(95,'Class A5',1,'2024-11-16 17:19:14','14:00'),(96,'Class A6',0,'2024-11-16 16:40:58','14:00'),(97,'Class A7',1,'2024-11-16 16:40:58','14:00'),(98,'Class A8',0,'2024-11-16 16:40:58','14:00'),(99,'Class A9',1,'2024-11-16 17:19:14','14:00'),(100,'Class A10',1,'2024-11-16 17:19:14','14:00'),(101,'Class A11',1,'2024-11-16 16:40:58','14:00'),(102,'Class A12',1,'2024-11-16 17:19:14','14:00'),(103,'Class A13',0,'2024-11-16 17:19:14','14:00'),(104,'Class A14',1,'2024-11-16 17:19:14','14:00'),(105,'Class A15',1,'2024-11-16 16:40:58','14:00'),(106,'Class A16',1,'2024-11-16 17:19:14','14:00'),(107,'Class A17',1,'2024-11-16 16:40:58','14:00'),(108,'Class A18',0,'2024-11-16 16:40:58','14:00'),(109,'Class A19',1,'2024-11-16 16:40:58','14:00'),(110,'Class A20',0,'2024-11-16 16:40:58','14:00'),(111,'Class A21',1,'2024-11-16 17:19:14','14:00'),(112,'Class A22',0,'2024-11-16 16:40:58','14:00'),(113,'Class A23',1,'2024-11-16 16:40:58','14:00'),(114,'Class A24',0,'2024-11-16 16:40:58','14:00'),(115,'Class A25',1,'2024-11-16 17:19:14','14:00'),(116,'Class A26',0,'2024-11-16 16:40:58','14:00'),(117,'Class A27',1,'2024-11-16 16:40:58','14:00'),(118,'Class A28',0,'2024-11-16 16:40:58','14:00'),(119,'Class A29',1,'2024-11-16 17:19:14','14:00'),(120,'Class A30',0,'2024-11-16 16:40:58','14:00'),(121,'Class A1',0,'2024-11-16 17:19:14','16:00'),(122,'Class A2',0,'2024-11-16 16:40:58','16:00'),(123,'Class A3',0,'2024-11-16 17:19:14','16:00'),(124,'Class A4',1,'2024-11-16 17:19:14','16:00'),(125,'Class A5',1,'2024-11-16 17:19:14','16:00'),(126,'Class A6',0,'2024-11-16 16:40:58','16:00'),(127,'Class A7',1,'2024-11-16 17:19:14','16:00'),(128,'Class A8',0,'2024-11-16 16:40:58','16:00'),(129,'Class A9',1,'2024-11-16 17:19:14','16:00'),(130,'Class A10',0,'2024-11-16 16:40:58','16:00'),(131,'Class A11',0,'2024-11-16 17:19:14','16:00'),(132,'Class A12',0,'2024-11-16 16:40:58','16:00'),(133,'Class A13',1,'2024-11-16 17:19:14','16:00'),(134,'Class A14',1,'2024-11-16 17:19:14','16:00'),(135,'Class A15',0,'2024-11-16 17:19:14','16:00'),(136,'Class A16',0,'2024-11-16 16:40:58','16:00'),(137,'Class A17',0,'2024-11-16 17:19:14','16:00'),(138,'Class A18',1,'2024-11-16 17:19:14','16:00'),(139,'Class A19',1,'2024-11-16 16:40:58','16:00'),(140,'Class A20',1,'2024-11-16 17:19:14','16:00'),(141,'Class A21',1,'2024-11-16 17:19:14','16:00'),(142,'Class A22',1,'2024-11-16 17:19:14','16:00'),(143,'Class A23',1,'2024-11-16 17:19:14','16:00'),(144,'Class A24',0,'2024-11-16 16:40:58','16:00'),(145,'Class A25',1,'2024-11-16 16:40:58','16:00'),(146,'Class A26',0,'2024-11-16 16:40:58','16:00'),(147,'Class A27',1,'2024-11-16 17:19:14','16:00'),(148,'Class A28',0,'2024-11-16 16:40:58','16:00'),(149,'Class A29',0,'2024-11-16 17:19:14','16:00'),(150,'Class A30',1,'2024-11-16 17:19:14','16:00');
/*!40000 ALTER TABLE classrooms ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table courses
--

DROP TABLE IF EXISTS courses;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE courses (
  course_id int NOT NULL AUTO_INCREMENT,
  course_name varchar(100) NOT NULL,
  course_description text,
  days varchar(255) DEFAULT NULL,
  times varchar(255) DEFAULT NULL,
  PRIMARY KEY (course_id)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table courses
--

LOCK TABLES courses WRITE;
/*!40000 ALTER TABLE courses DISABLE KEYS */;
INSERT INTO courses VALUES (1,'BIL101','Introduction to Programming','Monday,Wednesday','10:00,14:00'),(2,'BIL102','Data Structures','Tuesday,Thursday','08:00,12:00'),(3,'BIL103','Computer Organization','Monday,Friday','10:00,16:00'),(4,'BIL104','Algorithms','Wednesday,Thursday','12:00,14:00'),(5,'BIL105','Operating Systems','Tuesday,Friday','08:00,10:00'),(6,'BIL106','Database Systems','Monday,Tuesday','12:00,16:00'),(7,'BIL107','Software Engineering','Thursday,Friday','08:00,10:00'),(8,'BIL108','Computer Networks','Tuesday,Wednesday','10:00,12:00'),(9,'BIL109','Discrete Mathematics','Monday,Thursday','08:00,14:00'),(10,'BIL110','Digital Logic Design','Wednesday,Friday','12:00,16:00'),(11,'BIL111','Microprocessors','Monday,Friday','10:00,14:00'),(12,'BIL112','Artificial Intelligence','Tuesday,Thursday','08:00,12:00'),(13,'BIL113','Machine Learning','Wednesday,Friday','10:00,16:00'),(14,'BIL114','Computer Graphics','Monday,Thursday','08:00,10:00'),(15,'BIL115','Web Development','Tuesday,Friday','12:00,16:00'),(16,'BIL116','Human-Computer Interaction','Monday,Wednesday','10:00,12:00'),(17,'BIL117','Cybersecurity Fundamentals','Thursday,Friday','08:00,14:00'),(18,'BIL118','Information Retrieval','Tuesday,Wednesday','12:00,16:00'),(19,'BIL119','Compiler Design','Monday,Friday','08:00,10:00'),(20,'BIL120','Parallel Computing','Wednesday,Thursday','10:00,14:00'),(21,'BIL121','Cloud Computing','Tuesday,Thursday','08:00,12:00'),(22,'BIL122','Distributed Systems','Monday,Wednesday','12:00,16:00'),(23,'BIL123','Network Security','Thursday,Friday','10:00,14:00'),(24,'BIL124','Game Development','Tuesday,Friday','08:00,12:00'),(25,'BIL125','Data Mining','Monday,Wednesday','08:00,10:00'),(26,'BIL126','Quantum Computing Basics','Thursday,Friday','12:00,16:00'),(27,'BIL127','Computer Vision','Tuesday,Wednesday','10:00,14:00'),(28,'BIL128','Natural Language Processing','Monday,Friday','08:00,12:00'),(29,'BIL129','Digital Forensics','Wednesday,Thursday','10:00,16:00'),(30,'BIL130','Advanced Programming Techniques','Monday,Tuesday','08:00,12:00'),(31,'BIL131','Robotics Programming','Monday,Thursday','08:00,14:00'),(32,'BIL132','Virtual Reality','Tuesday,Friday','10:00,12:00'),(33,'BIL133','Augmented Reality','Wednesday,Thursday','12:00,16:00'),(34,'BIL134','Blockchains and Cryptography','Monday,Tuesday','08:00,10:00'),(35,'BIL135','Advanced Databases','Thursday,Friday','10:00,14:00'),(36,'BIL136','Numerical Methods','Tuesday,Wednesday','08:00,12:00'),(37,'BIL137','Scientific Computing','Monday,Friday','12:00,16:00'),(38,'BIL138','Software Testing','Wednesday,Thursday','10:00,14:00'),(39,'BIL139','Embedded Systems','Monday,Tuesday','08:00,12:00'),(40,'BIL140','Computer Architecture','Thursday,Friday','12:00,16:00'),(41,'BIL141','Design and Analysis of Algorithms','Tuesday,Friday','08:00,10:00'),(42,'BIL142','Advanced Computer Networks','Monday,Thursday','10:00,14:00'),(43,'BIL143','Signal Processing','Wednesday,Friday','12:00,16:00'),(44,'BIL144','Control Systems','Tuesday,Thursday','08:00,10:00'),(45,'BIL145','Mobile App Development','Monday,Wednesday','10:00,12:00'),(46,'BIL146','Big Data Analytics','Thursday,Friday','08:00,14:00'),(47,'BIL147','Bioinformatics','Tuesday,Wednesday','12:00,16:00'),(48,'BIL148','Deep Learning','Monday,Thursday','08:00,10:00'),(49,'BIL149','Data Visualization','Wednesday,Friday','10:00,14:00'),(50,'BIL150','Software Project Management','Tuesday,Friday','12:00,16:00');
/*!40000 ALTER TABLE courses ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table enrollments
--

DROP TABLE IF EXISTS enrollments;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE enrollments (
  enrollment_id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  course_id int NOT NULL,
  enrollment_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (enrollment_id),
  KEY user_id (user_id),
  KEY course_id (course_id),
  CONSTRAINT enrollments_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
  CONSTRAINT enrollments_ibfk_2 FOREIGN KEY (course_id) REFERENCES courses (course_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table enrollments
--
--ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '195388Eo!.'; işe yaramıyosa
LOCK TABLES enrollments WRITE;
/*!40000 ALTER TABLE enrollments DISABLE KEYS */;
INSERT INTO enrollments VALUES (1,1,1,'2024-11-23 21:00:00'),(2,1,2,'2024-11-23 21:00:00'),(3,1,3,'2024-11-23 21:00:00'),(4,1,4,'2024-11-23 21:00:00'),(5,1,5,'2024-11-23 21:00:00'),(6,1,6,'2024-11-23 21:00:00'),(7,1,7,'2024-11-23 21:00:00'),(8,2,8,'2024-11-23 21:00:00'),(9,2,9,'2024-11-23 21:00:00'),(10,2,10,'2024-11-23 21:00:00'),(11,2,11,'2024-11-23 21:00:00'),(12,2,12,'2024-11-23 21:00:00'),(13,2,13,'2024-11-23 21:00:00'),(14,2,14,'2024-11-23 21:00:00'),(15,3,15,'2024-11-23 21:00:00'),(16,3,16,'2024-11-23 21:00:00'),(17,3,17,'2024-11-23 21:00:00'),(18,3,18,'2024-11-23 21:00:00'),(19,3,19,'2024-11-23 21:00:00'),(20,3,20,'2024-11-23 21:00:00'),(21,3,21,'2024-11-23 21:00:00'),(22,4,22,'2024-11-23 21:00:00'),(23,4,23,'2024-11-23 21:00:00'),(24,4,24,'2024-11-23 21:00:00'),(25,4,25,'2024-11-23 21:00:00'),(26,4,26,'2024-11-23 21:00:00'),(27,4,27,'2024-11-23 21:00:00'),(28,4,28,'2024-11-23 21:00:00'),(29,5,29,'2024-11-23 21:00:00'),(30,5,30,'2024-11-23 21:00:00'),(31,5,31,'2024-11-23 21:00:00'),(32,5,32,'2024-11-23 21:00:00'),(33,5,33,'2024-11-23 21:00:00'),(34,5,34,'2024-11-23 21:00:00'),(35,5,35,'2024-11-23 21:00:00'),(36,50,44,'2024-11-23 21:00:00'),(37,50,45,'2024-11-23 21:00:00'),(38,50,46,'2024-11-23 21:00:00'),(39,50,47,'2024-11-23 21:00:00'),(40,50,48,'2024-11-23 21:00:00'),(41,50,49,'2024-11-23 21:00:00'),(42,50,50,'2024-11-23 21:00:00');
/*!40000 ALTER TABLE enrollments ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table friends
--

DROP TABLE IF EXISTS friends;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE friends (
  friend_id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  friend_user_id int NOT NULL,
  PRIMARY KEY (friend_id),
  KEY user_id (user_id),
  KEY friend_user_id (friend_user_id),
  CONSTRAINT friends_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
  CONSTRAINT friends_ibfk_2 FOREIGN KEY (friend_user_id) REFERENCES users (user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table friends
--

LOCK TABLES friends WRITE;
/*!40000 ALTER TABLE friends DISABLE KEYS */;
INSERT INTO friends (friend_id, user_id, friend_user_id) VALUES
(1, 1, 2), -- User 1 is friends with User 2
(2, 1, 3), -- User 1 is friends with User 3
(3, 2, 4), -- User 2 is friends with User 4
(4, 2, 5), -- User 2 is friends with User 5
(5, 3, 6), -- User 3 is friends with User 6
(6, 4, 7); -- User 4 is friends with User 7
/*!40000 ALTER TABLE friends ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table student_cards
--

DROP TABLE IF EXISTS student_cards;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE student_cards (
  card_id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  balance decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (card_id),
  KEY user_id (user_id),
  CONSTRAINT student_cards_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table student_cards
--

LOCK TABLES student_cards WRITE;
/*!40000 ALTER TABLE student_cards DISABLE KEYS */;
INSERT INTO student_cards VALUES (1,1,400.00),(2,2,154.00),(3,3,230.00),(4,4,186.00),(5,5,141.00),(6,6,450.00),(7,7,123.00),(8,8,368.00),(9,9,170.00),(10,10,449.00),(11,11,432.00),(12,12,311.00),(13,13,159.00),(14,14,166.00),(15,15,252.00),(16,16,262.00),(17,17,453.00),(18,18,178.00),(19,19,234.00),(20,20,135.00),(21,21,274.00),(22,22,463.00),(23,23,191.00),(24,24,268.00),(25,25,267.00),(26,26,430.00),(27,27,447.00),(28,28,444.00),(29,29,381.00),(30,30,475.00),(31,31,327.00),(32,32,113.00),(33,33,286.00),(34,34,191.00),(35,35,395.00),(36,36,102.00),(37,37,430.00),(38,38,137.00),(39,39,100.00),(40,40,391.00),(41,41,352.00),(42,42,488.00),(43,43,482.00),(44,44,445.00),(45,45,281.00),(46,46,368.00),(47,47,499.00),(48,48,488.00),(49,49,443.00),(50,50,253.00);
/*!40000 ALTER TABLE student_cards ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table users
--

DROP TABLE IF EXISTS users;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE users (
  user_id int NOT NULL AUTO_INCREMENT,
  email varchar(100) NOT NULL,
  password_hash varchar(255) NOT NULL,
  name varchar(100) DEFAULT NULL,
  contact_details varchar(255) DEFAULT NULL,
  registration_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id),
  UNIQUE KEY email (email)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table users
--

LOCK TABLES users WRITE;
/*!40000 ALTER TABLE users DISABLE KEYS */;
INSERT INTO users VALUES (1,'admin@etu.edu.tr','hashed_password','Admin','123-456-7890','2024-11-15 21:00:00'),(2,'user2@etu.edu.tr','passwordhash','Mehmet Demir','05023456789','2024-11-23 21:00:00'),(3,'user3@etu.edu.tr','passwordhash','Ayşe Kaya','05034567890','2024-11-23 21:00:00'),(4,'user4@etu.edu.tr','passwordhash','Fatma Şahin','05045678901','2024-11-23 21:00:00'),(5,'user5@etu.edu.tr','passwordhash','Ali Çelik','05056789012','2024-11-23 21:00:00'),(6,'user6@etu.edu.tr','passwordhash','Hüseyin Koç','05067890123','2024-11-23 21:00:00'),(7,'user7@etu.edu.tr','passwordhash','Emine Ak','05078901234','2024-11-23 21:00:00'),(8,'user8@etu.edu.tr','passwordhash','Mustafa Arslan','05089012345','2024-11-23 21:00:00'),(9,'user9@etu.edu.tr','passwordhash','Zeynep Kaplan','05090123456','2024-11-23 21:00:00'),(10,'user10@etu.edu.tr','passwordhash','Kemal Öztürk','05001234567','2024-11-23 21:00:00'),(11,'user11@etu.edu.tr','passwordhash','Halime Yıldız','05011234567','2024-11-23 21:00:00'),(12,'user12@etu.edu.tr','passwordhash','Burak Tan','05021234567','2024-11-23 21:00:00'),(13,'user13@etu.edu.tr','passwordhash','Seda Güler','05031234567','2024-11-23 21:00:00'),(14,'user14@etu.edu.tr','passwordhash','Eren Şen','05041234567','2024-11-23 21:00:00'),(15,'user15@etu.edu.tr','passwordhash','Hale Aydın','05051234567','2024-11-23 21:00:00'),(16,'user16@etu.edu.tr','passwordhash','Sevim Durmaz','05061234567','2024-11-23 21:00:00'),(17,'user17@etu.edu.tr','passwordhash','Onur Bulut','05071234567','2024-11-23 21:00:00'),(18,'user18@etu.edu.tr','passwordhash','Melike Kurt','05081234567','2024-11-23 21:00:00'),(19,'user19@etu.edu.tr','passwordhash','Cem Özkan','05091234567','2024-11-23 21:00:00'),(20,'user20@etu.edu.tr','passwordhash','Leyla Sarı','05022334455','2024-11-23 21:00:00'),(21,'user21@etu.edu.tr','passwordhash','Canan Ünal','05032334455','2024-11-23 21:00:00'),(22,'user22@etu.edu.tr','passwordhash','Koray Pek','05042334455','2024-11-23 21:00:00'),(23,'user23@etu.edu.tr','passwordhash','Rukiye Baş','05052334455','2024-11-23 21:00:00'),(24,'user24@etu.edu.tr','passwordhash','Hasan Er','05062334455','2024-11-23 21:00:00'),(25,'user25@etu.edu.tr','passwordhash','Filiz Ar','05072334455','2024-11-23 21:00:00'),(26,'user26@etu.edu.tr','passwordhash','Okan Dal','05082334455','2024-11-23 21:00:00'),(27,'user27@etu.edu.tr','passwordhash','Berna Çevik','05092334455','2024-11-23 21:00:00'),(28,'user28@etu.edu.tr','passwordhash','Cenk Balcı','05001223344','2024-11-23 21:00:00'),(29,'user29@etu.edu.tr','passwordhash','Pelin Kılıç','05011223344','2024-11-23 21:00:00'),(30,'user30@etu.edu.tr','passwordhash','Ferhat Tunca','05021223344','2024-11-23 21:00:00'),(31,'user31@etu.edu.tr','passwordhash','Serap İnce','05031223344','2024-11-23 21:00:00'),(32,'user32@etu.edu.tr','passwordhash','Bora Erkan','05041223344','2024-11-23 21:00:00'),(33,'user33@etu.edu.tr','passwordhash','Demet Taş','05051223344','2024-11-23 21:00:00'),(34,'user34@etu.edu.tr','passwordhash','Kerem Fidan','05061223344','2024-11-23 21:00:00'),(35,'user35@etu.edu.tr','passwordhash','Büşra Güçlü','05071223344','2024-11-23 21:00:00'),(36,'user36@etu.edu.tr','passwordhash','Arda Zengin','05081223344','2024-11-23 21:00:00'),(37,'user37@etu.edu.tr','passwordhash','Meral Altın','05091223344','2024-11-23 21:00:00'),(38,'user38@etu.edu.tr','passwordhash','Görkem Kara','05011234567','2024-11-23 21:00:00'),(39,'user39@etu.edu.tr','passwordhash','Özlem Çakır','05021234567','2024-11-23 21:00:00'),(40,'user40@etu.edu.tr','passwordhash','İsmail Tok','05031234567','2024-11-23 21:00:00'),(41,'user41@etu.edu.tr','passwordhash','Figen Kaplan','05041234567','2024-11-23 21:00:00'),(42,'user42@etu.edu.tr','passwordhash','Barış Deniz','05051234567','2024-11-23 21:00:00'),(43,'user43@etu.edu.tr','passwordhash','Şule Demet','05061234567','2024-11-23 21:00:00'),(44,'user44@etu.edu.tr','passwordhash','Esra Mutlu','05071234567','2024-11-23 21:00:00'),(45,'user45@etu.edu.tr','passwordhash','Mert Özdemir','05081234567','2024-11-23 21:00:00'),(46,'user46@etu.edu.tr','passwordhash','Selin Çetinkaya','05091234567','2024-11-23 21:00:00'),(47,'user47@etu.edu.tr','passwordhash','Cansu Yaman','05012341234','2024-11-23 21:00:00'),(48,'user48@etu.edu.tr','passwordhash','Gizem Bayrak','05022341234','2024-11-23 21:00:00'),(49,'user49@etu.edu.tr','passwordhash','Cihan Uçar','05032341234','2024-11-23 21:00:00'),(50,'user50@etu.edu.tr','passwordhash','Nalan Gündüz','05042341234','2024-11-23 21:00:00');
/*!40000 ALTER TABLE users ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-25 13:56:13