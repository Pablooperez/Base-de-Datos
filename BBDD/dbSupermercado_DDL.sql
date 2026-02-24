/*
Base Datos: dbSupermercado
Autor: Rafa Acosta
Descripción:
Gestión de una base de datos para la actividad de un supermercado
*/

/* ----------------------------------------------------------------------
                Creación de las estructura de la Base Datos (DDL)
   --------------------------------------------------------------------- */

-- Comenzar  Trans. para crear la estrutura generada por el Modelo E/R
BEGIN;

DROP DATABASE IF EXISTS dbSupermercado;
CREATE DATABASE dbSupermercado;
USE dbSupermercado;

# ----------------------- Tablas Generales -------------------------------
DROP TABLE IF EXISTS tblComunidades;
CREATE TABLE tblComunidades (
  idcomunidad TINYINT UNSIGNED NOT NULL,
  comunidad VARCHAR(100) NOT NULL,
  PRIMARY KEY (idcomunidad)
);


-- tabla Provincias y localidades
DROP TABLE IF EXISTS tblProvincias;
CREATE TABLE tblProvincias
(
    idprovincia TINYINT UNSIGNED NOT NULL, # son los 2 primeros digitos del cp
    provincia   VARCHAR(100) NOT NULL,
    prov         VARCHAR(3) NOT NULL,
    idcomunidad  TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (idprovincia),
    FOREIGN KEY (idcomunidad) REFERENCES tblComunidades(idcomunidad)
);

DROP TABLE IF EXISTS tblLocalidades;
CREATE TABLE tblLocalidades
(
    idlocalidad VARCHAR(5) NOT NULL, # es el cp
    localidad   VARCHAR(100) NOT NULL,
    PRIMARY KEY (idlocalidad));

CREATE INDEX idx_provincia
    ON tblProvincias (provincia);
CREATE INDEX idx_localidad
    ON tblLocalidades (idlocalidad);

DROP TABLE IF EXISTS tblSupermercados;
CREATE TABLE tblSupermercados
(
    idsuper TINYINT UNSIGNED NOT NULL AUTO_INCREMENT, # es el cp
    super   VARCHAR(100) NOT NULL,
    PRIMARY KEY (idsuper));

CREATE INDEX idx_super
    ON tblSupermercados (super);

/* -------------------------------------------------------------------------
                        Información General de las Tiendas
   ------------------------------------------------------------------------ */


# Tabla de Tienda
DROP TABLE IF EXISTS tblTiendas;
CREATE TABLE tblTiendas
(
    idtienda TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    idsuper  TINYINT UNSIGNED NOT NULL,
    codigo INT NOT NULL,
    idlocalidad VARCHAR(5) NOT NULL NOT NULL,
    hora_apertura  INT NOT NULL,
    hora_cierre INT NOT NULL,
    horario VARCHAR(50) NOT NULL,
    gerente TINYINT UNSIGNED NULL, # idempleado , valor 0 no hay asignado gerente
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY (idtienda),
    FOREIGN KEY (idlocalidad) REFERENCES tblLocalidades (idlocalidad),
    FOREIGN KEY (idsuper) REFERENCES tblSupermercados(idsuper)
);

# Tabla Servicios de la tienda
DROP TABLE IF EXISTS tblServicios;
CREATE TABLE tblServicios
(
    idservicio TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    servicio   VARCHAR(50) NOT NULL,
    PRIMARY KEY (idservicio)
);
CREATE INDEX idx_servicios
    ON tblServicios (servicio);

# Tabla de Tipos de ventas
DROP TABLE IF EXISTS tblTipoVentas;
CREATE TABLE tblTipoVentas
(
    idtipo TINYINT UNSIGNED NOT NULL,
    venta VARCHAR(50), # online, en tienda, a domicilio
    PRIMARY KEY  (idtipo)
);
# Insertar Medidas para los productos
DROP TABLE IF EXISTS tblMedidas;
CREATE TABLE tblMedidas
(
    idmedida TINYINT NOT NULL AUTO_INCREMENT,
    medidas  VARCHAR(50), # medida (unidad, malla, bolsa, caja)
    PRIMARY KEY (idmedida)
);
# Insertar Marcas de los productos
DROP TABLE IF EXISTS dbSupermercado.tblMarcas;
CREATE TABLE tblMarcas
(
    idmarca TINYINT NOT NULL AUTO_INCREMENT,
    marca  VARCHAR(50),
    PRIMARY KEY (idmarca)
);

