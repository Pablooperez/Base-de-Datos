
/* qewrqwerwq */


/* Saber una tienda por la localidad, y si está que me devuelva el ID */
use dbsupermercado;
DROP FUNCTION IF EXISTS dbsupermercado.fBuscarTienda;
DELIMITER $$
CREATE FUNCTION dbsupermercado.fBuscarTienda(localidad varchar(5))
RETURNS tinyint
DETERMINISTIC
BEGIN
        DECLARE v_idtienda tinyint;
        select dbsupermercado.tbltiendas.idtienda into v_idtienda
        from dbsupermercado.tbltiendas
        where tbltiendas.idlocalidad=localidad;
    RETURN ifnull(v_idtienda,0);
end $$
DELIMITER ;
select dbsupermercado.fBuscarTienda(28051);


/* Saber el ID de una categoria pasandole el nombre de la Categoría */

DROP FUNCTION IF EXISTS dbsupermercado.fCategoria;
DELIMITER $$
CREATE FUNCTION dbsupermercado.fCategoria(vcategoria varchar(50))
RETURNS tinyint
DETERMINISTIC
BEGIN
    DECLARE v_idcategoria tinyint;
    select dbsupermercado.tblcategorias.idcategoria into v_idcategoria
    from dbsupermercado.tblcategorias
    where categoria=vcategoria;
    RETURN ifnull(v_idcategoria,0);
end $$
DELIMITER ;
select dbsupermercado.fCategoria('bebe');

/* Crear una categoría */

DROP FUNCTION IF EXISTS dbsupermercado.fCrearCategoria;
DELIMITER $$
CREATE FUNCTION dbsupermercado.fCrearCategoria(vcategoria varchar(50))
RETURNS int
DETERMINISTIC
BEGIN
    if  (dbsupermercado.fBuscarCategoria(vcategoria)=0) then
            INSERT INTO dbSupermercado.tblcategorias(categoria)
            VALUES (upper(vcategoria));
            return last_insert_id();

     else return 1;
    end if;
end $$
DELIMITER ;
select dbsupermercado.fCrearCategoria('2134233');


/* Crear una marca */

DROP FUNCTION IF EXISTS dbsupermercado.fCrearMarca;
DELIMITER $$
CREATE FUNCTION dbsupermercado.fCrearMarca(vmarca varchar(50))
RETURNS int
DETERMINISTIC
BEGIN
    if  (dbsupermercado.fBuscarMarca(vmarca)=0) then
            INSERT INTO dbSupermercado.tblMarcas(marca)
            VALUES (upper(vmarca));
            return last_insert_id();

     else return 1;
    end if;
end $$
DELIMITER ;
select dbsupermercado.fCrearMarca('2134233');

/* Registrar un producto en la base de datos conociendo el codigo, nombre del producto, el precio, la cantidad, la medida, categoría, marca, si está en oferta o no, el proveedor del producto, el almacen y la tienda. Una vez que se registre, me devuelva el codigo de barras generado. */
drop function if exists dbsupermercado.fRegistrarProducto;
delimiter $$
create function dbsupermercado.fRegistrarProducto(vCodigo int,vNombre varchar(100))




/* EJERCICIOS MD */

/* 1:
Enunciado: Crea una función que busque un producto por su código de barra y devuelva su ID. Si no existe, debe retornar 0. */

DROP FUNCTION IF EXISTS dbsupermercado.fBuscarProductoCB;
delimiter $$
create function dbsupermercado.fBuscarProductoCB(vCodigoBarras int)
returns int
deterministic
begin
    return ifnull(
           (select dbsupermercado.tblproductos.codigo
            from dbsupermercado.tblproductos
            where tblproductos.codigobarra=vCodigoBarras),0);

end $$

select dbsupermercado.fBuscarProductoCB(1123213);

/* 2:
Enunciado: Desarrolla una función que busque una localidad por su nombre y devuelva su ID (código postal). La búsqueda debe ser insensible a mayúsculas/minúsculas y espacios. */

drop function if exists dbsupermercado.fBuscarLocalidad;
delimiter $$
create function dbsupermercado.fBuscarLocalidad(vLocalidad varchar(100))
returns varchar(5)
deterministic
begin
    return ifnull(
           (select dbsupermercado.tbllocalidades.idlocalidad
            from dbsupermercado.tbllocalidades
            where tbllocalidades.localidad like lower(trim(vLocalidad))),0);

end $$

select dbsupermercado.fBuscarLocalidad('eeeee');

/* 3:
Enunciado: Implementa una función que busque una tienda por el ID de localidad y devuelva el ID de la tienda. */

drop function if exists dbsupermercado.fBuscarTiendaLocalidad;
delimiter $$
create function dbsupermercado.fBuscarTiendaLocalidad(vIdLocalidad varchar(5))
returns int
deterministic
begin
    return ifnull(
            (select dbsupermercado.tbltiendas.idtienda
             from dbsupermercado.tbltiendas
             where tbltiendas.idlocalidad=vIdLocalidad),0);
end $$

select dbsupermercado.fBuscarTiendaLocalidad(28001);

/* 4:
Enunciado: Crea una función que busque un proveedor por su CIF y devuelva su ID. */
DROP FUNCTION IF EXISTS dbsupermercado.fProveedor;
DELIMITER $$
CREATE FUNCTION dbsupermercado.fProveedor(_cif varchar(9))
RETURNS tinyint
DETERMINISTIC
BEGIN
    RETURN ifnull(
            (select idproveedor
            from dbsupermercado.tblproveedores
            where tblproveedores.cif=_cif),0);
