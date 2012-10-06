-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1:3306

-- Generation Time: Oct 05, 2012 at 07:45 AM
-- Server version: 5.5.28
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Dumping data for table `m_types`
--

INSERT INTO `m_types` (`id`, `type`, `extension`, `created`, `modified`) VALUES
(1, 'audio/aiff', 'aif', NOW(), NOW()),
(2, 'audio/aiff', 'aifc', NOW(), NOW()),
(3, 'audio/aiff', 'aiff', NOW(), NOW()),
(4, 'audio/mpeg', 'mp3', NOW(), NOW()),
(5, 'audio/ogg', 'ogg', NOW(), NOW()),
(6, 'audio/wav', 'wav', NOW(), NOW()),
(7, 'audio/x-flac', 'flac', NOW(), NOW()),
(8, 'audio/aac', 'm4a', NOW(), NOW()),
(9, 'audio/aac', 'aac', NOW(), NOW()),
(10, 'audio/aac', '3gp', NOW(), NOW()),
(11, 'audio/basic', 'au', NOW(), NOW()),
(12, 'audio/x-ms-wma', 'wma', NOW(), NOW()),
(13, 'audio/x-monkeys-audio', 'ape', NOW(), NOW());

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
