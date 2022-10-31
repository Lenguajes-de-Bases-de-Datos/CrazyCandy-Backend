-- MariaDB dump 10.19  Distrib 10.9.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: crazycandy
-- ------------------------------------------------------
-- Server version	10.9.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ncategoria` varchar(100) DEFAULT NULL,
  `pasilloInicio` int(11) DEFAULT NULL,
  `pasilloFin` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES
(1,'Chocolates',5,7,1),
(2,'Mazapanes',8,8,1),
(3,'Chetos',1,4,1),
(4,'Bebidas',9,11,1),
(5,'Dulces Chinos',12,14,1),
(6,'Dulces Japoneses',15,17,1),
(7,'Dulces Americanos',18,20,1),
(8,'Salsas',21,21,1),
(9,'Adornos',22,22,1),
(10,'Arreglos',23,23,1);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compra` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_usuario` int(11) DEFAULT NULL,
  `ID_sucursal` int(11) DEFAULT NULL,
  `ID_prov` int(11) DEFAULT NULL,
  `total` decimal(11,4) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_usuario` (`ID_usuario`),
  KEY `ID_sucursal` (`ID_sucursal`),
  KEY `ID_prov` (`ID_prov`),
  CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`ID_usuario`) REFERENCES `usuario` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`ID_sucursal`) REFERENCES `sucursal` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `compra_ibfk_3` FOREIGN KEY (`ID_prov`) REFERENCES `proveedor` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra_producto`
--

DROP TABLE IF EXISTS `compra_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compra_producto` (
  `ID_prod` int(11) NOT NULL,
  `ID_comp` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precioUnitario` decimal(6,4) DEFAULT NULL,
  PRIMARY KEY (`ID_prod`,`ID_comp`),
  KEY `ID_comp` (`ID_comp`),
  CONSTRAINT `compra_producto_ibfk_1` FOREIGN KEY (`ID_prod`) REFERENCES `producto` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `compra_producto_ibfk_2` FOREIGN KEY (`ID_comp`) REFERENCES `compra` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra_producto`
--

LOCK TABLES `compra_producto` WRITE;
/*!40000 ALTER TABLE `compra_producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `compra_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_venta` (
  `ID_producto` int(11) NOT NULL,
  `ID_venta` int(11) NOT NULL,
  `pproducto` decimal(8,4) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID_producto`,`ID_venta`),
  KEY `ID_venta` (`ID_venta`),
  CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`ID_producto`) REFERENCES `producto` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`ID_venta`) REFERENCES `venta` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` int(11) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `precioUnitario` decimal(8,4) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `imagen` varchar(100) DEFAULT NULL,
  `piezas` int(11) DEFAULT NULL,
  `pertenece` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `categoria` (`categoria`),
  KEY `pertenece` (`pertenece`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`pertenece`) REFERENCES `producto` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES
(1,1,'Caja de Mazapanes','',30.5000,1,'mazapan.jpg',20,NULL),
(2,1,'Caja de Mazapanes de Chocolate','',40.5000,1,'mazapan-chocolate.jpg',20,NULL);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_ubicacion` int(11) DEFAULT NULL,
  `nempresa` varchar(30) DEFAULT NULL,
  `nencargado` varchar(20) DEFAULT NULL,
  `appat` varchar(20) DEFAULT NULL,
  `apmat` varchar(20) DEFAULT NULL,
  `calle` varchar(100) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `telefono` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_ubicacion` (`ID_ubicacion`),
  CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`ID_ubicacion`) REFERENCES `ubicacion` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES
(1,10,'Dulces de la Rosa','Juan','Reynoso','Higareda','Mijarez',788,'Proveedor por mayoreo.','Delarosa11@outlook.com',1,'496-996-88-77'),
(2,12,'Super sweets','Smith','White','Brady','Life',411,'Proveedor extranjero por mayoreo.','sweets12@gmail.com',1,'814-78-95-66'),
(3,15,'Dulces Japoneses','Asuna','Kiribama','Yahoko','Esencia',777,'Proveedor extranjero.','Djapon@gmail.com',1,'267-54-70-11'),
(4,14,'Dulces Chinos','Kasuto','Atoriyama','Kamazaky','Legendaria',877,'Proveedor extranjero.','Dchinos@gmail.com',1,'241-881-77-22'),
(5,13,'Tasty sweets','Tom','Staham','Freed','Shine',72,'Proveedor extranjero.','TastySweets@gmail.com',1,'805-557-44-88');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sucursal`
--

DROP TABLE IF EXISTS `sucursal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sucursal` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_ubicacion` int(11) DEFAULT NULL,
  `calle` varchar(100) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `horarioap` time DEFAULT NULL,
  `horariocierre` time DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_1` (`ID_ubicacion`),
  CONSTRAINT `fk_1` FOREIGN KEY (`ID_ubicacion`) REFERENCES `ubicacion` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursal`
--