end $$
DELIMITER ;
select dbsupermercado.fProveedor('A123456');

/* 5:
Enunciado: Desarrolla una función que busque una categoría por su nombre y devuelva su ID. */

DROP FUNCTION IF EXISTS dbsupermercado.fBuscarCategoria;
DELIMITER $$
CREATE FUNCTION dbsupermercado.fBuscarCategoria(vNombreCategoria varchar(50))
returns int
deterministic
begin
    RETURN ifnull(
            (select dbsupermercado.tblcategorias.idcategoria
            from dbsupermercado.tblcategorias
            where tblcategorias.categoria like lower(trim(vNombreCategoria))),0);

end $$

select dbsupermercado.fBuscarCategoria('bebe');

/* 6:
Enunciado: Implementa una función que busque una marca por su nombre y devuelva su ID. */

DROP FUNCTION IF EXISTS dbsupermercado.fBuscarMarca;
DELIMITER $$
CREATE FUNCTION dbsupermercado.fBuscarMarca(vNombreMarca varchar(50))
returns int
deterministic
begin
    RETURN ifnull(
            (select dbsupermercado.tblmarcas.idmarca
            from dbsupermercado.tblmarcas
            where tblmarcas.marca like vNombreMarca),0);

end $$

select dbsupermercado.fBuscarMarca('lplplp');

/* 7:
Enunciado: Crea una función que busque un tipo de venta por su nombre y devuelva su ID. */

drop function if exists dbSupermercado.fBuscarTipoVenta;
delimiter $$
create function dbsupermercado.fBuscarTipoVenta(vTipoVenta varchar(50))
returns int
deterministic
begin
    return ifnull(
           (select dbsupermercado.tbltipoventas.idtipo
            from tbltipoventas
            where venta like lower(trim(vTipoVenta))),0);
end $$

select dbsupermercado.fBuscarTipoVenta('tienda');

/* 8:
Enunciado: Desarrolla una función que busque una medida por su nombre y devuelva su ID. */
drop function if exists dbSupermercado.fBuscarTipoMedida;
delimiter $$
create function dbsupermercado.fBuscarTipoMedida(vTipoMedida varchar(50))
returns int
deterministic
begin
    return ifnull(
           (select dbsupermercado.tblmedidas.idmedida
            from tblmedidas
            where medidas like lower(trim(vTipoMedida))),0);
end $$

select dbsupermercado.fBuscarTipoMedida('KILOS');

/* 9:
Enunciado: Implementa una función que busque una oferta por su nombre y devuelva su ID. */

drop function if exists dbSupermercado.fBuscarTipoOferta;
delimiter $$
create function dbsupermercado.fBuscarTipoOferta(vTipoOferta varchar(100))
returns int
deterministic
begin
    return ifnull(
           (select dbsupermercado.tblofertas.idoferta
            from tblofertas
            where oferta like lower(trim(vTipoOferta))),0);
end $$

select dbsupermercado.fBuscarTipoOferta('3x2');

/* 10:
Enunciado: Crea una función que busque si una oferta está asignada a una categoría específica. Utiliza un parámetro compuesto con separador '|'. */
drop function if exists dbsupermercado.fBuscarOfertaACategoria;
delimiter $$
create function dbsupermercado.fBuscarOfertaACategoria(vOferta varchar(100),vCategoria varchar(50))
returns int
deterministic
begin
    if  (fBuscarTipoOferta(vOferta!=0) and fBuscarCategoria(vCategoria)!=0) then
        
    end if $$
end $$



















/* PRACTICA INNER JOIN */

/* 1 */
USE dbSupermercado;

SELECT
    t.idtienda AS Nombre_Tienda,
    l.localidad AS Localidad,
    CONCAT(e.nombre, ' ', e.apellidos) AS Gerente
FROM dbsupermercado.tbltiendas t
INNER JOIN tblLocalidades l ON t.idlocalidad = l.idlocalidad
INNER JOIN tblEmpleados e ON t.gerente = e.idempleado;

/* Enunciado:
Muestra el nombre del producto, la categoría a la que pertenece y su precio de oferta. Solo muestra los productos que tengan una categoría asignada.

Tablas que usarás: tblProductos y tblCategorias.

Haz que el resultado muestre columnas:

Producto → nombre del producto

Categoría → nombre de la categoría

Precio_Oferta → precio de oferta del producto */

use dbsupermercado;

SELECT p.producto as Producto, c.categoria as Categoria, p.precio_oferta
from tblproductos p
inner join tblcategorias c on p.idcategoría = c.idcategoria;


select tblproductos.producto,tblcategorias.categoria, tblproductos.precio_oferta
from tblproductos,
     tblcategorias
where tblproductos.idcategoría=tblcategorias.idcategoria;

/* Muestra el nombre de cada empleado junto con el nombre de la tienda en la que trabaja y su puesto. Solo deben aparecer los empleados que estén asignados a una tienda.*/

use dbsupermercado;

select tblempleados.nombre, tbllocalidades.localidad
from tblempleados,
     tbllocalidades,
     tbltiendas
where tbllocalidades.idlocalidad=tbltiendas.idlocalidad;
