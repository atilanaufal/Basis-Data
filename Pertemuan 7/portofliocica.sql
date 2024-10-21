-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for portfoliocica
CREATE DATABASE IF NOT EXISTS `portfoliocica` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `portfoliocica`;

-- Dumping structure for table portfoliocica.awards
CREATE TABLE IF NOT EXISTS `awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table portfoliocica.awards: ~3 rows (approximately)
DELETE FROM `awards`;
/*!40000 ALTER TABLE `awards` DISABLE KEYS */;
INSERT INTO `awards` (`id`, `title`, `description`, `image_path`) VALUES
	(1, '1st Winner', '	UI/UX Design on GITHUB 2024', 'foto/github.jpg'),
	(2, '2nd Winner', 'Poster Competition On Jayaverse 2024', 'foto/poster.jpg'),
	(3, '3rd Winner', 'UI/UX Mobile Design Competition On Euformatika-23', 'foto/uiux.jpg');
/*!40000 ALTER TABLE `awards` ENABLE KEYS */;

-- Dumping structure for table portfoliocica.choose
CREATE TABLE IF NOT EXISTS `choose` (
  `title` varchar(50) NOT NULL,
  `desc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table portfoliocica.choose: ~3 rows (approximately)
DELETE FROM `choose`;
/*!40000 ALTER TABLE `choose` DISABLE KEYS */;
INSERT INTO `choose` (`title`, `desc`) VALUES
	('Custom Designs', 'Unique designs crafted to suit your business goals and user needs.'),
	('Responsive Layouts', 'Ensuring perfect functionality and aesthetics on any device.'),
	('User-Centered Approach', 'Designs that prioritize user experience and ease of interaction.');
/*!40000 ALTER TABLE `choose` ENABLE KEYS */;

