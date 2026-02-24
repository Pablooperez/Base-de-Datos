/* 1. Lista todos los productos con: código de barras, producto, cantidad y precio ordenados por nombre ascendente. */

use dbSupermercado;

select tblProductos.codigobarra, tblProductos.producto, tblProductos.cantidad, tblProductos.precio
from dbSupermercado.tblProductos
order by producto asc;

/* 2. Muestra únicamente los nombres de productos sin repetir. */

select distinct tblProductos.producto
from dbSupermercado.tblProductos;

/* 3. Selecciona todos los productos cuyo nombre contenga la palabra “pack”. */

select tblProductos.producto
from dbSupermercado.tblProductos
where producto like '%pack%';

/* 4. Selecciona todas las ofertas cuyo detalle contenga la palabra “gratis”. */

select tblOfertas.oferta, detalle
from dbSupermercado.tblOfertas
where detalle like '%gratis%';

/* 5. Muestra los productos cuyo precio sea NULL o 0. */

select tblProductos.producto
from dbSupermercado.tblProductos
where precio is null
   or precio = 0;

/* 6. Devuelve los productos cuyo IVA sea 10 o 21 y cuyo precio esté entre 5 y 50. */

select tblProductos.producto
from dbSupermercado.tblProductos
where iva in (10, 21)
  and precio between 5 and 50;

/* 7. Obtén las 5 primeras ofertas ordenadas por el campo valor de menor a mayor. */

select detalle, valor
from tblOfertas
order by valor asc
limit 5;

/* 8. Devuelve los productos cuyo nombre comience por “A” y terminen en “o”. */

select tblProductos.producto
from dbSupermercado.tblProductos
where producto like 'A%'
  and producto like '%o';

/* 9. Muestra los productos cuyo IVA NO sea ninguno de estos: 0, 4, 10. */

select tblProductos.producto
from dbSupermercado.tblProductos
where iva not in (0, 4, 10);

/* 10. Selecciona las 3 ofertas posteriores a la primera (igual que tu ejemplo de LIMIT 2,3 pero aplicado a valor). */

select tblOfertas.oferta
from dbSupermercado.tblOfertas
order by oferta
limit 1,3;

/* 11. Muestra los productos cuyo stock (cantidad) sea menor que 10 o mayor que 200. */

select tblProductos.producto
from dbSupermercado.tblProductos
where cantidad < 10
   or cantidad > 200;

/* 12. Selecciona los productos cuyo precio_venta esté entre 100 y 300 y no contengan “Samsung”. */

select tblProductos.producto
from dbSupermercado.tblProductos
where precio_venta between 100 and 300
  and producto not like '%Samsung%';

/* 13. listado con el codigo y el detalle de la oferta de las tres primeras en la base de datos ordenadas por el codigo de oferta */

SELECT tblofertas.idoferta, tblofertas.detalle
FROM dbsupermercado.tblofertas
GROUP BY idoferta
ORDER BY idoferta
limit 3;


/* 14. listado con el codigo y el detalle de la oferta a partir del tercero tres ofertas en la base de datos ordenadas por el codigo de oferta */

SELECT tblofertas.idoferta, tblofertas.detalle
FROM dbsupermercado.tblofertas
GROUP BY idoferta
ORDER BY idoferta
limit 2,3;

/* 15. Devuelve todas las ofertas con el valor distinto para el campo detalle */

SELECT DISTINCT tblofertas.detalle
FROM dbsupermercado.tblofertas;

/* 16. Devuelve las ofertas que no sean identicos para "valor" y "detalle" */

SELECT DISTINCTROW tblofertas.valor, tblofertas.detalle
FROM dbsupermercado.tblofertas;

/* 17. Seleccionar las ofertas cuyo nombre contiene la expresión "50% descuento" */

SELECT tblofertas.idoferta
from dbsupermercado.tblofertas
where detalle like lower('%50% descuento%');

/* 18. Seleccionar los productos que contengan "Philips" en la descripción del nombre (producto) y valor iva sea 10, 0 y 21 y el precio de venta sea cualquier valor entre 50 y 100 */

SELECT tblproductos.producto
from dbsupermercado.tblproductos
where producto like '%Philips%'
  and iva in (10, 0, 21)
  and precio_venta between 50 and 100;

/* 19. Seleccionar los productos que contengan "Philips" en la descripcion del nombre (producto) y no tengan precio aún asignado */

SELECT tblproductos.producto
from dbsupermercado.tblproductos
where producto like '%Philips%'
  and precio is null;

