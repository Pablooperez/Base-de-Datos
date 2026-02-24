-- Script: dbMiniSuper
START TRANSACTION;

DROP DATABASE IF EXISTS dbMiniSuper;
CREATE DATABASE IF NOT EXISTS dbMiniSuper;
USE dbMiniSuper;


-- 1) Esquema y tablas
CREATE TABLE IF NOT EXISTS categorias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  descripcion TEXT
);

CREATE TABLE IF NOT EXISTS proveedores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  telefono VARCHAR(30),
  email VARCHAR(150),
  ciudad VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS productos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sku VARCHAR(50) UNIQUE,
  nombre VARCHAR(200) NOT NULL,
  categoria_id INT,
  proveedor_id INT,
  precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
  costo DECIMAL(10,2) NOT NULL CHECK (costo >= 0),
  unidad VARCHAR(20) DEFAULT 'unidad',
  punto_reorden INT DEFAULT 10,
  creado_en TIMESTAMP DEFAULT NOW(),
  CONSTRAINT fk_productos_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE SET NULL,
  CONSTRAINT fk_productos_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS tiendas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  ubicacion VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS empleados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tienda_id INT,
  nombre VARCHAR(150) NOT NULL,
  rol VARCHAR(80),
  CONSTRAINT fk_empleados_tienda FOREIGN KEY (tienda_id) REFERENCES tiendas(id)
);

CREATE TABLE IF NOT EXISTS clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE,
  telefono VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS inventario (
  id INT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT,
  tienda_id INT,
  cantidad INT NOT NULL DEFAULT 0,
  ultima_actualizacion TIMESTAMP DEFAULT NOW(),
  UNIQUE KEY ux_inventario_producto_tienda (producto_id, tienda_id),
  CONSTRAINT fk_inventario_producto FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
  CONSTRAINT fk_inventario_tienda FOREIGN KEY (tienda_id) REFERENCES tiendas(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ordenes_compra (
  id INT AUTO_INCREMENT PRIMARY KEY,
  proveedor_id INT,
  creado_en TIMESTAMP DEFAULT NOW(),
  recibido_en TIMESTAMP,
  estado VARCHAR(50) DEFAULT 'pendiente',
  CONSTRAINT fk_ordenes_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);

CREATE TABLE IF NOT EXISTS items_compra (
  id INT AUTO_INCREMENT PRIMARY KEY,
  orden_compra_id INT,
  producto_id INT,
  cantidad INT NOT NULL,
  costo DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_itemscompra_orden FOREIGN KEY (orden_compra_id) REFERENCES ordenes_compra(id) ON DELETE CASCADE,
  CONSTRAINT fk_itemscompra_producto FOREIGN KEY (producto_id) REFERENCES productos(id)
);

CREATE TABLE IF NOT EXISTS ventas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tienda_id INT,
  cliente_id INT,
  empleado_id INT,
  creado_en TIMESTAMP DEFAULT NOW(),
  total DECIMAL(12,2) DEFAULT 0,
  CONSTRAINT fk_ventas_tienda FOREIGN KEY (tienda_id) REFERENCES tiendas(id),
  CONSTRAINT fk_ventas_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  CONSTRAINT fk_ventas_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id)
);

CREATE TABLE IF NOT EXISTS items_venta (
  id INT AUTO_INCREMENT PRIMARY KEY,
  venta_id INT,
  producto_id INT,
  cantidad INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_itemsventa_venta FOREIGN KEY (venta_id) REFERENCES ventas(id) ON DELETE CASCADE,
  CONSTRAINT fk_itemsventa_producto FOREIGN KEY (producto_id) REFERENCES productos(id)
);

CREATE TABLE IF NOT EXISTS promociones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT,
  descripcion TEXT,
  descuento_percent DECIMAL(5,2) CHECK (descuento_percent >= 0 AND descuento_percent <= 100),
  fecha_inicio DATE,
  fecha_fin DATE,
  CONSTRAINT fk_promociones_producto FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- 2) Datos: categorías, proveedores, tiendas
INSERT INTO categorias(nombre, descripcion) VALUES
('Lácteos','Productos lácteos y derivados'),
('Bebidas','Bebidas frías y calientes'),
('Abarrotes','Alimentos envasados'),
('Limpieza','Productos de limpieza'),
('Carnes','Carnes y embutidos');

INSERT INTO proveedores(nombre, telefono, email, ciudad) VALUES
('Distribuciones Norte','555-001','norte@sup.com','Ciudad A'),
('Alimentos SA','555-002','ventas@alimentos.com','Ciudad B'),
('Bebidas Global','555-003','info@bebidas.com','Ciudad C');

INSERT INTO tiendas(nombre, ubicacion) VALUES
('Central','Av. Principal 100'),
('Sucursal Oeste','Calle Secundaria 45');

INSERT INTO empleados(tienda_id, nombre, rol) VALUES
(1,'Ana Perez','Gerente'),
(1,'Carlos Ruiz','Cajero'),
(2,'María Gómez','Encargada');

