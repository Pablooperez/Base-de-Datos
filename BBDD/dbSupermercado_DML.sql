/*
Base Datos:   dbSupermercado
Autor: Rafa Acosta
Descripción:
Gestión de una base de datos para la actividad de un supermercado

----------------------------------------------------------------------
                Inserción  de datos (DML)
---------------------------------------------------------------------- */
-- Comenzar  Trans.
BEGIN;

-- Desactivar las FK
SET foreign_key_checks = 0;

/* -- Insertar provincias y localidades  ---- */
TRUNCATE dbSupermercado.tblComunidades;
INSERT INTO dbSupermercado.tblComunidades
VALUES
  (01, 'Andalucía'),
  (02, 'Aragón'),
  (03, 'Asturias'),
  (04, 'Baleares'),
  (05, 'Canarias'),
  (06, 'Cantabria'),
  (07, 'Castilla-La Mancha'),
  (08, 'Castilla y León'),
  (09, 'Cataluña'),
  (10, 'Comunidad Valenciana'),
  (11, 'Extremadura'),
  (12, 'Galicia'),
  (13, 'La Rioja'),
  (14, 'Madrid'),
  (15, 'Murcia'),
  (16, 'Navarra'),
  (17, 'Comunidad Vasco'),
  (18, 'Ceuta'),
  (19, 'Melilla');
TRUNCATE dbSupermercado.tblProvincias;
INSERT INTO dbSupermercado.tblProvincias
VALUES
    (01, 'Álava', 'AL', 17),
    (02, 'Albacete', 'AB', 7),
    (03, 'Alicante', 'AL', 10),
    (04, 'Almería', 'AL', 1),
    (05, 'Ávila', 'AV', 8),
    (06, 'Badajoz', 'BA', 11),
    (07, 'Baleares', 'IB', 4),
    (08, 'Barcelona', 'B', 9),
    (09, 'Burgos', 'BU', 8),
    (10, 'Cáceres', 'CC', 11),
    (11, 'Cádiz', 'CA', 1),
    (12, 'Castellón', 'CS', 10),
    (13, 'Ciudad Real', 'CR', 7),
    (14, 'Córdoba', 'CO', 1),
    (15, 'La Coruña', 'CO', 12),
    (16, 'Cuenca', 'CU', 7),
    (17, 'Gerona', 'GI', 9),
    (18, 'Granada', 'GR', 1),
    (19, 'Guadalajara', 'GU', 7),
    (20, 'Guipúzcoa', 'GU', 17),
    (21, 'Huelva', 'HU', 1),
    (22, 'Huesca', 'HU', 2),
    (23, 'Jaén', 'J', 1),
    (24, 'León', 'LE', 8),
    (25, 'Lérida', 'L', 9),
    (26, 'La Rioja', 'LO', 13),
    (27, 'Lugo', 'LU', 12),
    (28, 'Madrid', 'M', 14),
    (29, 'Málaga', 'MA', 1),
    (30, 'Murcia', 'MU', 15),
    (31, 'Navarra', 'NA', 16),
    (32, 'Orense', 'OR', 12),
    (33, 'Asturias', 'AS', 3),
    (34, 'Palencia', 'P', 8),
    (35, 'Las Palmas', 'GC', 5),
    (36, 'Pontevedra', 'PO', 12),
    (37, 'Salamanca', 'SA', 8),
    (38, 'Santa Cruz de Tenerife', 'TF', 5),
    (39, 'Cantabria', 'S', 6),
    (40, 'Segovia', 'SG', 8),
    (41, 'Sevilla', 'SE', 1),
    (42, 'Soria', 'SO', 8),
    (43, 'Tarragona', 'T', 9),
    (44, 'Teruel', 'TE', 2),
    (45, 'Toledo', 'TO', 7),
    (46, 'Valencia', 'V', 10),
    (47, 'Valladolid', 'VA', 8),
    (48, 'Vizcaya', 'BI', 17),
    (49, 'Zamora', 'ZA', 8),
    (50, 'Zaragoza', 'Z', 2),
    (51, 'Ceuta', 'CE', 18),
    (52, 'Melilla', 'ML', 19);