/* 20. Cantidad de productos Agrupados por marcas */

SELECT idmarca, count(tblproductos.producto)
from dbsupermercado.tblproductos
group by idmarca;

/* 21. Conocer el precio de venta más alto de cada marca */

select tblproductos.idmarca, max(tblproductos.precio_venta) as 'MAX_Precio'
from dbsupermercado.tblproductos
group by idmarca;

/* 22. El valor promedio del precio coste, Agrupados para las marcas 1,2 y 3 */

select idmarca, avg(tblproductos.precio) as 'Precio_Medio'
from dbsupermercado.tblproductos
where idmarca in (1, 2, 3)
group by idmarca;

/* 23. Seleccionar las marcas que tengan más de un producto con iva >= 10 */

select idmarca, count(*) as 'cantidad'
from dbsupermercado.tblproductos
where iva >= 10 /* Seleccionar los registros */
group by idmarca
having count(*) > 1;
/* El having es para filtrar el grupo*/

/* 24. Muestra el nombre y el precio de todos los productos ordenados por precio de mayor a menor. */

select tblProductos.producto, tblProductos.precio
from dbSupermercado.tblProductos
order by precio desc;

/* 25. Devuelve únicamente los nombres de productos sin repetir, ordenados alfabéticamente. */

select distinct tblProductos.producto
from dbSupermercado.tblProductos
order by producto asc;

/* 26. Selecciona todos los productos que contengan la palabra “Light” en su nombre. */

select tblProductos.producto
from dbSupermercado.tblProductos
where producto like '%Light%';

/* 27. Muestra el código de barras y el nombre de los productos cuyo precio sea mayor que 20€. */

select tblProductos.codigobarra, tblProductos.producto
from dbSupermercado.tblProductos
where precio > 20;

/* 28. Devuelve las ofertas cuyo detalle empiece por la palabra “Descuento”. */

select tblOfertas.oferta
from dbSupermercado.tblOfertas
where detalle like 'Descuento%';

/* 29. Muestra los productos cuyo nombre termine en la letra “a”. */

select tblProductos.producto
from dbSupermercado.tblProductos
where producto like '%a';

/* 30. Selecciona los productos con un IVA diferente de 0, 4 y 10. */

select producto, iva
from dbSupermercado.tblProductos
where iva not in (0, 4, 10);

/* 31. Devuelve los productos cuyo precio esté entre 1 y 5 euros. */

select tblProductos.producto, precio
from dbSupermercado.tblProductos
where precio between 1 and 5;

/* 32. Muestra los productos cuyo precio sea NULL o cuyo precio_venta sea 0. */

select tblProductos.producto, tblProductos.precio
from dbSupermercado.tblProductos
where precio is null
   or precio_venta = 0;

/* 33. Selecciona los 3 primeros productos ordenados por cantidad ascendente. */

select tblProductos.producto, cantidad
from dbSupermercado.tblProductos
order by cantidad asc
limit 3;

/* 34. Muestra cuántos productos tiene cada marca (idMarca). */

select idmarca, count(tblProductos.idmarca) as 'Cantidad_Productos'
from dbSupermercado.tblProductos
group by idmarca;

/* 35. Devuelve el precio máximo de venta agrupado por marca, ordenado del más alto al más bajo. */

select idmarca, max(tblProductos.precio_venta) as 'Precio_maximo'
from dbSupermercado.tblProductos
group by idmarca
order by Precio_maximo desc;


/* 36. Calcula el precio medio (precio) de los productos agrupados por IVA. */

select tblproductos.iva, avg(tblProductos.precio)
from dbSupermercado.tblProductos
group by iva;

/* 37. Selecciona las marcas (idMarca) que tengan más de 5 productos. */

select distinct idmarca, count(*) as NumProductos
from dbSupermercado.tblProductos
group by idmarca
having count(*) > 5;
/* 38. Devuelve el IVA y el número de productos cuyo precio sea mayor de 10€, agrupado por IVA. */

select tblProductos.iva, count(tblProductos.producto) as 'Numero_Productos'
from dbSupermercado.tblProductos
where precio > 10
group by tblProductos.iva;
/* 39. Muestra los IVA cuyo precio medio (precio) sea mayor de 20€. */

select tblProductos.iva, avg(tblProductos.precio)
from dbSupermercado.tblProductos
group by iva
having avg(tblProductos.precio) > 20;

/* 40. Agrupa los productos por IVA y muestra únicamente aquellos grupos cuyo precio máximo sea menor de 100. */