# Tabla de categorias de productos
DROP TABLE IF EXISTS dbSupermercado.tblCategorias;
CREATE TABLE dbSupermercado.tblCategorias
(
    idcategoria TINYINT NOT NULL AUTO_INCREMENT,
    categoria   VARCHAR(50),   # ( carnes, lácteos, pescado, frutas y verduras)
    PRIMARY KEY (idcategoria)
);
CREATE INDEX idx_cat ON dbSupermercado.tblCategorias(categoria);

# Tabla de Subcategoria de los productos
DROP TABLE IF EXISTS dbSupermercado.tblSubCategorias;
CREATE TABLE dbSupermercado.tblSubCategorias
(
    idsubacat TINYINT NOT NULL AUTO_INCREMENT,
    subcategoria VARCHAR(50) NOT NULL,
    idcategoria TINYINT NOT NULL,
    PRIMARY KEY (idsubacat),
    FOREIGN KEY (idcategoria) REFERENCES dbSupermercado.tblCategorias(idcategoria)
);
CREATE INDEX idx_subcat ON dbSupermercado.tblSubCategorias(subcategoria);

# Tabla de Ofertas
DROP TABLE IF EXISTS tblOfertas;
CREATE TABLE tblOfertas
(
    idoferta TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    detalle VARCHAR(100) NOT NULL,
    oferta VARCHAR(100) NOT NULL,
    valor FLOAT NOT NULL,
    tipo_descuento TINYINT NOT NULL, -- 1 Valor, 2 Porcentaje
    idcategoria TINYINT NOT NULL,
    PRIMARY KEY (idoferta)
);
# Tabla de Cupones
DROP TABLE IF EXISTS tblCupones;
CREATE TABLE tblCupones
(
    idcupon TINYINT UNSIGNED NOT NULL ,
    cupon VARCHAR(100) NOT NULL,
    finicio INT NOT NULL,
    fvencimiento  INT NOT NULL,
    idproducto INT NOT NULL, # si el valor es 0 , es un descuento general y no sobre el producto
    valor TINYINT UNSIGNED NOT NULL , # valor positivo (% de descuento) , valor negativo (valor de descuento)
    PRIMARY KEY (idcupon)
);
#  Tabla de Puestos
DROP TABLE IF EXISTS tblPuestos;
CREATE TABLE tblPuestos
(
    idpuesto TINYINT UNSIGNED NOT NULL AUTO_INCREMENT ,
    puesto VARCHAR(50) NOT NULL,
    PRIMARY KEY (idpuesto)
);
CREATE INDEX idx_puesto
    ON tblPuestos (puesto);

DROP TABLE IF EXISTS tblInfoGeneral;
CREATE TABLE tblInfoGeneral
(
    idinfo TINYINT UNSIGNED NOT NULL ,
    text1 VARCHAR(100) NOT NULL,
    text2 VARCHAR(100) NOT NULL,
    text3 VARCHAR(100) NOT NULL,
    text4 VARCHAR(100) NOT NULL,
    text5 VARCHAR(100) NOT NULL,
    PRIMARY KEY (idinfo)
);



# ----------------------- Tablas de Relaciones correspondientes a Tienda  -------------------------------

DROP TABLE IF EXISTS tblTiendaServicios;
CREATE TABLE tblTiendaServicios
(
    idtienda TINYINT UNSIGNED NOT NULL ,
    idservicio TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (idtienda) REFERENCES tblTiendas (idtienda),
    FOREIGN KEY (idservicio) REFERENCES tblServicios (idservicio)
);

DROP TABLE IF EXISTS tblTiendaTipoVentas;
CREATE TABLE tblTiendaTipoVentas
(
    idtienda TINYINT UNSIGNED NOT NULL ,
    idventa TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (idtienda) REFERENCES tblTiendas (idtienda),
    FOREIGN KEY (idventa) REFERENCES tblTipoVentas(idtipo)
);

