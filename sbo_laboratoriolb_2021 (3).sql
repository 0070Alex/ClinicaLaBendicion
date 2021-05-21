-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3308
-- Tiempo de generación: 15-05-2021 a las 15:04:09
-- Versión del servidor: 8.0.18
-- Versión de PHP: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sbo_laboratoriolb_2021`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_solicitudes`
--

DROP TABLE IF EXISTS `estados_solicitudes`;
CREATE TABLE IF NOT EXISTS `estados_solicitudes` (
  `idEstadoSolicitud` int(11) NOT NULL AUTO_INCREMENT,
  `nombreEstadoSolicitud` varchar(50) NOT NULL,
  PRIMARY KEY (`idEstadoSolicitud`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estados_solicitudes`
--

INSERT INTO `estados_solicitudes` (`idEstadoSolicitud`, `nombreEstadoSolicitud`) VALUES
(1, '01-Creado'),
(2, '02-Enviado'),
(3, '03-Asignado'),
(4, '04-Análisis '),
(5, '06-Revisión '),
(6, '09-Espera '),
(7, '11-Finalizado'),
(8, '12-Rechazado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `expedientes`
--

DROP TABLE IF EXISTS `expedientes`;
CREATE TABLE IF NOT EXISTS `expedientes` (
  `idexpediente` int(11) NOT NULL AUTO_INCREMENT,
  `NoExpediente` varchar(30) NOT NULL,
  `Dpi` varchar(15) NOT NULL,
  `PrimerNombre` varchar(50) NOT NULL,
  `SegundoNombre` varchar(50) DEFAULT NULL,
  `OtroNombre` varchar(50) DEFAULT NULL,
  `PrimerApellido` varchar(50) NOT NULL,
  `SegundoApellido` varchar(50) DEFAULT NULL,
  `FechaNacimiento` varchar(12) NOT NULL,
  `TelDomicilio` varchar(15) DEFAULT NULL,
  `TelMovil` varchar(15) DEFAULT NULL,
  `Eamil` varchar(75) DEFAULT NULL,
  `Nit` varchar(10) DEFAULT NULL,
  `FechaCreacion` varchar(25) NOT NULL,
  `FechaModificacion` varchar(25) DEFAULT NULL,
  `UsuaroiCreacion` int(11) NOT NULL,
  `UsuarioModificaion` int(11) DEFAULT NULL,
  `numeroFactura` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idexpediente`),
  UNIQUE KEY `NoExpediente` (`NoExpediente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `expedientes`
--

INSERT INTO `expedientes` (`idexpediente`, `NoExpediente`, `Dpi`, `PrimerNombre`, `SegundoNombre`, `OtroNombre`, `PrimerApellido`, `SegundoApellido`, `FechaNacimiento`, `TelDomicilio`, `TelMovil`, `Eamil`, `Nit`, `FechaCreacion`, `FechaModificacion`, `UsuaroiCreacion`, `UsuarioModificaion`, `numeroFactura`) VALUES
(1, '2021-04-27-01-0000001', '2983312054875', 'Douglas', 'Alexander', NULL, 'Sacalxot', 'Elias', '01-05-1996', '25547865', '32243548', 'd.alexelias@gmail.com', '94754878', '31-03-2021 17:06:42', NULL, 10, NULL, '12345678910'),
(2, '2021-05-03-02-0000002', '', 'Katherine', 'Eunice', NULL, 'Castellanos', 'Martinez', '13-09-1993', '43565456', '34567865', 'castellanos@gmail.com', '45434567', '03-05-2021', NULL, 1, NULL, '123456789');

--
-- Disparadores `expedientes`
--
DROP TRIGGER IF EXISTS `tg_NoExpediente`;
DELIMITER $$
CREATE TRIGGER `tg_NoExpediente` BEFORE INSERT ON `expedientes` FOR EACH ROW BEGIN
DECLARE correlativo int;
SET correlativo =(SELECT ifnull(MAX(CONVERT(substring(idexpediente,1), signed integer)),0) FROM expedientes) +1;

set new.NoExpediente = concat(year(now()),'-',lpad(MONTH (NOW()),2,'0'),"-",lpad(DAY(NOW()),2,'0'),"-",lpad(correlativo,2,"0"),"-",lpad(correlativo,7,"0"));
    
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_medicas`
--

DROP TABLE IF EXISTS `solicitudes_medicas`;
CREATE TABLE IF NOT EXISTS `solicitudes_medicas` (
  `idSolicitudes` int(11) NOT NULL AUTO_INCREMENT,
  `codigoSolicitud` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `tipoSolicitante` int(4) NOT NULL,
  `tipoSolicitud` int(11) NOT NULL,
  `Descripcion` varchar(2000) NOT NULL,
  `NoExpediente` varchar(30) NOT NULL,
  `nit` varchar(10) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `Telefono` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `FechaCreacion` varchar(25) NOT NULL,
  `FechaModificacion` varchar(25) DEFAULT NULL,
  `UsuarioCreacion` int(11) NOT NULL,
  `UsuarioModificacion` int(11) DEFAULT NULL,
  `UsuarioAsignacion` int(11) DEFAULT NULL,
  `tipoSoporte` int(2) NOT NULL,
  `numSoporte` varchar(50) NOT NULL,
  `estado_solicitud` int(11) DEFAULT NULL,
  PRIMARY KEY (`idSolicitudes`),
  KEY `tipoSolicitante` (`tipoSolicitante`),
  KEY `tipoSolicitud` (`tipoSolicitud`),
  KEY `estado_solicitud` (`estado_solicitud`),
  KEY `NoExpediente` (`NoExpediente`),
  KEY `tipoSoporte` (`tipoSoporte`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `solicitudes_medicas`
--

INSERT INTO `solicitudes_medicas` (`idSolicitudes`, `codigoSolicitud`, `tipoSolicitante`, `tipoSolicitud`, `Descripcion`, `NoExpediente`, `nit`, `nombre`, `Telefono`, `email`, `FechaCreacion`, `FechaModificacion`, `UsuarioCreacion`, `UsuarioModificacion`, `UsuarioAsignacion`, `tipoSoporte`, `numSoporte`, `estado_solicitud`) VALUES
(1, 'IN-20210512-00001', 10, 1, 'gjhgjhgjh', '2021-05-03-02-0000002', '45434567', 'Katherine Castellanos', '45687678', 'ktha@gmail.com', '12-05-2021', NULL, 2, NULL, NULL, 2, 'AAA50000', 1),
(2, 'IN-20210512-00002', 10, 1, 'faltadocumento', '2021-05-03-02-0000002', '45434567', 'Katherine Castellanos', '45687678', 'ktha@gmail.com', '12-05-2021', NULL, 2, NULL, NULL, 3, '10000AAAAAAAAAA', 1),
(3, 'IN-20210513-00003', 10, 1, 'FaltopresentarDocumento', '2021-04-27-01-0000001', '94754878', 'Douglas Sacalxot', '58689785', 'elias@gmail.com', '13-05-2021', NULL, 2, NULL, NULL, 4, 'BBBB101010101020202020', 1),
(4, 'IN-20210514-00004', 10, 1, 'adfasf', '2021-05-03-02-0000002', '45434567', 'Katherine Castellanos', '54585658', 'ktha@gmail.com', '14-05-2021', NULL, 2, NULL, NULL, 4, '10000AAAAAAAAAA', 1),
(5, 'IN-20210515-00005', 10, 1, 'afdasf', '2021-04-27-01-0000001', '94754878', 'Douglas Sacalxot', '54585658', 'ktha@gmail.com', '15-05-2021', NULL, 2, NULL, NULL, 2, '10000AAAAAAAAAA', 1),
(6, 'EX-20210515-00006', 20, 1, 'Notrajodocumento', '2021-04-27-01-0000001', '94754878', 'Douglas Sacalxot', '45685245', 'ejemplo@gmail.com', '15-05-2021', NULL, 2, NULL, NULL, 1, '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `soporte`
--

DROP TABLE IF EXISTS `soporte`;
CREATE TABLE IF NOT EXISTS `soporte` (
  `idSoporte` int(2) NOT NULL AUTO_INCREMENT,
  `nombreSoporte` varchar(25) DEFAULT NULL,
  `idTipoSoporte` int(2) NOT NULL,
  PRIMARY KEY (`idSoporte`),
  KEY `idTipoSoporte` (`idTipoSoporte`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `soporte`
--

INSERT INTO `soporte` (`idSoporte`, `nombreSoporte`, `idTipoSoporte`) VALUES
(1, 'SM-Solicitud Medica', 1),
(2, 'ET- Examén externo', 1),
(3, 'FP-FCTURA', 2),
(4, 'HO-Hoja de oficio', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_solicitantes`
--

DROP TABLE IF EXISTS `tipos_solicitantes`;
CREATE TABLE IF NOT EXISTS `tipos_solicitantes` (
  `idTipoSolicitante` int(4) NOT NULL,
  `nombreTipoSolicitante` varchar(30) NOT NULL,
  PRIMARY KEY (`idTipoSolicitante`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipos_solicitantes`
--

INSERT INTO `tipos_solicitantes` (`idTipoSolicitante`, `nombreTipoSolicitante`) VALUES
(10, 'IN-Usuario interno'),
(20, 'EX-Usuario externo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_solicitante_recovery`
--

DROP TABLE IF EXISTS `tipos_solicitante_recovery`;
CREATE TABLE IF NOT EXISTS `tipos_solicitante_recovery` (
  `condigoSolicitud` int(11) NOT NULL AUTO_INCREMENT,
  `codigoTipoSolicitud` int(4) DEFAULT NULL,
  PRIMARY KEY (`condigoSolicitud`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tipos_solicitante_recovery`
--

INSERT INTO `tipos_solicitante_recovery` (`condigoSolicitud`, `codigoTipoSolicitud`) VALUES
(1, 10),
(2, 10),
(3, 10),
(4, 10),
(5, 10),
(6, 20);

--
-- Disparadores `tipos_solicitante_recovery`
--
DROP TRIGGER IF EXISTS `generar_codigo`;
DELIMITER $$
CREATE TRIGGER `generar_codigo` AFTER INSERT ON `tipos_solicitante_recovery` FOR EACH ROW BEGIN

    DECLARE correlativo int;
    DECLARE tsp int;
   
   
    SET correlativo =(SELECT max(condigoSolicitud) FROM tipos_solicitante_recovery);

    SET tsp =(SELECT codigoTipoSolicitud FROM tipos_solicitante_recovery ORDER BY condigoSolicitud DESC LIMIT 1);
 	

     IF (tsp = 10) THEN 
    BEGIN
    update solicitudes_medicas	set codigoSolicitud = concat(('IN'),'-',year(now()),lpad(MONTH (NOW()),2,'0'),lpad(DAY(NOW()),2,'0'),'-',lpad(correlativo,5,"0")) WHERE idSolicitudes
    	=correlativo;
	
	END; 
	 ELSEIF (tsp = 20) THEN 
	BEGIN
    	update solicitudes_medicas set codigoSolicitud = concat(('EX'),'-',year(now()),lpad(MONTH (NOW()),2,'0'),lpad(DAY(NOW()),2,'0'),'-',lpad(correlativo,5,"0")) WHERE idSolicitudes
    	=correlativo;
	END;
	END IF;  
	
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_solicitudes`
--

DROP TABLE IF EXISTS `tipos_solicitudes`;
CREATE TABLE IF NOT EXISTS `tipos_solicitudes` (
  `idTipoSolicitud` int(11) NOT NULL AUTO_INCREMENT,
  `nombreTipoSolicitud` varchar(50) NOT NULL,
  PRIMARY KEY (`idTipoSolicitud`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipos_solicitudes`
--

INSERT INTO `tipos_solicitudes` (`idTipoSolicitud`, `nombreTipoSolicitud`) VALUES
(1, 'MM-Muestra medica'),
(2, 'LQ-Laboratorio ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_soporte`
--

DROP TABLE IF EXISTS `tipo_soporte`;
CREATE TABLE IF NOT EXISTS `tipo_soporte` (
  `idSoporte` int(2) NOT NULL AUTO_INCREMENT,
  `tipoSoporte` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idSoporte`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tipo_soporte`
--

INSERT INTO `tipo_soporte` (`idSoporte`, `tipoSoporte`) VALUES
(1, 'Interno'),
(2, 'Externo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `EntityID` int(11) NOT NULL AUTO_INCREMENT,
  `PrimerNombre` varchar(30) NOT NULL,
  `SegundoNombre` varchar(30) DEFAULT NULL,
  `OtroNombre` varchar(25) DEFAULT NULL,
  `PrimerApellido` varchar(30) NOT NULL,
  `SegundoApellido` varchar(30) DEFAULT NULL,
  `Usuario` varchar(12) NOT NULL,
  `PasswordUser` varchar(18) NOT NULL,
  `FechaNacimiento` varchar(15) NOT NULL,
  `Genero` int(11) NOT NULL,
  `Telefono` varchar(12) NOT NULL,
  `Movil` varchar(12) DEFAULT NULL,
  `Correo` varchar(60) DEFAULT NULL,
  `FechaCreacion` varchar(25) NOT NULL,
  `FechaModificacion` varchar(15) DEFAULT NULL,
  `Estado` int(11) NOT NULL,
  PRIMARY KEY (`EntityID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`EntityID`, `PrimerNombre`, `SegundoNombre`, `OtroNombre`, `PrimerApellido`, `SegundoApellido`, `Usuario`, `PasswordUser`, `FechaNacimiento`, `Genero`, `Telefono`, `Movil`, `Correo`, `FechaCreacion`, `FechaModificacion`, `Estado`) VALUES
(2, 'Douglas', 'Alexander', NULL, 'Sacalxot', 'Elias', 'Elias3224', '@elias3224', '01-05-1996', 1, '24365878', '53856987', 'd.alexelias@gmail.com', '31-03-2021 17:06:42', NULL, 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `solicitudes_medicas`
--
ALTER TABLE `solicitudes_medicas`
  ADD CONSTRAINT `solicitudes_medicas_ibfk_2` FOREIGN KEY (`tipoSolicitud`) REFERENCES `tipos_solicitudes` (`idTipoSolicitud`),
  ADD CONSTRAINT `solicitudes_medicas_ibfk_3` FOREIGN KEY (`estado_solicitud`) REFERENCES `estados_solicitudes` (`idEstadoSolicitud`),
  ADD CONSTRAINT `solicitudes_medicas_ibfk_4` FOREIGN KEY (`NoExpediente`) REFERENCES `expedientes` (`NoExpediente`),
  ADD CONSTRAINT `solicitudes_medicas_ibfk_5` FOREIGN KEY (`tipoSoporte`) REFERENCES `soporte` (`idSoporte`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `solicitudes_medicas_ibfk_6` FOREIGN KEY (`tipoSolicitante`) REFERENCES `tipos_solicitantes` (`idTipoSolicitante`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `soporte`
--
ALTER TABLE `soporte`
  ADD CONSTRAINT `soporte_ibfk_1` FOREIGN KEY (`idTipoSoporte`) REFERENCES `tipo_soporte` (`idSoporte`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