select iva, max(tblProductos.precio) as PreioMaximo
from dbSupermercado.tblProductos
group by iva
having PreioMaximo < 100;


/* 41. Muestra idMarca y la suma total de existencias (cantidad) por marca, ordenado de mayor a menor. */

select tblProductos.idmarca, sum(tblProductos.cantidad)
from dbSupermercado.tblProductos
group by idmarca
order by sum(tblProductos.cantidad) desc;

/* 42. Devuelve los grupos de IVA que tengan entre 2 y 4 productos. */

select tblProductos.iva
from dbSupermercado.tblProductos
group by iva
having COUNT(*) between 2 and 4;

/* 43. Devuelve las marcas cuyo producto más barato (MIN(precio)) cueste menos de 5€. */

select idmarca, min(tblProductos.precio)
from dbSupermercado.tblProductos
group by idmarca
having min(tblProductos.precio) < 5;

/* 44. Devuelve cuántos productos tienen un precio mayor de 20€, agrupados por marca. */

select idmarca, count(*) as cantidadproductos
from dbSupermercado.tblProductos
where precio > 20
group by idmarca;

/* 45. Muestra cada IVA y el precio máximo de precio_venta, ordenado del mayor al menor. */

select tblProductos.iva, max(tblProductos.precio_venta) as maxprecioventa
from dbSupermercado.tblProductos
group by iva
order by maxprecioventa desc;

/* 46. Calcula la suma total del precio (precio) de todos los productos agrupados por idMarca. */

select tblProductos.idmarca, sum(tblProductos.precio)
from dbSupermercado.tblProductos
group by idmarca;

/* 47. Selecciona los idMarca que tengan un precio medio superior a 15€. */

select tblProductos.idmarca, avg(tblProductos.precio) as preciomedio
from dbSupermercado.tblProductos
group by idmarca
having preciomedio > 15;

/* 48. Muestra el IVA y la cantidad total (SUM(cantidad)) por cada IVA. */

select tblProductos.iva, sum(tblProductos.cantidad)
from dbSupermercado.tblProductos
group by iva;

/* 49. Devuelve los productos agrupados por marca (idMarca), mostrando solo las marcas que tengan al menos 3 productos. */

select tblProductos.idmarca, count(*)
from dbSupermercado.tblProductos
group by idmarca
having count(*) >= 3;

/* 50. Muestra el idMarca cuyo precio más alto (precio) sea mayor que 50€. */

select tblProductos.idmarca, max(precio) as preciomaximo
from dbSupermercado.tblProductos
group by idmarca
having preciomaximo > 50;

/* 51. Selecciona los IVA cuyo número de productos (COUNT) sea mayor que 4. */

select tblProductos.iva, count(tblProductos.producto) as cantidadproductos
from dbSupermercado.tblProductos
group by iva
having cantidadproductos > 4;

/* 52. Agrupa los productos por idMarca y devuelve solo aquellos grupos donde la cantidad total supere 100 unidades. */

select tblProductos.idmarca, sum(cantidad) as cantidadtotal
from dbSupermercado.tblProductos
group by idmarca
having cantidadtotal > 100;

/* 53. Devuelve para cada IVA el precio_venta medio, pero solo muestra los IVA cuyo precio_venta medio sea inferior a 30€. */
select tblProductos.iva, avg(tblProductos.precio_venta) as precioventa
from dbSupermercado.tblProductos
group by iva
having precioventa < 30;

/* 54. Selecciona todos los datos del producto cuyo precio coste sea el más alto de la tabla. */

select max(tblProductos.precio)
into @preciomasalto
from dbSupermercado.tblProductos;

select @preciomasalto;

select tblProductos.producto, tblProductos.precio
from dbSupermercado.tblProductos
where precio = @preciomasalto;

/* 55. Devuelve el nombre de la categoría que tiene más productos. */

select max(tblProductos.cantidad)
into @mayorcantidad
from dbSupermercado.tblProductos;

select @mayorcantidad;

select @mayorcantidad, tblProductos.codigo
from dbSupermercado.tblProductos
where cantidad = @mayorcantidad;

/* 56. Muestra el producto cuyo precio de venta sea igual al precio de venta promedio de la tabla. */

select avg(tblProductos.precio_venta)
into @preciopromedio
from dbSupermercado.tblProductos;

select @preciopromedio;

select tblProductos.producto, tblProductos.precio_venta
from dbSupermercado.tblProductos
where precio_venta = @preciopromedio;

/* 57. Muestra la marca que tenga el mayor precio de venta promedio en sus productos. */

