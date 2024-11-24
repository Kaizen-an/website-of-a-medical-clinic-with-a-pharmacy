-- --------------------------------------------------------
-- Сервер:                       127.0.0.1
-- Версія сервера:               8.0.34 - MySQL Community Server - GPL
-- ОС сервера:                   Win64
-- HeidiSQL Версія:              12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for medical_clinic_database
CREATE DATABASE IF NOT EXISTS `medical_clinic_database` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `medical_clinic_database`;

-- Dumping structure for таблиця medical_clinic_database.appointmentregistration
CREATE TABLE IF NOT EXISTS `appointmentregistration` (
  `AppointmentID` int NOT NULL AUTO_INCREMENT,
  `AppointmentDate` date NOT NULL,
  `DoctorID` int DEFAULT NULL,
  `PatientID` int DEFAULT NULL,
  PRIMARY KEY (`AppointmentID`),
  KEY `DoctorID` (`DoctorID`),
  KEY `PatientID` (`PatientID`),
  CONSTRAINT `appointmentregistration_ibfk_1` FOREIGN KEY (`DoctorID`) REFERENCES `doctors` (`DoctorID`),
  CONSTRAINT `appointmentregistration_ibfk_2` FOREIGN KEY (`PatientID`) REFERENCES `patients` (`patientID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table medical_clinic_database.appointmentregistration: ~30 rows (приблизно)
DELETE FROM `appointmentregistration`;
INSERT INTO `appointmentregistration` (`AppointmentID`, `AppointmentDate`, `DoctorID`, `PatientID`) VALUES
	(1, '2023-01-10', 1, 1),
	(2, '2023-02-15', 2, 2),
	(3, '2023-03-20', 3, 3),
	(4, '2023-04-25', 4, 4),
	(5, '2023-05-30', 5, 5),
	(6, '2023-06-05', 6, 6),
	(7, '2023-07-10', 7, 7),
	(8, '2023-08-15', 8, 8),
	(9, '2023-09-20', 9, 9),
	(10, '2023-10-25', 10, 10),
	(11, '2023-11-30', 11, 11),
	(12, '2023-12-05', 12, 12),
	(13, '2023-01-10', 13, 13),
	(14, '2023-02-15', 14, 14),
	(15, '2023-03-20', 15, 15),
	(16, '2023-04-25', 16, 16),
	(17, '2023-05-30', 2, 17),
	(18, '2023-06-05', 3, 18),
	(19, '2023-07-10', 4, 19),
	(20, '2023-08-15', 5, 20),
	(21, '2023-09-20', 6, 21),
	(22, '2023-10-25', 7, 22),
	(23, '2023-11-30', 8, 23),
	(24, '2023-12-05', 9, 24),
	(25, '2023-01-10', 10, 25),
	(26, '2023-02-15', 11, 26),
	(27, '2023-03-20', 12, 27),
	(28, '2023-04-25', 13, 28),
	(29, '2023-05-30', 14, 29),
	(30, '2023-06-05', 15, 30);

-- Dumping structure for таблиця medical_clinic_database.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table medical_clinic_database.categories: ~13 rows (приблизно)
DELETE FROM `categories`;
INSERT INTO `categories` (`id`, `name`) VALUES
	(1, 'Антибіотики'),
	(2, 'Вітаміни'),
	(3, 'Знеболюючі'),
	(4, 'Противірусні'),
	(5, 'Протиалергічні'),
	(6, 'Заспокійливі'),
	(7, 'Антациди'),
	(8, 'Препарати для діабету'),
	(9, 'Антигіпертензивні'),
	(10, 'Діуретики'),
	(11, 'Препарати для лікування артриту'),
	(12, 'Гемостатичні засоби'),
	(13, 'Гормональні препарати');

-- Dumping structure for процедура medical_clinic_database.DeleteMedicalRecord
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteMedicalRecord`(
    IN record_id INT
)
BEGIN
    DELETE FROM MedicalRecords
    WHERE RecordID = record_id;
END//
DELIMITER ;

-- Dumping structure for процедура medical_clinic_database.DeletePatientRecords
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePatientRecords`(IN patientID INT)
BEGIN
    DELETE FROM Finances WHERE PatientID = patientID;
    DELETE FROM MedicalRecords WHERE PatientID = patientID;
    DELETE FROM Patients WHERE PatientID = patientID;
END//
DELIMITER ;

-- Dumping structure for таблиця medical_clinic_database.doctors
CREATE TABLE IF NOT EXISTS `doctors` (
  `DoctorID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Specialization` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DoctorID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table medical_clinic_database.doctors: ~16 rows (приблизно)
DELETE FROM `doctors`;
INSERT INTO `doctors` (`DoctorID`, `FirstName`, `LastName`, `Specialization`) VALUES
	(1, 'Іван', 'Петров', 'Терапевт'),
	(2, 'Марія', 'Ковальчук', 'Лікар з педіатрії'),
	(3, 'Олег', 'Сидоренко', 'Кардіолог'),
	(4, 'Ірина', 'Коваленко', 'Офтальмолог'),
	(5, 'Василь', 'Лисенко', 'Невролог'),
	(6, 'Тетяна', 'Павлова', 'Лікар загальної практики'),
	(7, 'Олександр', 'Григоренко', 'Хірург'),
	(8, 'Марина', 'Макаренко', 'Лікар-терапевт'),
	(9, 'Вікторія', 'Іваненко', 'Дерматолог'),
	(10, 'Андрій', 'Козлов', 'Психіатр'),
	(11, 'Ольга', 'Ткаченко', 'Ендокринолог'),
	(12, 'Євген', 'Семененко', 'Лікар-фізіотерапевт'),
	(13, 'Маргарита', 'Василенко', 'Лікар з неврології'),
	(14, 'Павло', 'Павленко', 'Кардіохірург'),
	(15, 'Наталія', 'Кучеренко', 'Лікар-стоматолог'),
	(16, 'Ігор', 'Литвиненко', 'Лікар з гастроентерології');

-- Dumping structure for таблиця medical_clinic_database.finances
CREATE TABLE IF NOT EXISTS `finances` (
  `TransactionID` int NOT NULL AUTO_INCREMENT,
  `TransactionDate` date NOT NULL,
  `TransactionAmount` decimal(10,2) NOT NULL,
  `PatientID` int DEFAULT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `PatientID` (`PatientID`),
  CONSTRAINT `finances_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patients` (`patientID`),
  CONSTRAINT `finances_chk_1` CHECK ((`TransactionAmount` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table medical_clinic_database.finances: ~22 rows (приблизно)
DELETE FROM `finances`;
INSERT INTO `finances` (`TransactionID`, `TransactionDate`, `TransactionAmount`, `PatientID`) VALUES
	(6, '2023-06-11', 2000.00, 6),
	(7, '2023-07-13', 1650.00, 7),
	(8, '2023-08-15', 850.50, 8),
	(9, '2023-09-17', 1700.25, 9),
	(11, '2023-11-21', 2100.00, 11),
	(12, '2023-12-23', 1900.50, 12),
	(13, '2023-01-25', 1250.00, 13),
	(14, '2023-02-27', 800.75, 14),
	(15, '2023-03-29', 1750.50, 15),
	(16, '2023-04-30', 1320.25, 16),
	(17, '2023-06-01', 1600.00, 17),
	(18, '2023-07-03', 1450.50, 18),
	(20, '2023-09-07', 1200.00, 20),
	(21, '2023-10-09', 1850.25, 21),
	(22, '2023-11-11', 1500.75, 22),
	(23, '2023-12-13', 2200.00, 23),
	(24, '2023-01-15', 1400.50, 24),
	(25, '2023-02-17', 950.25, 25),
	(27, '2023-04-21', 1300.50, 27),
	(28, '2023-05-23', 1650.25, 28),
	(30, '2023-07-27', 1150.50, 30);

-- Dumping structure for процедура medical_clinic_database.GetPatientsByDoctor
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientsByDoctor`(IN docID INT)
BEGIN
    SELECT Patients.*
    FROM Patients
    INNER JOIN AppointmentRegistration ON Patients.PatientID = AppointmentRegistration.PatientID
    WHERE AppointmentRegistration.DoctorID = docID;
END//
DELIMITER ;

-- Dumping structure for функція medical_clinic_database.GetPatientTransactionCount
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `GetPatientTransactionCount`(patient_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE transaction_count INT;

    SELECT COUNT(*)
    INTO transaction_count
    FROM Finances
    WHERE PatientID = patient_id;

    RETURN transaction_count;
END//
DELIMITER ;

-- Dumping structure for процедура medical_clinic_database.GetTotalExpensesForPatient
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTotalExpensesForPatient`(IN patientID INT, OUT totalExpenses DECIMAL(10, 2))
BEGIN
    SELECT SUM(TransactionAmount)
    INTO totalExpenses
    FROM Finances
    WHERE PatientID = patientID;
END//
DELIMITER ;

-- Dumping structure for таблиця medical_clinic_database.medicalrecords
CREATE TABLE IF NOT EXISTS `medicalrecords` (
  `RecordID` int NOT NULL AUTO_INCREMENT,
  `Diagnosis` text,
  `Prescription` text,
  `AppointmentDate` date DEFAULT NULL,
  `PatientID` int DEFAULT NULL,
  PRIMARY KEY (`RecordID`),
  KEY `PatientID` (`PatientID`),
  CONSTRAINT `medicalrecords_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patients` (`patientID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table medical_clinic_database.medicalrecords: ~30 rows (приблизно)
DELETE FROM `medicalrecords`;
INSERT INTO `medicalrecords` (`RecordID`, `Diagnosis`, `Prescription`, `AppointmentDate`, `PatientID`) VALUES
	(1, 'Грип', 'Парацетамол', '2023-01-05', 1),
	(2, 'Зламана нога', 'Гіпс', '2023-02-12', 2),
	(3, 'Ангіна', 'Антибіотики', '2023-03-20', 3),
	(4, 'Головний біль', 'Масаж', '2023-04-08', 4),
	(5, 'Алергія', 'Антигістаміни', '2023-05-17', 5),
	(6, 'Травма руки', 'Фіксатор', '2023-06-22', 6),
	(7, 'Захворювання серця', 'Бета-блокатори', '2023-07-30', 7),
	(8, 'Грип', 'Відпочинок', '2023-08-04', 8),
	(9, 'Пневмонія', 'Антибіотики', '2023-09-11', 9),
	(10, 'Алергічний кашель', 'Експекторанти', '2023-10-19', 10),
	(11, 'Захворювання шлунку', 'Гастропротектори', '2023-11-25', 11),
	(12, 'Зламана рука', 'Гіпс', '2023-12-03', 12),
	(13, 'Мігрень', 'Анальгетики', '2023-01-18', 13),
	(14, 'Грип', 'Відпочинок', '2023-02-28', 14),
	(15, 'Захворювання нирок', 'Діуретики', '2023-03-07', 15),
	(16, 'Головний біль', 'Масаж', '2023-04-14', 16),
	(17, 'Стоматит', 'Антисептики', '2023-05-22', 17),
	(18, 'Захворювання шлунку', 'Гастропротектори', '2023-06-29', 18),
	(19, 'Зламана нога', 'Гіпс', '2023-07-06', 19),
	(20, 'Грип', 'Парацетамол', '2023-08-13', 20),
	(21, 'Грип', 'Відпочинок', '2023-09-21', 21),
	(22, 'Пневмонія', 'Антибіотики', '2023-10-28', 22),
	(23, 'Ангіна', 'Антибіотики', '2023-11-04', 23),
	(24, 'Головний біль', 'Масаж', '2023-12-12', 24),
	(25, 'Захворювання серця', 'Бета-блокатори', '2023-01-30', 25),
	(26, 'Алергічний кашель', 'Експекторанти', '2023-02-06', 26),
	(27, 'Зламана рука', 'Гіпс', '2023-03-15', 27),
	(28, 'Мігрень', 'Анальгетики', '2023-04-23', 28),
	(29, 'Захворювання нирок', 'Діуретики', '2023-05-30', 29),
	(30, 'Стоматит', 'Антисептики', '2023-06-07', 30);

-- Dumping structure for таблиця medical_clinic_database.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `customer_surname` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table medical_clinic_database.orders: ~4 rows (приблизно)
DELETE FROM `orders`;
INSERT INTO `orders` (`id`, `customer_name`, `customer_surname`, `phone`, `email`, `order_date`, `total_amount`, `status`) VALUES
	(16, 'аафіацуац', 'афіааоуаоу', '094342348923', 'asdwqdq@fkef.com', '2024-11-19 01:21:21', 15.00, 'Pending'),
	(17, 'ewqwef', 'fda', '0902492412', 'efqwefwffqwdq@fkef.com', '2024-11-19 01:24:08', 75.00, 'Pending'),
	(18, 'ауцайцаві', 'иццицицци', '56789', 'flwkflkwlf@fkef.com', '2024-11-19 02:09:18', 25.00, 'Pending'),
	(19, 'fdjlkdfkdfkljdfldf', 'vczkveve', '980958324958023', 'gegewgsnvnkwerge@fkeflwekfw.com', '2024-11-19 12:23:32', 100.00, 'Pending');

-- Dumping structure for таблиця medical_clinic_database.order_items
CREATE TABLE IF NOT EXISTS `order_items` (
  `order_id` int NOT NULL,
  `medicine_id` int NOT NULL,
  `quantity` int NOT NULL,
  KEY `order_id` (`order_id`),
  KEY `medicine_id` (`medicine_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`medicine_id`) REFERENCES `pharmacy` (`MedicineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table medical_clinic_database.order_items: ~5 rows (приблизно)
DELETE FROM `order_items`;
INSERT INTO `order_items` (`order_id`, `medicine_id`, `quantity`) VALUES
	(16, 9, 1),
	(17, 4, 1),
	(17, 2, 1),
	(18, 2, 1),
	(19, 1, 5);

-- Dumping structure for таблиця medical_clinic_database.patients
CREATE TABLE IF NOT EXISTS `patients` (
  `patientID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  PRIMARY KEY (`patientID`) USING BTREE,
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table medical_clinic_database.patients: ~42 rows (приблизно)
DELETE FROM `patients`;
INSERT INTO `patients` (`patientID`, `FirstName`, `LastName`, `Email`) VALUES
	(1, 'Олексій', 'Петров', 'oleksii@gmail.com'),
	(2, 'Ірина', 'Ковальчук', 'iryna123@gmail.com'),
	(3, 'Олена', 'Сидоренко', 'sidorenko_o@gmail.com'),
	(4, 'Петро', 'Коваленко', 'petro_kovalenko@gmail.com'),
	(5, 'Наталія', 'Лисенко', 'nataliia.l@gmail.com'),
	(6, 'Віктор', 'Павлов', 'vpavlov@gmail.com'),
	(7, 'Марія', 'Григоренко', 'm.grigorenko@gmail.com'),
	(8, 'Андрій', 'Макаренко', 'andrii.mak@gmail.com'),
	(9, 'Катерина', 'Іваненко', 'katya_ivanenko@gmail.com'),
	(10, 'Олександра', 'Козлова', 'sasha.kozlova@gmail.com'),
	(11, 'Михайло', 'Ткаченко', 'm.tka4enko@gmail.com'),
	(12, 'Анна', 'Семененко', 'annasemen@gmail.com'),
	(13, 'Олег', 'Василенко', 'vas_oleg@gmail.com'),
	(14, 'Тетяна', 'Павленко', 'pavlenko.t@gmail.com'),
	(15, 'Дмитро', 'Кучеренко', 'dima.kucher@gmail.com'),
	(16, 'Євгенія', 'Литвиненко', 'yevhenia.lit@gmail.com'),
	(17, 'Валентин', 'Кравченко', 'valentin.krav@gmail.com'),
	(18, 'Марина', 'Мельник', 'mari.melnik@gmail.com'),
	(19, 'Роман', 'Савченко', 'roman.savch@gmail.com'),
	(20, 'Ігор', 'Попов', 'popov.igor@gmail.com'),
	(21, 'Світлана', 'Петренко', 's.petrenko@gmail.com'),
	(22, 'Аліна', 'Гриценко', 'alina_grits@gmail.com'),
	(23, 'Сергій', 'Даниленко', 'serhii_dan@gmail.com'),
	(24, 'Юлія', 'Бондаренко', 'julia_bond@gmail.com'),
	(25, 'Віталій', 'Кузьменко', 'vitalii.kuzm@gmail.com'),
	(26, 'Іван', 'Морозенко', 'ivan.mor@gmail.com'),
	(27, 'Маргарита', 'Шевченко', 'margo.shev@gmail.com'),
	(28, 'Григорій', 'Луценко', 'grygory_luc@gmail.com'),
	(29, 'Лариса', 'Федоренко', 'larisa.fed@gmail.com'),
	(30, 'Денис', 'Біленький', 'denis.bilenko@gmail.com'),
	(31, 'Артем', 'dsada', 'dwqdqdasd@gmail.com'),
	(32, 'dkqwd', 'feqfq', 'nfefqkfewqem@gmail.com'),
	(33, 'feqwf', 'fewqf', 'afwfw@g,aifewf'),
	(34, 'а3а3', 'ауцай', 'ацйацу@fewqf'),
	(36, 'ceafada', 'fwqfa', 'dwqdqwd@dfwqwd'),
	(37, 'Авіфауц', 'ауцйа', 'ауцйа@ауцоац'),
	(38, 'fwfefa', 'fewqfwe', 'fsdafsfaef@fsifjwe'),
	(39, 'ауауцуца', 'авіфа', 'аіауц@dkwofkw'),
	(40, 'ауцауц', 'ауцацуа', 'ауцацу@fewfwf'),
	(41, 'Артем', 'аіаіацу', 'asdwqdq@fkef.com'),
	(42, '', '', ''),
	(45, 'цввйв', 'чмсчмссмч', 'алфоатьсятм@flewkfw');

-- Dumping structure for таблиця medical_clinic_database.pharmacy
CREATE TABLE IF NOT EXISTS `pharmacy` (
  `MedicineID` int NOT NULL AUTO_INCREMENT,
  `MedicineName` varchar(100) NOT NULL,
  `RecordID` int DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `description` text,
  `composition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `category_id` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `ingredients` text,
  PRIMARY KEY (`MedicineID`),
  KEY `RecordID` (`RecordID`),
  KEY `idx_pharmacy_name` (`MedicineName`),
  KEY `idx_pharmacy_composition` (`composition`(255)),
  KEY `idx_pharmacy_category_id` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pharmacy_ibfk_1` FOREIGN KEY (`RecordID`) REFERENCES `medicalrecords` (`RecordID`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table medical_clinic_database.pharmacy: ~33 rows (приблизно)
DELETE FROM `pharmacy`;
INSERT INTO `pharmacy` (`MedicineID`, `MedicineName`, `RecordID`, `photo`, `description`, `composition`, `category_id`, `price`, `ingredients`) VALUES
	(1, 'Аспірин', 1, '/static/images/aspirin.jpg', 'Знеболювальний та жарознижувальний засіб', 'Ацетилсаліцилова кислота 500 мг', 3, 20.00, 'Ацетилсаліцилова кислота, допоміжні речовини'),
	(2, 'Ібупрофен', 2, '/static/images/ibuprofen.jpg', 'Знеболюючий та протизапальний засіб', 'Ібупрофен 200 мг', 3, 25.00, 'Ібупрофен, целюлоза'),
	(3, 'Парацетамол', 3, '/static/images/paracetamol.jpg', 'Знеболюючий та жарознижувальний засіб', 'Парацетамол 500 мг', 3, 15.00, 'Парацетамол, крохмаль'),
	(4, 'Амоксицилін', 4, '/static/images/amoxicillin.jpg', 'Антибіотик широкого спектра дії', 'Амоксицилін 500 мг', 1, 50.00, 'Амоксицилін, крохмаль'),
	(5, 'Діазепам', 5, '/static/images/diazepam.jpg', 'Заспокійливий засіб', 'Діазепам 5 мг', 6, 35.00, 'Діазепам, лактоза'),
	(6, 'Левофлоксацин', 6, '/static/images/levofloxacin.jpg', 'Антибіотик для лікування інфекцій', 'Левофлоксацин 500 мг', 1, 60.00, 'Левофлоксацин, допоміжні речовини'),
	(7, 'Лоратадин', 7, '/static/images/loratadine.jpg', 'Антигістамінний препарат', 'Лоратадин 10 мг', 5, 20.00, 'Лоратадин, допоміжні речовини'),
	(8, 'Цефтриаксон', 8, '/static/images/ceftriaxone.jpg', 'Антибіотик для ін\'єкцій', 'Цефтриаксон 1 г', 1, 80.00, 'Цефтриаксон, натрію хлорид'),
	(9, 'Фенілеприна', 9, '/static/images/phenylephrine.jpg', 'Засіб від закладеності носа', 'Фенілеприна гідрохлорид', 4, 15.00, 'Фенілеприна, допоміжні речовини'),
	(10, 'Ранітідин', 10, '/static/images/ranitidine.jpg', 'Засіб для зменшення кислотності шлунка', 'Ранітідин 150 мг', 7, 25.00, 'Ранітідин, крохмаль'),
	(11, 'Азитроміцин', 11, '/static/images/azithromycin.jpg', 'Антибіотик для лікування бактеріальних інфекцій', 'Азитроміцин 500 мг', 1, 70.00, 'Азитроміцин, крохмаль'),
	(12, 'Омепразол', 12, '/static/images/omeprazole.jpg', 'Препарат для лікування шлункових захворювань', 'Омепразол 20 мг', 7, 30.00, 'Омепразол, допоміжні речовини'),
	(13, 'Флуоксетин', 13, '/static/images/fluoxetine.jpg', 'Антидепресант', 'Флуоксетин 20 мг', 6, 40.00, 'Флуоксетин, лактоза'),
	(14, 'Метформін', 14, '/static/images/metformin.jpg', 'Препарат для лікування діабету', 'Метформін 500 мг', 8, 35.00, 'Метформін, допоміжні речовини'),
	(15, 'Ацетилцистеїн', 15, '/static/images/acetylcysteine.jpg', 'Засіб від кашлю', 'Ацетилцистеїн 200 мг', 4, 25.00, 'Ацетилцистеїн, допоміжні речовини'),
	(16, 'Нітрогліцерин', 16, '/static/images/nitroglycerin.jpg', 'Судинорозширювальний засіб', 'Нітрогліцерин 0.5 мг', 9, 50.00, 'Нітрогліцерин, допоміжні речовини'),
	(17, 'Каптоприл', 17, '/static/images/captopril.jpg', 'Засіб для зниження тиску', 'Каптоприл 25 мг', 9, 15.00, 'Каптоприл, допоміжні речовини'),
	(18, 'Флебодіа', 18, '/static/images/phlebodia.jpg', 'Венотонік', 'Діосмін 600 мг', 10, 80.00, 'Діосмін, допоміжні речовини'),
	(19, 'Атенолол', 19, '/static/images/atenolol.jpg', 'Бета-блокатор', 'Атенолол 50 мг', 9, 30.00, 'Атенолол, допоміжні речовини'),
	(20, 'Лозап', 20, '/static/images/lozap.jpg', 'Засіб для лікування гіпертонії', 'Лозартан 50 мг', 9, 45.00, 'Лозартан, допоміжні речовини'),
	(21, 'Фуросемід', 21, '/static/images/furosemide.jpg', 'Діуретик', 'Фуросемід 40 мг', 10, 20.00, 'Фуросемід, допоміжні речовини'),
	(22, 'Лоранжепам', 22, '/static/images/lorazepam.jpg', 'Заспокійливий засіб', 'Лоранжепам 1 мг', 6, 55.00, 'Лоранжепам, лактоза'),
	(23, 'Сироп від кашлю', 23, '/static/images/cough_syrup.jpg', 'Засіб від кашлю', 'Різні рослинні екстракти', 4, 25.00, 'Рослинні екстракти, мед'),
	(24, 'Метронідазол', 24, '/static/images/metronidazole.jpg', 'Антибіотик для лікування інфекцій', 'Метронідазол 250 мг', 1, 30.00, 'Метронідазол, допоміжні речовини'),
	(25, 'Сульфасалазин', 25, '/static/images/sulfasalazine.jpg', 'Препарат для лікування ревматоїдного артриту', 'Сульфасалазин 500 мг', 11, 65.00, 'Сульфасалазин, допоміжні речовини'),
	(26, 'Гемостатичний спонж', 26, '/static/images/hemostatic_sponge.jpg', 'Зупинка кровотечі', 'Гемостатичні речовини', 12, 40.00, 'Колаген, гемостатичні речовини'),
	(27, 'Інсулін', 27, '/static/images/insulin.jpg', 'Препарат для лікування діабету', 'Інсулін 100 IU', 8, 90.00, 'Інсулін, допоміжні речовини'),
	(28, 'Тироксин', 28, '/static/images/thyroxine.jpg', 'Гормональний препарат', 'Тироксин 50 мкг', 13, 75.00, 'Тироксин, допоміжні речовини'),
	(29, 'Нівестон', 29, '/static/images/nyveston.jpg', 'Гормональний засіб', 'Нівестон 2 мг', 13, 80.00, 'Нівестон, лактоза'),
	(30, 'Триметазидин', 30, '/static/images/trimetazidine.jpg', 'Засіб для лікування ішемії', 'Триметазидин 35 мг', 9, 50.00, 'Триметазидин, допоміжні речовини'),
	(43, 'Амоксицилін', 5, '/static/images/amoxicillin.jpg', 'Антибіотик для лікування інфекцій', 'Амоксицилін 500 мг', 1, 50.00, 'Амоксицилін, крохмаль'),
	(44, 'Вітамін C', 1, '/static/images/vitamin_c.jpg', 'Для підвищення імунітету', 'Аскорбінова кислота 500 мг', 2, 30.00, 'Аскорбінова кислота, глюкоза'),
	(45, 'Ібупрофен', 8, '/static/images/ibuprofen.jpg', 'Знеболюючий засіб', 'Ібупрофен 200 мг', 3, 25.00, 'Ібупрофен, целюлоза');

-- Dumping structure for тригер medical_clinic_database.CreateFinanceRecordOnMedicalRecordInsert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE DEFINER=`root`@`localhost` TRIGGER `CreateFinanceRecordOnMedicalRecordInsert` AFTER INSERT ON `medicalrecords` FOR EACH ROW BEGIN
    INSERT INTO Finances (TransactionDate, TransactionAmount, PatientID)
    VALUES (NEW.AppointmentDate, 0, NEW.PatientID);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for тригер medical_clinic_database.DeleteFinancesOnPatientDelete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE DEFINER=`root`@`localhost` TRIGGER `DeleteFinancesOnPatientDelete` AFTER DELETE ON `patients` FOR EACH ROW BEGIN
    DELETE FROM Finances WHERE PatientID = OLD.PatientID;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