TRUNCATE dbSupermercado.tblLocalidades;
INSERT INTO dbSupermercado.tblLocalidades(localidad,idlocalidad)
VALUES
  ('Madrid', '28001'),
  ('Barcelona',  '08001'),
  ('Valencia',  '46001'),
  ('Sevilla',  '41001'),
  ('Zaragoza', '50001'),
  ('Málaga',  '29001'),
  ('Murcia',  '30001'),
  ('Palma de Mallorca',  '07001'),
  ('Las Palmas de Gran Canaria', '35001'),
  ('Bilbao', '48001'),
  ('Alicante', '03001'),
  ('Córdoba',  '14001'),
  ('Granada',  '18001'),
  ('Oviedo', '33001'),
  ('Gijón',  '33201'),
  ('Santander', '39001'),
  ('Valladolid',  '47001'),
  ('Salamanca', '37001'),
  ('Segovia',  '40001'),
  ('Toledo',  '45001');


TRUNCATE dbSupermercado.tblSupermercados;
INSERT INTO dbSupermercado.tblSupermercados(super)
VALUES ('El Cortes Ingles'),
       ('Alimerka'),
       ('El Arbol'),
       ('MasYMas'),
       ('Carrefour'),
       ('Lidl'),
       ('Alcampo'),
       ('Consum'),
       ('Mercadona');


/* ------------------------------------------------------------------
       Información General de las Tiendas
   ------------------------------------------------------------------ */
# Creación de una Tienda: Insertar los datos de la tienda y obtenemos el ID asignado a la tienda de forma automatica ---- */

SELECT idsuper INTO @idsuper FROM dbSupermercado.tblSupermercados WHERE upper(super) LIKE upper('Alcampo');