DROP TABLE IF EXISTS tblTiendaOfertas;
CREATE TABLE tblTiendaOfertas
(
    idtienda TINYINT UNSIGNED NOT NULL ,
    idoferta TINYINT UNSIGNED NOT NULL,
    idsuper TINYINT UNSIGNED NOT NULL , # 0 solo en tienda, 1 en cualquier tienda del super
    finicio INT NOT NULL,
    fvencimiento  INT NOT NULL,
    FOREIGN KEY (idtienda) REFERENCES tblTiendas (idtienda),
    FOREIGN KEY (idoferta) REFERENCES tblOfertas (idoferta)
);
DROP TABLE IF EXISTS tblTiendaCupones;
CREATE TABLE tblTiendaCupones
(
    idtienda TINYINT UNSIGNED NOT NULL ,
    idsuper TINYINT UNSIGNED NOT NULL , # 0 solo en tienda, 1 en cualquier tienda del super
    idcupon TINYINT UNSIGNED NOT NULL,
    finicio INT NOT NULL,
    fvencimiento  INT NOT NULL,
    FOREIGN KEY (idtienda) REFERENCES tblTiendas (idtienda),
    FOREIGN KEY (idcupon) REFERENCES tblCupones (idcupon)
);



/* -------------------------------------------------------------------------
                        Información General de  Empleados
   ------------------------------------------------------------------------ */

# Empleados  -------------------------------
DROP TABLE IF EXISTS dbSupermercado.tblEmpleados;
CREATE TABLE dbSupermercado.tblEmpleados
(
    idempleado TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    dni blob NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    nacimiento INT UNSIGNED NOT NULL,
    sexo TINYINT UNSIGNED NOT NULL ,
    direccion1 VARCHAR(50) NOT NULL,
    direccion2 VARCHAR(50) NOT NULL,
    idlocalidad VARCHAR(5) NULL,
    telefono INT UNSIGNED NOT NULL,
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY  (idempleado),
    FOREIGN KEY (idlocalidad) REFERENCES tblLocalidades (idlocalidad)
);
CREATE INDEX idx_empleado ON tblEmpleados(apellidos,nombre);


DROP TABLE IF EXISTS tblTiendaEmpleadosPuestos;
CREATE TABLE tblTiendaEmpleadosPuestos
(
    idtienda TINYINT UNSIGNED NOT NULL ,
    idempleado TINYINT UNSIGNED NOT NULL,
    idpuesto TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (idtienda) REFERENCES tblTiendas (idtienda),
    FOREIGN KEY (idempleado) REFERENCES tblEmpleados (idempleado),
    FOREIGN KEY (idpuesto) REFERENCES tblPuestos (idpuesto)
);

/* -------------------------------------------------------------------------
                        Información General de  Proveedores
   ------------------------------------------------------------------------ */
DROP TABLE IF EXISTS tblTiendaAlmacen;
CREATE TABLE tblTiendaAlmacen(
   idalmacen TINYINT NOT NULL AUTO_INCREMENT,
   descripcion VARCHAR(50) NOT NULL,
   idtienda TINYINT UNSIGNED NOT NULL,
   responsable TINYINT UNSIGNED ,
   PRIMARY KEY (idalmacen) ,
   FOREIGN KEY (responsable)  REFERENCES tblEmpleados(idempleado),
   FOREIGN KEY (idtienda)  REFERENCES tblTiendas(idtienda)
);
DROP TABLE IF EXISTS tblProveedores;
CREATE TABLE tblProveedores
(
    idproveedor TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    cif VARCHAR(9) NOT NULL,
    proveedor VARCHAR(100) NOT NULL,
    direccion1 VARCHAR(50) NOT NULL,
    direccion2 VARCHAR(50) NOT NULL,
    idlocalidad VARCHAR(5)  NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL,
    FOREIGN KEY (idlocalidad) REFERENCES tblLocalidades (idlocalidad),
    PRIMARY KEY  (idproveedor)
);
CREATE INDEX idx_proveedor ON tblProveedores(proveedor,cif);


/* -------------------------------------------------------------------------
                        Información Productos
   ------------------------------------------------------------------------ */
