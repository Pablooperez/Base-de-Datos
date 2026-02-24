
/* Comprobar si existe un producto */

use dbSupermercado;
DELIMITER //
DROP FUNCTION IF EXISTS fn_existe_producto;
drop function if exists fn_existe_producto;
CREATE FUNCTION if not exists fn_existe_producto(p_idproducto INT)
RETURNS TINYINT
DETERMINISTIC
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM dbSupermercado.tblProductos
    WHERE tblProductos.codigo = p_idproducto;

    IF v_count > 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END //

DELIMITER ;

select fn_existe_producto(420020);

/* Devuelve la cantidad actual de un producto. */
use dbSupermercado;
delimiter //
drop function if exists fn_stock;
create function dbSupermercado.fn_stock(vcodigo int)
returns int
deterministic
begin
    declare vstock int;
    select tblProductos.cantidad into vstock
    from dbSupermercado.tblProductos
    where codigo=vcodigo;
    return vstock;
end //
delimiter ;
select fn_stock(420020);

/* fn_hay_stock_suficiente
   Requisitos:
        Recibe:
        p_idproducto INT
        p_cantidad INT
    Devuelve:
        TINYINT
    Debe devolver:
        1 si el producto existe y tiene stock suficiente.
        0 si no existe o no hay suficiente stock. */

use dbSupermercado;
delimiter //
drop function if exists dbSupermercado.fn_hay_stock_suficiente;
create function dbSupermercado.fn_hay_stock_suficiente(v_idproducto int)
returns tinyint
deterministic
begin
    declare v_cantidadpro int;
    select tblProductos.cantidad into v_cantidadpro
    from dbSupermercado.tblProductos
    where codigo=v_idproducto;
    if v_cantidadpro > 0 then
        return 1;
    else return 0;
    end if;
end //

select fn_hay_stock_suficiente(4020);

/* Crear una función fn_precio_con_descuento que, dado un idproducto, devuelva el precio final aplicando la oferta asignada al producto, si la tiene. */

use dbSupermercado;
delimiter //
drop function if exists dbSupermercado.fn_precio_con_descuento;
create function dbSupermercado.fn_precio_con_descuento(v_idproducto int)
returns decimal(10,2)
deterministic
begin
    return (select tblProductos.precio_oferta
            from dbSupermercado.tblProductos
            where codigo=v_idproducto);
end //

select fn_precio_con_descuento(420020);

/* Crear una función fn_stock_total_categoria que reciba un idcategoria y devuelva la suma de todas las cantidades en stock de los productos de esa categoría. */

use dbSupermercado;
delimiter //
drop function if exists dbSupermercado.fn_stock_total_categoria;
create function dbSupermercado.fn_stock_total_categoria(v_idcategoria tinyint)
returns int
deterministic
begin
    return (select sum(tblProductos.cantidad)
            from dbSupermercado.tblProductos
            where idcategoría=v_idcategoria);
end //

select fn_stock_total_categoria(11);

/* Saber o buscar una tienda por la localidad y que me devuelva el ID de la tienda */
DROP FUNCTION IF EXISTS dbSupermercado.fBuscarTienda;
delimiter $$
create function dbSupermercado.fBuscarTienda(v_idlocalidad varchar(5))
returns tinyint
deterministic
begin
    return (select tblTiendas.idtienda
            from dbSupermercado.tblTiendas
            where idlocalidad=v_idlocalidad);
end $$

select fBuscarTienda(46001);

/* Saber si existe un proveedor poniendo el CIF */

drop function if exists dbSupermercado.fBuscarProveedor;
delimiter $$
create function dbSupermercado.fBuscarProveedor(v_cif varchar(9))
returns tinyint
deterministic
begin
    return (select tblProveedores.idproveedor
            from dbSupermercado.tblProveedores
            where cif=v_cif);
end $$

select fBuscarProveedor('A123456');