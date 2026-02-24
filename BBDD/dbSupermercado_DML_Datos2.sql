/*
========================================================================
PARTE 2: AÑADIR 10 OFERTAS Y ASIGNARLAS A TIENDAS Y PRODUCTOS
========================================================================
*/

USE dbSupermercado;

BEGIN;

-- Añadir más ofertas
INSERT INTO tblOfertas(detalle, oferta, valor, tipo_descuento, idcategoria)
VALUES
(UPPER('Oferta 15% descuento'), UPPER('15%'), 15, 2, 14),
(UPPER('Oferta 25% descuento'), UPPER('25%'), 25, 2, 16),
(UPPER('Oferta 30% descuento'), UPPER('30%'), 30, 2, 17),
(UPPER('Oferta 40% descuento'), UPPER('40%'), 40, 2, 21),
(UPPER('Oferta 4X3 compra 4 y pagas 3'), UPPER('4X3'), 100, 2, 11),
(UPPER('Oferta 5€ descuento'), UPPER('-5€'), 5, 1, 13),
(UPPER('Oferta 2da unidad 70% descuento'), UPPER('2X70%'), 70, 2, 14);

-- Asignar ofertas a diferentes tiendas
-- Obtener IDs de ofertas
SELECT idoferta INTO @oferta_15 FROM tblOfertas WHERE oferta LIKE '15%';
SELECT idoferta INTO @oferta_25 FROM tblOfertas WHERE oferta LIKE '25%';
SELECT idoferta INTO @oferta_30 FROM tblOfertas WHERE oferta LIKE '30%';
SELECT idoferta INTO @oferta_40 FROM tblOfertas WHERE oferta LIKE '40%';
SELECT idoferta INTO @oferta_4x3 FROM tblOfertas WHERE oferta LIKE '4X3';
SELECT idoferta INTO @oferta_5e FROM tblOfertas WHERE oferta LIKE '-5€';
SELECT idoferta INTO @oferta_2x70 FROM tblOfertas WHERE oferta LIKE '2X70%';

-- Asignar ofertas a tiendas (fechas en formato YYYYMMDD como INT)
INSERT INTO tblTiendaOfertas(idtienda, idoferta, idsuper, finicio, fvencimiento)
VALUES
(1, @oferta_15, 0, 20250101, 20250131),
(2, @oferta_25, 0, 20250115, 20250215),
(3, @oferta_30, 1, 20250101, 20250228),
(4, @oferta_40, 0, 20250201, 20250228),
(5, @oferta_4x3, 1, 20250101, 20250331),
(6, @oferta_5e, 0, 20250115, 20250215),
(7, @oferta_2x70, 0, 20250201, 20250331),
(8, @oferta_15, 1, 20250101, 20250430),
(9, @oferta_25, 0, 20250301, 20250331),
(10, @oferta_30, 1, 20250115, 20250315);

-- Actualizar algunos productos con las nuevas ofertas
UPDATE tblProductos SET idoferta = @oferta_15 WHERE codigobarra IN (100011, 100021, 100031);
UPDATE tblProductos SET idoferta = @oferta_25 WHERE codigobarra IN (100041, 100051, 100061);
UPDATE tblProductos SET idoferta = @oferta_30 WHERE codigobarra IN (100071, 100081);
UPDATE tblProductos SET idoferta = @oferta_40 WHERE codigobarra IN (100091);
UPDATE tblProductos SET idoferta = @oferta_4x3 WHERE codigobarra IN (100012, 100022);
UPDATE tblProductos SET idoferta = @oferta_5e WHERE codigobarra IN (100042, 100052);

/*
========================================================================
PARTE 2: AÑADIR EMPLEADOS CON DISTINTOS CARGOS A VARIAS TIENDAS
========================================================================
*/

