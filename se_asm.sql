-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2022 at 10:47 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `se_asm2`
--

-- --------------------------------------------------------

--
-- Table structure for table `assign_vehicle`
--

CREATE TABLE `assign_vehicle` (
  `emp_username` varchar(50) NOT NULL,
  `vehicle_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assign_vehicle`
--

INSERT INTO `assign_vehicle` (`emp_username`, `vehicle_id`) VALUES
('congthanh', '1001'),
('duongnghia', '2002'),
('hoainam', '2001'),
('huypham', '1003'),
('khanhhung', '1002'),
('luong', '2005'),
('trantien', '1004');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT '123',
  `name` varchar(50) DEFAULT NULL,
  `role` enum('janitor','collector') DEFAULT NULL,
  `status` enum('free','in_work') NOT NULL DEFAULT 'free',
  `email` varchar(50) DEFAULT NULL,
  `phone_num` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`username`, `password`, `name`, `role`, `status`, `email`, `phone_num`) VALUES
('congthanh', '123', 'Truong Cong Thanh', 'collector', 'in_work', 'thanhcong@gmail.com', 90126),
('duongnghia', '123', 'Duong Duc Nghia', 'janitor', 'free', 'nghia@gmail.com', 90120),
('hoainam', '123', 'Nguyen Hoai Nam', 'janitor', 'in_work', 'nam@gmail.com', 90323),
('huypham', '123', 'Pham Viet Huy', 'collector', 'free', 'huypham@gmail.com', 90103),
('khanhhung', '123', 'Nguyen Khanh Hung', 'collector', 'free', 'khanhhung@gmail.com', 90123),
('luong', '123', 'Hoang Luong', 'janitor', 'free', 'luonghoang@gmail.com', 90127),
('trantien', '123', 'Tran Tien', 'collector', 'in_work', 'tien@gmail.com', 90163);

-- --------------------------------------------------------

--
-- Table structure for table `mcp`
--

CREATE TABLE `mcp` (
  `id` int(11) NOT NULL,
  `capacity` int(10) DEFAULT NULL,
  `current` int(10) NOT NULL,
  `status` enum('full','available') DEFAULT 'available',
  `location` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcp`
--

INSERT INTO `mcp` (`id`, `capacity`, `current`, `status`, `location`) VALUES
(9001, 100, 75, 'available', 'KTX DHQG TPHCM'),
(9002, 120, 110, 'full', 'Dai hoc Bach khoa TPHCM'),
(9003, 80, 75, 'full', 'Suoi Tien'),
(9004, 100, 20, 'available', 'Dai hoc SPKT TPHCM'),
(9005, 150, 10, 'available', 'Dam Sen');

-- --------------------------------------------------------

--
-- Table structure for table `task_collector`
--

CREATE TABLE `task_collector` (
  `id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT addtime(curtime(),'1:0:0'),
  `emp_username` varchar(50) DEFAULT NULL,
  `mcp_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `task_collector`
--

INSERT INTO `task_collector` (`id`, `description`, `time`, `emp_username`, `mcp_id`) VALUES
(10001, 'MCP day', '2022-12-07 10:00:00', 'khanhhung', 9002),
(10002, 'MCP day', '2022-12-07 19:00:00', 'huypham', 9003);

-- --------------------------------------------------------

--
-- Table structure for table `task_janitor`
--

CREATE TABLE `task_janitor` (
  `id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT addtime(curtime(),'1:0:0'),
  `emp_username` varchar(50) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `task_janitor`
--

INSERT INTO `task_janitor` (`id`, `description`, `time`, `emp_username`, `area`) VALUES
(20001, 'Thu gom rac', '2022-12-07 16:00:00', 'hoainam', 'Suoi Tien'),
(20002, 'Thu gom rac', '2022-12-07 17:30:00', 'luong', 'Dai hoc Bach khoa TPHCM');

-- --------------------------------------------------------

--
-- Table structure for table `troller`
--

CREATE TABLE `troller` (
  `troller_id` varchar(50) NOT NULL,
  `area` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `troller`
--

INSERT INTO `troller` (`troller_id`, `area`) VALUES
('2001', 'Quan Thu Duc'),
('2002', 'Quan 2'),
('2003', 'Quan 9'),
('2004', 'Quan 1'),
('2005', 'Quan 10');

-- --------------------------------------------------------

--
-- Table structure for table `truck`
--

CREATE TABLE `truck` (
  `truck_id` varchar(50) NOT NULL,
  `fuel` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `truck`
--

INSERT INTO `truck` (`truck_id`, `fuel`) VALUES
('1001', 80),
('1002', 70),
('1003', 70),
('1004', 85);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `id` varchar(50) NOT NULL,
  `type` enum('truck','troller') DEFAULT NULL,
  `status` enum('in_use','free') DEFAULT 'free'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`id`, `type`, `status`) VALUES
('1001', 'truck', 'in_use'),
('1002', 'truck', 'free'),
('1003', 'truck', 'in_use'),
('1004', 'truck', 'free'),
('2001', 'troller', 'free'),
('2002', 'troller', 'in_use'),
('2003', 'troller', 'in_use'),
('2004', 'troller', 'in_use'),
('2005', 'troller', 'free');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assign_vehicle`
--
ALTER TABLE `assign_vehicle`
  ADD PRIMARY KEY (`emp_username`,`vehicle_id`),
  ADD KEY `vehicle_id` (`vehicle_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `mcp`
--
ALTER TABLE `mcp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task_collector`
--
ALTER TABLE `task_collector`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emp_username` (`emp_username`),
  ADD KEY `mcp_id` (`mcp_id`);

--
-- Indexes for table `task_janitor`
--
ALTER TABLE `task_janitor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emp_username` (`emp_username`);

--
-- Indexes for table `troller`
--
ALTER TABLE `troller`
  ADD PRIMARY KEY (`troller_id`);

--
-- Indexes for table `truck`
--
ALTER TABLE `truck`
  ADD PRIMARY KEY (`truck_id`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `mcp`
--
ALTER TABLE `mcp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9006;

--
-- AUTO_INCREMENT for table `task_collector`
--
ALTER TABLE `task_collector`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10003;

--
-- AUTO_INCREMENT for table `task_janitor`
--
ALTER TABLE `task_janitor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20003;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assign_vehicle`
--
ALTER TABLE `assign_vehicle`
  ADD CONSTRAINT `assign_vehicle_ibfk_1` FOREIGN KEY (`emp_username`) REFERENCES `employee` (`username`),
  ADD CONSTRAINT `assign_vehicle_ibfk_2` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`);

--
-- Constraints for table `task_collector`
--
ALTER TABLE `task_collector`
  ADD CONSTRAINT `task_collector_ibfk_1` FOREIGN KEY (`emp_username`) REFERENCES `employee` (`username`),
  ADD CONSTRAINT `task_collector_ibfk_3` FOREIGN KEY (`mcp_id`) REFERENCES `mcp` (`id`);

--
-- Constraints for table `task_janitor`
--
ALTER TABLE `task_janitor`
  ADD CONSTRAINT `task_janitor_ibfk_1` FOREIGN KEY (`emp_username`) REFERENCES `employee` (`username`);

--
-- Constraints for table `troller`
--
ALTER TABLE `troller`
  ADD CONSTRAINT `troller_ibfk_1` FOREIGN KEY (`troller_id`) REFERENCES `vehicle` (`id`);

--
-- Constraints for table `truck`
--
ALTER TABLE `truck`
  ADD CONSTRAINT `truck_ibfk_1` FOREIGN KEY (`truck_id`) REFERENCES `vehicle` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
