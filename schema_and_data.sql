-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 18, 2025 at 08:01 PM
-- Server version: 10.11.13-MariaDB-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kkailay_3_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customerID` int(11) NOT NULL,
  `custFirstName` varchar(50) NOT NULL,
  `custLastName` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerID`, `custFirstName`, `custLastName`, `phone`, `email`) VALUES
(1, 'Alex', 'Rivera', '317-555-0101', 'alex.rivera@email.com'),
(2, 'Maya', 'Patel', '317-555-0102', 'maya.patel@email.com'),
(3, 'Jordan', 'Lee', '317-555-0103', 'jordan.lee@email.com');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employeeID` int(11) NOT NULL,
  `empFirstName` varchar(50) NOT NULL,
  `empLastName` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `jobID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employeeID`, `empFirstName`, `empLastName`, `phone`, `email`, `jobID`) VALUES
(1, 'Sidhu', 'Moosewala', '317-555-5911', 'sidhu.moosewala@shop.com', 2),
(2, 'Taylor', 'Brooks', '317-555-1244', 'taylor.brooks@shop.com', 2),
(3, 'Casey', 'Morgan', '317-555-1524', 'casey.morgan@shop.com', 3);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `invoiceID` int(11) NOT NULL,
  `repairOrderID` int(11) NOT NULL,
  `invoiceDate` date NOT NULL,
  `totalAmount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`invoiceID`, `repairOrderID`, `invoiceDate`, `totalAmount`) VALUES
