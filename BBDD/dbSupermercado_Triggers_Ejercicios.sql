use dbsupermercado;
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
where codigo in (100001);

select * from tbl_auditoria_precios;

-- Ejercicio 2:
-- Enunciado: Crear una rutina que impida establecer cantidades negativas en el stock de productos. Si intenta poner un valor negativo, se establece a 0.
-- Analisis: Primero tenemos que ver sobre qué tabla estamos vigilando, y seguidamente sobre qué procesos tenemos que vigilar.
    -- Tabla a vigilar: tblproductos Procesos a vigilar: Update, Insert.
    -- Creamos set cantidad = new.tblproductos.cantidad
    -- Si cantidad < 0 entonces new.tbl.productos.cantidad = 0
    -- Si cantidad > 0 entonces new.tbl.productos.cantidad = cantidad
-- Algoritmo:

-- Update

drop trigger if exists dbsupermercado.trCantNega;
delimiter $$
CREATE TRIGGER dbsupermercado.trCantNega
    BEFORE
    UPDATE
    on tblproductos
    FOR EACH ROW
    BEGIN
        if NEW.cantidad <= 0 then
                set NEW.cantidad = 0;
        else
                set new.cantidad = NEW.cantidad;
        end if;
    end $$
    delimiter ;

-- Insert

drop trigger if exists dbsupermercado.trCantNega1;
delimiter $$
CREATE TRIGGER dbsupermercado.trCantNega1
    BEFORE
    INSERT
    on tblproductos
    FOR EACH ROW
    BEGIN
        if NEW.cantidad <= 0 then
                set NEW.cantidad = 0;
        else
                set new.cantidad = NEW.cantidad;
        end if;
    end $$
    delimiter ;

select tblproductos.cantidad from dbsupermercado.tblproductos;

update tblproductos
set cantidad = -1
where codigobarra = 1;

select tblproductos.cantidad from dbsupermercado.tblproductos;

-- Ahora en rutina.

drop function if exists dbSupermercado.fDevolucionCantidad;
delimiter $$
create function dbsupermercado.fDevolucionCantidad(vCant int)
returns int
deterministic
begin
if  vCant >= 0 then
    return vCant;
else
    return 0;
end if;
end $$
delimiter ;

select dbsupermercado.fDevolucionCantidad(-1);



-- Ejercicio 3:
-- Enunciado: Crear una rutina que al insertar un empleado asigne automaticamente la fecha de alta.
-- Analisis: Primero tenemos que ver sobre qué tabla estamos vigilando, y seguidamente sobre qué procesos tenemos que vigilar.
    -- Tabla a vigilar: tblempleados Procesos a vigilar: Insert.
    -- Dado que dentro de tblempleados, no disponemos de una columna fecha_alta, debemos crearla. Alter table.
    -- Cuando se realiza un Insert dentro de tblempleados, automaticamente en fecha_alta = current_date().
-- Algoritmo:
ALTER TABLE tblempleados add column fecha_alta date;
-- Cuando se añaden nuevos usuarios:
drop trigger if exists dbsupermercado.trFechaAltaAuto1;
delimiter $$
create trigger dbsupermercado.trFechaAltaAuto1
    before
    insert
    on tblempleados
    for each row
    BEGIN
        declare fecha date;
        set fecha = current_date;

        set new.fecha_alta = fecha;

    end $$
    delimiter ;

insert into dbsupermercado.tblempleados(dni, nombre, apellidos, nacimiento, sexo, direccion1, direccion2, idlocalidad, telefono, email)
VALUES ('1234123', 'Empleado 1', 'Apellido 1', 111970, 1, 'Ave Gran via 1', 'Oviedo Ciudad', 46001,
        600600600,'info@gmail.com');

select * from dbsupermercado.tblempleados;
-- Cuando se modifican usuarios
drop trigger if exists dbsupermercado.trFechaAltaAuto2;
delimiter $$
create trigger dbsupermercado.trFechaAltaAuto2
    before
    update
    on tblempleados
    for each row
    BEGIN
        declare fecha date;
        set fecha = current_date;

        set new.fecha_alta = fecha;

    end $$
    delimiter ;

update dbsupermercado.tblempleados
set nombre = 'Pablo'
where nombre = 'Juan';





-- Ejercicio 4:
-- Enunciado: Crear una rutina automatizada que calcule automaticamente el precio de venta cuando se modifique el precio de coste o el IVA. Precio-Venta = (PrecioCoste+IVA)*1.30.
-- Analisis: Primero vamos a crear una función polimórfica.
-- Algoritmo:

drop function if exists dbsupermercado.fpModificarPrecio;
delimiter $$
create function dbsupermercado.fpModificarPrecio(v_codigobarra int, v_precio float, v_tipo int)
returns int
deterministic
begin

    if  v_tipo = 1 then
        update dbsupermercado.tblproductos
        set tblproductos.precio_venta = (v_precio * (1 + (tblproductos.iva/100)))
        where codigobarra = v_codigobarra;
        return tblproductos.precio_venta;
    end if;

    if  v_tipo = 2 then
        update dbsupermercado.tblproductos
        set tblproductos.precio_venta = (tblproductos.precio * (1 + (v_precio/100)))
        where codigobarra = v_codigobarra;
        return tblproductos.precio_venta;
    end if;
end $$
delimiter ;

drop trigger if exists dbsupermercado.tModificarPrecio;
delimiter $$
create trigger dbsupermercado.tModificarPrecio
    before
    update
    on tblproductos
    for each row
    begin
        if  (new.precio!=OLD.precio) then
            call dbsupermercado.fpModificarPrecio(old.codigobarra,new.precio,1);
        end if;
        if  (new.iva!=old.iva) then
            call dbsupermercado.fpModificarPrecio(OLD.codigobarra, new.iva, 2);
        end if ;
end $$
delimiter ;

update tblproductos
set precio = 50
where codigo in (100001);