DROP TABLE IF EXISTS tblProductos;
CREATE TABLE tblProductos
(
    codigobarra   INT          NOT NULL AUTO_INCREMENT,
    codigo        INT          NOT NULL,
    producto      VARCHAR(100) NOT NULL,
    información   VARCHAR(150) NOT NULL,
    origen        VARCHAR(100) NOT NULL, # pais del producto
    cantidad      INT          NOT NULL,
    cant_alert    FLOAT        NOT NULL,
    precio        FLOAT        NOT NULL,
    precio_oferta FLOAT        NOT NULL,
    precio_venta  FLOAT        NOT NULL,
    iva           TINYINT      NOT NULL,
    contenido     FLOAT        NOT NULL,
    peso          FLOAT        NOT NULL,
    vencimiento   VARCHAR(10)  NOT NULL,
    fila          TINYINT      NOT NULL,
    pasillo       TINYINT      NOT NULL,
    estanteria    TINYINT      NOT NULL,
    nevera        TINYINT      NOT NULL,
    tipoventa     TINYINT      NOT NULL, # 1 online, 2 tienda, 3 a domicilio
    idmedida      TINYINT      NOT NULL, # fk
    idcategoría   TINYINT      NOT NULL, # fk
    idmarca       TINYINT         NOT NULL, # fk
    idoferta      TINYINT UNSIGNED     NULL, # fk
    idproveedor   TINYINT  UNSIGNED    NOT NULL, # fk
    idalmacen     TINYINT NOT NULL,
    idtienda      TINYINT UNSIGNED     NOT NULL, # fk
    idsuper        TINYINT UNSIGNED     NOT NULL, # fk
    PRIMARY KEY (codigobarra),
    FOREIGN KEY (idmedida) REFERENCES tblMedidas(idmedida),
    FOREIGN KEY (idcategoría) REFERENCES tblCategorias(idcategoria),
    FOREIGN KEY (idmarca) REFERENCES tblMarcas(idmarca),
    FOREIGN KEY (idoferta) REFERENCES tblOfertas(idoferta),
    FOREIGN KEY (idproveedor) REFERENCES tblProveedores(idproveedor),
    FOREIGN KEY (idalmacen) REFERENCES dbSupermercado.tblTiendaAlmacen(idalmacen),
    FOREIGN KEY (idtienda) REFERENCES tblTiendas(idtienda),
    FOREIGN KEY (idsuper) REFERENCES tblSupermercados(idsuper)
);

DROP TABLE IF EXISTS tblProductos_alerta;
CREATE TABLE tblProductos_alerta
(
    codigobarra   INT          NOT NULL ,
    codigo        INT          NOT NULL,
    fecha_registro INT         NOT NULL,
    alerta        VARCHAR(25)  NOT NULL, -- Agotado / Solicitar
    idproveedor   TINYINT  UNSIGNED    NOT NULL, # fk
    idtienda      TINYINT UNSIGNED     NOT NULL, # fk
    FOREIGN KEY  (codigobarra) REFERENCES tblProductos(codigobarra),
    FOREIGN KEY (idproveedor) REFERENCES tblProveedores(idproveedor),
    FOREIGN KEY (idtienda) REFERENCES tblTiendas(idtienda)
);
# Tablas sobre Métodos de pago
DROP TABLE IF EXISTS tblMetodosPagos;
CREATE TABLE tblMetodosPagos
(
    idmetodopago TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    metodo VARCHAR(15) NOT NULL,
    PRIMARY KEY  (idmetodopago)
);

# Tablas Membresía
DROP TABLE IF EXISTS tblMembresias;
CREATE TABLE tblMembresias
(
    idsocio INT UNSIGNED NOT NULL,
    dni VARCHAR(9) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(9) NOT NULL,
    nacimiento INT NOT NULL,
    telefono INT NOT NULL,
    email VARCHAR(50) NOT NULL,
    idlocalidad  VARCHAR(5) NOT NULL,
    PRIMARY KEY (idsocio),
    FOREIGN KEY  (idlocalidad) REFERENCES tblLocalidades(idlocalidad)
);
/* -------------------------------------------------------------------------
                        Información Financieros
   ------------------------------------------------------------------------ */
# Tablas sobre Métodos de pago
DROP TABLE IF EXISTS tblMetodosPagos;
CREATE TABLE tblMetodosPagos
(
    idmetodopago TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    metodo VARCHAR(15) NOT NULL,
    PRIMARY KEY  (idmetodopago)
);

DROP TABLE IF EXISTS tblPagos;
CREATE TABLE tblPagos
(
    # si vencimiento y cvv es 0, el pago es bizum (numero - num tel)
    idmetodopago TINYINT UNSIGNED NOT NULL,
    numero INT UNSIGNED NOT NULL,
    vencimiento INT UNSIGNED NOT NULL,
    cvv TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY  (idmetodopago) REFERENCES tblMetodosPagos(idmetodopago)
);

