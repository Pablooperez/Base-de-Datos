
DROP PROCEDURE IF EXISTS dbsupermercado.pListadoProductos;
DELIMITER $$
CREATE DEFINER='root'@'localhost' PROCEDURE dbsupermercado.PlistadoProductos()
BEGIN
    select *
    FROM dbsupermercado.tblproductos;
END $$
DELIMITER ;

CALL dbsupermercado.plistadoProductos();

/* Saber el inventario de ventas de la base de datos. */

DROP PROCEDURE IF EXISTS dbsupermercado.pInventario;
DELIMITER $$
CREATE DEFINER='root'@'localhost' PROCEDURE dbsupermercado.PInventario()
BEGIN
    select sum(tblproductos.cantidad) as Inventario, round(tblproductos.cantidad*precio_venta) as Cantidad
    from dbsupermercado.tblproductos;
END $$
DELIMITER ;

CALL dbsupermercado.pInventario();

/* 1. Conocer los detalles de un producto pasandole el codigo que quiera.
   2. Conocer/listar los productos de una categoria determinada. Carnes.
   3. Dado el codigo de una categoria, dime que categoria es. */

DROP PROCEDURE IF EXISTS dbsupermercado.PDetallesProducto;
DELIMITER $$
CREATE DEFINER='root'@'localhost' PROCEDURE dbsupermercado.pDetallesProducto(IN id int)
BEGIN
    SELECT *
    FROM dbsupermercado.tblproductos
    WHERE codigobarra=id;
end $$
DELIMITER ;

CALL dbSupermercado.pDetallesProducto(1);

DROP PROCEDURE IF EXISTS dbsupermercado.pListarProductosCategoria;
DELIMITER $$
CREATE PROCEDURE dbsupermercado.plistarProductosCategoria(IN categoria varchar(50))
BEGIN
    SELECT *
    FROM dbsupermercado.tblproductos
    WHERE idcategoría=(
        select tblcategorias.idcategoria
        from dbsupermercado.tblcategorias
        where TRIM(tblcategorias.categoria)=TRIM(categoria)
        );
end $$
DELIMITER ;

CALL dbSupermercado.pListarProductosCategoria("carnes");

DROP PROCEDURE IF EXISTS dbsupermercado.pDimeCategoria;
DELIMITER $$
CREATE DEFINER='root'@'localhost' PROCEDURE dbsupermercado.PDimeCategoria(IN id int)
BEGIN
    SELECT categoria
    FROM dbsupermercado.tblcategorias
    WHERE idcategoria=id;
end $$
DELIMITER ;

CALL dbSupermercado.pDimeCategoria(10);

/* Informe estadístico con los siguientes datos Cantidad de productos-PrecioMax y PrecioMin-Inventario de ventas-Inventario de costes */

DROP PROCEDURE IF EXISTS dbsupermercado.pInforme;
DELIMITER $$
CREATE PROCEDURE dbsupermercado.PInforme(out cp int, out pmin float,out pmax float,out IVen float,out ICos float)
BEGIN
    SELECT count(*) into cp
    FROM dbsupermercado.tblproductos;
    SELECT min(tblproductos.precio_venta) into pmin
    FROM dbsupermercado.tblproductos;
    SELECT max(tblproductos.precio_venta) into pmax
    FROM dbsupermercado.tblproductos;
    SELECT sum(tblproductos.cantidad*precio_venta) into IVen
    FROM dbsupermercado.tblproductos;
    SELECT sum(tblproductos.cantidad*precio) into ICos
    FROM dbsupermercado.tblproductos;
end $$
DELIMITER ;

CALL dbSupermercado.PInforme(@cp,@pmin,@pmax,@IVen,@ICos);

select @cp as cantidad,@pmin as preciominimo,@pmax as preciomaximo,@IVen as inventarioventas,@ICos as inventariocostes;