SELECT idmarca, AVG(precio_venta) AS promedio
FROM dbSupermercado.tblProductos
GROUP BY idmarca
HAVING AVG(precio_venta) =
       (SELECT MAX(promedio)
        FROM (SELECT AVG(precio_venta) AS promedio
              FROM dbSupermercado.tblProductos
              GROUP BY idmarca) AS tabla_promedios);

/* 58. Selecciona el proveedor que tiene el producto más barato. */

SELECT idproveedor, MAX(precio_venta) AS precio_max_proveedor
FROM dbSupermercado.tblProductos
GROUP BY idproveedor
HAVING MAX(precio_venta) =
       (SELECT MAX(max_pre)
        FROM (SELECT MAX(precio_venta) AS max_pre
              FROM dbSupermercado.tblProductos
              GROUP BY idproveedor) AS tabla_maximos);

/* 59. Listar todos los productos de las marcas que contienen “Samsung”, “Hisense” o “Xiaomi”. */

select tblMarcas.idmarca
into @idmarcaSamsung
from dbSupermercado.tblMarcas
where lower(marca) like lower('%samsung%');

select @idmarcaSamsung;

select tblMarcas.idmarca
into @idmarcaHisense
from dbSupermercado.tblMarcas
where lower(marca) like lower('%hisense%');

select @idmarcaHisense;

select tblMarcas.idmarca
into @idmarcaXiaomi
from dbSupermercado.tblMarcas
where lower(marca) like lower('%xiaomi%');

select @idmarcaXiaomi;

select tblProductos.idmarca, tblProductos.producto
from dbSupermercado.tblProductos
where idmarca in (@idmarcaXiaomi, @idmarcaHisense, @idmarcaSamsung);

/* 60. Mostrar todos los productos cuya categoría tenga más de 5 productos. */

SELECT *
FROM dbSupermercado.tblProductos
WHERE idcategoría IN (SELECT idcategoría
                      FROM dbSupermercado.tblProductos
                      GROUP BY idcategoría
                      HAVING COUNT(*) > 5);

/* 61. Muestra todos los productos de los proveedores cuya dirección contenga la palabra “Madrid”. */

select *
from dbSupermercado.tblProductos
where idproveedor in (select tblProveedores.idproveedor
                      from dbSupermercado.tblProveedores
                      where lower(direccion1) like lower('%madrid%')
                         or lower(direccion2) like lower('%madrid%'));

/* 62. Muestra el nombre del producto y su precio de todos los productos cuyo precio sea mayor que 15€, ordenados de menor a mayor precio.*/

select tblproductos.producto, tblproductos.precio_venta
from dbsupermercado.tblproductos
where precio_venta>15
order by precio_venta asc;

/* 63. Devuelve los nombres de productos que no tengan precio asignado.*/

select tblproductos.producto
from dbsupermercado.tblproductos
where precio is null;

/* 64. Lista el código de barras y el nombre de los productos cuyo nombre contenga la palabra "Pro". */

select tblproductos.codigobarra, tblproductos.producto
from dbsupermercado.tblproductos
where lower (producto) like ('%Pro%');

/* 65. Muestra los productos cuyo IVA sea 4 o 10 y cuyo stock sea superior a 50 unidades. */

select tblproductos.producto, tblproductos.iva
from dbsupermercado.tblproductos
where iva in (4,10)
    and cantidad >50;

/* 66. Selecciona los productos cuyo nombre empiece por "S". */

select tblproductos.producto
from dbsupermercado.tblproductos
where producto like ('S%');

/* 67. Selecciona los productos cuyo nombre empiece por "S" y no contenga la palabra "Light". */

select tblproductos.producto
from dbsupermercado.tblproductos
where producto like ('S%') and producto not like ('%Light%');

/* 68.  Devuelve los productos cuyo precio esté entre 10 y 30 euros y cuyo IVA no sea 0. */

select tblproductos.producto
from dbsupermercado.tblproductos
where precio_venta between 10 and 30
    and iva <> 0;

/* 69. Muestra las ofertas cuyo detalle termine en "gratis". */

select *
from dbsupermercado.tblofertas
where lower(detalle) like '%gratis';

/* 70. Devuelve los productos cuyo IVA no sea 0, 4 ni 10. */
select tblproductos.producto, tblproductos.iva
from dbsupermercado.tblproductos
where iva not in (0,4,10);

/* 71. Devuelve los 5 productos más baratos (nombre y precio). */

select tblproductos.producto,tblproductos.precio_venta
from dbsupermercado.tblproductos
order by precio_venta asc
limit 5;

/* 72. Muestra las 3 ofertas más caras, saltándote la primera. */

select tblproductos.producto, tblproductos.precio_venta
from dbsupermercado.tblproductos
order by precio_venta desc
limit 1,3;

/* 73. Selecciona los 3 productos con menor cantidad en stock. */

select tblproductos.producto, tblproductos.cantidad
from dbsupermercado.tblproductos
order by cantidad asc
limit 3;

/* 74. Muestra cuántos productos hay por cada IVA. */

select tblproductos.iva, count(tblproductos.producto)
from dbsupermercado.tblproductos
group by iva;

/* 75. Devuelve el precio medio de los productos agrupados por marca (idMarca). */

select tblproductos.idmarca, avg(tblproductos.precio_venta)
from dbsupermercado.tblproductos
group by idmarca;

/* 76. Muestra las marcas que tengan más de 3 productos. */

select tblproductos.idmarca, count(tblproductos.producto) as cantidadd
from dbsupermercado.tblproductos
group by idmarca
having cantidadd>3;

/* 77. Devuelve los IVA cuyo precio medio sea mayor que 25€. */

select tblproductos.iva, avg(tblproductos.precio_venta) as preciomedio
from dbsupermercado.tblproductos
group by iva
having preciomedio>25;

/* 78. Muestra las marcas cuyo producto más caro supere los 100€. */

select tblproductos.idmarca, max(precio_venta) as maxprecioventa
from dbsupermercado.tblproductos
group by idmarca
having maxprecioventa>100;


/* 79. Devuelve las marcas cuya cantidad total de productos supere las 100 unidades. */

select tblproductos.idmarca, sum(tblproductos.cantidad) as cantidadd
from dbsupermercado.tblproductos
group by idmarca
having cantidadd>100;

/* 80. Muestra el producto o productos con el precio más alto de toda la tabla. */

select tblproductos.producto, tblproductos.precio_venta
from dbsupermercado.tblproductos
where precio_venta=(
    select max(precio_venta)
    from dbsupermercado.tblproductos
    );

/* 81. Devuelve los productos que pertenecen a marcas que tengan más de 5 productos. */

select *
from dbsupermercado.tblproductos
where idmarca in(
    select idmarca
    from dbsupermercado.tblproductos
    group by idmarca
    having count(*) > 5
    );

/* 82. Muestra los productos cuyo precio sea superior al precio medio de la tabla. */

select *
from dbsupermercado.tblproductos
where precio_venta > (
    select avg(tblproductos.precio_venta)
    from dbsupermercado.tblproductos
    );

/* 83. Muestra el producto o productos cuyo precio de venta sea el más bajo de toda la tabla. */

select *
from dbsupermercado.tblproductos
where precio_venta = (
    select min(precio_venta)
    from dbsupermercado.tblproductos
    );

/* 84. Devuelve los productos cuyo precio de venta sea inferior al precio medio de los productos con IVA 21. */

select *
from dbsupermercado.tblproductos
where precio_venta <
      (select avg(tblproductos.precio_venta)
        from dbsupermercado.tblproductos
        where iva = 21
    );

/* 85. Muestra las marcas (idMarca) cuyo precio medio de venta sea superior al precio medio global de la tabla. */

select tblproductos.idmarca
from dbsupermercado.tblproductos
group by idmarca
having avg(precio_venta) > (
    select avg(tblproductos.precio_venta)
    from dbsupermercado.tblproductos
    );

/* 86. Devuelve los productos que pertenezcan a marcas cuyo producto más caro tenga un precio de venta superior a 200€. */

select *
from dbsupermercado.tblproductos
where idmarca in (
    select idmarca
    from dbsupermercado.tblproductos
    group by idmarca
    having max(precio_venta) > 200
    );

/* 87. Muestra los productos cuyo precio de venta sea igual al precio máximo de su propia marca. */

SELECT *
FROM dbSupermercado.tblProductos p
WHERE precio_venta = (
    SELECT MAX(precio_venta)
    FROM dbSupermercado.tblProductos
    WHERE idmarca = p.idmarca
);

/* 88. Devuelve las marcas que tengan al menos un producto con precio de venta superior al precio medio global. */

select idmarca
from dbsupermercado.tblproductos
group by idmarca
having max(precio_venta) > (
    select avg(precio_venta)
    from dbsupermercado.tblproductos
    );

/* 89. Muestra los productos cuyo precio de venta sea mayor que el precio medio de los productos de su misma marca. */

select *
from dbsupermercado.tblproductos p
where precio_venta > (
    select avg(precio_venta)
    from dbsupermercado.tblproductos
    where idmarca=p.idmarca
    );

/* 90. Devuelve las marcas cuyo precio mínimo sea superior al precio medio global. */

select tblproductos.idmarca
from dbsupermercado.tblproductos
group by idmarca
having min(precio_venta) > (
    select avg(precio_venta)
    from dbsupermercado.tblproductos
    );

/* 91. Muestra los productos que pertenezcan a marcas que tengan exactamente 3 productos. */

select *
from dbsupermercado.tblproductos
where idmarca in (
    select idmarca
    from dbsupermercado.tblproductos
    group by idmarca
    having count(*)=3
    );

/* 92. Devuelve los productos cuyo precio de venta sea mayor que el precio máximo de los productos con IVA 10. */

select *
from dbSupermercado.tblProductos
where precio_venta>(
    select max(precio_venta)
    from dbSupermercado.tblProductos
    where iva=10
    );

/* 93. Muestra los productos cuyo precio de venta sea menor que el precio mínimo de los productos con IVA 21. */

select *
from dbSupermercado.tblProductos
where precio_venta<(
    select min(tblProductos.precio_venta)
    from dbSupermercado.tblProductos
    where iva=21
    );

/* 94. Devuelve los productos cuyo precio de venta sea mayor que el precio máximo de los productos de su propia marca menos 10 unidades. */

select *
from dbSupermercado.tblProductos p
where precio_venta > (
    select max(precio_venta)-10
    from dbSupermercado.tblProductos
    where idmarca=p.idmarca
    );

/* 95. Muestra las marcas cuyo precio medio de venta sea menor que el precio medio global menos 5€. */

select tblProductos.idmarca
from dbSupermercado.tblProductos
group by idmarca
having avg(precio_venta) < (
    select avg(precio_venta)-5
    from dbSupermercado.tblProductos
    );

/* 96. Devuelve los productos cuyo precio de venta sea superior al precio promedio de los productos de su misma categoría (idcategoría). */

select *
from dbSupermercado.tblProductos p
where precio_venta > (
    select avg(precio_venta)
    from dbSupermercado.tblProductos tP
    where idcategoría=p.idcategoría
    );

/* 97. Muestra las marcas cuyo producto más barato sea mayor que el precio medio de todos los productos de IVA 10. */

select idmarca
from dbSupermercado.tblProductos
group by idmarca
having min(precio_venta) > (
    select avg(precio_venta)
    from dbSupermercado.tblProductos
    where iva=10
    );

/* 98. Devuelve los productos cuyo precio de venta sea mayor que el promedio de su marca, pero menor que el precio máximo de la marca. */

select *
from dbSupermercado.tblProductos p
where precio_venta > (
    select avg(precio_venta)
    from dbSupermercado.tblProductos
    where idmarca=p.idmarca)
and precio_venta < (
    select max(precio_venta)
    from dbSupermercado.tblProductos
    where idmarca=p.idmarca
    );

/* 99. Muestra las marcas que tengan más de 2 productos cuyo precio de venta supere el precio medio global. */

select tblProductos.idmarca
from dbSupermercado.tblProductos
where precio_venta > (
    select avg(precio_venta)
    from dbSupermercado.tblProductos
    )
group by idmarca
having count(*) > 2;

/* 100. Devuelve los productos cuyo precio de venta esté entre el precio mínimo y máximo de su propia marca. */

select *
from dbSupermercado.tblProductos p
where precio_venta between (
    select min(precio_venta)
    from dbSupermercado.tblProductos
    where idmarca=p.idmarca
    ) and (
    select max(precio_venta)
    from dbSupermercado.tblProductos
    where idmarca=p.idmarca
);

/* 101. Muestra las marcas cuyo precio máximo de venta sea mayor que el precio máximo global menos 50€. */

select tblProductos.idmarca
from dbSupermercado.tblProductos
group by idmarca
having max(precio_venta) > (
    select max(precio_venta) -50
    from dbSupermercado.tblProductos
);

/* 102. Devuelve los productos cuyo precio de venta sea mayor que la suma del precio mínimo y máximo de su marca dividido entre 2 (precio medio de la marca). */

select *
from dbSupermercado.tblProductos p
where precio_venta > (
    select (min(precio_venta)+max(precio_venta))/2
    from dbSupermercado.tblProductos
    where idmarca=p.idmarca
);











