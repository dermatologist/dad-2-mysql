-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 01, 2018 at 07:36 PM
-- Server version: 5.7.21-0ubuntu0.16.04.1
-- PHP Version: 7.0.28-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dad`
--
CREATE DATABASE IF NOT EXISTS `dad` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `dad`;

-- --------------------------------------------------------

--
-- Table structure for table `encounter`
--

CREATE TABLE IF NOT EXISTS `encounter` (
  `encounter_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` int(10) UNSIGNED NOT NULL,
  `morbidity` varchar(45) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL,
  `province` int(11) DEFAULT NULL,
  `inst_from` int(11) DEFAULT NULL,
  `inst_to` int(11) DEFAULT NULL,
  `admit_cat` int(11) DEFAULT NULL,
  `entry_code` int(11) DEFAULT NULL,
  `discharge_disp` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `gestation` int(11) DEFAULT NULL,
  `tlos` int(11) DEFAULT NULL,
  `alos` int(11) DEFAULT NULL,
  `alc_los` int(11) DEFAULT NULL,
  `rel_discharge` int(11) DEFAULT NULL,
  `rel_admission` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=205375 DEFAULT CHARSET=utf8 COMMENT='Encounter Table';

-- --------------------------------------------------------

--
-- Table structure for table `intervention`
--

CREATE TABLE IF NOT EXISTS `intervention` (
  `intervention_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cci_code` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `anaesthetic` int(11) DEFAULT NULL,
  `encounter_encounter_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`intervention_id`),
  KEY `fk_intervention_encounter1_idx` (`encounter_encounter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=261984 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `morbidity`
--

CREATE TABLE IF NOT EXISTS `morbidity` (
  `morbidity_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `icd_10_ca` varchar(45) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `encounter_encounter_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`morbidity_id`),
  KEY `fk_morbidity_encounter1_idx` (`encounter_encounter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=497917 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `speciality`
--

CREATE TABLE IF NOT EXISTS `speciality` (
  `speciality_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `encounter_encounter_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`speciality_id`),
  KEY `fk_speciality_encounter1_idx` (`encounter_encounter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `special_care`
--

CREATE TABLE IF NOT EXISTS `special_care` (
  `special_care_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `unit` int(11) DEFAULT NULL,
  `hours` int(11) DEFAULT NULL,
  `encounter_encounter_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`special_care_id`),
  KEY `fk_special_care_encounter1_idx` (`encounter_encounter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27639 DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `intervention`
--
ALTER TABLE `intervention`
  ADD CONSTRAINT `fk_intervention_encounter1` FOREIGN KEY (`encounter_encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `morbidity`
--
ALTER TABLE `morbidity`
  ADD CONSTRAINT `fk_morbidity_encounter1` FOREIGN KEY (`encounter_encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `speciality`
--
ALTER TABLE `speciality`
  ADD CONSTRAINT `fk_speciality_encounter1` FOREIGN KEY (`encounter_encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `special_care`
--
ALTER TABLE `special_care`
  ADD CONSTRAINT `fk_special_care_encounter1` FOREIGN KEY (`encounter_encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
