/*
Script para crear 10 tiendas y 100 productos en dbSupermercado
*/

USE dbSupermercado;

BEGIN;

SET foreign_key_checks = 0;

-- ====================================================================
-- CREAR 10 TIENDAS
-- ====================================================================

-- Limpiar datos previos si es necesario
TRUNCATE TABLE tblTiendas;
TRUNCATE TABLE tblTiendaAlmacen;
TRUNCATE TABLE tblTiendaServicios;
TRUNCATE TABLE tblTiendaTipoVentas;

-- Tienda 1: Madrid
SELECT idsuper INTO @idsuper1 FROM tblSupermercados WHERE super LIKE 'Mercadona';
INSERT INTO tblTiendas(idsuper, codigo, idlocalidad, hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
VALUES (@idsuper1, 101, '28001', 8, 22, 'Lun-Dom', 0, 'Calle Gran Vía 45', '910001001', 'madrid1@mercadona.com');
SET @idtienda1 = LAST_INSERT_ID();
INSERT INTO tblTiendaAlmacen(descripcion, idtienda) VALUES ('Almacen Central Madrid', @idtienda1);
SET @idalmacen1 = LAST_INSERT_ID();

-- Tienda 2: Barcelona
SELECT idsuper INTO @idsuper2 FROM tblSupermercados WHERE super LIKE 'Carrefour';
INSERT INTO tblTiendas(idsuper, codigo, idlocalidad, hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
VALUES (@idsuper2, 201, '08001', 9, 21, 'Lun-Sab', 0, 'Passeig de Gràcia 100', '930002002', 'barcelona1@carrefour.com');
SET @idtienda2 = LAST_INSERT_ID();
INSERT INTO tblTiendaAlmacen(descripcion, idtienda) VALUES ('Almacen Central Barcelona', @idtienda2);
SET @idalmacen2 = LAST_INSERT_ID();

-- Tienda 3: Valencia
SELECT idsuper INTO @idsuper3 FROM tblSupermercados WHERE super LIKE 'Alcampo';
INSERT INTO tblTiendas(idsuper, codigo, idlocalidad, hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
VALUES (@idsuper3, 301, '46001', 9, 21, 'Lun-Sab', 0, 'Avenida del Puerto 234', '960003003', 'valencia1@alcampo.com');
SET @idtienda3 = LAST_INSERT_ID();
INSERT INTO tblTiendaAlmacen(descripcion, idtienda) VALUES ('Almacen Central Valencia', @idtienda3);
SET @idalmacen3 = LAST_INSERT_ID();

-- Tienda 4: Sevilla
SELECT idsuper INTO @idsuper4 FROM tblSupermercados WHERE super LIKE 'Lidl';
INSERT INTO tblTiendas(idsuper, codigo, idlocalidad, hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
VALUES (@idsuper4, 401, '41001', 9, 22, 'Lun-Dom', 0, 'Calle Sierpes 50', '950004004', 'sevilla1@lidl.com');
SET @idtienda4 = LAST_INSERT_ID();
INSERT INTO tblTiendaAlmacen(descripcion, idtienda) VALUES ('Almacen Central Sevilla', @idtienda4);
SET @idalmacen4 = LAST_INSERT_ID();

-- Tienda 5: Zaragoza
SELECT idsuper INTO @idsuper5 FROM tblSupermercados WHERE super LIKE 'Consum';
INSERT INTO tblTiendas(idsuper, codigo, idlocalidad, hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
VALUES (@idsuper5, 501, '50001', 8, 21, 'Lun-Sab', 0, 'Paseo Independencia 78', '970005005', 'zaragoza1@consum.com');
SET @idtienda5 = LAST_INSERT_ID();
INSERT INTO tblTiendaAlmacen(descripcion, idtienda) VALUES ('Almacen Central Zaragoza', @idtienda5);
SET @idalmacen5 = LAST_INSERT_ID();

-- Tienda 6: Málaga
SELECT idsuper INTO @idsuper6 FROM tblSupermercados WHERE super LIKE 'Mercadona';
INSERT INTO tblTiendas(idsuper, codigo, idlocalidad, hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
VALUES (@idsuper6, 601, '29001', 8, 22, 'Lun-Dom', 0, 'Calle Larios 25', '950006006', 'malaga1@mercadona.com');
SET @idtienda6 = LAST_INSERT_ID();
INSERT INTO tblTiendaAlmacen(descripcion, idtienda) VALUES ('Almacen Central Málaga', @idtienda6);
SET @idalmacen6 = LAST_INSERT_ID();

-- Tienda 7: Bilbao
SELECT idsuper INTO @idsuper7 FROM tblSupermercados WHERE super LIKE 'Carrefour';
INSERT INTO tblTiendas(idsuper, codigo, idlocalidad, hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
VALUES (@idsuper7, 701, '48001', 9, 21, 'Lun-Sab', 0, 'Gran Vía 88', '940007007', 'bilbao1@carrefour.com');
SET @idtienda7 = LAST_INSERT_ID();
INSERT INTO tblTiendaAlmacen(descripcion, idtienda) VALUES ('Almacen Central Bilbao', @idtienda7);
SET @idalmacen7 = LAST_INSERT_ID();

-- Tienda 8: Alicante
SELECT idsuper INTO @idsuper8 FROM tblSupermercados WHERE super LIKE 'MasYMas';
INSERT INTO tblTiendas(idsuper, codigo, idlocalidad, hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
VALUES (@idsuper8, 801, '03001', 8, 21, 'Lun-Sab', 0, 'Explanada de España 12', '960008008', 'alicante1@masymas.com');
SET @idtienda8 = LAST_INSERT_ID();
INSERT INTO tblTiendaAlmacen(descripcion, idtienda) VALUES ('Almacen Central Alicante', @idtienda8);
SET @idalmacen8 = LAST_INSERT_ID();

-- Tienda 9: Valladolid
SELECT idsuper INTO @idsuper9 FROM tblSupermercados WHERE super LIKE 'Lidl';
INSERT INTO tblTiendas(idsuper, codigo, idlocalidad, hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
VALUES (@idsuper9, 901, '47001', 9, 22, 'Lun-Dom', 0, 'Plaza Mayor 3', '980009009', 'valladolid1@lidl.com');
SET @idtienda9 = LAST_INSERT_ID();
INSERT INTO tblTiendaAlmacen(descripcion, idtienda) VALUES ('Almacen Central Valladolid', @idtienda9);
SET @idalmacen9 = LAST_INSERT_ID();

-- Tienda 10: Salamanca
SELECT idsuper INTO @idsuper10 FROM tblSupermercados WHERE super LIKE 'Alcampo';
INSERT INTO tblTiendas(idsuper, codigo, idlocalidad, hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
VALUES (@idsuper10, 1001, '37001', 8, 21, 'Lun-Sab', 0, 'Calle Toro 45', '920010010', 'salamanca1@alcampo.com');
SET @idtienda10 = LAST_INSERT_ID();
INSERT INTO tblTiendaAlmacen(descripcion, idtienda) VALUES ('Almacen Central Salamanca', @idtienda10);
SET @idalmacen10 = LAST_INSERT_ID();

-- Asignar servicios y tipos de venta a todas las tiendas
INSERT INTO tblTiendaServicios
SELECT t.idtienda, s.idservicio
FROM tblTiendas t
CROSS JOIN tblServicios s;

INSERT INTO tblTiendaTipoVentas
SELECT t.idtienda, tv.idtipo
FROM tblTiendas t
CROSS JOIN tblTipoVentas tv;

-- ====================================================================
-- CREAR 100 PRODUCTOS
-- ====================================================================

TRUNCATE TABLE tblProductos;

-- Variables para IDs
SELECT idmedida INTO @med_unidad FROM tblMedidas WHERE medidas LIKE 'UNIDAD';
SELECT idmedida INTO @med_kilo FROM tblMedidas WHERE medidas LIKE 'KILOS';
SELECT idmedida INTO @med_bolsa FROM tblMedidas WHERE medidas LIKE 'BOLSA';
SELECT idmedida INTO @med_caja FROM tblMedidas WHERE medidas LIKE 'CAJA';

SELECT idcategoria INTO @cat_carnes FROM tblCategorias WHERE categoria LIKE 'CARNES';
SELECT idcategoria INTO @cat_lacteos FROM tblCategorias WHERE categoria LIKE 'LACTEOS';
SELECT idcategoria INTO @cat_pescado FROM tblCategorias WHERE categoria LIKE 'PESCADO';
SELECT idcategoria INTO @cat_frescura FROM tblCategorias WHERE categoria LIKE 'FRESCURA';
SELECT idcategoria INTO @cat_bebidas FROM tblCategorias WHERE categoria LIKE 'BEBIDAS';
SELECT idcategoria INTO @cat_despensa FROM tblCategorias WHERE categoria LIKE 'DESPENSA';
SELECT idcategoria INTO @cat_cocina FROM tblCategorias WHERE categoria LIKE 'COCINA';
SELECT idcategoria INTO @cat_hogar FROM tblCategorias WHERE categoria LIKE 'HOGAR';
SELECT idcategoria INTO @cat_limpieza FROM tblCategorias WHERE categoria LIKE 'LIMPIESA';
SELECT idcategoria INTO @cat_cosmetica FROM tblCategorias WHERE categoria LIKE 'COSMETICA E HIGIENE';

SELECT idoferta INTO @oferta_sin FROM tblOfertas WHERE oferta LIKE 'SIN OFERTA';
SELECT idoferta INTO @oferta_3x2 FROM tblOfertas WHERE oferta LIKE '3X2';
SELECT idoferta INTO @oferta_2x50 FROM tblOfertas WHERE oferta LIKE '2X50%';

SELECT idproveedor INTO @prov1 FROM tblProveedores LIMIT 1;

-- PRODUCTOS 1-10: CARNES
INSERT INTO tblProductos(codigo, producto, información, origen, cantidad, cant_alert, precio, precio_oferta, precio_venta, iva, contenido, peso, vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida, idcategoría, idmarca, idoferta, idproveedor, idalmacen, idtienda, idsuper)
VALUES
(100001, 'Pechuga de Pollo', 'Pechuga de pollo fresca sin piel', 'España', 50, 10, 5.99, 5.99, 7.25, 10, 1, 1, '5 días', 1, 1, 1, 1, 2, @med_kilo, @cat_carnes, 1, @oferta_sin, @prov1, @idalmacen1, @idtienda1, @idsuper1),
(100002, 'Muslos de Pollo', 'Muslos de pollo frescos', 'España', 45, 10, 4.49, 4.49, 5.43, 10, 1, 1, '5 días', 1, 1, 1, 1, 2, @med_kilo, @cat_carnes, 1, @oferta_sin, @prov1, @idalmacen2, @idtienda2, @idsuper2),
(100003, 'Carne Picada de Ternera', 'Carne picada fresca de ternera', 'España', 40, 8, 8.99, 8.99, 10.88, 10, 1, 1, '3 días', 1, 1, 2, 1, 2, @med_kilo, @cat_carnes, 1, @oferta_sin, @prov1, @idalmacen3, @idtienda3, @idsuper3),
(100004, 'Chuletas de Cerdo', 'Chuletas de cerdo frescas', 'España', 35, 8, 6.99, 5.99, 8.45, 10, 1, 1, '4 días', 1, 1, 2, 1, 2, @med_kilo, @cat_carnes, 1, @oferta_3x2, @prov1, @idalmacen4, @idtienda4, @idsuper4),
(100005, 'Solomillo de Ternera', 'Solomillo de ternera premium', 'España', 25, 5, 18.99, 18.99, 22.97, 10, 1, 1, '5 días', 1, 1, 3, 1, 2, @med_kilo, @cat_carnes, 1, @oferta_sin, @prov1, @idalmacen5, @idtienda5, @idsuper5),
(100006, 'Costillas de Cerdo', 'Costillas de cerdo adobadas', 'España', 30, 7, 7.49, 7.49, 9.06, 10, 1, 1, '4 días', 1, 1, 3, 1, 2, @med_kilo, @cat_carnes, 1, @oferta_sin, @prov1, @idalmacen6, @idtienda6, @idsuper6),
(100007, 'Filete de Pavo', 'Filete de pavo natural', 'España', 35, 8, 6.49, 6.49, 7.85, 10, 1, 1, '6 días', 1, 1, 4, 1, 2, @med_kilo, @cat_carnes, 1, @oferta_sin, @prov1, @idalmacen7, @idtienda7, @idsuper7),
(100008, 'Alitas de Pollo', 'Alitas de pollo frescas', 'España', 40, 10, 3.99, 3.49, 4.82, 10, 1, 1, '5 días', 1, 1, 4, 1, 2, @med_kilo, @cat_carnes, 1, @oferta_2x50, @prov1, @idalmacen8, @idtienda8, @idsuper8),
(100009, 'Lomo de Cerdo', 'Lomo de cerdo fresco', 'España', 30, 6, 9.99, 9.99, 12.08, 10, 1, 1, '5 días', 1, 1, 5, 1, 2, @med_kilo, @cat_carnes, 1, @oferta_sin, @prov1, @idalmacen9, @idtienda9, @idsuper9),
(100010, 'Cordero Lechal', 'Cordero lechal tierno', 'España', 20, 4, 15.99, 15.99, 19.33, 10, 1, 1, '4 días', 1, 1, 5, 1, 2, @med_kilo, @cat_carnes, 1, @oferta_sin, @prov1, @idalmacen10, @idtienda10, @idsuper10);

-- PRODUCTOS 11-20: LÁCTEOS
INSERT INTO tblProductos(codigo, producto, información, origen, cantidad, cant_alert, precio, precio_oferta, precio_venta, iva, contenido, peso, vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida, idcategoría, idmarca, idoferta, idproveedor, idalmacen, idtienda, idsuper)
VALUES
(100011, 'Leche Entera 1L', 'Leche entera pasteurizada', 'España', 100, 20, 0.99, 0.99, 1.09, 10, 1, 1.03, '7 días', 2, 2, 1, 1, 2, @med_unidad, @cat_lacteos, 1, @oferta_sin, @prov1, @idalmacen1, @idtienda1, @idsuper1),
(100012, 'Yogur Natural Pack 4', 'Yogur natural sin azúcar', 'España', 80, 15, 1.49, 1.49, 1.64, 10, 4, 0.5, '15 días', 2, 2, 1, 1, 2, @med_unidad, @cat_lacteos, 1, @oferta_sin, @prov1, @idalmacen2, @idtienda2, @idsuper2),
(100013, 'Mantequilla 250g', 'Mantequilla con sal', 'Francia', 60, 10, 2.49, 2.49, 2.74, 10, 0.25, 0.26, '30 días', 2, 2, 2, 1, 2, @med_unidad, @cat_lacteos, 1, @oferta_sin, @prov1, @idalmacen3, @idtienda3, @idsuper3),
(100014, 'Queso Manchego', 'Queso manchego curado', 'España', 40, 8, 12.99, 11.99, 15.72, 10, 0.5, 0.52, '60 días', 2, 2, 2, 1, 2, @med_kilo, @cat_lacteos, 1, @oferta_3x2, @prov1, @idalmacen4, @idtienda4, @idsuper4),
(100015, 'Nata para Cocinar 200ml', 'Nata líquida para cocinar', 'España', 70, 15, 1.29, 1.29, 1.42, 10, 0.2, 0.22, '20 días', 2, 2, 3, 1, 2, @med_unidad, @cat_lacteos, 1, @oferta_sin, @prov1, @idalmacen5, @idtienda5, @idsuper5),
(100016, 'Queso Mozzarella', 'Queso mozzarella fresco', 'Italia', 50, 10, 3.49, 3.49, 3.84, 10, 0.25, 0.26, '15 días', 2, 2, 3, 1, 2, @med_unidad, @cat_lacteos, 1, @oferta_sin, @prov1, @idalmacen6, @idtienda6, @idsuper6),
(100017, 'Yogur Griego 500g', 'Yogur griego cremoso', 'Grecia', 65, 12, 2.99, 2.99, 3.29, 10, 0.5, 0.52, '20 días', 2, 2, 4, 1, 2, @med_unidad, @cat_lacteos, 1, @oferta_sin, @prov1, @idalmacen7, @idtienda7, @idsuper7),
(100018, 'Queso Brie', 'Queso brie francés', 'Francia', 35, 7, 5.99, 5.49, 7.24, 10, 0.3, 0.31, '25 días', 2, 2, 4, 1, 2, @med_unidad, @cat_lacteos, 1, @oferta_2x50, @prov1, @idalmacen8, @idtienda8, @idsuper8),
(100019, 'Leche Sin Lactosa 1L', 'Leche sin lactosa semidesnatada', 'España', 90, 18, 1.39, 1.39, 1.53, 10, 1, 1.03, '10 días', 2, 2, 5, 1, 2, @med_unidad, @cat_lacteos, 1, @oferta_sin, @prov1, @idalmacen9, @idtienda9, @idsuper9),
(100020, 'Queso de Cabra', 'Queso de cabra semicurado', 'España', 30, 6, 8.99, 8.99, 9.89, 10, 0.4, 0.42, '45 días', 2, 2, 5, 1, 2, @med_unidad, @cat_lacteos, 1, @oferta_sin, @prov1, @idalmacen10, @idtienda10, @idsuper10);

-- PRODUCTOS 21-30: PESCADO
INSERT INTO tblProductos(codigo, producto, información, origen, cantidad, cant_alert, precio, precio_oferta, precio_venta, iva, contenido, peso, vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida, idcategoría, idmarca, idoferta, idproveedor, idalmacen, idtienda, idsuper)
VALUES
(100021, 'Salmón Fresco', 'Salmón fresco del Atlántico', 'Noruega', 30, 6, 14.99, 14.99, 16.48, 10, 1, 1, '2 días', 3, 3, 1, 1, 2, @med_kilo, @cat_pescado, 1, @oferta_sin, @prov1, @idalmacen1, @idtienda1, @idsuper1),
(100022, 'Merluza Fresca', 'Merluza fresca en rodajas', 'España', 35, 7, 11.99, 11.99, 13.18, 10, 1, 1, '2 días', 3, 3, 1, 1, 2, @med_kilo, @cat_pescado, 1, @oferta_sin, @prov1, @idalmacen2, @idtienda2, @idsuper2),
(100023, 'Atún Fresco', 'Atún rojo fresco', 'España', 25, 5, 18.99, 18.99, 20.88, 10, 1, 1, '2 días', 3, 3, 2, 1, 2, @med_kilo, @cat_pescado, 1, @oferta_sin, @prov1, @idalmacen3, @idtienda3, @idsuper3),
(100024, 'Dorada Fresca', 'Dorada fresca entera', 'España', 40, 8, 9.99, 8.99, 12.08, 10, 1, 1, '2 días', 3, 3, 2, 1, 2, @med_kilo, @cat_pescado, 1, @oferta_3x2, @prov1, @idalmacen4, @idtienda4, @idsuper4),
(100025, 'Bacalao Fresco', 'Bacalao fresco en lomos', 'Islandia', 30, 6, 13.99, 13.99, 15.38, 10, 1, 1, '2 días', 3, 3, 3, 1, 2, @med_kilo, @cat_pescado, 1, @oferta_sin, @prov1, @idalmacen5, @idtienda5, @idsuper5),
(100026, 'Gambas Frescas', 'Gambas blancas frescas', 'España', 45, 9, 16.99, 16.99, 18.68, 10, 1, 1, '1 día', 3, 3, 3, 1, 2, @med_kilo, @cat_pescado, 1, @oferta_sin, @prov1, @idalmacen6, @idtienda6, @idsuper6),
(100027, 'Lubina Fresca', 'Lubina fresca entera', 'España', 35, 7, 10.99, 10.99, 12.08, 10, 1, 1, '2 días', 3, 3, 4, 1, 2, @med_kilo, @cat_pescado, 1, @oferta_sin, @prov1, @idalmacen7, @idtienda7, @idsuper7),
(100028, 'Pulpo Fresco', 'Pulpo fresco limpio', 'España', 20, 4, 19.99, 18.99, 24.18, 10, 1, 1, '2 días', 3, 3, 4, 1, 2, @med_kilo, @cat_pescado, 1, @oferta_2x50, @prov1, @idalmacen8, @idtienda8, @idsuper8),
(100029, 'Rape Fresco', 'Rape fresco en filetes', 'España', 25, 5, 17.99, 17.99, 19.78, 10, 1, 1, '2 días', 3, 3, 5, 1, 2, @med_kilo, @cat_pescado, 1, @oferta_sin, @prov1, @idalmacen9, @idtienda9, @idsuper9),
(100030, 'Mejillones Frescos', 'Mejillones frescos limpios', 'España', 60, 12, 4.99, 4.99, 5.48, 10, 1, 1, '1 día', 3, 3, 5, 1, 2, @med_kilo, @cat_pescado, 1, @oferta_sin, @prov1, @idalmacen10, @idtienda10, @idsuper10);

-- PRODUCTOS 31-40: FRUTAS Y VERDURAS (FRESCURA)
INSERT INTO tblProductos(codigo, producto, información, origen, cantidad, cant_alert, precio, precio_oferta, precio_venta, iva, contenido, peso, vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida, idcategoría, idmarca, idoferta, idproveedor, idalmacen, idtienda, idsuper)
VALUES
(100031, 'Manzanas Golden', 'Manzanas golden dulces', 'España', 100, 20, 1.99, 1.99, 2.18, 10, 1, 1, '10 días', 4, 4, 1, 0, 2, @med_kilo, @cat_frescura, 1, @oferta_sin, @prov1, @idalmacen1, @idtienda1, @idsuper1),
(100032, 'Plátanos de Canarias', 'Plátanos canarios maduros', 'España', 120, 25, 1.79, 1.79, 1.96, 10, 1, 1, '7 días', 4, 4, 1, 0, 2, @med_kilo, @cat_frescura, 1, @oferta_sin, @prov1, @idalmacen2, @idtienda2, @idsuper2),
(100033, 'Tomates', 'Tomates maduros de rama', 'España', 90, 18, 2.49, 2.49, 2.73, 10, 1, 1, '5 días', 4, 4, 2, 0, 2, @med_kilo, @cat_frescura, 1, @oferta_sin, @prov1, @idalmacen3, @idtienda3, @idsuper3),
(100034, 'Naranjas', 'Naranjas de Valencia', 'España', 110, 22, 1.49, 1.29, 1.80, 10, 1, 1, '14 días', 4, 4, 2, 0, 2, @med_kilo, @cat_frescura, 1, @oferta_3x2, @prov1, @idalmacen4, @idtienda4, @idsuper4),
(100035, 'Lechuga Iceberg', 'Lechuga iceberg fresca', 'España', 80, 16, 0.99, 0.99, 1.08, 10, 1, 0.5, '7 días', 4, 4, 3, 0, 2, @med_unidad, @cat_frescura, 1, @oferta_sin, @prov1, @idalmacen5, @idtienda5, @idsuper5),
(100036, 'Zanahorias', 'Zanahorias frescas', 'España', 95, 19, 1.29, 1.29, 1.41, 10, 1, 1, '10 días', 4, 4, 3, 0, 2, @med_kilo, @cat_frescura, 1, @oferta_sin, @prov1, @idalmacen6, @idtienda6, @idsuper6),
(100037, 'Aguacates', 'Aguacates Hass maduros', 'México', 70, 14, 3.99, 3.99, 4.38, 10, 1, 1, '5 días', 4, 4, 4, 0, 2, @med_kilo, @cat_frescura, 1, @oferta_sin, @prov1, @idalmacen7, @idtienda7, @idsuper7),
(100038, 'Fresas', 'Fresas frescas de Huelva', 'España', 60, 12, 4.49, 3.99, 5.43, 10, 0.5, 0.52, '3 días', 4, 4, 4, 0, 2, @med_caja, @cat_frescura, 1, @oferta_2x50, @prov1, @idalmacen8, @idtienda8, @idsuper8),
(100039, 'Pimientos Rojos', 'Pimientos rojos dulces', 'España', 85, 17, 2.99, 2.99, 3.28, 10, 1, 1, '7 días', 4, 4, 5, 0, 2, @med_kilo, @cat_frescura, 1, @oferta_sin, @prov1, @idalmacen9, @idtienda9, @idsuper9),
(100040, 'Patatas', 'Patatas para freír', 'España', 150, 30, 0.99, 0.99, 1.08, 10, 1, 1, '30 días', 4, 4, 5, 0, 2, @med_kilo, @cat_frescura, 1, @oferta_sin, @prov1, @idalmacen10, @idtienda10, @idsuper10);

-- PRODUCTOS 41-50: BEBIDAS
INSERT INTO tblProductos(codigo, producto, información, origen, cantidad, cant_alert, precio, precio_oferta, precio_venta, iva, contenido, peso, vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida, idcategoría, idmarca, idoferta, idproveedor, idalmacen, idtienda, idsuper)
VALUES
(100041, 'Agua Mineral 1.5L', 'Agua mineral natural', 'España', 200, 40, 0.39, 0.39, 0.42, 10, 1.5, 1.52, 's/c', 5, 5, 1, 0, 2, @med_unidad, @cat_bebidas, 1, @oferta_sin, @prov1, @idalmacen1, @idtienda1, @idsuper1),
(100042, 'Coca-Cola 2L', 'Refresco de cola', 'España', 150, 30, 1.99, 1.99, 2.18, 21, 2, 2.05, 's/c', 5, 5, 1, 0, 2, @med_unidad, @cat_bebidas, 1, @oferta_sin, @prov1, @idalmacen2, @idtienda2, @idsuper2),
(100043, 'Zumo de Naranja 1L', 'Zumo de naranja natural', 'España', 100, 20, 2.49, 2.49, 3.01, 21, 1, 1.03, '7 días', 5, 5, 2, 1, 2, @med_unidad, @cat_bebidas, 1, @oferta_sin, @prov1, @idalmacen3, @idtienda3, @idsuper3),
(100044, 'Cerveza Pack 6', 'Cerveza rubia lager', 'España', 180, 36, 3.99, 3.49, 4.82, 21, 6, 2.1, 's/c', 5, 5, 2, 0, 2, @med_unidad, @cat_bebidas, 1, @oferta_3x2, @prov1, @idalmacen4, @idtienda4, @idsuper4),
(100045, 'Té Verde 1.5L', 'Té verde sin azúcar', 'España', 120, 24, 1.49, 1.49, 1.80, 21, 1.5, 1.52, 's/c', 5, 5, 3, 0, 2, @med_unidad, @cat_bebidas, 1, @oferta_sin, @prov1, @idalmacen5, @idtienda5, @idsuper5),
(100046, 'Café Soluble 200g', 'Café soluble instantáneo', 'Colombia', 90, 18, 5.99, 5.99, 6.58, 10, 0.2, 0.22, 's/c', 5, 5, 3, 0, 2, @med_unidad, @cat_bebidas, 1, @oferta_sin, @prov1, @idalmacen6, @idtienda6, @idsuper6),
(100047, 'Vino Tinto Rioja', 'Vino tinto Denominación Rioja', 'España', 80, 16, 7.99, 7.99, 8.78, 10, 0.75, 1.25, 's/c', 5, 5, 4, 0, 2, @med_unidad, @cat_bebidas, 1, @oferta_sin, @prov1, @idalmacen7, @idtienda7, @idsuper7),
(100048, 'Batido Chocolate 1L', 'Batido de chocolate', 'España', 110, 22, 2.29, 1.99, 2.77, 21, 1, 1.03, '15 días', 5, 5, 4, 1, 2, @med_unidad, @cat_bebidas, 1, @oferta_2x50, @prov1, @idalmacen8, @idtienda8, @idsuper8),
(100049, 'Agua con Gas 1.25L', 'Agua mineral con gas', 'España', 130, 26, 0.59, 0.59, 0.64, 10, 1.25, 1.27, 's/c', 5, 5, 5, 0, 2, @med_unidad, @cat_bebidas, 1, @oferta_sin, @prov1, @idalmacen9, @idtienda9, @idsuper9),
(100050, 'Refresco Limón 2L', 'Refresco sabor limón', 'España', 140, 28, 1.79, 1.79, 2.16, 21, 2, 2.05, 's/c', 5, 5, 5, 0, 2, @med_unidad, @cat_bebidas, 1, @oferta_sin, @prov1, @idalmacen10, @idtienda10, @idsuper10);

-- PRODUCTOS 51-60: DESPENSA
INSERT INTO tblProductos(codigo, producto, información, origen, cantidad, cant_alert, precio, precio_oferta, precio_venta, iva, contenido, peso, vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida, idcategoría, idmarca, idoferta, idproveedor, idalmacen, idtienda, idsuper)
VALUES
(100051, 'Arroz Blanco 1kg', 'Arroz blanco largo', 'España', 200, 40, 1.19, 1.19, 1.30, 10, 1, 1.02, 's/c', 6, 6, 1, 0, 2, @med_bolsa, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen1, @idtienda1, @idsuper1),
(100052, 'Pasta Espaguetis 500g', 'Pasta de sémola de trigo', 'Italia', 180, 36, 0.99, 0.99, 1.08, 10, 0.5, 0.52, 's/c', 6, 6, 1, 0, 2, @med_bolsa, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen2, @idtienda2, @idsuper2),
(100053, 'Aceite de Oliva 1L', 'Aceite de oliva virgen extra', 'España', 120, 24, 4.99, 4.99, 5.48, 10, 1, 0.92, 's/c', 6, 6, 2, 0, 2, @med_unidad, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen3, @idtienda3, @idsuper3),
(100054, 'Legumbres Variadas 500g', 'Legumbres variadas secas', 'España', 150, 30, 1.79, 1.49, 2.16, 10, 0.5, 0.52, 's/c', 6, 6, 2, 0, 2, @med_bolsa, @cat_despensa, 1, @oferta_3x2, @prov1, @idalmacen4, @idtienda4, @idsuper4),
(100055, 'Harina de Trigo 1kg', 'Harina de trigo de fuerza', 'España', 140, 28, 0.89, 0.89, 0.97, 10, 1, 1.02, 's/c', 6, 6, 3, 0, 2, @med_bolsa, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen5, @idtienda5, @idsuper5),
(100056, 'Azúcar Blanco 1kg', 'Azúcar blanco granulado', 'España', 160, 32, 1.09, 1.09, 1.19, 10, 1, 1.02, 's/c', 6, 6, 3, 0, 2, @med_bolsa, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen6, @idtienda6, @idsuper6),
(100057, 'Sal Marina 1kg', 'Sal marina yodada', 'España', 190, 38, 0.49, 0.49, 0.53, 10, 1, 1.02, 's/c', 6, 6, 4, 0, 2, @med_bolsa, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen7, @idtienda7, @idsuper7),
(100058, 'Tomate Frito 400g', 'Tomate frito natural', 'España', 130, 26, 1.49, 1.29, 1.80, 10, 0.4, 0.43, 's/c', 6, 6, 4, 0, 2, @med_unidad, @cat_despensa, 1, @oferta_2x50, @prov1, @idalmacen8, @idtienda8, @idsuper8),
(100059, 'Atún en Lata 3 Pack', 'Atún en aceite de oliva', 'España', 170, 34, 3.99, 3.99, 4.38, 10, 0.24, 0.26, 's/c', 6, 6, 5, 0, 2, @med_unidad, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen9, @idtienda9, @idsuper9),
(100060, 'Galletas María 800g', 'Galletas tipo María', 'España', 155, 31, 2.29, 2.29, 2.51, 10, 0.8, 0.82, 's/c', 6, 6, 5, 0, 2, @med_unidad, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen10, @idtienda10, @idsuper10);

-- PRODUCTOS 61-70: COCINA/HOGAR
INSERT INTO tblProductos(codigo, producto, información, origen, cantidad, cant_alert, precio, precio_oferta, precio_venta, iva, contenido, peso, vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida, idcategoría, idmarca, idoferta, idproveedor, idalmacen, idtienda, idsuper)
VALUES
(100061, 'Sartén Antiadherente 24cm', 'Sartén con recubrimiento antiadherente', 'España', 50, 10, 12.99, 12.99, 15.71, 21, 1, 0.8, 's/c', 7, 7, 1, 0, 2, @med_unidad, @cat_cocina, 1, @oferta_sin, @prov1, @idalmacen1, @idtienda1, @idsuper1),
(100062, 'Juego de Cuchillos 6 pz', 'Set de cuchillos de cocina', 'China', 40, 8, 19.99, 19.99, 24.18, 21, 1, 1.2, 's/c', 7, 7, 1, 0, 2, @med_unidad, @cat_cocina, 1, @oferta_sin, @prov1, @idalmacen2, @idtienda2, @idsuper2),
(100063, 'Tabla de Cortar Bambú', 'Tabla de cortar ecológica', 'Vietnam', 60, 12, 8.99, 8.99, 10.87, 21, 1, 0.6, 's/c', 7, 7, 2, 0, 2, @med_unidad, @cat_cocina, 1, @oferta_sin, @prov1, @idalmacen3, @idtienda3, @idsuper3),
(100064, 'Batidora de Mano 500W', 'Batidora eléctrica de mano', 'España', 35, 7, 24.99, 21.99, 30.23, 21, 1, 1.5, 's/c', 7, 7, 2, 0, 2, @med_unidad, @cat_cocina, 2, @oferta_3x2, @prov1, @idalmacen4, @idtienda4, @idsuper4),
(100065, 'Olla Express 6L', 'Olla a presión 6 litros', 'España', 30, 6, 39.99, 39.99, 48.38, 21, 1, 3.5, 's/c', 7, 7, 3, 0, 2, @med_unidad, @cat_cocina, 1, @oferta_sin, @prov1, @idalmacen5, @idtienda5, @idsuper5),
(100066, 'Juego Sábanas 150cm', 'Juego de sábanas algodón', 'Portugal', 45, 9, 29.99, 29.99, 36.28, 21, 1, 1.8, 's/c', 7, 7, 3, 0, 2, @med_unidad, @cat_hogar, 1, @oferta_sin, @prov1, @idalmacen6, @idtienda6, @idsuper6),
(100067, 'Toallas Baño 2 unidades', 'Pack 2 toallas de baño', 'Turquía', 55, 11, 14.99, 14.99, 18.13, 21, 1, 1.2, 's/c', 7, 7, 4, 0, 2, @med_unidad, @cat_hogar, 1, @oferta_sin, @prov1, @idalmacen7, @idtienda7, @idsuper7),
(100068, 'Almohada Viscoelástica', 'Almohada ergonómica', 'España', 40, 8, 19.99, 17.99, 24.18, 21, 1, 1.5, 's/c', 7, 7, 4, 0, 2, @med_unidad, @cat_hogar, 1, @oferta_2x50, @prov1, @idalmacen8, @idtienda8, @idsuper8),
(100069, 'Mantel 140x200cm', 'Mantel antimanchas', 'España', 50, 10, 12.99, 12.99, 15.71, 21, 1, 0.5, 's/c', 7, 7, 5, 0, 2, @med_unidad, @cat_hogar, 1, @oferta_sin, @prov1, @idalmacen9, @idtienda9, @idsuper9),
(100070, 'Cortinas Opacas 2pz', 'Par de cortinas opacas', 'China', 35, 7, 24.99, 24.99, 30.23, 21, 1, 2.0, 's/c', 7, 7, 5, 0, 2, @med_unidad, @cat_hogar, 1, @oferta_sin, @prov1, @idalmacen10, @idtienda10, @idsuper10);

-- PRODUCTOS 71-80: LIMPIEZA
INSERT INTO tblProductos(codigo, producto, información, origen, cantidad, cant_alert, precio, precio_oferta, precio_venta, iva, contenido, peso, vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida, idcategoría, idmarca, idoferta, idproveedor, idalmacen, idtienda, idsuper)
VALUES
(100071, 'Detergente Líquido 3L', 'Detergente para ropa', 'España', 100, 20, 6.99, 6.99, 8.45, 21, 3, 3.1, 's/c', 8, 8, 1, 0, 2, @med_unidad, @cat_limpieza, 1, @oferta_sin, @prov1, @idalmacen1, @idtienda1, @idsuper1),
(100072, 'Suavizante 2L', 'Suavizante concentrado', 'España', 90, 18, 3.99, 3.99, 4.82, 21, 2, 2.05, 's/c', 8, 8, 1, 0, 2, @med_unidad, @cat_limpieza, 1, @oferta_sin, @prov1, @idalmacen2, @idtienda2, @idsuper2),
(100073, 'Lavavajillas Mano 750ml', 'Líquido lavavajillas', 'España', 120, 24, 1.99, 1.99, 2.40, 21, 0.75, 0.78, 's/c', 8, 8, 2, 0, 2, @med_unidad, @cat_limpieza, 1, @oferta_sin, @prov1, @idalmacen3, @idtienda3, @idsuper3),
(100074, 'Lejía 2L', 'Lejía desinfectante', 'España', 110, 22, 1.49, 1.29, 1.80, 21, 2, 2.1, 's/c', 8, 8, 2, 0, 2, @med_unidad, @cat_limpieza, 1, @oferta_3x2, @prov1, @idalmacen4, @idtienda4, @idsuper4),
(100075, 'Limpiador Multiusos 1L', 'Limpiador multiusos', 'España', 130, 26, 2.49, 2.49, 3.01, 21, 1, 1.05, 's/c', 8, 8, 3, 0, 2, @med_unidad, @cat_limpieza, 1, @oferta_sin, @prov1, @idalmacen5, @idtienda5, @idsuper5),
(100076, 'Fregasuelos 1.5L', 'Fregasuelos perfumado', 'España', 100, 20, 2.99, 2.99, 3.61, 21, 1.5, 1.55, 's/c', 8, 8, 3, 0, 2, @med_unidad, @cat_limpieza, 1, @oferta_sin, @prov1, @idalmacen6, @idtienda6, @idsuper6),
(100077, 'Papel Higiénico 12 rollos', 'Papel higiénico triple capa', 'España', 150, 30, 5.99, 5.99, 7.24, 21, 1, 2.5, 's/c', 8, 8, 4, 0, 2, @med_unidad, @cat_limpieza, 1, @oferta_sin, @prov1, @idalmacen7, @idtienda7, @idsuper7),
(100078, 'Servilletas 200 uds', 'Servilletas de papel', 'España', 140, 28, 1.99, 1.79, 2.40, 21, 1, 0.8, 's/c', 8, 8, 4, 0, 2, @med_unidad, @cat_limpieza, 1, @oferta_2x50, @prov1, @idalmacen8, @idtienda8, @idsuper8),
(100079, 'Bayetas Microfibra 5pz', 'Pack bayetas microfibra', 'España', 80, 16, 3.99, 3.99, 4.82, 21, 1, 0.3, 's/c', 8, 8, 5, 0, 2, @med_unidad, @cat_limpieza, 1, @oferta_sin, @prov1, @idalmacen9, @idtienda9, @idsuper9),
(100080, 'Estropajo 10 uds', 'Estropajos doble cara', 'España', 160, 32, 2.49, 2.49, 3.01, 21, 1, 0.4, 's/c', 8, 8, 5, 0, 2, @med_unidad, @cat_limpieza, 1, @oferta_sin, @prov1, @idalmacen10, @idtienda10, @idsuper10);

-- PRODUCTOS 81-90: COSMÉTICA E HIGIENE
INSERT INTO tblProductos(codigo, producto, información, origen, cantidad, cant_alert, precio, precio_oferta, precio_venta, iva, contenido, peso, vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida, idcategoría, idmarca, idoferta, idproveedor, idalmacen, idtienda, idsuper)
VALUES
(100081, 'Champú Cabello Normal 400ml', 'Champú uso frecuente', 'España', 80, 16, 3.99, 3.99, 4.82, 21, 0.4, 0.43, 's/c', 9, 9, 1, 0, 2, @med_unidad, @cat_cosmetica, 1, @oferta_sin, @prov1, @idalmacen1, @idtienda1, @idsuper1),
(100082, 'Gel de Baño 750ml', 'Gel de ducha hidratante', 'España', 90, 18, 2.99, 2.99, 3.61, 21, 0.75, 0.78, 's/c', 9, 9, 1, 0, 2, @med_unidad, @cat_cosmetica, 1, @oferta_sin, @prov1, @idalmacen2, @idtienda2, @idsuper2),
(100083, 'Pasta de Dientes 75ml', 'Dentífrico con flúor', 'España', 120, 24, 1.99, 1.99, 2.40, 21, 0.075, 0.09, 's/c', 9, 9, 2, 0, 2, @med_unidad, @cat_cosmetica, 1, @oferta_sin, @prov1, @idalmacen3, @idtienda3, @idsuper3),
(100084, 'Desodorante Roll-On 50ml', 'Desodorante 48h', 'España', 100, 20, 2.49, 2.19, 3.01, 21, 0.05, 0.06, 's/c', 9, 9, 2, 0, 2, @med_unidad, @cat_cosmetica, 1, @oferta_3x2, @prov1, @idalmacen4, @idtienda4, @idsuper4),
(100085, 'Crema Hidratante 200ml', 'Crema corporal hidratante', 'Francia', 70, 14, 5.99, 5.99, 7.24, 21, 0.2, 0.22, 's/c', 9, 9, 3, 0, 2, @med_unidad, @cat_cosmetica, 1, @oferta_sin, @prov1, @idalmacen5, @idtienda5, @idsuper5),
(100086, 'Jabón Manos 500ml', 'Jabón líquido manos', 'España', 110, 22, 2.49, 2.49, 3.01, 21, 0.5, 0.53, 's/c', 9, 9, 3, 0, 2, @med_unidad, @cat_cosmetica, 1, @oferta_sin, @prov1, @idalmacen6, @idtienda6, @idsuper6),
(100087, 'Cuchillas Afeitar 8 uds', 'Cuchillas desechables', 'Alemania', 85, 17, 4.99, 4.99, 6.03, 21, 1, 0.1, 's/c', 9, 9, 4, 0, 2, @med_unidad, @cat_cosmetica, 1, @oferta_sin, @prov1, @idalmacen7, @idtienda7, @idsuper7),
(100088, 'Protector Solar SPF50 200ml', 'Protección solar alta', 'España', 60, 12, 9.99, 8.99, 12.08, 21, 0.2, 0.22, 's/c', 9, 9, 4, 0, 2, @med_unidad, @cat_cosmetica, 1, @oferta_2x50, @prov1, @idalmacen8, @idtienda8, @idsuper8),
(100089, 'Pañuelos Papel 10 paquetes', 'Pañuelos desechables', 'España', 130, 26, 3.49, 3.49, 4.22, 21, 1, 0.6, 's/c', 9, 9, 5, 0, 2, @med_unidad, @cat_cosmetica, 1, @oferta_sin, @prov1, @idalmacen9, @idtienda9, @idsuper9),
(100090, 'Compresas 24 uds', 'Compresas ultra finas', 'España', 95, 19, 2.99, 2.99, 3.61, 21, 1, 0.3, 's/c', 9, 9, 5, 0, 2, @med_unidad, @cat_cosmetica, 1, @oferta_sin, @prov1, @idalmacen10, @idtienda10, @idsuper10);

-- PRODUCTOS 91-100: VARIADOS (PANADERÍA, REFRIGERADOS)
INSERT INTO tblProductos(codigo, producto, información, origen, cantidad, cant_alert, precio, precio_oferta, precio_venta, iva, contenido, peso, vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida, idcategoría, idmarca, idoferta, idproveedor, idalmacen, idtienda, idsuper)
VALUES
(100091, 'Pan de Molde 450g', 'Pan de molde integral', 'España', 100, 20, 1.29, 1.29, 1.42, 10, 0.45, 0.47, '7 días', 10, 10, 1, 0, 2, @med_unidad, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen1, @idtienda1, @idsuper1),
(100092, 'Bollería Variada 6 uds', 'Croissants y napolitanas', 'España', 80, 16, 2.99, 2.99, 3.29, 10, 0.3, 0.32, '5 días', 10, 10, 1, 0, 2, @med_unidad, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen2, @idtienda2, @idsuper2),
(100093, 'Jamón Cocido 200g', 'Jamón cocido extra', 'España', 70, 14, 3.49, 3.49, 3.84, 10, 0.2, 0.22, '10 días', 10, 10, 2, 1, 2, @med_unidad, @cat_lacteos, 1, @oferta_sin, @prov1, @idalmacen3, @idtienda3, @idsuper3),
(100094, 'Salchichas Frankfurt 400g', 'Salchichas de pavo', 'España', 90, 18, 2.49, 2.19, 3.01, 10, 0.4, 0.42, '20 días', 10, 10, 2, 1, 2, @med_unidad, @cat_carnes, 1, @oferta_3x2, @prov1, @idalmacen4, @idtienda4, @idsuper4),
(100095, 'Pizza Congelada', 'Pizza 4 quesos', 'Italia', 85, 17, 3.99, 3.99, 4.38, 10, 0.4, 0.45, '180 días', 10, 10, 3, 1, 2, @med_unidad, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen5, @idtienda5, @idsuper5),
(100096, 'Helado 1L', 'Helado de vainilla', 'España', 75, 15, 4.99, 4.99, 5.48, 10, 1, 0.55, '365 días', 10, 10, 3, 1, 2, @med_unidad, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen6, @idtienda6, @idsuper6),
(100097, 'Hummus 200g', 'Hummus de garbanzo', 'España', 65, 13, 2.29, 2.29, 2.51, 10, 0.2, 0.22, '30 días', 10, 10, 4, 1, 2, @med_unidad, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen7, @idtienda7, @idsuper7),
(100098, 'Guacamole 200g', 'Guacamole fresco', 'España', 55, 11, 2.99, 2.69, 3.61, 10, 0.2, 0.22, '7 días', 10, 10, 4, 1, 2, @med_unidad, @cat_frescura, 1, @oferta_2x50, @prov1, @idalmacen8, @idtienda8, @idsuper8),
(100099, 'Tortitas de Maíz 130g', 'Tortitas de maíz integral', 'España', 95, 19, 1.79, 1.79, 1.96, 10, 0.13, 0.15, 's/c', 10, 10, 5, 0, 2, @med_unidad, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen9, @idtienda9, @idsuper9),
(100100, 'Chocolate Negro 100g', 'Chocolate negro 70% cacao', 'Bélgica', 110, 22, 2.49, 2.49, 2.73, 10, 0.1, 0.11, 's/c', 10, 10, 5, 0, 2, @med_unidad, @cat_despensa, 1, @oferta_sin, @prov1, @idalmacen10, @idtienda10, @idsuper10);

SET foreign_key_checks = 1;

COMMIT;

-- ====================================================================
-- VERIFICACIÓN DE DATOS INSERTADOS
-- ====================================================================

-- Verificar tiendas creadas
SELECT
    t.idtienda,
    s.super,
    t.codigo,
    l.localidad,
    t.direccion
FROM tblTiendas t
JOIN tblSupermercados s ON t.idsuper = s.idsuper
JOIN tblLocalidades l ON t.idlocalidad = l.idlocalidad
ORDER BY t.idtienda;

-- Verificar productos por tienda
SELECT
    t.idtienda,
    s.super,
    l.localidad,
    COUNT(p.codigobarra) as total_productos
FROM tblTiendas t
JOIN tblSupermercados s ON t.idsuper = s.idsuper
JOIN tblLocalidades l ON t.idlocalidad = l.idlocalidad
LEFT JOIN tblProductos p ON t.idtienda = p.idtienda
GROUP BY t.idtienda, s.super, l.localidad
ORDER BY t.idtienda;

-- Verificar total de productos
SELECT COUNT(*) as total_productos FROM tblProductos;

-- Ver productos por categoría
SELECT
    c.categoria,
    COUNT(p.codigobarra) as cantidad_productos
FROM tblCategorias c
LEFT JOIN tblProductos p ON c.idcategoria = p.idcategoría
GROUP BY c.categoria
ORDER BY cantidad_productos DESC;