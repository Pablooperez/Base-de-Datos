
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

CALL dbSupermercado.pListarProductosCategoria('carnes');

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

/* Crear una categoría */

drop procedure if exists dbsupermercado.pCrearCategoria;
delimiter $$
create procedure dbsupermercado.pCrearCategoria(vCategoria varchar(50))
begin
    declare vIdCategoria int;
    declare vResultado int;
    set vResultado=1;
    set vIdCategoria=fBuscarCategoria(vCategoria);
    if(vIdCategoria=0) then
        insert into dbsupermercado.tblcategorias(categoria)
            values (UPPER(vCategoria));
        select idcategoria
        from tblcategorias
        where categoria like vCategoria;
    else select vResultado;
    end if;
end $$
delimiter ;

call dbSupermercado.pCrearCategoria('tyyy');

/* Crear una marca */

drop procedure if exists dbSupermercado.pCrearMarca;
delimiter $$
create procedure dbsupermercado.pCrearMarca(vMarca varchar(50))
begin
    declare vIdMarca int;
    declare vResultado int;
    set vResultado=1;
    set vIdMarca=fBuscarMarca(vMarca);
    if(vIdMarca=0) then
        insert into dbsupermercado.tblmarcas(marca)
            values (UPPER(vMarca));
        select tblmarcas.idmarca
        from tblmarcas
        where marca like vMarca;
    else select vResultado;
    end if;
end $$
delimiter ;

call dbSupermercado.pCrearMarca('ww');

/* Crear una tienda */

drop procedure if exists dbsupermercado.pCrearTienda;
delimiter $$
create procedure dbsupermercado.pCrearTienda( in vIdSuper tinyint, in vCodigo int, in vIDLocalidad varchar(5), in vHAper int, in vHCierre int, in vHorario varchar(50), in vGerente int, in vDireccion varchar(100), in vTel varchar(20), in vEmail varchar(50), out vResultado int )
begin
    if not exists(select tblsupermercados.idsuper from tblsupermercados where vIdSuper=idsuper) then
        set vResultado=-1;
    elseif exists(select tbltiendas.codigo from tbltiendas where vCodigo=codigo) then
        set vResultado=0;
    else
        insert into dbsupermercado.tbltiendas(idsuper,codigo,idlocalidad,hora_apertura, hora_cierre, horario, gerente, direccion, telefono, email)
        values (vIdSuper,vCodigo,vIDLocalidad,vHAper,vHCierre, vHorario, vGerente, vDireccion, vTel, vEmail);
    set vResultado=last_insert_id();
    end if;
end $$
delimiter ;

call dbSupermercado.pCrearTienda(7,1,'03001',8,22,'Lunes-Domingo',0,'masquefa','987789876','palelele@rer.com',@vResultado);
select @vResultado;

/* PROCEDIMIENTOS ALMACENADOS */

/* 12:
Enunciado: Crea un procedimiento que muestre todos los productos registrados en la base de datos.

Resultado: Lista completa de productos */

drop procedure if exists dbsupermercado.pListadoCompletoProductos;
delimiter $$
create procedure dbsupermercado.pListadoCompletoProductos()
begin
    select *
    from dbsupermercado.tblproductos;
end $$
delimiter ;

call dbsupermercado.pListadoCompletoProductos();

/* 13:
Enunciado: Desarrolla un procedimiento que muestre los detalles de un producto específico por su código de barra.

Resultado: Detalles completos del producto */

drop procedure if exists dbsupermercado.pDetallesProductoID;
delimiter $$
create procedure dbsupermercado.pDetallesProductoID(vID int)
begin
    select *
    from dbsupermercado.tblproductos
    where codigobarra=vID;
end $$

call dbsupermercado.pDetallesProductoID(1);

/* 14:
Enunciado: Implementa un procedimiento que cuente el total de productos registrados y devuelva el resultado.

Resultado: Número total de productos en el inventario */

drop procedure if exists dbsupermercado.pTotalInventario;
delimiter $$
create procedure dbsupermercado.pTotalInventario()
begin
    select count(*)
    from dbsupermercado.tblproductos;
end $$

call dbsupermercado.pTotalInventario();

/* 15:
Enunciado: Crea un procedimiento que liste todos los productos de una categoría específica.

Resultado: Lista de productos de la categoría especificada */

drop procedure if exists dbsupermercado.pProductosCategoria;
delimiter $$
create procedure dbsupermercado.pProductosCategoria(vCategoria varchar(50))
begin
    declare vIdCategoria int;
    set vIdCategoria=fBuscarCategoria(vCategoria);
    if(vIdCategoria!=0) then
        select *
        from dbsupermercado.tblproductos
        where idcategoría=vIdCategoria;
    else select 'No existe' as Resultado;
    end if ;
end $$

call dbSupermercado.pProductosCategoria('bebidas');

/* 16:
Enunciado: Desarrolla un procedimiento que genere un informe estadístico del inventario incluyendo cantidad, precios mínimos/máximos y valor total.

Resultado: Estadísticas completas del inventario */

drop procedure if exists dbsupermercado.pInventarioSelecto;
delimiter $$
create procedure dbsupermercado.pInventarioSelecto()
begin
    select tblproductos.producto as producto, tblproductos.cantidad as cantidad, tblproductos.precio_oferta as precio_minimo, tblproductos.precio_venta as precio_maximo, sum(cantidad*precio_venta) as valor_total
    from dbsupermercado.tblproductos
    order by producto
    group by producto;
end $$

call dbSupermercado.pInventarioSelecto();

/* CREAR UN PROCEDIMIENTO PARA REGISTRAR UN NUEVO PRODUCTO CON TODAS SUS CARACTERISTICAS Y VALIDACIONES */

drop procedure if exists dbsupermercado.pRegistrarProducto;
delimiter $$
create procedure dbsupermercado.pRegistrarProducto(in v_codigo int, in v_producto varchar(100), in v_informacion varchar(150), in v_origen varchar(100), in v_cantidad int, in v_cantalert float, in v_precio float, in v_precio_oferta float, in v_precio_venta float, in v_iva tinyint, in v_contenido float, in v_peso float, in v_vencimiento varchar(10), in v_fila tinyint, in v_pasillo tinyint, in v_estanteria tinyint, in v_nevera tinyint, in v_medida varchar(50), in v_idcategoria tinyint, in v_idmarca tinyint, in iv_idoferta tinyint, in v_idproveedor tinyint, in v_idalmacen tinyint, in v_idtienda tinyint, in v_idsuper tinyint, out v_resultado int)
begin
    if(fBuscarProductoCod(v_codigo)=0
           and fProveedorId(v_idproveedor)=v_idproveedor
           and fBuscarProductoNom(v_producto)=0
           and fBuscarProductoInf(v_informacion)=0
           and fBuscarTipoMedida(v_medida)!=0
           and fBuscarMarca(v_idmarca)!=0
           and

end $$


