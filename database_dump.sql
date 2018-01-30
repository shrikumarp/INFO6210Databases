CREATE DATABASE  IF NOT EXISTS `info6210project` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `info6210project`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: info6210project
-- ------------------------------------------------------
-- Server version	5.6.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cardetails`
--

DROP TABLE IF EXISTS `cardetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cardetails` (
  `CarID` int(11) NOT NULL,
  `DriverID` varchar(45) NOT NULL,
  `CarRegistrationNumber` varchar(45) DEFAULT NULL,
  `CarMake` varchar(45) DEFAULT NULL,
  `CarModel` varchar(45) DEFAULT NULL,
  `CarManufacturer` varchar(45) DEFAULT NULL,
  `NoofSeats` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`CarID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cardetails`
--

LOCK TABLES `cardetails` WRITE;
/*!40000 ALTER TABLE `cardetails` DISABLE KEYS */;
INSERT INTO `cardetails` VALUES (1,'24','849','2012','Explorer','Ford',6),(2,'32','233','2012','Mustang','Ford',2),(3,'11','232','2012','Suburban','Chevrolet',6),(4,'12','234','2012','City','Honda',4),(5,'13','235','2012','CrossTrek','Subaru',4);
/*!40000 ALTER TABLE `cardetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerfeedback`
--

DROP TABLE IF EXISTS `customerfeedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customerfeedback` (
  `TripID` int(11) NOT NULL,
  `Feedbackid` int(11) NOT NULL,
  `UserRating` double DEFAULT NULL,
  KEY `Feedbackid_idx` (`Feedbackid`),
  KEY `TripID` (`TripID`),
  CONSTRAINT `Feedbackid` FOREIGN KEY (`Feedbackid`) REFERENCES `feedbacktable` (`Feedbackid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `TripID` FOREIGN KEY (`TripID`) REFERENCES `tripdetails` (`TripID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerfeedback`
--

LOCK TABLES `customerfeedback` WRITE;
/*!40000 ALTER TABLE `customerfeedback` DISABLE KEYS */;
INSERT INTO `customerfeedback` VALUES (21,301,4.7),(4,301,4.7),(9,301,4.7);
/*!40000 ALTER TABLE `customerfeedback` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger ratngupdate 
after insert on customerfeedback
for each row
begin
set @nt= new.tripid;
set @newrtng= new.userrating;

update driver
-- set @a=totaltripscompleted;
set totaltripscompleted=totaltripscompleted+1
where driverid=(select driver_driverid from tripdetails where tripid=@nt);
update driver
set averagerating= (averagerating*(totaltripscompleted)+ @newrtng)/(totaltripscompleted+1)
where driverid=(select driver_driverid from tripdetails where tripid=@nt);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `driver` (
  `DriverID` int(11) NOT NULL,
  `DriverName` varchar(45) DEFAULT NULL,
  `LicenseRegistrationNumber` varchar(45) DEFAULT NULL,
  `CarDetails_CarID` int(11) DEFAULT NULL,
  `AverageRating` double DEFAULT NULL,
  `TotalTripsCompleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`DriverID`),
  KEY `fk_Driver_CarDetails1_idx` (`CarDetails_CarID`),
  CONSTRAINT `fk_Driver_CarDetails1` FOREIGN KEY (`CarDetails_CarID`) REFERENCES `cardetails` (`CarID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver`
--

LOCK TABLES `driver` WRITE;
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
INSERT INTO `driver` VALUES (11,'Joe','2235',3,4.8,49),(12,'Tom','2236',4,4.6,5),(13,'Mike','2237',5,4.514285714285714,13),(24,'Shri','2233',1,4.5,45),(32,'Akki','2234',2,4.9,47);
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faretable`
--

DROP TABLE IF EXISTS `faretable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faretable` (
  `Fareid` int(11) NOT NULL,
  `SurgePercentage` double DEFAULT NULL,
  `BaseFare` double DEFAULT NULL,
  `IncrementalFare` double DEFAULT NULL,
  `TaxPercentage` double DEFAULT NULL,
  PRIMARY KEY (`Fareid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faretable`
--

LOCK TABLES `faretable` WRITE;
/*!40000 ALTER TABLE `faretable` DISABLE KEYS */;
INSERT INTO `faretable` VALUES (401,9,5,3,14),(402,2,7,4.5,14);
/*!40000 ALTER TABLE `faretable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbacktable`
--

DROP TABLE IF EXISTS `feedbacktable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedbacktable` (
  `Feedbackid` int(11) NOT NULL,
  `Feedback` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Feedbackid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbacktable`
--

LOCK TABLES `feedbacktable` WRITE;
/*!40000 ALTER TABLE `feedbacktable` DISABLE KEYS */;
INSERT INTO `feedbacktable` VALUES (301,'Clean Car'),(302,'Professional Driver'),(303,'Fun conversation'),(304,'Good Driving');
/*!40000 ALTER TABLE `feedbacktable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `feedbackview`
--

DROP TABLE IF EXISTS `feedbackview`;
/*!50001 DROP VIEW IF EXISTS `feedbackview`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `feedbackview` AS SELECT 
 1 AS `usercustomer_usercustomerid`,
 1 AS `tripid`,
 1 AS `driver_driverid`,
 1 AS `source`,
 1 AS `destination`,
 1 AS `feedback`,
 1 AS `userrating`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `paymentmethods`
--

DROP TABLE IF EXISTS `paymentmethods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentmethods` (
  `PaymentMethodID` int(11) NOT NULL,
  `UserCustomer_UserCustomerID` int(11) NOT NULL,
  `PaymentMethodDetails` varchar(45) DEFAULT NULL,
  `SecurityCodeDetails` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`PaymentMethodID`),
  KEY `fk_PaymentMethods_UserCustomer1_idx` (`UserCustomer_UserCustomerID`),
  CONSTRAINT `fk_PaymentMethods_UserCustomer1` FOREIGN KEY (`UserCustomer_UserCustomerID`) REFERENCES `usercustomer` (`UserCustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymentmethods`
--

LOCK TABLES `paymentmethods` WRITE;
/*!40000 ALTER TABLE `paymentmethods` DISABLE KEYS */;
INSERT INTO `paymentmethods` VALUES (501,102,'2222222222222222','123'),(502,102,'2222222222222223','122'),(503,101,'1111222222222224','111');
/*!40000 ALTER TABLE `paymentmethods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promocodetable`
--

DROP TABLE IF EXISTS `promocodetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promocodetable` (
  `Promocode` varchar(25) NOT NULL,
  `Discount` double DEFAULT NULL,
  `Validity` date DEFAULT NULL,
  PRIMARY KEY (`Promocode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promocodetable`
--

LOCK TABLES `promocodetable` WRITE;
/*!40000 ALTER TABLE `promocodetable` DISABLE KEYS */;
INSERT INTO `promocodetable` VALUES ('88',20,'2017-10-27'),('99',50,'2017-10-24');
/*!40000 ALTER TABLE `promocodetable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `refundrequestsview1`
--

DROP TABLE IF EXISTS `refundrequestsview1`;
/*!50001 DROP VIEW IF EXISTS `refundrequestsview1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `refundrequestsview1` AS SELECT 
 1 AS `rcrequestid`,
 1 AS `reason`,
 1 AS `driver`,
 1 AS `CustomerServed`,
 1 AS `tripdate`,
 1 AS `driverid`,
 1 AS `drivername`,
 1 AS `licenseregistrationnumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `refundscomplainttable`
--

DROP TABLE IF EXISTS `refundscomplainttable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refundscomplainttable` (
  `RCRequestid` int(11) NOT NULL AUTO_INCREMENT,
  `Reason` varchar(45) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `TripDetails_TripID` int(11) NOT NULL,
  PRIMARY KEY (`RCRequestid`),
  KEY `fk_RefundsComplaintTable_TripDetails1_idx` (`TripDetails_TripID`),
  CONSTRAINT `fk_RefundsComplaintTable_TripDetails1` FOREIGN KEY (`TripDetails_TripID`) REFERENCES `tripdetails` (`TripID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=702 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refundscomplainttable`
--

LOCK TABLES `refundscomplainttable` WRITE;
/*!40000 ALTER TABLE `refundscomplainttable` DISABLE KEYS */;
INSERT INTO `refundscomplainttable` VALUES (701,'Cancelled/Driver nor arrived','Not Solved',13);
/*!40000 ALTER TABLE `refundscomplainttable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `top3drivers`
--

DROP TABLE IF EXISTS `top3drivers`;
/*!50001 DROP VIEW IF EXISTS `top3drivers`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `top3drivers` AS SELECT 
 1 AS `DriverID`,
 1 AS `DriverName`,
 1 AS `LicenseRegistrationNumber`,
 1 AS `CarDetails_CarID`,
 1 AS `AverageRating`,
 1 AS `TotalTripsCompleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transactionstable`
--

DROP TABLE IF EXISTS `transactionstable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionstable` (
  `TransactionID` int(11) NOT NULL AUTO_INCREMENT,
  `TripID` int(11) NOT NULL,
  `PaymentMethods_PaymentMethodID` int(11) NOT NULL,
  `TotalFare` double DEFAULT NULL,
  `PromocodeTable_Promocode` varchar(25) NOT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `fk_TransactionsTable_PaymentMethods1_idx` (`PaymentMethods_PaymentMethodID`),
  KEY `fk_TransactionsTable_PromocodeTable1_idx` (`PromocodeTable_Promocode`),
  KEY `fk_TripID_idx` (`TripID`),
  CONSTRAINT `fk_TransactionsTable_PaymentMethods1` FOREIGN KEY (`PaymentMethods_PaymentMethodID`) REFERENCES `paymentmethods` (`PaymentMethodID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TransactionsTable_PromocodeTable1` FOREIGN KEY (`PromocodeTable_Promocode`) REFERENCES `promocodetable` (`Promocode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TripID` FOREIGN KEY (`TripID`) REFERENCES `tripdetails` (`TripID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactionstable`
--

LOCK TABLES `transactionstable` WRITE;
/*!40000 ALTER TABLE `transactionstable` DISABLE KEYS */;
INSERT INTO `transactionstable` VALUES (1,12,502,23,'99'),(2,9,503,21.090000000000003,'99');
/*!40000 ALTER TABLE `transactionstable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tripdetails`
--

DROP TABLE IF EXISTS `tripdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tripdetails` (
  `TripID` int(11) NOT NULL AUTO_INCREMENT,
  `Source` varchar(45) DEFAULT NULL,
  `Destination` varchar(45) DEFAULT NULL,
  `DistanceInMiles` varchar(45) DEFAULT NULL,
  `Driver_DriverID` int(11) NOT NULL,
  `UserCustomer_UserCustomerID` int(11) NOT NULL,
  `TripDate` date DEFAULT NULL,
  `TripTime` time DEFAULT NULL,
  `FareTable_Fareid` int(11) NOT NULL,
  PRIMARY KEY (`TripID`),
  KEY `fk_TripDetails_Driver_idx` (`Driver_DriverID`),
  KEY `fk_TripDetails_UserCustomer1_idx` (`UserCustomer_UserCustomerID`),
  KEY `fk_TripDetails_FareTable1_idx` (`FareTable_Fareid`),
  CONSTRAINT `fk_TripDetails_Driver` FOREIGN KEY (`Driver_DriverID`) REFERENCES `driver` (`DriverID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TripDetails_FareTable1` FOREIGN KEY (`FareTable_Fareid`) REFERENCES `faretable` (`Fareid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_TripDetails_UserCustomer1` FOREIGN KEY (`UserCustomer_UserCustomerID`) REFERENCES `usercustomer` (`UserCustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tripdetails`
--

LOCK TABLES `tripdetails` WRITE;
/*!40000 ALTER TABLE `tripdetails` DISABLE KEYS */;
INSERT INTO `tripdetails` VALUES (4,'Massachusetts Ave','Huntington Ave','1.5',32,102,'2017-10-21','10:34:09',402),(9,'Tremont Street','Huntington Ave','1.5',13,102,'2017-10-29','11:34:09',401),(12,'Tremont street','Huntington Ave','3.5',32,102,'2017-10-27','10:34:09',401),(13,'Massachusetts Ave','Northeastern','2',32,102,'2017-10-11','10:34:09',402),(21,'BSO','Tremont Street','3',24,101,'2017-10-21','10:34:09',401);
/*!40000 ALTER TABLE `tripdetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger faretrig3 
after insert on tripdetails
for each row
begin
set @newtrip= new.tripid;
set @newd= new.distanceinmiles;
set @newfare= new.faretable_fareid;
set @userid= new.usercustomer_usercustomerid;

select a.surgepercentage into @x
from Faretable as a inner join tripdetails as b on b.FareTable_Fareid=a.fareid  
where a.fareid=@newfare
limit 1;
select a.basefare into @y
from Faretable as a inner join tripdetails as b on b.FareTable_Fareid=a.fareid  
where a.fareid=@newfare
limit 1;
select a.incrementalfare into @l
from Faretable as a inner join tripdetails as b on b.FareTable_Fareid=a.fareid  
where a.fareid=@newfare
limit 1;
select a.taxpercentage into @m
from Faretable as a inner join tripdetails as b on b.FareTable_Fareid=a.fareid  
where a.fareid=@newfare
limit 1;

insert into transactionstable (tripid,paymentmethods_paymentmethodid,totalfare,promocodetable_promocode)
values(@newtrip,503,((@x+@y+(@newd*@l))*(1+(@m/100))),99);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usercustomer`
--

DROP TABLE IF EXISTS `usercustomer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usercustomer` (
  `UserCustomerID` int(11) NOT NULL,
  `UserCustomerName` varchar(45) DEFAULT NULL,
  `UserCustomerEmail` varchar(45) DEFAULT NULL,
  `UserCustomerPhone` varchar(45) DEFAULT NULL,
  `UserCustomerUserID` varchar(45) DEFAULT NULL,
  `UserCustomerPassword` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UserCustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usercustomer`
--

LOCK TABLES `usercustomer` WRITE;
/*!40000 ALTER TABLE `usercustomer` DISABLE KEYS */;
INSERT INTO `usercustomer` VALUES (101,'Akshay','akshay@husky.neu.edu','8171111112','aks','akspass'),(102,'Ritesh','ritesh@husky.neu.edu','8171111111','rit','ritpass');
/*!40000 ALTER TABLE `usercustomer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'info6210project'
--

--
-- Dumping routines for database 'info6210project'
--
/*!50003 DROP PROCEDURE IF EXISTS `calcdiscountfrompromocodes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `calcdiscountfrompromocodes`(inout discfare double, in promo VARCHAR(25))
begin
select @x:=p.discount, @y:=t.totalfare
from transactionstable as t inner join promocodetable as p on  p.promocode=t.PromocodeTable_Promocode
where p.Promocode=promo;
set discfare= @y*(1-(@x/100));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `distributionforafareid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `distributionforafareid`(in takenfareid int)
begin
select a.surgepercentage, a.basefare,a.incrementalfare,a.taxpercentage,
 (b.distanceinmiles*a.incrementalfare+a.basefare+a.surgepercentage)*(1+(a.taxpercentage/100)) 
from Faretable as a inner join  tripdetails as b
on a.fareid=b.FareTable_Fareid where a.fareid=takenfareid ;
-- set @x= y;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fareidcompdist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fareidcompdist`(in takenfareid int)
begin
select surgepercentage, basefare,incrementalfare,taxpercentage from Faretable where fareid=takenfareid;
-- set @x= y;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tripsbetweentwodates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tripsbetweentwodates`()
begin
select * from tripdetails where tripdate between '2016-10-24' and '2017-10-26';
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_feedbackfor_driver` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_feedbackfor_driver`()
begin
create view feedbackview
as select t.usercustomer_usercustomerid,t.tripid, t.driver_driverid,t.source, t.destination,
 f.feedback, cf.userrating
from tripdetails as t inner join customerfeedback as cf on t.tripid=cf.tripid 
inner join feedbacktable as f on f.feedbackid=cf.feedbackid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `feedbackview`
--

/*!50001 DROP VIEW IF EXISTS `feedbackview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `feedbackview` AS select `t`.`UserCustomer_UserCustomerID` AS `usercustomer_usercustomerid`,`t`.`TripID` AS `tripid`,`t`.`Driver_DriverID` AS `driver_driverid`,`t`.`Source` AS `source`,`t`.`Destination` AS `destination`,`f`.`Feedback` AS `feedback`,`cf`.`UserRating` AS `userrating` from ((`tripdetails` `t` join `customerfeedback` `cf` on((`t`.`TripID` = `cf`.`TripID`))) join `feedbacktable` `f` on((`f`.`Feedbackid` = `cf`.`Feedbackid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `refundrequestsview1`
--

/*!50001 DROP VIEW IF EXISTS `refundrequestsview1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `refundrequestsview1` AS select `ref`.`RCRequestid` AS `rcrequestid`,`ref`.`Reason` AS `reason`,`tp`.`Driver_DriverID` AS `driver`,`tp`.`UserCustomer_UserCustomerID` AS `CustomerServed`,`tp`.`TripDate` AS `tripdate`,`dr`.`DriverID` AS `driverid`,`dr`.`DriverName` AS `drivername`,`dr`.`LicenseRegistrationNumber` AS `licenseregistrationnumber` from ((`refundscomplainttable` `ref` join `tripdetails` `tp` on((`ref`.`TripDetails_TripID` = `tp`.`TripID`))) join `driver` `dr` on((`tp`.`Driver_DriverID` = `dr`.`DriverID`))) order by `tp`.`TripDate` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `top3drivers`
--

/*!50001 DROP VIEW IF EXISTS `top3drivers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `top3drivers` AS select `driver`.`DriverID` AS `DriverID`,`driver`.`DriverName` AS `DriverName`,`driver`.`LicenseRegistrationNumber` AS `LicenseRegistrationNumber`,`driver`.`CarDetails_CarID` AS `CarDetails_CarID`,`driver`.`AverageRating` AS `AverageRating`,`driver`.`TotalTripsCompleted` AS `TotalTripsCompleted` from `driver` where (`driver`.`TotalTripsCompleted` >= 25) order by `driver`.`AverageRating` desc limit 3 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-13 23:49:09