(1, 1, '2025-11-10', 471.98),
(2, 2, '2025-11-11', 226.69),
(3, 3, '2025-11-12', 110.00);

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE `job` (
  `jobID` int(11) NOT NULL,
  `jobTitle` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job`
--

INSERT INTO `job` (`jobID`, `jobTitle`) VALUES
(1, 'Manager'),
(2, 'Mechanic'),
(3, 'Service Advisor');

-- --------------------------------------------------------

--
-- Table structure for table `make`
--

CREATE TABLE `make` (
  `makeID` int(11) NOT NULL,
  `makeName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `make`
--

INSERT INTO `make` (`makeID`, `makeName`) VALUES
(1, 'Toyota'),
(2, 'Ford'),
(3, 'Chevrolet');

-- --------------------------------------------------------

--
-- Table structure for table `model`
--

CREATE TABLE `model` (
  `modelID` int(11) NOT NULL,
  `makeID` int(11) NOT NULL,
  `modelName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `model`
--

INSERT INTO `model` (`modelID`, `makeID`, `modelName`) VALUES
(1, 1, 'Camry'),
(2, 1, 'Corolla'),
(3, 2, 'F-150'),
(4, 3, 'Silverado');

-- --------------------------------------------------------

--
-- Table structure for table `part`
--

CREATE TABLE `part` (
  `partID` int(11) NOT NULL,
  `partName` varchar(80) NOT NULL,
  `partDescription` varchar(300) DEFAULT NULL,
  `unitPrice` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `part`
--

INSERT INTO `part` (`partID`, `partName`, `partDescription`, `unitPrice`) VALUES
(1, 'Oil Filter', 'Standard oil filter', 12.99),
(2, 'Engine Oil 5W-30', '1 quart synthetic blend', 8.49),
(3, 'Brake Pads (Set)', 'Brake pad set', 79.99),
(4, 'Brake Cleaner', 'Aerosol brake cleaner', 6.99),
(5, 'Shop Supplies', 'Rags, gloves, small supplies fee', 5.00);

-- --------------------------------------------------------

--
-- Table structure for table `partUsed`
--

CREATE TABLE `partUsed` (
  `partUsedID` int(11) NOT NULL,
  `repairLineItemID` int(11) NOT NULL,
  `partID` int(11) NOT NULL,
  `quantityUsed` int(11) NOT NULL,
  `unitPriceAtUse` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `partUsed`
--

INSERT INTO `partUsed` (`partUsedID`, `repairLineItemID`, `partID`, `quantityUsed`, `unitPriceAtUse`) VALUES
(1, 2, 3, 1, 79.99),
(2, 2, 4, 1, 6.99),
(3, 3, 1, 1, 12.99),
(4, 3, 2, 5, 8.49),
(5, 3, 5, 1, 5.00);


-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `paymentID` int(11) NOT NULL,
  `invoiceID` int(11) NOT NULL,
  `paymentDate` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `paymentMethod` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`paymentID`, `invoiceID`, `paymentDate`, `amount`, `paymentMethod`) VALUES
(1, 2, '2025-11-11', 189.95, 'Card');

-- --------------------------------------------------------

--
-- Table structure for table `repairLineItem`
--

CREATE TABLE `repairLineItem` (
  `repairLineItemID` int(11) NOT NULL,
  `repairOrderID` int(11) NOT NULL,
  `serviceTypeID` int(11) NOT NULL,
  `laborHours` decimal(5,2) NOT NULL,
  `laborRate` decimal(8,2) NOT NULL,
  `lineNotes` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `repairLineItem`
--

INSERT INTO `repairLineItem` (`repairLineItemID`, `repairOrderID`, `serviceTypeID`, `laborHours`, `laborRate`, `lineNotes`) VALUES
(1, 1, 4, 1.00, 110.00, 'Performed brake inspection and road test.'),
(2, 1, 2, 2.50, 110.00, 'Replaced brake pads.'),
(3, 2, 1, 1.00, 95.00, 'Oil and filter change.'),
(4, 2, 3, 0.75, 95.00, 'Rotated tires and checked pressure.'),
(5, 3, 4, 1.00, 110.00, 'General diagnostic / inspection.');

-- --------------------------------------------------------

--
-- Table structure for table `repairOrder`
--

CREATE TABLE `repairOrder` (
  `repairOrderID` int(11) NOT NULL,
  `vehicleID` int(11) NOT NULL,
  `employeeID` int(11) NOT NULL,
  `dateIn` date NOT NULL,
  `status` varchar(30) NOT NULL,
  `notes` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `repairOrder`
--

INSERT INTO `repairOrder` (`repairOrderID`, `vehicleID`, `employeeID`, `dateIn`, `status`, `notes`) VALUES
(1, 1, 3, '2025-11-10', 'In Progress', 'Customer reports squeaking when braking.'),
(2, 2, 3, '2025-11-11', 'Complete', 'Routine maintenance visit.'),
(3, 3, 3, '2025-11-12', 'Complete', 'Customer requested inspection before road trip.');

-- --------------------------------------------------------

--
-- Table structure for table `serviceType`
--

CREATE TABLE `serviceType` (
  `serviceTypeID` int(11) NOT NULL,
  `serviceName` varchar(80) NOT NULL,
  `standardLaborHours` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `serviceType`
--

INSERT INTO `serviceType` (`serviceTypeID`, `serviceName`, `standardLaborHours`) VALUES
(1, 'Oil Change', 1.00),
(2, 'Brake Pad Replace', 2.50),
(3, 'Tire Rotation', 0.75),
(4, 'Diagnostic', 1.00);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `vehicleID` int(11) NOT NULL,
  `customerID` int(11) NOT NULL,
  `modelID` int(11) NOT NULL,
  `vin` varchar(17) NOT NULL,
  `year` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`vehicleID`, `customerID`, `modelID`, `vin`, `year`) VALUES
(1, 1, 1, '1HGCM82633A004111', 2018),
(2, 1, 3, '1FTFW1E50JFB12345', 2020),
(3, 2, 2, '2T1BURHE0JC123456', 2016),
(4, 3, 4, '3GCUKREC0JG123789', 2019);

-- --------------------------------------------------------

--
-- Stand-in structure for view `viewInvoicePaymentStatus`
-- (See below for the actual view)
--
CREATE TABLE `viewInvoicePaymentStatus` (
`invoiceID` int(11)
,`invoiceDate` date
,`totalAmount` decimal(10,2)
,`paymentDate` date
,`amount` decimal(10,2)
,`paymentMethod` varchar(30)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `viewRepairOrderInfo`
-- (See below for the actual view)
--
CREATE TABLE `viewRepairOrderInfo` (
`repairOrderID` int(11)
,`dateIn` date
,`status` varchar(30)
,`custFirstName` varchar(50)
,`custLastName` varchar(50)
,`vin` varchar(17)
,`year` smallint(6)
,`empFirstName` varchar(50)
,`empLastName` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure for view `viewInvoicePaymentStatus`
--
DROP TABLE IF EXISTS `viewInvoicePaymentStatus`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kkailay`@`localhost` SQL SECURITY DEFINER VIEW `viewInvoicePaymentStatus`  AS SELECT `i`.`invoiceID` AS `invoiceID`, `i`.`invoiceDate` AS `invoiceDate`, `i`.`totalAmount` AS `totalAmount`, `p`.`paymentDate` AS `paymentDate`, `p`.`amount` AS `amount`, `p`.`paymentMethod` AS `paymentMethod` FROM (`invoice` `i` left join `payment` `p` on(`i`.`invoiceID` = `p`.`invoiceID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `viewRepairOrderInfo`
--
DROP TABLE IF EXISTS `viewRepairOrderInfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kkailay`@`localhost` SQL SECURITY DEFINER VIEW `viewRepairOrderInfo`  AS SELECT `ro`.`repairOrderID` AS `repairOrderID`, `ro`.`dateIn` AS `dateIn`, `ro`.`status` AS `status`, `c`.`custFirstName` AS `custFirstName`, `c`.`custLastName` AS `custLastName`, `v`.`vin` AS `vin`, `v`.`year` AS `year`, `e`.`empFirstName` AS `empFirstName`, `e`.`empLastName` AS `empLastName` FROM (((`repairOrder` `ro` join `vehicle` `v` on(`ro`.`vehicleID` = `v`.`vehicleID`)) join `customer` `c` on(`v`.`customerID` = `c`.`customerID`)) join `employee` `e` on(`ro`.`employeeID` = `e`.`employeeID`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerID`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employeeID`),
  ADD KEY `fk_employee_job` (`jobID`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoiceID`),
  ADD UNIQUE KEY `unique_invoice_repairOrder` (`repairOrderID`),
  ADD UNIQUE KEY `repairOrderID` (`repairOrderID`);

--
-- Indexes for table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`jobID`);

--
-- Indexes for table `make`
--
ALTER TABLE `make`
  ADD PRIMARY KEY (`makeID`);

--
-- Indexes for table `model`
--
ALTER TABLE `model`
  ADD PRIMARY KEY (`modelID`),
  ADD KEY `fk_model_make` (`makeID`);

--
-- Indexes for table `part`
--
ALTER TABLE `part`
  ADD PRIMARY KEY (`partID`);

--
-- Indexes for table `partUsed`
--
ALTER TABLE `partUsed`
  ADD PRIMARY KEY (`partUsedID`),
  ADD KEY `fk_partUsed_repairLineItem` (`repairLineItemID`),
  ADD KEY `fk_partUsed_part` (`partID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`paymentID`),
  ADD UNIQUE KEY `unique_payment_invoice` (`invoiceID`),
  ADD UNIQUE KEY `invoiceID` (`invoiceID`);

--
-- Indexes for table `repairLineItem`
--
ALTER TABLE `repairLineItem`
  ADD PRIMARY KEY (`repairLineItemID`),
  ADD KEY `fk_repairLineItem_repairOrder` (`repairOrderID`),
  ADD KEY `fk_repairLineItem_serviceType` (`serviceTypeID`);

--
-- Indexes for table `repairOrder`
--
ALTER TABLE `repairOrder`
  ADD PRIMARY KEY (`repairOrderID`),
  ADD KEY `fk_repairOrder_vehicle` (`vehicleID`),
  ADD KEY `fk_repairOrder_employee` (`employeeID`);

--
-- Indexes for table `serviceType`
--
ALTER TABLE `serviceType`
  ADD PRIMARY KEY (`serviceTypeID`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehicleID`),
  ADD UNIQUE KEY `uq_vehicle_vin` (`vin`),
  ADD KEY `fk_vehicle_customer` (`customerID`),
  ADD KEY `fk_vehicle_model` (`modelID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `invoiceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `job`
--
ALTER TABLE `job`
  MODIFY `jobID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `make`
--
ALTER TABLE `make`
  MODIFY `makeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `model`
--
ALTER TABLE `model`
  MODIFY `modelID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `part`
--
ALTER TABLE `part`
  MODIFY `partID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `partUsed`
--
ALTER TABLE `partUsed`
  MODIFY `partUsedID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `paymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `repairLineItem`
--
ALTER TABLE `repairLineItem`
  MODIFY `repairLineItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `repairOrder`
--
ALTER TABLE `repairOrder`
  MODIFY `repairOrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `serviceType`
--
ALTER TABLE `serviceType`
  MODIFY `serviceTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `vehicleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `fk_employee_job` FOREIGN KEY (`jobID`) REFERENCES `job` (`jobID`);

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `fk_invoice_repairOrder` FOREIGN KEY (`repairOrderID`) REFERENCES `repairOrder` (`repairOrderID`);

--
-- Constraints for table `model`
--
ALTER TABLE `model`
  ADD CONSTRAINT `fk_model_make` FOREIGN KEY (`makeID`) REFERENCES `make` (`makeID`);

--
-- Constraints for table `partUsed`
--
ALTER TABLE `partUsed`
  ADD CONSTRAINT `fk_partUsed_part` FOREIGN KEY (`partID`) REFERENCES `part` (`partID`),
  ADD CONSTRAINT `fk_partUsed_repairLineItem` FOREIGN KEY (`repairLineItemID`) REFERENCES `repairLineItem` (`repairLineItemID`) ON DELETE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_payment_invoice` FOREIGN KEY (`invoiceID`) REFERENCES `invoice` (`invoiceID`) ON DELETE CASCADE;

--
-- Constraints for table `repairLineItem`
--
ALTER TABLE `repairLineItem`
  ADD CONSTRAINT `fk_repairLineItem_repairOrder` FOREIGN KEY (`repairOrderID`) REFERENCES `repairOrder` (`repairOrderID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_repairLineItem_serviceType` FOREIGN KEY (`serviceTypeID`) REFERENCES `serviceType` (`serviceTypeID`);

--
-- Constraints for table `repairOrder`
--
ALTER TABLE `repairOrder`
  ADD CONSTRAINT `fk_repairOrder_employee` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`employeeID`),
  ADD CONSTRAINT `fk_repairOrder_vehicle` FOREIGN KEY (`vehicleID`) REFERENCES `vehicle` (`vehicleID`);

--
-- Constraints for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD CONSTRAINT `fk_vehicle_customer` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`),
  ADD CONSTRAINT `fk_vehicle_model` FOREIGN KEY (`modelID`) REFERENCES `model` (`modelID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