LOCK TABLES `sucursal` WRITE;
/*!40000 ALTER TABLE `sucursal` DISABLE KEYS */;
INSERT INTO `sucursal` VALUES
(1,11,'Av. Universidad',630,'449-145-78-95','crazyuni@gmail.com',1,'09:00:00','22:00:00'),
(2,2,'Heroes',455,'659-458-75-15','crazyheroes@gmail.com',1,'09:00:00','21:00:00'),
(3,3,'Caracas',758,'659-784-12-51','crazycaracas@gmail.com',1,'09:00:00','22:00:00'),
(4,4,'Hernan',65,'449-821-46-52','crazypancho@gmail.com',1,'09:00:00','21:00:00'),
(5,5,'Huerta',45,'449-102-30-40','crazycalvillo@gmail.com',1,'09:00:00','22:00:00'),
(6,6,'Guerreros',782,'461-758-94-42','crazymadero@gmail.com',1,'08:00:00','22:00:00'),
(7,7,'Jimenez',701,'461-654-98-12','crazyiztapalapa@gmail.com',1,'09:00:00','21:00:00'),
(8,8,'Magallanez',305,'313-513-74-20','crazymich@gmail.com',1,'08:00:00','20:00:00'),
(9,10,'Villa',145,'496-784-96-32','crazyzac@gmail.com',1,'09:00:00','21:00:00'),
(10,1,'Av. Interceptor',888,'449-872-45-98','crazyint@gmail.com',1,'09:00:00','22:00:00');
/*!40000 ALTER TABLE `sucursal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sucursal_producto`
--

DROP TABLE IF EXISTS `sucursal_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sucursal_producto` (
  `ID_sucursal` int(11) NOT NULL,
  `ID_producto` int(11) NOT NULL,
  `existencias` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID_sucursal`,`ID_producto`),
  KEY `ID_producto` (`ID_producto`),
  CONSTRAINT `sucursal_producto_ibfk_1` FOREIGN KEY (`ID_sucursal`) REFERENCES `sucursal` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `sucursal_producto_ibfk_2` FOREIGN KEY (`ID_producto`) REFERENCES `producto` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursal_producto`
--

LOCK TABLES `sucursal_producto` WRITE;
/*!40000 ALTER TABLE `sucursal_producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `sucursal_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicacion`
--

DROP TABLE IF EXISTS `ubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ubicacion` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(30) DEFAULT NULL,
  `ciudad` varchar(30) DEFAULT NULL,
  `colonia` varchar(30) DEFAULT NULL,
  `cp` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicacion`
--

LOCK TABLES `ubicacion` WRITE;
/*!40000 ALTER TABLE `ubicacion` DISABLE KEYS */;
INSERT INTO `ubicacion` VALUES
(1,'Aguascalientes','Aguascalientes','Fatima','20130'),
(2,'Chihuahua','Chihuahua','Independencia','2000'),
(3,'Chihuahua','Ahumada','Revolución','15243'),
(4,'Aguascalientes','San pancho','Reales','79896'),
(5,'Aguascalientes','Calvillo','Rio azul','78410'),
(6,'Cd Mexico','Gustavo A. Madero','Juarez','14569'),
(7,'Cd Mexico','Iztapalapa','Zaragoza','74183'),
(8,'Michoacan','Morelia','Estudiantes','43197'),
(9,'Michoacan','Uruapan','Hidalgo','93752'),
(10,'Zacatecas','Guadalupe','Revolucion','97453'),
(11,'Aguascalientes','Aguascalientes','Sab J. Arenal','20130'),
(12,'California USA','Los Angeles','Misuri','75123'),
(13,'Minnesota USA','Minneapolis','Central ave SE','55407'),
(14,'Yuzhong China','Lanzhou','Gansu','730199'),
(15,'Nagano Japon','Sako','Nakagomi','30201');
/*!40000 ALTER TABLE `ubicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_sucursal` int(11) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `appat` varchar(30) DEFAULT NULL,
  `apmat` varchar(30) DEFAULT NULL,
  `privilegios` enum('administrador','vendedor','almacenista','reponedor') DEFAULT NULL,
  `des` varchar(200) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `activo` tinyint(1) DEFAULT 0,
  `imagen` varchar(100) DEFAULT 'default.png',
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email` (`email`),
  KEY `ID_sucursal` (`ID_sucursal`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`ID_sucursal`) REFERENCES `sucursal` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES
(1,1,'b460b1982188f11d175f60ed670027e1afdd16558919fe47023ecd38329e0b7f','Hector','Perez','Lopez','reponedor','Tiempo completo','hect11@outlook.com',1,0,'default.png','449-789-52-45'),
(2,1,'e82827b00b2ca8620beb37f879778c082b292a52270390cff35b6fe3157f4e8b','Ana Maria','Reyes','Hernandez','vendedor','Tiempo medio','Mariaes@protonmail.com',1,0,'default.png','449-852-78-44'),
(3,1,'e1f9d22462069f21a3537f3476fa7e99665f3ca2c9d37fbfa8b755170aa8461c','Juan Carlos','Alonso','Bravo','administrador','Tiempo completo','Juka@gmail.com',1,0,'default.png','449-874-00-41'),
(4,1,'4d7a6ff89a07162c382478fcd35e722c01c8c85a38922726fad8c5da83472a94','Ricardo','Perez','Reynoso','almacenista','Tiempo completo','Riki@gmail.com',1,0,'default.png','449-478-08-45'),
(5,1,'4c4228129e6b328c10cdf678003888d6f3156ccb53615ab10f7f67c5836bb4fa','Samantha','Esparragoza','Delgado','vendedor','Tiempo completo','Sami@gmail.com',1,0,'default.png','449-144-80-78'),
(6,1,'ca7b3af8a2cf36f63221bb25522cea3941762c2ce006c7a694d8db783ebf9e9a','Manuel','Bravo','Cisneros','almacenista','Tiempo completo','Manue@gmail.com',1,0,'default.png','449-150-47-44'),
(7,1,'acba9915e924c05cf670f280f5ae516a024edf32c363d8cc342df45c78c1f077','Teresa','Villalpando','Cruz','reponedor','Tiempo completo','Tere11@outlook.com',1,0,'default.png','449-754-05-01'),
(8,1,'9c51b72e643cfebb5a94bd374ea8ab154fd5426637896f583742b3c13ab4970e','Kirito','Honda','Akiriyama','vendedor','Tiempo completo','Kiri56@gmail.com',1,0,'default.png','449-044-87-47'),
(9,1,'1d2edc8ab8d305887120870b84897272f53ddd8c3ea70819ffe1173e4ae0c8e3','Yadira','Esparza','Guzman','almacenista','Tiempo medio.','Yadi@gmail.com',1,0,'default.png','449-888-74-55'),
(10,1,'86bd2f8301c869acc8ba530756cb795bd080c6a809d7aa91ffd6ce7af4198722','Lolita','Reyes','Torres','vendedor','Tiempo Completo.','Lolii@gmail.com',1,0,'default.png','449-111-47-54'),
(11,2,'a2561a496c0cd5ee4e8c37833846f24eb6747526c6169100ea1c342b9d23e7ee','Luis Enrique','Lopez','Almada','reponedor','Tiempo completo.','Lenrique@outlook.com',1,0,'default.png','658-789-98-88'),
(12,2,'bdf842aec979fca4466729793bd6e09816e32cfc3c05a54910270d6c8d871171','Raul','Martinez','Contreras','administrador','Tiempo completo.','Raul115@gmail.com',1,0,'default.png','685-452-81-00'),
(13,2,'915ad4484089145f7d29e435b9754f0b8a1608e40ed130ee758a204f5a5f92b5','Jessica','Villalpando','Juarez','vendedor','Tiempo completo.','Jessi8@outlook.com',1,0,'default.png','685-854-11-99'),
(14,2,'27212e5661106b3298e28def365d758a7591cc91fb5d08cc6acd58fa02eba43b','Almendra','Rodriguez','Gutierrez','vendedor','Tiempo completo.','Alme12@gmail.com',1,0,'default.png','685-952-12-33'),
(15,2,'940fc061d45e7e5e5c9cd3b751cffbe002a2e04415e8d7a381657cb0982dcd49','Maria','Torres','Martinez','vendedor','Tiempo completo.','Mariii88@gmail.com',1,0,'default.png','685-981-00-20'),
(16,2,'8fa56ffbb5a2ddf7ac363b7a1eb80abb6e475dcb1de7fa38060585212ff33cee','Jony','Beltran','Leiva','reponedor','Tiempo completo.','jony11i@gmail.com',1,0,'default.png','685-487-30-00'),
(17,2,'5fffde61c0f07130b5cfd0a278f25a936378a89202bb7db876c8739c15d7d085','Felipe','Cruz','Guzman','almacenista','Tiempo completo.','Felo12@outlook.com',1,0,'default.png','685-258-16-91'),
(18,2,'e3de3a6dd09737341dd98ce0714ed8d23ba70d253f87b515e25f7f73cc32b8d0','Juan','Guevara','Ruiseñor','almacenista','Tiempo completo.','Juanitoalimania@gmail.com',1,0,'default.png','685-951-19-43'),
(19,2,'e337dd6b852d6dbce3075c376c1cba41a8bb41c9cea1ae5f8fd25a99dac161fe','Guillermo','Vazquez','Alonso','reponedor','Tiempo completo.','Guille14@outlook.com',1,0,'default.png','685-025-85-20'),
(20,2,'68f3717213b645c3c930949335636c6e6406cea98db7535597eff692ea8e2c42','Mabel','Magon','Hernandez','almacenista','Tiempo completo.','Mabii12@gmail.com',1,0,'default.png','685-951-03-08'),
(21,1,'5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','Gandi','Perruno','Diaz','vendedor','caja 8','Gandii@gmail.com',1,0,'default.png','487-962-14-55');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venta` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_usuario` int(11) DEFAULT NULL,
  `ID_sucursal` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `fechav` datetime DEFAULT NULL,
  `total` decimal(11,4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_usuario` (`ID_usuario`),
  KEY `ID_sucursal` (`ID_sucursal`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`ID_usuario`) REFERENCES `usuario` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`ID_sucursal`) REFERENCES `sucursal` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-30 21:24:29