-- 3) Productos (más de 10)
INSERT INTO productos(sku, nombre, categoria_id, proveedor_id, precio, costo, unidad, punto_reorden) VALUES
('LT-001','Leche Entera 1L',1,1,1.20,0.80,'unidad',20),
('LT-002','Yogurt Natural 500g',1,1,1.50,0.90,'unidad',15),
('BB-001','Coca-Cola 2L',2,3,2.00,1.10,'unidad',25),
('BB-002','Jugo Naranja 1L',2,3,1.80,1.00,'unidad',20),
('AB-001','Arroz 1kg',3,2,1.10,0.60,'bolsa',30),
('AB-002','Azúcar 1kg',3,2,0.90,0.50,'bolsa',25),
('LP-001','Detergente 1L',4,1,3.50,2.00,'unidad',10),
('CN-001','Pechuga de Pollo 1kg',5,2,4.50,3.00,'kg',8),
('AB-003','Aceite 1L',3,2,2.50,1.50,'unidad',12),
('BB-003','Agua Mineral 600ml',2,3,0.70,0.30,'unidad',40),
('LT-003','Queso Mozzarella 250g',1,1,2.20,1.30,'unidad',12),
('SN-001','Galletas Saladas 200g',3,2,1.20,0.70,'unidad',18),
('BB-004','Café Molido 250g',2,2,3.80,2.20,'unidad',10),
('LP-002','Limpiador Multiuso 500ml',4,1,2.80,1.60,'unidad',10),
('CN-002','Jamón Cocido 250g',5,2,2.00,1.20,'unidad',10);

-- 4) Inventario (por tienda)
INSERT INTO inventario(producto_id, tienda_id, cantidad) VALUES
(1,1,50),(2,1,30),(3,1,80),(4,1,40),(5,1,100),
(6,1,60),(7,1,20),(8,1,15),(9,1,35),(10,1,120),
(11,1,18),(12,1,25),(13,1,22),(14,1,12),(15,1,28),
(1,2,30),(3,2,40),(5,2,60),(10,2,70),(11,2,10);

-- 5) Clientes (más de 10)
INSERT INTO clientes(nombre, email, telefono) VALUES
('Luis Mora','luis.mora@mail.com','600-111'),
('Sofía León','sofia.leon@mail.com','600-112'),
('Pedro Ruiz','pedro.ruiz@mail.com','600-113'),
('Carla Díaz','carla.diaz@mail.com','600-114'),
('Diego Torres','diego.torres@mail.com','600-115'),
('Laura Vega','laura.vega@mail.com','600-116'),
('Marta Soto','marta.soto@mail.com','600-117'),
('Jorge Peña','jorge.pena@mail.com','600-118'),
('Ana Castillo','ana.castillo@mail.com','600-119'),
('Raúl Ortega','raul.ortega@mail.com','600-120'),
('Eva Ruiz','eva.ruiz@mail.com','600-121'),
('Óscar Blanco','oscar.blanco@mail.com','600-122');

-- 6) Pedidos de compra y recepciones (MySQL INTERVAL)
INSERT INTO ordenes_compra(proveedor_id, creado_en, recibido_en, estado) VALUES
(2, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 18 DAY), 'received'),
(3, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 9 DAY), 'received');

INSERT INTO items_compra(orden_compra_id, producto_id, cantidad, costo) VALUES
(1,5,200,0.55),(1,6,150,0.45),(1,9,100,1.40),
(2,3,200,1.05),(2,10,300,0.25);

-- 7) Ventas (varias ventas y items) - interval convertido a DATE_SUB
INSERT INTO ventas(tienda_id, cliente_id, empleado_id, creado_en, total) VALUES
(1,1,2, DATE_SUB(NOW(), INTERVAL 12 DAY), 0),
(1,2,2, DATE_SUB(NOW(), INTERVAL 10 DAY), 0),
(2,3,3, DATE_SUB(NOW(), INTERVAL 9 DAY), 0),
(1,4,2, DATE_SUB(NOW(), INTERVAL 4 DAY), 0),
(2,5,3, DATE_SUB(NOW(), INTERVAL 2 DAY), 0),
(1,6,2, DATE_SUB(NOW(), INTERVAL 1 DAY), 0);

-- items_venta and update totals
INSERT INTO items_venta(venta_id, producto_id, cantidad, precio_unitario) VALUES
(1,1,2,1.20),(1,3,1,2.00),(1,5,1,1.10),
(2,10,6,0.70),(2,11,1,2.20),
(3,3,3,2.00),(3,12,2,1.20),
(4,8,1,4.50),(4,14,1,2.80),
(5,9,2,2.50),(5,13,1,3.80),
(6,1,1,1.20),(6,15,2,2.00);


UPDATE ventas v
LEFT JOIN (
  SELECT venta_id, ROUND(SUM(cantidad * precio_unitario), 2) AS total
  FROM items_venta
  GROUP BY venta_id
) AS sub ON v.id = sub.venta_id
SET v.total = COALESCE(sub.total, 0)
WHERE v.id = sub.venta_id OR sub.venta_id IS NULL;


-- Promociones (usar DATE_ADD / DATE_SUB)
INSERT INTO promociones(producto_id, descripcion, descuento_percent, fecha_inicio, fecha_fin) VALUES
(3,'Oferta 10% Coca-Cola',10, DATE_SUB(CURDATE(), INTERVAL 5 DAY), DATE_ADD(CURDATE(), INTERVAL 5 DAY)),
(11,'Promo Queso 15%',15, DATE_SUB(CURDATE(), INTERVAL 10 DAY), DATE_ADD(CURDATE(), INTERVAL 20 DAY));

-- Índices (mejoras de rendimiento)
CREATE INDEX idx_productos_categoria ON productos(categoria_id);
CREATE INDEX idx_inventario_producto_tienda ON inventario(producto_id, tienda_id);
CREATE INDEX idx_ventas_creado_en ON ventas(creado_en);

COMMIT;