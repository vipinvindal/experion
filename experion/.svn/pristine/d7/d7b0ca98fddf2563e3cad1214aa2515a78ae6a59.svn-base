CREATE DATABASE  IF NOT EXISTS `experion` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `experion`;
-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (i686)
--
-- Host: 127.0.0.1    Database: experion
-- ------------------------------------------------------
-- Server version	5.5.35-0ubuntu0.12.04.1

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
-- Table structure for table `app_config`
--

DROP TABLE IF EXISTS `app_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `config_key` varchar(255) NOT NULL,
  `custom_value` varchar(2000) DEFAULT NULL,
  `default_value` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_key` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_config`
--

LOCK TABLES `app_config` WRITE;
/*!40000 ALTER TABLE `app_config` DISABLE KEYS */;
INSERT INTO `app_config` VALUES (1,'100','This email id does not exist.','INVALID_EMAIL'),(2,'102','This email id is not registered with us.','INVALID_USER'),(3,'103','Invalid password.','INVALID_PASSWORD'),(4,'104','Inactive user. Please login to continue.','INACTIVE_USER'),(5,'105','This email id is not registered with us.','USER_NOT_REGISTERED'),(6,'303','Unable to process your request at this moment. Please try again later.','USER_REGISTERED_DEVICE_NOT_ADDED'),(7,'305','Unable to process your request at this moment. Please try again later.','DEVICE_NOT_FOUND'),(8,'309','Unable to process your request at this moment. Please try again later.','COMMAND_HISTORY_NOT_SAVED'),(9,'207','Registration Successful','USER_REGISTERED_DEVICE_ADDED'),(10,'209','Activated Successfully','COMMAND_HISTORY_SAVED'),(11,'1000','Unable to process your request at this moment. Please try again later.','UNHANDLED_EROR'),(12,'400','Registration Successful.','LOGIN_SUCCESS'),(13,'401','Unable to process your request at this moment. Please try again later.','LOGIN_FAIL'),(14,'402','Password has been sent successfully.','PASSWORD_IS_SEND'),(15,'403','This email id is not registered with us.','PASSWORD_SENDING_FAIL'),(16,'404','Password updated successfully.','PASSWORD_UPDATED'),(17,'405','Unable to process your request at this moment. Please try again later.','PASSWORD_UPDATE_FAIL'),(18,'406','Deactivated Successfully.','USER_SERVICE_DEACTIVATED'),(19,'407','Unable to process your request at this moment. Please try again later.','USER_SERVICE_DEACTIVATE_FAIL'),(20,'408','Your feedback has been sent successfully.','FEEDBACK_REGISTERED'),(21,'410','Invalid Request','DEVICE_ID_INVALID_OR_NULL'),(22,'ADMIN_USER_NAME','admin','admin'),(23,'ADMIN_USER_PASS','admin','admin'),(24,'412','Unable to add more devices. Maximum limit to add devices is 5.','LOGIN_FAIL_NO_MORE_DEVICE_TO_ADD'),(25,'414','This email and mobile has already been registered. Please login to proceed','USER_EMIL_AND_DEVICE_ALREADY_REGISTERED'),(26,'415',' ','SUCCESS_ACKNOWLEDGEMENT'),(27,'416',' ','FAILURE_ACKNOWLEDGEMENT'),(28,'418','This email id has already been registered with us. Please login to proceed.','USER_ALREADY_REGISTERED'),(29,'SENDER_ID','','AIzaSyBV-APQFzkVnYuYeM5hNO6liRm9Fr0IUyw'),(30,'MAIL_SUBJECT_REGISTER','Registration Details','mSecure Registration'),(31,'MAIL_BODY_REGISTER','<b>Dear @@USERNAME@@</b>,<br><br>Thank you for registering with mSecure.<br><br>Your mSecure account details are as follows:<br><br>Username: @@EMAIL@@<br><br>Password: @@PASSWORD@@','<b>Dear @@USERNAME@@,</b><br/><br/>Thank you for registering with mSecure.<br/><br/>Your mSecure account details are as follows:<br/><br/>Username: @@EMAIL@@<br/>Password: @@PASSWORD@@<br/><br/>'),(32,'MAIL_OPTIONS_CONTENT','In case your mobile device ever gets lost or stolen, you can now remotely lock, track and erase the data on the device by sending text messages from any other number to your lost device.<br><br><b>1. Remote Lock - </b>Helps you to lock your mobile device remotely.<br><b>To Activate, SMS - </b>Lock < Password ><br><b>To Deactivate - </b>Enter mSecure password to unlock the locked screen.<br><br><b>2. Remote Access Lock - </b>Helps you to lock your device Gallery, SMS and settings.<br><b>To Activate, SMS - </b>LockA < Password ><br><b>To Deactivate - </b>Enter mSecure password to unlock the locked screen.<br><br><b>Note - </b>By default this feature will get activated automatically as soon as the SIM card is replaced.<br><br><b>3. Remote Tracking - </b>Helps you to remotely track your lost device by sending location details through SMS to the emergency number.<br><b>To Activate, SMS - </b>Track < Password ><br><b>To Deactivate, SMS - </b>TRACKD < Password ><br><br><b>Note - </b>By default this feature will get activated automatically as soon as the SIM card is replaced.<br><br><b>4. Remote Erase - </b>Helps you to erase the data of your mobile device remotely.<br>a) For Contacts - WIPEC < Password ><br>b) For SMS - WIPES < Password ><br> c) For Images - WIPEI < Password ><br> d) For Videos - WIPEV < Password ><br> e) For Complete Data - WIPEAll < Password ><br><br><b>5. Remote Alarm - </b>Helps you to raise an alarm on your device.<br><b>To Activate, SMS - </b>ALARMA < Password ><br><b>To Deactivate, SMS - </b>ALARMD < Password ><br><br><b>6. Lost Handset logs - </b>Provides complete call logs of the new number of the SIM, that has been inserted in your lost device, to the emergency number.<br><b>To Activate, SMS - </b>CALLA < Password ><br><b>To Deactivate, SMS - </b>CALLD < Password ><br><br><b>7. Remote Deactivation - </b>Helps you to deactivate all the activated features of mSecure.<br><b>Send a SMS - </b>STOP < Password >','<br/>You can lock, track and wipe the data of your lost phone remotely by sending a few simple messages, or <br/> login to  http://msecure.bets.net.in   with your credentials.<br/><br/><b>1. Remote Lock-</b> helps you to lock your device remotely.<br/><b>Send a sms-</b> &nbsp;&lt;lock&gt;&lt;Space&gt;&lt;Password&gt;<br/><br/>2. Remote Access Lock -</b> helps you to lock your device remotely.<br/><b>Send a sms-</b> &nbsp;&lt;locka&gt;&lt;Space&gt;&lt;Password&gt;<br/><br/><b>3. Remote Delete-</b> Helps you to delete the data of your device remotely.<br/> a) For Contacts : &lt;wipec&gt;&lt;Space&gt;&lt;Password&gt;<br/><pre1> b) For SMS:&lt;wipes&gt;&lt;Space&gt;&lt;Password&gt;<br/>c) For Images: &lt;wipei&gt;&lt;Space&gt;&lt;Password&gt;<br/> d) For Videos: &lt;wipev&gt;&lt;Space&gt;&lt;Password&gt;<br/> e) For Complete Data : &lt;wipeall&gt;&lt;Space&gt;&lt;Password&gt;<br/><br><b>4. Alert Setup-</b> ring your device.<br/><b>Send a sms -</b>&nbsp; &lt;Alarm&gt;&lt;Space&gt;&lt;Password&gt;<br/><br/><b>5. Deactivate Service from any number(Change of handset intentionally).</b><br/>&nbsp; &lt;stop&gt;&lt;Space&gt;&lt;Password&gt;<br/><br/>Looking forward to assist you again.<br/><br/><b>Customer Care:</b><br/>Beyond Evolution<br/>Your World on your mobile!<br/><br/>NOTE: Please do not respond to this mail. Should you have any further queries, kindly write us at msecure@bets.net.in'),(33,'MAIL_SUBJECT_PASSWORD','Account Details','mSecure account details'),(34,'MAIL_BODY_PASSWORD','<b>Dear @@USERNAME@@</b><br><br>Your mSecure account details are as follows:<br><br>Username: @@EMAIL@@<br>Password: @@PASSWORD@@','<b>Dear @@USERNAME@@,</b><br/><br/>Your mSecure account details are as follows:<br/><br/>Username: @@EMAIL@@<br/>Password: @@PASSWORD@@<br/><br/>Looking forward to assist you again.<br/><br/><b>Customer Care:</b><br/>Beyond Evolution<br/>Your World on your mobile!<br/><br>NOTE: Please do not respond to this mail. Should you have any further queries, kindly write us at msecure@bets.net.in<br/>'),(35,'MAIL_SUBJECT_SIMCHANGE','Alert from mSecure','mSecure Notification'),(36,'MAIL_BODY_SIMCHANGE','Dear @@USERNAME@@,<br/><br/>This is an alert from mSecure.<br/><br/>An unregistered number has been inserted into your mobile device.<br/><br/>','<b>Dear @@USERNAME@@,</b><br/><br/>This is an alert from mSecure<br/><br/>An unregistered number has inserted into your mobile.<br/>'),(37,'MAIL_SUBJECT_FEEDBACK_ACK','Feedback Acknowledgement','mSecure Feedback Acknowledgement'),(38,'MAIL_BODY_FEEDBACK_ACK','<b>Dear User,</b><br><br>Thank you for writing in.<br><br>Your feedback is important for us. It\'s our constant endeavour to provide you complete satisfaction.','<b>Dear User,</b><br/><br/>Thank you for writing in.<br/><br/>Your feedback is important to us and we are committed to provide a satisfactory resolution.<br/><br/><b>Customer Care:</b><br/>Beyond Evolution<br/>Your World on your mobile!<br/><br/>NOTE: Please do not respond to this mail. Should you have any further queries, kindly write us at msecure@bets.net.in<br/>'),(39,'417','Unable to process your request at this moment. Please try again later.','FEEDBACK_REGISTRATION_FAIL'),(40,'MAIL_USERNAME',' ','noreply@ms.bets.net.in'),(41,'MAIL_PASSWORD',' ','Apple123#'),(42,'MAIL_FROM_NAME','','mSecure'),(43,'MAIL_SMTP_HOST',' ','smtp.gmail.com'),(44,'MAIL_SMTP_PORT',' ','465'),(45,'106',' ','EMERGENCY_NUMBER_UPDATED'),(46,'MAIL_SIGNATURE','<br><br>Look forward to assisting you again.<br><br><b>Customer Care:</b><br>Beyond Evolution<br><i>Your World on Your Mobile!</i><br><br>NOTE: Please do not respond to this mail. In case you have any clarifications, kindly write to us at <br>msecure@bets.net.in','MAIL_SIGNATURE'),(47,'MAIL_SUBJECT_FEEDBACK',' ','mSecure: Feedback'),(48,'MAIL_BODY_FEEDBACK',' ','@@USER_EMAIL@@ has given the following feedback:@@FEEDBACK@@'),(49,'FEEDBACK_MAIL_ID','msecure@bets.net.in','support@beyondevolution.in');
/*!40000 ALTER TABLE `app_config` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-01-29 16:02:07