TRUNCATE dbSupermercado.tblTiendas;
INSERT INTO dbSupermercado.tblTiendas(tblTiendas.idsuper,codigo,idlocalidad, hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
VALUES (@idsuper,1,'46001', 9, 21, 'Lun-Sab', 0,'Avenida Pelis i Valero', '960111222', 'info@tienda.com');
SET @idtienda = LAST_INSERT_ID();


# -- Insertar los Tipos de ventas
TRUNCATE dbSupermercado.tblTipoVentas;
INSERT INTO dbSupermercado.tblTipoVentas(idtipo, venta)
VALUES (1, 'ONLINE'),
       (2, 'TIENDA'),
       (3, 'ADOMICILIO');

# -- Insertar los Servicios
TRUNCATE dbSupermercado.tblServicios;
INSERT INTO dbSupermercado.tblServicios (servicio)
VALUES ('Parking'),
       ('Panaderia'),
       ('Pescaderia'),
       ('Carniceria'),
       ('Entrega a domicilio');

#  Insertar Categorias de los productos
TRUNCATE dbSupermercado.tblCategorias;
INSERT INTO dbSupermercado.tblCategorias(categoria)
VALUES (UPPER('Jardin')),
       (UPPER('Deporte')),
       (UPPER('Cocina')),
       (UPPER('Hogar')),
       (UPPER('Bricolaje')),
       (UPPER('Moda')),
       (UPPER('Mascotas')),
       (UPPER('Bebe')),
       (UPPER('Juguetes')),
       (UPPER('Carnes')),
       (UPPER('Lacteos')),
       (UPPER('Pescado')),
       (UPPER('Frescura')),
       (UPPER('Bebidas')),
       (UPPER('Vinos')),
       (UPPER('Despensa')),
       (UPPER('Cosmetica e higiene')),
       (UPPER('Refrigerados')),
       (UPPER('Panaderia')),
       (UPPER('Electronica')),
       (UPPER('Limpiesa'));

/* --- Insertar las Medidas y Marcas de los productos -- */
TRUNCATE dbSupermercado.tblMedidas;
INSERT INTO dbSupermercado.tblMedidas(medidas)
VALUES (upper('Unidad')),
       (upper('Malla')),
       (upper('Bolsa')),
       (upper('Caja')),
       (upper('Kilos')),
       (upper('Gramo'));

TRUNCATE dbSupermercado.tblMarcas;
INSERT INTO dbSupermercado.tblMarcas(marca)
VALUES (upper('Ufesa')),
       (upper('philips'));


# Insertar subcategoria para algunos productos: Buscar el ID de la categoria 'Jardin'
SELECT idcategoria
INTO @x_idcategoria
FROM dbSupermercado.tblCategorias
WHERE upper(tblCategorias.categoria) LIKE upper('Jardin');

INSERT INTO dbSupermercado.tblSubCategorias(subcategoria, idcategoria)
VALUES (upper('Muebles y decoración'), @x_idcategoria),
       (upper('Herramientas'), @x_idcategoria),
       (upper('Barbacoa'), @x_idcategoria),
       (upper('Camping'), @x_idcategoria);

SELECT idcategoria
INTO @x_idcategoria
FROM dbSupermercado.tblCategorias
WHERE tblCategorias.categoria LIKE upper('deporte');

INSERT INTO dbSupermercado.tblSubCategorias(subcategoria, idcategoria)
VALUES (upper('Ropa deportiva mujer'), @x_idcategoria),
       (upper('Ropa deportiva hombre'), @x_idcategoria),
       (upper('Accesorios deporte'), @x_idcategoria);

SELECT idcategoria
INTO @x_idcategoria
FROM dbSupermercado.tblCategorias
WHERE tblCategorias.categoria LIKE upper('cocina');

INSERT INTO dbSupermercado.tblSubCategorias(subcategoria, idcategoria)
VALUES (upper('Pequeños electrodomésticos de cocina'), @x_idcategoria),
       (upper('Menaje'), @x_idcategoria);

SELECT idcategoria
INTO @x_idcategoria
FROM dbSupermercado.tblCategorias
WHERE tblCategorias.categoria LIKE upper('Bricolaje');

INSERT INTO dbSupermercado.tblSubCategorias(subcategoria, idcategoria)
VALUES (upper('Herramientas electricas'), @x_idcategoria),
       (upper('Herramientas manuales'), @x_idcategoria),
       (upper('Accesorios bricolaje'), @x_idcategoria);

/* -- Insertar las ofertas ---- */
TRUNCATE dbSupermercado.tblOfertas;
INSERT INTO dbSupermercado.tblOfertas(detalle, oferta, valor, tipo_descuento, idcategoria)
VALUES (upper('SIN OFERTA'), upper('SIN OFERTA'), 0, 1, 0),
       (upper('Oferta 2da unidad 50% descuento'), upper('2X50%'), 50, 2, 12),
       (upper('Oferta 3X2 compra 3 unidades y pagas 2'), upper('3X2'), 100, 2, 19),
       (upper('Oferta 2X1 compra 2 unidades y pagas 1'), upper('2x1'), 100, 2, 4),
       (upper('Oferta 10% descuento'), upper('10%'), 10, 2, 4),
       (upper('Oferta 20% descuento'), upper('20%'), 20, 2, 7),
       (upper('Oferta 50% descuento'), upper('50%'), 50, 2, 7);

# -- Insertar los Puestos
TRUNCATE dbSupermercado.tblPuestos;
INSERT INTO dbSupermercado.tblPuestos(puesto)
VALUES ('Empleado General'),
       ('Cajero'),
       ('Dependiente'),
       ('Jefe de area'),
       ('Gerente');

/* ------------- Relaciones sobre Tienda   ------------------------------ */

/* -- Crear el Almacen "Almacen General' en la tienda creada -- */
TRUNCATE dbSupermercado.tblTiendaAlmacen;
INSERT INTO dbSupermercado.tblTiendaAlmacen(descripcion, idtienda)
VALUES ('Almacen General', @idtienda);
SET @idalmacen = LAST_INSERT_ID();

TRUNCATE dbSupermercado.tblTiendaServicios;
INSERT INTO dbSupermercado.tblTiendaServicios
    values(@idtienda, 1),
          (@idtienda, 2),
          (@idtienda, 3),
          (@idtienda, 4),
          (@idtienda, 5);

TRUNCATE dbSupermercado.tblTiendaTipoVentas;
INSERT INTO  dbSupermercado.tblTiendaTipoVentas
    values(@idtienda, 1),
          (@idtienda, 2),
          (@idtienda, 3);



# asignar la oferta 'Oferta 10% descuento en hogar' a la tienda creada, sin asignar fecha de inicio y vencimiento --- */
# Buscar el ID de oferta 'Oferta 10% descuento en hogar'
SELECT idoferta
INTO @idoferta
FROM dbSupermercado.tblOfertas
WHERE tblOfertas.oferta LIKE lower('50%');

-- El valor 0 de los campos finicio y fvencimiento, es que no está activa
TRUNCATE dbSupermercado.tblTiendaOfertas;
INSERT INTO dbSupermercado.tblTiendaOfertas(idtienda, idoferta,idsuper, finicio, fvencimiento)
VALUES (@idtienda, @idoferta,0, 0, 0);

/* ------------------------------------------------------------------
                    Información Financiera
   ------------------------------------------------------------------ */
INSERT INTO dbSupermercado.tblMetodosPagos(metodo)
    VALUES (lower('efectivo')),
            (lower('tarjeta debito')),
            (lower('tarjeta credito')),
            (lower('tranferencia')),
            (lower('bizzum')),
            (lower('paypal'));

/* ------------------------------------------------------------------
       Información General de los Empleados
   ------------------------------------------------------------------ */

# Insertar el empleado con dni '11111111A' que reside en oviedo en la tienda creada
# buscar el ID de la provincia de valencia antes de insertar el empleado
SELECT idlocalidad INTO @idlocalidad FROM dbSupermercado.tblLocalidades
WHERE lower(localidad) LIKE lower('oviedo');

TRUNCATE dbSupermercado.tblEmpleados;
INSERT INTO dbSupermercado.tblEmpleados(dni, nombre, apellidos, nacimiento, sexo, direccion1, direccion2, idlocalidad,
                                        telefono, email)
VALUES ('11111111A', 'Empleado 1', 'Apellido 1', 111970, 1, 'Ave Gran via 1', 'Oviedo Ciudad', @idlocalidad,
        600600600,'info@gmail.com');

/* ------- Insertar un empleado '11111111A' como 'Gerente' de la tienda creada ------ */
# Buscar el ID del empleado
SELECT idempleado INTO @idempleado FROM dbSupermercado.tblEmpleados
WHERE tblEmpleados.dni LIKE upper('11111111A');

# Buscar el ID del puesto de 'Gerente'
SELECT idpuesto
INTO @idpuesto
FROM dbSupermercado.tblPuestos
WHERE upper(tblPuestos.puesto) LIKE upper('gerente');

TRUNCATE dbSupermercado.tblTiendaEmpleadosPuestos;
INSERT INTO dbSupermercado.tblTiendaEmpleadosPuestos(idtienda, idempleado, idpuesto)
    VALUE (@idtienda, @idempleado, @idpuesto);

/* -- Asignar el empleado '11111111A' como responsable de almacen de la tienda creada  -- */
UPDATE dbSupermercado.tblTiendaAlmacen
SET responsable = @idempleado
WHERE idtienda = @idtienda;


/* ------------------------------------------------------------------
       Información General de los Proveedores
   ------------------------------------------------------------------ */
# Crear el proveedor con CIF 'A123456' con localidad en 'Valencia centro ' ------ */

# Buscar el ID de la localidad 'Valencia Centro'
SELECT idlocalidad INTO @idlocal FROM dbSupermercado.tblLocalidades
WHERE upper(tblLocalidades.localidad) LIKE upper('Valencia');

TRUNCATE dbSupermercado.tblProveedores;
INSERT INTO dbSupermercado.tblProveedores(cif, proveedor, direccion1, direccion2, idlocalidad, telefono, email)
VALUES ('A123456', 'Supermercado Lidl', 'Avenida Pelis i Valero 1', 'Valencia Ciudad', @idlocal, '600600600',
        'info@lidl.com');
SET @idproveedor = LAST_INSERT_ID();


/* ------------------------------------------------------------------
       Información General de Productos
   ------------------------------------------------------------------ */

/* Insertar los siguientes productos, donde la medias es 'Unidad', perteneciente a la categoria 'Cocina' para el proveedor y
   tienda creada para las marcas 'UFESA' y 'philips'  */
# Buscar los ID necesarios para insertar los productos

SELECT idsuper
INTO @idsuper
FROM dbSupermercado.tblSupermercados
WHERE tblSupermercados.super LIKE trim(lower('Alcampo'));


SELECT idmedida
INTO @idmedida
FROM dbSupermercado.tblMedidas
WHERE tblMedidas.medidas LIKE upper('Unidad');

SELECT idcategoria
INTO @idcategoria
FROM dbSupermercado.tblCategorias
WHERE tblCategorias.categoria LIKE upper('cocina');

SELECT idmarca
INTO @idmarca
FROM dbSupermercado.tblMarcas
WHERE tblMarcas.marca LIKE upper('UFESA');

/* Eliminar la inforación de la tabla productos y tablas relacionadas */
TRUNCATE TABLE dbSupermercado.tblProductos;
INSERT INTO dbSupermercado.tblProductos(codigo, producto, información, origen, cantidad,cant_alert, precio, precio_oferta,
                                        precio_venta, iva, contenido, peso,
                                        vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida,
                                        idcategoría, idmarca,
                                        idoferta, idproveedor, idalmacen, idtienda,idsuper)
VALUES (420020, 'Ufesa ® Batidora de mano 1100 W',
        'Ufesa ® Batidora de mano 1100 W con 2 cuchillas de acero inoxidable de alta calidad.', 'España', 10,5, 54.99,
        44.99, 64, 21, 1,
        1.32, 's/c', 0, 0, 0, 0, 1, @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen,
        @idtienda,@idsuper);

SELECT idmarca
INTO @idmarca
FROM dbSupermercado.tblMarcas
WHERE tblMarcas.marca LIKE upper('philips');

INSERT INTO dbSupermercado.tblProductos(codigo, producto, información, origen, cantidad,cant_alert, precio, precio_oferta,
                                        precio_venta, iva, contenido, peso,
                                        vencimiento, fila, pasillo, estanteria, nevera, tipoventa, idmedida,
                                        idcategoría, idmarca,
                                        idoferta, idproveedor, idalmacen, idtienda,idsuper)
    VALUE (401178, 'Philips Batidora 450 W',
           'Philips Batidora 450 W para una gran ayuda en la cocina y obtener resultados perfectos en la preparación de batidos',
           'España', 10,6, 29.99, 24.99, 36, 21, 1,
           1.583, 's/c', 0, 0, 0, 0, 123, @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen,
           @idtienda,@idsuper);


-- Insertar 10 productos en la tabla tblProductos

-- Obtener IDs necesarios para las claves foráneas
SELECT idmarca INTO @idmarca FROM dbSupermercado.tblMarcas LIMIT 1;
SELECT idcategoria INTO @idcategoria FROM dbSupermercado.tblCategorias WHERE categoria = 'LACTEOS' LIMIT 1;
SELECT idproveedor INTO @idproveedor FROM dbSupermercado.tblProveedores LIMIT 1;
SELECT idalmacen INTO @idalmacen FROM dbSupermercado.tblTiendaAlmacen LIMIT 1;
SELECT idtienda INTO @idtienda FROM dbSupermercado.tblTiendas LIMIT 1;
SELECT idsuper INTO @idsuper FROM dbSupermercado.tblSupermercados LIMIT 1;
SELECT idmedida INTO @idmedida FROM dbSupermercado.tblMedidas WHERE medidas = 'UNIDAD' LIMIT 1;
SET @idoferta = NULL; -- Sin oferta

-- Insertar productos
INSERT INTO dbSupermercado.tblProductos (
    codigo, producto, información, origen, cantidad, cant_alert,
    precio, precio_oferta, precio_venta, iva, contenido, peso,
    vencimiento, fila, pasillo, estanteria, nevera, tipoventa,
    idmedida, idcategoría, idmarca, idoferta, idproveedor, idalmacen, idtienda, idsuper
) VALUES
-- Leche Entera 1L
(100001, 'Leche Entera 1L', 'Leche entera UHT 1 litro', 'España', 100, 20,
 0.95, 0.85, 1.15, 4, 1, 1.03,
 '2024-12-31', 1, 1, 1, 1, 2,
 @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen, @idtienda, @idsuper),

-- Pan de molde integral
(100002, 'Pan de molde integral', 'Pan de molde integral 400g', 'España', 50, 10,
 1.20, 0.99, 1.45, 10, 1, 0.4,
 '2024-01-15', 2, 1, 1, 0, 2,
 @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen, @idtienda, @idsuper),

-- Manzanas Royal Gala
(100003, 'Manzanas Royal Gala', 'Manzanas Royal Gala kg', 'España', 150, 30,
 1.99, 1.79, 2.41, 10, 1, 1.0,
 '2024-01-10', 3, 2, 2, 1, 2,
 @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen, @idtienda, @idsuper),

-- Arroz blanco 1kg
(100004, 'Arroz blanco 1kg', 'Arroz blanco de grano redondo', 'España', 80, 15,
 0.89, 0.75, 1.08, 10, 1, 1.0,
 '2025-12-31', 4, 3, 1, 0, 2,
 @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen, @idtienda, @idsuper),

-- Atún en aceite de oliva
(100005, 'Atún en aceite de oliva', 'Atún claro en aceite de oliva 80g', 'España', 60, 12,
 1.75, 1.50, 2.12, 10, 1, 0.08,
 '2025-06-30', 5, 4, 2, 0, 2,
 @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen, @idtienda, @idsuper),

-- Yogur natural 4 unidades
(100006, 'Yogur natural 4x125g', 'Yogur natural sin azúcares añadidos', 'España', 120, 25,
 1.45, 1.25, 1.75, 4, 4, 0.5,
 '2024-01-20', 1, 1, 2, 1, 2,
 @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen, @idtienda, @idsuper),

-- Aceite de oliva virgen extra 1L
(100007, 'Aceite de oliva virgen extra 1L', 'Aceite de oliva virgen extra primera prensada en frío', 'España', 70, 15,
 4.95, 4.50, 5.99, 10, 1, 0.92,
 '2025-12-31', 2, 5, 1, 0, 2,
 @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen, @idtienda, @idsuper),

-- Huevos camperos talla L 12ud
(100008, 'Huevos camperos talla L 12ud', 'Huevos de gallinas camperas', 'España', 90, 20,
 3.25, 2.99, 3.93, 4, 12, 0.78,
 '2024-02-10', 3, 1, 3, 1, 2,
 @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen, @idtienda, @idsuper),

-- Pan de barra 250g
(100009, 'Pan de barra 250g', 'Pan de barra artesano', 'España', 40, 10,
 0.65, 0.55, 0.79, 10, 1, 0.25,
 '2024-01-08', 2, 1, 2, 0, 2,
 @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen, @idtienda, @idsuper),

-- Agua mineral 1.5L
(100010, 'Agua mineral 1.5L', 'Agua mineral natural', 'España', 200, 40,
 0.45, 0.39, 0.54, 10, 1.5, 1.6,
 '2025-12-31', 4, 6, 1, 1, 2,
 @idmedida, @idcategoria, @idmarca, @idoferta, @idproveedor, @idalmacen, @idtienda, @idsuper);


SET foreign_key_checks = 1;

COMMIT;

# Actualiza un registro, un campo

UPDATE dbSupermercado.tblTiendas
SET horario = 'Lun - Vie: 10:00h - 17:00h, Sab: Cerrado'
WHERE idtienda = 1;

# Actualiza un registro,  varios campos
UPDATE dbSupermercado.tblTiendas
SET horario = 'Lun - Vie: 10:00h - 17:00h, Sab: Cerrado',
    email = 'info@clinica2.com'
WHERE idtienda = 2;

# Actualiza todos los registros
UPDATE dbSupermercado.tblTiendas
SET telefono = concat('+34',telefono);



-- Activar las FK
SET foreign_key_checks = 1;

COMMIT;
/* -- Insertar para la categoria 'Jardin", las subcategorias :
      'Muebles y decoración', 'Herramientas', 'Barbacoa', 'Camping'

      Para la categoria 'deporte' las subcategorias:
      'Ropa deportiva mujer', 'Ropa deportiva hombre', 'Accesorios deporte'

     Para la categoria 'cocina' las subcategorias:
      'Pequeños electrodomésticos de cocina','Menaje'

     Para la categoria 'Bricolaje' las subcategorias:
      'Herramientas electricas', 'Herramientas manuales','Accesorios bricolaje'

 */

# crea solo la estructura de la tabla
#CREATE TABLE dbSupermercado.tblCopias_Produtos AS (SELECT * FROM dbSupermercado.tblProductos limit 0);

/*INSERT INTO dbSupermercado.tblCopias_Produtos
SELECT *  FROM dbSupermercado.tblProductos;*/

# crea la estructura de la tabla y copia todos los registros
#CREATE TABLE dbSupermercado.tblCopias_Produtos2 AS (SELECT * FROM dbSupermercado.tblProductos);

# crea la estructura de la tabla y copia hasta 100 registros
#CREATE TABLE dbSupermercado.tblCopias_Produtos3 AS (SELECT * FROM dbSupermercado.tblProductos limit 100);


# Actualiza un registro, un campo

UPDATE dbSupermercado.tblTiendas
SET horario = 'Lun - Vie: 10:00h - 17:00h, Sab: Cerrado'
WHERE idtienda = 1;

# Actualiza un registro,  varios campos
UPDATE dbSupermercado.tblTiendas
SET horario = 'Lun - Vie: 10:00h - 17:00h, Sab: Cerrado',
    email = 'info@clinica2.com'
WHERE idtienda = 2;

# Actualiza todos los registros
UPDATE dbSupermercado.tblTiendas
SET telefono = concat('+34',telefono);


# Elimina todos los registros
#DELETE FROM dbSupermercado.tblTiendas;

# Elimina todos los registro, según la condición
#DELETE FROM dbSupermercado.tblTiendas
#WHERE idlocalidad BETWEEN 46000 AND 46999;