-- Obtener IDs de localidades y puestos
SELECT idlocalidad INTO @loc_madrid FROM tblLocalidades WHERE localidad LIKE 'Madrid';
SELECT idlocalidad INTO @loc_barcelona FROM tblLocalidades WHERE localidad LIKE 'Barcelona';
SELECT idlocalidad INTO @loc_valencia FROM tblLocalidades WHERE localidad LIKE 'Valencia';
SELECT idlocalidad INTO @loc_sevilla FROM tblLocalidades WHERE localidad LIKE 'Sevilla';

SELECT idpuesto INTO @puesto_gerente FROM tblPuestos WHERE puesto LIKE 'Gerente';
SELECT idpuesto INTO @puesto_jefe FROM tblPuestos WHERE puesto LIKE 'Jefe de area';
SELECT idpuesto INTO @puesto_cajero FROM tblPuestos WHERE puesto LIKE 'Cajero';
SELECT idpuesto INTO @puesto_dependiente FROM tblPuestos WHERE puesto LIKE 'Dependiente';
SELECT idpuesto INTO @puesto_empleado FROM tblPuestos WHERE puesto LIKE 'Empleado General';

-- Añadir empleados
INSERT INTO tblEmpleados(dni, nombre, apellidos, nacimiento, sexo, direccion1, direccion2, idlocalidad, telefono, email)
VALUES
('12345678A', 'Juan', 'García López', 15051985, 1, 'Calle Mayor 10', 'Madrid Centro', @loc_madrid, 611111111, 'juan.garcia@email.com'),
('23456789B', 'María', 'Martínez Sánchez', 20031990, 2, 'Av. Diagonal 50', 'Barcelona', @loc_barcelona, 622222222, 'maria.martinez@email.com'),
('34567890C', 'Pedro', 'Rodríguez Pérez', 10071988, 1, 'Calle Colón 25', 'Valencia', @loc_valencia, 633333333, 'pedro.rodriguez@email.com'),
('45678901D', 'Ana', 'López Fernández', 05121992, 2, 'Calle Sierpes 30', 'Sevilla', @loc_sevilla, 644444444, 'ana.lopez@email.com'),
('56789012E', 'Carlos', 'González Ruiz', 18091987, 1, 'Gran Vía 100', 'Madrid', @loc_madrid, 655555555, 'carlos.gonzalez@email.com'),
('67890123F', 'Laura', 'Sánchez Moreno', 22041991, 2, 'Rambla Catalunya 80', 'Barcelona', @loc_barcelona, 666666666, 'laura.sanchez@email.com'),
('78901234G', 'Miguel', 'Fernández Gil', 30061989, 1, 'Av. del Puerto 150', 'Valencia', @loc_valencia, 677777777, 'miguel.fernandez@email.com'),
('89012345H', 'Isabel', 'Díaz Castro', 12021993, 2, 'Plaza España 5', 'Sevilla', @loc_sevilla, 688888888, 'isabel.diaz@email.com'),
('90123456I', 'David', 'Muñoz Torres', 25111986, 1, 'Calle Alcalá 200', 'Madrid', @loc_madrid, 699999999, 'david.munoz@email.com'),
('01234567J', 'Carmen', 'Jiménez Ramos', 08081994, 2, 'Paseo Gracia 120', 'Barcelona', @loc_barcelona, 610101010, 'carmen.jimenez@email.com'),
('11223344K', 'Francisco', 'Ruiz Molina', 14021990, 1, 'Calle Paz 45', 'Valencia', @loc_valencia, 621212121, 'francisco.ruiz@email.com'),
('22334455L', 'Lucía', 'Moreno Ortiz', 03051988, 2, 'Av. Constitución 70', 'Sevilla', @loc_sevilla, 632323232, 'lucia.moreno@email.com'),
('33445566M', 'Antonio', 'Romero Delgado', 19101991, 1, 'Calle Goya 88', 'Madrid', @loc_madrid, 643434343, 'antonio.romero@email.com'),
('44556677N', 'Raquel', 'Navarro Iglesias', 27071989, 2, 'Av. Meridiana 200', 'Barcelona', @loc_barcelona, 654545454, 'raquel.navarro@email.com'),
('55667788O', 'José', 'Alonso Prieto', 11031992, 1, 'Calle Ruzafa 33', 'Valencia', @loc_valencia, 665656565, 'jose.alonso@email.com');

