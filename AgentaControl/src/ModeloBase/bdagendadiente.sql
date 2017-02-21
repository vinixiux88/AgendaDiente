-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-02-2017 a las 16:25:37
-- Versión del servidor: 5.6.17
-- Versión de PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `bdagendadiente`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarUsuario`(IN `nom` VARCHAR(45), IN `ape` VARCHAR(45), IN `dir` VARCHAR(45), IN `tel` VARCHAR(45), IN `email` VARCHAR(45), IN `usu` VARCHAR(45), IN `pass` VARCHAR(45), IN `id` INT)
    NO SQL
begin
	update usuario set Nombre=nom,Apellidos=ape,Direccion=dir,Telefono=tel,Correo=email,Usuario=usu,Contrasena=pass where idUsuario=id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarBitacora`(IN `act` VARCHAR(400))
    NO SQL
begin
	insert into bitacora(Accion) values (act);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetalle`(IN `des` VARCHAR(45), IN `opcion` INT, IN `diente` INT, IN `tratamiento` INT, IN `estado` INT)
    NO SQL
begin
	insert into detalletratamiento(Descripcion,OpcionTratameinto_idOpcionTratamiento,ListadoDientes_idListadoDiente,Tratameinto_idTratamiento,estadoDetalle)values(des,opcion,diente,tratamiento,estado);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarGasto`(IN `fac` VARCHAR(45), IN `total` DOUBLE, IN `usu` INT)
    NO SQL
begin
	insert into comprobantegastos(NumFactura,Total,usuario_idUsuario) values(fac,total,usu);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarNuevoTratamiento`(IN `des` VARCHAR(45), IN `cos` DOUBLE)
    NO SQL
begin
	insert into opciontratamiento(Descripcion,Costo)values(des,cos);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarPaciente`(in dpi varchar(45),in nom varchar(45),in sex varchar(45),in edad int,in dir varchar(45),in tel varchar(45),in mail varchar(45))
begin 
	insert into paciente(Dpi,Nombres,Sexo,Edad,Direccion,Telefono,Correo) values (dpi,nom,sex,edad,dir,tel,mail);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarPago`(IN `cuenta` DOUBLE, IN `paciente` INT)
    NO SQL
begin

	insert into comprobantepago(monto,Paciente_idPaciente)values(cuenta,paciente);

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarTratamiento`(IN `tot` DOUBLE, IN `comen` VARCHAR(200), IN `estado` INT, IN `paciente` INT)
    NO SQL
begin
	insert into tratamiento(Total,Comentarios,estadoTratamiento,Paciente_idPaciente)values(tot,comen,estado,paciente);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarUsuario`(in nom varchar(45),in ape varchar(45),in dir varchar(50),in tel varchar(45),in email varchar(45),in us varchar(45),in pass varchar(45),in tipo int(11))
begin
	insert into usuario(Nombre, Apellidos,Direccion,Telefono,Correo,User,contrasena,tipoUsuario_idtipoUsuario) values (nom,ape,dir,tel,email,us,pass,tipo);
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora`
--

