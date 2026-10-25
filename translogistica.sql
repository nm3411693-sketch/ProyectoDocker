-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-09-2026 a las 23:23:35
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `translogistica_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_clientes` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `fecha_registro` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_clientes`, `nombre`, `telefono`, `direccion`, `fecha_registro`) VALUES
(1, 'Laura Martínez', '3104567890', 'Cra 12 # 15-30, Santa Rosa de Cabal', '2026-09-01'),
(2, 'Carlos Ramírez', '3156782341', 'Calle 10 # 8-45, Santa Rosa de Cabal', '2026-09-03'),
(3, 'Andrés Gómez', '3007894562', 'Cra 14 # 20-18, Santa Rosa de Cabal', '2026-09-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `envios`
--

CREATE TABLE `envios` (
  `id_envio` int(11) NOT NULL,
  `nro_guía` varchar(100) NOT NULL,
  `descripcion` varchar(40) NOT NULL,
  `fecha_envio` date NOT NULL,
  `destino` varchar(50) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `precio_envío` decimal(10,0) NOT NULL,
  `tiempo_entrega` time NOT NULL,
  `id_clientes` int(11) DEFAULT NULL,
  `id_rutas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `envios`
--

INSERT INTO `envios` (`id_envio`, `nro_guía`, `descripcion`, `fecha_envio`, `destino`, `estado`, `precio_envío`, `tiempo_entrega`, `id_clientes`, `id_rutas`) VALUES
(1, 'TL-0001', 'Documentos empresariales', '2026-08-10', 'Pereira', 'Entregado', 18000, '01:30:00', 1, 6),
(2, 'TL-0002', 'Paquete de ropa', '2026-09-11', 'Dosquebradas', 'En tránsito', 25000, '02:00:00', 2, 7),
(3, 'TL-0003', 'Productos electrónicos', '2026-07-12', 'Santa Rosa de Cabal', 'Pendiente', 32000, '03:00:00', 3, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rutas`
--

CREATE TABLE `rutas` (
  `id_ruta` int(11) NOT NULL,
  `origen` text NOT NULL,
  `destino` varchar(40) NOT NULL,
  `distancia` varchar(100) NOT NULL,
  `tiempo_ruta` time NOT NULL,
  `codigo_postal` int(11) NOT NULL,
  `id_vehiculos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rutas`
--

INSERT INTO `rutas` (`id_ruta`, `origen`, `destino`, `distancia`, `tiempo_ruta`, `codigo_postal`, `id_vehiculos`) VALUES
(6, 'Santa Rosa de Cabal', 'Pereira', '15.5', '00:35:00', 660007, 1),
(7, 'Santa Rosa de Cabal', 'Dosquebradas', '12.2', '00:25:00', 661001, 2),
(8, 'Santa Rosa de Cabal', 'Santa Rosa de Cabal', '2', '00:10:00', 661020, 3),
(9, 'Santa Rosa de Cabal', 'Santa Rosa de Cabal', '7.5', '00:40:00', 661027, 4),
(10, 'Santa Rosa de Cabal', 'Santa Rosa de Cabal', '1.0', '00:10:00', 661020, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `satisfacción`
--

CREATE TABLE `satisfacción` (
  `id_encuesta` int(11) NOT NULL,
  `calificacion` int(5) NOT NULL,
  `fecha_encuesta` date NOT NULL,
  `opinion` varchar(100) NOT NULL,
  `id_envios` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `satisfacción`
--

INSERT INTO `satisfacción` (`id_encuesta`, `calificacion`, `fecha_encuesta`, `opinion`, `id_envios`) VALUES
(1, 5, '2026-08-13', 'El envío llegó en buen estado y a tiempo.', 1),
(2, 4, '2026-09-15', 'El servicio fue bueno, aunque tuvo un poco de demora.', 2),
(3, 5, '2026-07-15', 'La atención fue buena y la información del envío fue clara.', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE `vehiculos` (
  `id_vehiculo` int(11) NOT NULL,
  `tipo_vehiculo` varchar(30) NOT NULL,
  `placa` varchar(7) NOT NULL,
  `costos` decimal(10,0) NOT NULL,
  `fecha_salida` date NOT NULL,
  `gps_activo` tinyint(1) NOT NULL,
  `capacidad` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`id_vehiculo`, `tipo_vehiculo`, `placa`, `costos`, `fecha_salida`, `gps_activo`, `capacidad`) VALUES
(1, 'Camión', 'KLM482', 180000, '2026-08-10', 1, '5000'),
(2, 'Camión', 'PTR731', 220000, '2026-09-11', 1, '7000'),
(3, 'Camión', 'WQF256', 195000, '2026-07-12', 1, '6000'),
(4, 'Camión', 'HJS914', 250000, '2026-09-13', 1, '8000'),
(5, 'Camión', 'NVC638', 210000, '2026-09-14', 1, '6500');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_clientes`);

--
-- Indices de la tabla `envios`
--
ALTER TABLE `envios`
  ADD PRIMARY KEY (`id_envio`),
  ADD UNIQUE KEY `nro_guía` (`nro_guía`),
  ADD KEY `fk_envios_clientes` (`id_clientes`),
  ADD KEY `fk_envios_rutas` (`id_rutas`);

--
-- Indices de la tabla `rutas`
--
ALTER TABLE `rutas`
  ADD PRIMARY KEY (`id_ruta`),
  ADD KEY `fk_ruta_vehiculo` (`id_vehiculos`);

--
-- Indices de la tabla `satisfacción`
--
ALTER TABLE `satisfacción`
  ADD PRIMARY KEY (`id_encuesta`),
  ADD KEY `fk_satisfaccion_envio` (`id_envios`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`id_vehiculo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_clientes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `envios`
--
ALTER TABLE `envios`
  MODIFY `id_envio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `rutas`
--
ALTER TABLE `rutas`
  MODIFY `id_ruta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `satisfacción`
--
ALTER TABLE `satisfacción`
  MODIFY `id_encuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `id_vehiculo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `envios`
--
ALTER TABLE `envios`
  ADD CONSTRAINT `fk_envios_clientes` FOREIGN KEY (`id_clientes`) REFERENCES `clientes` (`id_clientes`),
  ADD CONSTRAINT `fk_envios_rutas` FOREIGN KEY (`id_rutas`) REFERENCES `rutas` (`id_ruta`);

--
-- Filtros para la tabla `rutas`
--
ALTER TABLE `rutas`
  ADD CONSTRAINT `fk_ruta_vehiculo` FOREIGN KEY (`id_vehiculos`) REFERENCES `vehiculos` (`id_vehiculo`);

--
-- Filtros para la tabla `satisfacción`
--
ALTER TABLE `satisfacción`
  ADD CONSTRAINT `fk_satisfaccion_envio` FOREIGN KEY (`id_envios`) REFERENCES `envios` (`id_envio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