-- Dumping structure for table portfoliocica.contact
CREATE TABLE IF NOT EXISTS `contact` (
  `id_contact` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `number` int(15) NOT NULL,
  `subject` varchar(30) NOT NULL,
  `message` varchar(200) NOT NULL,
  PRIMARY KEY (`id_contact`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table portfoliocica.contact: ~15 rows (approximately)
DELETE FROM `contact`;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` (`id_contact`, `fullname`, `email`, `number`, `subject`, `message`) VALUES
	(10, 'name', 'aaa@gmail.com', 123, 'subject', 'message'),
	(11, 'name', 'aaa@gmail.com', 123, 'subject', 'message'),
	(12, 'asd', 'anagakenny24@gmail.com', 0, 'asd', '123'),
	(13, 'asd', 'anagakenny24@gmail.com', 0, 'asd', '123'),
	(14, 'asd', 'anagakenny24@gmail.com', 111, 'adasdasdasd', 'tes'),
	(15, 'asd', 'anagakenny24@gmail.com', 111, 'adasdasdasd', 'tes'),
	(16, 'tes1', 'anagakenny24@gmail.com', 0, 'ass', 'adasd'),
	(17, 'tes1', 'anagakenny24@gmail.com', 0, 'ass', 'adasd'),
	(18, 'asd', 'asdad@gmail.com', 0, 'asdas', 'ads'),
	(19, 'asd', 'asdad@gmail.com', 0, 'asdas', 'ads'),
	(20, 'sdsds', 'anagakenny24@gmail.com', 0, 'asd', 'asd'),
	(21, 'asd', 'asdad@gmail.com', 0, 'asdas', 'ads'),
	(22, 'cica', 'cica@gmail.com', 8123, 'tes2', 'tes3'),
	(23, 'tes111', 'anagakenny24@gmail.com', 123213, 'asd', 'asdsadsadsadadsadas'),
	(24, 'aaaaaaa', 'aaa@gmail.com', 123123123, 'bbbbb', 'message');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;

-- Dumping structure for table portfoliocica.experience
CREATE TABLE IF NOT EXISTS `experience` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table portfoliocica.experience: ~4 rows (approximately)
DELETE FROM `experience`;
/*!40000 ALTER TABLE `experience` DISABLE KEYS */;
INSERT INTO `experience` (`id`, `year`, `title`, `description`) VALUES
	(1, '2023', 'High School', 'SMAN 2 CIANJUR, Ilmu Pengetahuan Alam'),
	(2, '2027', 'University', 'Universitas Pembangunan Jaya, majoring informatics, computer science, and robotics.'),
	(3, '2024', 'Internship', 'Product Sourcing Intern - Gao Tek Manhattan, USA.'),
	(4, '2024', 'Internship', 'Editor Video Intern - Cosmeloka');
/*!40000 ALTER TABLE `experience` ENABLE KEYS */;

-- Dumping structure for table portfoliocica.offer
CREATE TABLE IF NOT EXISTS `offer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table portfoliocica.offer: ~3 rows (approximately)
DELETE FROM `offer`;
/*!40000 ALTER TABLE `offer` DISABLE KEYS */;
INSERT INTO `offer` (`id`, `title`, `image_path`) VALUES
	(1, 'Creates Professional Design That\'s Oriented Towards Client Needs', 'foto/project3.jpg'),
	(2, 'Mobile App Design', 'foto/project1.jpg'),
	(3, 'Web Design', 'foto/project2.jpg');
/*!40000 ALTER TABLE `offer` ENABLE KEYS */;

-- Dumping structure for table portfoliocica.projects
CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '0',
  `image_path` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table portfoliocica.projects: ~6 rows (approximately)
DELETE FROM `projects`;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` (`id`, `title`, `description`, `image_path`) VALUES
	(1, 'Graphic Design', 'Lorem ipsum dolor sit amet.', 'foto/merah4.jpg'),
	(2, 'Web Development', 'Lorem ipsum dolor sit amet.', 'foto/merah3.jpg'),
	(3, 'Frontend Development', 'Lorem ipsum dolor sit amet.', 'foto/code.jpg'),
	(4, 'Backend Development', 'Lorem ipsum dolor sit amet.', 'foto/merah2.jpg'),
	(5, 'UI/UX Design', 'Lorem ipsum dolor sit amet.', 'foto/merah1.jpg'),
	(6, 'Mobile App Development', 'Lorem ipsum dolor sit amet.', 'foto/gambarhome&aboutme.jpg');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;

-- Dumping structure for table portfoliocica.service
CREATE TABLE IF NOT EXISTS `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `icon_class` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table portfoliocica.service: ~3 rows (approximately)
DELETE FROM `service`;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` (`id`, `title`, `description`, `icon_class`) VALUES
	(1, 'UI/UX Design', 'Menyediakan layanan desain antarmuka untuk aplikasi mobile dan website, termasuk pembuatan wireframe, mockup, dan prototipe interaktif menggunakan alat seperti Figma. Selain itu, layanan ini mencakup pengujian kegunaan untuk meningkatkan kualitas desain b', 'bx bxs-mobile'),
	(2, '	Frontend Development', 'Menawarkan pengembangan frontend untuk aplikasi web dan mobile, dengan mengonversi desain antarmuka menjadi aplikasi yang berfungsi dengan baik. Layanan ini mencakup implementasi kode berkualitas untuk memastikan pengalaman pengguna yang optimal.', 'bx bx-code-alt'),
	(3, 'Backend Development', 'Memberikan konsultasi desain yang berfokus pada kebutuhan pengguna, termasuk penelitian UX, analisis perilaku pengguna, dan rekomendasi perbaikan untuk meningkatkan pengalaman pengguna pada produk digital.', 'bx bxs-server');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;

-- Dumping structure for table portfoliocica.skills
CREATE TABLE IF NOT EXISTS `skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `icon_class` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table portfoliocica.skills: ~9 rows (approximately)
DELETE FROM `skills`;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
INSERT INTO `skills` (`id`, `name`, `icon_class`) VALUES
	(1, 'UI/UX Design', 'bx bx-palette'),
	(2, 'Web Development', 'bx bx-code-alt'),
	(3, 'Graphic Design', 'bx bx-pen'),
	(4, 'Prototyping', 'bx bx-cube'),
	(5, 'Wireframing', 'bx bx-line-chart'),
	(6, 'User Research', 'bx bx-search-alt'),
	(7, 'HTML/CSS', 'bx bx-code'),
	(8, 'JavaScript', 'bx bxl-javascript'),
	(9, 'Yapping', 'bx bxl-javascript');
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;

-- Dumping structure for table portfoliocica.social
CREATE TABLE IF NOT EXISTS `social` (
  `id_social` int(11) NOT NULL,
  `link` varchar(50) NOT NULL,
  PRIMARY KEY (`id_social`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table portfoliocica.social: ~3 rows (approximately)
DELETE FROM `social`;
/*!40000 ALTER TABLE `social` DISABLE KEYS */;
INSERT INTO `social` (`id_social`, `link`) VALUES
	(0, 'https://github.com/CICAA111'),
	(1, 'https://www.linkedin.com/in/siti-nurcica-3124a8281'),
	(2, 'https://www.instagram.com/cyca_adjudicate_3/');
/*!40000 ALTER TABLE `social` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