CREATE TABLE IF NOT EXISTS `bitacora` (
  `idBitacora` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NULL DEFAULT NULL,
  `Accion` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`idBitacora`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprobantegastos`
--

CREATE TABLE IF NOT EXISTS `comprobantegastos` (
  `idComprobanteGastos` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `NumFactura` varchar(45) DEFAULT NULL,
  `Total` double DEFAULT NULL,
  `usuario_idUsuario` int(11) NOT NULL,
  PRIMARY KEY (`idComprobanteGastos`),
  KEY `fk_comprobantegastos_usuario1_idx` (`usuario_idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprobantepago`
--

CREATE TABLE IF NOT EXISTS `comprobantepago` (
  `idComprobantePago` int(11) NOT NULL AUTO_INCREMENT,
  `monto` varchar(45) DEFAULT NULL,
  `Paciente_idPaciente` int(11) NOT NULL,
  PRIMARY KEY (`idComprobantePago`),
  KEY `fk_ComprobantePago_Paciente1_idx` (`Paciente_idPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalletratamiento`
--

CREATE TABLE IF NOT EXISTS `detalletratamiento` (
  `idDetalleTratamiento` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(45) DEFAULT NULL,
  `OpcionTratamiento_idOpcionTratamiento` int(11) NOT NULL,
  `ListadoDientes_idDiente` int(11) NOT NULL,
  `Tratamiento_idTratamiento` int(11) NOT NULL,
  `estadoDetalle` int(11) DEFAULT '0',
  PRIMARY KEY (`idDetalleTratamiento`),
  KEY `fk_DetalleTratamiento_OpcionTratamiento1_idx` (`OpcionTratamiento_idOpcionTratamiento`),
  KEY `fk_DetalleTratamiento_ListadoDientes1_idx` (`ListadoDientes_idDiente`),
  KEY `fk_DetalleTratamiento_Tratamiento1_idx` (`Tratamiento_idTratamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `listadodientes`
--

CREATE TABLE IF NOT EXISTS `listadodientes` (
  `idDiente` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idDiente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opciontratamiento`
--

CREATE TABLE IF NOT EXISTS `opciontratamiento` (
  `idOpcionTratamiento` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(45) DEFAULT NULL,
  `Costo` double DEFAULT NULL,
  PRIMARY KEY (`idOpcionTratamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE IF NOT EXISTS `paciente` (
  `idPaciente` int(11) NOT NULL AUTO_INCREMENT,
  `Dpi` varchar(45) DEFAULT NULL,
  `Nombres` varchar(45) DEFAULT NULL,
  `Sexo` varchar(45) DEFAULT NULL,
  `Edad` int(11) DEFAULT NULL,
  `Direccion` varchar(45) DEFAULT NULL,
  `Telefono` varchar(45) DEFAULT NULL,
  `Correo` varchar(45) DEFAULT NULL,
  `saldo` double DEFAULT '0',
  PRIMARY KEY (`idPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipousuario`
--

CREATE TABLE IF NOT EXISTS `tipousuario` (
  `idtipoUsuario` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtipoUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipousuario`
--

INSERT INTO `tipousuario` (`idtipoUsuario`, `descripcion`) VALUES
(1, 'Administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamiento`
--

CREATE TABLE IF NOT EXISTS `tratamiento` (
  `idTratamiento` int(11) NOT NULL AUTO_INCREMENT,
  `Total` double DEFAULT NULL,
  `Comentarios` varchar(200) DEFAULT NULL,
  `estadoTratamiento` int(11) DEFAULT '0',
  `Paciente_idPaciente` int(11) NOT NULL,
  PRIMARY KEY (`idTratamiento`),
  KEY `fk_Tratamiento_Paciente1_idx` (`Paciente_idPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) DEFAULT NULL,
  `Apellidos` varchar(45) DEFAULT NULL,
  `Direccion` varchar(45) DEFAULT NULL,
  `Telefono` varchar(45) DEFAULT NULL,
  `Correo` varchar(45) DEFAULT NULL,
  `Usuario` varchar(45) DEFAULT NULL,
  `contrasena` varchar(45) DEFAULT NULL,
  `tipoUsuario_idtipoUsuario` int(11) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `fk_Usuario_tipoUsuario_idx` (`tipoUsuario_idtipoUsuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `Nombre`, `Apellidos`, `Direccion`, `Telefono`, `Correo`, `Usuario`, `contrasena`, `tipoUsuario_idtipoUsuario`) VALUES
(1, 'pablo', 'sosa', 'salcaja', '12344556', 'pablo@hotmail.com', 'pablo', 'pablo', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comprobantegastos`
--
ALTER TABLE `comprobantegastos`
  ADD CONSTRAINT `fk_comprobantegastos_usuario1` FOREIGN KEY (`usuario_idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `comprobantepago`
--
ALTER TABLE `comprobantepago`
  ADD CONSTRAINT `fk_ComprobantePago_Paciente1` FOREIGN KEY (`Paciente_idPaciente`) REFERENCES `paciente` (`idPaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalletratamiento`
--
ALTER TABLE `detalletratamiento`
  ADD CONSTRAINT `fk_DetalleTratamiento_ListadoDientes1` FOREIGN KEY (`ListadoDientes_idDiente`) REFERENCES `listadodientes` (`idDiente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleTratamiento_OpcionTratamiento1` FOREIGN KEY (`OpcionTratamiento_idOpcionTratamiento`) REFERENCES `opciontratamiento` (`idOpcionTratamiento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleTratamiento_Tratamiento1` FOREIGN KEY (`Tratamiento_idTratamiento`) REFERENCES `tratamiento` (`idTratamiento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD CONSTRAINT `fk_Tratamiento_Paciente1` FOREIGN KEY (`Paciente_idPaciente`) REFERENCES `paciente` (`idPaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_Usuario_tipoUsuario` FOREIGN KEY (`tipoUsuario_idtipoUsuario`) REFERENCES `tipousuario` (`idtipoUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