DROP TABLE IF EXISTS tblCajaVentas;
CREATE TABLE tblCajaVentas
(
    idcaja TINYINT NOT NULL AUTO_INCREMENT,
    tipocaja TINYINT NOT NULL, # 1 - presencial, 2 - autoventa
    estado TINYINT NOT NULL, # 0 cerrada 1 abierta
    idempleado TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (idcaja),
    FOREIGN KEY (idempleado) REFERENCES tblEmpleados(idempleado)
);
DROP TABLE IF EXISTS tblTickets;
CREATE TABLE tblTickets
(
    idticket     INT          NOT NULL AUTO_INCREMENT,
    fecha_hora   DATETIME     NOT NULL,
    importe      FLOAT        NOT NULL,
    pagado       FLOAT        NOT NULL DEFAULT (0.0),
    ticket  TINYINT      NOT NULL DEFAULT 0, # tipo de tique ( 0- impreso o 1- digital )
    idmetodopago TINYINT   UNSIGNED   NOT NULL,
    idempleado   TINYINT UNSIGNED     NOT NULL,
    idtipoventa  TINYINT UNSIGNED     NOT NULL,
    idsocio      INT  UNSIGNED        NOT NULL,
    idcaja       TINYINT      NOT NULL,
    info_ticket  VARCHAR(100) NOT NULL,
    PRIMARY KEY (idticket),
    FOREIGN KEY (idtipoventa) REFERENCES tblTipoVentas (idtipo),
    FOREIGN KEY (idempleado) REFERENCES tblEmpleados (idempleado),
    FOREIGN KEY (idmetodopago) REFERENCES tblMetodosPagos (idmetodopago),
    FOREIGN KEY (idempleado) REFERENCES tblEmpleados (idempleado),
    FOREIGN KEY (idsocio) REFERENCES tblMembresias (idsocio),
    FOREIGN KEY (idcaja) REFERENCES tblCajaVentas(idcaja)
);

DROP TABLE IF EXISTS tblTicketsProductos;
CREATE TABLE tblTicketsProductos
(
    idticket INT NOT NULL,
    codigobarra INT NOT NULL,
    precio  FLOAT NOT NULL,
    iva TINYINT NOT NULL,
    cant FLOAT NOT NULL,
    FOREIGN KEY (idticket) REFERENCES tblTickets(idticket),
    FOREIGN KEY (codigobarra) REFERENCES tblProductos(codigobarra)
    );

DROP TABLE IF EXISTS tblTicketsCupones;
CREATE TABLE tblTicketsCupones
(
    idticket INT NOT NULL,
    idcupon TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (idticket) REFERENCES tblTickets(idticket),
    FOREIGN KEY (idcupon) REFERENCES tblCupones(idcupon)
    );

/* -------------------------------------------------------------------------
                        Información Membresía
   ------------------------------------------------------------------------ */

DROP TABLE IF EXISTS tblMembresiasMetodoPagos;
CREATE TABLE tblMembresiasMetodoPagos
(
    idsocio INT UNSIGNED NOT NULL,
    tarjeta INT NOT NULL,
    banco VARCHAR(50) NOT NULL,
    FOREIGN KEY (idsocio) REFERENCES tblMembresias(idsocio)
);

DROP TABLE IF EXISTS tblMembresiasCupones;
CREATE TABLE tblMembresiasCupones
(
    idsocio INT UNSIGNED NOT NULL,
    idcupon TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY  (idsocio) REFERENCES tblMembresias(idsocio),
    FOREIGN KEY  (idcupon) REFERENCES tblCupones(idcupon)
);


# ----------------------- Tablas  Productos , Tickets y almacen-------------------------------



DROP TABLE IF EXISTS tblTicketsProductos;
CREATE TABLE tblTicketsProductos
(
    idticket INT NOT NULL,
    codigobarra INT NOT NULL,
    precio  FLOAT NOT NULL,
    iva TINYINT NOT NULL,
    cant FLOAT NOT NULL,
    FOREIGN KEY (idticket) REFERENCES tblTickets(idticket),
    FOREIGN KEY (codigobarra) REFERENCES tblProductos(codigobarra)
    );

DROP TABLE IF EXISTS tblTicketsCupones;
CREATE TABLE tblTicketsCupones
(
    idticket INT NOT NULL,
    idcupon TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (idticket) REFERENCES tblTickets(idticket),
    FOREIGN KEY (idcupon) REFERENCES tblCupones(idcupon)
    );
COMMIT;