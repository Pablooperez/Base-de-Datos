/* 1. Un listado de todos los productos: codigo barra, codigo productos, producto, cantidad y precio.*/

use dbsupermercado;

SELECT tblproductos.codigobarra, tblproductos.codigo, tblproductos.producto, tblproductos.cantidad, tblproductos.precio
FROM dbsupermercado.tblproductos;

/* listado con el codigo y el detalle de la oferta de las tres primeras en la base de datos ordenadas por el codigo de oferta */

SELECT tblofertas.idoferta, tblofertas.detalle
FROM dbsupermercado.tblofertas
GROUP BY idoferta
ORDER BY idoferta limit 3;


/* listado con el codigo y el detalle de la oferta a partir del tercero tres ofertas en la base de datos ordenadas por el codigo de oferta */

SELECT tblofertas.idoferta, tblofertas.detalle
FROM dbsupermercado.tblofertas
GROUP BY idoferta
ORDER BY idoferta limit 2,3;

/* 1. Devuelve todas las ofertas con el valor distinto para el campo detalle */

SELECT DISTINCT tblofertas.detalle
FROM dbsupermercado.tblofertas;

/* 2. Devuelve las ofertas que no sean identicos para "valor" y "detalle" */

SELECT DISTINCTROW tblofertas.valor, tblofertas.detalle
FROM dbsupermercado.tblofertas;

/* 3. Seleccionar las ofertas cuyo nombre contiene la expresión "50% descuento" */

SELECT tblofertas.idoferta
from dbsupermercado.tblofertas
where detalle like lower('%50% descuento%');

/*  4. Seleccionar los productos que contengan "Philips" en la descripción del nombre (producto) y valor iva sea 10, 0 y 21 y el precio de venta sea cualquier valor entre 50 y 100 */

SELECT tblproductos.producto
from dbsupermercado.tblproductos
where producto like '%Philips%' and iva in (10,0,21) and precio_venta between 50 and 100;

/* 5. Seleccionar los productos que contengan "Philips" en la descripcion del nombre (producto) y no tengan precio aún asignado */

SELECT tblproductos.producto
from dbsupermercado.tblproductos
where producto like '%Philips%' and precio is null;

/* 6. Cantidad de productos Agrupados por marcas */

SELECT idmarca, count(tblproductos.producto)
from dbsupermercado.tblproductos
group by idmarca;

/* 7. Conocer el precio de venta más alto de cada marca */

select tblproductos.idmarca, max(tblproductos.precio_venta) as 'MAX_Precio'
from dbsupermercado.tblproductos
group by idmarca;

/* 8. El valor promedio del precio coste, Agrupados para las marcas 1,2 y 3 */

select idmarca, avg(tblproductos.precio) as 'Precio_Medio'
from dbsupermercado.tblproductos
where idmarca in (1,2,3)
group by idmarca;

/* 9. Seleccionar las marcas que tengan más de un producto con iva >= 10 */

select idmarca,count(*) as 'cantidad'
from dbsupermercado.tblproductos
where iva >= 10 /* Seleccionar los registros */
group by idmarca
having count(*)>1; /* El having es para filtrar el grupo*/

/* 10. Conocer todos los datos del producto de mayor precio de venta */

select *
from dbsupermercado.tblproductos
where precio_venta=(select max(precio_venta)
                    from dbsupermercado.tblproductos);

/* 11. Listado de todos los productos de la marca Philips */

select tblproductos.producto
from dbsupermercado.tblproductos
where idmarca=(select tblmarcas.idmarca
                from dbsupermercado.tblmarcas
                where lower(marca) like '%philips%');

/* 12. Listar todos los productos de la marca Philips y ufesa del proveedor lidl */

/* Mediante variables */
select idmarca into @idmarca1
from dbsupermercado.tblmarcas
where lower(marca) like lower(trim('%Philips'));

select @idmarca1;

select idmarca into @idmarca2
from dbsupermercado.tblmarcas
where lower(marca) like lower(trim('%ufesa'));

select @idmarca2;

select *
from dbsupermercado.tblproductos
where idproveedor=(select idproveedor from dbsupermercado.tblproveedores
                    where lower(proveedor) like lower('%lidl%'))
and (idmarca in (select idmarca
                 from dbsupermercado.tblmarcas
                 where tblmarcas.idmarca in (@idmarca1, @idmarca2)));

/* Forma correcta pero menos óptima */
SELECT idmarca,idproveedor, producto
FROM dbSupermercado.tblProductos
WHERE tblProductos.idmarca IN (SELECT idmarca
					FROM dbSupermercado.tblMarcas
					WHERE lower(marca) LIKE lower('%Philips%') or lower(marca) like lower('%ufesa%')
and idproveedor=(select idproveedor
                from dbsupermercado.tblproveedores
                where lower(proveedor) like lower('%lidl%')));



/* 13. Seleccionar los productos cuya marca no sea Philips */

select idmarca
from dbsupermercado.tblmarcas
where lower(marca) like lower(trim('%Philips%'));

select @idmarcanophilips;

select *
from dbsupermercado.tblproductos
where idmarca <> (select idmarca
                  from dbsupermercado.tblmarcas
                  where lower(marca) like lower(trim('%Philips%')));

/* 14. Seleccionar la categoria que tiene el producto con el precio de venta mayor */

select max(precio_venta) into @precioventamayor
from dbsupermercado.tblproductos;

select @precioventamayor;

select tblproductos.idcategoría into @categoriamayor
from dbsupermercado.tblproductos
where precio_venta=@precioventamayor;

select @categoriamayor;

select tblproductos.idcategoría, producto, precio_venta
from dbsupermercado.tblproductos
where precio_venta=@precioventamayor;

select categoria
from tblcategorias
where idcategoria=@categoriamayor;