-- Asignar empleados a tiendas con sus puestos
-- Tienda 1 (Madrid)
INSERT INTO tblTiendaEmpleadosPuestos(idtienda, idempleado, idpuesto)
VALUES
(1, (SELECT idempleado FROM tblEmpleados WHERE dni='12345678A'), @puesto_gerente),
(1, (SELECT idempleado FROM tblEmpleados WHERE dni='56789012E'), @puesto_jefe),
(1, (SELECT idempleado FROM tblEmpleados WHERE dni='90123456I'), @puesto_cajero),
(1, (SELECT idempleado FROM tblEmpleados WHERE dni='33445566M'), @puesto_dependiente);

-- Tienda 2 (Barcelona)
INSERT INTO tblTiendaEmpleadosPuestos(idtienda, idempleado, idpuesto)
VALUES
(2, (SELECT idempleado FROM tblEmpleados WHERE dni='23456789B'), @puesto_gerente),
(2, (SELECT idempleado FROM tblEmpleados WHERE dni='67890123F'), @puesto_jefe),
(2, (SELECT idempleado FROM tblEmpleados WHERE dni='01234567J'), @puesto_cajero),
(2, (SELECT idempleado FROM tblEmpleados WHERE dni='44556677N'), @puesto_dependiente);

-- Tienda 3 (Valencia)
INSERT INTO tblTiendaEmpleadosPuestos(idtienda, idempleado, idpuesto)
VALUES
(3, (SELECT idempleado FROM tblEmpleados WHERE dni='34567890C'), @puesto_gerente),
(3, (SELECT idempleado FROM tblEmpleados WHERE dni='78901234G'), @puesto_jefe),
(3, (SELECT idempleado FROM tblEmpleados WHERE dni='11223344K'), @puesto_cajero),
(3, (SELECT idempleado FROM tblEmpleados WHERE dni='55667788O'), @puesto_empleado);

-- Tienda 4 (Sevilla)
INSERT INTO tblTiendaEmpleadosPuestos(idtienda, idempleado, idpuesto)
VALUES
(4, (SELECT idempleado FROM tblEmpleados WHERE dni='45678901D'), @puesto_gerente),
(4, (SELECT idempleado FROM tblEmpleados WHERE dni='89012345H'), @puesto_cajero),
(4, (SELECT idempleado FROM tblEmpleados WHERE dni='22334455L'), @puesto_dependiente);

-- Actualizar gerentes en tabla tiendas
UPDATE tblTiendas SET gerente = (SELECT idempleado FROM tblEmpleados WHERE dni='12345678A') WHERE idtienda = 1;
UPDATE tblTiendas SET gerente = (SELECT idempleado FROM tblEmpleados WHERE dni='23456789B') WHERE idtienda = 2;
UPDATE tblTiendas SET gerente = (SELECT idempleado FROM tblEmpleados WHERE dni='34567890C') WHERE idtienda = 3;
UPDATE tblTiendas SET gerente = (SELECT idempleado FROM tblEmpleados WHERE dni='45678901D') WHERE idtienda = 4;

-- Actualizar responsables de almacén
UPDATE tblTiendaAlmacen SET responsable = (SELECT idempleado FROM tblEmpleados WHERE dni='56789012E') WHERE idtienda = 1;
UPDATE tblTiendaAlmacen SET responsable = (SELECT idempleado FROM tblEmpleados WHERE dni='67890123F') WHERE idtienda = 2;
UPDATE tblTiendaAlmacen SET responsable = (SELECT idempleado FROM tblEmpleados WHERE dni='78901234G') WHERE idtienda = 3;

COMMIT;