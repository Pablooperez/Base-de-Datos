
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

/* Saber si existe un proveedor conociendo el CIF */

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
select dbsupermercado.fProveedor('A1238856');

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

DROP PROCEDURE IF EXISTS dbsupermercado.pCrearCategoria;
DELIMITER $$
CREATE PROCEDURE dbsupermercado.pCrearCategoria()


/* Crear una marca */

DROP FUNCTION IF EXISTS dbsupermercado.fCrearMarca;
DELIMITER $$
CREATE FUNCTION dbsupermercado.fCrearMarca(vmarca varchar(50))
RETURNS varchar(50)
DETERMINISTIC
BEGIN
    if  () then
            INSERT INTO dbSupermercado.tblMarcas(marca)
            VALUES (upper(vmarca));
            RETURN vmarca;
     else return 0;
    end if;
end $$
DELIMITER ;
select dbsupermercado.fCrearMarca('IBERICOS');

/* Buscar marca */

DROP FUNCTION IF EXISTS dbsupermercado.fBuscarMarca;
DELIMITER $$
CREATE FUNCTION dbsupermercado.fBuscarMarca(vNombreMarca varchar(50))
returns varchar(50)
deterministic
begin
    RETURN ifnull(
            (select dbsupermercado.tblmarcas.marca
            from dbsupermercado.tblmarcas
            where tblmarcas.marca=vNombreMarca),0);

end $$

select dbsupermercado.fBuscarMarca('philips');

/* Registrar un producto en la base de datos conociendo el codigo, nombre del producto, el precio, la cantidad, la medida, categoría, marca, si está en oferta o no, el proveedor del producto, el almacen y la tienda. Una vez que se registre, me devuelva el codigo de barras generado. */

/* PRACTICA INNER JOIN */

/* 1 */
USE dbSupermercado;

SELECT
    t.idtienda AS Nombre_Tienda,
    l.localidad AS Localidad,
    CONCAT(e.nombre, ' ', e.apellidos) AS Gerente
FROM tblTiendas t
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
