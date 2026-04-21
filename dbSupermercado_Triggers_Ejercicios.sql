DROP TABLE IF EXISTS dbsupermercado.tbl_auditoria_precios;
CREATE TABLE dbsupermercado.tbl_auditoria_precios
(
    id_auditoria    INT AUTO_INCREMENT PRIMARY KEY,
    idcodigo        INT                 NOT NULL,
    precio_anterior DECIMAL(10, 2)      NOT NULL,
    precio_nuevo    DECIMAL(10, 2)      NOT NULL,
    fecha_modificacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    usuario         VARCHAR(50),
    FOREIGN KEY     (idcodigo) REFERENCES dbsupermercado.tblproductos (codigobarra)
);

-- EJERCICIO FACIL 1: Registro de auditoria para cambios de precios
-- ENUNCIADO: Crear un trigger que registre en una tabla de auditoria cada vez que se modifique
-- el precio de un producto. La tabla debe guardar: código del producto, precio antiguo,
-- precio nuevo, fecha de modificación y usuario que realizó el cambio.

-- Solución:
drop trigger if exists dbsupermercado.trAuditoria_precios;
delimiter $$
CREATE TRIGGER dbsupermercado.trAuditoria_precios
    AFTER
    UPDATE
    ON tblproductos
    FOR EACH ROW
    BEGIN
        declare v_idcodigo int;
        declare v_precio_anterior float;
        declare v_precio_nuevo float;
        set v_idcodigo=OLD.codigo;
        set v_precio_nuevo=NEW.precio;
        set v_precio_anterior=old.precio;

        if  old.precio != NEW.precio then
            insert into  tbl_auditoria_precios (idcodigo, precio_anterior, precio_nuevo, usuario)
            values (v_idcodigo, v_precio_anterior, v_precio_nuevo, current_user);
        end if;
    end $$
    delimiter ;

 -- Prueba del trigger
select * from tbl_auditoria_precios;

update tblproductos
set precio = 20
where codigo in (100001, 100002);

select * from tbl_auditoria_precios;

-- Ejercicio 2:
-- Enunciado: Crear una rutina que impida establecer cantidades negativas en el stock de productos. Si intenta poner un valor negativo, se establece a 0.
-- Analisis: Primero tenemos que ver sobre qué tabla estamos vigilando, y seguidamente sobre qué procesos tenemos que vigilar.
    -- Tabla a vigilar: tblproductos Procesos a vigilar: Update, Insert.
    -- Creamos set cantidad = new.tblproductos.cantidad
    -- Si cantidad < 0 entonces new.tbl.productos.cantidad = 0
    -- Si cantidad > 0 entonces new.tbl.productos.cantidad = cantidad
-- Algoritmo:

-- Ejercicio 3:
-- Enunciado: Crear una rutina que al insertar un empleado asigne automaticamente la fecha de alta.
-- Analisis: Primero tenemos que ver sobre qué tabla estamos vigilando, y seguidamente sobre qué procesos tenemos que vigilar.
    -- Tabla a vigilar: tblempleados Procesos a vigilar: Insert.
    -- Dado que dentro de tblempleados, no disponemos de una columna fecha_alta, debemos crearla.
    -- Cuando se realiza un Insert dentro de tblempleados, automaticamente en fecha_alta = current_date().
-- Algoritmo:

-- Ejercicio 4:
-- Enunciado: Crear una rutina automatizada que calcule automaticamente el precio de venta cuando se modifique el precio de coste o el IVA. Precio-Venta = (PrecioCoste+IVA)*1.30.
-- Analisis:
-- Algoritmo:



