use dbminisuper;
/*  1. listado de todos los productos que su precio sea mayor de 2 euros y ordenado por precio descendiente y que el nombre aparezca como producto.*/

SELECT nombre as producto, precio
FROM productos
WHERE (precio>2)
ORDER BY productos.precio DESC;

/*  2. Stock total por producto (agrupado por producto_id desde inventario) */

SELECT sum(cantidad) as stock_total
from dbminisuper.inventario
group by producto_id;

/*  2.1 Stock total de precio por producto (agrupado por categoria_id desde productos) */

SELECT sum(precio) as precio
from dbminisuper.productos
group by categoria_id

/*  3. Listar todos los productos de la categoria 5 que su descripción detalle que es de 1L, ordenado por el precio mayor a menor */

SELECT *
from dbminisuper.productos
where nombre like '%1L%' and categoria_id=5
order by precio desc;

/*  4. Ordenes de compra cuyo estado sea "pendientes" (más antiguas primero) */

select *
from dbminisuper.ordenes_compra
where estado = 'pendientes'
order by creado_en desc;

/*  5. Saber los datos de las tiendas que estén ubicadas en "calle" */

select *
from dbminisuper.tiendas
where ubicacion like '%calle%';

/*  6. Subir un 10% al precio de todos los productos cuyo proveedor sea Alimentos SA */

set @idproveedor = (select proveedores.id
                    from proveedores
                    where nombre = 'Alimentos SA');

select @idproveedor;

UPDATE productos
set precio = precio*1.10
where proveedor_id=(select proveedores.id
                    from proveedores
                    where nombre = 'Alimentos SA');

select *
from productos
where proveedor_id like '2';

/*  7. Empleados con la cantidad de números de ventas realizados y el total gastado (por empleado_id) */

select sum(ventas.id) as 'ventas_realizadas',sum(total) as 'ventas_totales'
from ventas
group by empleado_id;


/*  8. De la tabla "Items venta", conocer el precio promedio y cantidad total por cada producto_id */




